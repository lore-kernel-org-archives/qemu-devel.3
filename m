Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F0DC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2R52-0003eA-QN; Fri, 04 Sep 2026 06:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2R51-0003dn-Kz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:23:31 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2R50-0001Du-5D
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:23:31 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66825847b2cso1114823d50.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 03:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788517409; cv=none;
 d=google.com; s=arc-20260327;
 b=A6pwaGHwMeHO43U89ZtPxi0tf1u8LKcAoUFzdV67FVg/BdAbOIIaPtzB3I1O/0cAim
 EssCvaUK62UVh8IbX+JHtOOTGQFNg5/PLTlKAYW+0FxHEyBzSVEOaSQ1VsCYV2c7mJ7F
 YhMDvHaINRa9Oya4v3HtyisdpawFQQH2plOdpjMK2NGkYBXR3iKhVa+Fven979+dnsjA
 s56D2Eku+i2n/yO0u1H6E7/htl/nBZQ/Chws3fGl0DUfzNPmEueU4FK4EkxGsNzkKLib
 wWyMYxqcW5ufCqM2lURtgwAGAbLL/jCiQyVCx9Z5c7dd4tTxWTODrlRgvVaNaHksnUUj
 +iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6MjX5N9trcgMS+EO9tmx9KtGHdfTm948PsZ9Pq/YGuU=;
 fh=YJYgcE9GCApM+XSQj404OqRt6uwrB/ULhwaSZWtMlw8=;
 b=l6177sbk3wArU38uQPYjFPeiGYtmLSaqfX0c1g85g+7psKdGgaaBxJFbJ7x4QjWjnA
 aoip0uBukBLVvnyE1GgeKnWei+1nIWmcGg+diLDUV4vWJCvMKTC6tyR1Onji3dIJK7ZD
 xnZ1JIkx4vLWBGypFcvUV0SXpHeg572f9qJ6qikgVFydDUzpKFpXEzEVI2YmV7vTfWSK
 L7bnukFA61LoyoJO/rE+wdu+/eLkVTAzjD7EcJn6J1Le1yA2TigQmwm1vZ191NoMUKOF
 t/fUL5b2l5fzNtq3aD8WsQuQ1V7m+ErWi3zLgZz9NpxUoOWv2lX09rqoehbr0CNxijdP
 rLGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788517409; x=1789122209; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6MjX5N9trcgMS+EO9tmx9KtGHdfTm948PsZ9Pq/YGuU=;
 b=EtsWQoZ0iEqFE0XOg0JUdSNIkInjfAAXf3W8p8oln6twEVUR6d6nMqsiU2kYMiI0Yx
 mmHodU0CVbo2yf3h72Uak0TD9u7HFMftmT+XNICZlkcabFrY5AVykMMYtT20Mpkp0LQ3
 cRGGJZzZALOo/1BhZqYmAgniTz6kgKCIc9/kRYX6dCNIEI7EAU2O9tNelBFEIHYKqmTv
 aWkKQTztVOKNdeANEu7uL9Ul8xGMnGUHBVnfFfDYIOWIet5owLpJ7UxEHKRAa0fwivou
 MVycSSUS6hGPwVHGeRBA8xn/i8ccThE62bstT9TCg/yngH/C6M9vQy1+9AdLBD9IvuMv
 yf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788517409; x=1789122209;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6MjX5N9trcgMS+EO9tmx9KtGHdfTm948PsZ9Pq/YGuU=;
 b=XBObhvv6OwLmf7Sh2qYFizrjg8Pl1HhtmemPINFZRp6a1sTVO0Mi0vcf7QcYd2oA6j
 JCf2nRaYHYAXQd1UHOo8dTZ69V9fJJs5d6cBAr/RwX1aS1ACdZxVUAdveuQq4Ht7m0Lr
 IHm2je75afQQyKTkrbUvRYBy1lh6s1nDiEVfeXP9f7vKwaf38rmKNQUYlzK9xX5DS5kO
 TzNFRHVrPMx46M6NKxNWSAPb8iATQ7w330IvbsYWnUYuibTvvFS9PS+yAMIDIfn2slQG
 DEFkkRC1GtReavbN1f5sQGBuQXAhG/+GkEEWZFylmxg11w+ewgiQJWg3LP4oxBS/Z3Wh
 6m/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzX0DgNPGqvHDK02+pQhDs7yXGAzcrTy4dcAOjDGWTTagZHwyRToZibyVrw2D8umrj8r4TFL8sbI9bR@nongnu.org
X-Gm-Message-State: AFuF++lj20DtlNVaKqvk8cSDkWIbPx55bc+HWmXwTg4qkHcd2A34ec+2
 xx9dS5kglcR5TJb/mcsyUMYYOHfwsqdpzBKuAR7FVTl2ld968RmSivc+m+QSG6sP4CVM1rkzTpE
 p8xnD3Nu3xkRyZCaWBB4gTEgHlRf+33WVDHOO00SwuQ==
X-Gm-Gg: AYBFou3l0TEpCMX/hC0IiGFBgp6kV6fPsjbvRDkZltVlilT/nZ82U8z9eqxklAXdKdQ
 FsXZxQuug6RXHTErNw0xZOp78ferv5anGUqY4wyChQ+UD3gKEjT+pe4SESQKJcmK0wF47KtywtQ
 Fx8qV/PuwLOyCJ359E6gz3nSVXaH8dwJe2y72STyMHOyDDGTryrwVbNcC4fGMF3rNrg3mrw08zw
 WfVMaB6InMwuCXoujGpsikh1aOVGz8e8e5ggdTIc60kTnVBFsyRvgqHlhYdr+umQVxn0C2Zx542
 eIQYnciAyRRFcoDiweEGdoQoa/PVDLDSJWBztXd0U4HhYpm9hkLogNPBf8NqBzzzlx37VosFIi8
 7aObPTKt+xVcXRZToAjjHfqCAuYqD
X-Received: by 2002:a05:690c:a785:b0:855:f387:98c0 with SMTP id
 00721157ae682-87127d27776mr24822697b3.29.1788517403794; Fri, 04 Sep 2026
 03:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
 <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
 <apqVhJrtMDECUb7I@redhat.com>
In-Reply-To: <apqVhJrtMDECUb7I@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2026 11:23:12 +0100
X-Gm-Features: AcwNN1XxniBYqO66vALzNTyn9nFiyFVQBGIf09PFXUslOmeDhJt8Pgy7f5dvl2A
Message-ID: <CAFEAcA8f15tCXn2Ut4ke2Q1PX6qWyAdMnxK5iK9pNXebw4Vncg@mail.gmail.com>
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: luoyonggang@gmail.com, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 4 Sept 2026 at 10:55, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Sep 04, 2026 at 10:13:04AM +0100, Peter Maydell wrote:
> >       That extends nicely to truly heterogenous machine names:
> > "-machine my-mixed-machine" wouldn't need the user to explicitly
> > give it a -target option or otherwise say that it includes aarch64
> > and microblaze CPUs. (We'd probably need to put something in to
> > prevent future machine name clashes across targets, so that the
> > only clashes are our existing legacy ones.)
>
> We don't have many examples of clashing machine names. Is there
> any beyond just the 'virt' boards ? Now that we know we want
> globally unique names, this feels easy enough to spot during
> review.

Yeah; but if it's easy to have it automatically detected during
"make check" then that's more reliable than catching it by
eye in code review, especially as most target-architecture
reviewers are probably not very familiar with machine names used
by other architectures.

> > This rests on the assumption that the only thing we need to
> > disambiguate is machine names, i.e. there aren't multiple
> > targets with user-facing (i.e. not easily renameable) device
> > names that are shared.
>
> IMHO it is best if our goal is to ensure type names are unique
> throughout the codebase, so hopefully we don't have clashing
> device names.

Yes, that's certainly what I'd hope we have; but if you told
me "actually it turns out that architectures foo and bar
both have a simple interrupt controller they named 'intc'"
I wouldn't be super surprised :-)

-- PMM

