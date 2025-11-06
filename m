Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860F1CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 09:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGwTh-0001zz-SG; Thu, 06 Nov 2025 04:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vGwTg-0001xh-Gj
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 04:40:24 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vGwTe-0005L3-O7
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 04:40:24 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b70fb7b54cdso130407866b.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 01:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762422021; x=1763026821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I9JtZzZZJ5Szb1swUQPzO9Qt81xOQJmVdlAU2ltZN3g=;
 b=cRP2knaI8mrRHqxvdCWqs2XEf4qqM7PaR4iMJ/5tM+4Hd8KD7IjY5w49rR8xjOLGH1
 We6FFfBvEcZOLjjd2Df8dzwV1rAorK15eh13vXnPKwQi14u0Z9eufy/BIPmiGGkL8Dx9
 GfG0dw0J89bRgeMtbO0PqlHeDMoF+lwf551ETaigw58CcvNf5Pa3amny1njKwhxVghhT
 xw3T27rHwgzvq1et+HHe4RAalZYI6Af+d7doskdYYduxPumcsaaDDeHHuygUC/T8T19d
 0QSMFTR0Nq0TVb94ytvpVJPzAHrSHFkqAreuIFdPRfZwMeZbZbVSX+XJYNwifD4IBIFb
 5rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762422021; x=1763026821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I9JtZzZZJ5Szb1swUQPzO9Qt81xOQJmVdlAU2ltZN3g=;
 b=BEQitKOZy8woFzU2PzbHSkfEI+khqFqtrTU0LVGg2yL872Fxi9n9Z+xpCwLOZBV5yC
 MnfjwCf0zPathWEkzVu2jOMy4G5xWtLL0SMtoQ5LBt1o2dHHKtIHNGsWfojN7MfdAnlW
 hp4l/D2c5OWiPglpPwhF5VZ8fVzb8oLCnc57PSLjNPNyf49+5PhHGF4mgTPUkOZtZOMh
 pjgzhxOkU7D7XMKJC+9FK2CyEB3U7rfuwt2P01PnQ0vpghwByVAvJaQqeZRjIqJyau3g
 FeVErSUkk4hAyFTXYnyp2Tkw+lo/p8ZHB7Rki/LC1fyh7minIGHiFyzMPWk+UDEv8Wim
 t2dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcMyqn1z8OjHPG7eLSCO2aNegX3Q4IDdIvFCUDBnyI1td9SIKOGiJRpqX5wF3pRhRzvkVhFKpUEUkW@nongnu.org
X-Gm-Message-State: AOJu0YxTHdQU0VjsYRtw15pjQffQSl5vlzCsIAXXzx2aZMaZ+rjC002F
 s7RNsUmkm3p+IyV4l2Ye2sw2X5bANt5XJsF0Xvyz4ddrUlPomq6JGFsGofJUA37OkFE=
X-Gm-Gg: ASbGnctjyouUM/x7VoN6msr4lTv/ATfQlYxWdwO2OD8JbiHCMdUlHcj8OucT9lsu3cF
 KXtxZl5WGOZupd+887SYqTDdrHjuJvslVBOBvwh89z6cnjq89dzpXJKCzO2VedQC2eLlZzShyC4
 PBSQhQ+VfBTLGSCZkGItsOwcMqvDsdbIhuAjarz1snbSXJH/o68O01og+HnHRL5EqqFoIoWPqZX
 3+MN112FJt9HXnlMThfQrtQoqrnR9QoomSzKA4tkUXvmDb5hghKKsp1kArngRkCTfCvC4t4HG74
 h1IMKmZHg5QzHI8SV4eNSPiGAhUss+lOHIlxRQitAWtESnga62zJbGSX+kxtQCHg3pc961gogY5
 Kvn6GmY5i71tG28KPM1doLrb3zyMWD6JweJKTpvRrtC4grO+SimpjLQIZdlj+gaX7w8Q3szohbY
 4hauHAiWtOewK2W726DnT69ThCfZlcdFRGYw==
X-Google-Smtp-Source: AGHT+IEImNLvEv+BvoVzM3oQPw7O5b8dvobLF8MfGHU2pTrRO+7e3bcoq1UdHlWr9onQhn11vFBzbQ==
X-Received: by 2002:a17:907:7f0f:b0:b3f:f207:b748 with SMTP id
 a640c23a62f3a-b726515d4e2mr469991666b.10.1762422020826; 
 Thu, 06 Nov 2025 01:40:20 -0800 (PST)
Received: from [172.20.148.161] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7289644819sm173764566b.45.2025.11.06.01.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 01:40:20 -0800 (PST)
Message-ID: <e52c8dd0-d284-4dc0-ad0c-3832ce996884@linaro.org>
Date: Thu, 6 Nov 2025 10:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 17/28] hw: arm: virt-acpi-build: add hack
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
 <20251029165510.45824-18-mohamed@unpredictable.fr>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20251029165510.45824-18-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ej1-x630.google.com
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

Hi Mohamed and Phil,

On 10/29/25 17:54, Mohamed Mediouni wrote:
> Looks like in the prior Qemu ACPI table handling, GICv2 configurations
> had vms->its=1...

To me, ITS should not be present on machines that have GICv2, so we should not generate
any ACPI table advertising ITS when GICv2 is used.


Cheers,
Gustavo

> Match that assumption to not make the test suite fail. Probably not merge-worthy...
> 
> And then maybe see what to do for older releases too?
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt-acpi-build.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index a6a56455a9..39dd3d1020 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -472,7 +472,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>           nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
>           rc_mapping_count = rc_smmu_idmaps_len;
>   
> -        if (virt_is_its_enabled(vms)) {
> +        if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
>               /*
>                * Knowing the ID ranges from the RC to the SMMU, it's possible to
>                * determine the ID ranges from RC that go directly to ITS.
> @@ -483,7 +483,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>               rc_mapping_count += rc_its_idmaps->len;
>           }
>       } else {
> -        if (virt_is_its_enabled(vms)) {
> +        if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
>               nb_nodes = 2; /* RC and ITS */
>               rc_mapping_count = 1; /* Direct map to ITS */
>           } else {
> @@ -498,7 +498,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
>       build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>   
> -    if (virt_is_its_enabled(vms)) {
> +    if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
>           /* Table 12 ITS Group Format */
>           build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
>           node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
> @@ -517,7 +517,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>           int smmu_mapping_count, offset_to_id_array;
>           int irq = sdev->irq;
>   
> -        if (virt_is_its_enabled(vms)) {
> +        if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
>               smmu_mapping_count = 1; /* ITS Group node */
>               offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
>           } else {
> @@ -610,7 +610,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>               }
>           }
>   
> -        if (virt_is_its_enabled(vms)) {
> +        if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
>               /*
>                * Map bypassed (don't go through the SMMU) RIDs (input) to
>                * ITS Group node directly: RC -> ITS.


