Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211D5C83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 15:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZX4y-000887-3Z; Wed, 09 Jul 2025 11:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZX0z-0004Wg-25
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 11:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZX0w-00043k-PG
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 11:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752076037;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HP21awq+TtEC7SuksenmV4h/ixKkxjFyFP0jA7q713E=;
 b=HC7JnsBxxB4U/W9nX/Z7W1qFGZCfv9YM7TMKhqatzo/wC0BFteJn1h8D309O8X9hhyy2PY
 TcVf3w3uwR98wJZFvf4LL4lpuutCCQLuZtF9t9ndzhXwa8pBft29xmxo/is3nOJK9gx1YP
 Hg/lT/MCDwCyo89hrRmj+WGV5zNGl1M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-TzBw49fnMAqwv7aW5v4KKw-1; Wed, 09 Jul 2025 11:47:15 -0400
X-MC-Unique: TzBw49fnMAqwv7aW5v4KKw-1
X-Mimecast-MFC-AGG-ID: TzBw49fnMAqwv7aW5v4KKw_1752076034
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so46309785e9.2
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 08:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752076034; x=1752680834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HP21awq+TtEC7SuksenmV4h/ixKkxjFyFP0jA7q713E=;
 b=rLKR0AOFfSKtKnQoKBhtN3iM6sQ+X6WlusGbN1NlXwSY1iaCPK+gu6f7fq2WK9XT+v
 PFtiLVGYYk52FRlXl8/OgoF0JRnGcEfxgrWLqWV1CiJo2K0bamWoFO6hX/E/4dihjQa+
 dyxFOqYMUJkTHlGm27ld7mod2UcHAwLkXx7LC33pOmBv0galg2LZi+cc2kCs60OtoJ7Y
 T+5BXQhf7UPcpV0nrvOklYEGJF6UhJ8M4kZcSpjsDB2VXlq1kOcnhjXJTK2MrsDTC089
 s4mMZFu9VCF12qmfFlFmBop/f/cMEhlWrXDgwpLNjz5BTNujr0U86iOpr4VvRx5De+iw
 uVGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpiiXs0lGkUAgSS6bVqBPFkepPcJ2BSa938BYTle4u1spSTN2eoxfcnEpYW/qWpHPohjhD2du4ROhp@nongnu.org
X-Gm-Message-State: AOJu0Yx3aoZArc61MtsyvM6Tn/MWK/IboYisKsQcY0ag5WsEnG/E5WZB
 3da/4kknGvdYCMLs/pZvT2N+OIya5hoR/SwNes3naos8gj8w6hxNaSNUseGlXjABdcl/8vVAUZe
 aJdpM3nxKldjD/UFxkPd06ZrlIKJ3gOMz3W3nv/dCUDGsJVzp3J/Etylg
X-Gm-Gg: ASbGncsevgwJ23zYvWUEapQmCDWCG3APPjaNnTzZU0ZfQ1+Ru4Y8a7mxHo8KXBS1xDn
 yW52ZaLd8R0WLIrjLHK8orKwyglPPEyafl+DRaaY2R1sdKuNYsRnYHLyy7Z89IHKEBExKZSDSQi
 F6vG9VodVsuwHnhDplIWt8sQuOmG85k7XnsN4EVLf5pQLpDObyadq4QGbjMbp4UmOr20qXz/PjH
 1VdD3cujodgJbomYrtleQr/MMxgun42upi1B8hSoF+aDys8l6ZrjBTlt+2kXutBqM1hL38Hwwdh
 Clf2S/XJ2j2weILBwhti8j3V2FVBa243+FB7CBE4OfbLwf7WqcXmQAGdTjNptb22PiuIIQ==
X-Received: by 2002:a05:600c:1988:b0:450:cd25:e68f with SMTP id
 5b1f17b1804b1-454d5384f3dmr30767215e9.27.1752076034386; 
 Wed, 09 Jul 2025 08:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2bpU8X6ofz4fcR4oWNeGY+3x3WsQDXQ461cTPmfSbFX+gH5QJ9Cv+SA1s2NzEsq9vYAXJgw==
X-Received: by 2002:a05:600c:1988:b0:450:cd25:e68f with SMTP id
 5b1f17b1804b1-454d5384f3dmr30766835e9.27.1752076033934; 
 Wed, 09 Jul 2025 08:47:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cdb31d21sm51556175e9.1.2025.07.09.08.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 08:47:13 -0700 (PDT)
Message-ID: <13bc4f63-f6be-4746-852a-6ac96253d1da@redhat.com>
Date: Wed, 9 Jul 2025 17:47:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm/cpu: fix trailing ',' for SET_IDREG
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
 <20250704141927.38963-4-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250704141927.38963-4-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/4/25 4:19 PM, Cornelia Huck wrote:
> While a trailing comma is not broken for SET_IDREG invocations, it
> does look odd; use a semicolon instead.
>
> Fixes: f1fd81291c91 ("arm/cpu: Store aa64mmfr0-3 into the idregs array")
> Fixes: def3f1c1026a ("arm/cpu: Store aa64dfr0/1 into the idregs array")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  target/arm/tcg/cpu64.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 00e12ed44ae8..d2f743fb3913 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -352,7 +352,7 @@ static void aarch64_a76_initfn(Object *obj)
>      cpu->clidr = 0x82000023;
>      cpu->ctr = 0x8444C004;
>      cpu->dcz_blocksize = 4;
> -    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull),
> +    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull);
>      SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
>      SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
>      SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101122ull);
> @@ -426,8 +426,8 @@ static void aarch64_a64fx_initfn(Object *obj)
>      cpu->reset_sctlr = 0x30000180;
>      SET_IDREG(isar, ID_AA64PFR0, 0x0000000101111111); /* No RAS Extensions */
>      SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000000);
> -    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408),
> -    SET_IDREG(isar, ID_AA64DFR1, 0x0000000000000000),
> +    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408);
> +    SET_IDREG(isar, ID_AA64DFR1, 0x0000000000000000);
>      SET_IDREG(isar, ID_AA64AFR0, 0x0000000000000000);
>      SET_IDREG(isar, ID_AA64AFR1, 0x0000000000000000);
>      SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000001122);
> @@ -678,13 +678,13 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
>      cpu->dcz_blocksize = 4;
>      SET_IDREG(isar, ID_AA64AFR0, 0x00000000);
>      SET_IDREG(isar, ID_AA64AFR1, 0x00000000);
> -    SET_IDREG(isar, ID_AA64DFR0, 0x000001f210305519ull),
> -    SET_IDREG(isar, ID_AA64DFR1, 0x00000000),
> +    SET_IDREG(isar, ID_AA64DFR0, 0x000001f210305519ull);
> +    SET_IDREG(isar, ID_AA64DFR1, 0x00000000);
>      SET_IDREG(isar, ID_AA64ISAR0, 0x1011111110212120ull); /* with FEAT_RNG */
>      SET_IDREG(isar, ID_AA64ISAR1, 0x0011000001211032ull);
>      SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101125ull);
> -    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull),
> -    SET_IDREG(isar, ID_AA64MMFR2, 0x0220011102101011ull),
> +    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
> +    SET_IDREG(isar, ID_AA64MMFR2, 0x0220011102101011ull);
>      SET_IDREG(isar, ID_AA64PFR0, 0x1101110120111112ull); /* GIC filled in later */
>      SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
>      SET_IDREG(isar, ID_AFR0, 0x00000000);


