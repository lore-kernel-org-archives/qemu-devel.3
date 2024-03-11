Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196C1C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rje7m-0002gR-RV; Mon, 11 Mar 2024 07:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rje7k-0002fO-RI
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:47:21 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rje7h-00020Q-Jr
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:47:20 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1710157620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZItAWnqUEX8vithBjqnl8CZ72qCPO7vT0BxocYPqO8=;
 b=PWxxp24C1v8C1IzVkOJ9pCCCqkelDa0ozny7K8F6XO9ZpwiEfvxLaTF/JeF1hmvTQjCu/j
 rNVkAaqfQXjlMzgmx/trcLpE7tDL/DTgjT3aD1t7DTlBwHgsGM8Pt4k47aLZ0NXWVqZMyV
 feqWWS4uMZzk5Hak9UpjbNdGVs3P+39b7NKEJ/gEdmVym95mpLjRzNiSPT9f8ik8whZqOb
 JEUC/tZpNkJ1rdaofkmC6x/ep2cjr3rvHChkAdGaP38l9S+0OV7guwL/hYCfXVZYNBoT0+
 yswnyaJB9+pjxImQ9+duDWhYRTCf4HIISBP8ZAz0qQVLPiiVm3CFPyv0yW1n4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1710157620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZItAWnqUEX8vithBjqnl8CZ72qCPO7vT0BxocYPqO8=;
 b=qmB9ZIZppX/ea8IBtlxCtoySEKhCQrkaqiwgcAIEVN6yL2t/gfg8inMFXCDoFjboyUOngN
 7PvNfF9VGOyRnjBQ==
Date: Mon, 11 Mar 2024 12:46:58 +0100
Subject: [PATCH v3 1/3] docs/interop/firmware.json: add new enum FirmwareFormat
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240311-qapi-firmware-json-v3-1-ceea6e35eb4a@linutronix.de>
References: <20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de>
In-Reply-To: <20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710157619; l=1429;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=laicSrSkSXm9Ia/XiliQJVD3W1LHm2SG548uT8BmFFg=;
 b=pPU1KP3gDgicwIFk7tPVD1wjafW1q+ZZGocIBDZHZ8lLFzakOBpQFZNl7q9AxVx6nka8bsBrK
 SpIu9C2atcyBbaMw0Xw5flkf1RqHB5KZ0IxkC1HTY9s+bmaujB84qkj
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=t-8ch@linutronix.de; helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Only a small subset of all blockdev drivers make sense for firmware
images. Introduce and use a new enum to represent this.

This also reduces the dependency of firmware.json on the global qapi
definitions.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 54a1fc6c1041..0e619e8780e7 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -15,7 +15,11 @@
 ##
 
 { 'include' : 'machine.json' }
-{ 'include' : 'block-core.json' }
+
+{ 'pragma': {
+    'documentation-exceptions': [
+        'FirmwareFormat'
+    ] } }
 
 ##
 # @FirmwareOSInterface:
@@ -200,6 +204,16 @@
              'enrolled-keys', 'requires-smm', 'secure-boot',
              'verbose-dynamic', 'verbose-static' ] }
 
+##
+# @FirmwareFormat:
+#
+# Formats that are supported for firmware images.
+#
+# Since: 8.3
+##
+{ 'enum': 'FirmwareFormat',
+  'data': [ 'raw', 'qcow2' ] }
+
 ##
 # @FirmwareFlashFile:
 #
@@ -219,7 +233,7 @@
 ##
 { 'struct' : 'FirmwareFlashFile',
   'data'   : { 'filename' : 'str',
-               'format'   : 'BlockdevDriver' } }
+               'format'   : 'FirmwareFormat' } }
 
 
 ##

-- 
2.44.0


