Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2723DFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK9bT-0000EX-4F; Tue, 05 May 2026 02:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9bH-0000Dm-Re
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9bD-00063d-7s
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777963782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RVT0tnJmjgmnhqKsD8dcnUu8DxkM2B1RNvvxkw4xAcU=;
 b=DgGKbZAnM/hR1YpZuAbwE3W9BOSgO5q6FHi6kEWD0cSIRRPZ+Hyk5fyqyrC6ax4/eZC0SJ
 n8ESWUEjreY3vuysBrEfT116NI9eO+D+Vr/FGsu2e1ctGg9FS8qKqAEV5YTLm7IgdQ1NfM
 WSX9+X7bTrQPZne0znVBBeqmHwtcyJ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-05y1N-hUMoaEdxF6h_msZg-1; Tue, 05 May 2026 02:49:41 -0400
X-MC-Unique: 05y1N-hUMoaEdxF6h_msZg-1
X-Mimecast-MFC-AGG-ID: 05y1N-hUMoaEdxF6h_msZg_1777963780
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43efc93e4f6so3718634f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 23:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777963779; x=1778568579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVT0tnJmjgmnhqKsD8dcnUu8DxkM2B1RNvvxkw4xAcU=;
 b=PjfATBcAzVo1GVmeEhWOMn/N69267OVaexrxU/2gHo6GM2nhNi4Wxf3jLIES4UMHht
 24xLe6JnWtU8i2xTRPdoiop41ITUJqi/74NKPe4gdS+vIx2orEXovWVsc/0apjG96r1X
 xZUy01Wz+3x0gnBw/ra0alZuCnlfEIH6v0vfi6J/tb//WFolwL2xQ4H+9DXNtrnngD2b
 cghoaxztDu5UlWr5/hu+Dq1kHGIL4GcIg+aHPnPG718m6rRqbdadWzIj5pNdpjnFcSe1
 5vGfjutWH7ewvaneQWd9tAtL5fNiuBxix3VOeWPGvEpkooQPHvzFo9bNhsUOttnkl+oa
 ZCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777963779; x=1778568579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RVT0tnJmjgmnhqKsD8dcnUu8DxkM2B1RNvvxkw4xAcU=;
 b=MX0gNw/IROZceQwpZxbwt1cx5ABWhy8DbrYPyk/zfz8zrYq1VpgJSZr1K34nmA1RxK
 F46kH+JRK9jLwM8FICwOSXQMTWq9E5QWSP7ASuCAA1mbCVdK3FFWItQkIUJedQXXWPQF
 GvQ0R2+X0nMwXIWgYI2S8/FL08SGrdPPk5I+mpxBptUyEpQz0z/dAdf5fnrJz1p48Dd2
 /4Xv+wOVwUX9PGbGnlPKtUbDhu8IeAYr0JfihyssGA4F9Uh7aMl1Z+iqWtDIbNkfIeF+
 wsbLy2zHq1YYy6J+Oj5o1DWjblwnQDKU1dydQACrsqKnXnmAF/L98nwEWkH2Vr6tz9q6
 l8dg==
X-Gm-Message-State: AOJu0YyhvYYNcuVwPulRPZCVWP602iZFKfESqnU+acsNg+/9mJaX4ks/
 RGCFxJJLE1qdL+2pRKkCqe1sr0FOq21RTwe4HNsle3HgNZ4qm9hAW5OCqVKnmvhAeiLzKviCA6+
 igJ1VBWFy97zeUbH3JvxVYkC/ZsRq0yOrxbQBUhs/mF8YxW3Inn6hnS4jnzSDM8zAGnzyQJhcqF
 4vK2xCjsYBP1YHZZy0BEU49uVJRejknQSJxpusY7BO
X-Gm-Gg: AeBDieuqzWrJQwUUAQl9KemHLGjdk3P6ak0wSRfm2yLDNw+9liJEzfoAv/ilhl7uY2W
 qnpQhErd1q2dLiTKGS6uyuNb4jsSxdXcuCUICVQ5S3mjxhzEbgToJD1TCAiGZQrOTqTX+BE0SpH
 +D0NX0fKyajlLLXLb5oDGMRSVQo2XCKykDUOiQXpRKjIIrw5cqDwEMdW6SJ/FU7+7GAI83xxxWY
 lvARhuifmd0KhAN5xhLLd2ryxs+jiC6kNz7mnb4A2D9gc5j3X2wVeWwtNP1ALKDdzQSU2lO9Uyp
 b4M8jBkVy6PMOtzRUMTjmveFsyE1uDXU15aswgAUOb84KVWdJmdVBT9a8QYnB8nY5HjlUdSLMuS
 7wXuoqIe4a6rT3NtYz6szP25WZr7u0w4PWme2owUWqHBu5uzK6SZ2jtHcllEdaBrp38bAEaKcDk
 hHHC2KJj3NbmPD1Bvj4QWTZ3GHRB0imUn3J/IDyAw=
X-Received: by 2002:a05:600c:4e04:b0:48a:906a:9050 with SMTP id
 5b1f17b1804b1-48a98638cebmr218946325e9.10.1777963779296; 
 Mon, 04 May 2026 23:49:39 -0700 (PDT)
X-Received: by 2002:a05:600c:4e04:b0:48a:906a:9050 with SMTP id
 5b1f17b1804b1-48a98638cebmr218945795e9.10.1777963778688; 
 Mon, 04 May 2026 23:49:38 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d14d1b4f6sm11598395e9.12.2026.05.04.23.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 23:49:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH v2 7/7] json-parser: add location to JSON parsing errors
Date: Tue,  5 May 2026 08:49:19 +0200
Message-ID: <20260505064919.177855-8-pbonzini@redhat.com>
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

Now that all calls to parse_error have a token, add the line and column
to the message.  As far as I can see the two important TODOs (better
errors and better EOI handling) are done, and the others (token range
information and "parsed size"?) do not really matter or are handled
better by json-streamer.c.  So remove the list, which had sat unchanged
since 2009.

This needs some adjustments to provide a good x and y for error messages.
First of all, they switch from zero-based to one-based, which is safe
because they were both sitting unused.  Second, right now the x and y
are those of the *last* character in the token.  Modify json-lexer.c to
freeze tok->x and tok->y at the first character added to the GString.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qobject/json-parser.h |  1 +
 qobject/json-lexer.c          | 11 +++++++----
 qobject/json-parser.c         | 12 ++----------
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
index 3479e637588..e078b36b2d5 100644
--- a/include/qobject/json-parser.h
+++ b/include/qobject/json-parser.h
@@ -17,6 +17,7 @@
 typedef struct JSONLexer {
     int start_state, state;
     GString *token;
+    int cur_x, cur_y;
     int x, y;
 } JSONLexer;
 
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 51341d96e49..7753ba6c092 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -277,7 +277,8 @@ void json_lexer_init(JSONLexer *lexer, bool enable_interpolation)
     lexer->start_state = lexer->state = enable_interpolation
         ? IN_START_INTERP : IN_START;
     lexer->token = g_string_sized_new(3);
-    lexer->x = lexer->y = 0;
+    lexer->cur_x = lexer->cur_y = 1;
+    lexer->x = lexer->y = 1;
 }
 
 static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
@@ -285,10 +286,10 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
     int new_state;
     bool char_consumed = false;
 
-    lexer->x++;
+    lexer->cur_x++;
     if (ch == '\n') {
-        lexer->x = 0;
-        lexer->y++;
+        lexer->cur_x = 1;
+        lexer->cur_y++;
     }
 
     while (flush ? lexer->state != lexer->start_state : !char_consumed) {
@@ -316,6 +317,8 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
         case IN_START:
             g_string_truncate(lexer->token, 0);
             new_state = lexer->start_state;
+            lexer->x = lexer->cur_x;
+            lexer->y = lexer->cur_y;
             break;
         case JSON_ERROR:
             json_message_process_token(lexer, lexer->token, JSON_ERROR,
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 7bf1a81af86..1ae90434c97 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -126,15 +126,6 @@ typedef struct JSONParserStackEntry {
 
 #define BUG_ON(cond) assert(!(cond))
 
-/**
- * TODO
- *
- * 0) make errors meaningful again
- * 1) add geometry information to tokens
- * 3) should we return a parsed size?
- * 4) deal with premature EOI
- */
-
 static inline JSONParserStackEntry *current_entry(JSONParserContext *ctxt)
 {
     return g_queue_peek_tail(ctxt->stack);
@@ -172,7 +163,8 @@ static void G_GNUC_PRINTF(3, 4) parse_error(JSONParserContext *ctxt,
     va_start(ap, msg);
     vsnprintf(message, sizeof(message), msg, ap);
     va_end(ap);
-    error_setg(&ctxt->err, "JSON parse error, %s", message);
+    error_setg(&ctxt->err, "JSON parse error at line %d, column %d, %s",
+               token->y, token->x, message);
 }
 
 static int cvt4hex(const char *s)
-- 
2.54.0


