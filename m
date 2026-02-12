Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C58EDF045
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQAJ-0000Ai-0R; Thu, 12 Feb 2026 01:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9x-0008DE-V7
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9w-0005Ic-0T
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6P5ZMHhQ1gBULl+0OpCFy+J1BWjsvb7Pt0GdIxytUuE=;
 b=aslgK+0MHk5X4bse6+AQL0+yKKzAGrfvpX3a14A2oWKp8taswV4nU6yVLgoR6Me9TvEXgC
 /gI/2/jcBTyQfNO9jIbAShvslYpZIWGcLwn/8WyeOCS9j+YFRdWW+dVlwxCtoKG3RIpw7+
 r6GRsOUwgRJ+tLhFBp4YGVkNsm+W+ys=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-Jpk5HuFOOBGG-MpYLcLVmg-1; Thu, 12 Feb 2026 01:26:36 -0500
X-MC-Unique: Jpk5HuFOOBGG-MpYLcLVmg-1
X-Mimecast-MFC-AGG-ID: Jpk5HuFOOBGG-MpYLcLVmg_1770877595
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35301003062so17083099a91.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877595; x=1771482395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6P5ZMHhQ1gBULl+0OpCFy+J1BWjsvb7Pt0GdIxytUuE=;
 b=s1jOxxPnJbG5GNG9fvGTgqG5FcY35bgemKJL9nUY/S287HWbVThwMYsKXyPNbHWXlc
 xFLcIBqcuImrDr5f6OKOaoz1Cr9q9b+AMQWyB2afMjUfmH+TQuBhVShUdk/PZqS1NeyU
 +aDlso9iJI3g2RHEAsVKwuXkK1Ckt7bqPLsuVsefxW/VWQD5A3io66GZ6pddYg/cLuEe
 tMnhL3kuzb1kf6bNUVC03XGrvJUtcObxCUNv18Qo9ApdtvcGmltNK77x/C0gUQBuo/Ap
 VCbx12bDI60eaZf65xpNyERaBKx9BatzGpG7Yn4+MhiV7sedyVsVZ5UX3dDjZ1bwCKaf
 o1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877595; x=1771482395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6P5ZMHhQ1gBULl+0OpCFy+J1BWjsvb7Pt0GdIxytUuE=;
 b=dT2mmCJGM5Kaql+qhWhrTSNvqN3g1I/Xq8EhCaWV/y8V8r+K0gEruNLKCqVDrGBByk
 zkHv8rZH5UeJo1UBkmnE24+KEqBPb21sjY+JCLSszphsBQdPEVKugpKi4HidAGekbmQ5
 5140B6oGgFyXzbQw8YP/80z0BUMBO3m/5g3vs7agiXnxfu9N8sJpXlJzB+Zhgc95slr+
 Vfse24ESs/lPE3atVsFLlVlxAE7IuI32KkyfdZF0n55kx+iGLQp3R9fNmnKHRCLAdH25
 DNZUFb7hY+Bz5epzqcrcjKKiCjAtmYyLCkbQdaTF8zD4P+7e/96p5rvQ/+01kHfNLhZN
 fmiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4E4V+lBajTimKkuJvUyCTTLRv6+HOY2AY7MeLNLRJ62XLGvh2HuQiG2lxbr//BJwB4SB1GkT6GVC3@nongnu.org
X-Gm-Message-State: AOJu0YyzBaP6yYmKuKPtv+DGaPj4Ul0p81Pzgp0Pic3GUuSXuC5GNzLM
 fB1IefyB8tC+84qrgwkIh1g6vNWhgY2ToKVzmF0qd1JYXtHGxwyYf1VC8y9At3VDr5cWXnAtx7+
 t1Mx0cyJ+GNC5NhTsUkUloRcbWPI+iGRg5uGfiVrL4EpJCahjXeOz8cBr
X-Gm-Gg: AZuq6aLq+Way1OCiGjoHt7ebaFKXBwXjftOhAvp4ZUyLGqIj0AorT5eGWj1etKiETnN
 MBOJmU9RdyN3L5dDRsC3QVTmlNLws45uC/5sd0zISNqvHtuh1NZzX2xfKNVLU7z69wI2fisYyhC
 1jL99iMUQ95qKa8XCtvG4dec3ztfaNMEzhAew8QSvjFTf2c2g3w32JOG0haq9MSCnWYJk8sX9oG
 Z4ZSQdb1+uWKICD5d+A1DBWZ3HLhmG0WIsqBHdGcXEXFDC1BqitbBCbToOP0nd9abWyaWxbZU4C
 hOSB4J0l6prqqDpJB95OtBXUHsgpVlBEZYvKFFxfghWWbMIn2M91E2G+6RMM9SDiz+sTQ1Q5w+p
 b8NMJeMiG/puGQTxUAePhUplW+toCVFoy6Irtqmq4q45SJqN4yKdcPi4=
X-Received: by 2002:a17:90a:d887:b0:356:72f3:acaf with SMTP id
 98e67ed59e1d1-3568f525fd2mr1628237a91.32.1770877595003; 
 Wed, 11 Feb 2026 22:26:35 -0800 (PST)
X-Received: by 2002:a17:90a:d887:b0:356:72f3:acaf with SMTP id
 98e67ed59e1d1-3568f525fd2mr1628229a91.32.1770877594670; 
 Wed, 11 Feb 2026 22:26:34 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:34 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 19/31] i386/sev: free existing launch update data and
 kernel hashes data on init
Date: Thu, 12 Feb 2026 11:55:03 +0530
Message-ID: <20260212062522.99565-20-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If there is existing launch update data and kernel hashes data, they need to be
freed when initialization code is executed. This is important for resettable
confidential guests where the initialization happens once every reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 647f4bf63d..b3893e431c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1773,6 +1773,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
+    SevLaunchUpdateData *data, *next_elm;
     SevCommonState *sev_common = SEV_COMMON(cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
     X86ConfidentialGuestClass *x86_klass =
@@ -1780,6 +1781,11 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     sev_common->state = SEV_STATE_UNINIT;
 
+    /* free existing launch update data if any */
+    QTAILQ_FOREACH_SAFE(data, &launch_update, next, next_elm) {
+        g_free(data);
+    }
+
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
     host_cbitpos = ebx & 0x3f;
 
@@ -1968,6 +1974,8 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     X86MachineState *x86ms = X86_MACHINE(ms);
+    SevCommonState *sev_common = SEV_COMMON(cgs);
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
 
     if (x86ms->smm == ON_OFF_AUTO_AUTO) {
         x86ms->smm = ON_OFF_AUTO_OFF;
@@ -1976,6 +1984,10 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
+    /* free existing kernel hashes data if any */
+    g_free(sev_snp_guest->kernel_hashes_data);
+    sev_snp_guest->kernel_hashes_data = NULL;
+
     return 0;
 }
 
-- 
2.42.0


