Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAA1C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfmK-0001if-4m; Thu, 13 Mar 2025 06:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsfmD-0001hD-ML
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:26:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsfmB-0003E9-Gj
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741861613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZPElpu3XonC/2Dj+bha+vi8Ozhn2t3cwzD18wNczoHg=;
 b=YooVfZbtiuoPv3OUuFwL/tN6U1QvJ5r6QeHIgX1Kyn/z+FtntRyLCB2v7weYGJdl8EQB6t
 s+VEPHulucAtTLGBSB/1xVNazWT4NHsWAlNI+VTvo/gYBET9corhyOtKunY7DP15G34W2P
 VkBXGPzkRLk1KS8iPLCS0vRVwHzgHLo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-6MxFWrWuN4yw8PiwkOmEfw-1; Thu,
 13 Mar 2025 06:26:51 -0400
X-MC-Unique: 6MxFWrWuN4yw8PiwkOmEfw-1
X-Mimecast-MFC-AGG-ID: 6MxFWrWuN4yw8PiwkOmEfw_1741861610
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9612E1956048; Thu, 13 Mar 2025 10:26:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EEE4300376F; Thu, 13 Mar 2025 10:26:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A7D7821E675E; Thu, 13 Mar 2025 11:26:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] target/loongarch: Return directly when detect KVM
 disabled features
In-Reply-To: <20250313091350.3770394-2-maobibo@loongson.cn> (Bibo Mao's
 message of "Thu, 13 Mar 2025 17:13:48 +0800")
References: <20250313091350.3770394-1-maobibo@loongson.cn>
 <20250313091350.3770394-2-maobibo@loongson.cn>
Date: Thu, 13 Mar 2025 11:26:43 +0100
Message-ID: <87a59pb50c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Suggest something like

  arget/loongarch: Fix error handling of KVM feature checks

That way, the nature of the patch (it's an error handling bug fix) is
obvious at a glance.

Bibo Mao <maobibo@loongson.cn> writes:

> For some paravirt KVM features, if user forces to enable it however
> KVM does not support, qemu should fail to run. Here set error message
> and return directly in function kvm_arch_init_vcpu().
>

Please add

  Fixes: 6edd2a9bec90 (target/loongarch/kvm: Implement LoongArch PMU extension)
  Fixes: 936c3f4d7916 (target/loongarch: Use auto method with LSX feature)
  Fixes: 5e360dabedb1 (target/loongarch: Use auto method with LASX feature)
  Fixes: 620d9bd0022e (target/loongarch: Add paravirt ipi feature detection) 

> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  target/loongarch/kvm/kvm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 28735c80be..b7f370ba97 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
   int kvm_arch_init_vcpu(CPUState *cs)
   {
       uint64_t val;
       int ret;
       Error *local_err = NULL;

       ret = 0;

Please drop this assignment, it's useless.

       qemu_add_vm_change_state_handler(kvm_loongarch_vm_stage_change, cs);

       if (!kvm_get_one_reg(cs, KVM_REG_LOONGARCH_DEBUG_INST, &val)) {
           brk_insn = val;
       }

> @@ -1091,21 +1091,25 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      ret = kvm_cpu_check_lsx(cs, &local_err);
>      if (ret < 0) {
>          error_report_err(local_err);
> +        return ret;
>      }
>  
>      ret = kvm_cpu_check_lasx(cs, &local_err);
>      if (ret < 0) {
>          error_report_err(local_err);
> +        return ret;
>      }
>  
>      ret = kvm_cpu_check_lbt(cs, &local_err);
>      if (ret < 0) {
>          error_report_err(local_err);
> +        return ret;
>      }
>  
>      ret = kvm_cpu_check_pmu(cs, &local_err);
>      if (ret < 0) {
>          error_report_err(local_err);
> +        return ret;
>      }
>  

Recommend to

>      ret = kvm_cpu_check_pv_features(cs, &local_err);
       if (ret < 0) {
           error_report_err(local_err);
  +        return ret;
       }

  -    return ret;
       return 0;
   }

Why?  Have a look at commit 6edd2a9bec90:

@@ -793,6 +828,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (ret < 0) {
         error_report_err(local_err);
     }
+
+    ret = kvm_cpu_check_pmu(cs, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+
     return ret;
 }

The new call broke the previous call's error handling.  Easy mistake to
make.  Less easy with my version.

With that
Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!


