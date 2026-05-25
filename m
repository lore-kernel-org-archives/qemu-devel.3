Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F99CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRWrn-0000o1-D0; Mon, 25 May 2026 11:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWrm-0000mW-6j
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWrk-00015s-Ot
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779721516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLty9WTrkgb0tLitcavi13F4CVcFzOwMfLsh2O+KoFY=;
 b=Hto9vGmShYGrW4D0guwhnF8FEA6ycytTsBeoUyOQ8K/HwEpWpNwmyDa5VMc00RV6aRf2o0
 8m8IGQS/l/puN7h3csVAOS6rEnDzve0ILPNDOGb9hxw3DD3gos2NhUJXTe8JlheUY/bbTf
 T+xZUDbOt8PoVEpE5Pi2Aq2o4menMYE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-qaJQ5OsEMOe8G7MdjNuRUA-1; Mon, 25 May 2026 11:05:14 -0400
X-MC-Unique: qaJQ5OsEMOe8G7MdjNuRUA-1
X-Mimecast-MFC-AGG-ID: qaJQ5OsEMOe8G7MdjNuRUA_1779721513
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49058e91639so14172415e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779721513; x=1780326313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gLty9WTrkgb0tLitcavi13F4CVcFzOwMfLsh2O+KoFY=;
 b=r8Y5b7c6fdqzrlol3eYWNa7bRKdlUfcPfPlrgudNiiSfYBoOFb7s9ktfabeQVJUW1M
 CiscaLBSWDQC9WiNVkI4QTj7jXW3fXyI5Bg5yWOIVTJnmbywqsfTc3UDthXoHLOsDBzO
 5NLfJvvnGdrqHAVD3NBcyBRH/R6u8dbarNyWC6OT81i+s2S9OO1bjBh82zHG3k5Okoy6
 Gvmt25uqOeQ7va81f9Yv0NgQ/NXL1J/lVvuFrmPzgTM2P7I3P1ESRxgDSh+qeynF2qz6
 JWEcWUtJK3YL8M8WnTw0kBlkSOLMz1WhCwgtQYZ/C8zmFdTW/NEskDsV6xYY4oQmbOSU
 FG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721513; x=1780326313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gLty9WTrkgb0tLitcavi13F4CVcFzOwMfLsh2O+KoFY=;
 b=bXsh3t7AuZnLAw+4xXKTyFGrJoPwj5MEBSYPts8AeEZTaZpKyraPn/Wxgjxbj3f1Vt
 oFSPnbyyoPn0Kv3wFhffHl3jvxSZBgcXr9TCZWoCuHn2TTgVDxOPuhDuFkWegI3IFePi
 jrcB9wa4QXMW4GzrQ/F8styqKmiZjLZwJqb7DN/NiaioXuSpnz2IOeIubyToUT+8wVKY
 NX50jUpLekuV2cGVKiNGtA94wLn0uJpHPh6+qofkAGTSA4RrBRBXNGg1CpUc23QoUNyI
 P+p5BAXfTkIVay3X0DeJxlId+O+Yazs4i0O/lQgQ6K58LD4H+qi21JVV5yY7VdI4BPZb
 MwFA==
X-Gm-Message-State: AOJu0YyHW+1TTgbVuXaEPQOiM3laqtIL7gWx89ma4+upeuwN0jZl99+V
 81gLR89za+xCtZHq/G5DM0U5hGTrTRTKVOTmdXAC7SVwEcay3lyU6xfjgyCRS8qd2eB1x5kZYFp
 UqBsOiAWUJlB+8+CyEqBu72ZnhyrzrDAhl0sM22G+K/WNFiFY6zTPX3NSkNqOUN0QjmgrsHo5UY
 WNHda7ZhhJrA70ogM70sFM6vzxTHTqr4i+jhvHSTVX
X-Gm-Gg: Acq92OH7BHQGaOeSeG/biFxwBMQZMQ64dHg+kfS7cESARFMf3nsa+rK76AQ8Eh+VOVU
 71PiPp4YVYqMrNUIKd+hPl51IcT11qKgK4sOopV9jT0LpqXvq0ulyAOxfx+vWKshbdW57StQB8w
 fGzAZ9nuL7EBuo/RDxeM+bmOGMT1zKb98OtnD0umYNp9n56RxN/eJ4CmcaJyphD7k4TzXeozefp
 FGH34Uzrmxv71WY2rFBEttiekcaFIzWBjnpzcKCvUoLD6w69cQUTP8qlwiPqa0SaVdsDo3Fm0Pr
 z38+GKdr0tH2DI9SOhHFjjunuoFJ0LHQfzlPose1XM0KcwX9tSZFPl5xFj3tCdmZMkZMy6+YzGY
 D/7jqwQvZ+WW9MuzXKoY4jT1FrqCe9VA38EDgaTK5DgX4u8uzQ3CZsfzNXT6ni2/gerAxhVWqr1
 dnG9uFwMGROSZ98mHTEQlj/9KFOK++
X-Received: by 2002:a05:600c:a402:b0:490:3d62:eb0 with SMTP id
 5b1f17b1804b1-490426d7019mr202253205e9.24.1779721513354; 
 Mon, 25 May 2026 08:05:13 -0700 (PDT)
X-Received: by 2002:a05:600c:a402:b0:490:3d62:eb0 with SMTP id
 5b1f17b1804b1-490426d7019mr202252695e9.24.1779721512889; 
 Mon, 25 May 2026 08:05:12 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042af026esm84443205e9.30.2026.05.25.08.05.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:05:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/7] json-streamer: make brace/bracket count unsigned
Date: Mon, 25 May 2026 17:05:00 +0200
Message-ID: <20260525150503.393743-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525150503.393743-1-pbonzini@redhat.com>
References: <20260525150503.393743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

It makes no sense to let brace_count and bracket_count go negative,
also because it immediately ends error recovery and sets them both
back to zero.  Instead set them to zero *before* choosing
whether to process the token queue; this makes it possible to
have the fields as unsigned.

Note that JSON_END_OF_INPUT now forces the parentheses to appear
balanced, so that the queue is emptied and an error is reported;
hence, the "type != JSON_END_OF_INPUT" condition can be removed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qobject/json-parser.h |  4 ++--
 qobject/json-streamer.c       | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
index 4c3d89f751f..0cf6932ecdc 100644
--- a/include/qobject/json-parser.h
+++ b/include/qobject/json-parser.h
@@ -31,8 +31,8 @@ typedef struct JSONMessageParser {
     void *opaque;
     JSONLexer lexer;
     JSONParserContext parser;
-    int brace_count;
-    int bracket_count;
+    unsigned int brace_count;
+    unsigned int bracket_count;
     GQueue tokens;
     uint64_t token_size;
 } JSONMessageParser;
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index f3dfdcaea12..b0bf2083ca6 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -41,12 +41,18 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         parser->brace_count++;
         break;
     case JSON_RCURLY:
+        if (parser->brace_count <= 0) {
+            goto end_error_recovery;
+        }
         parser->brace_count--;
         break;
     case JSON_LSQUARE:
         parser->bracket_count++;
         break;
     case JSON_RSQUARE:
+        if (parser->bracket_count <= 0) {
+            goto end_error_recovery;
+        }
         parser->bracket_count--;
         break;
     case JSON_ERROR:
@@ -56,6 +62,15 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         if (g_queue_is_empty(&parser->tokens)) {
             return;
         }
+    end_error_recovery:
+        /*
+         * Cause error recovery to end immediately.
+         * If not in error recovery, the parser will raise an error
+         * (due to JSON_ERROR or unexpected JSON_R{CURLY,SQUARE})
+         * but error recovery won't be entered at all.
+         */
+        parser->brace_count = 0;
+        parser->bracket_count = 0;
         break;
     default:
         break;
@@ -83,9 +98,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
 
     g_queue_push_tail(&parser->tokens, token);
 
-    if ((parser->brace_count > 0 || parser->bracket_count > 0)
-        && parser->brace_count >= 0 && parser->bracket_count >= 0
-        && type != JSON_END_OF_INPUT) {
+    if (parser->brace_count > 0 || parser->bracket_count > 0) {
         return;
     }
 
-- 
2.54.0


