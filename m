Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A383CC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xRO-0008G2-NI; Tue, 08 Sep 2026 11:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3xRL-0007wW-V5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:08:52 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3xRJ-0007sD-Eh
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:08:51 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8588583a7c3so46395247b3.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 08:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788880128; cv=none;
 d=google.com; s=arc-20260327;
 b=Sfs7+KqmVWAZf/5ZjIdPXGEZYIfbcUzc9I9GaLr7NXwEUlJVUsrg19CU1Z7mqT9V49
 JZQy5cxvS7njDe1Z+ax/sJje3yOZxKieQYp5Gyr0nioUBlCbC2YEweJ9+YxzcBIHmblp
 PjhOmhtBMFo2Gd5H9RY1/CebyfLBJvv2XmnBNbZzrbnYZtiHe6spGo3fT3clr9dasuDI
 sd07N63Cq3CBayoas+e/33+GdRmd7zTMMSCibJyACTSEVypR/HG6kX3tSSBU3jMiC4tj
 ZOwH4ahDitL9tfUT32/e9lSxGM0vQWPAqNf/DdljZkkkhbLUs2QQwvvYJct5wLuzSlCO
 Nxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lG5Ki8PQpUUwKhw1Y8knnrwmS/fSxYm+38NAUe54Z7Y=;
 fh=ieLaz7e/0RpAqfE5XLQ1RcBHWjTUv1z6arE2SouQh04=;
 b=qdKMO5x9LThE5r9P0KmD5qhMqeBahOL8X8HHIgv85RH5CPh3cwHHaQdBJhcIonF+JK
 Vy0tJVtSISLCAwICWnC3qkxTafhX2h/SCsGhWe5VMW0TRCh3uG0xuX3vQ8uZRmbyq+Jh
 ii0Cas+ftnto6RkekLgeYDvJbcb0TxWmhlyFUJelMBeHs8GpkCG5J+sNfDE/jJ/P3Gp1
 QkzDwp3RRvxufdjG04/qjmLwRt3rM1NFRk38/1gmzqXC8SDm14DbioyCeHuJB87G3JMU
 0+/yeqgMKbyI3dtlBQGJWIV0B0A9rxis2CdtDv14X+Rdp/7zYrBzyZZE/ohskRdzEWlf
 7hSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788880128; x=1789484928; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lG5Ki8PQpUUwKhw1Y8knnrwmS/fSxYm+38NAUe54Z7Y=;
 b=WVlJHDgjuh+tfHLCSyKF1oIXCF7X3lNVguaUgNRFFvw22xxl7MW0y/p+FCBLOdM4eZ
 T4y6TI2xx/yzg7+0Ao3HkSqLtHdPR72SY3bBFQzrTUEVdh2FHePUWgJURGG0nxq4D+xm
 UHmuAFNagP7um9sjfMaWrK10Bvahg1wOzRNR5w8PiOWSrIHOIezqIYRIRI59ZYYHSLI1
 pjNKF8M8gmPZZeDmZQCII3kyey4y7Ck233LXrg93TpGT2R+excTst/HW0i+qlHc4EYVQ
 6bvZ6NoziDg0GWy1bl0oOTHntisCbWRBxJuFu3jAYvPv9y3jrsB91xS36fcY60Lq5ZWW
 d2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788880128; x=1789484928;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lG5Ki8PQpUUwKhw1Y8knnrwmS/fSxYm+38NAUe54Z7Y=;
 b=lqIZrcFx5JO36kKkov91fZKTZIH1tdSpcQ9AcucAdoLezBdquiRHgMlJ6Xk1Mi+Xmb
 aV6+IwzxwFbEmLWU29WUcgt0t9jiqxZ+pkqBrmmV/xkQPjIBi4CUwQYavffrV1ynbr/O
 U/egDEG1XX/rtTttPywpOMxlUOsXcvWUFjQM8w0HFRyPzw8StOPtky7hoZUKtLlPtwMT
 6TSj5PnMKk9CHt/iOxE5Ljowm+S2M60U4sQkgJBGJOJeR28n3IA40bqXVAM8ys3YAzYA
 quwC2Ueq9839b/+nsTwsi1pIlIWoDTNLAYycZtu7HV5nIzeFk/syf6z+ljP98O3wL6+B
 j1Uw==
X-Gm-Message-State: AFuF++nQbpwQwRfbDZ50uJb3y8FJRZh5Zq5KmPLkZHcs/6UfWnZ3IPM9
 YEcu6yXuSQn4/Ra1rv19dzIE/V3H4NmwnkZbh3ZhKVReiNlau1hflUxLuxuW/jyeCH+aNRGoT+4
 ji9urRCD4jflsc13o9DXj7Bk6LyKgWrX301HW/5m+2w==
X-Gm-Gg: AYBFou1Pgpu8apgv8zU+V1EyHh73NWHhJWFENYmomxh44jbkLWWmsUkNxaODZeqnbMY
 NWYP/grblobCyJ4Iq2aRyyU6b1djY/CrtHGM3QJrGjXdROPKCq793N52DOLiwQJ0bfEhCftMfe4
 t1hlqYRUtNYWfAYJRLjbTGEOs3ND1VEwqQo9tjoQ59qFAEj+ZC/JBY4J1T220EBrVSPsJzTspW+
 s0mUTdjyU8f7E8atfFjOfpqSQIrUg3ZRdMecy3c0WQtLj3FhtHYBVGop24wJOoYL1ntvtjnGgSl
 A0GwhjcqZVqtaIh16yOJCwZiT7i01P7kZKf8tYDa7edpcuGuiCfJPqnK9EmazGmhNWS9UbTkarv
 Dp3oWV+ZPenhsuF2sEd/loKle0LG4/2lfzMmH1ng=
X-Received: by 2002:a05:690c:e649:10b0:873:5bb2:6c16 with SMTP id
 00721157ae682-8735bb26f7bmr54865947b3.64.1788880127668; Tue, 08 Sep 2026
 08:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260902122646.2848464-1-imammedo@redhat.com>
In-Reply-To: <20260902122646.2848464-1-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 16:08:35 +0100
X-Gm-Features: AcwNN1UpUaEkzGudHPz7lDbwxxrmgZ7BbVDcthWsvgSh0S9pz3fYemKVb_KKYyo
Message-ID: <CAFEAcA-AgMXT8LKWCH46FhqLPh1NNv84DoZz-16Ub92K_5-HjA@mail.gmail.com>
Subject: Re: [PATCH 0/6] sbsa-gwdt cleanup and fixes
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 2 Sept 2026 at 13:26, Igor Mammedov <imammedo@redhat.com> wrote:
>
>
> Series picks up dropped gwdt fixes from
>
>   [PATCH v3 00/17] Add watchdog support to arm/virt board
>   https://patchew.org/QEMU/20260624102830.1355552-1-imammedo@redhat.com/
>
> patches were basically rewritten to make changes simpler/easier to reson about.
>
> patch 6/6 is partial fix with open question:
>
> sbsa-gwdt currently mantains WVC in since VM start ticks, which works fine under
> TCG. However under KVM those system counter domains diverge and CNTPCT in guest
> starts to return host's value. As result WCV reads/writes got mixed up with
> QEMU still assuming VM timeframe while guest using host's one.
> Question is how should we fix it?

Presumably we should be dealing in deltas from the
QEMU_CLOCK_VIRTUAL value?

Anyway, for this series, since the only thing I wanted to change
was expanding a comment, I'll apply this to target-arm.next and
make that tweak there.

-- PMM

