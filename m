Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D512CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY9f-0002Uz-MA; Tue, 13 Oct 2026 04:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4T-0001JS-Gw
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:17 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4R-0008G7-C0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1512533f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880874; x=1792485674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H+1SIPr+/cnH/YAjnVN8m/hIlWQogWqNOztypjX89Kg=;
 b=SEsfp1/ptSNOo8rGY96Te1Ojp7XtidMQuDVXL5EHOYogacTNcCWcTg5P0pJdJ3mrfT
 7h7BNjNmmvsNPLq0kS/PT7JFDpuasllQCCOfAonDgozN1XdIwvmKKZbLteSKEKU4Eyc3
 sgFfuTcabWSSOm76ROVZclH709Cj4XQyOVMmDjJBtQib2Ek05YY7QT9sqlvJaA2oVXDF
 skWJfzq4cHrkBftODu39Uu/6EXVmNApZhLhcnbbfNDabk7O5cN1Ll9B896N+CR9umqzi
 c1eYRJBJ+S9q5sQvkq3/hb/5aSBMaxlszFgw8Iz8V9zVTUsrJsTUdxftR2qFmDt44Dwd
 W5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880874; x=1792485674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=H+1SIPr+/cnH/YAjnVN8m/hIlWQogWqNOztypjX89Kg=;
 b=d7HgzpeVkk6enw/ddh/C0tdS5AlKJ0O+wuNMXHpE/Cqn3UVVSfwuiU/QqZfqj1yM2b
 37LLypetIrvcStGsyCxxoxa5QmOoe8HVnRRA2aRgyVpHIuwFho3cqC9zOKyfeeONYPVP
 bA8Vnx6UB3AemveT4mtkmHQ8THeshQo/i1NxkKezDo2KfaPkyrmlRB8JNp3JUzA0I/Cd
 ivRnkqMOjsV47dH8USFeqqR6/BYyHXRcGbp/L9krJvOHpFDgdST1433cBSD0QhTalnEv
 ndmOVndLK9koJiFJ9w5q1/nKiEXgxkvmawf8haa1EUFcLNi0Z2cwUoTO851S/Oo1KyUK
 xpeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByp+UzHszR3khqX20q2PZe1s6Wzqc8te5NS/TEmmUCXC6XOq2DaSgjonZOw7mmhxvQVk8j2aFaEZgQj@nongnu.org
X-Gm-Message-State: AFq9FYLMeNgNtPYt8wENKS7B7fkgkxLqM1W1dkS/4LIruXZM/8xiqimk
 SJqrjD8Fxd/uyRqQjDDbQFjfuU3ZVB0EWfytvxhcxd0wfbvlRKsH1rAzrTyqgMwTlJ5QXuDLBeq
 YUIqtWyk=
X-Gm-Gg: AYBFou0QAa8whXJskX7whEDY1u0cipiOuCsdmJ/4XNF0eV2Zo2bjgll7m/64VvoTam/
 4jGOSHlOZU1jtZUTNhzPUuLfEUTTwu2cLk6l11CaNJcjXkTz1+YeetskY99A75QyKSvZQPk4phP
 VDAvQ18ZBX+r5NskKmvS5mpyNrnWqTlp49KgPk/HeI+8IbNK6pZdw6Cq5BTG514ihqvGIombTzo
 OrNdpLqvihXlS0nilrk95B9lgSfiAOFWhlVjBBS+T7w+JdIch7C49H/GJS6E3p+DGHWBpdp+5/O
 ZZBJZ4sNtGqdAp0V5iSrhrtw1De/rJ5mjYD4msK80eIDDyx+g6U+NQAReuQCai8CyAm7PCri+Zy
 3eJUmJt/Wr5ZLKD/0BE9DeZaoOuYeKbZHXikqondreavCPZJK8Cz9GAWMacDLt7+VsQ/6Yg7JHk
 CmwuSDMznYU3jHy3hRdmuBYXs8NBSSJVnZarHqhzqmQdKFEU1D73hdjlBslRyYmbAst6roU2ugA
 s6RvXhvPYCmDWUezRssrtqnFctn+DebWeAoOS1tt+RD0gp5WREdjqSG/vdecZxkdq+l+j9kYL7G
 s7g=
X-Received: by 2002:a05:600c:46c5:b0:4a1:78c5:79f5 with SMTP id
 5b1f17b1804b1-4a18e4d6b28mr236081095e9.33.1791880873732; 
 Tue, 13 Oct 2026 01:41:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 76/86] hw/intc/arm_gicv5: Handle virtual=true in
 gicv5_request_config()
Date: Tue, 13 Oct 2026 09:39:23 +0100
Message-ID: <20261013083933.1024405-77-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Support returning the config of a virtual interrupt; as with all the
config-setting functions, virtual interrupts can be dealt with
similarly to physical LPIs, just searching in a different IST.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 39c96fe0526..8f4d44b2b37 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -994,9 +994,19 @@ uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
     uint64_t icsr;
 
     if (virtual) {
-        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_request_config: tried to "
-                      "read config of a virtual interrupt\n");
-        return R_ICSR_F_MASK;
+        const GICv5ISTConfig *cfg = ist_for_vint(s, cs, domain, type, cpuidx);
+
+        if (!cfg) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_request_config: tried to "
+                          "read config of unreachable virtual %s %d\n",
+                          inttype_name(type), id);
+            return R_ICSR_F_MASK;
+        }
+
+        icsr = l2_iste_to_icsr(cs, cfg, id);
+        trace_gicv5_request_config(domain_name[domain], inttype_name(type),
+                                   virtual, id, icsr);
+        return icsr;
     }
 
     switch (type) {
-- 
2.43.0


