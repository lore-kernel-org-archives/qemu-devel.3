Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86A2FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6D-0004hD-7v; Thu, 30 Apr 2026 13:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6B-0004gp-Ha
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV69-0004Hr-Np
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+McHS3rLxz1dlXfKNjuhXZV4i76ytAU3FB6qdTnnEY4=;
 b=hpDsKR+FZ+YgTtUNcGdjyPa9iJtUvqI3mWUv6vhoDhW3/RqTG9xhTFX5hf55Lm1/ZsO1pd
 PyEo1SPfo8yWV3J9kwPUsVp32SPzRapw7lx1ZHA7ZfF6bJ2I3iD7N0YsnHW7oBz38QLQ4d
 WAGk50ygiTIUtm0xIBGOOIaSso0zbM0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623--CrMY0lHP0W4cbp6N-0x1w-1; Thu, 30 Apr 2026 13:22:47 -0400
X-MC-Unique: -CrMY0lHP0W4cbp6N-0x1w-1
X-Mimecast-MFC-AGG-ID: -CrMY0lHP0W4cbp6N-0x1w_1777569767
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50e5a336b44so21774171cf.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569766; x=1778174566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+McHS3rLxz1dlXfKNjuhXZV4i76ytAU3FB6qdTnnEY4=;
 b=S+d39ZcoUUoRe+Zbugn6RZu4p2uj+kgyoihDTfHPh9xpXaMgx1hbijKXXngyZSKBxE
 rMe2r7ud368P59Z3UxwSntMhQzvImbWYLr5ldO60Tny7vutcZ2BZrCgAzlIzwWIsXLXu
 TSxaLG5Pvx+k2V2AdA3+2EJknRjvikg8s4HOPxpywYNf5I0PG6Z84RIOouc2hFluXf8a
 DwgpDLkvAyhAAU/PXsrLm0nGNAifcWlYhi2k0xlxcgSLlzgXvN1kXQ3yiJJAeVKlEfHI
 SrtvLaB0Q0AQnefkCTJC7TLD/gvCGpFxwHjUAg9c2glHXN1PGPQDCExfB31CqPSZxeZn
 yqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569766; x=1778174566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+McHS3rLxz1dlXfKNjuhXZV4i76ytAU3FB6qdTnnEY4=;
 b=Uxh6IpRuHQGpUp22kxlVtcQVzu/3wW4imBUGReSW0skDHmfn2L5wEHcSF47lFSt4iG
 IGaVVB3rQ2t6KDEca7B26s/8R+JLu3OI55oSYz9p/85jvWuFYJ+RdKtG5krMuDfYOr11
 6p7ozOYkS18j7AGOhnQKUsq+bmVskDLLGv7SRwcXfoiLYMAfWptXCMOtzzKBWYqqEWzw
 HswEXYIK85akXOs8FM9H23FgvlNgG/NPlTXckK/nZ3/yeoBJACCxU2MTOcSp33zZw2EB
 1f/JhpzNSuq8SYrEgFfjqAARMuhifPwdBE8ZJGJOhsMMi4CWlu0GDHhy68yfID4QMZU0
 QI0Q==
X-Gm-Message-State: AOJu0YxWsleokBPnXGpWlK0sUorFFWAXiNu+MHXEA/2iZnyD6EWyP8Ur
 /FByQ6qeeABtCY8q1Onf+kF93z+0sTl2YnGdyv4ISTN5LTmiYMixh/7oaQvDtrIPKovZifVwQPu
 e3+LEWZxs9d3IcmKsxUobKXI+/WLMBTRPiamHzcKpXm6YVtVLTFWCYKi9tyGlhibscT8Z08Spsc
 Zpo/8t5GBuwC8DfgiFWfUG/iDUEQF4k4Gf/8a8HBxI
X-Gm-Gg: AeBDiesv6kprYghYGnRf64JaAQSvfQbuDLpFclwE0x5/hMW9pKy3tlyGVw6QQsqyJxP
 o25nU06Tq9clDj8vgUfoRz+1FXcS3MIQjsl1FwtDnI5et/G8lnaxx0RpPw6z2l/MRFjqu4UTcoc
 dDykiwt6Obq1mAt0VCX1rqwAqptITaESRuw7BqLkRuwF9nrrlg+1Cgy4Zq1IvlFB1khqPhBAILI
 0sRW/X8FLNsT1bP9C+aWalgeV3v2ffj4QjFVS03YtEw9d8pQBOXMuFaGPeNhztWH3WGbQMsDHID
 C6cXWKn30aEd+hOBBvKQ7AqZslGoovlYVAtyqyo8unt/1wnMW0EebiDEfWIUvVYwqA8PDjBK///
 xzkd4yWuDDy5/yIwJmMSaPDbX4w7kCz4byrXHS8JKmgY/8IAqpb4AjQqvsolUbCvsJpCxHVhgF4
 S6WzO6JBDtSUqIu8yx9Da46DwBl68v6z1F4o4=
X-Received: by 2002:a05:622a:248d:b0:50f:bd19:657b with SMTP id
 d75a77b69052e-5102d13e8ddmr43952391cf.10.1777569766190; 
 Thu, 30 Apr 2026 10:22:46 -0700 (PDT)
X-Received: by 2002:a05:622a:248d:b0:50f:bd19:657b with SMTP id
 d75a77b69052e-5102d13e8ddmr43951631cf.10.1777569765504; 
 Thu, 30 Apr 2026 10:22:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d2f63dbsm284901cf.18.2026.04.30.10.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 11/58] minikconf: simplify self.tok
Date: Thu, 30 Apr 2026 19:21:17 +0200
Message-ID: <20260430172204.1006673-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Do not ever store a string in self.tok, only a finished token.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 59 ++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 2656d364920..3d63cc6b21f 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -330,9 +330,9 @@ def do_imply(self, var, symbol, cond=None):
 class KconfigParserError(Exception):
     def __init__(self, parser, msg, tok=None):
         self.loc = parser.location()
-        tok = tok or parser.tok
+        tok = tok if tok is not None else parser.tok
         if tok != TOK_NONE:
-            location = TOKENS.get(tok, None) or ('"%s"' % tok)
+            location = TOKENS[tok] if isinstance(tok, int) else '"%s"' % tok
             msg = '%s before %s' % (msg, location)
         self.msg = msg
 
@@ -573,13 +573,14 @@ def parse_config(self):
 
     def get_token(self):
         while True:
-            self.tok = self.src[self.cursor]
+            ch = self.src[self.cursor]
             self.pos = self.cursor
             self.cursor += 1
 
             self.val = None
-            self.tok = self.scan_token()
-            if self.tok is not None:
+            tok = self.scan_token(ch)
+            if tok is not None:
+                self.tok = tok
                 return
 
     def check_keyword(self, rest):
@@ -591,46 +592,46 @@ def check_keyword(self, rest):
         self.cursor += length
         return True
 
-    def scan_token(self):
-        if self.tok == '#':
+    def scan_token(self, ch):
+        if ch == '#':
             self.cursor = self.src.find('\n', self.cursor)
             return None
-        elif self.tok == '=':
+        elif ch == '=':
             return TOK_EQUAL
-        elif self.tok == '(':
+        elif ch == '(':
             return TOK_LPAREN
-        elif self.tok == ')':
+        elif ch == ')':
             return TOK_RPAREN
-        elif self.tok == '&' and self.src[self.pos+1] == '&':
+        elif ch == '&' and self.src[self.pos+1] == '&':
             self.cursor += 1
             return TOK_AND
-        elif self.tok == '|' and self.src[self.pos+1] == '|':
+        elif ch == '|' and self.src[self.pos+1] == '|':
             self.cursor += 1
             return TOK_OR
-        elif self.tok == '!':
+        elif ch == '!':
             return TOK_NOT
-        elif self.tok == 'd' and self.check_keyword("epends"):
+        elif ch == 'd' and self.check_keyword("epends"):
             return TOK_DEPENDS
-        elif self.tok == 'o' and self.check_keyword("n"):
+        elif ch == 'o' and self.check_keyword("n"):
             return TOK_ON
-        elif self.tok == 's' and self.check_keyword("elect"):
+        elif ch == 's' and self.check_keyword("elect"):
             return TOK_SELECT
-        elif self.tok == 'i' and self.check_keyword("mply"):
+        elif ch == 'i' and self.check_keyword("mply"):
             return TOK_IMPLY
-        elif self.tok == 'c' and self.check_keyword("onfig"):
+        elif ch == 'c' and self.check_keyword("onfig"):
             return TOK_CONFIG
-        elif self.tok == 'd' and self.check_keyword("efault"):
+        elif ch == 'd' and self.check_keyword("efault"):
             return TOK_DEFAULT
-        elif self.tok == 'b' and self.check_keyword("ool"):
+        elif ch == 'b' and self.check_keyword("ool"):
             return TOK_BOOL
-        elif self.tok == 'i' and self.check_keyword("f"):
+        elif ch == 'i' and self.check_keyword("f"):
             return TOK_IF
-        elif self.tok == 'y' and self.check_keyword(""):
+        elif ch == 'y' and self.check_keyword(""):
             return TOK_Y
-        elif self.tok == 'n' and self.check_keyword(""):
+        elif ch == 'n' and self.check_keyword(""):
             return TOK_N
-        elif (self.tok == 's' and self.check_keyword("ource")) or \
-              self.tok == 'i' and self.check_keyword("nclude"):
+        elif (ch == 's' and self.check_keyword("ource")) or \
+              ch == 'i' and self.check_keyword("nclude"):
             # source FILENAME
             # include FILENAME
             while self.src[self.cursor].isspace():
@@ -639,19 +640,19 @@ def scan_token(self):
             self.cursor = self.src.find('\n', self.cursor)
             self.val = self.src[start:self.cursor]
             return TOK_SOURCE
-        elif self.tok.isalnum():
+        elif ch.isalnum():
             # identifier
             while self.src[self.cursor].isalnum() or self.src[self.cursor] == '_':
                 self.cursor += 1
             self.val = self.src[self.pos:self.cursor]
             return TOK_ID
-        elif self.tok == '\n':
+        elif ch == '\n':
             if self.cursor == len(self.src):
                 return TOK_EOF
             self.line += 1
             self.line_pos = self.cursor
-        elif not self.tok.isspace():
-            raise KconfigParserError(self, 'invalid input')
+        elif not ch.isspace():
+            raise KconfigParserError(self, 'invalid input', ch)
 
         return None
 
-- 
2.54.0


