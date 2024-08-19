Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6CEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 13:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg21i-0001sl-HN; Mon, 19 Aug 2024 09:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1sg21N-0000jK-Bx
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 09:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1sg21L-0005vL-ED
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 09:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724072521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CQ57VPFhj0J7dTLtPr/fFqy6l9Ee5cMcJ/yzr5U87U0=;
 b=fQTNtZf6x3da+acyWIrK7q7qni90kCHEHdx9NJISYTQNgzsnKon+30XUc0AUr3gY6bm+qc
 TCyarK6DKnbB7nZjis7UwDmDymCG7bqNULqQdV6LI+u+KXhXeDxDNRKd3Dfz9axV3ccZ2Z
 g1uFaWNq5AQNy3dvQTNNzckHyUWSv2Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-x_53zHMkPnSqXP2C8WMdxQ-1; Mon,
 19 Aug 2024 09:00:11 -0400
X-MC-Unique: x_53zHMkPnSqXP2C8WMdxQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAF951955BEE
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 13:00:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.126])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A40C330001A1; Mon, 19 Aug 2024 13:00:08 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Jan Richter <jarichte@redhat.com>
Subject: [PATCH] hyperv: Make sure SynIC state is really updated before KVM_RUN
Date: Mon, 19 Aug 2024 16:00:06 +0300
Message-ID: <20240819130007.33088-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

'hyperv_synic' test from KVM unittests was observed to be flaky on certain
hardware (hangs sometimes). Debugging shows that the problem happens in
hyperv_sint_route_new() when the test tries to set up a new SynIC
route. The function bails out on:

 if (!synic->sctl_enabled) {
         goto cleanup;
 }

but the test writes to HV_X64_MSR_SCONTROL just before it starts
establishing SINT routes. Further investigation shows that
synic_update() (called from async_synic_update()) happens after the SINT
setup attempt and not before. Apparently, the comment before
async_safe_run_on_cpu() in kvm_hv_handle_exit() does not correctly describe
the guarantees async_safe_run_on_cpu() gives. In particular, async worked
added to a CPU is actually processed from qemu_wait_io_event() which is not
always called before KVM_RUN, i.e. kvm_cpu_exec() checks whether an exit
request is pending for a CPU and if not, keeps running the vCPU until it
meets an exit it can't handle internally. Hyper-V specific MSR writes are
not automatically trigger an exit.

Fix the issue by simply raising an exit request for the vCPU where SynIC
update was queued. This is not a performance critical path as SynIC state
does not get updated so often (and async_safe_run_on_cpu() is a big hammer
anyways).

Reported-by: Jan Richter <jarichte@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm/hyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index b94f12acc2c9..70b89cacf94b 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -80,6 +80,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
          * necessary because memory hierarchy is being changed
          */
         async_safe_run_on_cpu(CPU(cpu), async_synic_update, RUN_ON_CPU_NULL);
+        cpu_exit(CPU(cpu));
 
         return EXCP_INTERRUPT;
     case KVM_EXIT_HYPERV_HCALL: {
-- 
2.46.0


