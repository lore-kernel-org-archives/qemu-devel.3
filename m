Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78B1E7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 18:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVatl-00028d-CL; Wed, 08 Jan 2025 13:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVati-00027B-II
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:35:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVatf-0002f8-AP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736361312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJg03g1ssw+ZqwmFpuoUTERERYx4Vmwv8vgdlJeD5zk=;
 b=T/h7yjOfP2IPz9H6tc22JmdBtJPaTZX167HwH+Oa98HLbqcpqpAVBp7yzuzH76/SGD5ms7
 izXb/gNkv15yqN5DI92u8gddB/1qWKmPv5nYhlEpDqtBBGmJ/G6wx50Xu/5FwxQmMhbIK1
 RkA1iPcyQvupKbbklH0oI5lmDnRPT9o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-f3_hQUVwPiagxfOKF4UoHQ-1; Wed, 08 Jan 2025 13:35:09 -0500
X-MC-Unique: f3_hQUVwPiagxfOKF4UoHQ-1
X-Mimecast-MFC-AGG-ID: f3_hQUVwPiagxfOKF4UoHQ
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa67fcbb549so13992566b.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 10:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736361308; x=1736966108;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qJg03g1ssw+ZqwmFpuoUTERERYx4Vmwv8vgdlJeD5zk=;
 b=HrhsLkedOdDz/00W9sdmBXr3n5JeB22OZ5xkwhA9beo/MZu754ckhqVZpBnAz4S6va
 f1F6EQ1rEGsS2McU1hri2JNYjmD3IZbk87noiIak5sjxFztyDnIdntWuhou7cRqP7bt0
 B0r8QjeT5okA31cRcX5ZnpPVCppu6eWVBAzg7Ci6xVdjUU3hHGb/eVCzN8g1epBideAr
 LAwbKzUjZfUmcrOcjwvxWuLrMbSp2fW526bOiXBPqIXa5Nsc7u31VWCFexHoFuqV7LjO
 0ZEVh+iL8ZSxRtcfhzAYx3xdSoR49mjh0/4lBC4ugsnW6edRz1ki+WmrVCx/Ejkd2VU5
 tQXg==
X-Gm-Message-State: AOJu0YyLHZsaGyL8ZVuCDNOIXOLUquVkT0r3BSmBLGNnpN7qzuMOKhff
 lTbez67s8mfxdQ84MAJ5BolgOGtXQGTOUSwQHRPAKfzIcvj94XeRSkeTtau7xOORTKhRWzep+z8
 YlPFCIPI6BzbRiA6iBY2A3wHIBCTci+H4v5fFj7qY7JM39gFLFs9/
X-Gm-Gg: ASbGncuGZW2ru9rjid6E+okLuzYpHOV/vfPaPMFA/wSd11QfwkXLHeTh9oitS96uQaM
 /dHTX3Uiayq2cJD32Fc5kP4Q+GpzhL9gGu4eQ1u9FYjmrj+EHQHQxlpkHOtj9E4Y5+S2ZP5ohcA
 DxD+0F30sOPPH+P6YiBXRBmWq/mwg92y0XgyEOTS9mBqwPWHDt7BWUoQ0tYab3VU2x6QbtSIqvg
 rY68/quwwU0KRFD9SUpNkrlzMI/7Dvc/dA/0y4N3bde0Qu+7Bs=
X-Received: by 2002:a17:907:2d24:b0:aae:b259:ef63 with SMTP id
 a640c23a62f3a-ab2ab5f9b18mr303376566b.34.1736361308302; 
 Wed, 08 Jan 2025 10:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcyidU23LGd0ytcokyYfbYS/XhG/pUvSVBMv8h1t9vxlpIWn86sJXjQqj8oxh/8+FPacIR4g==
X-Received: by 2002:a17:907:2d24:b0:aae:b259:ef63 with SMTP id
 a640c23a62f3a-ab2ab5f9b18mr303375066b.34.1736361307976; 
 Wed, 08 Jan 2025 10:35:07 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e82eb8fsm2507006866b.35.2025.01.08.10.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 10:35:07 -0800 (PST)
Date: Wed, 8 Jan 2025 13:35:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hendrik Wuethrich <whendrik@google.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net,
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, zhao1.liu@intel.com, xiaoyao.li@intel.com,
 peternewman@google.com
Subject: Re: [PATCH v5 8/8] i386/cpu: Adjust level for RDT on
 full_cpuid_auto_level
Message-ID: <20250108133450-mutt-send-email-mst@kernel.org>
References: <20241213172645.2751696-1-whendrik@google.com>
 <20241213172645.2751696-9-whendrik@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241213172645.2751696-9-whendrik@google.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Dec 13, 2024 at 05:26:45PM +0000, Hendrik Wuethrich wrote:
> From: ‪Hendrik Wüthrich <whendrik@google.com>
> 
> Make sure that RDT monitoring and allocation features are included in
> in full_cpuid_auto_level.
> 
> Signed-off-by: Hendrik Wüthrich <whendrik@google.com>
> ---
>  target/i386/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f7904870ed..4f1493043e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -880,6 +880,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>  #else
>  #define TCG_7_0_ECX_RDPID 0
>  #endif
> +
>  #define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | \
>            /* CPUID_7_0_ECX_OSPKE is dynamic */ \
>            CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES | \


do not change unrelated code pls.

> @@ -7672,6 +7673,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>          x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
>          x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
>          x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
> +        x86_cpu_adjust_feat_level(cpu, FEAT_RDT_F_0_EDX);
> +        x86_cpu_adjust_feat_level(cpu, FEAT_RDT_10_0_EBX);
>  
>          /* Intel Processor Trace requires CPUID[0x14] */
>          if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
> -- 
> 2.47.1.613.gc27f4b7a9f-goog


