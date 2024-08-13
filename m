Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF81FC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy41-0006ex-D3; Tue, 13 Aug 2024 16:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3s-0005zN-Da
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:08 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3R-0006DK-0p
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3685a564bafso2694599f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580619; x=1724185419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIGt432MKZ8L2aq8hRDGJlqVxXSIZygXwHEjBgcA/QQ=;
 b=JqTB9nPyD1tctq9zRAmOIlinYD4zAEyF4hJVHVSMc7IKTYskPzMRbJ4Ay8phGntMqe
 s3ro55GSuyrLLeBjHrtdc6hdm4ohztrpS+hYndzxkY71M1Z0ZEW5Ag/phrg6Ok8Lp/TR
 ihbqAWAJ+qQZo7SajZLSnGALl3AT/IBDeJBAqYzTERrv9CkSyKzFM32xd3E0Vg2ezS8H
 R4ZDOxm/FLm9gXU2dpj+mh4dtuJWtwIZgXYTfxK4gJng6C92CPCVyAEGSFPju5eqlboI
 K41imi5vn94cEeC7ov3hreSAQQsqzhyE7MHoqi3RkuLiWeULP3rfzUC3vC6OO79nFOVu
 ZacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580619; x=1724185419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UIGt432MKZ8L2aq8hRDGJlqVxXSIZygXwHEjBgcA/QQ=;
 b=BjhRAR/IZs0d6iTq5QHZGn9ksrxrgZ7N6HK4qjeth+QMzuMv/XivsJ7Ot2TFdovudN
 hPfrcFyZ9V/+Ofr+NIVDrjuMbV5wVscTklq+nXh7HJ7s71yYNc5/K0tBIkxaDlSo5xGZ
 sZtO18ZnvXPP4tLTtthoUMUSSbqKlBcxkzzY2sTpfov9EDyZfLfFZW9P8DnM3hpkiTtD
 DAuJ1ZxeEnmtztRaTeNawqTiuolefAavBIOmUGWNJRm4fQXDBaGcSJRUb8HsIf0KQYjS
 M0qbGCFZOS3v66Mos8UkeQqk7AlYVre6eH5I6nngtLQVqwZQelw30qfHxuh9vrm2vV1w
 kvZQ==
X-Gm-Message-State: AOJu0YyOHHUxGyhToGZVL/nhS/mfMZMTdoLSFH9X3tdln3reAPSVOd8k
 BUgEfPpfFSu6spJ2snCQcAYKqsE7DdZemDofPag3h7s8zqlz3NbZ6TdHsAifPvI=
X-Google-Smtp-Source: AGHT+IEpz2xU3t1ZaX7PZ7NZrvnlD88bcAC7XlkHNEaQkoIM0lnkLpk8dvBny9HpZ1MozYPXLO3Rdw==
X-Received: by 2002:adf:a30a:0:b0:367:f104:d9e8 with SMTP id
 ffacd0b85a97d-371778095c7mr380324f8f.47.1723580618434; 
 Tue, 13 Aug 2024 13:23:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c93833asm11309309f8f.41.2024.08.13.13.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3FA935FA30;
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
Subject: [PATCH v2 09/21] scripts/replay-dump.py: Update to current rr record
 format
Date: Tue, 13 Aug 2024 21:23:17 +0100
Message-Id: <20240813202329.1237572-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The v12 format support for replay-dump has a few issues still. This
fixes async decoding; adds event, shutdown, and end decoding; fixes
audio in / out events, fixes checkpoint checking of following async
events.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240813050638.446172-2-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/replay-dump.py | 127 ++++++++++++++++++++++++++++++-----------
 1 file changed, 93 insertions(+), 34 deletions(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index d668193e79..419ee3257b 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -20,6 +20,7 @@
 
 import argparse
 import struct
+import os
 from collections import namedtuple
 from os import path
 
@@ -134,6 +135,17 @@ def swallow_async_qword(eid, name, dumpfile):
     print("  %s(%d) @ %d" % (name, eid, step_id))
     return True
 
+def swallow_bytes(eid, name, dumpfile, nr):
+    """Swallow nr bytes of data without looking at it"""
+    dumpfile.seek(nr, os.SEEK_CUR)
+
+def decode_exception(eid, name, dumpfile):
+    print_event(eid, name)
+    return True
+
+# v12 does away with the additional event byte and encodes it in the main type
+# Between v8 and v9, REPLAY_ASYNC_BH_ONESHOT was added, but we don't decode
+# those versions so leave it out.
 async_decode_table = [ Decoder(0, "REPLAY_ASYNC_EVENT_BH", swallow_async_qword),
                        Decoder(1, "REPLAY_ASYNC_INPUT", decode_unimp),
                        Decoder(2, "REPLAY_ASYNC_INPUT_SYNC", decode_unimp),
@@ -142,8 +154,8 @@ def swallow_async_qword(eid, name, dumpfile):
                        Decoder(5, "REPLAY_ASYNC_EVENT_NET", decode_unimp),
 ]
 # See replay_read_events/replay_read_event
-def decode_async(eid, name, dumpfile):
-    """Decode an ASYNC event"""
+def decode_async_old(eid, name, dumpfile):
+    """Decode an ASYNC event (pre-v8)"""
 
     print_event(eid, name)
 
@@ -157,6 +169,35 @@ def decode_async(eid, name, dumpfile):
 
     return call_decode(async_decode_table, async_event_kind, dumpfile)
 
+def decode_async_bh(eid, name, dumpfile):
+    op_id = read_qword(dumpfile)
+    print_event(eid, name)
+    return True
+
+def decode_async_bh_oneshot(eid, name, dumpfile):
+    op_id = read_qword(dumpfile)
+    print_event(eid, name)
+    return True
+
+def decode_async_char_read(eid, name, dumpfile):
+    char_id = read_byte(dumpfile)
+    size = read_dword(dumpfile)
+    print_event(eid, name, "device:%x chars:%s" % (char_id, dumpfile.read(size)))
+    return True
+
+def decode_async_block(eid, name, dumpfile):
+    op_id = read_qword(dumpfile)
+    print_event(eid, name)
+    return True
+
+def decode_async_net(eid, name, dumpfile):
+    net_id = read_byte(dumpfile)
+    flags = read_dword(dumpfile)
+    size = read_dword(dumpfile)
+    swallow_bytes(eid, name, dumpfile, size)
+    print_event(eid, name, "net:%x flags:%x bytes:%d" % (net_id, flags, size))
+    return True
+
 total_insns = 0
 
 def decode_instruction(eid, name, dumpfile):
@@ -166,6 +207,10 @@ def decode_instruction(eid, name, dumpfile):
     print_event(eid, name, "+ %d -> %d" % (ins_diff, total_insns))
     return True
 
+def decode_shutdown(eid, name, dumpfile):
+    print_event(eid, name)
+    return True
+
 def decode_char_write(eid, name, dumpfile):
     res = read_dword(dumpfile)
     offset = read_dword(dumpfile)
@@ -177,7 +222,7 @@ def decode_audio_out(eid, name, dumpfile):
     print_event(eid, name, "%d" % (audio_data))
     return True
 
-def decode_checkpoint(eid, name, dumpfile):
+def __decode_checkpoint(eid, name, dumpfile, old):
     """Decode a checkpoint.
 
     Checkpoints contain a series of async events with their own specific data.
@@ -189,14 +234,20 @@ def decode_checkpoint(eid, name, dumpfile):
 
     # if the next event is EVENT_ASYNC there are a bunch of
     # async events to read, otherwise we are done
-    if next_event != 3:
-        print_event(eid, name, "no additional data", event_number)
-    else:
+    if (old and next_event == 3) or (not old and next_event >= 3 and next_event <= 9):
         print_event(eid, name, "more data follows", event_number)
+    else:
+        print_event(eid, name, "no additional data", event_number)
 
     replay_state.reuse_event(next_event)
     return True
 
+def decode_checkpoint_old(eid, name, dumpfile):
+    return __decode_checkpoint(eid, name, dumpfile, False)
+
+def decode_checkpoint(eid, name, dumpfile):
+    return __decode_checkpoint(eid, name, dumpfile, True)
+
 def decode_checkpoint_init(eid, name, dumpfile):
     print_event(eid, name)
     return True
@@ -212,15 +263,23 @@ def decode_clock(eid, name, dumpfile):
 
 def decode_random(eid, name, dumpfile):
     ret = read_dword(dumpfile)
-    data = read_array(dumpfile)
-    print_event(eid, "%d bytes of random data" % len(data))
+    size = read_dword(dumpfile)
+    swallow_bytes(eid, name, dumpfile, size)
+    if (ret):
+        print_event(eid, name, "%d bytes (getrandom failed)" % (size))
+    else:
+        print_event(eid, name, "%d bytes" % (size))
     return True
 
+def decode_end(eid, name, dumpfile):
+    print_event(eid, name)
+    return False
+
 # pre-MTTCG merge
 v5_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
                   Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
                   Decoder(2, "EVENT_EXCEPTION", decode_plain),
-                  Decoder(3, "EVENT_ASYNC", decode_async),
+                  Decoder(3, "EVENT_ASYNC", decode_async_old),
                   Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
                   Decoder(5, "EVENT_CHAR_WRITE", decode_char_write),
                   Decoder(6, "EVENT_CHAR_READ_ALL", decode_unimp),
@@ -242,7 +301,7 @@ def decode_random(eid, name, dumpfile):
 v6_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
                   Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
                   Decoder(2, "EVENT_EXCEPTION", decode_plain),
-                  Decoder(3, "EVENT_ASYNC", decode_async),
+                  Decoder(3, "EVENT_ASYNC", decode_async_old),
                   Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
                   Decoder(5, "EVENT_CHAR_WRITE", decode_char_write),
                   Decoder(6, "EVENT_CHAR_READ_ALL", decode_unimp),
@@ -266,7 +325,7 @@ def decode_random(eid, name, dumpfile):
 v7_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
                   Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
                   Decoder(2, "EVENT_EXCEPTION", decode_unimp),
-                  Decoder(3, "EVENT_ASYNC", decode_async),
+                  Decoder(3, "EVENT_ASYNC", decode_async_old),
                   Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
                   Decoder(5, "EVENT_SHUTDOWN_HOST_ERR", decode_unimp),
                   Decoder(6, "EVENT_SHUTDOWN_HOST_QMP", decode_unimp),
@@ -296,32 +355,31 @@ def decode_random(eid, name, dumpfile):
 
 v12_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
                   Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
-                  Decoder(2, "EVENT_EXCEPTION", decode_plain),
-                  Decoder(3, "EVENT_ASYNC", decode_async),
-                  Decoder(4, "EVENT_ASYNC", decode_async),
-                  Decoder(5, "EVENT_ASYNC", decode_async),
-                  Decoder(6, "EVENT_ASYNC", decode_async),
-                  Decoder(6, "EVENT_ASYNC", decode_async),
-                  Decoder(8, "EVENT_ASYNC", decode_async),
-                  Decoder(9, "EVENT_ASYNC", decode_async),
-                  Decoder(10, "EVENT_ASYNC", decode_async),
-                  Decoder(11, "EVENT_SHUTDOWN", decode_unimp),
-                  Decoder(12, "EVENT_SHUTDOWN_HOST_ERR", decode_unimp),
-                  Decoder(13, "EVENT_SHUTDOWN_HOST_QMP_QUIT", decode_unimp),
-                  Decoder(14, "EVENT_SHUTDOWN_HOST_QMP_RESET", decode_unimp),
-                  Decoder(14, "EVENT_SHUTDOWN_HOST_SIGNAL", decode_unimp),
-                  Decoder(15, "EVENT_SHUTDOWN_HOST_UI", decode_unimp),
-                  Decoder(16, "EVENT_SHUTDOWN_GUEST_SHUTDOWN", decode_unimp),
-                  Decoder(17, "EVENT_SHUTDOWN_GUEST_RESET", decode_unimp),
-                  Decoder(18, "EVENT_SHUTDOWN_GUEST_PANIC", decode_unimp),
-                  Decoder(19, "EVENT_SHUTDOWN_GUEST_SUBSYSTEM_RESET", decode_unimp),
-                  Decoder(20, "EVENT_SHUTDOWN_GUEST_SNAPSHOT_LOAD", decode_unimp),
-                  Decoder(21, "EVENT_SHUTDOWN___MAX", decode_unimp),
+                  Decoder(2, "EVENT_EXCEPTION", decode_exception),
+                  Decoder(3, "EVENT_ASYNC_BH", decode_async_bh),
+                  Decoder(4, "EVENT_ASYNC_BH_ONESHOT", decode_async_bh_oneshot),
+                  Decoder(5, "EVENT_ASYNC_INPUT", decode_unimp),
+                  Decoder(6, "EVENT_ASYNC_INPUT_SYNC", decode_unimp),
+                  Decoder(7, "EVENT_ASYNC_CHAR_READ", decode_async_char_read),
+                  Decoder(8, "EVENT_ASYNC_BLOCK", decode_async_block),
+                  Decoder(9, "EVENT_ASYNC_NET", decode_async_net),
+                  Decoder(10, "EVENT_SHUTDOWN", decode_shutdown),
+                  Decoder(11, "EVENT_SHUTDOWN_HOST_ERR", decode_shutdown),
+                  Decoder(12, "EVENT_SHUTDOWN_HOST_QMP_QUIT", decode_shutdown),
+                  Decoder(13, "EVENT_SHUTDOWN_HOST_QMP_RESET", decode_shutdown),
+                  Decoder(14, "EVENT_SHUTDOWN_HOST_SIGNAL", decode_shutdown),
+                  Decoder(15, "EVENT_SHUTDOWN_HOST_UI", decode_shutdown),
+                  Decoder(16, "EVENT_SHUTDOWN_GUEST_SHUTDOWN", decode_shutdown),
+                  Decoder(17, "EVENT_SHUTDOWN_GUEST_RESET", decode_shutdown),
+                  Decoder(18, "EVENT_SHUTDOWN_GUEST_PANIC", decode_shutdown),
+                  Decoder(19, "EVENT_SHUTDOWN_SUBSYS_RESET", decode_shutdown),
+                  Decoder(20, "EVENT_SHUTDOWN_SNAPSHOT_LOAD", decode_shutdown),
+                  Decoder(21, "EVENT_SHUTDOWN___MAX", decode_shutdown),
                   Decoder(22, "EVENT_CHAR_WRITE", decode_char_write),
                   Decoder(23, "EVENT_CHAR_READ_ALL", decode_unimp),
                   Decoder(24, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp),
-                  Decoder(25, "EVENT_AUDIO_IN", decode_unimp),
-                  Decoder(26, "EVENT_AUDIO_OUT", decode_audio_out),
+                  Decoder(25, "EVENT_AUDIO_OUT", decode_audio_out),
+                  Decoder(26, "EVENT_AUDIO_IN", decode_unimp),
                   Decoder(27, "EVENT_RANDOM", decode_random),
                   Decoder(28, "EVENT_CLOCK_HOST", decode_clock),
                   Decoder(29, "EVENT_CLOCK_VIRTUAL_RT", decode_clock),
@@ -334,6 +392,7 @@ def decode_random(eid, name, dumpfile):
                   Decoder(36, "EVENT_CP_CLOCK_VIRTUAL_RT", decode_checkpoint),
                   Decoder(37, "EVENT_CP_INIT", decode_checkpoint_init),
                   Decoder(38, "EVENT_CP_RESET", decode_checkpoint),
+                  Decoder(39, "EVENT_END", decode_end),
 ]
 
 def parse_arguments():
-- 
2.39.2


