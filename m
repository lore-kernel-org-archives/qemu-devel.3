Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048B1CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RWl-0003Ks-Vg; Thu, 16 Oct 2025 13:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RWk-0003Ka-Lm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:12:34 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RWb-0003p4-RC
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:12:34 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3327f8ed081so1303483a91.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760634740; x=1761239540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wqblu1nTC6KBf9GQr3KlSotdtAc28SYiKW3vv2OoNSk=;
 b=heyPNoVE66P3uI7NuJ7SSqwENPmcrQJD60RswW4hQ8OsZVeO+9Nf7RwewES0wRTrm2
 JuRcYNHFI2IZifJvyoIgOroW47lvICwwFW/IUUADhZLN9rKgTjB2dTL9YpjeieVZCGIj
 4F215nrqxl6q/UIrg/lcA0L07cYu8UPaDfVhnWZ3yyKtfhJaeZ6bpAgKQ2onwicd94qA
 m8AIlbGWUxyLgyiHkV+Tlgqv3SOi3qSTa16zGhxgzfrZR1rdWV2Nwod39YUsBSracQMH
 oA/NmCen9pmv/BZvLENuy9K+VWClZIuyorPvfq0ZklNDJC//oAZ/tweAUI322NXGcGU6
 ZkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760634740; x=1761239540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wqblu1nTC6KBf9GQr3KlSotdtAc28SYiKW3vv2OoNSk=;
 b=NHGfY5owQL+8Z3I1ZMOzYNcSt+0kwgSSber95fRigsTekQAd4BJMI/3LEToODMGOmB
 3d0Zc8XYEOfmTytg1/pzvD55vpzWbid4ebo0s4wfCivaJgzu1b7ICj8S+/KDgegEmz/b
 BqrTdWPpz3r+hDNGGbi2YvPJa640YIKPWnEizsgFJHNf/86EWFZeGoVIYFQvZpTBNAhY
 +bQZZW3BdoKzXAor9etr897AzUGp2cDbdZxKGh6TeZUH/TsVBnLFUW21RXyWa1ByTA2K
 g/Yy1w1qZYDVUHE4tAv0JRFV93iyiCkw04ssdEobg23azkycf8PKcdLXIxhpkmsFCLii
 NZ7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQsFTnD++lLarPYwhkhk3Lso14knx/j+ffSNpPLHGMEGdJ/nZQn8ot3HOa41LscPuDL76ZBe1RlYjx@nongnu.org
X-Gm-Message-State: AOJu0YzWsptJh12bWFRJGknR8d8rS2AVCVfDS6sYogErZHWrumYM4gS6
 b6WDU23lGB8gsimFNrDqrQgXqqZFIG0bZZqVlZrWP0HppxGGYhecxDmSJ6irzjFPD88=
X-Gm-Gg: ASbGncsmbOLK32kexGmo06jtt20HZxk+UhzFBO/D868o04X65HM8ntLWve21+6gut9W
 Fi/dSwPquf61Te90L2oWJHNXtHcitRIW5oCHtGYj38Uw9pWbxgYWmS7rbcmaLOvLwz38nOzXjLF
 odgBUCovvDOGt/0wsnQyH78C48Lc8fD2h+IYE2A5/nfdF37Axwwbk1Y0p0ALkZzK1+VVYKitYGc
 aR1WhXOJP6n1Xz/XiMUwWndONYvHx4smqFyTUJkLzQWRYlZ2yQ6H8YY+XxAG7EJUCKXIsoBWigk
 xOz26FQUrh/LP5xN4AUFRTvOUWPebEnVIzqnOpsTBm+Z+xkrJq2++D0gDXmZJp6nKLP8NeJcaNp
 Bidfukwbq2iaJXBpZ0n2Jqp35je+nyz8OGIc3dV1ZMNQGdsbjzkGKm690H8zTQVMybefc/jULoa
 fg3rAcuSP18+ub
X-Google-Smtp-Source: AGHT+IHelTFD/6eyJl55bPn6h0h2qCPlAEcjf6xEmaHE7c0nv5FzNep3RfWsm3FjU/yzVLvG86PL9g==
X-Received: by 2002:a17:90b:28c4:b0:338:3789:2e7b with SMTP id
 98e67ed59e1d1-33bcf86b5bbmr642520a91.13.1760634740118; 
 Thu, 16 Oct 2025 10:12:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33bb66c4a93sm2557506a91.23.2025.10.16.10.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 10:12:19 -0700 (PDT)
Message-ID: <d44a4957-4b0e-4ab3-a720-04b7fc88978b@linaro.org>
Date: Thu, 16 Oct 2025 10:12:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/24] whpx: arm64: implement -cpu host
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-20-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251016165520.62532-20-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/16/25 9:55 AM, Mohamed Mediouni wrote:
> Logic to fetch MIDR_EL1 for cpu 0 adapted from:
> https://github.com/FEX-Emu/FEX/blob/e6de17e72ef03aa88ba14fa0ec13163061608c74/Source/Windows/Common/CPUFeatures.cpp#L62
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt.c              |   2 +-
>   target/arm/cpu64.c         |  19 ++++---
>   target/arm/whpx/whpx-all.c | 104 +++++++++++++++++++++++++++++++++++++
>   target/arm/whpx_arm.h      |   1 +
>   4 files changed, 119 insertions(+), 7 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


