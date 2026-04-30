Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF6FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV65-0004er-0C; Thu, 30 Apr 2026 13:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV62-0004dr-3v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV60-0004Et-Hk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1c1ijwUc7ufXMrkyywVeD81tZX1EKRChOVW214SFpU=;
 b=KY/2RjJ+4hHiMQFJ+VGI/6fV/tqmv1RQQUJNtVSIHfWpummkA2IrKb7P/THlCu32GXic8F
 arnDNZ2K7JL0EQ/YPrMP4MPlnQKXmBYpNCxrrK7D3TxVZ8sF/sT4+qw6fPHShL3iKjSWy/
 i3VZboN3igUFJoRSGMS+h5VB+HehKbg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-i1o91YZ_PQGYHFFf_lh9yg-1; Thu, 30 Apr 2026 13:22:38 -0400
X-MC-Unique: i1o91YZ_PQGYHFFf_lh9yg-1
X-Mimecast-MFC-AGG-ID: i1o91YZ_PQGYHFFf_lh9yg_1777569758
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8acb26fbbb2so19343626d6.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569757; x=1778174557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1c1ijwUc7ufXMrkyywVeD81tZX1EKRChOVW214SFpU=;
 b=oPFXLr4p8aUiNOmZ1ooiYTUxVnJA+q90KHAK18XQVqVMMdzIeTeZ7eMS5VGKMzMvTP
 0Te3vuvQ0dV0XyIBcFArHmdlh1mD7qT/GsqHAgIGfEXLplwyOs2lq07rHtulyu/01t3j
 S6cfcXBDCk77uh+MTnsdmmwExMMtHJBdAl5VpcP5vwnZ0n2f6x3xhTK1ke5P0ClXEB99
 dIT7sPkBcZSPE4ZnRdzNixqhf1p0pXqeIWFWBxUe5fJuWz7AsuRFcFxYv+HBhlsxvw6w
 aaA496xS6AexFkVA91/VX5VWGko11KuVs+A6j5LNlqa+Y3NRyQskxILl1CaDLkrg8HIx
 8ILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569757; x=1778174557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H1c1ijwUc7ufXMrkyywVeD81tZX1EKRChOVW214SFpU=;
 b=A6sf+/GSx+vOIGBqyRrP45pytC+vb0rXlfh3ZiolyrpKlkVanxT1sF9KRkpIkQw9eV
 RfP59nF1ClewL/Phtt9hSEbkRjZksLt1LNK5/SJJ9UGGNTBRRdgomxmw6DB52IIN1sOv
 VJc6a3TfJr0fTdmlEq5YHTVa7QtUeg7PfuUlrQun/aEmqS9EfVqn9GDJTGbswsws9PkV
 uTkVUUoCUtq4JJ+zicHvbwK4ZeCgD7uueWjAGvdFImtoKGQHdmR6fPrMUeXwK7xITlJE
 XnJOLKMRrnK39NjoZjS2GMelr4a45MdeNWbtdSaEIh1GwIgfPkMV8iG/0GRGF1b1tBqx
 wo6A==
X-Gm-Message-State: AOJu0YxiYjFntP/ereaAIrKv6PIIfYY6j+Mp/A2awkJPOKKE5fLgw2iP
 6tDNzyZxSgpsxI63OZZdk6Djxuvq5RuvJVLn0+W3oypnO2XvwKhzU+jUkfeZ6nsJXE20PSP2efl
 Qz9yKoJqZCPgtwFNbiUCFW/3YOZKu+JMIcIFYvgjKEbYx9wSFffhswcsXrappHIdVN4iPTbyuCp
 eUly9K1wAudZJP9m1kLxmdDRULnaEDvyyWIMkgDWzw
X-Gm-Gg: AeBDieuMRcWBeqXgVK0q8+kYZRxn0cPHNt3/mWc+e/jO+AGjPQittjf54DJC0JPx+Zv
 sV+1jY+yiI214hEAqS/iIFPbGfMvFcfjiVoXPaOWksk5/+dN1+bsDstTIUhgplNIJXqwdv/ba2g
 yPTq1OX/YIGIJgsFjB6aDF4gfhmpyWccjH7EFkJPTcCMwyLFVg2uDBArTCCRZp6OSPlBTdB4yO+
 tVrHJYrDndCgNAot+hFQHX8Al03r/Hp+MJRDBEIsGP5kM4tTjp3OlwVuiVtwMLFn099TlNSwl05
 EOnV7loIuCxXRS2SECbxMVkyioTWVl1wIWMsPS0IMsWQW6uZnKCSG/78vf2GokOUYeXaQjxZJQs
 k0Jcqs/W6fqSwm5lw22oYqzJA05ShxAYgfkngD7LULKEjFOCre55IDWapKoi7ppPuXKUJh/xsEV
 rxUI7pgZCtiikc/VftLVydWUvwqp/xBfvqgt0=
X-Received: by 2002:a05:6214:e66:b0:8ac:a914:c2da with SMTP id
 6a1803df08f44-8b3fe6e666emr58369636d6.2.1777569756903; 
 Thu, 30 Apr 2026 10:22:36 -0700 (PDT)
X-Received: by 2002:a05:6214:e66:b0:8ac:a914:c2da with SMTP id
 6a1803df08f44-8b3fe6e666emr58368616d6.2.1777569756130; 
 Thu, 30 Apr 2026 10:22:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff335ccdsm22777456d6.20.2026.04.30.10.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 08/58] minikconf: small cleanups and dead code removal
Date: Thu, 30 Apr 2026 19:21:14 +0200
Message-ID: <20260430172204.1006673-9-pbonzini@redhat.com>
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


