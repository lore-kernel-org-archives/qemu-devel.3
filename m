Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801DCCD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRWrt-0000va-NN; Mon, 25 May 2026 11:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWrs-0000vB-Fl
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWrq-00016v-NJ
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779721519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ERjXe+UF5yfB73iQjlHQiSxNM/6kyfITxFBZNn5OvM=;
 b=IJrx771c7sXKxDGbXbMOZr0StYGYiuLJrvcEi8kXj/N6Vuv2REUZJcrvvLuXgqEYXwCfDb
 5l0DVeptYOdcpVgQcaQ0QvJ6eC4gkp6hQO0jgSrYK6nEqYRei5yJ25gvHkfUSwNYX9nWIB
 RNzuKBokgLsFJqyC4T7OrwOPgMHgLCw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-3xlDCUAQNX-wEEBMQrGmcA-1; Mon, 25 May 2026 11:05:14 -0400
X-MC-Unique: 3xlDCUAQNX-wEEBMQrGmcA-1
X-Mimecast-MFC-AGG-ID: 3xlDCUAQNX-wEEBMQrGmcA_1779721511
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49048e21ea7so13058665e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779721511; x=1780326311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/ERjXe+UF5yfB73iQjlHQiSxNM/6kyfITxFBZNn5OvM=;
 b=bfpcaZXaA1vZiNyIo60et8DWtWRoWKFaGafXc/f/VsJhd/lgHaTYuuxTzJtqfeLpR9
 5jrnCi/nLg9WwZlYSuu4JFT7xabAyda4vA2ZIs+ebN5gCB4XFJKckcjViGJ86UzEt8k+
 eNTM3wx2J1dx9i+5oT82Hq1cta4Ezm7yAVx/7GP3wPzcQ8/b77YcjAElaC5BWmPCdXLJ
 mElOHQPWfnZQS/VvZX0WZXuULjwB3yPX+/Q8WbBqc913F9p6mG5izcSbMk7mjojAF1ax
 QtWCF0VEPwoG6FK9i+AcHsjvMcdBXBCjnhsVpM97Y0+cFgi6xbCFFGrnJdWW0DDEh4LB
 fiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721511; x=1780326311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/ERjXe+UF5yfB73iQjlHQiSxNM/6kyfITxFBZNn5OvM=;
 b=jNyHdUYi2edYWPAXFXcYo4EtxNGF3G6N5MnKHUCYot+23sOLtyb5N8WcyNCm+dnrUP
 JlL6I6WrMGU8q6KVKQEPdmkT0xC2oHJv1fdHQjrczfIaOd8Waf66yINHwtJBOE5NFXXB
 eO2BO5b+YWS/WJ3HBqkn5TdnP+pifVSAv9xOZbCyZGvze7UxUHYDAhHbNgOoLsDONtdc
 K3cViu261TeFSSKId7rh+gdP3uOTECNcbAPO5RTRk5rtDEiQDgbJz643TvuUV2IaiTEZ
 EJdbQPFvU4Q5nsyJiH/71XiBLq535nrw0Lf+ieMkUaAG6f59bW0KedIR2TCmLzIfVPfn
 a5cQ==
X-Gm-Message-State: AOJu0Yy6YMeK60SFqf88einCN5vdM4a2wohyuZ/Xy+5ea0f1Leba8sr+
 fGkHDCPFoxYYvt5oZZsvDVXEDGIxdjmYzzwYrWihuhx006ySwV+47GQdFIIAHcJOvHxsA3fiQbo
 EFB7sBVqc6IK5Pd9UOiPvU+SgmmwKqPs5tGFzD8MqfkDlwnmmzNY595K5VtmjFHsV79AKuwgA2v
 oLVoRHqAyNcAnjO7T752wx9DPt3QjTrMlb9xXtjd87
X-Gm-Gg: Acq92OGh5sbDIhPuGxeYoJitG1tUffSa6Gxo5O6j53yNIK2Eq5N5Nxebz1bZG+ikoqg
 887EuWZvFti9OK1TObFNkpXZCijlw8Fq764xAEQX1vRlZIp9S4i7YAjzh1m+aoonqgkQxwckM4m
 9Bn5JKzJHa/slZ5C/a2MTXk8ZIv6PIGnuRapE3hF0Dh/j7AaPPhqg52aWZhXtQy07ekFk+r+eaS
 TFukS5dbzHOzNtucIqkk1zCBOyddU+cVY1JstVoku4zWnSUq3xVDllbVm2Uj+HFR2j6tFZrctD4
 4qgEwkWKHq0eW4S9CbVSXReBBb0Jg+xPp7Z678Ul3lYoNKhryRDIC11IZhvUipuUMjyEX7VxyxE
 hLFnejaufRP5SmrbYEVfXJgicT2e1Jb83ac67rlZRmjTbO0B+yssncQzM7t0SK8wtJyVJrkHpW8
 MDzlxtGNvV0cgifLavJJbSSPe3T3K/
X-Received: by 2002:a05:600d:6443:20b0:490:548f:6ca0 with SMTP id
 5b1f17b1804b1-490548f6dc2mr95219295e9.8.1779721511419; 
 Mon, 25 May 2026 08:05:11 -0700 (PDT)
X-Received: by 2002:a05:600d:6443:20b0:490:548f:6ca0 with SMTP id
 5b1f17b1804b1-490548f6dc2mr95218615e9.8.1779721510943; 
 Mon, 25 May 2026 08:05:10 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cd351csm29081298f8f.14.2026.05.25.08.05.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:05:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] json-streamer: reuse parser
Date: Mon, 25 May 2026 17:04:59 +0200
Message-ID: <20260525150503.393743-4-pbonzini@redhat.com>
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


