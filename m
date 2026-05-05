Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03903CD3430
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK9b3-0000AU-88; Tue, 05 May 2026 02:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9b1-0000AC-O9
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9az-0005ms-Bt
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777963767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seRe1ZqQqT3HIB24WiVLXa3WLn+CdJlH2m0bpSi8QME=;
 b=aPY2gDxdErvG/UpD4pQ5uYrQLm5UFBmVXJRKQO7a+Zy1RR7YixO1I9+SKXmVyPiZebI+vq
 AUGK9OPcMVGJ8Q27W5bz3JXRuGI4tAtyQoOKomdYHdo1U0emjvaU5c9atqKGXoWmjR/0+Z
 soJoWRS/70e/HkDmetM06oX8G/OqH9c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-z9pwDgVeMYCCWYsZTQAW8Q-1; Tue, 05 May 2026 02:49:26 -0400
X-MC-Unique: z9pwDgVeMYCCWYsZTQAW8Q-1
X-Mimecast-MFC-AGG-ID: z9pwDgVeMYCCWYsZTQAW8Q_1777963765
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48d144d3428so5708195e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 23:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777963764; x=1778568564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seRe1ZqQqT3HIB24WiVLXa3WLn+CdJlH2m0bpSi8QME=;
 b=CqINq38R6o4E8KG/92eljbcz7aVbyA+SKv9ShQ2FaLXbBiwwl/4U8zEDRs9d/92sTv
 q7mdW2SgjYfnZy5WNvSRF0/HctqvhmbUEAFSeqIt6440JvNUmCDvsUFsgidERFtIU6Pl
 fqNnOX6p6/EbevTKC4xBYKOwSYjE9inOP0nNRmYHpC23YnN2lcMfXxSq1OPDBhGvjRWi
 Y8elwzDEaulnuZ4/qcButuSs/DMh6VaVbaxS+UqRe8WVl87hgE0TJpiGVbo3B9psv7Y/
 z2zdYIhHyrR/AUMgNFo3I5zVGbmcgz5Ebdbryi/So2WAM7GOzeMVLZOAxiQzSVOZfdBF
 AYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777963764; x=1778568564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=seRe1ZqQqT3HIB24WiVLXa3WLn+CdJlH2m0bpSi8QME=;
 b=RqtjkBAMBjOW4Xr5vnWqazZlPZzGxbnklRRQtc5FVqcfvS/6GCTJukcraLzYGMolGg
 ODc7CIbmBtP9OXXVTlZiafrSC7X82Be5xVCHLBlXNKI5aVrHCaZrrM7Ss7HXROJ7lLPU
 yJ8ZLU5rgXPPZZXuh7hRjoFjn4tq/jb7zY6Aadg174u3Ur831lLqVE0q3jzUgNz0RP9R
 rN6evIl87cdPspw0uLtKLylKNlnWTzFpmERlZbce22WwXd7WENCEDNfNYxWEFAn8eSdR
 OQqCGcyUxGtU0jGwf/+n8ZW7NOCoxvLJDXyd7eQZLt8NoFH4NCVX8xtHmcwfAnHdROcY
 8MRA==
X-Gm-Message-State: AOJu0YyglgfTHH0H/CUY3JPHttJXeReu+gDULSRsK6Lgg+5Dd34tGRu3
 wdxnxKOi+3qDxNZBH4P2o3LlqXBC4vlS68RRRWBsx7kaQKcuNVdm9qlqot7JFZG4PFLMdiszVKO
 jKBssTWVO95JLWIOxyk6x8uC1UKrPmZl737BQRzt8HAVv6chiUh/X3YVwBFGjICTayU5fdjELZZ
 +L0uQQAfjdbb1KX3JlFTekIOqnTcu9UBKy9AcmjgUs
X-Gm-Gg: AeBDietrADjOhrUzpphqgXMuoklxs4AMH+t7lchBqe8yfkFm5WYK/3NbsRwPIaMbc8R
 KIkda1MHshqJehGhxgM6zpjFQNRksfVIMOZSPOc3s3843O7vviLCQoYCtvo4c627deyKDSWtJro
 AXeN/Q7/5q+Xm3J5hW1b4hX/eFRv4uJRlxH/89x5/AAQkZ0VLLdjsiQqwruRLHS1OOxYHMQlEAf
 aEqhKypSmEemQxLZB1kvX1AZeUWbssV4nUlbztV0DLNPSm8aOy0lXUMhzVrNw3X4lsJxOLPdOLz
 7bcmPPLMrx4ZyG1pJOe/GpqV4PGeRDjdbl8scRz4YscUi7OWjbYbi2jqv/U5csLmlVhw4u1fGDH
 A6REAyg4Vr9VuZeJe0Ep7X6zh3dc6CgV6rD9OFp1/bNTuA29M9sBRbxX6yA555g/esBJdUFKGu2
 PIjilp8XwwntHb+o5GGHtQ8EyhsuwGjoONTLjDFcM=
X-Received: by 2002:a05:600c:a302:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48a98638a65mr147188395e9.8.1777963764690; 
 Mon, 04 May 2026 23:49:24 -0700 (PDT)
X-Received: by 2002:a05:600c:a302:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48a98638a65mr147188235e9.8.1777963764293; 
 Mon, 04 May 2026 23:49:24 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f7csm385227895e9.12.2026.05.04.23.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 23:49:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH v2 1/7] json-parser: constify JSONToken
Date: Tue,  5 May 2026 08:49:13 +0200
Message-ID: <20260505064919.177855-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505064919.177855-1-pbonzini@redhat.com>
References: <20260505064919.177855-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qobject/json-parser.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 7483e582fea..f6622b82b0a 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -55,7 +55,8 @@ static QObject *parse_value(JSONParserContext *ctxt);
  * Error handler
  */
 static void G_GNUC_PRINTF(3, 4) parse_error(JSONParserContext *ctxt,
-                                           JSONToken *token, const char *msg, ...)
+                                            const JSONToken *token,
+                                            const char *msg, ...)
 {
     va_list ap;
     char message[1024];
@@ -126,7 +127,7 @@ static int cvt4hex(const char *s)
  * - Invalid Unicode characters are rejected.
  * - Control characters \x00..\x1F are rejected by the lexer.
  */
-static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
+static QString *parse_string(JSONParserContext *ctxt, const JSONToken *token)
 {
     const char *ptr = token->str;
     GString *str;
@@ -239,14 +240,14 @@ out:
  * parser_context_pop_token is deleted as soon as parser_context_pop_token
  * is called again.
  */
-static JSONToken *parser_context_pop_token(JSONParserContext *ctxt)
+static const JSONToken *parser_context_pop_token(JSONParserContext *ctxt)
 {
     g_free(ctxt->current);
     ctxt->current = g_queue_pop_head(ctxt->buf);
     return ctxt->current;
 }
 
-static JSONToken *parser_context_peek_token(JSONParserContext *ctxt)
+static const JSONToken *parser_context_peek_token(JSONParserContext *ctxt)
 {
     return g_queue_peek_head(ctxt->buf);
 }
@@ -259,7 +260,7 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict)
     QObject *key_obj = NULL;
     QString *key;
     QObject *value;
-    JSONToken *peek, *token;
+    const JSONToken *peek, *token;
 
     peek = parser_context_peek_token(ctxt);
     if (peek == NULL) {
@@ -309,7 +310,7 @@ out:
 static QObject *parse_object(JSONParserContext *ctxt)
 {
     QDict *dict = NULL;
-    JSONToken *token, *peek;
+    const JSONToken *token, *peek;
 
     token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_LCURLY);
@@ -363,7 +364,7 @@ out:
 static QObject *parse_array(JSONParserContext *ctxt)
 {
     QList *list = NULL;
-    JSONToken *token, *peek;
+    const JSONToken *token, *peek;
 
     token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_LSQUARE);
@@ -426,7 +427,7 @@ out:
 
 static QObject *parse_keyword(JSONParserContext *ctxt)
 {
-    JSONToken *token;
+    const JSONToken *token;
 
     token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_KEYWORD);
@@ -444,7 +445,7 @@ static QObject *parse_keyword(JSONParserContext *ctxt)
 
 static QObject *parse_interpolation(JSONParserContext *ctxt)
 {
-    JSONToken *token;
+    const JSONToken *token;
 
     token = parser_context_pop_token(ctxt);
     assert(token && token->type == JSON_INTERP);
@@ -480,7 +481,7 @@ static QObject *parse_interpolation(JSONParserContext *ctxt)
 
 static QObject *parse_literal(JSONParserContext *ctxt)
 {
-    JSONToken *token;
+    const JSONToken *token;
 
     token = parser_context_pop_token(ctxt);
     assert(token);
@@ -532,7 +533,7 @@ static QObject *parse_literal(JSONParserContext *ctxt)
 
 static QObject *parse_value(JSONParserContext *ctxt)
 {
-    JSONToken *token;
+    const JSONToken *token;
 
     token = parser_context_peek_token(ctxt);
     if (token == NULL) {
-- 
2.54.0


