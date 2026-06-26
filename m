Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DD1CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3cz-0006ER-GN; Fri, 26 Jun 2026 06:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3cx-0006DV-JL
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3cv-00053u-WB
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGGvWJRtvW7IOFkOBW6H2Jyklms6smfTnzqEtf9KrDE=;
 b=ErPmjDygtDTA43YwLdcKrRRQiMh5yywyXri12Q2KDDoTkXYxDQoNNGFNpS7LeQCSCU1TSI
 Tn4FQQwQEa71fyXReEjKG03aoWOMnBEdLU1xPHPZZloWl21UO6BkXmj50XMDeu8HD97Zvm
 79iTIqZo9i2Osdy89EGM9+jkqQxaE8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-WN7Sc6kHNx63CjYt_og4zg-1; Fri, 26 Jun 2026 06:17:36 -0400
X-MC-Unique: WN7Sc6kHNx63CjYt_og4zg-1
X-Mimecast-MFC-AGG-ID: WN7Sc6kHNx63CjYt_og4zg_1782469055
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49244130073so5942155e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469055; x=1783073855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGGvWJRtvW7IOFkOBW6H2Jyklms6smfTnzqEtf9KrDE=;
 b=NNp1WLmz9dCCIYlYn+gavtDJJM/uLGKce3bE/NDomSBcjPzGhZWMYT3A00nlQP9a/k
 P2KoU0HFcnyDGqAcmtU1G835rti+TxsPwvaLT+1HN1wLR3M2+lrIOS/WjwuuyNjy/1Yk
 z8gKZHSnpg28xvJoQ7HoGS/aDMRcytAbIqO93oEL0gDKyi5s+24PyeBjnj6nzocgCa+y
 KBgUSOWhKwYOfdS5De3uN5zKr+bqJfBcMMK9t8ADmNJZvjQbe1tFsC+tEGfP0RbhjFLe
 QyvjYV1fBOimSdwjlx5e0iLd2Gwsl0gkZ1zG90n6lbKoMq96ozxSwAMOd0Iss4OfB2pj
 QxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469055; x=1783073855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aGGvWJRtvW7IOFkOBW6H2Jyklms6smfTnzqEtf9KrDE=;
 b=ka5aRx/ctXth3H881XpoQ0dcqzTAf4pVvuewXv8U8NuRq+L1rFFD00a0V2nNGrm569
 +unnJ24r/MVHaHz48VkG9oPmD+fy4daJh7sU8jnFb9EOPAde9RJtttQZ4efG51YqgN51
 rmor3hwp4QHF/ecv05t417wBcYg9NGgYyyYfrkpA+nN8CHpdBGuuEXERXjuskPK8p+k/
 A7yLhMe8h7acVwmSLkTH3+Cby4UfRtDKHQz8oK3UDbwTnVG/y6k05By1U/lSL+Gep/I6
 sC99sMpgUo5DsId9FcsvSvHF1pcTwURVO+VjW4PhODVSooEM/NgtlDLrGOxwQapOOHIr
 G7ew==
X-Gm-Message-State: AOJu0YygtP9U2DjNReLsKDxBHOOM7zZOXWpZ8NmRaByqNjxV2hqre764
 uOsVekbKgYH4U0jSjCYm+gIJQdwahNM1I5qwwVhJcEDDJju/OiC/l9cVLbie8ME7kIa/3R4pwR8
 TSTq+kj84DfQqABK2JCnUbzKomxZBqWNCsSpG5pTUENH+AoMqGwKuse4N0ET65Am0RZl4kdtDWh
 nvMC3RJUKWBlyEzB+I29my6lIwWv6H/wMavnn79/if
X-Gm-Gg: AfdE7ckYPOmb2cqYAx3+G6QSmfNhrZJUT7B5NzCZJE3eI6b3b82pAIv1ZdIZ50WxWHy
 JECl6GZBwbXmssNdxys+FYUPofNCPhstuU+Vnsiym9yOWbYqSl8wCNYcUcu8YcR1B8bQ4pKcEfn
 t6/b2KsyixU0eD9EFSRzj6Pa3qi8tXoK2eLdIgoTX0ln5PNNuwn0IsPF1ooCBzAThU/O8HteXVg
 K8HoEAbhXgOhC3XlaQmDtBYAuAYoYPKcVNuK7uxxvyRaygDJVUxe4mkSTwpBR/euzbnigBTCXws
 QUGYooiRHOJY9vRlHbvzM0TpYMQ8J0Q4LRqc2ZV74jO5iyt0hoIFaWW9trs1+zpUTchfm1RzOXm
 h6q7B615bKoO+4IYPTQFoX7o7bstHHq/ZdEV5oRbdc/WAyTdc8Z7jfWu1XjsjNjF6Lqc3AweL4M
 YqDeSq3v+71OAh6tMK
X-Received: by 2002:a05:600c:4e4b:b0:490:e196:eaee with SMTP id
 5b1f17b1804b1-49266872cd7mr83692345e9.10.1782469054778; 
 Fri, 26 Jun 2026 03:17:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4b:b0:490:e196:eaee with SMTP id
 5b1f17b1804b1-49266872cd7mr83691625e9.10.1782469053943; 
 Fri, 26 Jun 2026 03:17:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926f94f213sm5785055e9.12.2026.06.26.03.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:17:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 2/6] json-streamer: reuse parser
Date: Fri, 26 Jun 2026 12:17:22 +0200
Message-ID: <20260626101727.1727389-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101727.1727389-1-pbonzini@redhat.com>
References: <20260626101727.1727389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>
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
index 6c93e6fd78d..6c4f99b3e7f 100644
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
@@ -90,21 +89,18 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
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
+    json_parser_reset(&parser->parser);
     parser->brace_count = 0;
     parser->bracket_count = 0;
     json_message_free_tokens(parser);
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


