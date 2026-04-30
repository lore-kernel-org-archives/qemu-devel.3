Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF387FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV66-0004fI-H8; Thu, 30 Apr 2026 13:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV65-0004es-9D
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV63-0004Fv-Kv
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnwQlRGzVUExHxF++9i6qmAddHxNllxRA7d5XP4c92o=;
 b=BP/79UYNI7jBftuRJDON4jRyzAxPPAdMg9bNdlDJkU2il3fSRyOiHmP75cCO0toZxSSoee
 qOYKbnzO3PKZtlA1gNEyvJlHDS2YLVJAi0b006O/TXVDXdI9B40QrEzI8i7+xS1VqsR2Sz
 AhXtv9InC1aJRmE4mBcuJp6bLTyYWOo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-AxFH65KnMCyPmeyae6sV_Q-1; Thu, 30 Apr 2026 13:22:41 -0400
X-MC-Unique: AxFH65KnMCyPmeyae6sV_Q-1
X-Mimecast-MFC-AGG-ID: AxFH65KnMCyPmeyae6sV_Q_1777569761
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50edf01172bso28634101cf.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569760; x=1778174560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnwQlRGzVUExHxF++9i6qmAddHxNllxRA7d5XP4c92o=;
 b=OV707WOikVKSCXCr8qYWuGtOqVAlGx/1No8CqvTvR8tdL9LmwKvWrqDoY+5LyYFVdV
 7nzOfVn8+j69G5AyAopq0fAB2g93CVq59wFwkmEy3Us7Lst9kkCCHwsaGd53Pt8aJ5U+
 WSY9WS22wSuvpEUxNwCN0dBvSsqoM/Wp9iFcqam3W+AfavYOecU6sU04HK/xtQkf9ALY
 5lRCVoMWG9d51IPxxZBrJidJU6jRPST74p3BpAQOaub7CXmER7bbKzt0UXvbwTMt+9W9
 57+VWfflFoCdwf5CbWGgALBL8HUx+9VppoqhQnEtcb5HXo3mwZSN/SAYd9Rn6az/PrEa
 qyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569760; x=1778174560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FnwQlRGzVUExHxF++9i6qmAddHxNllxRA7d5XP4c92o=;
 b=RwsdOQ+Asmo4QPDMJRcGruvoXC0yI9GKlNDca40ee/SCSndDkDcj06v7+FlU2qCKPS
 jbcOJuY8KlSGQNe6zNG5AohqvdMVbsoR4OIa6H6hdvHn7eVDUFIlXdBv04yB0QLrJZLb
 SWsYTmFo7KS2hSEI6WpfvkMlo1NrCVbZpt+VRV/7c6ihTdUZc+2bZVbquqPmJyBM3ZUY
 ef/yfjQyFYDyxDwrRG9d2hPNqf7S3ctXvlzG5Ne0GEW4KV+C1aa5TQsNq083/NZ9XHy/
 uFsSXpbnO0f8BJKjRKBhE8Cll+nhA5WXs34v2C5FDXUBaHhIuKk/Xe6YdYvI3uxqbDC/
 CviA==
X-Gm-Message-State: AOJu0YyZsewN+w+SSG/l/EEZekV4kwMX7zdlxU7FYv7J6oyKvLwOjF5+
 CWrPs8iLlJmfhAMRCQWx+Tu4+mUmfzfx9EnKX5/ccp4Wru4HKlmXcVSaIMcwHOM3TtB9RrEcPfR
 HMZf60RACA5Jx6j4PhVJJ2CodL6CVu8K5Xp8y4mkokocDqnuK2nj4EyR8HjPOabBEsnSKuay6yD
 ABfnFadsRURDiFioh2pW9fd1FkBqe/m30OD2M3puOW
X-Gm-Gg: AeBDievGC36OUkLIgiYxqkqKTnGTWiu2pV1NbE4tVJkihAuHDmDu/omu4QHBCOOno6S
 6vWB8ykuYx9mw7H0YY6p/4R9cEJ4xc+cT3+4ZF/9GutuC3NxK81MZHpXDUF4WHlSse2kR2On5CT
 pEyEo+aJ55ElxnRvTAGzQWENr8dvz44D9ng5/f8oxcOBoydxeSxtHtaY+oRTEwGrjZx77kagRzJ
 iLj9st882zt0rfz5x7rV/yV49NZq9leWGsQOe8N2snYNRImoqzyFaM3s6F6IeDTnvWiMOw1nudj
 8KQroO2+ySDhX2danGBe+FNBoAX0Gg1r+DSBvOaqvqiQVz4yKm35fGlI4fKHSZ7Fg/g00Ej7jJk
 oZ23GPiQ2ejH7IKUlKhWmu0ySJaKtjVhtz0h49wyFs0iaLsAVbvHKoQ5c15WV9pgyJdsXGUh9Tu
 FmRpACSqWrcN0G+OMC6Linjzzw+7LkBs7shOk=
X-Received: by 2002:a05:622a:64c:b0:50e:5d24:db5f with SMTP id
 d75a77b69052e-5102ae78731mr53000901cf.60.1777569760236; 
 Thu, 30 Apr 2026 10:22:40 -0700 (PDT)
X-Received: by 2002:a05:622a:64c:b0:50e:5d24:db5f with SMTP id
 d75a77b69052e-5102ae78731mr53000191cf.60.1777569759544; 
 Thu, 30 Apr 2026 10:22:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d206793sm503031cf.11.2026.04.30.10.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 09/58] minikconf: move command-line assignment out of the parser
Date: Thu, 30 Apr 2026 19:21:15 +0200
Message-ID: <20260430172204.1006673-10-pbonzini@redhat.com>
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


