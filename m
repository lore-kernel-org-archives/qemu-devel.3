Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21262E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxm-0006Hb-M9; Sat, 27 Dec 2025 04:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxj-00065o-Lh
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxi-0007XN-0c
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0o903Dc2qu1dTRcXlXDrKlZDWfP3LsB5Y748CsL1HI=;
 b=VD3xolqRKIGZkW1MNEws0C8A6zqNiQdoxG+X2upJEYfDyCQZ8ZnUKHCxg14NlmZudm3IxA
 WzRRfknBQScrzAB/TEc83/ULqiBTmfYqg5uFdx5ygsiA/aXqHyrLDISx19x4lVFXetqnH6
 H6vGOZghci/xEj+fdj4dGdimqMwNIO8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-jW6IK-0sM1a04RHTtYFvOg-1; Sat, 27 Dec 2025 04:51:47 -0500
X-MC-Unique: jW6IK-0sM1a04RHTtYFvOg-1
X-Mimecast-MFC-AGG-ID: jW6IK-0sM1a04RHTtYFvOg_1766829106
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4325cc15176so3163262f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829105; x=1767433905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0o903Dc2qu1dTRcXlXDrKlZDWfP3LsB5Y748CsL1HI=;
 b=bGb6KU8mz1xqTgQhKwWdoHo3+IK6htzf+li29dLNgdICw16jxxojYWD1taGkgYdPUZ
 scYOqepPrUVAqF57YMcZroEcKQHS+5heInzl0Ey04azZ9q24hyaRxrWwCALMsAr4jG82
 cAED1ZAcXefLeRb7EwYjOKEKuqucAtsMj9ii9sztCYcE0fBJoATDXsfrw2pXj7We1sDB
 z1hnfV+p75yTYKPuOZZiaYWQswlEV24vwsYVNOez+ntIuKKouhqxvOkmZamZA6x6JFco
 it/CyoJRdm4p45YuC2Z+VVCfhMCGYIShHTGKYpMsabZsm+eyDZxOZsx13ZOo8hqKDZ5z
 8J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829105; x=1767433905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z0o903Dc2qu1dTRcXlXDrKlZDWfP3LsB5Y748CsL1HI=;
 b=gNQS39ctZgWOd3Ye2Hryom6yHL9ZiDZFZeO+CroO1bGsAjS/Cku9SaykFBa/ahWMtq
 +ACZS/z9rv+K5l3e1gYs8zQLeVfXKMzYFgPiFzL5UnnHBnc6GwNljMsLxlOBWaO6nbxP
 o6ZSs/2C7HU4ZNLQaw6RUp8qXFS9KpfTlS4g4nmjV7GBTbe2qc8GS+ZgSbXaMriQY7Nu
 QFB/Nn9rRcNgfTMxR+QoabQwNUhHY03HH8lvviAdwAD9peeU+YdfuryKftFWT0SRj0oh
 qmpW2UlKrE7SMz44KBWoNod1h8FAV3DeQW/f1BIuL7ju8S7tY7Eax38lL6LfC0bTHHzf
 tu3w==
X-Gm-Message-State: AOJu0YxU7oD5csn5gXzKStTmZ7+kNjhzFrjn2mWhRrDkvVOeABLYItK+
 hvMKrtIczCFQ3uHFJh1KJrgvc+0k/FxSVEd61FbHGn/PrWg09SvG/8CnDuYbre66jHf72bR+tZl
 9YR94S2Jl6RmKvOckFTn0ySohIkwPxt6kTdaJP13UrnlanWpPZ4y+7kkDTpnF3R/ujxUBwM1dSW
 QrbmKm/cVGIjvbwxQBkuKItNNPZMrSXXkz1nHMJG5U
X-Gm-Gg: AY/fxX4Cm/G4odAewaTC1YJ/NZSqb56SET/3j9JU/vvyfw40q8ldqOaRG2sg8cb4pXK
 BSMX/xeDJo/iF8+VV5DzFB9lCE/DQ9mvZPJjqzt8nr/LsyS3mZZRw4oEQszxowkThpdXG3WhWyr
 iI0d/3m24tnJwlrJ4rxogrweiEE3hvxEYL4todbzp6nCbJ0R1QxlS6U728kqqysP3rfr4BavSfm
 HnmIOchkUb4ZNZ0++G3Pvo6lX5w2y/hGl6VHloqEmzES3tMWuJFM91h4cAfz4Z4iK0Wb8wFmdxB
 MnSnvcUP5DME4GgiJtD9aPHbS0o2KfLGwygOglQ/AZQk86mXdM4LAhFIQzJzYVUzUVgCmnCB6G9
 FqFfihaKUNZLiQm9B/RZPLI3gyE/2Z19P/KDWp4bcO3VAc99SO/VQfk1pSH79/uaszQ2REi1brr
 vSnBsV6TopUjzNOh0=
X-Received: by 2002:a5d:5f51:0:b0:429:ba48:4d8 with SMTP id
 ffacd0b85a97d-4324e4d27b3mr32374534f8f.25.1766829105544; 
 Sat, 27 Dec 2025 01:51:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBUaRu73ct84RjgxYRULxBvA7yHcq9pISyCGPzNs0toPA/ZR4Q9osS2P8d6LNVVN8t1BlXYg==
X-Received: by 2002:a5d:5f51:0:b0:429:ba48:4d8 with SMTP id
 ffacd0b85a97d-4324e4d27b3mr32374511f8f.25.1766829105162; 
 Sat, 27 Dec 2025 01:51:45 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82f6asm51627902f8f.27.2025.12.27.01.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Marc Morcos <marcmorcos@google.com>
Subject: [PULL 148/153] qmp: Fix thread race
Date: Sat, 27 Dec 2025 10:47:53 +0100
Message-ID: <20251227094759.35658-74-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc Morcos <marcmorcos@google.com>

This fixes a thread race involving the monitor in monitor_qmp_event and monitor_qapi_event_emit .

Signed-off-by: Marc Morcos <marcmorcos@google.com>
Link: https://lore.kernel.org/r/20251213001443.2041258-4-marcmorcos@google.com
[Use QEMU_LOCK_GUARD and "continue". - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/monitor.c | 8 ++++++--
 monitor/qmp.c     | 6 ++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index c5a5d308774..1273eb72605 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -346,9 +346,13 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
         }
 
         qmp_mon = container_of(mon, MonitorQMP, common);
-        if (qmp_mon->commands != &qmp_cap_negotiation_commands) {
-            qmp_send_response(qmp_mon, qdict);
+        {
+            QEMU_LOCK_GUARD(&mon->mon_lock);
+            if (qmp_mon->commands == &qmp_cap_negotiation_commands) {
+                continue;
+            }
         }
+        qmp_send_response(qmp_mon, qdict);
     }
 }
 
diff --git a/monitor/qmp.c b/monitor/qmp.c
index cb99a12d941..e1419a9efa3 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -462,8 +462,10 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
 
     switch (event) {
     case CHR_EVENT_OPENED:
-        mon->commands = &qmp_cap_negotiation_commands;
-        monitor_qmp_caps_reset(mon);
+        WITH_QEMU_LOCK_GUARD(&mon->common.mon_lock) {
+            mon->commands = &qmp_cap_negotiation_commands;
+            monitor_qmp_caps_reset(mon);
+        }
         data = qmp_greeting(mon);
         qmp_send_response(mon, data);
         qobject_unref(data);
-- 
2.52.0


