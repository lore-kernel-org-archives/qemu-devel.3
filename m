Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43643FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK9b7-0000Bb-Fb; Tue, 05 May 2026 02:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9b6-0000B8-C6
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9b3-0005rs-9l
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777963772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ERjXe+UF5yfB73iQjlHQiSxNM/6kyfITxFBZNn5OvM=;
 b=A19d+HTvyZ7LhEc5nsAY7hWtBya+Aw9j/eGtxKzSU1f/8Q9ROdvpxgi5xVf6KKd0aDRkh6
 gVGvIekbGhlXcQ4MCmlWKNEx30gANXQfBhHgmqcmexIeT0IwdfMKRfTpf8xm4B7pST6Ko/
 2v0DNs6ODrMjVtVCjVPr00R1NFTAo/Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-w9dtPyHdMJmPnI1ZZKxrIg-1; Tue, 05 May 2026 02:49:31 -0400
X-MC-Unique: w9dtPyHdMJmPnI1ZZKxrIg-1
X-Mimecast-MFC-AGG-ID: w9dtPyHdMJmPnI1ZZKxrIg_1777963770
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44696b11265so5217347f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 23:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777963769; x=1778568569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ERjXe+UF5yfB73iQjlHQiSxNM/6kyfITxFBZNn5OvM=;
 b=gnA9L6PEueeXEqb7nIrcsqk2XjtBnX6rR8s4ZuTJm8/P6oYATuEuBdVx8dqkGX4tQo
 Ju4DNx6YxpBKXmJNZMZ5KUlIDU5Yyn2MIq5RhszcyWbGzGCTB4orCapcC/lr4fnjMjIB
 PT4FTOcUokaO99Wx6s7b9z7dSWW0WE3Am7jXakTxDOJpyt6GdAKmqI1SY+SRIi0g+vwG
 WlfQwbKccpgzNmyOEpxsNF9HlBaLS93cq4Wc7M/D3HPDITNPdQvMV5yUYiuNDj1UNKgV
 O36I+Nk8r4ZybkZI/r29Azd1Kt4xGj/ntpmNKR6Jl8P5q4srzydZFbAgC7Y814DAB+eh
 OgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777963769; x=1778568569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ERjXe+UF5yfB73iQjlHQiSxNM/6kyfITxFBZNn5OvM=;
 b=Bji04DX6+hH7U44Cx2xshP1XDQ4tqGdnEVBeLptYnE8AInJNHVrGGChLYIm9TJ5Y1y
 gkpd1ymSLD6rehKGJ2Wlr06eXd/+ssa4R3cBb5fRXgJwp8a83UCVwZOfB7o5YpgG4WiQ
 0FwYlO5hNNmHmGbHda7ZynHT9P4jKir9svgLCmwp2r6J+/E5MeOLA308Hw/yL1UpaaOn
 /s/ky8QPhmuPgZdWkchJcrdEhbSYVucjMvvt+jL4miPBIC4XS6MUh0ZczfzHjng0tJb4
 5rz+xq7FpN8Y87xGfmHYZPx2uDmowdB67NtieTyLubI6zYN2MqTsHM5lcTLB+0ffcpdA
 IUEw==
X-Gm-Message-State: AOJu0Yykw1Brm4+SiGgAihhebow+AGfadwhlnyXQ8D/DDA3q6Lm1c8zo
 82e2PdR/1XzccWgkRuJwiL8SC0Z46dKvqj2ZS5M8V+zpA8CW/c38C28xvd9O/5oHoTs14/HRGKa
 M03BaqXd8viXE+VyoTuzUVM1lc+P6qap6513NmISTApr2Squ2816TM1NQQxRKwo2k3+t/qGRx4F
 Ds+vxbWhGLHBti1js+QF9faitK+aulwDXuqRCgh1yA
X-Gm-Gg: AeBDies4BIqX9DcZeImKbn0RKgd4jwHVyqRUM4h35IYzTQ250pDSOQP17lRgRxT8Wcq
 DgiYbP79Bq37B0VFFRnrDNCuuCJCl7XFMVH0eYhy/Tvlry0+82c9R/ud9WHvPbOh8qOMXf1uwGy
 rJdIEAdUiSLBx8KsZ3XqS8uE52IZDzt+mJN3QUvTQNfOK0U9Qwkvbrpo4zp4Urpyskilzy8QtXa
 9fqD/+5RINs35MkNCaSkQ3L8dHhyK/E6E5nH+/tiOnjVu9cv7blcjG72a1ndNPYflm5fbzJThF9
 UJNpB7NG6rPlmi1y8H+scyhnePXs2QexOdKWy13V0tUmlUsBxTIi0+c090RRShjAzNvDw1FqJuG
 SUTvQ4e0BMQa7BDZ5LCs77qgSLvmp/iZpBZi32dR064qyRZ0bibK8Wr8RN0cvhRxM2Xs1sD4RSB
 0vnmz9q8ogSO6x+pBMMuYBdh0X8ZapjFZ43i7Hj7M=
X-Received: by 2002:a05:6000:18a5:b0:449:c5e2:a8b7 with SMTP id
 ffacd0b85a97d-450060571bemr3031263f8f.30.1777963768996; 
 Mon, 04 May 2026 23:49:28 -0700 (PDT)
X-Received: by 2002:a05:6000:18a5:b0:449:c5e2:a8b7 with SMTP id
 ffacd0b85a97d-450060571bemr3031230f8f.30.1777963768482; 
 Mon, 04 May 2026 23:49:28 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02f76sm2059488f8f.23.2026.05.04.23.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 23:49:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH v2 3/7] json-streamer: reuse parser
Date: Tue,  5 May 2026 08:49:15 +0200
Message-ID: <20260505064919.177855-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505064919.177855-1-pbonzini@redhat.com>
References: <20260505064919.177855-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The push parser can be reset, so reuse it when the json-streamer
detects a completed toplevel object.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qobject/json-parser.h |  2 +-
 qobject/json-streamer.c       | 11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
index 05346fa816b..4c3d89f751f 100644
--- a/include/qobject/json-parser.h
+++ b/include/qobject/json-parser.h
@@ -29,8 +29,8 @@ typedef struct JSONParserContext {
 typedef struct JSONMessageParser {
     void (*emit)(void *opaque, QObject *json, Error *err);
     void *opaque;
-    va_list *ap;
     JSONLexer lexer;
+    JSONParserContext parser;
     int brace_count;
     int bracket_count;
     GQueue tokens;
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 6c93e6fd78d..f3dfdcaea12 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -32,7 +32,6 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
                                 JSONTokenType type, int x, int y)
 {
     JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
-    JSONParserContext ctxt;
     QObject *json = NULL;
     Error *err = NULL;
     JSONToken *token;
@@ -90,26 +89,23 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         return;
     }
 
-    json_parser_init(&ctxt, parser->ap);
-
     /* Process all tokens in the queue */
     while (!g_queue_is_empty(&parser->tokens)) {
         token = g_queue_pop_head(&parser->tokens);
-        json = json_parser_feed(&ctxt, token, &err);
+        json = json_parser_feed(&parser->parser, token, &err);
         g_free(token);
         if (json || err) {
             break;
         }
     }
 
-    json_parser_destroy(&ctxt);
-
 out_emit:
     parser->brace_count = 0;
     parser->bracket_count = 0;
     json_message_free_tokens(parser);
     parser->token_size = 0;
     parser->emit(parser->opaque, json, err);
+    json_parser_reset(&parser->parser);
 }
 
 void json_message_parser_init(JSONMessageParser *parser,
@@ -119,12 +115,12 @@ void json_message_parser_init(JSONMessageParser *parser,
 {
     parser->emit = emit;
     parser->opaque = opaque;
-    parser->ap = ap;
     parser->brace_count = 0;
     parser->bracket_count = 0;
     g_queue_init(&parser->tokens);
     parser->token_size = 0;
 
+    json_parser_init(&parser->parser, ap);
     json_lexer_init(&parser->lexer, !!ap);
 }
 
@@ -144,4 +140,5 @@ void json_message_parser_destroy(JSONMessageParser *parser)
 {
     json_lexer_destroy(&parser->lexer);
     json_message_free_tokens(parser);
+    json_parser_destroy(&parser->parser);
 }
-- 
2.54.0


