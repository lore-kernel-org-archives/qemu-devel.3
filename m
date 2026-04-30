Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD97CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6G-0004iF-D0; Thu, 30 Apr 2026 13:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6E-0004hs-R5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6D-0004Jh-7f
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGYB/Qea4Rw59yZSl456XX9o94gifzjhM+3vdt+q8MM=;
 b=NA72SdiLzmipohSt8+w2F6h8dgFqtRHIKC4xC+Z6HZce6UaUNa9VW8HZaWyLz+OafKKrCO
 BGVOJ9SPjQXBODNDOFO0TRiT2n3CXyEiWWHI0t2j6aa00rNcHJ8L1gCepgEdax6j+Wb9yJ
 L8BqKMSCkhwZh3EWbWW4q/oXU+sMnQk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-kLHjyBl9N5qJxAL1dDx-1g-1; Thu, 30 Apr 2026 13:22:50 -0400
X-MC-Unique: kLHjyBl9N5qJxAL1dDx-1g-1
X-Mimecast-MFC-AGG-ID: kLHjyBl9N5qJxAL1dDx-1g_1777569770
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8eb04352924so223839885a.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569769; x=1778174569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGYB/Qea4Rw59yZSl456XX9o94gifzjhM+3vdt+q8MM=;
 b=qdIfiPkijnE/iWl372NCw4dRrXzORL77vNI/BFq3RLvpltyO9L2ozJsnAR42Cblb3Q
 6KLARDXo4plFFA8trtmWNDA/+fOb6vA7U8NfvyXXaCMYr/LI7nbt1IXVfdfps05gPZ9s
 2cHovP1HU2SLSSR6oJNElbaeGTmaVDeic+/nLX55E3oMr8/4EA1QmTUgni0z1N1jA6N2
 B21Whsk5ZBk/kWvfmaA8Asbd5wyWzTkverN56XS79QRiqFUhlcgWWTEAkIuEzxRXcLDd
 Etma2ypohZRaztvIVT5zpD3Xd6hVuozX1XBiw2AKDelul/H42Fa5CwtKT8ivdA2sHHlA
 DIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569769; x=1778174569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XGYB/Qea4Rw59yZSl456XX9o94gifzjhM+3vdt+q8MM=;
 b=CTSzlPe9OFllE8nIdKAG7YvzVRcagehhpKH1C8wRTwh/yLstwwJ+H9XTvOCWU2QO/g
 zkPS87V1LOOfDcNt/w+7fms4I9BsGZkOTlVOsFRCwFA2U4aIf0W7yIl0RMB1lStRDzpv
 Irnrjyaha8k8VbBPlCeCQy1VWOlnuxwPck1Wz1Fzk9wIRSnTWC5ckBaiPt1JaKbadhZn
 ad1NLvTFOCzCSEfUVTg9ylqO0mSpqy0bDfu6+Ld8hFKifdXL/QUmponIVkBXzMqueRLU
 /Z2vtrFOvAHWQ904+u8tavjv3UpGzAY8ZXy4ZYIGqH8TQgkOzMoXTb15kdZArrweDdZ+
 r7WA==
X-Gm-Message-State: AOJu0YysWdUlig7AwO2Kio2Yf32qgCuK8/rf+Klv+6HscG9SkjJlerHT
 68tizmfMSbN9CQL2CRXG8WS1OK8KjZOKQG9P07FQDrA/a+OXBnzw4fEjos3edb7e0BiZaWWYtTW
 j5qkRK9vqoPV3RKKhwBgVaDmX1BucjowTxDLVaNRV7SfdACzn4uVgKDDcLlfoJjY0MYQNTdtjWf
 DbPaaYtQ/R5UvNrgEFq0bQb6CLS37gbfiZT0lY9+uv
X-Gm-Gg: AeBDiet99l1PBlE7zLvwyz6CaDFyclwaiE0fWJFQlM/hzzktDa5HdfyJYwt8kUHBq39
 cHAvR1dYMckJAxux9v81XTJMCREemyXOLxGj0JS8my+O8oooMhI6guvnX/fqecOD84W95Zqe7vj
 ysELt5ZzdxTw1dJUG4B2c4gcC8n4fvoAF0rXVrbwDH2TGwjDANqNOdiGfDYLhxLfXHrRvHbNqjp
 zZAYqg1CnfPg2HDW7K/qCm1HBrufI/vhvgLVQjZyQQWjhcOWJQl9xUOHP2zX/axjWDjnMg1UtGp
 Y7yQ3pVcdg80O27n3cCkoe51dPGdcYMbK1NW7pjTd2vmgPGnp22ODkBUxIpHXbnOP0JUKIwFQS0
 Nqzaau6aV/bsrheKvb5xkzk36eyO1Tq0KQjOrLI5LWvWAuo2juQwMUMWmFpo3BtJfhpnDribn+x
 NWdrwAQkRVBBB1tKY/ni4qw1l943SG2k/BGkg=
X-Received: by 2002:a05:620a:bc7:b0:8ee:1073:320b with SMTP id
 af79cd13be357-8fa88847176mr596811885a.32.1777569769035; 
 Thu, 30 Apr 2026 10:22:49 -0700 (PDT)
X-Received: by 2002:a05:620a:bc7:b0:8ee:1073:320b with SMTP id
 af79cd13be357-8fa88847176mr596803685a.32.1777569768379; 
 Thu, 30 Apr 2026 10:22:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb09fc96fsm27525985a.6.2026.04.30.10.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 12/58] minikconf: modernize handling of include chain
Date: Thu, 30 Apr 2026 19:21:18 +0200
Message-ID: <20260430172204.1006673-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use a dataclass, and store it in the parser to avoid having to
save and restore it.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 68 +++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 3d63cc6b21f..c46c73f82d9 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -11,15 +11,36 @@
 # or, at your option, any later version.  See the COPYING file in
 # the top-level directory.
 
+from __future__ import annotations
+
 import os
 import random
 import re
 import sys
+from dataclasses import dataclass
 
 __all__ = [ 'KconfigDataError', 'KconfigParserError',
             'KconfigData', 'KconfigParser' ,
             'defconfig', 'allyesconfig', 'allnoconfig', 'randconfig' ]
 
+@dataclass
+class IncludeInfo:
+    file: str
+    line: int
+    parent: IncludeInfo | None
+
+    def __iter__(self):
+        inf = self
+        while inf is not None:
+            yield "%s:%d" % (inf.file, inf.line)
+            inf = inf.parent
+
+    def error_path(self):
+        res = ""
+        for loc in self:
+            res = "In file included from %s:\n" % loc + res
+        return res
+
 def debug_print(*args):
     #print('# ' + (' '.join(str(x) for x in args)))
     pass
@@ -202,7 +223,6 @@ def process(self):
     def __init__(self, value_mangler=defconfig):
         self.value_mangler = value_mangler
         self.previously_included = []
-        self.incl_info = None
         self.defined_vars = set()
         self.referenced_vars = dict()
         self.clauses = list()
@@ -342,13 +362,12 @@ def __str__(self):
 class KconfigParser:
 
     @classmethod
-    def parse(cls, fp, data):
-        cls(data).parse_file(fp)
+    def parse(cls, fp, data, incl_info=None):
+        cls(fp, data, incl_info).parse_config()
 
-    def __init__(self, data):
+    def __init__(self, fp, data, incl_info):
         self.data = data
-
-    def parse_file(self, fp):
+        self.incl_info = incl_info
         self.abs_fname = os.path.abspath(fp.name)
         self.fname = fp.name
         self.data.previously_included.append(self.abs_fname)
@@ -360,19 +379,9 @@ def parse_file(self, fp):
         self.line = 1
         self.line_pos = 0
         self.get_token()
-        self.parse_config()
 
     # file management -----
 
-    def error_path(self):
-        inf = self.data.incl_info
-        res = ""
-        while inf:
-            res = ("In file included from %s:%d:\n" % (inf['file'],
-                                                       inf['line'])) + res
-            inf = inf['parent']
-        return res
-
     def location(self):
         col = 1
         for ch in self.src[self.line_pos:self.pos]:
@@ -380,33 +389,34 @@ def location(self):
                 col += 8 - ((col - 1) % 8)
             else:
                 col += 1
-        return '%s%s:%d:%d' %(self.error_path(), self.fname, self.line, col)
+        inf = self.incl_info
+        incl_chain = inf.error_path() if inf is not None else ""
+        return '%s%s:%d:%d' % (incl_chain, self.fname, self.line, col)
 
     def do_include(self, include):
         incl_abs_fname = os.path.join(os.path.dirname(self.abs_fname),
                                       include)
         # catch inclusion cycle
-        inf = self.data.incl_info
+        inf = self.incl_info
         while inf:
-            if incl_abs_fname == os.path.abspath(inf['file']):
+            if incl_abs_fname == os.path.abspath(inf.file):
                 raise KconfigParserError(self, "Inclusion loop for %s"
                                     % include)
-            inf = inf['parent']
+            inf = inf.parent
 
         # skip multiple include of the same file
         if incl_abs_fname in self.data.previously_included:
             return
         try:
-            fp = open(incl_abs_fname, 'rt', encoding='utf-8')
-        except IOError as e:
-            raise KconfigParserError(self,
-                                '%s: %s' % (e.strerror, include))
+            try:
+                fp = open(incl_abs_fname, 'rt', encoding='utf-8')
+            except IOError as e:
+                raise KconfigParserError(self, '%s: %s' % (e.strerror, include))
 
-        inf = self.data.incl_info
-        self.data.incl_info = { 'file': self.fname, 'line': self.line,
-                'parent': inf }
-        KconfigParser(self.data).parse_file(fp)
-        self.data.incl_info = inf
+            inner = IncludeInfo(file=self.fname, line=self.line, parent=self.incl_info)
+            type(self).parse(fp, self.data, inner)
+        finally:
+            fp.close()
 
     # recursive descent parser -----
 
-- 
2.54.0


