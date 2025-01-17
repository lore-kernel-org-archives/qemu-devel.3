Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D14EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjOH-0006P9-AA; Fri, 17 Jan 2025 05:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYjOF-0006OC-Ce
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:15:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYjOD-0002Hr-MD
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737108943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rf/dwWEh9N5dRnVbhZAlKcF59bupXvDai4d0/kk6ee8=;
 b=Yqlhjh4s8N0Y6+KTDq9oh7gkjMeJB7VvzMLcR+L2YRFRbkraYUZ1AgKap85KglARuTle8f
 zCD9Q0Qab8RGespc12d3F9+sjb8RCPbRVZP53uvvelxO97cwJiyhPTPhwbCAxxpI+4syU2
 wGRHykhHB4STjxN5gVboGTyjmZBg6TM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-yCIdjGZHNeKeY5ezDT9tCA-1; Fri, 17 Jan 2025 05:15:42 -0500
X-MC-Unique: yCIdjGZHNeKeY5ezDT9tCA-1
X-Mimecast-MFC-AGG-ID: yCIdjGZHNeKeY5ezDT9tCA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so9750715e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 02:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737108941; x=1737713741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rf/dwWEh9N5dRnVbhZAlKcF59bupXvDai4d0/kk6ee8=;
 b=JSFfboj3bn+g0iETvo3ap4UMjNZIsGWAZU2k1eKS6I3a96m7As1rI9OBIPWa/EqIaP
 knIegmVps6Q6iogpruSk3zbNQxVkf4qWJR6+PcYj3eTmwRdVszC5UyTNjIAVHJ9zsbx7
 GHp/D+a0HTzGfGxN1acS+qLLDtgR6gmbXhZXp6GvH8BNLSxDlry14O9vUMxL91aSQFdK
 mULIw70tUwt3OYTxdsAVTTvUpV1YTbz/eOokv9EXedrKN+OChfc7Pr8ruU3ZNcDVufF+
 oPk3f1KDw69lPaWIrSszINPxvvT1eN2w6hkHnaoTc4eiZGOLKAEWNiGrJIg1ozGJncoE
 rhnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtZDfVxWQvUpdPmU+gqRI65qGrXxPyIcKGBu+KdCDZMLUVhrhx65sYfxLqbIfAz9zL6dkfs0IceKsO@nongnu.org
X-Gm-Message-State: AOJu0YzAY83kXIIUzvfDy2/4Z9kCh0d0vY3mgkPs8dH55GQ+dsD4SBhC
 SistTABM99IzDf3gnsjG8Y0ClBXTjcdYS4JQ+T2DGoJUG2WJ7HWsMwyzXaD9NzP5qIxYrK8HZc9
 zdtZEn2mL24xOu70OtQd048AiySsSIRZSkvkCuRgJoeKJRQ1x6pStlg2Ysr9ir7GuECeDqwtlPP
 Ba7+qiOoZp68NeXBUQJLLD38MS5sA=
X-Gm-Gg: ASbGncskHPPj3WB0ZPdcYzn1fNt9v4YaoOht6147PlVVZOZdzDGpw8azy4Y06oze+/3
 4U3xosegarVGkI5+I4xeRKiTq6sAUk9L0T5hwh/Y=
X-Received: by 2002:adf:f1cc:0:b0:38b:ed88:f045 with SMTP id
 ffacd0b85a97d-38bf566fb1bmr1636101f8f.33.1737108940934; 
 Fri, 17 Jan 2025 02:15:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFfN4qkuFaGI6ruWNDms5fpkiAkzYj5cts9GQ3U/ld64iK3BAhLmtufYDzagn1kigquPlNxu1rJ/LQP0QqWX4=
X-Received: by 2002:adf:f1cc:0:b0:38b:ed88:f045 with SMTP id
 ffacd0b85a97d-38bf566fb1bmr1636078f8f.33.1737108940583; Fri, 17 Jan 2025
 02:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-10-zhao1.liu@intel.com>
 <1da970e8-1708-48ef-87c4-1099d23e8909@redhat.com> <Z4oxlydZIK/f/aNC@intel.com>
In-Reply-To: <Z4oxlydZIK/f/aNC@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Jan 2025 11:15:27 +0100
X-Gm-Features: AbW1kvYwh5EnV3-4UzXKu7DL7k7YTgb-rqadUh6ZWRK06h7_iM0h_Qljj727zUY
Message-ID: <CABgObfY4dLcti4QkPdRB1bwNHzioRm7tFt9isc5Pn4HGRVoqbQ@mail.gmail.com>
Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 17, 2025 at 11:13=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:>
> Unfortunately, this way doesn't work either, if we disable both
> CONFIG_HPET and CONFIG_X_HPET_RUST.
>
> This is because I integrate hpet_fw_cfg into hpet lib which is compiled
> under CONFIG_X_HPET_RUST along with other HPET parts.
>
> The place broken is when hpet_fw_cfg is written into machine's fw_cfg (in
> hw/i386/fw_cfg.c).
>
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index 162785019b7a..3635b83620da 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -147,7 +147,14 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
>  #endif
>      fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
>
> -    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_fw_cfg, sizeof(hpet_fw_c=
fg));
> +#if defined(CONFIG_HPET) || defined(CONFIG_X_HPET_RUST)
> +    PCMachineState *pcms =3D (PCMachineState *)object_dynamic_cast(OBJEC=
T(ms),
> +                                                                 TYPE_PC=
_MACHINE);
> +    if (pcms && pcms->hpet_enabled) {
> +        fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_fw_cfg, sizeof(hpet_=
fw_cfg));
> +    }
> +#endif
> +
>      /* allocate memory for the NUMA channel: one (64bit) word for the nu=
mber
>       * of nodes, one word for each VCPU->node and one word for each node=
 to
>       * hold the amount of memory.
>
> I think this is a thorough enough solution and I can post a separate
> patch.

Yes, go ahead so that we can evaluate it separately from Rust concerns.

Paolo


