Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6EACD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3dE-0006RE-BS; Fri, 26 Jun 2026 06:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3d9-0006Pf-Bs
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3d7-00055v-Lu
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6g1WIFxg79eY4POLrBwb5BZYFE2C39RrZvOqTPAeZM=;
 b=VG2kg/l+NaaTRz2CuJW1UirgJl0gjQpE0bZxU4BQChJCfp3hGlOpvA0PEmjbO2R/eYIsbv
 kvd3NpOorhwLoAJ8eo/tgs4zdMDtdJYC1W3I+VTuYfjoeWh9fFXJ9NuvDfVxZVvtyH9k1S
 jZz5c2Vt+K/sdKToc0TnMhGUoqvOTIw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-dPNPG5LrNuiOGC18sGfuCg-1; Fri, 26 Jun 2026 06:17:47 -0400
X-MC-Unique: dPNPG5LrNuiOGC18sGfuCg-1
X-Mimecast-MFC-AGG-ID: dPNPG5LrNuiOGC18sGfuCg_1782469067
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4625e71d3ccso1428191f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469066; x=1783073866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6g1WIFxg79eY4POLrBwb5BZYFE2C39RrZvOqTPAeZM=;
 b=kIplujsWyWAQNxLfi8U71LFD0fwG/xSQGd/3irbe1Ie6HfYQ+gbhWrQjQYSwra7lJp
 iWej993cxezQxIQ6KdvRq4MJKI6Na+abIzxk+VNC0ttWnxPyhtILrTPMwtx38y9nqT9g
 e7ciLWTVpEWkKi3YwZqRPs4VvUQf5+Wj2WtobbnzD7ira4YJ+tk/tXA0LExqXmC3Vhhx
 bZs/ycqBDke+ebOk3G55QOtApz5gLhSioCZU84XdEmSzrJLWknJ0KPB78L9wQvnZcQ9b
 Rzmg9UAeUJ+zTWs5cvnfK/SlmIRqkw+6ZxtlSjafGVIRd6Yb6VScQLvBNlCabRZogOmp
 xcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469066; x=1783073866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b6g1WIFxg79eY4POLrBwb5BZYFE2C39RrZvOqTPAeZM=;
 b=o3Ho+iftNR0SXN4xGbFGKbRLLKibtdbEiX3B0upcNibXWdTV6fZe7ivGEVlNuciKv9
 DoQEfTfiKDfxYMrOEoXbmXJtaRnmVfJ1YYOsJBT/qPbMSdlqqmAaZJ3HfBeTsi0vOpyX
 aq8xwn4hvfR0fee/RT1t2mzdBVjV0x3Sosg7jnlM4Z19c1QHrB3xE+duqATKOdwcWWSs
 KbLl3mV5m0NkSqW7kJjVvrDoI55HZKNoWixQhQkNzhg8fvQsT1ynkMq39tYRk5Q6jZNv
 5n0kuOMJJKHqVxM99BWUExLGABCRpkcIK0aneL4dEVKDZa02dDuQmHxalK1sT6rioJdw
 zhQA==
X-Gm-Message-State: AOJu0YyUK8rfhDRplAvabu5rvK76DosRcYV2D5YAfaXo76A/TlR4LkHE
 8EwI75lLATqK/ZTL7msaOe46U7Z6QG3Z/7FFT4+gqW7bhegJ7Pr6NUDzHhtMjdHGxOkK+SwYpCo
 l3LjZOL13jPGQndN38owcv+tyWWNae5Rt31hSO1chNdH4lfArDlPTa5wDUVgCm+6Z0CXCGV50jb
 4j0vLACU9O9SdJsoCRMP2gQyDJyCQEzg9tKkO2SbA/
X-Gm-Gg: AfdE7cl/ycW0GekhRA9tbXZtRiNFUWQaUR5YNkz9QoM1RpPADBXedVAUern8rT2Kdv/
 cX8sRfnRsvieefzB5CS63XgwcjJDz1B29XPLq7QtXs0bcd1matfRzH40XUVFWikL6Ttik8TAW6b
 kAZBhyC3Zp6GIdfZNYhf4uw4HRN8s3B3lIcvBeYeUmx3JFSprTxiJVZdcG0686b7phDnl+J1lgR
 6raT+XyX+jr9fJWu4RGIFaAdtiMed+jnxj6MCFD0J9pYwaKI/8/MyOnhwnmDIqCFDonykVysNG2
 flyh5a2cd4GHDMF0u/vqQNKSAnJORTnijO8w+gqAaoINCqjRyXjUWeIP0u+D3ZFN5Exc9rO/1lO
 XT2DeZY90+mVkQlKssYOtPO83SAZfysES0TSGoFnyLjP0i44KVQdrmAGoDy+fV+AhwgZF31kGM/
 aMMyeP1QCPqsQBphUU
X-Received: by 2002:a05:600c:524a:b0:490:bbc1:c9be with SMTP id
 5b1f17b1804b1-49266192a51mr76953315e9.0.1782469066465; 
 Fri, 26 Jun 2026 03:17:46 -0700 (PDT)
X-Received: by 2002:a05:600c:524a:b0:490:bbc1:c9be with SMTP id
 5b1f17b1804b1-49266192a51mr76952935e9.0.1782469065771; 
 Fri, 26 Jun 2026 03:17:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269016362sm63345335e9.13.2026.06.26.03.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:17:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 6/6] json-parser: add location to JSON parsing errors
Date: Fri, 26 Jun 2026 12:17:26 +0200
Message-ID: <20260626101727.1727389-7-pbonzini@redhat.com>
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
index 4a3f5866129..a188d58d006 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -132,15 +132,6 @@ typedef struct JSONParserStackEntry {
 
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
@@ -179,7 +170,8 @@ static void G_GNUC_PRINTF(3, 4) parse_error(JSONParserContext *ctxt,
     va_start(ap, msg);
     vsnprintf(message, sizeof(message), msg, ap);
     va_end(ap);
-    error_setg(&ctxt->err, "JSON parse error, %s", message);
+    error_setg(&ctxt->err, "%d:%d: JSON parse error, %s",
+               token->y, token->x, message);
 }
 
 static int cvt4hex(const char *s)
-- 
2.54.0


