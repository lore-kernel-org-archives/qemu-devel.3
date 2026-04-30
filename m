Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F10FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLb-00089I-QH; Thu, 30 Apr 2026 05:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLR-00081g-6J
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLO-00039i-GS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvOzDfKMqp1ekADGqACG/Bzi+q6o7xSLS2++veRRDN0=;
 b=e6l0MkTbjQKs+NWkLnZOuB7iUJkHVVFSAMi6KxOF5lViVCFe0H4C4rIbLTbmcTO8fl4QGX
 sY07FvOWdhT/gsU6XFMec+oYAaUunRoNiNkLWNQCYKCe+Dx6LlLWQdWA34QatZvIFQ7czv
 rja6aAAa8gCeZi6FpUtQSGvqemx7u5U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-BRMW4z7rP5W_Vza_t7_nPA-1; Thu, 30 Apr 2026 05:06:00 -0400
X-MC-Unique: BRMW4z7rP5W_Vza_t7_nPA-1
X-Mimecast-MFC-AGG-ID: BRMW4z7rP5W_Vza_t7_nPA_1777539959
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488d56f87e8so5751305e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539958; x=1778144758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qvOzDfKMqp1ekADGqACG/Bzi+q6o7xSLS2++veRRDN0=;
 b=AsyBxGQWxMP5GSvFSNeC03zNbF6zjnkrEkazjNOGnptE+9JMDj2aRe5DDGyhYjm7HF
 b+MMKBaUKNUGN3jgS6VhSubXStGBN3wqpqSmUNhlTSvzoNLLBctXUE1WP9Zs+JWUpg0D
 9ETdPaSt9hTskNx/0gelBkWY7cabOpQrDW7eAVPbvykGYrexkS6sBdebCBruvU/Ycp7H
 ejw1GFndwTN7PjTGVsszK+OLyGDk24fauBf/CLeH2Rb1L2To40g5kJbuyrjsPs5R3wvT
 67v6aGE41nB7jo3yLV5d9nQ9p4tKa2m/M/lBD3jvkkTYxGFg1t7HxiNfC2ZBpTBSnaeI
 7hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539958; x=1778144758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qvOzDfKMqp1ekADGqACG/Bzi+q6o7xSLS2++veRRDN0=;
 b=PdSd9jCUXHVmbWsFcJSGHa8OYe/uhZ5Sg+s6WG2gLTGi+Rp44mAgJwCo6huSUalx5U
 vQfJr+ZbmaQ/lWpvuAHiUL4Y2AnU9OjZPyFhM9K+ZU1HeIQP7mNL01rdWyhngVKaItvB
 8R7pnHxdgB136HPRobZ/ZLKuCFFunGzKkB/MOzp4pvl/C6gPMszmvIWKUldwOaGxzyfk
 KJmz9VGdLI0CO5CTcRd4uN402YlfCjcxujD/qZ3+z6gJeVhEzFdlABzuji0oJm5aqzG3
 7vyNqn93z2TiwTMqhPnFvBGFqT8R8SXBSMACd3ioSe6QAlUbtAeGxvwAKqR4qiQgqRak
 2n7w==
X-Gm-Message-State: AOJu0Yy7ScZVcpusqFqtmtKHuJ7YOF/HIlx2+rCbutuawUbCZ7I+Y1Xe
 5p+K5T+Hqd1hmvJfpnqmc8P/4TqKcWIdiwHXZ1k6+YuLhujvprpTfpJPR3kTid+i37rce1/X+x6
 gAgr+CGVJLRV//6X8eK+r81hfxT6L36Xqk2W+rr9CO98iML1/6BN/94fuZ5pDjbYqsFSlFG1sxw
 4dcW/hUEvaLCr23iE0rrHNfCN7WNXKa9gaasVEpdqj
X-Gm-Gg: AeBDievpqjFr6uaQlOFF71iuUQPEoksTzuxQ2+CKUet8g0Rr+hSe8tXZXbb2eSuUe/J
 wU4rM5wMMgiJcn6GAaR5HzFOtsInp0mfD5iFaH4gyLG0ZGLfYu5m5U/cij/vKxEmmjBnmAIKe4v
 8TvL26C0rdwGnYuN1+vIqkj8VkwVIM9rUtfgkLPNinVBWUMB0Rj7bxyQe7VGr9hqpKUeNRLmXnB
 xB/EPAibCXJK+RyVo9SpvRufw5JicoRf3Ki4cq+jxjocgeqKOjqhJCbLgyW6Ya53e1ExXpOT4QR
 hVXzb3bgilzRliRi1dPCdNvqvG7rly0zaqTGh4b3rCGQw0Frpwk+hmq0a+4SIAwk3fvi3ZqLO12
 XMk+wVSoiSmyGJ428TWstM0u78Fg0hskj5t2CvL8y82tkubOS6TE+wE7DpEo+BbH4WnsuRhH8hO
 0uQBGDQtrKF20TrXo6omCJM0FYYxugVzYmCVo=
X-Received: by 2002:a05:600c:a593:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-48a8447c7dfmr18250935e9.25.1777539958006; 
 Thu, 30 Apr 2026 02:05:58 -0700 (PDT)
X-Received: by 2002:a05:600c:a593:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-48a8447c7dfmr18250615e9.25.1777539957376; 
 Thu, 30 Apr 2026 02:05:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822be902sm59042405e9.6.2026.04.30.02.05.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/13] minikconf: replace else with early return and avoid
 unnecessary else
Date: Thu, 30 Apr 2026 11:05:33 +0200
Message-ID: <20260430090534.841894-13-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 79 ++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 5fb42c8f760..7a2fe865484 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -430,24 +430,24 @@ def parse_y_or_n(self):
 
     # var: ID
     def parse_var(self):
-        if self.tok == TOK_ID:
-            val = self.val
-            self.get_token()
-            return self.data.do_var(val)
-        else:
+        if self.tok != TOK_ID:
             raise KconfigParserError(self, 'Expected identifier')
+        val = self.val
+        assert val is not None
+        self.get_token()
+        return self.data.do_var(val)
 
     # assignment_var: ID (starting with "CONFIG_")
     def parse_assignment_var(self):
-        if self.tok == TOK_ID:
-            val = self.val
-            if not val.startswith("CONFIG_"):
-                raise KconfigParserError(self,
-                           'Expected identifier starting with "CONFIG_"', TOK_NONE)
-            self.get_token()
-            return self.data.do_var(val[7:])
-        else:
+        if self.tok != TOK_ID:
             raise KconfigParserError(self, 'Expected identifier')
+        val = self.val
+        assert val is not None
+        if not val.startswith("CONFIG_"):
+            raise KconfigParserError(self,
+                       'Expected identifier starting with "CONFIG_"', TOK_NONE)
+        self.get_token()
+        return self.data.do_var(val[7:])
 
     # assignment: var EQUAL y_or_n
     def parse_assignment(self):
@@ -495,11 +495,10 @@ def parse_expr(self):
     # condition: IF expr
     #       | empty
     def parse_condition(self):
-        if self.tok == TOK_IF:
-            self.get_token()
-            return self.parse_expr()
-        else:
+        if self.tok != TOK_IF:
             return None
+        self.get_token()
+        return self.parse_expr()
 
     # property: DEFAULT y_or_n condition
     #       | DEPENDS ON expr
@@ -604,41 +603,41 @@ def scan_token(self, ch):
         if ch == '#':
             self.cursor = self.src.find('\n', self.cursor)
             return None
-        elif ch == '=':
+        if ch == '=':
             return TOK_EQUAL
-        elif ch == '(':
+        if ch == '(':
             return TOK_LPAREN
-        elif ch == ')':
+        if ch == ')':
             return TOK_RPAREN
-        elif ch == '&' and self.src[self.pos+1] == '&':
+        if ch == '&' and self.src[self.pos+1] == '&':
             self.cursor += 1
             return TOK_AND
-        elif ch == '|' and self.src[self.pos+1] == '|':
+        if ch == '|' and self.src[self.pos+1] == '|':
             self.cursor += 1
             return TOK_OR
-        elif ch == '!':
+        if ch == '!':
             return TOK_NOT
-        elif ch == 'd' and self.check_keyword("epends"):
+        if ch == 'd' and self.check_keyword("epends"):
             return TOK_DEPENDS
-        elif ch == 'o' and self.check_keyword("n"):
+        if ch == 'o' and self.check_keyword("n"):
             return TOK_ON
-        elif ch == 's' and self.check_keyword("elect"):
+        if ch == 's' and self.check_keyword("elect"):
             return TOK_SELECT
-        elif ch == 'i' and self.check_keyword("mply"):
+        if ch == 'i' and self.check_keyword("mply"):
             return TOK_IMPLY
-        elif ch == 'c' and self.check_keyword("onfig"):
+        if ch == 'c' and self.check_keyword("onfig"):
             return TOK_CONFIG
-        elif ch == 'd' and self.check_keyword("efault"):
+        if ch == 'd' and self.check_keyword("efault"):
             return TOK_DEFAULT
-        elif ch == 'b' and self.check_keyword("ool"):
+        if ch == 'b' and self.check_keyword("ool"):
             return TOK_BOOL
-        elif ch == 'i' and self.check_keyword("f"):
+        if ch == 'i' and self.check_keyword("f"):
             return TOK_IF
-        elif ch == 'y' and self.check_keyword(""):
+        if ch == 'y' and self.check_keyword(""):
             return TOK_Y
-        elif ch == 'n' and self.check_keyword(""):
+        if ch == 'n' and self.check_keyword(""):
             return TOK_N
-        elif (ch == 's' and self.check_keyword("ource")) or \
+        if (ch == 's' and self.check_keyword("ource")) or \
               ch == 'i' and self.check_keyword("nclude"):
             # source FILENAME
             # include FILENAME
@@ -648,21 +647,23 @@ def scan_token(self, ch):
             self.cursor = self.src.find('\n', self.cursor)
             self.val = self.src[start:self.cursor]
             return TOK_SOURCE
-        elif ch.isalnum():
+        if ch.isalnum():
             # identifier
             while self.src[self.cursor].isalnum() or self.src[self.cursor] == '_':
                 self.cursor += 1
             self.val = self.src[self.pos:self.cursor]
             return TOK_ID
-        elif ch == '\n':
+        if ch == '\n':
             if self.cursor == len(self.src):
                 return TOK_EOF
             self.line += 1
             self.line_pos = self.cursor
-        elif not ch.isspace():
-            raise KconfigParserError(self, 'invalid input', ch)
+            return None
+        if ch.isspace():
+            return None
+
+        raise KconfigParserError(self, 'invalid input', ch)
 
-        return None
 
 def main():
     argv = sys.argv
-- 
2.54.0


