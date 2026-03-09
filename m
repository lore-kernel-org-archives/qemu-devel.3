Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54B0FCA19C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzjA7-0001SO-HR; Mon, 09 Mar 2026 18:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3p0qvaQQKCk470y7w44w1u.s426u2A-tuBu1343w3A.47w@flex--rkir.bounces.google.com>)
 id 1vzjA5-0001SA-QE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:33:17 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3p0qvaQQKCk470y7w44w1u.s426u2A-tuBu1343w3A.47w@flex--rkir.bounces.google.com>)
 id 1vzjA4-0000ua-8y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:33:17 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c739120475fso2798642a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773095592; x=1773700392; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/jEOSZqXvX7oqb37NNn2BCpc9o7sCwjr2f+SOIOx/JE=;
 b=YKsRtNoG38OXml/HjBAelvrElO2O2qmpJqlb1xFrBBciIqE7A2yrIFQ8DGXKSMYKxu
 2oALm4gUXovPKUbnOe/uKfyC0pXsDGUxkLMAU6fshCYss+R+NTsjQLLKCGPoqASh7Vll
 wUJuwL23hsrQEwrMtnIQEb6bUs4qFvMzY+AfBHP7rcu3fwslD65ijoKMNwCtwnNdOhT/
 40UtJLT6N8sApFo70AXgy6KKSDMcXvh1A6DTEltc9z3FAVt+o6f3on1Vo3O2Ml/3uJOr
 GB+a7fNCuhQpbBzgED7Ou1W1rlbfK0YXdaNGQS2YlCl5rLaXDfhgt+YZvq+KI7YFJKHp
 siXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773095592; x=1773700392;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/jEOSZqXvX7oqb37NNn2BCpc9o7sCwjr2f+SOIOx/JE=;
 b=DpeLxGhT+JQJXR6EkIfoPmY5EWn6D0Opp3GSMyOpyAOFbjo8lBGrwUILr/HwhsmqO7
 8zcgP/quLCHFnonJh/ZGBfcKeCSpbP8GTQjkQJqDIyVtgA6GvE+TxIjXQDaMNGdx0olx
 B3hs/JSPhMrvrpNeyEtudcXfPgtBtAoDie+JbBlvwM1d11ERPhZY6gu5VTX0koeHkqAe
 YMg1w0QejCIKa4zZ0MiwjjVHBPWzWfK3J3Ij6FnPnCjLqQKE33dzVx4R52DOTwMoKXk/
 NJAIGTJ/D0qXCbCR4k7gWNFa1uiK+5tqgNHbKtmHX9tOuliE2d846fkZpsoZkyysjbhZ
 B2lA==
X-Gm-Message-State: AOJu0YyvTKEQ2TOzvkyDK8UZEXSbYA2IXgbKutQ3js6fa2+ZwmIj/6ZH
 yfw1RrQKrs3Kig9BkA8d1UQDEvN2llc+nIao37tdbJ9tWmJIy+Qhnw7EYKNG2864GHdXE6THoQ=
 =
X-Received: from pfbmy12.prod.google.com
 ([2002:a05:6a00:6d4c:b0:824:b235:888c])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:7701:b0:824:a8f2:7de7
 with SMTP id d2e1a72fcca58-829a30ca97emr8188474b3a.60.1773095591794; Mon, 09
 Mar 2026 15:33:11 -0700 (PDT)
Date: Mon,  9 Mar 2026 22:31:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260309223116.3233668-1-rkir@google.com>
Subject: [PATCH] vmstate: assert that VMStateDescription::fields is not NULL
From: Roman Kiryanov <rkir@google.com>
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com, 
 jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3p0qvaQQKCk470y7w44w1u.s426u2A-tuBu1343w3A.47w@flex--rkir.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The vmstate_save_state_v() function does not
support NULL in VMStateDescription::fields
and will crash if one is provided.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 migration/vmstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4d28364f7b..5cb173ea25 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -433,6 +433,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
     ERRP_GUARD();
     int ret = 0;
     const VMStateField *field = vmsd->fields;
+    assert(field);
 
     trace_vmstate_save_state_top(vmsd->name);
 
-- 
2.53.0.851.ga537e3e6e9-goog


