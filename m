Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C544C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFCO-0002eh-SZ; Mon, 18 Mar 2024 11:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCM-0002Ur-Od
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:46:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCI-0007pk-BO
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:46:50 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e6ce174d45so3553047b3a.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776804; x=1711381604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLLsOmMfH6Hic0UmOy3GbMHG10bAawMzfOEyo9niiZA=;
 b=Wi13bPoA7Dcu93ipC8Kij6uWH9F+/xHvjgWi+OSFNsMGQ06aFkI8fcEBG04q5tfWt7
 HIC/lLVQqjG1DA5k+BEOXiYHqRZ6FJimJrmhFNCeUlm/zIH98+PoD8ITh6OPCn94zBCG
 /f3cAEQJkO0PP+kv1ZROD5WeGHJLtcmKXvdjSwdCnrZxr/V5U3h1wSnhe4EmCNkJ3fUR
 tP1Tq3qdFC5sV8xWQhU+q55ZKVkknc2yTwchRwa4xf8SPABh+55yi4U8WF9UVQeFq4Up
 kyo8h5hz/F5gLPEOdJ2MZd/JK+Wdo7sonIsowuBg3mUoxzWOYux+xzxT+K/VlV6O89EH
 2hXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776804; x=1711381604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLLsOmMfH6Hic0UmOy3GbMHG10bAawMzfOEyo9niiZA=;
 b=WoQcbeWOEEDDVlW5gnj7E6+aMiZFd7cKTFpYIpxpPHeP94jNAKJoZfdlP5TauYAyr+
 huwqE6ZLhgUiDh6JAL1h/ErURSbOD2gwaSjs23cIFTr8kmtO9axsB2FMrCZ3QPdQIsuF
 AxV0k1NirxqmtPjXbyVE8ZiEaR+/GLH2KO6wp3IoXwwl2r5pWiRpfdZj8h2M7sDO9W/D
 sv1x6I5e3uc+ivFl8Z38hjM4Ivq6WXxBD4gCAPZld2YBl6cSksOpFW6COMMDsvXqcV60
 CMRcFfG+XBrgC4DFsa6ymL0aZaJFvUydDaFSn9IOg8MHWQGip9ZdHEku82ZNQswJaZgn
 PUUQ==
X-Gm-Message-State: AOJu0YxtaXkt7laclypiESvlOIAcYFvV2I7r1g2yCHoXRH+k0LeSQaz+
 Oh2uHYsd0TpswhOtFCiiFy0j24nHwVVMRrtX3eOP0eoc9F+IKU7FusA58ckD2PY=
X-Google-Smtp-Source: AGHT+IGtjZWBpdak5J334qTOLd36yu1+eU8bR4frRfz/bWLbjlDIqNxpMQnlrZ+/Y9AXusGEI7/JYw==
X-Received: by 2002:a05:6a21:3986:b0:1a3:67cb:f7c4 with SMTP id
 ad6-20020a056a21398600b001a367cbf7c4mr2552443pzc.34.1710776804297; 
 Mon, 18 Mar 2024 08:46:44 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:46:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 02/24] scripts/replay-dump.py: rejig decoders in event
 number order
Date: Tue, 19 Mar 2024 01:45:59 +1000
Message-ID: <20240318154621.2361161-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Sort decoder functions to be ascending in order of event number,
same as the decoder tables.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
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
2.42.0


