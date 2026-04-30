Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA8BFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLN-0007zi-O2; Thu, 30 Apr 2026 05:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLK-0007ys-2A
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLI-00038n-CL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KDJRYPPLDzkY3EK1Q+ay5cnp96vxNf8VANGXo/2TzNc=;
 b=gabKHb/SeWpeR/s7yVL4q5G2hKi+ordy7JVKRdhImCy+gttP1FYjW3GgpbuHXETTkmBFht
 yJfz9OYiFiYmIqW2CmhrYIXWg9QFcSqPNep9RnZ6TPXuj95KY6+w30HNOZ89OVU8flICtF
 6ttmlWMhKOCXgR9JheV4b4OtIk08iok=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-zCYeDxwAN0mNICdlYZdfFw-1; Thu, 30 Apr 2026 05:05:53 -0400
X-MC-Unique: zCYeDxwAN0mNICdlYZdfFw-1
X-Mimecast-MFC-AGG-ID: zCYeDxwAN0mNICdlYZdfFw_1777539952
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488c0fcc6deso5134915e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539951; x=1778144751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KDJRYPPLDzkY3EK1Q+ay5cnp96vxNf8VANGXo/2TzNc=;
 b=JBu81qUtHoi7Bwmd6Rrqs+myobzQ4YOoK2I+v6c+Wj4bHDESeBGT/osY7JspwED/Vb
 lZkJNw5SdxceM6DgPdMhUBWXqy0k9KNmnZlyO+Y+4+GlCEOI4BTvgvLkb3DlfFXtEcaB
 EReSSC5S1IfeaREiXs6WlaAUnpqsJmY4uqNKXLs01EfkO5QmVC0QIFNk9fPpC+2coMIB
 3IYElJcmJRy4j7HjFK69Y320nO5rXpt/JGVYEWi6R/EXl4rEOceWkwda8DYp90WFoNUH
 yzmscuS0UZuHeJ1prCmo8WQejcGeW9MHzJSTD3AN88nDCbJuo99740dm+XPFPOQDuIJy
 KB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539951; x=1778144751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KDJRYPPLDzkY3EK1Q+ay5cnp96vxNf8VANGXo/2TzNc=;
 b=ot45jGyaomRRWdUXCoVwI8zWMGD5V/n1SX6Zmsjt5GIAD4nq1Uvm354WqSxTxJezAK
 uyBCOv5m5FwCp2hZi8Hvm3S83kTkiOE5Zk5seCLfK7uDYqBcsX5jFlmb1Sfk6gPi1iA+
 KNq2Z5ZZrhUTu1B/iHhCPk1oQZN06o0kCOUPogYF38nnJP5idAzCV/QUYa/zMkfyl+3b
 8mw4pfQq1E5nygGDTEPqgJrLa3octsDMetvpVg96Lqf7svGEcX3Cb2ozkpALD29pVAl2
 FfQKqxdTiFZFxu89jicMyy4Y5JfzEnUs6j+jCPvv/I5O8/yKUdEFP/JG2rJq7/7w1UF/
 9s5w==
X-Gm-Message-State: AOJu0YxisQU2FjIQZ1V3xThsE6AuJPlRV7p5SnqPJ6KfVC7+hIJ+p5BK
 A/4NW4HaXJJXAW0penkdADtxlRsLeEEgait5ccYEkWa07iBQuXiSwucmo4pAD4959reqaCyQf03
 1a60Lru2Mu9ccIz9fajBCl7x4CaN6LBEeBvYyC7adqm77issNfgpnCzCgPFk6ZNbP6vSyObO/Ih
 598dy+WdAypOO5opIqkRcrLzelTbLiMddMt5Yd9a56
X-Gm-Gg: AeBDieu0yQRLCQudQfHed6LkH7d/jGOK8PaSMKcN2pVcFWDAamOdhQ1JQBq4kamj+89
 D9bLO+cXMBRDt5b/VRxFxnfDaXTGOD+VrZSIhBvwkInIWUjChPhfaxZM1IM6eONLgDDMLcYeOpm
 g9YTrQZiLZ2If7KX7LJz3YAma/WxmZIS4a6JmiamkPAbf6hl6jvdY+EO7kbYxpKsFEcqpc/yaUZ
 YU0pEOGmEhVGnrKLKp5KwsCXHbPl7OyNIfqwF/xLG7u8w5uyVATE92U5DtHyXQyjhy9bmhk4uN7
 6jPZXjqmF7igpCV4qxZRDFOkSqRgDHsDPUeqMIH9MAUJG91oRrSfq1RqgHHZQ+ZmQkLHGRjM6ee
 6VGf48tpVN0xerLzsKYf9gjMWsqGzU9oh6LHt6mp2HotKLekr2WMGJxM19AFtkr46+YY5iL+/OR
 rzcWhS5j9M5HIHd983ihdgkzaXPW6t/dpVzrU=
X-Received: by 2002:a05:600c:a14:b0:489:ecee:c4ef with SMTP id
 5b1f17b1804b1-48a84451b9fmr31196975e9.13.1777539951344; 
 Thu, 30 Apr 2026 02:05:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a14:b0:489:ecee:c4ef with SMTP id
 5b1f17b1804b1-48a84451b9fmr31196365e9.13.1777539950735; 
 Thu, 30 Apr 2026 02:05:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b9219f3sm44778695e9.9.2026.04.30.02.05.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/13] minikconf: modernize handling of include chain
Date: Thu, 30 Apr 2026 11:05:29 +0200
Message-ID: <20260430090534.841894-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430090534.841894-1-pbonzini@redhat.com>
References: <20260430090534.841894-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Use a dataclass, and store it in the parser to avoid having to
save and restore it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 66 +++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 3d63cc6b21f..07a5152ef54 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -15,11 +15,30 @@
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
@@ -202,7 +221,6 @@ def process(self):
     def __init__(self, value_mangler=defconfig):
         self.value_mangler = value_mangler
         self.previously_included = []
-        self.incl_info = None
         self.defined_vars = set()
         self.referenced_vars = dict()
         self.clauses = list()
@@ -342,13 +360,12 @@ def __str__(self):
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
@@ -360,19 +377,9 @@ def parse_file(self, fp):
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
@@ -380,33 +387,34 @@ def location(self):
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


