Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15F6FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV80-000142-6l; Thu, 30 Apr 2026 13:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7v-0000fL-9L
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7t-0004vO-K7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pll79ubvj2WY+vR4reNM8nqRiqCLK9Som46Z/qrJjIE=;
 b=F0Fx1U1HIRzIzvNM6+khYMBdKr/Jm7tNnNbdwt2viFIbpNH6d1C9PABkeXbUgEfLRjcJSB
 dz+Q8ZcAlmPnL/stvYVb8yX9oUgbOZ6Uouw/jxPGXUSds44fB3F4XSrtf87lazIalkfCaI
 2CIB8qu54+MqGdBo1AX+TLh1+4uWs48=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512--GeKzMCANAin6rieVg-T9g-1; Thu, 30 Apr 2026 13:24:35 -0400
X-MC-Unique: -GeKzMCANAin6rieVg-T9g-1
X-Mimecast-MFC-AGG-ID: -GeKzMCANAin6rieVg-T9g_1777569875
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50f13da9684so12960011cf.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569874; x=1778174674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pll79ubvj2WY+vR4reNM8nqRiqCLK9Som46Z/qrJjIE=;
 b=SX6ZAJ8B7cpcraEqnKVs2PWuG2nxrTd/meIiltZucuQxJv6z0ypq4UwsHN76dDEtEA
 lm6md4Agj3EugfJdweFYZ3cjqqgHsBXohxMhKs74LfZmxA1GTX/0DhZk/3kl1Pwmyqem
 3JvgzEdqVVu2ubVBHIfCe8ArMD495fg0QU4aadFeJJtuSbOTkSYpM8vl1HK1BMM4VYXX
 ZJ9OdqJESXqWHvXOpgedjNnqz1gv5QOQaxLdm07OY6tDR4DIFJPr2+TL+N4tfs0SQglZ
 9BoLoMjmiFtgOPZxFbbr/1HaJu8AcCMTH9Wm6XEWOoUllaNtdcg2CV3Y5H7kBqnRVlNh
 8MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569874; x=1778174674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pll79ubvj2WY+vR4reNM8nqRiqCLK9Som46Z/qrJjIE=;
 b=CZgqRKUzNXVgYP9LufRFgJDcgU++ac5RfO0WLxuSWG+NYm8vK82f4nru9Z5RljKZlb
 GA0TX4bRGNPHvRgPnG2vqE08eS7LLiJEOrStCNTGqYrFONDjgRqP7igDNXYDjsHZX8qL
 9z9AzMT3tzUn/AgEhDwZgc8H14HZx627SpbFeziUqPVyPhZY6vpylZjui3B/zE8hx6ev
 aY8HWlrABF/gqvPWvdN+W5ITHcAtkI7w3tDYgDfbIn8+MiKzM+XG37JAoJ/NEOca1GqV
 tQq09PRLUTWMLNvoL2XUJmpxCBePFkl8Kl3neLE/frQyV6wwgI6nSuekEyKUJV3XpSq/
 7q1Q==
X-Gm-Message-State: AOJu0YyFl9Q4VHqWAUp57hxhfOCDxxF4FlHspdwER02xmz2UNJiraOPZ
 QeN+dHE5IjlNkvq9yZlJNkbPpqOHK2oSZTGa5XZ9Mj20w+hAXXuqHjU+/ooymBIL/BLk1t8/M01
 xXO6IpiHQU/BAu8SVD1A8NZN6PitD4abh6ZB95pop99O4sMHz9MUccgHnFJZGKLvqTdsyrCdgJG
 gXKjgL+QIbjqTkbREvQWuiUGs2O9/dCpVJRycmjJOY
X-Gm-Gg: AeBDieso3os3WUWk/kSW+HNvhd/GKZFzxzDEdBdecEZBp9Qx7aci5EfYyXRqGDyhaxI
 cLkQw5fpijTO4StJbzNdGNiryWkG72IBMWFWV5J4Wr5P65rDtRcJLc8r4Mn2USSIbs0jWwy0+L4
 pJNkDDBRG1VFKv/bqcjkp9v667pZp1YeD9iD5SJcszkP8ZhzvlFZfWFnqsS8kJcyrz5u4562hU9
 XCqjLXadAx0qwG9dmM37e7MvdqCxRa/tqX5XKAE844etFvOFt1NovSdlj0coERv36+3eXY/iI4B
 sM/1NgOzkiKT4XO4F/SxM72Zu7Ien3RXFJiJPHTcX4uirUekTlyCmeRZ3QLyDMvBZQsPHYspg9v
 7r1Z24GG59OKphCWAETkpd1zD0aR6Q3LtcaCuXRRdSDYBrPw1adG6MnBkQOzHuooaRWyZlqWy5J
 8gsJLcoWBtAAlFQ63VyhUO7yGrJqRU1aRJDdE=
X-Received: by 2002:ac8:5c88:0:b0:50e:5ffd:dec2 with SMTP id
 d75a77b69052e-5102ab1bf61mr57490231cf.1.1777569874419; 
 Thu, 30 Apr 2026 10:24:34 -0700 (PDT)
X-Received: by 2002:ac8:5c88:0:b0:50e:5ffd:dec2 with SMTP id
 d75a77b69052e-5102ab1bf61mr57489571cf.1.1777569873828; 
 Thu, 30 Apr 2026 10:24:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d3485c5sm229391cf.30.2026.04.30.10.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 47/58] whpx: i386: some x2APIC awareness
Date: Thu, 30 Apr 2026 19:21:53 +0200
Message-ID: <20260430172204.1006673-48-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-24-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-apic.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index 65629ca45f9..cc272f82a5a 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -33,7 +33,11 @@ static void whpx_put_apic_state(APICCommonState *s,
     int i;
 
     memset(kapic, 0, sizeof(*kapic));
-    kapic->fields[0x2].data = s->id << 24;
+    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
+        kapic->fields[0x2].data = s->initial_apic_id;
+    } else {
+        kapic->fields[0x2].data = s->id << 24;
+    }
     kapic->fields[0x3].data = s->version | ((APIC_LVT_NB - 1) << 16);
     kapic->fields[0x8].data = s->tpr;
     kapic->fields[0xd].data = s->log_dest << 24;
@@ -61,7 +65,11 @@ static void whpx_get_apic_state(APICCommonState *s,
 {
     int i, v;
 
-    s->id = kapic->fields[0x2].data >> 24;
+    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
+        assert(kapic->fields[0x2].data == s->initial_apic_id);
+    } else {
+        s->id = kapic->fields[0x2].data >> 24;
+    }
     s->tpr = kapic->fields[0x8].data;
     s->arb_id = kapic->fields[0x9].data;
     s->log_dest = kapic->fields[0xd].data >> 24;
-- 
2.54.0


