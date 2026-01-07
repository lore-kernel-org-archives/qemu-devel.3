Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85E8CF6C04
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdPEL-0000Ec-57; Wed, 07 Jan 2026 03:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdPDw-0007rT-FU
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:49:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdPDu-0008I1-8P
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767775736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XU7tVc2WcpOXgLVF21ZjZzEa8fYwcstCpt/1TetGoNM=;
 b=QIucR3bwXS8doC+YESujRxlHXc/KASH45sQkIoKpaN/7HJ6nRoROKvQfOXT5TuxUohmO7e
 2X0/WBMjnM7hn7hs8BSREBle3S1Rnvs/4zHm4w8OW4W/cudt9f52XC5ciEMq20Ui3fdKMV
 OfUvrvw4gqXos//1BpIVWLqcVxT7EiY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-BXgJPKNQPJC0NDsJ-aUvmw-1; Wed, 07 Jan 2026 03:48:55 -0500
X-MC-Unique: BXgJPKNQPJC0NDsJ-aUvmw-1
X-Mimecast-MFC-AGG-ID: BXgJPKNQPJC0NDsJ-aUvmw_1767775734
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso946272f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 00:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767775733; x=1768380533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XU7tVc2WcpOXgLVF21ZjZzEa8fYwcstCpt/1TetGoNM=;
 b=K59VQd72KVscep1g9oBQX9sDagBzaqyMQ8MFJZFuUrp0hQxHkcHrTQye7PO7y81kWi
 UU5YMi8Ol9XBDW/Ha3/C1WghZj6jLqVG/w4kRBGzJHatW3hdUosEnk/QFUkDYeevyR+N
 1GgQr5AmIz2u+d1CArXdHjncgwHbv+11HCVi5cwKA1Nl5bUEa/kBjhz09uTw0ZDuXhzR
 KzmkRsRmeOxZI1YJUg3T/eG7hvtxtR//eVex+zWLqV4rU63jUwedbm7F7WaSv2A3zhOi
 LJJ3yfsgTvQSII+DtgT9oidUtfVo1CygM+zI3golHZ3Vzqe0y2g1QvZ9le+WRThIaShf
 XKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767775733; x=1768380533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XU7tVc2WcpOXgLVF21ZjZzEa8fYwcstCpt/1TetGoNM=;
 b=ttDY+GMqIOFUlGBU9sg2a8EPm0WyeO1TOd2x0jr7wzVaKjrY8owBfLEU7nOBcuHM2t
 cpglRRKhROKGPpbTD3Jje94qBIKBXjs6CbzBmQxjTZ4ANLLRw6RCtl/D0wIm0xq3X3fk
 8FqM0DdWaWQ4etLQyEzfkQAfKuuax3+2grETVonRfxPl6r2/0QHcPiM6TpyfDunmWEm+
 GAFgC5NnFCKb1v9TqiDSnaS+8U0B0zF/vPt2XDQ6GedarF6LOA4FsJe97JEKomV0ZqqS
 CvC0C07FjKt2CNuNJ7/bLTCMe/b1i/zVQVoEHxArBrav8aehYDJzUqzh+7UNOO8W3Ly5
 skHg==
X-Gm-Message-State: AOJu0YwTmFVHJLt8DgSCrtAR4G/8f4p3t3uqpXbiJj9EUPis0ZDmkq6Y
 6yzxv8WYmwZ3GofW847J2aEkLKk0JqvJbDyx/MxQoTEZ+M1gGBC8u3hnjflEO6c9/cLBU3Tv3wC
 0oUeR6IdnT9sP6W93vuSasFnwJA2t8iB6p2ZdgMoWhdrstkMeGv2CMzQxAmz8mPiloS/4qjGBjQ
 YMTPznzpfnrO81t9mNunzukYjSY4M6Z2v3vOWMYWHz
X-Gm-Gg: AY/fxX6R7wEpDznFePEzYsr2XFjH2MsGMu1yi+aC62IZ7Duss68nu9QDY3gLWFswAYI
 TVy7HbNCch/JwGqBYixnwsGMHQW2ncGium66sp7i/qvFkxFYuA8cUXSf9tRwATVP4pE7izX/xZ5
 63hDuEjBEAFI8TS22+/PfvyAtJ9EHFGD1kSyXqNZnEzrnejrCQbvsD8/erq960B6fBwlnM3ff2K
 aRdd+WnHaIlRI+r3IMBIsFeZiKHWTyNS0Hbf0tkm8Jf5sbaekXDyU8iynu4S/Slqet0lfgSZ/EX
 4y6B5wZLyf+ockw6mdYJinLCcpMNxEsbCBj8CaaWjAOqSx3+wriuccMtr2Zom7F9pedgZ3bLhPn
 xBESDr4HlAk0/ODYv2ozrgnE1s6uqumNKg12MmVhqpFwiOlGLWPawWdktBUJBb8HSCM3VKfQw5f
 MzWiEj91K9Kzj1eg==
X-Received: by 2002:a05:6000:2384:b0:431:397:4c45 with SMTP id
 ffacd0b85a97d-432c37767c2mr1776207f8f.59.1767775732958; 
 Wed, 07 Jan 2026 00:48:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzk6N38h+EaptIec2/gjAdE2wtBTvDB+r/MM1rScsl+hqkq4x3IOr0EHRWwkjLNkwHP0sw+Q==
X-Received: by 2002:a05:6000:2384:b0:431:397:4c45 with SMTP id
 ffacd0b85a97d-432c37767c2mr1776173f8f.59.1767775732372; 
 Wed, 07 Jan 2026 00:48:52 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e17aasm9149922f8f.15.2026.01.07.00.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 00:48:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 5/5] json-parser: add location to JSON parsing errors
Date: Wed,  7 Jan 2026 09:48:40 +0100
Message-ID: <20260107084840.150843-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107084840.150843-1-pbonzini@redhat.com>
References: <20260107084840.150843-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Now that all calls to parse_error have a token, add the line and column
to the message.  As far as I can see the two important TODOs (better
errors and better EOI handling) are done, and the others (token range
information and "parsed size"?) do not really matter or are handled
better by json-streamer.c.  So remove the list, which had sat unchanged
since 2009.

Note however that right now the x and y are those of the *last* character
in the token.  Modify json-lexer.c to freeze tok->x and tok->y at the
first character added to the GString.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qobject/json-parser.h |  1 +
 qobject/json-lexer.c          | 11 +++++++----
 qobject/json-parser.c         | 12 ++----------
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
index 923eb74ca00..98fe1371a85 100644
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
index 2fede59842f..93b737511d1 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -57,15 +57,6 @@ typedef struct JSONParserStackEntry {
 
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
@@ -105,7 +96,8 @@ static void G_GNUC_PRINTF(3, 4) parse_error(JSONParserContext *ctxt,
     va_start(ap, msg);
     vsnprintf(message, sizeof(message), msg, ap);
     va_end(ap);
-    error_setg(&ctxt->err, "JSON parse error, %s", message);
+    error_setg(&ctxt->err, "JSON parse error at line %d, column %d, %s",
+	       token->y, token->x, message);
 }
 
 static int cvt4hex(const char *s)
-- 
2.52.0


