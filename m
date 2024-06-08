Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDA4C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXP-0000bn-HK; Sat, 08 Jun 2024 04:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXN-0000b7-2W
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXL-0008Js-NC
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqGP3iARUUcD1dasvYAyOR0V6U+KICwfqCfpWvRLK08=;
 b=ds+sF69P5ex9BOQXgy6BaY8h4nDlpENJ/KRbNzGRRLNT7xaxb+tdenr6yPmDdlesQZu6qA
 E5e/EZah3BR0N2p18ZaPzcjxB369L2ozpKt/FTMQb1B7zOubOueLGZ6e5nIimF5cfDpcyX
 fLo8DH1psB5LKPT6i0+WHI+z2ju0Jxw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-xVjtoVFwOzKdXEzArdnibg-1; Sat, 08 Jun 2024 04:34:53 -0400
X-MC-Unique: xVjtoVFwOzKdXEzArdnibg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6f0ed4c213so4126566b.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835691; x=1718440491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqGP3iARUUcD1dasvYAyOR0V6U+KICwfqCfpWvRLK08=;
 b=i/zbx16VTayjNpvyZRMHZd4SiBnDf7yV0MUBTACScyMFGDDxKVWnrxBykxMuepEJMK
 9Bx1Cf37brvYup1hHgZYVbhs46b9xB1tD7JW7psO8D0pBYs4R625JcydshdzHB0zglXz
 +SiFc9MZj8UbguE3RpIZlKltfxgtT3FujNDhYXpOUoqk/fo/c8HbU1XxyDqZAgQ9ubre
 Ruptta/zXIRQ/SUF+FMiHMsUyYflvJgMrwR8gzOiQh3fWxUlsTzimc+ILtONZLpmk+K8
 f/vO6Wr2gDHIu2hYx2ICJ9/ciTLaPAKy/KExR13LsfOj7SqMdNr2EZxPPwRHxv80nVJP
 b08A==
X-Gm-Message-State: AOJu0YxgvEonQQYmvk1/ObqaJjhSc0XHxVK6nTgwW7kvVM3NY95QJzYC
 k26bSYoMZpDQS8VvVKW4jpvYBETmVkEuj9yEQDUgUrb10hx+LO73Cmew07REg5owfw3Vieb6TVu
 0o8vIvWQY7boJZShVokYUS1mqGYMBB3kmKC7TMFQwRvX1jODf7PtKtin2wq9YGh3YT0dRpDU5Nq
 1h6PddE4H+YL2XSE9UjYh8GaeFobODitwk52Wo
X-Received: by 2002:a17:906:16d9:b0:a6f:a54:1598 with SMTP id
 a640c23a62f3a-a6f0a541702mr53249466b.49.1717835690683; 
 Sat, 08 Jun 2024 01:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl01fq4AXeqRU7GVh/hscTjtHdvIvB22QgS/0MonBc4EX4WiblO9UrOG7ReTg6owjnk/+iKg==
X-Received: by 2002:a17:906:16d9:b0:a6f:a54:1598 with SMTP id
 a640c23a62f3a-a6f0a541702mr53248066b.49.1717835690194; 
 Sat, 08 Jun 2024 01:34:50 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c806eaec8sm357527366b.104.2024.06.08.01.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 12/42] target/i386: use local X86DecodedOp in gen_POP()
Date: Sat,  8 Jun 2024 10:33:45 +0200
Message-ID: <20240608083415.2769160-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This will make subsequent changes a little easier to read.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20240606095319.229650-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index f90f3d3c589..ca78504b6e4 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2575,11 +2575,13 @@ static void gen_PMOVMSKB(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
 
 static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
+    X86DecodedOp *op = &decode->op[0];
     MemOp ot = gen_pop_T0(s);
-    if (decode->op[0].has_ea) {
+
+    if (op->has_ea) {
         /* NOTE: order is important for MMU exceptions */
         gen_op_st_v(s, ot, s->T0, s->A0);
-        decode->op[0].unit = X86_OP_SKIP;
+        op->unit = X86_OP_SKIP;
     }
     /* NOTE: writing back registers after update is important for pop %sp */
     gen_pop_update(s, ot);
-- 
2.45.1


