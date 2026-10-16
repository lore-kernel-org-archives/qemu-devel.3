Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDF9CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHgj3-0001gv-0M; Fri, 16 Oct 2026 08:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHgj1-0001gc-Dk
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHgiw-0007iH-UO
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792152464;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ju0nFAYOk2Czky0zNl7ufn2mbubdX/H/KKmBDyLc6mA=;
 b=W+qbueBkOM8+8IB5gu409gLn8IVck37x69I1FsxNhOzt5w0CiJWeOHAmQCUBQSeXY/hp9J
 wr1alHA0hvvaNf1GEAkp9m7TwmnM3/LWvgpAII0WVnQDmvIYXAaFs6wHkDn9f73HnBgkQb
 FMLnz2B9YLJ56JiSDe1aOxL1vwRNE5k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-nTGh9BcJOu-TilnXdagqTg-1; Fri, 16 Oct 2026 12:07:43 +0000
X-MC-Unique: nTGh9BcJOu-TilnXdagqTg-1
X-Mimecast-MFC-AGG-ID: nTGh9BcJOu-TilnXdagqTg_1792152462
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48dfdc0fa95so471653f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792152462; x=1792757262;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ju0nFAYOk2Czky0zNl7ufn2mbubdX/H/KKmBDyLc6mA=;
 b=h6LNiz9j36/XyZtkXGsD28f04Paha6dWb7wnGvxsQgQi2q+K2PNldwR+bxoYeHzJfh
 GaRiAUtuYLlp+R0CF6kZ/jWqjnMxrxbzItWRY3esC2Ggjb7LyHzvys4aRM3Wi5vLKDUn
 ruVnrm/e1SxBOIIpqr3nS7Xn3g6NwaGG+2uA9iS+7g/G1DslfseYi+Dz/2H9KzCMQ/mB
 rDs8ErGbKhGpWBWBEyUEFJ59CLQRLbnZJ9Ry0yghdqbU0MT3vz9RgiUX/7ie8xT/F+JK
 QAduxyqQVgwe9S33JkywtkX7h3lzFcrnV2zeA39VxKBZvOA8s5/jW0t34i0cYplHduW+
 jzUA==
X-Forwarded-Encrypted: i=1;
 AKwUvByoMr2NvEsSd9y+Wh8b6lVmCwmBmnEJ7ehZeaKKqcAsD7b+dQaO+5Pg7aaUuDs+CQX6GSNInu9KCq2V@nongnu.org
X-Gm-Message-State: AFq9FYIN3FdfdWi5Go2+1q53jGJvvpteHooSyh/ZCuOIHMnD/tbH1Nnd
 QVIP+qExg2f7YNGVfmkgv1IhpyQJ7JGBhUpRwjguMQmAwPkEO/pmTitLTt5GFYC+VLO13skxDvX
 kU44TOUBJ7K5Yq8I8UAckqLoQoUqel3izdlImu66PrjGlFo+BGC8cUOqq
X-Gm-Gg: AYBFou1qKMhsm205wHE91jrEq5tDiWdG84xAUjqaBNGdONjqpemla5W/dLFZONey36F
 CpWeaXUtGXTeumlbC7Q4c+jZWHvlLn+Xmb04onkTUyBv9Zx6YlFQB9kZ3MkYOygT05MwYLEA6Nf
 ksTLE8aSgzy04b2nR2ZLZPrQEyrW908qGyiJQEzmutD0Zv2T8nToT4S9dSC5I/pUGV/ZJMqZcPr
 /GyU/QV5U8G5D6PWbdAa5HX5bbm+iZo6u5H5IO9xtL+khENuj8lC7/aUNPLuxAjm0jzDWaPKUFB
 LZQvqIQu0mGpofVORopHdNrxsPE891PpJPmBUTYqffT/fn7t0tCCLgi8+ZpMIn3i7TbP/jXzn9o
 yX9iaEawMhSq5JBZsPUPhZdDS+nskfUy4MWOYh7bRnjnS5dJT
X-Received: by 2002:a05:6000:987:b0:488:7787:469d with SMTP id
 ffacd0b85a97d-48df14ed887mr13718628f8f.25.1792152462145; 
 Fri, 16 Oct 2026 05:07:42 -0700 (PDT)
X-Received: by 2002:a05:6000:987:b0:488:7787:469d with SMTP id
 ffacd0b85a97d-48df14ed887mr13718556f8f.25.1792152461547; 
 Fri, 16 Oct 2026 05:07:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503a24sm4678122f8f.49.2026.10.16.05.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 05:07:40 -0700 (PDT)
Message-ID: <45c37754-2244-4336-9aa8-12d0b89840d4@redhat.com>
Date: Fri, 16 Oct 2026 14:07:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 12/25] target/arm: add arm-v9.0-a-v1 named CPU model
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 ping@khushitshah.com, sandesh.patel@nutanix.com
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-13-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-13-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 9/21/26 2:32 PM, Khushit Shah wrote:
> Add a KVM-only named CPU model for the Armv9.0-A baseline, following
> DDI0487 revision M.c. The property list is the architecture-mandated
> ID-register field view.
>
> Pointer authentication is omitted because a v9.0-A core may implement
> any PAuth algorithm.
>
> Named models start from a zeroed ID-register view, so features whose
> "not implemented" encoding is non-zero (for example TGran64=0xF,
> DoubleLock=0xF) are set explicitly.
>
> The model is not realizable on its own; implementation-defined fields
> such as CTR_EL0.{CWG,ERG} and ID_AA64DFR0_EL1.CTX_CMPs still have to be
> supplied on the command line. However, this provides a useful baseline
> for upcoming reference core models.
>
> Final ID register state requested from KVM for "arm-v9.0-a-v1":
> [  0] AIDR_EL1                 = 0x0000000000000000
> [  1] CLIDR_EL1                = 0x0000000000000000
> [  2] CTR_EL0                  = 0x0000000080008000
> [  3] DCZID_EL0                = 0x0000000000000000
> [  4] GMID_EL1                 = 0x0000000000000000
> [  5] ID_AA64AFR0_EL1          = 0x0000000000000000
> [  6] ID_AA64AFR1_EL1          = 0x0000000000000000
> [  7] ID_AA64DFR0_EL1          = 0x000000f000000009
> [  8] ID_AA64DFR1_EL1          = 0x0000000000000000
> [  9] ID_AA64DFR2_EL1          = 0x0000000000000000
> [ 10] ID_AA64FPFR0_EL1         = 0x0000000000000000
> [ 11] ID_AA64ISAR0_EL1         = 0x0221100010210000
> [ 12] ID_AA64ISAR1_EL1         = 0x0000011100211002
> [ 13] ID_AA64ISAR2_EL1         = 0x0000000000000000
> [ 14] ID_AA64ISAR3_EL1         = 0x0000000000000000
> [ 15] ID_AA64MMFR0_EL1         = 0x000001110f000000
> [ 16] ID_AA64MMFR1_EL1         = 0x0000000000211000
> [ 17] ID_AA64MMFR2_EL1         = 0x1001001100000011
> [ 18] ID_AA64MMFR3_EL1         = 0x0000000000000000
> [ 19] ID_AA64MMFR4_EL1         = 0x000000000f000000
> [ 20] ID_AA64PFR0_EL1          = 0x1101000010110011
> [ 21] ID_AA64PFR1_EL1          = 0x0000000000000001
> [ 22] ID_AA64PFR2_EL1          = 0x0000000000000000
> [ 23] ID_AA64SMFR0_EL1         = 0x0000000000000000
> [ 24] ID_AA64ZFR0_EL1          = 0x0000000000000000
> [ 25] ID_AFR0_EL1              = 0x0000000000000000
> [ 26] ID_DFR0_EL1              = 0x0000000000000000
> [ 27] ID_DFR1_EL1              = 0x0000000000000000
> [ 28] ID_ISAR0_EL1             = 0x0000000000000000
> [ 29] ID_ISAR1_EL1             = 0x0000000000000000
> [ 30] ID_ISAR2_EL1             = 0x0000000000000000
> [ 31] ID_ISAR3_EL1             = 0x0000000000000000
> [ 32] ID_ISAR4_EL1             = 0x0000000000000000
> [ 33] ID_ISAR5_EL1             = 0x0000000000000000
> [ 34] ID_ISAR6_EL1             = 0x0000000000000000
> [ 35] ID_MMFR0_EL1             = 0x0000000000000000
> [ 36] ID_MMFR1_EL1             = 0x0000000000000000
> [ 37] ID_MMFR2_EL1             = 0x0000000000000000
> [ 38] ID_MMFR3_EL1             = 0x0000000000000000
> [ 39] ID_MMFR4_EL1             = 0x0000000000000000
> [ 40] ID_MMFR5_EL1             = 0x0000000000000000
> [ 41] ID_PFR0_EL1              = 0x0000000000000000
> [ 42] ID_PFR1_EL1              = 0x0000000000000000
> [ 43] ID_PFR2_EL1              = 0x0000000000000000
> [ 44] MIDR_EL1                 = 0x0000000000000000
> [ 45] MPIDR_EL1                = 0x0000000080000000
> [ 46] MVFR0_EL1                = 0x0000000000000000
> [ 47] MVFR1_EL1                = 0x0000000000000000
> [ 48] MVFR2_EL1                = 0x0000000000000000
> [ 49] REVIDR_EL1               = 0x0000000000000000
> [ 50] SMIDR_EL1                = 0x0000000000000000
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  hw/arm/virt.c           |  3 ++
>  target/arm/cpu-models.c | 75 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index e7a56e37f7..01381ab5e7 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -4144,6 +4144,9 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
>      }
> +    if (kvm_enabled() && target_aarch64()) {
> +        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("arm-v9.0-a-v1")));
> +    }
>      if (target_aarch64()) {
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
> diff --git a/target/arm/cpu-models.c b/target/arm/cpu-models.c
> index 153ee10ae6..7394dd358e 100644
> --- a/target/arm/cpu-models.c
> +++ b/target/arm/cpu-models.c
> @@ -39,7 +39,82 @@
>  /* Maximum parent-chain depth for named CPU models. */
>  #define ARM_NAMED_CPU_MODEL_MAX_DEPTH 16
>  
> +/* Arm-v9.0-a mandatory features. */
> +static const ArmModelPropValue arm_v9_0_a_v1_props[] = {
> +    /* ID_AA64PFR0_EL1 */
> +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_EL0", NUM, 1), /* only FEAT_AA64EL0 (Armv9.0) */
> +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_EL1", NUM, 1), /* only FEAT_AA64EL1 (Armv9.0) */
> +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_RAS", NUM, 1), /* FEAT_RAS (Armv8.2) */
> +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_DIT", NUM, 1), /* FEAT_DIT (Armv8.4) */
> +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_CSV2", NUM, 1), /* FEAT_CSV2 (Armv8.5) */
> +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_CSV3", NUM, 1), /* FEAT_CSV3 (Armv8.5) */
> +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_FP", NUM, 1), /* FEAT_FP16 */
> +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_AdvSIMD", NUM, 1), /* FEAT_FP16 */
I have not found that FP+AdvSIMD (ie FEAT_FP16) were mandated by v9.0
amybe you want this model to implement FP16 but it does not seems
strictly mandated in v9.0
so it might be distinguished from other settings that are truly mandated.

> +
> +    /* ID_AA64PFR1_EL1 */
> +    /* KVM zeroes out these field when MTE is not enabled. */
> +    MODEL_PROP("SYSREG_ID_AA64PFR1_EL1_MTE_frac", NUM, 0),
useless as default is 0, no?
> +    MODEL_PROP("SYSREG_ID_AA64PFR1_EL1_BT", NUM, 1), /* FEAT_BTI (Armv8.5) */


> +
> +    /* ID_AA64MMFR0_EL1 */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR0_EL1_TGran64", NUM, 0xF), /* not mandatory */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR0_EL1_TGran4", NUM, 0), /* 4K granular support */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR0_EL1_TGran16_2", NUM, 1), /* not mandatory */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR0_EL1_TGran64_2", NUM, 1), /* not mandatory */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR0_EL1_TGran4_2", NUM, 1), /* not mandatory */
so the top comment, ie. 

+/* Arm-v9.0-a mandatory features. */

should really be updated accordingly. None of that is mandated by v9.0
spec, right?

|
|
> +
> +    /* ID_AA64DFR0_EL1 */
> +    MODEL_PROP("SYSREG_ID_AA64DFR0_EL1_DebugVer", NUM, 9), /* FEAT_Debugv8p4 (Armv8.4) */
> +    MODEL_PROP("SYSREG_ID_AA64DFR0_EL1_DoubleLock", NUM, 0xF), /* not implemented */
I understand this is mandated by v9.0, ie v9Ap0 ==> (!FEAT_DoubleLock)
> +    /* no PMU for named models */
> +    MODEL_PROP("SYSREG_ID_AA64DFR0_EL1_PMUVer", NUM, 0),
not needed? 

> +
> +    /* CTR_EL0 */
> +    MODEL_PROP("SYSREG_CTR_EL0_L1Ip", NUM, 2), /* FEAT_IVIPT: VIPT cache impl. */
ARMv8.0
> +
> +    /* ID_AA64MMFR4_EL1 */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR4_EL1_E2H0", NUM, 0xF), /* FEAT_E2H0 not mandatory */
not mandatory. All the non mandatory settings might rather go in the
neoverse child, no? That way it is easier to understand the role of this
parent which enforce mandatory features only
> +
> +    /* ID_AA64ISAR0_EL1 */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR0_EL1_CRC32", NUM, 1), /* FEAT_CRC32 (Armv8.1) */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR0_EL1_Atomic", NUM, 2), /* FEAT_LSE (Armv8.1) */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR0_EL1_TS", NUM, 2), /* FEAT_FlagM2 (Armv9.0 & FP) */
this is required because FP was opt-in. Otherwise v9.0 does not require
2. As far as I understand there is no  v9Ap0 ==> FEAT_FP

> +    MODEL_PROP("SYSREG_ID_AA64ISAR0_EL1_TLB", NUM, 2), /* FEAT_TLBIRANGE (Armv8.4) */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR0_EL1_RDM", NUM, 1), /* FEAT_RDM (Armv9.0 & FP) */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR0_EL1_DP", NUM, 1), /* FEAT_DotProd (Armv9.0 & FP) */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR0_EL1_FHM", NUM, 1), /* FEAT_FHM (Armv9.0 & FP) */
> +
> +    /* ID_AA64ISAR1_EL1 */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR1_EL1_LRCPC", NUM, 2), /* FEAT_LRCPC2 (Armv8.4) */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR1_EL1_FRINTTS", NUM, 1), /* FEAT_FRINTTS (v9.0 & FP) */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR1_EL1_FCMA", NUM, 1), /* FEAT_FCMA (Armv9.0 & FP) */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR1_EL1_JSCVT", NUM, 1), /* FEAT_JSCVT (Armv9.0 & FP) */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR1_EL1_DPB", NUM, 2), /* FEAT_DPB2 (Armv8.5) */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR1_EL1_SB", NUM, 1), /* FEAT_SB (Armv8.5) */
> +    MODEL_PROP("SYSREG_ID_AA64ISAR1_EL1_SPECRES", NUM, 1), /* FEAT_SPECRES (Armv8.5) */

For readability please groups all fields that are mandated if v9.0 + FP
+ AdvSIMD. This is still arguable if this shall be part of this model
though
> +    /*
> +     * FEAT_PAuth is mandated by Armv8.3 but is excluded here as reference
> +     * core can choose to implement any PAuth algorithm (APA/API/APA3).
Can you set a default value then? GPI/API <= 1 or GPA3/APA3.  This mens
the child will need to override.
Without that you cannot claim this model to ve v9.0 compliant.

I guess you need to document all named vcpu models in either
docs/system/arm/cpu-features.rst
There is also docs/system/qemu-cpu-models.rst
> +     */
> +
> +    /* ID_AA64MMFR1_EL1 */
nit reorder after AA64_MFR0. All values below look good to me
> +    MODEL_PROP("SYSREG_ID_AA64MMFR1_EL1_HPDS", NUM, 1), /* FEAT_HPDS (Armv8.1) */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR1_EL1_LO", NUM, 1), /* FEAT_LOR (Armv8.1) */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR1_EL1_PAN", NUM, 2), /* FEAT_PAN2 (Armv8.2) */
> +
> +    /* ID_AA64MMFR2_EL1 */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR2_EL1_UAO", NUM, 1), /* FEAT_UAO (Armv8.2) */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR2_EL1_CnP", NUM, 1), /* FEAT_TTCNP (Armv8.2) */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR2_EL1_TTL", NUM, 1), /* FEAT_TTL (Armv8.4) */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR2_EL1_AT", NUM, 1), /* FEAT_LSE2 (Armv8.4) */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR2_EL1_IDS", NUM, 1), /* FEAT_IDST (Armv8.4) */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR2_EL1_E0PD", NUM, 1), /* FEAT_E0PD (Armv8.5) */
> +
> +    MODEL_PROP_END,
> +};
> +
>  static const ArmNamedCpuModel arm_cpu_models[] = {
> +    {"arm-v9.0-a-v1", NULL, arm_v9_0_a_v1_props},
>      {NULL, NULL, NULL}
>  };
>  
Thanks

Eric


