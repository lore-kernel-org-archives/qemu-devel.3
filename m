Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2987CE8B362
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 21:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNwt-0002NG-RL; Tue, 03 Feb 2026 16:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vnNws-0002Mp-EI
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 16:28:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vnNwq-0002BM-OW
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 16:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770154115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GVR/lVuaiDdWUaS5EvTp5m5n5CK7Qp68tSRQ0eeJsw=;
 b=CV9wL4lihNY7F0ADW7gL0nvg/HGBuVomskObwzlu1tYBxPsWFSha90mvMtS17w/wq/MAoX
 AMgSufqzt86zcj12LlrnzXkiVmPa0BJ/Ds8IO+m2e/f3xwQsuz3t+Wwf1ik4bEgSKvUSwq
 Onj5Mu0trOaavTLpkc4BZ/D7aePzS04=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-JxbjY4qKPDCAiL5XUL09oA-1; Tue, 03 Feb 2026 16:28:34 -0500
X-MC-Unique: JxbjY4qKPDCAiL5XUL09oA-1
X-Mimecast-MFC-AGG-ID: JxbjY4qKPDCAiL5XUL09oA_1770154114
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6445cf02fcbso8440302d50.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 13:28:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770154114; cv=none;
 d=google.com; s=arc-20240605;
 b=LjUGG+KW9VM2ULfWNzABWRhjGpnCSyDHhcHhV48XBMVTpk8/RyYJ2OzoD5JwMb6VI6
 TRbrBfSie2LX2N5yYvI1zazchDoUkunuES+kB98jHo33NxTwRs7RNsJByCfSTikyPHdy
 Dp8trvxe8eN6pT3h0Glm5WjE2NFMMHSDAVQ5CAVI8pgiu7h4sALM+8pMo2bpdzRZFrss
 8e3m49iEehRqcaw5ij7pw8KXq4t0nK3aJ9sXhII0Fa74KQvJtTrNtFxYBE8AiY6NskMm
 ulPLjJsKWhIgkVJFqVbRv4bGNbF25PIXsKkB4SNsB5vyE+9/tN6AsSW5bmggT4lcTSwB
 CyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6GVR/lVuaiDdWUaS5EvTp5m5n5CK7Qp68tSRQ0eeJsw=;
 fh=v/epxvmm3ueG+eAhMMiJ15y4jUAJn4isqoG/QQ/Vzn0=;
 b=ZQXGQwq5BOZC8YPtoUIqoW55zVzTXJ7uaSMEE95WOnnTqKWhs6evuHLOXVHv+2S62s
 5UIKzack/WKtbIK0r8xetRA5GQH4sCl2HPMpxgo2z7JTaFxEYFmyE4Asxg+Wxf15x3NQ
 Nvl3zgfYboAV7CGYJUIYq//qv7YdjOrZGOFof782A1h1lHsSqFQZMgozGc8b7i5nkknF
 ZiKqs4OWCbCCvrJR8hC3GGTVpkMAsQkfOQTUwH5jFDlvg48snMKWtazoIZDZQ+p+DPPd
 Q/FmsVVQSxE0zgw+3cNl6YUS8J+y4xil7ye95d72dZ2KtSml29NDlF6obSM4rZxjBMm4
 Hi2Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770154114; x=1770758914; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GVR/lVuaiDdWUaS5EvTp5m5n5CK7Qp68tSRQ0eeJsw=;
 b=soCPYgnC7WMo0KW7qfqTMjAjzV6AUtJ40zFsMzWL5LhY8SmD+3lm0GWW9UqLw2Rnxl
 EL4tWM/Mp7OkWwgqDZdVI9Pzt5GdHHEslS68if1ao4CYBONrgW8NNlKyvRbe4CLnsg19
 D5YgCC0qKXBD6bUD/KHYWvwY99JajxnWEtW7T3JAgz5D5Vbdhf/rLQ0rtfb/rR9koHY4
 4lZyN8HUJFUfLP/huoasuGDUK4FyaGmkZhmZ9AbNlcze8BQrv/aVrsSgUqu7gf8C8Icp
 wDr4XoarK+Ta4TwgZHNMxoNIsPuLi0PZFgBA4yhEIS2fwop8Ru8fzS47ij0t/e+OfQ9W
 2SHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770154114; x=1770758914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6GVR/lVuaiDdWUaS5EvTp5m5n5CK7Qp68tSRQ0eeJsw=;
 b=tZupJvEOC8GsDQMOnn/v/c0+3KeHQysV/Uoymy9Mx4PL+jdwILvicOondFsN7tWXM6
 4TTnV8kk1YG6OwdTWcgctCChkzaslqBKQI3FhAGPuxhoG+fSngvSrgJGhuWC0nKahvZ9
 UUrhTP5G+waBNOOAjOsAtrlLdQFSLQqI5V2BLwrAPexe8iNgGWoTouFV1h+BJh+m1CMt
 UAFDrbVbRHXBuhdWN8xSqK14VEj0vsbghsfr9B+MPkMFD/YmWYvnVVnGheOb/LFLC/Pl
 ns6XSPExAwqO1LXOzY4/bgUVnEcb4ZHQVM8308+oEao2eQ+HdETdK352OpsmOmruMqDb
 wo0Q==
X-Gm-Message-State: AOJu0YwdQ03fnu3sB0abclRcmNBcEbC/XqgVAONeQrR2NtBLq/HsKj1s
 1biu4nfdo2twk16ITkfKHWzX20a1VbZTOPBY1B9DN5K2zldJ6qFWOO9SvOLKXAqgf+3LGZ+ZfGq
 US/oLHDEY0baeyHcg7eQKQn9PmP3xR2+0MpyKLqT6XnKNlUTMzjSe2V8yw3ivXz04POZOXJJiO0
 ThCTUDjonGhFt3XBrKfo/nXRV0MQLMnLI=
X-Gm-Gg: AZuq6aKRueooZGYTtUxF6ZoZdXfXFgXeFFV9sg/J0xXS8mk1ajJxyxJQIYBkY/8iJ7n
 51mmC/jvy6L4B1Re1ROjyKCF3O5Y1ZR+mkNmejN1CxhrPsCJxSYECNgVLMTuHA1EiLUHAkuDmnr
 6LfjYEbe4mrW5jUzUXqFM9qUB31/EgRVPkBFwerFemk6grNVn4KWgAktQgZGVz83RgKeKPfB+89
 1RKxzpPNw+mfqfZmne8ADxl2w==
X-Received: by 2002:a05:690c:7109:b0:789:2be7:ae80 with SMTP id
 00721157ae682-794fe7a1450mr20894697b3.54.1770154114148; 
 Tue, 03 Feb 2026 13:28:34 -0800 (PST)
X-Received: by 2002:a05:690c:7109:b0:789:2be7:ae80 with SMTP id
 00721157ae682-794fe7a1450mr20894207b3.54.1770154113751; Tue, 03 Feb 2026
 13:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-12-jsnow@redhat.com>
 <CABgObfYtKr88BvhPUL4KfX464u=T4d7BP70XRLMdn28sXSKU4g@mail.gmail.com>
In-Reply-To: <CABgObfYtKr88BvhPUL4KfX464u=T4d7BP70XRLMdn28sXSKU4g@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 3 Feb 2026 16:28:23 -0500
X-Gm-Features: AZwV_QjXkl2fM6uI3ATgeuFxuPYouxs3Phy2y2PjcK0w24GkuArbwIDC1HnuOG0
Message-ID: <CAFn=p-bq8siBh0f2bs=x6ZeHQn6y2_2RuwKVnVrH+CvOTe-4ig@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] meson, mkvenv: add qemu.git/python/qemu package
 to pythondeps.toml
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 3, 2026 at 4:08=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
>
>
> Il mar 3 feb 2026, 21:36 John Snow <jsnow@redhat.com> ha scritto:
>>
>> Add the local python package group into pythondeps.toml for the
>> tooling This makes qemu.qmp, qemu.machine and qemu.utils
>> packages unconditionally available for tests and scripts.
>
>
> Out of curiosity why not add setuptools and wheel to the group, at this p=
oint? Can be done on top of course.

Hm. If we're operating offline, it would only really serve as a
configure check. Online it might actually be a help. I'll do it as a
follow up, I just need to figure out which versions meet our needs and
do testing to choose the accepted values.

>
> Paolo
>
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  pythondeps.toml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/pythondeps.toml b/pythondeps.toml
>> index 743e2a8848c..89256132fee 100644
>> --- a/pythondeps.toml
>> +++ b/pythondeps.toml
>> @@ -37,6 +37,7 @@ sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", install=
ed =3D "1.2.2" }
>>  # system packages, or python packages we vendor.
>>  [tooling]
>>  "qemu.qmp" =3D { accepted =3D ">=3D0.0.5", installed =3D "0.0.5" }
>> +"qemu" =3D { path =3D "python/" }
>>
>>  # This test group is for functional tests, and can include dependencies
>>  # fetched from PyPI.
>> --
>> 2.52.0
>>


