Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7D9C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 01:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua2vu-0006mL-DM; Thu, 10 Jul 2025 21:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua2vr-0006jL-Su
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 21:52:12 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua2vo-0007kw-B0
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 21:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752198728; x=1783734728;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JKaMQAipjm07ZHenYmiSXJD0s+0zUQA3XWSgJ6fZu+Y=;
 b=cignk90kQeL0lC8IiXJS+CYoWvSG54d4uuC0aC7Gn91OitLTcycBtng9
 3bpKtMVjZrs6aACKznohNnSA668+Xf4JA4OsG8HgvFuM2j0FaAA6baaal
 movv97hgHJy3dC5Ivj58hxKGKwQUHJkJ7hunSK4oozkmPE6fOPwdq6o5H
 /m/J4A51YqgkFbJSfOOr9hs+Ohx1AAL1kVgjuD3T9SBibi/fkv5Mmy6WU
 37gcby/ih4vG2RbLfGG16Tptzx2gXK83PNuv53JoNTAG8eNGly747NL+u
 HroiZI1YLtzn41OqSVFx+Yj437pdCxNOqnUrzoTNLPaETXRIbq5bOAvdc Q==;
X-CSE-ConnectionGUID: f2NBgC4lSymdTi5SvF8o0Q==
X-CSE-MsgGUID: +F9BVhj2S/iJGPhSjEy5mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58255150"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="58255150"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 18:52:05 -0700
X-CSE-ConnectionGUID: K9dwr8cJQE6tpml6q878MA==
X-CSE-MsgGUID: gR/0+tJQR2+qksMDdG2SNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="161936265"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 18:52:04 -0700
Message-ID: <6c381d13-db0e-4b61-b72b-bda9e7727143@intel.com>
Date: Fri, 11 Jul 2025 09:52:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/i386: move max_features to class
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20250711000603.438312-1-pbonzini@redhat.com>
 <20250711000603.438312-2-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250711000603.438312-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/11/2025 8:06 AM, Paolo Bonzini wrote:
> max_features is always set to true for instances created by -cpu max or
> -cpu host; it's always false for other classes.  Therefore it can be
> turned into a field in the X86CPUClass.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

missed one place:


----------------8<---------------
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8302,7 +8302,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error 
**errp)
          }
      }

-    /*TODO: Now cpu->max_features doesn't overwrite features
+    /*TODO: Now xcc->max_features doesn't overwrite features
       * set using QOM properties, and we can convert
       * plus_features & minus_features to global properties
       * inside x86_cpu_parse_featurestr() too.



with above added,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>


