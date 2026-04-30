Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270E9CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6R-0004m9-Co; Thu, 30 Apr 2026 13:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6P-0004lR-AK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6N-0004Ox-KT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2y1bpuysoEbl+6lNkzmdlCJGYQ3nonRiNk3euPaHYUU=;
 b=V2qDvQv7xejrP+/u/adP30g7bZu4WsyW5wSD/Qg38p0Xg0zsiToiDieURjZ8TrcG/Y9lV4
 +NrExU3rL9x5DAEzpEhUB1vZD2bX2bdEMAaXkszC+hSP2BPNUNIGM2/CTAjdxxfsNBpZKn
 HK2k1lXOnThsfjA5JfO+i7EYJQC/KpI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-9F3rCknTMZmFEt-osWPoOA-1; Thu, 30 Apr 2026 13:23:01 -0400
X-MC-Unique: 9F3rCknTMZmFEt-osWPoOA-1
X-Mimecast-MFC-AGG-ID: 9F3rCknTMZmFEt-osWPoOA_1777569781
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8ed2c173d3bso231946685a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569780; x=1778174580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2y1bpuysoEbl+6lNkzmdlCJGYQ3nonRiNk3euPaHYUU=;
 b=SzoQJNn4KD4B6rT9yOPknvkGCWdncHK1qxjQS6p4oZrb3vchmWf5VWcwK6kUpYiCwc
 M+Sa8mLa1Km8CVvx9BOYnZqqDSHOfQdFp8tatpTlOzuhpQW8m5Qo2KydIs1dKSwyKnAo
 cXc/0VAYineQEB8CZDsNZRap3iLDuepinvXIEuJWnSuqeAa8H4PTolh3JdL+jlPUHx6/
 qXPkQcCQH4apAE136gud/ycnq00G+6G9G9KMSuKnj5ZPPE7dwW3reG8I24zlKcJorNTO
 VgXNpU+SzjoI+Z4ay/HAEdN0FBWFJPtzC/55hW/Tz59sJkFmt9jyne4aWui+QJMxEjuN
 AZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569780; x=1778174580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2y1bpuysoEbl+6lNkzmdlCJGYQ3nonRiNk3euPaHYUU=;
 b=NCLD1il/+rfzmghCR7bEW/3cAyyXLtJCPA9sV6L9C/My9fWFCvzswhBppsz5KGFIn6
 XGYHMcmUtutvARwPBKOFl1BPPr7kYj+ykisef/7ONrKiJ/Tv2t6EA6Qex0PpceAWmccL
 Fx/XrwWgH5TBw+iT1CDPGjtRi4ucUHtkhmcFtfaw0iRqjYzbaLXD+gqmJRtZGU/mHHDd
 zh+qUFCGJ1bW0olO35S3mfmGmEA4ZHQJUgE8RUFwMA/mrcbjnq47X4RvKEZVv3D6qB5I
 ukwmxhB23geTEM3pO3GAcJgqSq5moLIhsfilKkev6WQvH6wsj5FiCvd+xRa9sd6sgqtR
 wJrg==
X-Gm-Message-State: AOJu0YwsYRPNJl3CAhrhySTDHn0o465o2tnvetH0u01rsipka9U+Meuf
 YolznKvGzGVVAIb0jloPW6YsetEa9IM28V7MSJxBPpv7oBiwVCeMhTyjgXHrZA85LARmGCeie5D
 Aswx2jaSesHTzHgRgOiSPR3E0Ygp+Q/7Ac3G8ouwxsET3o7bYzE+f1W+gGXi1CviZh9nB4NGo0t
 kiXjNEaDiNbm/DOfo5wjWk9CpZ9FbC9VIj+zz3e5O1
X-Gm-Gg: AeBDiesb4Q2Fjt/g9l7YVisoOWmZnOp+iGAMrd7bQxTeG7WaGMt7agZ7U/KAP1hWxKp
 IdTU/MV6c8FaMeJ8SAqVVRHuVAWOtIvnUJjFFsNX2PpiA9WclnoGMEk4sI1bo9i4+hKPwh5Dj4U
 YBKXLaOR10sNyt10UioUcQeTu41RykK1QPjzAoO2CZyp7iCyBaYzbGjjCKVbIkbLBoHiv9QCNmT
 witsTVWo2ZRlcnVpYhIXFweOd3eQ2YtoQIE3D4coRs6pkIwOPep+Ke8n+UIsi8V4AbtHu3ZUCPs
 7vqRgCVHGKF2cuDBPMQYq/dTRX4SUf6Xt/1Xzu78jXgFzSaZQ68KQa8O8vv0H9C4XODMF5R6RQs
 RvEzlRP81HV0Q32qoB301R3E+9V0C3nXG+YfXhUz0ozxrQ9xVrovZrAGxRf1S9mybdsmzGi/h6T
 ReU59CicUzS49cFVanI0frn7GEBByPP1r1Kww=
X-Received: by 2002:a05:620a:2804:b0:8ec:8346:1b70 with SMTP id
 af79cd13be357-8fa888428f9mr606503185a.34.1777569779885; 
 Thu, 30 Apr 2026 10:22:59 -0700 (PDT)
X-Received: by 2002:a05:620a:2804:b0:8ec:8346:1b70 with SMTP id
 af79cd13be357-8fa888428f9mr606496585a.34.1777569779285; 
 Thu, 30 Apr 2026 10:22:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb15c2423sm32744785a.19.2026.04.30.10.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 16/58] minikconf: replace else with early return and avoid
 unnecessary else
Date: Thu, 30 Apr 2026 19:21:22 +0200
Message-ID: <20260430172204.1006673-17-pbonzini@redhat.com>
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 79 ++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 685e559bb87..7f042daecbf 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -432,24 +432,24 @@ def parse_y_or_n(self):
 
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
@@ -497,11 +497,10 @@ def parse_expr(self):
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
@@ -606,41 +605,41 @@ def scan_token(self, ch):
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
@@ -650,21 +649,23 @@ def scan_token(self, ch):
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
 
 def main() -> None:
     argv = sys.argv
-- 
2.54.0


