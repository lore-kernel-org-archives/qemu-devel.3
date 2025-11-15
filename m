Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A05CE8D6B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 00:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK413-0005vi-8M; Fri, 14 Nov 2025 19:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vK40u-0005ty-2k
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 19:19:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vK40s-000801-6q
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 19:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763165972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2TndT4OS9g9ZV9Pv6S9WKvqcKhsN3Lm5nxn+5ird3ts=;
 b=SD0WViDMnNMXE9qN7uSD7lO/PBUoqTIPWFkpLzR+I/0vW1qAIWMuYqHbWxRxKa5Mrvlzv0
 8hsd0t9ikPtrW9Q4A1Odcf5ZE1W8Nx1ireej+DXvudX0RfuPqo98TVQ8LmoUCBh8uplK5P
 ZvSmdn9fXjrdn3TuhONDzizzNA4FkK4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-m553tDJcOqiu9v1WVFW8yA-1; Fri, 14 Nov 2025 19:19:31 -0500
X-MC-Unique: m553tDJcOqiu9v1WVFW8yA-1
X-Mimecast-MFC-AGG-ID: m553tDJcOqiu9v1WVFW8yA_1763165970
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2ffe9335so3271387f8f.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 16:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763165969; x=1763770769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2TndT4OS9g9ZV9Pv6S9WKvqcKhsN3Lm5nxn+5ird3ts=;
 b=amHvuZqbHg0BQbT5VmYwIe7PhuX8gp8R6mGPQMmI3zaC1pp7LUEVW88lwkOV/9SW9V
 C7P0XOYEcmgQp4QuqTp2NLi8y3nFzH89dzL02XEI2sqZF1HVTfAdsPcFEU0sJ69fTLmd
 Ut/wZbgbeQMo6M+euRZeWRyH1mQQ3vEP0ae7OEFdFdnxfzdy0x9bwObOHy8R3vk1sLLi
 4AZUioa7DThsV8GIadQxbbbU+NE2fqUrbgc1p6DifK2Tc7SPUJQA2izP3nk2kmZqFSXB
 AM3sP2aCsGeo5QHwDoWs8LKnC8oQb5vX9FXgxFUbh4C7d2s7/yQU0olecACBqt3rIl7r
 B2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763165969; x=1763770769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TndT4OS9g9ZV9Pv6S9WKvqcKhsN3Lm5nxn+5ird3ts=;
 b=NqSIQf4NEQJEwDE5s5N2VjwgYZsLqNKqhrHSijdkwatwhxWbYVXdhSdWaVSFeH/K85
 2HncIv4gCSB2aOaLe6WnfQADYQka3PVeK69mP5fkytSmWdXhyRgcDI5Dw2BDJzVA0xwt
 hez0bNcekGaVJoTa5nyGJcjyzJMtZWwLX/YDjLjOUw42UBGfjgi84d9HJlJUACNijTbj
 in/9vng1pn54JCA2eTqmk8V2U6gsyGyN0EiW3zX+kbJZnSY866B+ZjnIlnXM1tn5Fynj
 CIZeVVoWeORKl9yn6K0JGLs1gZrVmtI+rgiwBuuqyvHv14PwFiVpVBVEeZ4YbCfb6FSt
 ZMWw==
X-Gm-Message-State: AOJu0YxcyDc4+Z7GGY4rsG4quLgmxWYDr+Cqa77aQNQ2Oaxc9qeipr1p
 XMcKXOsTjohHhMB8mL/5w/h4GzUmoMh4prIlJcwiQSt/ByIL9VT31WCU+v0Yc2HIf5p7iTBAbTR
 Wh/89PwAlfSzWNezcxHOUHhykvkar0FRvIL1/b9i4MiUG9UAPjxL7HHWrh0qUer2ZaXD4cgXr9D
 0OlAAIal463a3c3xbwuI9DoTifiOzfL9onTOBJmXzX
X-Gm-Gg: ASbGncsZIUk4P5ij1qj53CTC2go/ICg+1l50cw2PbkpPA8fOJFbhqYNDPsBKJhczDum
 2Gk93cKvSf2THL2xK3lc/Euk3cr9OJ1woov1O4elYY8wbkD4EkbAvfEVUAIL0hS1Dw4fSyTqlRe
 Gj5cND0AdkJ+L1YwJTlyZAsX9on6lhO3x81/+xeev0Ct/KnfEYesEzdRuoFDHeQfSwWVUs5v5dF
 Si8pBkhgDFNhieyP2LhLhyqgAHrrHtq0OLL4e5iQqKu5pSOvf4+p51dClEI577a+EnuD2IiuyG2
 pHnxun3tkUkHM6gC9/wP8qE1twt8y+piCsCnEYCujBiRf+4RmuV9MXFGMOdIVa+wdq7LpJTvj52
 kmpByhqzFpGV+WWmJie+qaw9zX7r0YsrXkRgHysVtYB211p46OI382FqBdKyYcrnY49+Taqn+fl
 re5FPy
X-Received: by 2002:a05:6000:4008:b0:429:d6dc:ae30 with SMTP id
 ffacd0b85a97d-42b5938ef17mr5606211f8f.46.1763165969428; 
 Fri, 14 Nov 2025 16:19:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuyNrxDhMQ5icdlw02nZF1VL5DZBZc5snQJHePn+8BFRgRbVIy8NymXDMCmnRfYuVy27m6Dg==
X-Received: by 2002:a05:6000:4008:b0:429:d6dc:ae30 with SMTP id
 ffacd0b85a97d-42b5938ef17mr5606195f8f.46.1763165968934; 
 Fri, 14 Nov 2025 16:19:28 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f19aa0sm12626675f8f.37.2025.11.14.16.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 16:19:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/i386/tcg: validate segment registers
Date: Sat, 15 Nov 2025 01:19:27 +0100
Message-ID: <20251115001927.98877-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Correctly reject invalid segment registers, including CS when used as
the destination of a MOV.  Ignore the REX prefix as well.

Fixes: 5e9e21bcc4d ("target/i386: move 60-BF opcodes to new decoder", 2024-05-07)
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3195
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 805cfd08e83..0f8c5d16938 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2059,7 +2059,12 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
     case X86_TYPE_S:  /* reg selects a segment register */
         op->unit = X86_OP_SEG;
-        goto get_reg;
+        op->n = (get_modrm(s, env) >> 3) & 7;
+        /* Values outside [CDEFGS]S, as well as storing to CS, are invalid.  */
+        if (op->n >= 6 || (op->n == R_CS && op == &decode->op[0])) {
+            return false;
+        }
+        break;
 
     case X86_TYPE_P:
         op->unit = X86_OP_MMX;
-- 
2.51.1


