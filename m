Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE2BCD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLH-0007xn-6L; Thu, 30 Apr 2026 05:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLF-0007xE-L4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLD-00037k-Gj
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gtxuAH4PAvxNT4xHNaNPMHcitxd/taN2BN54e0wKh4=;
 b=iF5zLrwZOCaj2oRUOQOZNwt0WUO44pNQHC4Y6tiX5cjna43kc5QqXLgtFr1tPA/tOsimon
 aITp+ts8+B0vaOuQiPMWEwt2QPg0Y2Edsulm/vqVmZHkUyu+5yTC8B2VNAggUdks39cKnb
 8MiEg5xztgwjse3LZQx8WutkPk8BA1U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-R5PVMPgcPZGwu6tDlDczhQ-1; Thu, 30 Apr 2026 05:05:48 -0400
X-MC-Unique: R5PVMPgcPZGwu6tDlDczhQ-1
X-Mimecast-MFC-AGG-ID: R5PVMPgcPZGwu6tDlDczhQ_1777539947
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48a5775d647so5622735e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539946; x=1778144746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4gtxuAH4PAvxNT4xHNaNPMHcitxd/taN2BN54e0wKh4=;
 b=cB/sqnBzHzkf53K6bMtS7fWgVK0BrnEH3QAhPjO5DSeYoF7QraEo5RqjkfVsKjD3a4
 9pYxFhkZ+LAdnmuiP3A+EP26S48zA6egZRDz/Npue5oJC1ERtW4PcxshUfAZrWoVbTxb
 LhPYaK4OvrQTYpVeTsS6Z+6HOlKU/okCs6xEXvclWpgOxam9sORjoa2TVBCZE70VC9YS
 VCCLdRu9456EvnmFXQLhh9z2y4pcJFkJ7ixJEMU446R2wySL//zReXkQM9oLOFbiXrHi
 /LBMGU3m042UA8tjzqiTRppOd5f3O6AHb5wdmVam6WdZYuvjP+wkwO7MnihweXtlUOM6
 aVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539946; x=1778144746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4gtxuAH4PAvxNT4xHNaNPMHcitxd/taN2BN54e0wKh4=;
 b=sMAeT54pN74cOWvw7El/LiCfVPPyHgM7HAlukKDM1r6O4j1QtY0k481eSNzgrK8n7S
 jl3jPI1VZjpRQQZpwhoUywGUC0dG1y0spXDGtdK4NU1KNvbUu3CppZj1NgkN2YZNQxQy
 NrNLhaQnmpQbsP2bZfRaD+P9kmAxTTlH/M2DklnkeTRYAymyH1Tev4sFzq4HO9hflcD6
 nJSQJbP67m4j4U04tQ1oeHjxLvTXq5L+8Q8f21mn1L1XKf0GgDx4Q4U9VsxWAf065N4/
 +5bUf8Qa2SJLkKGFmPpRNd7RqNmNei5DU13pIu5TPAMnyCmZOOEQV0Pea/Vv4FkN/P3f
 C67Q==
X-Gm-Message-State: AOJu0Yx1boPlunHgBW4mNpSDz7R2zYOZ738YucGHTYP2r/Z96xk7cpTa
 GS5hLxsraAYzG9kyjZlugFOcA/PQOVYX/B4QccFEI5es9Ta1xMnKW4jRyaG18YZ4dItpQmmKjDq
 05C32yKz8ZKi2swVJf03dj56fMTYbIJxhiiWHnOSoS2FLU/UECkvkGQDF2SWu8xfyNyO30p/CGe
 AYl3tEyhHME2CLkT5kV6KyEOqwkJLKdSscbUx4dOh9
X-Gm-Gg: AeBDieu097q++bUlEh1SWuLtrYKktmp9NeacR7VhXd/VBNAPgJeJn7+D1wyhuYCePh0
 c+wCjveg0iOxdl/Mj667VK/s5yM6dwwW+kdZpZFaWNlJ+DmzTbQbH0KKcM3sAWjFMnNEZS5gd3L
 yaSv2/oBstFeXnKxTWgkIHwR25iCA0bvo6RzAhhWMRC7VlUQHATF8CTYzDfZkqKuWfSJfvItqtJ
 fK8g9pZjx04n5e7S6L5JVlZxIQ6gtyXLXX2B9lUE24A+NWzCJ1K8D92BwmQ+b1rDzs+tjY4hgcg
 0uf7ejucOScWO+1wxPTVr48SdbEzJo9seUjH4xPvRPF0dbcOMJ/ZDic6ap+rGMVw2lmQVTsJcQM
 7wHRZ5GrZhJjPsJ7Aff4IaTC1n8ok6qGkPPs1bma9LJycAXI+w7EU8Us6l0bimyivt75IX3B63s
 yx37Q6/doJuVOhk3SFDzWHAMyfRw3ZiWOuRpk=
X-Received: by 2002:a05:600c:c4a5:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-48a84467651mr33692915e9.18.1777539946098; 
 Thu, 30 Apr 2026 02:05:46 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a5:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-48a84467651mr33692325e9.18.1777539945419; 
 Thu, 30 Apr 2026 02:05:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c1d0228sm138960685e9.2.2026.04.30.02.05.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/13] minikconf: move command-line assignment out of the
 parser
Date: Thu, 30 Apr 2026 11:05:26 +0200
Message-ID: <20260430090534.841894-6-pbonzini@redhat.com>
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

KconfigParser.do_assignment() only exists to handle CONFIG_FOO=y/n
arguments from the command line; it is never invoked while parsing
a Kconfig source file.  Because main() called it on a parser that
had never been through parse_file(), a failing CONFIG_ check would
raise a KconfigParserError whose __init__ and location() touch
fields of "self" that do not exist yet.  The regex in main()
currently shields this, but it is fragile.

Move the prefix-stripping assignment to KconfigData as
do_cmdline_assignment(), simplify KconfigParser.parse() to accept
an existing KconfigData, and call it from main() so the parser is
only used for actual file parsing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 08df8d5dabb..668de577d09 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -278,6 +278,10 @@ def do_var(self, var):
     def do_assignment(self, var, val):
         self.clauses.append(KconfigData.AssignmentClause(var, val))
 
+    def do_cmdline_assignment(self, var, val):
+        assert var.startswith("CONFIG_")
+        self.do_assignment(self.do_var(var[7:]), val)
+
     def do_default(self, var, val, cond=None):
         val = self.value_mangler(val)
         self.clauses.append(KconfigData.DefaultClause(var, val, cond))
@@ -338,11 +342,8 @@ def __str__(self):
 class KconfigParser:
 
     @classmethod
-    def parse(cls, fp, mode=None):
-        data = KconfigData(mode or defconfig)
-        parser = cls(data)
-        parser.parse_file(fp)
-        return data
+    def parse(cls, fp, data):
+        cls(data).parse_file(fp)
 
     def __init__(self, data):
         self.data = data
@@ -361,14 +362,6 @@ def parse_file(self, fp):
         self.get_token()
         self.parse_config()
 
-    def do_assignment(self, var, val):
-        if not var.startswith("CONFIG_"):
-            raise KconfigParserError(
-                self, "assigned variable should start with CONFIG_"
-            )
-        var = self.data.do_var(var[7:])
-        self.data.do_assignment(var, val)
-
     # file management -----
 
     def error_path(self):
@@ -688,18 +681,16 @@ def scan_token(self):
         sys.exit(1)
 
     data = KconfigData(mode)
-    parser = KconfigParser(data)
     external_vars = set()
     for arg in argv[3:]:
         m = re.match(r'^(CONFIG_[A-Z0-9_]+)=([yn]?)$', arg)
         if m is not None:
             name, value = m.groups()
-            parser.do_assignment(name, value == 'y')
+            data.do_cmdline_assignment(name, value == 'y')
             external_vars.add(name[7:])
         else:
-            fp = open(arg, 'rt', encoding='utf-8')
-            parser.parse_file(fp)
-            fp.close()
+            with open(arg, 'rt', encoding='utf-8') as fp:
+                KconfigParser.parse(fp, data)
 
     config = data.compute_config()
     for key in sorted(config.keys()):
-- 
2.54.0


