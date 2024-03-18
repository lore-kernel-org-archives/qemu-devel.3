Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B78C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8Bn-0003Yu-Md; Mon, 18 Mar 2024 04:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rm8Bh-0003YC-S7; Mon, 18 Mar 2024 04:17:41 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rm8Bf-0003sZ-5k; Mon, 18 Mar 2024 04:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710749859; x=1742285859;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Gp5/N3Kgd9u6t4pstjSRJF2QxivLRDeeRMPxXHWN/cY=;
 b=IVCxkKpHRNb4HDuf8N+HNRtySCNVCFC51LNUOQUkhUBdVyyJI7KQeyS6
 5sPsnHd+Vj/URhSH648aPmQhF9X7mkfabVI93ZUTzeU7PdgmKYQTdfzQk
 8nEnW/RggBXOGqMBm303PvhcT9GQfqC7y/PLvP3pvzZ8RTdghrD+/Bl9H
 pjnY/5/3q+wUuJTdxIMXUgHoFX+fufkHOY2lB97eayWCXBLZo3fb3nMYf
 zOiSp9lzEPIDI1hDZnDRpAnXrgTPPSNisYtgFIv+t3inkK3zs4UOSu4mp
 nIMN32cXjySeEmZFO3vddu4MNbe/yGprymotqF7zU5wnzyGwyHY8Wd0Un Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16271090"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="16271090"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 01:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="14034331"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 18 Mar 2024 01:17:28 -0700
Date: Mon, 18 Mar 2024 16:31:19 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH-for-9.1 05/21] cpus: Open code OBJECT_DECLARE_TYPE() in
 OBJECT_DECLARE_CPU_TYPE()
Message-ID: <Zff71/46jLOGz9XO@intel.com>
References: <20240315130910.15750-1-philmd@linaro.org>
 <20240315130910.15750-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315130910.15750-6-philmd@linaro.org>
Received-SPF: none client-ip=192.198.163.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Philippe,

On Fri, Mar 15, 2024 at 02:08:53PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 15 Mar 2024 14:08:53 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 05/21] cpus: Open code OBJECT_DECLARE_TYPE() in
>  OBJECT_DECLARE_CPU_TYPE()
> X-Mailer: git-send-email 2.41.0
> 
> Since the OBJECT_DECLARE_CPU_TYPE() macro uses the abstract ArchCPU
> type, when declaring multiple CPUs of the same ArchCPU type we get
> an error related to the indirect G_DEFINE_AUTOPTR_CLEANUP_FUNC()
> use within OBJECT_DECLARE_TYPE():
> 
>   target/mips/cpu-qom.h:31:1: error: redefinition of 'glib_autoptr_clear_ArchCPU'
>   OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
>   ^
>   include/hw/core/cpu.h:82:5: note: expanded from macro 'OBJECT_DECLARE_CPU_TYPE'
>       OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
>       ^
>   include/qom/object.h:237:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
>       G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
>       ^
>   /usr/include/glib-2.0/glib/gmacros.h:1371:3: note: expanded from macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
>     _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
>     ^
>   /usr/include/glib-2.0/glib/gmacros.h:1354:36: note: expanded from macro '_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
>     static G_GNUC_UNUSED inline void _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) (TypeName *_ptr)                     \
>                                      ^
>   /usr/include/glib-2.0/glib/gmacros.h:1338:49: note: expanded from macro '_GLIB_AUTOPTR_CLEAR_FUNC_NAME'
>   #define _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) glib_autoptr_clear_##TypeName
>                                                   ^
>   <scratch space>:54:1: note: expanded from here
>   glib_autoptr_clear_ArchCPU
>   ^
>   target/mips/cpu-qom.h:30:1: note: previous definition is here
>   OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
>   ^
> 
> Avoid that problem by expanding the OBJECT_DECLARE_TYPE() macro
> within OBJECT_DECLARE_CPU_TYPE().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> TODO: check rth comment:
> What about adding an OBJECT_DECLARE_CPU_SUBTYPE that omits half the stuff instead?
> We don't need another object typedef at all, for instance.
> ---
>  include/hw/core/cpu.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index ec14f74ce5..4c2e5095bf 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -78,7 +78,12 @@ DECLARE_CLASS_CHECKERS(CPUClass, CPU,
>   */
>  #define OBJECT_DECLARE_CPU_TYPE(CpuInstanceType, CpuClassType, CPU_MODULE_OBJ_NAME) \
>      typedef struct ArchCPU CpuInstanceType; \
> -    OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
> +    typedef struct CpuClassType CpuClassType; \
> +    \
> +    G_DEFINE_AUTOPTR_CLEANUP_FUNC(CpuInstanceType, object_unref) \
> +    \
> +    DECLARE_OBJ_CHECKERS(CpuInstanceType, CpuClassType, \
> +                         CPU_MODULE_OBJ_NAME, TYPE_##CPU_MODULE_OBJ_NAME)
>

The OBJECT_DECLARE_TYPE is expaneded as the following:

#define OBJECT_DECLARE_TYPE(InstanceType, ClassType, MODULE_OBJ_NAME) \
    typedef struct InstanceType InstanceType; \
    typedef struct ClassType ClassType; \
    \
    G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
    \
    DECLARE_OBJ_CHECKERS(InstanceType, ClassType, \
                         MODULE_OBJ_NAME, TYPE_##MODULE_OBJ_NAME)

So the above code change deletes a typedef:

    typedef struct ArchCPU ArchCPU;

Will this deletion break the direct uses of ArchCPU? e.g., in
accel/tcg/translator.c:

static void set_can_do_io(DisasContextBase *db, bool val)
{
    if (db->saved_can_do_io != val) {
        ...
        tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
                        offsetof(ArchCPU, parent_obj.neg.can_do_io) -
                        offsetof(ArchCPU, env));
    }
}

Thanks,
Zhao


