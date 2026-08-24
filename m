Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B524AC5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyRt9-0002aY-3K; Mon, 24 Aug 2026 06:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRt7-0002aQ-Rd
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:26:45 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRt6-0001iQ-Ai
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:26:45 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66d06b5f023so1229454d50.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 03:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787567202; cv=none;
 d=google.com; s=arc-20260327;
 b=lm6yJzbM9kqjRP1U/0sBC2GG7cSJdltMo4PCjFO38aHI+TKv/IvgwfmvApAlsrtd8q
 QqSS3unV8z4ht3tLRrzjsZPS5KPyJgGwtesW2JI+TpO3Zjme2pKhmAB47Pkhw33XxaQM
 Z5SayY+++7uqm5fNqcVBbES5QaBa6L3GPiPikPXulZVft3dw5TKHlRtGDvahgoQReti/
 9vLqSM78CSggG3pD9apsbq4DW+F4u1fXvNGbXYFrE1uXX+JuhIg0kJdSw9RlHKGWbleR
 yd3STqvVL0eqAadBBbvlQiYGeWVFjXbP6Jr5CFTRuHF67aeCFu+8gkMnJfyDZ1l1vtLl
 GbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c/v3aBrd8S38Bcnwtdh2wQ0met9M5bH+aTIJmS3sE8I=;
 fh=B6STahklW9K39yksOpcsN4+yLgkd6tQAAsMtrDWs4x8=;
 b=TAzqeNll0saf8dEa+VU6bAk3WLnJBp8kVtq9NJxBJVQ483Zz5mxzTvhQ+mOl7m75Mu
 RwzLx1Ib6XP8xleraOPpsaHmzQqrhArAYuOMDMMiGL/yKCnqh3zMt5py4ctcABtr1WxY
 OwC7iZj2wG2+94vrmoLuW2ndNuPiQXCNxd05Z9LB7JQvNfIKsbMwel6WsobMpuNTVKW6
 ZeXwhPlnfEd7XvQTAjVC191f6OnIoLOOdcg3/QFPqUKO8RhJTRQD5JSdd50bQF2Nwta9
 vVJNhn98dPnSoBtgdMKd9BEBaQUWRMk4iFWuQ7hmdWJf3YFJFHkRFktS1tCPYXVsqAen
 K2Hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787567202; x=1788172002; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c/v3aBrd8S38Bcnwtdh2wQ0met9M5bH+aTIJmS3sE8I=;
 b=obTd3N+h3AiNujglF2ZOdCbQjaFBnPpHkWlnSYwCH8u/jc0x0oPq+qDZtm+vV2hSmq
 G9qX4/dqXG6L2V0Hbr/RYB2Ldj7Jt8y7VXdosQEwvWVRy/cyRNoicxfZ1q5FsUTBhKmU
 0IkOZSGQbNl2cPH2xvjTuA6TtRpfA67OjcERCI6tykuJCPR8q7TpuvDoY6/032qqEbmc
 BLwtEhCqXASnLta6vgxCy/8oQSYj37+i7q4TT5CRfUa6Zo5O3OKjbHW+nzHsSFuO2D7R
 gPIdrvLg9gzxN1xmPo9pdgfl5kf/4wk77AXJ187hOnpj0x2TIk/opAZ0BIC20fI29Izd
 luOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787567202; x=1788172002;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c/v3aBrd8S38Bcnwtdh2wQ0met9M5bH+aTIJmS3sE8I=;
 b=XxJPmn8gAwGp+UjfaaiIdFMdBHGxu4K336tJ4HgalfhekBJA3hzAqVckRhzm+JSKNG
 7+whOnYVZ9OrptADSIXPNs6LMSHzE0YlC1FwCZftzcLSWs8uyDwwDwhUCSoUlKfNEo8A
 eFz81NLEZM31WCJQwfguaD/1l/7RfL5f7kboNUTq9N5JCA1WDWv9/eFocCFLDFcw8ukc
 2WxF+wDVMf2ybyFusVJdAQjtK7gL/jy/c/Nxxuw1Kuv+20250Vp39wPIGwyIlVmkyOBy
 aMYY2a29o5c94Fw+GEyqyGcLLW3j3J97OdgKpslgpszUJF8ADhBw5NniBmGxhA5oIG2E
 e8pw==
X-Gm-Message-State: AFuF++ka/oFYgYpbapA3g0x5zO/EehC+rzcopU4DlY620bqGlKnwQCqL
 7PxTzjGJ/5fPiqE5R99lP75jzaNTqYwmEwrBL/vUA+vI29zqFID3jQsquM2NqlajdbMnQCNcLCB
 yUFUILJkPpMga7wZLuncS+qIHrmYZfNjNoX1u/5iiWw==
X-Gm-Gg: AR+sD115eU50+SOqz3GBfaEsuO7j9HNO64Waq0YURVQLrjGk+wC26A2tDlVfHApx9A6
 b1i5fPwQtiJi9jT6aJvzFs93PfCXgkyNdisFXZRNzfm/e4u5OBmNveEf8z6AJ1qHyyuZTICUlNj
 11uzm/5kkcuM2jSiS4lnvLfegaaahuLcxIMJ1SfXji3NtrilKI5ldCdMPvf1zVfzyp+cCg0n/eo
 m2faEWtVfIBXXxxwJU+83OyU52L7puxZZ0LBpSeewHuEm6L6nCESX3mcLTBw02FA2qH+lmkGo5/
 ys6KbjvKAbCrrXI6fIkS65LuS840PPFhCf3WwyAiRDvHg8xASdxuStXhkfScNc2Gxn0YteNHSRG
 QV7lRahnUy/3ESLA+XyTRr8zhn7pB
X-Received: by 2002:a05:690e:2282:b0:66c:e21d:9ac8 with SMTP id
 956f58d0204a3-66ce4ab0c6bmr6640958d50.28.1787567202444; Mon, 24 Aug 2026
 03:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260707110300.1918153-1-armbru@redhat.com>
 <20260707110300.1918153-36-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-36-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2026 11:26:31 +0100
X-Gm-Features: AcwNN1W-IGbpQiguKzhSaKnNrfqAn5YrL-o1okc6pHHaLVN-_Y9fgG6MbQyNLpY
Message-ID: <CAFEAcA-tUz_YGhvqU8-o-jw-jhR4MTMFDJ3S9rA2ZG-0GpLtVw@mail.gmail.com>
Subject: Re: [PULL 35/35] docs: mark '-mon' as deprecated in favour of -object
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Krempa <pkrempa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 7 Jul 2026 at 12:06, Markus Armbruster <armbru@redhat.com> wrote:
>
> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> The high level `-qmp` and `-monitor` options can remain as convenience
> wrappers, but the low level `-mon` is completed obsoleted by the new
> `-object` support with 'monitor-qmp' and 'monitor-hmp' types.
>

> @@ -3239,6 +3239,8 @@ void qemu_init(int argc, char **argv)
>                  default_monitor =3D 0;
>                  break;
>              case QEMU_OPTION_mon:
> +                warn_report_once("'-mon' is deprecated, use '-object' wi=
th "
> +                                 "'monitor-hmp' or 'monitor-qmp' types i=
nstead");

Can we be more precise in deprecation messages of this kind, please?
This warning is not enough for the user to be able to figure out how
to change their existing command line.

I had to look into deprecated.rst, check the git history to see which
commit added the deprecation, then find out how this commit was adjusting
the examples in the tree.

Notably, "-object monitor-hmp" appears to require an "id=3D" despite
nothing actually caring what that ID is, and the warning message
doesn't say how to determine whether your existing -mon option
should be changed to monitor-hmp or monitor-qmp. The deprecated.rst
docs do say that part, but don't mention the ID bit.

thanks
-- PMM

