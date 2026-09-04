Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87044C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TtL-0005Xe-Kl; Fri, 04 Sep 2026 09:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtI-0005WO-QW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:36 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtG-0008JY-SQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:36 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-485888b3c3dso912766f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788528213; x=1789133013; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tOTYcu87ro6PtDq6th4kzuspvF4cJxXqC3d7gEkpF5A=;
 b=evBTZRTRxd+N/l3q3FoVtaUcDj6l306WZpmIOv31jE/P73XmaEe8fLXICm51ta0qcs
 ypDMZUuVGnE23/Pw0AEu37Eb7aYAl9eJIA/EaqutTPkkIb+60/wfffcHnfymtpnYOkoF
 xfagsyTD2tRtckMNTAL1Vk16jUFZC3UX+1QnvTXAWGXpKBlpiW8DiMlJkzFXuB7LnrOs
 FnSpW2blXfVCgaRYVoI1i0aYNx1+2f9fFpw2vILUMeOFHWVdQcrqTXW7VHKbggXDTUx/
 jQ16T0gz+OcDHkZa8rEAu7zmrL66eNcq53RrhoyMKQGnBAymH83KoF+CAmIO4xapMosg
 xQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528213; x=1789133013;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tOTYcu87ro6PtDq6th4kzuspvF4cJxXqC3d7gEkpF5A=;
 b=WAAKPlyyPzRNEt6ChbZZyNgGaB2LDmS5/AZnpMAxtwvlUpaZ9M2Q0XXWnFP+SHbAsn
 g4qXl7Nos3kIPwbdGIGveh+E6Au97mRfpQbI6z3uKe36o3cwX1mBVyKUYL1KSLnWIaZu
 m+qiKMQ51BhhT/IbC54JyQAshD8j+RK8nbbaOV48z+BuBl3T+/54tEBgmtmOKM+hkMHw
 9MSkU2h3CjVtF4AgnKoCaGYBtAAclbfmsaIrBLb8Q4fHWmzFkOmYiHr5qbiZ1/xVt6hF
 05Pihru8Z8VlDYoW6I9LhF2eoHIf/ql0BIo9QvnPBMRAVvZ6LiXg8OVKKeTcc23S9yLj
 biBw==
X-Gm-Message-State: AFuF++nhEmW/in0cvPpTY70d0dv48mQkVz6/R4hTt1KHQPLVMJPW6sdJ
 4gvYmAo1saLzMNmvQhw7qLrBAqQe4XK3dIlkSM110jOhMrHi35KhFytYw7J7761LGgo=
X-Gm-Gg: AYBFou31UQnuKvNhvijBy9Gh+1IrievytUZy+EKm8OSvtdeDtnLTNvS4RPZEDxKtZPY
 sNa3qO1e/Cui/iGIG627HSIODnBs3VPyrbk6AYxJfSqwikFTIGtxL+jqXAcLx+Qwfdn5QsksCdm
 06WWP+G4ZORElbIlrdIMgQ9zt+WiPDZAJ4RwnnUkLGq/OzRZLhAQhHGikONtFNZPtnaHGxGjLeG
 /X2uq8ZXeQKRp966kF/Lrhq0ft5/EqSURDzpSqZONLwd99fEoKkfeeaiX8zA3GTdAF8H1GC4Ptj
 58lL380grY0QT+AkAxyY7Gd0g/AERTPUgoIuy8pUzn2aMvqBOQ8D0Ru2b8OEuQpVkohlUsO/+IE
 lQAEiKm6hsTH3JtXiirLzaPMhyltSZ4GZzuLzPvs28nwRCHk0XTsfOdOglo5fTfG1WyJKxsCrI0
 VHicCOZE652HzqERlEyH59dDpY2z6pV8TS1GkVjRr2mhlwFI4FMly3gGvyGEl0
X-Received: by 2002:a5d:5d83:0:b0:485:8c16:5eec with SMTP id
 ffacd0b85a97d-4858c166045mr3229425f8f.38.1788528213160; 
 Fri, 04 Sep 2026 06:23:33 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c81c3sm6051919f8f.26.2026.09.04.06.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:23:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB5CE61891;
 Fri, 04 Sep 2026 13:46:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 037/105] tests/tcg/multiarch: declare system tests
Date: Fri,  4 Sep 2026 13:44:51 +0100
Message-ID: <20260904124604.2207440-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

We now declare all multiarch system tests.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-38-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index 99af41b3fcc..508fdb585b7 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -1,3 +1,5 @@
+subdir('system')
+
 tests = []
 
 float_helpers = files('libs/float_helpers.c')[0]
diff --git a/tests/tcg/multiarch/system/meson.build b/tests/tcg/multiarch/system/meson.build
new file mode 100644
index 00000000000..f71c12db38e
--- /dev/null
+++ b/tests/tcg/multiarch/system/meson.build
@@ -0,0 +1,53 @@
+tests = []
+
+# multiarch src path are written to be included from any other arch folder,
+# so all arch can directly add those tests.
+multiarch = meson.current_source_dir()
+
+tests += {
+  multiarch/'hello.c': {},
+  multiarch/'interrupt.c': {},
+  multiarch/'memory.c': {},
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'gdb_test': ['--test', files('../gdbstub/memory.py')]
+  },
+  multiarch/'interrupt.c': {
+    'gdb_test': ['--test', files('../gdbstub/interrupt.py')]
+  },
+  multiarch/'hello.c': {
+    'test_name': 'untimely-packet',
+    'gdb_test': ['--gdb-args',  '-ex \'set debug remote 1\'',
+                 '--output', '/dev/stdout',
+                 '--stderr', '/dev/stdout'],
+    'wrapper': [prog_run_and_check_forbidden_output,
+                'Packet instead of Ack, ignoring it']
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'registers',
+    'gdb_test': ['--test', files('../gdbstub/registers.py')]
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'memory-access',
+    'plugin_test': {
+      'plugin': 'mem',
+      'args': ['region-summary=true'],
+    },
+    'wrapper': [prog_check_plugin_output,
+                find_program('./validate-memory-counts.py')]
+  }
+}
+
+tcg_tests += {
+  'multiarch-softmmu': {
+    'tests': tests
+  }
+}
-- 
2.47.3


