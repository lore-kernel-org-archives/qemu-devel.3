Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA7CC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy47-0007Ct-I5; Tue, 13 Aug 2024 16:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3q-0005qt-Px
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3R-0006DT-Eo
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:03 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3687f8fcab5so3109925f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580619; x=1724185419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pP0Fo+KnSDTrFxCsw1YiRuncAlRjF4c9n6ZeDd0O4VU=;
 b=pXgLsNT/D4EXpwpfUrA0Uw2zS0di6wz3L2Id80E1ZKHlOD7eTDMO/PrSRGqe8TN7YR
 fF7qAwJ5MxB9Z7oI+7eh2sNXvdxSInyuUNC6QMfxGdRgDkXlhmSwZCJugeywxPV0vTfH
 J7/ll70aDm0C8559pnEbe9X8Bty8UYlJR0vx3mllf9Ep/iD8uj6z4jdj/4dS5lEX7WAU
 yLEgFrUzx8aDtbqHCm+RSQAaZPwoiGDS948e82pj0sb7SYFyZAJirsCph4tfsYAaN802
 2jKlTgY/DG/dt0eHTM51VO1gTFF3QRc5UHxfwMEMu4HjcSkESvNw09I71flgqBHrmU2X
 yCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580619; x=1724185419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pP0Fo+KnSDTrFxCsw1YiRuncAlRjF4c9n6ZeDd0O4VU=;
 b=RSUQjn9ke2VyDTEo1ZX9b7HPz/ugX+hbKJUgQCMMXnIDo9uBZFnalo7jHlEAeB7wHr
 bK4oVvXhKb19b277v+lsIDoY+6bxmlTGEwomlKa4Fl3hx+RmnfpXqDLctZWJ+MxVI2Yr
 PiyWwa3vNuTAP7Llr2XFQJs3fu3SjqULikJ28y6JptF+InStK+MtqMIrBSBRVFW/Kqz6
 3EklqyQnckrzsHy/fYWZ1CZuqhMq3spZ6jcLPoEINrwYUT2CNxvWpNtXwXN63LX5qO7R
 KI2hsxJzq7+pWKbo+f8fILAzNH1TH0WJ6mEXaN0IXAFxmkeAOG5Ww+QLa0FKrOCLx7R2
 ID1w==
X-Gm-Message-State: AOJu0Yy2zrICYvseCob0pbvuwVMneV5R7Y9YZ1g3hDoOwo7MOA5+8nkf
 Q7svfYxUKp7HMX5TBc6WkwK3w855Tadzar4PLb/mGiWfCECTiCQN18+r4xaztsg=
X-Google-Smtp-Source: AGHT+IEjeN+yfY+rxMvEizfQNxPZLwKOV4SUh6vlc05jRoq2+k4GPdPO0K9pvBdrUZFGIm+wBb0R5Q==
X-Received: by 2002:adf:ce89:0:b0:367:9237:611d with SMTP id
 ffacd0b85a97d-371778221d4mr570039f8f.60.1723580618620; 
 Tue, 13 Aug 2024 13:23:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937b6esm11248588f8f.32.2024.08.13.13.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57C3D5FA49;
 Tue, 13 Aug 2024 21:23:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 10/21] scripts/replay-dump.py: rejig decoders in event
 number order
Date: Tue, 13 Aug 2024 21:23:18 +0100
Message-Id: <20240813202329.1237572-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Sort decoder functions to be ascending in order of event number,
same as the decoder tables.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240813050638.446172-3-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/replay-dump.py | 56 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 419ee3257b..b82659cfb6 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -139,6 +139,19 @@ def swallow_bytes(eid, name, dumpfile, nr):
     """Swallow nr bytes of data without looking at it"""
     dumpfile.seek(nr, os.SEEK_CUR)
 
+total_insns = 0
+
+def decode_instruction(eid, name, dumpfile):
+    global total_insns
+    ins_diff = read_dword(dumpfile)
+    total_insns += ins_diff
+    print_event(eid, name, "+ %d -> %d" % (ins_diff, total_insns))
+    return True
+
+def decode_interrupt(eid, name, dumpfile):
+    print_event(eid, name)
+    return True
+
 def decode_exception(eid, name, dumpfile):
     print_event(eid, name)
     return True
@@ -198,15 +211,6 @@ def decode_async_net(eid, name, dumpfile):
     print_event(eid, name, "net:%x flags:%x bytes:%d" % (net_id, flags, size))
     return True
 
-total_insns = 0
-
-def decode_instruction(eid, name, dumpfile):
-    global total_insns
-    ins_diff = read_dword(dumpfile)
-    total_insns += ins_diff
-    print_event(eid, name, "+ %d -> %d" % (ins_diff, total_insns))
-    return True
-
 def decode_shutdown(eid, name, dumpfile):
     print_event(eid, name)
     return True
@@ -222,6 +226,21 @@ def decode_audio_out(eid, name, dumpfile):
     print_event(eid, name, "%d" % (audio_data))
     return True
 
+def decode_random(eid, name, dumpfile):
+    ret = read_dword(dumpfile)
+    size = read_dword(dumpfile)
+    swallow_bytes(eid, name, dumpfile, size)
+    if (ret):
+        print_event(eid, name, "%d bytes (getrandom failed)" % (size))
+    else:
+        print_event(eid, name, "%d bytes" % (size))
+    return True
+
+def decode_clock(eid, name, dumpfile):
+    clock_data = read_qword(dumpfile)
+    print_event(eid, name, "0x%x" % (clock_data))
+    return True
+
 def __decode_checkpoint(eid, name, dumpfile, old):
     """Decode a checkpoint.
 
@@ -252,25 +271,6 @@ def decode_checkpoint_init(eid, name, dumpfile):
     print_event(eid, name)
     return True
 
-def decode_interrupt(eid, name, dumpfile):
-    print_event(eid, name)
-    return True
-
-def decode_clock(eid, name, dumpfile):
-    clock_data = read_qword(dumpfile)
-    print_event(eid, name, "0x%x" % (clock_data))
-    return True
-
-def decode_random(eid, name, dumpfile):
-    ret = read_dword(dumpfile)
-    size = read_dword(dumpfile)
-    swallow_bytes(eid, name, dumpfile, size)
-    if (ret):
-        print_event(eid, name, "%d bytes (getrandom failed)" % (size))
-    else:
-        print_event(eid, name, "%d bytes" % (size))
-    return True
-
 def decode_end(eid, name, dumpfile):
     print_event(eid, name)
     return False
-- 
2.39.2


