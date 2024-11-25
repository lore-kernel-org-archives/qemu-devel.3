Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D291ED58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatu-00042W-T1; Mon, 25 Nov 2024 10:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatq-0003yo-2m
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:18 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatn-0001mK-Vv
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:17 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539f6e1f756so5123303e87.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548074; x=1733152874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtUaFCn29c62i9cIZ+z0ThKUyrSmt2dDjZxz8gXQfGk=;
 b=p9CiWip98+ETpnZkqm4TtY81VqY3mU+Wa2LFlQMTMTL3R6/rlNoPmd4Y6zlcRhFS6r
 QSrHnJLOJG9S5Q0DkP+0BDJR2Eu7TClh4b+aKjoItAHBITEfApN60lCCP55t1eDp0XC6
 S9MG3hscT7TNd8HiiR5KcYTpxy1PjZNRW7evfl9oWXjeugo0G9x1z92FgapHLVA4Ecdb
 MDVnrQEBogYvdVFD0aVdBh0gSHzVD5zFIE88torC/wa9AG0JsAUsmYgpYv82ZH2EIdHU
 WJQDWY9KLipdvGSrrbid5/9PxIF4G33LbfvoB8NXIj4h6U2urQVSPqNxR6ka5Bv84Vnn
 fZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548074; x=1733152874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XtUaFCn29c62i9cIZ+z0ThKUyrSmt2dDjZxz8gXQfGk=;
 b=vXTpYQ9T2T6mvN6Fpml0k8Qs0smb5eKqnqBRWkpna/KmX2+E2mfrrL62ZuvjV2a3tE
 dlsyL/ABptCXseTqRABNnZV8GCOvBNaAeWJ1v+CeKj8xDSdMjbRSgmMVLNK8oMNj9Xcg
 Wn+p2642LBQsxuMoMyNymFGJePAhGt8lG/vj7f9z9Dyujn2uW8KbVw/s0BxxuLgH7aqX
 sZxYhBEHTZIHUS6s4GPAMJ0yjQ/KaL3fODpy9hQ/EgckbNzDgLVdnGozYichzMolBZEk
 RNdlrTjcbktOizUstvKqHum8CdFfi6Wm68q5gUzeZyG8/+pVOyim0hX2nzwe2TZWPUMe
 9Tyg==
X-Gm-Message-State: AOJu0Yzg6aUbPzNtvzB/5iWmuRG9strJLiUxw8M+518dNLeri2PCwiJs
 pL73LXNM9MuO+zGsjQSTYfEqI9S01blZz5yhTRBw4eeqN4SGs4wP35UTWsnThi8=
X-Gm-Gg: ASbGncseKPIjFG/HP+q9gtHmuHH2c73lyYSOdVBqLDK3HoFqG/57GfXpD5+5OSL+Uyt
 JFtVMNVdbynIEwsfP3H4eQbKMQkQXaAcJc+nPQZFHNmSQ+DMl9CD9yVWRQwlVHyG6zGk4mDgq/W
 dpWd75lq4+092skREXB1dNWrBCCnYgLZAXcacDs14blm3NrHrDZmhmL9AqQ+/Ez6HnRUEJTuFsr
 yomYLCb00hUNBzMWjY4NpOKR2ttfiTb5FufU7lHU/xSPMwg
X-Google-Smtp-Source: AGHT+IE0JhZ57eXk2itG3IVNhRoCBlICGROZXa6BbWit2NuWEpdirIr4fxa6zlrJ5fPvdC/Sp5Qnlw==
X-Received: by 2002:a05:6512:2244:b0:539:f8da:b466 with SMTP id
 2adb3069b0e04-53dd35a5108mr5981217e87.11.1732548072557; 
 Mon, 25 Nov 2024 07:21:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349b70aa23sm72513635e9.14.2024.11.25.07.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8BC945F9EC;
 Mon, 25 Nov 2024 15:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 08/28] tests/functional: honour self.workdir in ACPI bits tests
Date: Mon, 25 Nov 2024 15:20:45 +0000
Message-Id: <20241125152105.2100395-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The ACPI bits test sets up its own private temporary directory into it
creates scratch files. This is justified by a suggestion that we need
to be able to preserve the scratch files. We have the ability to
preserve the scratch dir with our functional harness, so there's no
reason to diverge from standard practice in file placement.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-9-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-9-alex.bennee@linaro.org>

diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 4c192d95cc..3498b96787 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -150,7 +150,6 @@ class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
     def __init__(self, *args, **kwargs):
         super().__init__(*args, **kwargs)
         self._vm = None
-        self._workDir = None
         self._baseDir = None
 
         self._debugcon_addr = '0x403'
@@ -169,7 +168,7 @@ def copy_bits_config(self):
         config_file = 'bits-cfg.txt'
         bits_config_dir = os.path.join(self._baseDir, 'acpi-bits',
                                        'bits-config')
-        target_config_dir = os.path.join(self._workDir,
+        target_config_dir = os.path.join(self.workdir,
                                          'bits-%d' %self.BITS_INTERNAL_VER,
                                          'boot')
         self.assertTrue(os.path.exists(bits_config_dir))
@@ -186,7 +185,7 @@ def copy_test_scripts(self):
 
         bits_test_dir = os.path.join(self._baseDir, 'acpi-bits',
                                      'bits-tests')
-        target_test_dir = os.path.join(self._workDir,
+        target_test_dir = os.path.join(self.workdir,
                                        'bits-%d' %self.BITS_INTERNAL_VER,
                                        'boot', 'python')
 
@@ -225,8 +224,8 @@ def fix_mkrescue(self, mkrescue):
             the directory where we have extracted our pre-built bits grub
             tarball.
         """
-        grub_x86_64_mods = os.path.join(self._workDir, 'grub-inst-x86_64-efi')
-        grub_i386_mods = os.path.join(self._workDir, 'grub-inst')
+        grub_x86_64_mods = os.path.join(self.workdir, 'grub-inst-x86_64-efi')
+        grub_i386_mods = os.path.join(self.workdir, 'grub-inst')
 
         self.assertTrue(os.path.exists(grub_x86_64_mods))
         self.assertTrue(os.path.exists(grub_i386_mods))
@@ -247,11 +246,11 @@ def generate_bits_iso(self):
         """ Uses grub-mkrescue to generate a fresh bits iso with the python
             test scripts
         """
-        bits_dir = os.path.join(self._workDir,
+        bits_dir = os.path.join(self.workdir,
                                 'bits-%d' %self.BITS_INTERNAL_VER)
-        iso_file = os.path.join(self._workDir,
+        iso_file = os.path.join(self.workdir,
                                 'bits-%d.iso' %self.BITS_INTERNAL_VER)
-        mkrescue_script = os.path.join(self._workDir,
+        mkrescue_script = os.path.join(self.workdir,
                                        'grub-inst-x86_64-efi', 'bin',
                                        'grub-mkrescue')
 
@@ -290,17 +289,7 @@ def setUp(self): # pylint: disable=arguments-differ
 
         self._baseDir = Path(__file__).parent
 
-        # workdir could also be avocado's own workdir in self.workdir.
-        # At present, I prefer to maintain my own temporary working
-        # directory. It gives us more control over the generated bits
-        # log files and also for debugging, we may chose not to remove
-        # this working directory so that the logs and iso can be
-        # inspected manually and archived if needed.
-        self._workDir = tempfile.mkdtemp(prefix='acpi-bits-',
-                                         suffix='.tmp')
-        self.logger.info('working dir: %s', self._workDir)
-
-        prebuiltDir = os.path.join(self._workDir, 'prebuilt')
+        prebuiltDir = os.path.join(self.workdir, 'prebuilt')
         if not os.path.isdir(prebuiltDir):
             os.mkdir(prebuiltDir, mode=0o775)
 
@@ -321,10 +310,10 @@ def setUp(self): # pylint: disable=arguments-differ
 
         # extract the bits software in the temp working directory
         with zipfile.ZipFile(bits_zip_file, 'r') as zref:
-            zref.extractall(self._workDir)
+            zref.extractall(self.workdir)
 
         with tarfile.open(grub_tar_file, 'r', encoding='utf-8') as tarball:
-            tarball.extractall(self._workDir)
+            tarball.extractall(self.workdir)
 
         self.copy_test_scripts()
         self.copy_bits_config()
@@ -334,7 +323,7 @@ def parse_log(self):
         """parse the log generated by running bits tests and
            check for failures.
         """
-        debugconf = os.path.join(self._workDir, self._debugcon_log)
+        debugconf = os.path.join(self.workdir, self._debugcon_log)
         log = ""
         with open(debugconf, 'r', encoding='utf-8') as filehandle:
             log = filehandle.read()
@@ -360,25 +349,18 @@ def tearDown(self):
         """
         if self._vm:
             self.assertFalse(not self._vm.is_running)
-        if not os.getenv('BITS_DEBUG') and self._workDir:
-            self.logger.info('removing the work directory %s', self._workDir)
-            shutil.rmtree(self._workDir)
-        else:
-            self.logger.info('not removing the work directory %s ' \
-                             'as BITS_DEBUG is ' \
-                             'passed in the environment', self._workDir)
         super().tearDown()
 
     def test_acpi_smbios_bits(self):
         """The main test case implementation."""
 
-        iso_file = os.path.join(self._workDir,
+        iso_file = os.path.join(self.workdir,
                                 'bits-%d.iso' %self.BITS_INTERNAL_VER)
 
         self.assertTrue(os.access(iso_file, os.R_OK))
 
         self._vm = QEMUBitsMachine(binary=self.qemu_bin,
-                                   base_temp_dir=self._workDir,
+                                   base_temp_dir=self.workdir,
                                    debugcon_log=self._debugcon_log,
                                    debugcon_addr=self._debugcon_addr)
 
-- 
2.39.5


