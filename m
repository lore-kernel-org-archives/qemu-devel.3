Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA77D3C545
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4U-0004rr-F9; Wed, 10 Dec 2025 08:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4C-0004nx-4w
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK49-00034W-AT
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUiIMweqIC4FNdOKpk92odsMbHq0zM9mduvXORaZgM4=;
 b=UCaiYNhMUj1izh+QRJICdRh5h9+oe2UkHCpnoj8uhuCNfNgR291SkPT5qZlX+b8iUzfkq6
 BhC17PzRLuZ5SNDIacxSLT/Jb3ACOPABu3UilMW0x+lnteJPS3AOBNyFuGh+aDHzimikT7
 ItUL8ElEVUIOtrVtTF6pUOxTLjg/0fo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-ePS0yuPzNfqJiPH-4sJSsg-1; Wed, 10 Dec 2025 08:17:10 -0500
X-MC-Unique: ePS0yuPzNfqJiPH-4sJSsg-1
X-Mimecast-MFC-AGG-ID: ePS0yuPzNfqJiPH-4sJSsg_1765372629
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so36856055e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372629; x=1765977429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QUiIMweqIC4FNdOKpk92odsMbHq0zM9mduvXORaZgM4=;
 b=cGOTnL8fJ2gn/j+ey4KgqEIYPsNyAok/YhO6JiMn0pRAizV1LN2/C5Rx9ALaIH10hD
 vF8ywd0PjPTDHsruSocR+hj7k3XMx0JVL59GjY+3jxuJ9nht4UtMsg8n8UaYBXRT9MoT
 KBzf221U/PoXNlowChhOpdjI1jA6ynx4xUNoHqNdNYLUpH4XwX5Y5svbc/U+vjY3/d9C
 gDsXDiK/oYX48ZXoX2CigfnHAeCGF7j3rrTw9YBr2vEHstkbEryEwE647bf4AuJXe1jX
 mMORPwBthhdZ/EbfZnaEA2O7R3PZXs6oFJw243EOBcNdpTEbwxWEZ3U7oNO4M7QuVFTn
 OZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372629; x=1765977429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QUiIMweqIC4FNdOKpk92odsMbHq0zM9mduvXORaZgM4=;
 b=GKQ7OOd+fu4NN+5LHueg9kHyHTlm4Rwo+3kp+PJStTFZC9diMwZSkDNkSneqDYKZiN
 pAZRmWp2VIYvabZG24gnYYMX7v6hYlPvtRtYqOUo5rsikP//efMPKDOJq0ycL2M7oSCh
 7B8UHeFxZm76ZKIyOsvniMw45gmnQolFu4nMPw6jMdzO3qPVRUgt2+v99ZChdsTAD6NL
 5FX6QdyPbO+Sji+EFAJ1e3PEMagm+tMHaXjDiJeAdsXhUM65ApxedfDowBw3xP5yDFym
 cM8u3ZU+JD/lUfPR18cXN0TzU3KMLrzzNcqHbmZsLjQbWsD6YopvRuPf3Mzk0PiSRgew
 h+nQ==
X-Gm-Message-State: AOJu0Yxyz097EkHRCI93ktfpHuJkDYelAKNuWKFrp2ilXKjNQmfaW0MS
 cR2af/HYEJOrXsC5ZN01vKrq9rLMCtV+i5yFm2Q+ihVn7DFMGWZwTCQfuFta0HS5PS9gBSlVmbB
 7qhsbTcMG7yluQTVxcglMZfhLfgE3tYoUubyiaG+v1+T/sF2S1GnU6tkeXkHiy2MMupAKPmVCf9
 icP9OnazBJKqXJc1PD041+NRW/5CsCntk38bP06L37
X-Gm-Gg: ASbGncvNRzywYU+k3zfZ8EW+RKhKoblbh53ngGGZlTh4NamNyfqVy8a+Z5nt9QKeuNd
 2PxB1+Ydb59LE0DXJsyjDzhX3u+AtHk81WTnANRsp3O4tiiguQFkibCsNuTQ17i16ku93XaCwpt
 cscZsAT5R/HqphMCPYkGG953dQoAXQeQzSRCT9OXpVyzVHNC1VwmvfZzpzjCZk84vLIQzsVKVgI
 bsD7s8Aglyi9jyPU0fNbu9H4no1mGmOOgk4pnQu5OnZI+2BvcAn9vC3Qzg9adQu6Lpds6TKKjJ7
 uKonb6bR8VXvrju4zJJbbuOSEqI5E99kKmloo0BjPDuezdCi1vKNKJjG7Ftra+XWef+wQNuz/F5
 HTsrkHRfqfpwWv4Bo74l7SWDmbMxLqXYQc9GAV6/xCVfYTRkMjGLPcJA9uvfvXWAIgKIBVDOOTs
 cSwRCzRWSFbwkLEqc=
X-Received: by 2002:a05:600c:6089:b0:470:fe3c:a3b7 with SMTP id
 5b1f17b1804b1-47a8376d708mr19194115e9.5.1765372629045; 
 Wed, 10 Dec 2025 05:17:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG4ouAFGz3e4wS8TdDjSl6+cNUKr6dF3/5UGMXLxpaQsIdwg6iRLMcHz4EvdJxwCTU7jBRqw==
X-Received: by 2002:a05:600c:6089:b0:470:fe3c:a3b7 with SMTP id
 5b1f17b1804b1-47a8376d708mr19193955e9.5.1765372628588; 
 Wed, 10 Dec 2025 05:17:08 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7e41826dsm40132415e9.3.2025.12.10.05.17.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/18] target/i386/tcg: move and expand misplaced comment
Date: Wed, 10 Dec 2025 14:16:42 +0100
Message-ID: <20251210131653.852163-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ea8e26f7f98..9d17bae7e75 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1878,16 +1878,11 @@ static const X86OpEntry opcodes_root[256] = {
 #undef vex12
 #undef vex13
 
-/*
- * Decode the fixed part of the opcode and place the last
- * in b.
- */
 static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     *entry = opcodes_root[*b];
 }
 
-
 static int decode_modrm(DisasContext *s, CPUX86State *env,
                         X86DecodedInsn *decode, X86DecodedOp *op)
 {
@@ -2222,6 +2217,10 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
 {
     X86OpEntry *e = &decode->e;
 
+    /*
+     * Each step decodes part of the opcode and place the last not-fully-decoded
+     * byte in decode->b.  If the modrm byte is read, it is placed in s->modrm.
+     */
     decode_func(s, env, e, &decode->b);
     while (e->is_decode) {
         e->is_decode = false;
-- 
2.52.0


