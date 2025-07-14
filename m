Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D7DC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 12:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHam-0003BL-3x; Mon, 14 Jul 2025 07:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1j-00027P-LI
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1h-0002GC-1f
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQgnwOxm8SMdCCueXNSX8RnBbLLlgFWSXKeYcZQinkg=;
 b=NDi6FecKBgcgxr1LtnnMYqgk5iPHdGyZAm63MkW1rW9rT4VPalwFuWkNsdzdU1qtr/4T5R
 p/Gv1F92MSqiX1E9SD4ZuQe6fLC4yHbFgvUBfi+UAT8/oOPsw2BRaGN7X1qxAWy3Whf33a
 uxYOTfHM5OFNRZDMwlkiv/myDZE/FFk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-5tJmpG5-O3qpMolxSA9wrw-1; Mon, 14 Jul 2025 07:07:14 -0400
X-MC-Unique: 5tJmpG5-O3qpMolxSA9wrw-1
X-Mimecast-MFC-AGG-ID: 5tJmpG5-O3qpMolxSA9wrw_1752491233
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b5fe97af5fso422425f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491232; x=1753096032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQgnwOxm8SMdCCueXNSX8RnBbLLlgFWSXKeYcZQinkg=;
 b=rt5GzcfYq5R+ct4s1mfsOo86JlZ1VmKLShulPY8zntfAz/cFh4Njy+TBc3diFDkCf8
 /DV2wvv3D6qCh78oOUBlUooHtijHXD9GbbQ0bLcTNTA/1D3lpwBY9/ySHCtyIHDPZcAI
 UtAncZ6sorwaFdvE8rJ0iPrX3qdUqg8b6DDXfFbhAK9Py4Bak98Qrl7Tet1kzQyWnzKt
 1EcVKArGUu2nZbZ+UL32VrgJOVq3bjcpnwOy67DLHE7yUNWf+Cf1Z67+vTC7IPYBxAq1
 eOz/QD8cHrYXG1vF4N3scSwJ1gDAw8p55HAtR00pn/5SwZrDLXyPAeyFH8z/fyQqRS3V
 Rm5w==
X-Gm-Message-State: AOJu0YwGPnB0hFgSFGDTdnfGaQz9K18KTXvyPjqwkFCSPsOYaggKnSUQ
 l1TCDFjyZGGKfLSAAA9kns0SirTfiWhw2rqtijPVdgUGSJLCgDA8BCRWyCa9GU6sk606cZC08F3
 79OWNKz/cidsj0/n3PqeiKUXjc9BYypDOxDOuyO1ep+EqfBDoMj+KQFpuLNC9tuANYYNWayNf8O
 ApWbq3CWIjklEu2PJYoAftgANatZms/8V7LT9ibLrT
X-Gm-Gg: ASbGncunlCxdhSFEtKmlJfM5l5mtQRHKlhIRr0MN47DNKmC3p2gEYWxBiHRxZmty/Ec
 RxrO6NUg11eQrnrsRknqKvJJ6cQFkXnIAAizLEU034YWZbK0LVjCTPQ7ZbV6SFU+b8ZSBAM8LiK
 1ueaOe8n5R+i9Z5ZGZay+qSVLLl7QBuLT3VOVFFjXprdaREgHIby5lOiob+BbFrVz2GktSHuiiJ
 HetfkSUXZ5DPRuyY26AYATTZLoFHUO5hCa16ORl159D46D2tOaWOlir4NJk3LnkinHpul3SjWbS
 Oc02dhqqJZn6OU4jV4HAS++zDMCYVitU9Kgm0Bjx+RA=
X-Received: by 2002:a05:6000:2d09:b0:3a6:d967:380e with SMTP id
 ffacd0b85a97d-3b5f187eb90mr7211842f8f.3.1752491231935; 
 Mon, 14 Jul 2025 04:07:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVQXd3d7/7yqLaRZct+uWPNhQxB2eIwxMFqqZlpk1TrWexlIzulZk/PRVlU3xs3m9IzIFVRw==
X-Received: by 2002:a05:6000:2d09:b0:3a6:d967:380e with SMTP id
 ffacd0b85a97d-3b5f187eb90mr7211812f8f.3.1752491231163; 
 Mon, 14 Jul 2025 04:07:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1736sm12262538f8f.15.2025.07.14.04.07.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:07:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 71/77] tests/functional: test_x86_cpu_model_versions: remove
 dead tests
Date: Mon, 14 Jul 2025 13:04:00 +0200
Message-ID: <20250714110406.117772-72-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tests that require machines older than 4.2 are now unconditionally skipped.
Remove them if they test legacy behavior, or use the latest machine if
they test current behavior.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../functional/test_x86_cpu_model_versions.py | 110 ++----------------
 1 file changed, 12 insertions(+), 98 deletions(-)

diff --git a/tests/functional/test_x86_cpu_model_versions.py b/tests/functional/test_x86_cpu_model_versions.py
index bd18acd44fa..36c968f1c0b 100755
--- a/tests/functional/test_x86_cpu_model_versions.py
+++ b/tests/functional/test_x86_cpu_model_versions.py
@@ -72,44 +72,11 @@ def validate_variant_aliases(self, cpus):
         self.assertNotIn("EPYC-IBPB-v1", cpus,
                          "EPYC-IBPB shouldn't be versioned")
 
-    def test_4_0_alias_compatibility(self):
-        """
-        Check if pc-*-4.0 unversioned CPU model won't be reported as aliases
-        """
-        self.set_machine('pc-i440fx-4.0')
-        # pc-*-4.0 won't expose non-versioned CPU models as aliases
-        # We do this to help management software to keep compatibility
-        # with older QEMU versions that didn't have the versioned CPU model
-        self.vm.add_args('-S')
-        self.vm.launch()
-        cpus = dict((m['name'], m) for m in
-                    self.vm.cmd('query-cpu-definitions'))
-
-        self.assertFalse(cpus['Cascadelake-Server']['static'],
-                         'unversioned Cascadelake-Server CPU model must not be static')
-        self.assertNotIn('alias-of', cpus['Cascadelake-Server'],
-                         'Cascadelake-Server must not be an alias')
-        self.assertNotIn('alias-of', cpus['Cascadelake-Server-v1'],
-                         'Cascadelake-Server-v1 must not be an alias')
-
-        self.assertFalse(cpus['qemu64']['static'],
-                         'unversioned qemu64 CPU model must not be static')
-        self.assertNotIn('alias-of', cpus['qemu64'],
-                         'qemu64 must not be an alias')
-        self.assertNotIn('alias-of', cpus['qemu64-v1'],
-                         'qemu64-v1 must not be an alias')
-
-        self.validate_variant_aliases(cpus)
-
-        # On pc-*-4.0, no CPU model should be reported as an alias:
-        for name,c in cpus.items():
-            self.assertNotIn('alias-of', c, "%s shouldn't be an alias" % (name))
-
-    def test_4_1_alias(self):
+    def test_unversioned_alias(self):
         """
         Check if unversioned CPU model is an alias pointing to right version
         """
-        self.set_machine('pc-i440fx-4.1')
+        self.set_machine('pc')
         self.vm.add_args('-S')
         self.vm.launch()
 
@@ -133,7 +100,7 @@ def test_4_1_alias(self):
 
         self.validate_variant_aliases(cpus)
 
-        # On pc-*-4.1, -noTSX and -IBRS models should be aliases:
+        # On recent PC machines, -noTSX and -IBRS models should be aliases:
         self.assertEqual(cpus["Haswell"].get('alias-of'),
                          "Haswell-v1",
                          "Haswell must be an alias")
@@ -247,8 +214,8 @@ def get_cpu_prop(self, prop):
         cpu_path = self.vm.cmd('query-cpus-fast')[0].get('qom-path')
         return self.vm.cmd('qom-get', path=cpu_path, property=prop)
 
-    def test_4_1(self):
-        self.set_machine('pc-i440fx-4.1')
+    def test(self):
+        self.set_machine('pc')
         # machine-type only:
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
@@ -256,80 +223,27 @@ def test_4_1(self):
                         'enforce=off')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
-                         'pc-i440fx-4.1 + Cascadelake-Server should not have arch-capabilities')
+                         'pc + Cascadelake-Server should not have arch-capabilities')
 
-    def test_4_0(self):
-        self.set_machine('pc-i440fx-4.0')
-        self.vm.add_args('-S')
-        self.set_vm_arg('-cpu',
-                        'Cascadelake-Server,x-force-features=on,check=off,'
-                        'enforce=off')
-        self.vm.launch()
-        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
-                         'pc-i440fx-4.0 + Cascadelake-Server should not have arch-capabilities')
-
-    def test_set_4_0(self):
-        self.set_machine('pc-i440fx-4.0')
-        # command line must override machine-type if CPU model is not versioned:
-        self.vm.add_args('-S')
-        self.set_vm_arg('-cpu',
-                        'Cascadelake-Server,x-force-features=on,check=off,'
-                        'enforce=off,+arch-capabilities')
-        self.vm.launch()
-        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
-                        'pc-i440fx-4.0 + Cascadelake-Server,+arch-capabilities should have arch-capabilities')
-
-    def test_unset_4_1(self):
-        self.set_machine('pc-i440fx-4.1')
+    def test_unset(self):
+        self.set_machine('pc')
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
                         'Cascadelake-Server,x-force-features=on,check=off,'
                         'enforce=off,-arch-capabilities')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
-                         'pc-i440fx-4.1 + Cascadelake-Server,-arch-capabilities should not have arch-capabilities')
+                         'pc + Cascadelake-Server,-arch-capabilities should not have arch-capabilities')
 
-    def test_v1_4_0(self):
-        self.set_machine('pc-i440fx-4.0')
-        # versioned CPU model overrides machine-type:
-        self.vm.add_args('-S')
-        self.set_vm_arg('-cpu',
-                        'Cascadelake-Server-v1,x-force-features=on,check=off,'
-                        'enforce=off')
-        self.vm.launch()
-        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
-                         'pc-i440fx-4.0 + Cascadelake-Server-v1 should not have arch-capabilities')
-
-    def test_v2_4_0(self):
-        self.set_machine('pc-i440fx-4.0')
-        self.vm.add_args('-S')
-        self.set_vm_arg('-cpu',
-                        'Cascadelake-Server-v2,x-force-features=on,check=off,'
-                        'enforce=off')
-        self.vm.launch()
-        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
-                        'pc-i440fx-4.0 + Cascadelake-Server-v2 should have arch-capabilities')
-
-    def test_v1_set_4_0(self):
-        self.set_machine('pc-i440fx-4.0')
-        # command line must override machine-type and versioned CPU model:
-        self.vm.add_args('-S')
-        self.set_vm_arg('-cpu',
-                        'Cascadelake-Server-v1,x-force-features=on,check=off,'
-                        'enforce=off,+arch-capabilities')
-        self.vm.launch()
-        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
-                        'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-capabilities should have arch-capabilities')
-
-    def test_v2_unset_4_1(self):
-        self.set_machine('pc-i440fx-4.1')
+    def test_v2_unset(self):
+        self.set_machine('pc')
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
                         'Cascadelake-Server-v2,x-force-features=on,check=off,'
                         'enforce=off,-arch-capabilities')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
-                         'pc-i440fx-4.1 + Cascadelake-Server-v2,-arch-capabilities should not have arch-capabilities')
+                         'pc + Cascadelake-Server-v2,-arch-capabilities should not have arch-capabilities')
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.50.0


