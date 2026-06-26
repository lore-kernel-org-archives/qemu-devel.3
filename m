Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40701CDE013
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3d3-0006F6-Uh; Fri, 26 Jun 2026 06:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3d0-0006EV-06
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3cy-00054G-CS
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=byDGriG36cugk0iUUjibQB2wOLS/oNL2G+fOn7UmSQs=;
 b=VU4WL31Wkc7E5RGsvyeNc0Rqaexq6NG7yhhoDHNb4HcZy6cNLMTAC+GVdcyjxsSOjuLj5y
 8hNJffl+6a67ygRk+d5kKuQ/XxtOdHGj8HsTkMogWuQDU+RgyRxzTECPWKIGPQkZXjtvuK
 sezaK00qQNcSzHtNt9WcZ6slAg9BPJk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-8_eRVnhbM8urCiXdnTllYw-1; Fri, 26 Jun 2026 06:17:38 -0400
X-MC-Unique: 8_eRVnhbM8urCiXdnTllYw-1
X-Mimecast-MFC-AGG-ID: 8_eRVnhbM8urCiXdnTllYw_1782469057
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b7959b9fso6333565e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469057; x=1783073857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byDGriG36cugk0iUUjibQB2wOLS/oNL2G+fOn7UmSQs=;
 b=RfQcMKVkUlZZygDVQlDCXRtoqz8XtJesjR1/L9EFuauJZlO838d2Bu5fw76fNTzUjG
 FjdV5pCAO3euC/N+offqZrh6hpiIiARNDGcWpqaSQd++ppJGj2yX0z2dc72QRyAQ0KrD
 grDbeNT8yrHCYJe/od3lIPaNBjp2Oy9i5pXHIgHGrTD64vMgKkqKelWJ2Ln1IYEBktrP
 EUIarE/8bnqgB14tXf02CTVi50kfTLzTMnle2nUJm7WX8zQwckUQl7X8gBM2TbWeXgMz
 U3G+p8JgpJB/Y/6dFo8323Gwksj2Hmlx4c5hrph8F0Ib7lZ2Ln3B9V6OvffL1Cklj5IB
 oxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469057; x=1783073857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=byDGriG36cugk0iUUjibQB2wOLS/oNL2G+fOn7UmSQs=;
 b=np0qz9evFof/k/WylFRmDDsKdBJN9rSPiqYMzBAn/frezMKBRpJYWnEadzTDplMSb9
 UcAYFNLwAqckXEerFwGlOAm8nyboyMeArbvWs8BspMYVCpEty77fQZ26vwJtWnKzSTn8
 zWYT/QCn4D0yQa2bqb+58T8G7Hkk8+8QzriHQDD5tihaD9w4ZZZlUEOv2KkYqflwEAp8
 p5VuRpsmSSQLdzv4p5FKw57mkQvZeSqtwiuObagOzmHnLwLQmnWgx1SbLx6KlBUaUC8f
 0CHmaS5cBII36REJhxIQDDM7SUNg7gr+WqdTISxIIaffzXmdXbQfgkwVhBUtSqNId5K7
 NMwQ==
X-Gm-Message-State: AOJu0Yz+KZBlrdeb3ALt9OppsEkMvB1qoI1TlkrW/TIDRc4LB8j734d+
 DRc4TTwaAotKZ99g5YkOQH7NTzAaKXCzcpZKYDAQHIsEP3HZSAUBdJASi+WyCLv1Kx68T2dL0/V
 BSHujYoby9WRPyX+5mnlvZNCXE9CBMCrtIxtx7ZhcRAIEp6p8jWNoPiEgnB8pHyY7DUOrvVm4jQ
 9/M/g9cac1/OO1S5mCQaHFHxk8KchWx+vyj3xUwcoW
X-Gm-Gg: AfdE7cnw+41i9T/P0PekH9KzyF6OC6EW3j8Ov3kJ2/bUZcppuOn32OikJyPRVn42duq
 Ndw+BgMoJF07SQiJ9rVGGCDxo1LEcZ4fxul9RH5LYu8PFmcwJSnthY826ICAJYfFp901M28y/9Y
 V+U5BxC+Wcl0XMtraAa0e+PbyiRQhB2Q52vPT5taiCehe5wONcnFRU38cnWeWoN0DeKApz27ETN
 YAsV+WYcTg6YhkecuwrF+CJvQSKY4qGkFVEwKfA+J/fHFiWolGqbcCpvO4OmGdzJPNtCMd9vj8e
 TLRe2Unafzmd3V0r6+svNz8RrJt2jZAoBj4mhgJdEbBnwiqB7dpvlVJaBS/lxSe+MSPeJPpeupH
 vVhtDqFacdJHcPmGaTbrMR9xen6DIC2fx5c8U16iXdCdZj7YPPYjMkEjxc9rGOu7Xq+5MQ4jaBL
 tsoWyB5NEmtiv4KgTe
X-Received: by 2002:a05:600c:c059:20b0:490:adb6:793d with SMTP id
 5b1f17b1804b1-4926689fb12mr73048235e9.26.1782469056856; 
 Fri, 26 Jun 2026 03:17:36 -0700 (PDT)
X-Received: by 2002:a05:600c:c059:20b0:490:adb6:793d with SMTP id
 5b1f17b1804b1-4926689fb12mr73047775e9.26.1782469056328; 
 Fri, 26 Jun 2026 03:17:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269020266sm65293625e9.15.2026.06.26.03.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:17:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 3/6] json-streamer: make brace/bracket count unsigned
Date: Fri, 26 Jun 2026 12:17:23 +0200
Message-ID: <20260626101727.1727389-4-pbonzini@redhat.com>
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
 qobject/json-streamer.c       | 24 +++++++++++++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

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
index 6c4f99b3e7f..9e1f650bad8 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -41,21 +41,41 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         parser->brace_count++;
         break;
     case JSON_RCURLY:
+        if (!parser->brace_count) {
+            goto end_error_recovery;
+        }
         parser->brace_count--;
         break;
     case JSON_LSQUARE:
         parser->bracket_count++;
         break;
     case JSON_RSQUARE:
+        if (!parser->bracket_count) {
+            goto end_error_recovery;
+        }
         parser->bracket_count--;
         break;
     case JSON_ERROR:
         error_setg(&err, "JSON parse error, stray '%s'", input->str);
         goto out_emit;
     case JSON_END_OF_INPUT:
+        /*
+         * Force the parentheses to appear balanced and the queue
+         * to be emptied, causing a parse error if it wasn't.
+         */
         if (g_queue_is_empty(&parser->tokens)) {
             return;
         }
+    end_error_recovery:
+        /*
+         * We goto here due to receiving either JSON_ERROR or a
+         * JSON_R{CURLY,SQUARE}) that is known to be unbalanced.
+         * If in error recovery, end it immediately.  If not in
+         * error recovery, json_parser_feed() will raise an error
+         * but error recovery won't be entered at all.
+         */
+        parser->brace_count = 0;
+        parser->bracket_count = 0;
         break;
     default:
         break;
@@ -83,9 +103,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
 
     g_queue_push_tail(&parser->tokens, token);
 
-    if ((parser->brace_count > 0 || parser->bracket_count > 0)
-        && parser->brace_count >= 0 && parser->bracket_count >= 0
-        && type != JSON_END_OF_INPUT) {
+    if (parser->brace_count > 0 || parser->bracket_count > 0) {
         return;
     }
 
-- 
2.54.0


