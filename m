Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4ACFB5EAB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mKl-0000rU-Iy; Wed, 18 Mar 2026 04:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2mKf-0000qI-Lo
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2mKb-0001mn-UT
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773822765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJH5hmtoWXtvQeN49h267jukyNNYmOsCxNzFF7k3ujg=;
 b=VdyWgzV6LngnsAZRsI29q7lU/xWTzO/LCf3OxUqlz55X7m78XlQXSIVLOREZQ1JXrenixT
 VqVkOYEP80vzObtoiZP5/KJNt2WqmIIXCcM+xN/hfQXNXZ8pwlpQa4z/gKJryoyS6lfmp1
 GSmtD4MQ3/n9ut6zDRo35rt1EA0ADfs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-FqaKp-NzNIWjJ4MCjzc0nA-1; Wed, 18 Mar 2026 04:32:43 -0400
X-MC-Unique: FqaKp-NzNIWjJ4MCjzc0nA-1
X-Mimecast-MFC-AGG-ID: FqaKp-NzNIWjJ4MCjzc0nA_1773822762
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853b00f9f5so69516195e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773822762; x=1774427562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJH5hmtoWXtvQeN49h267jukyNNYmOsCxNzFF7k3ujg=;
 b=RbvnahOcq24XD4UZ7f0I3xj+UQRZukwqMCyTxW+0ZkJEuSMWnUdE9YyylMHhc9BRp5
 v4douMoQOEvo7zXIpYCedQDgOTiwpVz5mnJXDBhVl/3Hee+AdNeNND5l0OGXp9j0dCG5
 /DWOBzSupafCFnRnuyGXUB+72xoias95e98ClWqiXeuwqlJM3xUm+hS7MgcNk+x5iY68
 aKjinn5iF4UlJT5fiascgEPJFGV7FYXnZs9r/mViMCxL4PoPKtKTS1eUgVpim1SKxPiw
 lFDNiQS4E7Wmfs8nWWk8LKzhbEcdPQmBoNuLbyi5jGQIg/jjbofIBBVUs5CvK8KBG67J
 hGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773822762; x=1774427562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TJH5hmtoWXtvQeN49h267jukyNNYmOsCxNzFF7k3ujg=;
 b=JMlto1lBliglkLLGWTeDoY/0d8WuesCf8nr1EgZyqmP6rfhGo8JIZ87lBew44rZIbP
 0Mp2xgCUU+way76T9o8a0HjNNW0dzykq2tp207GdZjE3Zapa/5PIE2Rbj2jYBMxmm4HP
 RnTUSuRWix16teL6x9kENpAffuzFuzgJ3pWa8tXxUOl9+kJa/TbXfpP+7GTNFAduk4Ot
 uD/7aYsZD4FppU9/qH0ykaMfaYtAQ143Ti/LpBTmU9Frj5z2hM4qoxgrffPAen4HuNqE
 CcGE7EpLLF7prO9H0aiH6XpE1+wmRK2a34F+r2TMl5+Bvrauo5bFk+ma4zzhZcEER50M
 Gj0Q==
X-Gm-Message-State: AOJu0YzIPsRxbNI+2G+XVw4wXcAcnytWllbrGwibFHhXdzQzOzRLZ+O7
 TZuCGN/+tWv+NkXri0fRqRLIupYf7jjZfDR/++jej2DVzLxxyJkj9QkIJ1DWnKv5G9EQusw8uIk
 Y6az09LW5ufedE452lcl30bCyFlIyhNF0gI8EzRakP7gslA0JPTWsVf4ttSxrmGov1D7//DroRy
 ex8yqG8IoMV++3/6gJKD/LwFfXGrijUokuRX41nBzV
X-Gm-Gg: ATEYQzzTT1hW4JtSTKURkBpA0PHmG+3kUVUNzeTJoq+9A2HHKPJINNd0zB7zciXvVFX
 YcHe1Jn0PgZVWv4EIovrDqQ+EOxfoerrNwRzVa57B+l98HVTw6Qz9+Y6YABbfkmuIyN52bJiGjD
 D44eY/oGpD5pl5DVjHnoc5F7B3L6nBk8hXvLPrWJQDdlBV1/MakAi+JE1FtwlBMgHDWYZAEkbWs
 WFT4hz+St445BWgEihp7CK9ZzmyMgEJt0+5+V9qWs993A9wx/0EVZ8MS+i7wDGQ7MmomKT5uORN
 Sr/fyCRenrzSWlzap0nsRXC0GfJba+kFvoYpnhF7W6TYwLpiLuIWoc502tEuHDEHfKJoIDKRU6E
 BFPWgXbRt07pSmtll8T4Edtbhn4rZnjbaQJsORB0v0bndQcu/lZIYiPL7UQofd50eRn1QaHOMUU
 U/MjVyG+biRqPKegiblAdp5QkxYLg=
X-Received: by 2002:a05:600c:3b28:b0:485:3aa1:a7f1 with SMTP id
 5b1f17b1804b1-486f441bc51mr41879055e9.7.1773822761575; 
 Wed, 18 Mar 2026 01:32:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3b28:b0:485:3aa1:a7f1 with SMTP id
 5b1f17b1804b1-486f441bc51mr41878375e9.7.1773822761020; 
 Wed, 18 Mar 2026 01:32:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ec4c9f3sm114138005e9.0.2026.03.18.01.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 01:32:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 1/4] runstate: handle return code of EOPNOTSUPP properly from
 rebuild_guest()
Date: Wed, 18 Mar 2026 09:32:35 +0100
Message-ID: <20260318083238.1132609-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318083238.1132609-1-pbonzini@redhat.com>
References: <20260318083238.1132609-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

If rebuild_guest() accelerator callback returns EOPNOTSUPP, this means that the
accelerator does not support rebuilding the guest state. Handle this case
properly and separately from other error return codes.

Fixes: 4003e5e65fe0("hw/accel: add a per-accelerator callback to change VM accelerator handle")
Reported-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260310094450.35861-2-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/runstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index 77cb14ae028..2d4e95a2166 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -531,10 +531,12 @@ void qemu_system_reset(ShutdownCause reason)
         (force_vmfd_change || !cpus_are_resettable())) {
         if (ac->rebuild_guest) {
             ret = ac->rebuild_guest(current_machine);
-            if (ret < 0) {
+            if (ret < 0 && ret != -EOPNOTSUPP) {
                 error_report("unable to rebuild guest: %s(%d)",
                              strerror(-ret), ret);
                 vm_stop(RUN_STATE_INTERNAL_ERROR);
+            } else if (ret == -EOPNOTSUPP) {
+                error_report("accelerator does not support reset!");
             } else {
                 info_report("virtual machine state has been rebuilt with new "
                             "guest file handle.");
-- 
2.53.0


