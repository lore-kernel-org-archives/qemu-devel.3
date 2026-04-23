Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77347F9936B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrLe-0002Ax-KW; Thu, 23 Apr 2026 06:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrL1-0001dT-VM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKq-0006AO-Uc
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXEYBCQhBS8pyO+GypVhIKr4nLl0vrpRMrlByTutUAw=;
 b=QhMtouFWeK3fKjzy07h8Pbdx+F2THA5AZsYYIdfku/K388DNAHOzr/5SHX+P0AqyTChbsO
 aQWqBCQx0pSTY2mZGzB3SyRBu3eL49AorfhiuRPbagarS+ibuiklqsVNQAQw0qF6VzJlwD
 HSa9kiF3Gsi7yR8ChRAlaHvsrOJYdfY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-klV8Q2n4MSWTBlG2f37WYQ-1; Thu, 23 Apr 2026 06:31:02 -0400
X-MC-Unique: klV8Q2n4MSWTBlG2f37WYQ-1
X-Mimecast-MFC-AGG-ID: klV8Q2n4MSWTBlG2f37WYQ_1776940261
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d780757eeso3979444f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940260; x=1777545060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXEYBCQhBS8pyO+GypVhIKr4nLl0vrpRMrlByTutUAw=;
 b=qaXx41k5XgFOQz0anBPfz1m857sf6BUE8bYuB78MLmtk1eGWWpF/NU2KmlSbpSHoeo
 7/3fDZD62Q96agtPrbpuwXRlI5CqeaQIe2QuBUH/ijQTkS9Mw3APPOwr/LudKDZRwSdW
 ySBdx33b305z8w5jafzDSN35rRvBde7XG+7tAJowR/BUAhO2gPd5JhBtPet60HNP2Sg1
 4pp2FHJvJe0/drg1PJT74d5lmABpbpi1vlCSSMN7AjQBeFAjAXFDlm/REDKG0hxUOV93
 4HnDxyexdBEFdAHOB7rdEYY1WfPtq1xbs6Gg+q/9EoYSBjBjTjaVKpHfp2zIc+Oon6Ty
 Z3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940260; x=1777545060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CXEYBCQhBS8pyO+GypVhIKr4nLl0vrpRMrlByTutUAw=;
 b=EPjzhrWwQMLG3/x0XCw6JEY+Eq55xMplVa+G3qbu7pGD+vW8n3XGJh+HYF08huWRp+
 CdExDn9FTJsloUpTXYcwBJ3EuFCjKct86wAiW4lPJoTmed7F8uSaRs3O+up6daw8/07M
 d8/D4XU46672KE1f5xPgpHjZQUvtbFe9P1UjipI8hYU5+LX1acQ0mKqvaBC9iDyIN+bk
 uvodROUHMuf08GFvk9ByuyZfN63LLdwPZdvI4yiLRPz5y+B3NawKOIoiZxGa8ezUD1PL
 6DTk0Zvl6EIT6ZWQyI7ZZ/D1ORr7/kJSER8/Og5Cu5SCQZoPztB2bYqTEIDOjSQV7HKR
 XmaQ==
X-Gm-Message-State: AOJu0Yw+jtxhIwvwRYE1JegMmgl1Mry0xgQXIOJjOw0wsk7oOMNKR3Ik
 4Wz5eXFqZ3bGtnnBnACscwS7T/p/S/TxU+Unsl0uSmPZJLp8iBrXArxn1AJOIKB9SlpJ4p2q6D4
 AsfSKlIBXKGDrkASTNc+2C7bNg+AKOXVwCGr5AYLuUTC3k4dsVjzn+ht9l+G6nx4nKaOArm07BG
 qsRUdwzaOC7tTc1rMmQHQBkXmhDYSV6wXN8BZUVYTS
X-Gm-Gg: AeBDievpNGhrPgulbrc/b1xwZuqdEz055PcbJQLN18v7FE0ACbCPcElfAIKy1A2/T8N
 OjhYd7G4tJWL45u981LEobDmTLDcNCK0KFtOpJeI/SsCBATbaA1T/0TRf0d34LyDjqROEsj0EN+
 6v9BVD7vrkDc6NBnuLdEvw96LFODiQUUM9hnveVob1UNA6EfjiPBWVxEtndCXqtGpC0vucbHXiy
 CNcOEHiggYx6KPWJUCWSnUj49Xanyv5gdTmtrn5UDM0gCMEhPwhn7xaE2CjK77VabekJ9q+8WDG
 ASqmV70sZVMbW593x1jR/4WgEmFJu6rI557nb3KoK6lBMARzF/aXxUtL7OwXpT/bmwRTSW8nr9H
 RaXk+gfjAC70UxWD2DsSulRxy6yL7/AaE1sh0KFGrXqgcfCdy+ptF47le8eGvx33lLz0a3Sn8nL
 0D1BroK1z56amYcKL+w4wg+jQvneV/VsaLrBA=
X-Received: by 2002:a5d:5848:0:b0:439:bee4:8a93 with SMTP id
 ffacd0b85a97d-43fe4073758mr42827328f8f.12.1776940260434; 
 Thu, 23 Apr 2026 03:31:00 -0700 (PDT)
X-Received: by 2002:a5d:5848:0:b0:439:bee4:8a93 with SMTP id
 ffacd0b85a97d-43fe4073758mr42827260f8f.12.1776940259903; 
 Thu, 23 Apr 2026 03:30:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1249sm48801208f8f.5.2026.04.23.03.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:30:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 25/25] target/i386: emulate: include name of unhandled
 instruction
Date: Thu, 23 Apr 2026 12:29:22 +0200
Message-ID: <20260423102922.443639-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
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

Instead of just the command number, include the instruction name to make debugging easier.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260407141809.16862-2-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_emu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 55b1a68eb6c..c2da1a133f3 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -1399,8 +1399,8 @@ static void init_cmd_handler(void)
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
 {
     if (!_cmd_handler[ins->cmd].handler) {
-        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x)\n",
-                env->eip,
+        printf("Unimplemented handler (" TARGET_FMT_lx ") for %s - %d (%x %x)\n",
+                env->eip, decode_cmd_to_string(ins->cmd),
                 ins->cmd, ins->opcode[0],
                 ins->opcode_len > 1 ? ins->opcode[1] : 0);
         env->eip += ins->len;
-- 
2.53.0


