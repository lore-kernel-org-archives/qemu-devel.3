Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84020FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLF-0007x9-Gm; Thu, 30 Apr 2026 05:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLE-0007ws-A8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLC-00037U-Pd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QCCs4RCOmtYxMOzifARQG7+H6mlv0elKLtfHjPN/uTQ=;
 b=TZY36L56rvuuqJC3Fzsh8ZHem7ljdWxcVnlZI7AXu58Cl3sHMD1ih2G/HLYPbMIBIrkeDM
 zcf9z4TCfioHFyZwzjDjkDrFYzxavmKg0pEnXYkGH7f6Kvuor0I9i0YW7gNvszw3JBx6a4
 7PvB6pBJrFORjyhdZydnQkBThD5a3Qg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-Twa8p2ZsOx6ik1hSP7qggQ-1; Thu, 30 Apr 2026 05:05:47 -0400
X-MC-Unique: Twa8p2ZsOx6ik1hSP7qggQ-1
X-Mimecast-MFC-AGG-ID: Twa8p2ZsOx6ik1hSP7qggQ_1777539946
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488dcaf2f2fso5316955e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539945; x=1778144745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QCCs4RCOmtYxMOzifARQG7+H6mlv0elKLtfHjPN/uTQ=;
 b=mjQPh12wrRio8GLm3YkycRD5Nl6L0l8Uen9aYL9LVMZTx4ZLmzpBs2h+BJyus8Z1Zr
 eb6Ky7xN4jEgdrcBkVybLcSNuZAFZLoaamJnt7qP3TaDmJXadiQIaV6sj5dfhMeOx07o
 /T9pFFDTOqZgqF1wJAluUHgDeELu7pa8d19n/baxYgHKX6yEi/wVVPe2WzjgESGz6N6B
 m3z+x2/H2Ujl8oizVi7KB5ahByNMfMb4yRWb7vIiIdQclB1hDJLm4XycYKV+rAGm+YCr
 JkfkkT+tkIrvEagnk7OMYQZnQUL7RDAbYZNfweQQn/p4EUgysd8aepRDEJVHKs7LBAI3
 3nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539945; x=1778144745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QCCs4RCOmtYxMOzifARQG7+H6mlv0elKLtfHjPN/uTQ=;
 b=N86oimd5NI7giHUQlr/TXqaitOK++DmxnCuNy8CtbDmFs9XBs0ASky0K2l/ZK2wP9t
 b81VP+3kRPSi94cBrHY+vu+TvlAAhWpdmxKnJOmCiSO3qbsZpIUG/t1bypYS0sm9b4me
 fWbu3TtLQncdecu1vlE2t2OhUzL7YRLFuNNsVpyL/SCTYg2C87iB8FZYwu5jexrEV0yd
 +kp3Db1qDJcxvgOv+qxn82f+oP7lKijryCZ2OB26HvuXczZYATAiGM41kJeq3vEK0HkV
 ef3PEvlhYz1Bws443rcgDsGCWZyIHZ9fTirL12p1kVy3RUxvoTa76h51liH5QGYjUC8V
 +8sQ==
X-Gm-Message-State: AOJu0YwvZlwBe18I+CxQrxsw+v1TCPN4UKPheSKiTCJKMGqbSZ4evMkq
 5cb7SXmdsovdiqUSW7OlHDyjTeTtK03KJTztMrETm4aBEq/UqN5y0hoJSUuFLLpAVcL0BKI4xrl
 aYt2FVG45dR0gwJU/W7B9Lu5/teVgVUTdmo/P9VBZ+6z2+ZRWtBV+keEEztNSozSFPaibF/yxQu
 Nj6BBgXND8YqUoX/GydmVLH6tPjRoqygFcIiHw2i8b
X-Gm-Gg: AeBDiesDxwv1HZ6zncOjqTatnSSeB0i/eNqFq+96DmVkYqGCm+XHRjiWDfNNi3gZSi4
 mtnA8cyVdX3bCAr227a0U02s2oui+Q5T7r3+5vRxT90fCG/d/7QxwHO46UMPYUagDTe8Ymye3N4
 XlTVhKWKvJp5nEDNw6lYiMTq2cDuAK/Ib81d7d+kmrVKsydklbAna43ASxZ+ZFq86H0F2o+/3qY
 iLgNUj79uRp+UoIv4RaxK53geGRIBQ8a1neOJ+b+GfXpBiiRwBQ1ZwGP0w2lAJEZI9xjYEsdt9t
 LixMa/oiCOEEv+olSIKMCvvWIsjQ8mGJHpwfb2g4991CMlbSnbq7EQq6Pj3ccPVFziph9YaJxXO
 2j+9umah94XUbXhu8jBVKYq1pGWU7ALti+24G0xbgPlok4abVTj4NvAkSp7pfB+9rcBO0lQBMNb
 LyhhVTDMFQMKLHFGLa8k1mQsMxN2CUwvh4Rek=
X-Received: by 2002:a05:600c:888e:b0:48a:592c:e655 with SMTP id
 5b1f17b1804b1-48a84446da7mr26054825e9.17.1777539944652; 
 Thu, 30 Apr 2026 02:05:44 -0700 (PDT)
X-Received: by 2002:a05:600c:888e:b0:48a:592c:e655 with SMTP id
 5b1f17b1804b1-48a84446da7mr26054365e9.17.1777539943990; 
 Thu, 30 Apr 2026 02:05:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b4216ecasm11966391f8f.14.2026.04.30.02.05.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/13] minikconf: small cleanups and dead code removal
Date: Thu, 30 Apr 2026 11:05:25 +0200
Message-ID: <20260430090534.841894-5-pbonzini@redhat.com>
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
 scripts/minikconf.py | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 24389763db0..08df8d5dabb 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -108,7 +108,7 @@ def __str__(self):
             return self.name
 
         def has_value(self):
-            return not (self.value is None)
+            return self.value is not None
         def set_value(self, val, clause):
             self.clauses_for_var.append(clause)
             if self.has_value() and self.value != val:
@@ -158,7 +158,7 @@ def __init__(self, dest, value, cond=None):
             KconfigData.Clause.__init__(self, dest)
             self.value = value
             self.cond = cond
-            if not (self.cond is None):
+            if self.cond is not None:
                 self.cond.add_edges_to(self.dest)
         def __str__(self):
             value = 'y' if self.value else 'n'
@@ -212,7 +212,7 @@ def __init__(self, value_mangler=defconfig):
     def check_undefined(self):
         undef = False
         for i in self.referenced_vars:
-            if not (i in self.defined_vars):
+            if i not in self.defined_vars:
                 print("undefined symbol %s" % (i), file=sys.stderr)
                 undef = True
         return undef
@@ -220,7 +220,6 @@ def check_undefined(self):
     def compute_config(self):
         if self.check_undefined():
             raise KconfigDataError("there were undefined symbols")
-            return None
 
         debug_print("Input:")
         for clause in self.clauses:
@@ -270,7 +269,7 @@ def do_declaration(self, var):
 
     # var is a string with the variable's name.
     def do_var(self, var):
-        if (var in self.referenced_vars):
+        if var in self.referenced_vars:
             return self.referenced_vars[var]
 
         var_obj = self.referenced_vars[var] = KconfigData.Var(var)
@@ -339,9 +338,9 @@ def __str__(self):
 class KconfigParser:
 
     @classmethod
-    def parse(self, fp, mode=None):
+    def parse(cls, fp, mode=None):
         data = KconfigData(mode or defconfig)
-        parser = KconfigParser(data)
+        parser = cls(data)
         parser.parse_file(fp)
         return data
 
@@ -352,9 +351,10 @@ def parse_file(self, fp):
         self.abs_fname = os.path.abspath(fp.name)
         self.fname = fp.name
         self.data.previously_included.append(self.abs_fname)
-        self.src = fp.read()
-        if self.src == '' or self.src[-1] != '\n':
-            self.src += '\n'
+        src = fp.read()
+        if src == '' or src[-1] != '\n':
+            src += '\n'
+        self.src = src
         self.cursor = 0
         self.line = 1
         self.line_pos = 0
@@ -534,7 +534,6 @@ def parse_property(self, var):
     # properties: properties property
     #       | /* empty */
     def parse_properties(self, var):
-        had_default = False
         while self.tok == TOK_DEFAULT or self.tok == TOK_DEPENDS or \
               self.tok == TOK_SELECT or self.tok == TOK_BOOL or \
               self.tok == TOK_IMPLY:
-- 
2.54.0


