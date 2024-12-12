Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7B6E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 05:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLbL0-0005Sg-66; Thu, 12 Dec 2024 00:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoyuan@linux.alibaba.com>)
 id 1tLaAB-0001g9-LJ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:46:55 -0500
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoyuan@linux.alibaba.com>)
 id 1tLaA8-0000iB-U5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 22:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1733975204; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
 bh=9EcLnTR7QbNumNY8YIr1TZfrhT/nECOq4b1pLbyi7qY=;
 b=b1ucooL0BJJM6m1Un0TKT+K9DB4Xep7UtH6n/t1Xb4emjvwPMfE3R+JyAAHS+EQ5xWszHxgTCWlxk4bwAxC4EIv6gdWKPhzuOfI/gbjLaCS936IBCy8t91rlN4QwUlggWhNBCAXfM5zTuNs2mbxcfd1vopdUQ1H/x1m2fKuru8w=
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com
 fp:SMTPD_---0WLKA3v0_1733974896 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 12 Dec 2024 11:41:36 +0800
Date: Thu, 12 Dec 2024 11:41:34 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org, 
 seanjc@google.com, michael.roth@amd.com, rick.p.edgecombe@intel.com, 
 isaku.yamahata@intel.com, farrah.chen@intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH] i386/kvm: Set return value after handling
 KVM_EXIT_HYPERCALL
Message-ID: <ivj52agcnualj7avwe4mbv65q6hd3fyzjihnm4sejieiewv2ae@s5d55tdzgnfq>
References: <20241212032628.475976-1-binbin.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212032628.475976-1-binbin.wu@linux.intel.com>
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=yaoyuan@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -164
X-Spam_score: -16.5
X-Spam_bar: ----------------
X-Spam_report: (-16.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Dec 2024 00:02:05 -0500
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

On Thu, Dec 12, 2024 at 11:26:28AM +0800, Binbin Wu wrote:
> Userspace should set the ret field of hypercall after handling
> KVM_EXIT_HYPERCALL.  Otherwise, a stale value could be returned to KVM.
>
> Fixes: 47e76d03b15 ("i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE")
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> ---
> To test the TDX code in kvm-coco-queue, please apply the patch to the QEMU,
> otherwise, TDX guest boot could fail.
> A matching QEMU tree including this patch is here:
> https://github.com/intel-staging/qemu-tdx/releases/tag/tdx-qemu-upstream-v6.1-fix_kvm_hypercall_return_value
>
> Previously, the issue was not triggered because no one would modify the ret
> value. But with the refactor patch for __kvm_emulate_hypercall() in KVM,
> https://lore.kernel.org/kvm/20241128004344.4072099-7-seanjc@google.com/, the
> value could be modified.
> ---
>  target/i386/kvm/kvm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 8e17942c3b..4bcccb48d1 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -6005,10 +6005,14 @@ static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
>
>  static int kvm_handle_hypercall(struct kvm_run *run)
>  {
> +    int ret = -EINVAL;
> +
>      if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
> -        return kvm_handle_hc_map_gpa_range(run);
> +        ret = kvm_handle_hc_map_gpa_range(run);

LGTM to the issue it tries to fix :-)

> +
> +    run->hypercall.ret = ret;
>
> -    return -EINVAL;
> +    return ret;
>  }
>
>  #define VMX_INVALID_GUEST_STATE 0x80000021
>
> base-commit: ae35f033b874c627d81d51070187fbf55f0bf1a7
> --
> 2.46.0
>

