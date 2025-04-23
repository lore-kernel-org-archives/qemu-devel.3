Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFA8C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wby-0004sf-7G; Wed, 23 Apr 2025 05:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbo-0004Th-8d
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbm-0008Ly-Le
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siEIdR86r67NqyI+Emn18SHDbW2jkuR6TNv9+/vLGVE=;
 b=UjxszNP/S0fSwmwO9amAUyiGMBVwSxW1xwB9hYC6S20Nyk7uiQgYTh8ww8URq6x5AfAlyN
 PpWXBbb6s7OqhMZO8dN21114hufuv2n8c10UWXMfds9u6/ijhCNA5B1YgcsJ9vzGR3GpnI
 donff0LeCA0y0xKRi4sce9ezESi+lRQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-3ysJbgZUMy-wGnGaoiye-Q-1; Wed, 23 Apr 2025 05:41:31 -0400
X-MC-Unique: 3ysJbgZUMy-wGnGaoiye-Q-1
X-Mimecast-MFC-AGG-ID: 3ysJbgZUMy-wGnGaoiye-Q_1745401290
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acb90bccc16so123991966b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401290; x=1746006090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=siEIdR86r67NqyI+Emn18SHDbW2jkuR6TNv9+/vLGVE=;
 b=oWKmmyfXwvbADPu+Q3Qk/v/KE+PaF5048mTgvJ1CrIE9EVeG8x8h+zZY01dVDGto5d
 qU1SDQRjA9VXGl1hxoZvP6v+9ExACpa6aiGUD6RqMcrsKVoQ8/9V45J5/F60pWmCvXxu
 Bki7HYEdDX3tPLw6ahE7726Wi+rICfud6RX5cBoY5tPeoCU+25drIBO+c5xoKTCbhgh9
 5NDptbFeXpmIrDI86mNtY1q79vAztFGD9e7QD0nlwDhH+KInuPhCsAr7fR3Fr2ek2jel
 bUNpRird8J+VqroTT2FPPt0H/TS+aDbQi55hi9V/dPfQWa6Y3k1jh3BEQQmQX4v4qmdd
 nlHw==
X-Gm-Message-State: AOJu0YxTzKwcNu/Re4ONhKNt5OoVzxZzyuOgal1UCikcJw4TPn1u0oI4
 Qmb/UGD4sKyRSJ+6ps4pMGhntjkBnoaSCGMGno9SQJMjwNHjS27dUeUEd+YYcygEWggsSOilzPy
 HdKuKIDL30xbPDjTYT5O++rYQb9sOFWUX5C6Z1gzbrue69gdcg6VNR4DYpVtA6WxT2OJjpzmMYT
 zjvgelL7RNYSlA9vEEzXUWARopq3gv2Darv5WO
X-Gm-Gg: ASbGncvEQ0uY02wIDd0QR+C+RZhwv4OpDmzGFwHAhx17H9z7J0S0m+QnfAFADHgphUF
 jycAGgQANuouYCFJ7U1+rl2cpdZupYQcsTEeU20IHSDEudnwnsWbIPtUVNHkZ5U4IJPpIE2fepG
 sOo6wL8EFjmuLBmo3GPuP6AkyiZ2pQa36YnyvCTXq1hYUMzW7wImgiJvKXWhhlrWmR7lJ6y81yE
 6kf5XGTJXnP1u1WfTVd+W1zOcTOopaG59zGSqUsXPuCRN/Vsvs0WsBnn0wWE07PGjnF/KHQFaNU
 5q8AYGynyVzQJ2BU
X-Received: by 2002:a17:907:9703:b0:ac3:3f11:b49d with SMTP id
 a640c23a62f3a-acb74761593mr1733266766b.0.1745401289631; 
 Wed, 23 Apr 2025 02:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3yIWCo72T6O2rnWThf9MLobCN92qheksq2dvSRMomAxuo5kXTdnzaY2ixxcoV6eYTf1S5Kw==
X-Received: by 2002:a17:907:9703:b0:ac3:3f11:b49d with SMTP id
 a640c23a62f3a-acb74761593mr1733264666b.0.1745401289121; 
 Wed, 23 Apr 2025 02:41:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6efadd0asm799182766b.175.2025.04.23.02.41.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/34] target/i386: emulate: microoptimize and explain
 ADD_COUT_VEC/SUB_COUT_VEC
Date: Wed, 23 Apr 2025 11:40:41 +0200
Message-ID: <20250423094105.40692-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The logic is the same, but the majority(NOT a, b, c) is brought out
to a separate macro and implemented without NOT operations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_flags.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index fedc70a1b80..60ab4f01a20 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -45,14 +45,30 @@
 #define LF_MASK_CF     (0x01 << LF_BIT_CF)
 #define LF_MASK_PO     (0x01 << LF_BIT_PO)
 
+/* majority(NOT a, b, c) = (a ^ b) ? b : c */
+#define MAJ_INV1(a, b, c)  ((((a) ^ (b)) & ((b) ^ (c))) ^ (c))
+
+/*
+ * ADD_COUT_VEC(x, y) = majority((x + y) ^ x ^ y, x, y)
+ *
+ * If two corresponding bits in x and y are the same, that's the carry
+ * independent of the value (x+y)^x^y.  Hence x^y can be replaced with
+ * 1 in (x+y)^x^y, resulting in majority(NOT (x+y), x, y)
+ */
 #define ADD_COUT_VEC(op1, op2, result) \
-   (((op1) & (op2)) | (((op1) | (op2)) & (~(result))))
+   MAJ_INV1(result, op1, op2)
 
+/*
+ * SUB_COUT_VEC(x, y) = NOT majority(x, NOT y, (x - y) ^ x ^ NOT y)
+ *                    = majority(NOT x, y, (x - y) ^ x ^ y)
+ *
+ * Note that the carry out is actually a borrow, i.e. it is inverted.
+ * If two corresponding bits in x and y are different, the value of the
+ * bit in (x-y)^x^y likewise does not matter.  Hence, x^y can be replaced
+ * with 0 in (x-y)^x^y, resulting in majority(NOT x, y, x-y)
+ */
 #define SUB_COUT_VEC(op1, op2, result) \
-   (((~(op1)) & (op2)) | (((~(op1)) ^ (op2)) & (result)))
-
-#define GET_ADD_OVERFLOW(op1, op2, result, mask) \
-   ((((op1) ^ (result)) & ((op2) ^ (result))) & (mask))
+   MAJ_INV1(op1, op2, result)
 
 /* ******************* */
 /* OSZAPC */
-- 
2.49.0


