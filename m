Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F290C48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 07:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbyU6-0008M1-2q; Mon, 19 Feb 2024 02:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1rbyU3-0008Lj-6m
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 02:54:39 -0500
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1rbyU0-0004Hh-9k
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 02:54:38 -0500
X-ASG-Debug-ID: 1708329263-086e230f2743bb0001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx1.zhaoxin.com with ESMTP id AUhwfZp6qktPqla3 (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 19 Feb 2024 15:54:23 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 15:54:23 +0800
Received: from [10.28.66.62] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 15:54:22 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <b09804a5-b93d-4370-918d-acd18bcc64bb@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.28.66.62
Date: Mon, 19 Feb 2024 02:54:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: PING: [PATCH v2] target/i386/kvm: Refine VMX controls setting for
 backward compatibility
Content-Language: en-US
X-ASG-Orig-Subj: PING: [PATCH v2] target/i386/kvm: Refine VMX controls setting
 for backward compatibility
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <kvm@vger.kernel.org>,
 <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <cobechen@zhaoxin.com>, <ewanhai@zhaoxin.com>
References: <20231127034326.257596-1-ewanhai-oc@zhaoxin.com>
In-Reply-To: <20231127034326.257596-1-ewanhai-oc@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1708329263
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3531
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121040
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Dear QEMU Community,

Two months have passed since my last submission of the patch aimed at
addressing an issue encountered with kernels prior to Linux kernel 5.3.
When using the latest version of QEMU with '-cpu host', if the host
supports the rdseed instruction but not rdseed exiting, it results in
a QEMU error: "error: failed to set MSR 0x48b to 0x*****".

I understand everyone is busy, and reviewing patches can be quite
resource-intensive. Nevertheless, I am eager to hear if there are any
further comments, suggestions, or advice on what steps I should take next
regarding this patch.

Sincerely,Ewan

On 11/26/23 22:43, EwanHai wrote:
> Commit 4a910e1 ("target/i386: do not set unsupported VMX secondary
> execution controls") implemented a workaround for hosts that have
> specific CPUID features but do not support the corresponding VMX
> controls, e.g., hosts support RDSEED but do not support RDSEED-Exiting.
>
> In detail, commit 4a910e1 introduced a flag `has_msr_vmx_procbased_clts2`.
> If KVM has `MSR_IA32_VMX_PROCBASED_CTLS2` in its msr list, QEMU would
> use KVM's settings, avoiding any modifications to this MSR.
>
> However, this commit (4a910e1) didn't account for cases in older Linux
> kernels(<5.3) where `MSR_IA32_VMX_PROCBASED_CTLS2` is in
> `kvm_feature_msrs`-obtained by ioctl(KVM_GET_MSR_FEATURE_INDEX_LIST),
> but not in `kvm_msr_list`-obtained by ioctl(KVM_GET_MSR_INDEX_LIST).
> As a result,it did not set the `has_msr_vmx_procbased_clts2` flag based
> on `kvm_msr_list` alone, even though KVM maintains the value of this MSR.
>
> This patch supplements the above logic, ensuring that
> `has_msr_vmx_procbased_clts2` is correctly set by checking both MSR
> lists, thus maintaining compatibility with older kernels.
>
> Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
> ---
> In response to the suggestions from ZhaoLiu(zhao1.liu@intel.com),
> the following changes have been implemented in v2:
> - Adjusted some punctuation in the commit message as per the
>    suggestions.
> - Added comments to the newly added code to indicate that it is a
>    compatibility fix.
>
> v1 link:
> https://lore.kernel.org/all/20230925071453.14908-1-ewanhai-oc@zhaoxin.com/
> ---
>   target/i386/kvm/kvm.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 11b8177eff..c8f6c0b531 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2296,6 +2296,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
>   static int kvm_get_supported_feature_msrs(KVMState *s)
>   {
>       int ret = 0;
> +    int i;
>   
>       if (kvm_feature_msrs != NULL) {
>           return 0;
> @@ -2330,6 +2331,19 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
>           return ret;
>       }
>   
> +    /*
> +     * Compatibility fix:
> +     * Older Linux kernels(<5.3) include the MSR_IA32_VMX_PROCBASED_CTLS2
> +     * only in feature msr list, but not in regular msr list. This lead to
> +     * an issue in older kernel versions where QEMU, through the regular
> +     * MSR list check, assumes the kernel doesn't maintain this msr,
> +     * resulting in incorrect settings by QEMU for this msr.
> +     */
> +    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {
> +        if (kvm_feature_msrs->indices[i] == MSR_IA32_VMX_PROCBASED_CTLS2) {
> +            has_msr_vmx_procbased_ctls2 = true;
> +        }
> +    }
>       return 0;
>   }
>   


