Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CEAFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLL-0007zP-Vd; Thu, 30 Apr 2026 05:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLI-0007yd-OH
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLH-00038W-4S
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a04HJwacH/7HHwrr3Yw5Am+YrjLFb+c7Jru2AF+J9Z0=;
 b=Mcpuy5nLlgszLsGrqje5gVc5vZrbY1mXFzEiH5XIPTyUKE/l5HkdVZOMmBRCiatW7O/nNr
 FRzIu8JYL9L3J6b6kWp1VPp9AgkqU4tLR8iJ90alIuYgCcT1uL2ntU2MDCLkEpguw9b255
 ThJxQ+A7fCoxvKiZq5cb7Rkt6zik5B0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-_FHXJsO1O0m8QAObEQh4Zw-1; Thu, 30 Apr 2026 05:05:52 -0400
X-MC-Unique: _FHXJsO1O0m8QAObEQh4Zw-1
X-Mimecast-MFC-AGG-ID: _FHXJsO1O0m8QAObEQh4Zw_1777539951
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-bb9fdd62dceso57585066b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539950; x=1778144750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a04HJwacH/7HHwrr3Yw5Am+YrjLFb+c7Jru2AF+J9Z0=;
 b=DMvlMwRRI0vUwPOkM5MYvrQ2dpkSx1es2A9YdwfUngiOC35W8FIVdfpuNlbKKaAjLV
 A6l0Il/VdZtzbn87AvKXIGQOgkChyIEVUmWFO34lBcUlEF6JNKy+3LT+XwaMPVO0MJ8t
 R+WY+wRD2StgIBE6pc25/EWEEWgP79KHJhfxIxJ1ir+Kq8XxkVrfkJ453R0FgoRrKR3O
 Q7caoE1Y49WYe6efS6FmAjIa/iiOCCfTmPfBlaI0OngydgJOsjrJoNJPDRZbtxrvgnma
 pNTB7mcpver+mDvLhbNCU88mlv1lz5us8qhc3C6AWM3NOTP3L2xK7fNwk68ZxZwvWVz7
 zUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539950; x=1778144750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a04HJwacH/7HHwrr3Yw5Am+YrjLFb+c7Jru2AF+J9Z0=;
 b=m5cD2UaTCQj9P9t4X5PutwrM8L1YHAFeAEJyQ7lB70EF+HfnbXkQMPNKoBow4vCk6r
 S8hUoA1Q026xCvXlOUWJ/EyMvfE7ltma4bxkA5yL7EljsXJPIAnKmrf1K21SQoPC/0J1
 4HifDVsKMt4UiwXPkTMFeFtiL2rc3ahdkt6lttvdi3etoKhJduQxCjBmKxptwGiKPSGH
 Ltoov2sfWaTZkyaGXTWibbRMSFo3QH8xdTpAdAMPl9mPFy3DOSdau3/6TDh1fZvehMjG
 /ax6K3koZdoIxo6HlBF+p30M0xshVX8YbFg+x5qQUr7pcnSBsWkD6RRlB3SYtS1QNw+5
 VGPA==
X-Gm-Message-State: AOJu0Yy5hA/m8Y8wdJ1nqflJGlMkDM18dqyp4vKthYB4RKaQ/wlVcKLZ
 7u6sm7G3EMN6qZa3oUSzmXuQVxF2TFGT321NEr9JZKmF+YUn8a0cn8/qcxjkhb17BEThNTABk4O
 8zUQwrXaOO13VGnxxUc2Is5ChMFz0qQwEfRKunimsvTipxmnuQnClwRB1dOr996v+A/Q5cY7nhq
 kub8Q8ebMe9KOhIDt5Vj6MOYXhiSfWM6+xGLCBWImy
X-Gm-Gg: AeBDievRpBYLi9dmx9oM145LuRVXZVnS5zuxWHHUQzc9loYNOTflw+2p1pdv04cF0mU
 jrn2SBqfG0KBURbLAX990Kogo+L6dSKWBTM0NFsrOHRBg3sR5mr00wVYlKMsUDcv0fjmm6E32VE
 Qilctk881/pTU9UUN3lNAyeBivkTQMLRi7RQeoo3dcinKNsWOTQrrysCXZhln67fBjiGxQ6TY8T
 VdaV0mpOyuKeOeB/fil/pC7vWZI5yTei+U4sjF51N4Wk5xfki/i22N8r8a/ZpbIDiZL7NcZ4lzj
 DrhFoQKY+X9N/QaxMhM63s+/ylxicNv3WrA61feysRcglPhI5JO+AbIgnTyKXgK7v/9VlfnKY9L
 ATwM380OIYbl4T26VOjFvoE0dPJM0+/umoj0x2Ck8+ides/q6nKcgZwxdA3rAb7ezsVYpK37PeH
 TKGwNWC/17M+O6PI5rKOl4khr1TG5UnB4o+Qg=
X-Received: by 2002:a17:906:518c:10b0:bb4:92dc:b84b with SMTP id
 a640c23a62f3a-bbac7890ca8mr101285666b.26.1777539949860; 
 Thu, 30 Apr 2026 02:05:49 -0700 (PDT)
X-Received: by 2002:a17:906:518c:10b0:bb4:92dc:b84b with SMTP id
 a640c23a62f3a-bbac7890ca8mr101282666b.26.1777539949048; 
 Thu, 30 Apr 2026 02:05:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10662427f8f.15.2026.04.30.02.05.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/13] minikconf: simplify self.tok
Date: Thu, 30 Apr 2026 11:05:28 +0200
Message-ID: <20260430090534.841894-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430090534.841894-1-pbonzini@redhat.com>
References: <20260430090534.841894-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Do not ever store a string in self.tok, only a finished token.

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


