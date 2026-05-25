Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8B1CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRWry-0000z6-Fw; Mon, 25 May 2026 11:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWrv-0000vq-LY
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWru-00017X-0a
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779721525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSlPLllxbCkrfFMjQn0uDUMwWkJljCiXnCYQyJGHgeQ=;
 b=jDuoHtSzLd6UMxt2DeILxeOLehThV285yMucuhAz/ghYP5LTTzW3dz945BChTgD3636Qoa
 pL/hkTjaOsjMVYX1pr19YvbxrJK4zZE8Js4jFqS9XEKeKtqFG0L/KtjnLNzUIEDVha3Cnn
 0uiyR7T/FcT1Wo+rPzpZ8nBlhf91vrs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-kVUvW07jOMWxJPRk1YiVMQ-1; Mon, 25 May 2026 11:05:22 -0400
X-MC-Unique: kVUvW07jOMWxJPRk1YiVMQ-1
X-Mimecast-MFC-AGG-ID: kVUvW07jOMWxJPRk1YiVMQ_1779721520
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fde68e420so78316275e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779721520; x=1780326320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LSlPLllxbCkrfFMjQn0uDUMwWkJljCiXnCYQyJGHgeQ=;
 b=TBWzlH7vKjtDwmKKNtIpNii52a/wrMpRVHhNwlATLfrzUceAencPlh+S/vrcExli/C
 oOEpdbCxB15lsDHsWbP80IyDKAdpohACcBPMzmb0QuuZHJ+ZCezciVd9GrDHwM136Zvm
 TqcdABnRp7EBv6xgMnL1peDtrsUJhyYZygtj5eIu89IisgBv6GXMZLQ+y/vf8dW2Gm98
 JBjS+pVwz2ijYFmeYnJpj+UGQD2OsbzL1IKBJpHmjiHEGl/oqTh6f02wUAotlQXPlXMs
 H1UAIQdcJbmcSXng9TxyVbdzaKHVDzJUjPRFSEi53dlIHFkGjw9+UF1O4Ai1x+zbxE7L
 drUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721520; x=1780326320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LSlPLllxbCkrfFMjQn0uDUMwWkJljCiXnCYQyJGHgeQ=;
 b=mIXz5jraY6c94SpiXT19wUM1DKYJjA911YryTtnPsQ+0lHh5XuLjo9tThLaT26fZjY
 t0Ljv6QXGm+EtwzmSCOTLISlvph4MO9KQRIHhscuElsLwpxpAGddWzhcwLtTaG+5XKfn
 0+9lcb5ezC1SHxjbXd7+rBWbBTCINxpxQi5b1MY/De5wQl9fiuDg2T9Xekqki8HG49JF
 WMCJb886hWF+SDnhLALynLm4279WJ0YWplVe+Ode8WW/m4bw8iwNwZQNglxNXqXgFm46
 x1NB1gbWKnk1h672+XudAZtlsnM7Qn9GRtXeCCocVEcFE3tJAv5yhm4mOxjA46/lAJq/
 sgJw==
X-Gm-Message-State: AOJu0Yx+lQmp+J5kXdst7E0ahJe4t+AfN1AOiIvMrFNT3GlTmVzOfdgM
 QKCakCKj7XZD0q9ulmGibvF6vd8JwOfQugJHfFA+6RhgFPUUsZx35DjKONOTq2kDmviTFZ7tSPq
 WkmZFDsqYfvJhcBUZRO18r9W98S3l+pMP8JJ/GD7LQncgjTYFSJq8KM7YmIhuLYpvHMUWWRPqpO
 QoLnbf89unFIJqTraPKUxHG0OMqUPlXVUYipv2Q/gS
X-Gm-Gg: Acq92OHFcNSvcoCjNdBM8CCJh/ny/Cp0ThVEXqCGGVMf22+PtB46w4R29grdgNU0x6T
 EcI7+HuT9PgmpBbk/oZdcIIr5+upGrV0Q7BI7wUF13jw8g0umqoQKDPaFCOG99Fpof7qvYphYPo
 9EKM0pmTwsxwK5Y2MS3sZjYg3+kfUNwrd+bEdwBZYPL118cZoiZjn3q07tTpPyv19id9RHiAKgR
 ooICXsNSscM8pc1tSFBuzcXUukopD2kr6h+dG6hjzmduuyibEIxXvL3or2ZB1Pp0gN0p6BQa90W
 zM67AiuVI/r8rUIGyKKFPnP08ZyfS60rqiK6yjADlbhUp8dm9XIrg3q7T2dCDW0KaSYZKSBH1yE
 ypy0mZNkU44AhLpTZB9st0GaRtADOmmDfI2BSk1ZBQ92Ar3fuZE30m3ALMIoge+QAsQTlb8tcOZ
 v34+AvWkbJMG1My+08rpiYKTFkOgEj
X-Received: by 2002:a05:600c:4e14:b0:490:5cb3:e936 with SMTP id
 5b1f17b1804b1-4905cb3eb00mr122124915e9.4.1779721519793; 
 Mon, 25 May 2026 08:05:19 -0700 (PDT)
X-Received: by 2002:a05:600c:4e14:b0:490:5cb3:e936 with SMTP id
 5b1f17b1804b1-4905cb3eb00mr122123635e9.4.1779721519186; 
 Mon, 25 May 2026 08:05:19 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490428d3e9esm115289225e9.7.2026.05.25.08.05.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:05:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/7] json-parser: add location to JSON parsing errors
Date: Mon, 25 May 2026 17:05:03 +0200
Message-ID: <20260525150503.393743-8-pbonzini@redhat.com>
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
index faf3a9142bd..8c58ae0349a 100644
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


