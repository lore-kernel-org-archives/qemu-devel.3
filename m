Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB036C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdjkV-0000Ry-RM; Tue, 13 Aug 2024 01:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjkP-0000Gr-SJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:07 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjkN-0007lH-NP
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d23caf8ddso4563677b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 22:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723525622; x=1724130422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmofXaNgST544n7NUVPZlVkPn87FdgINhtNwrqLrz/0=;
 b=ngj2K05/Fk6bDjqoqh2SUUbPmLVT7GTZL2qoy3YmUadAageChyqzNdUhkFmTQd7n0f
 J21fqVReWbD810VBDptbNNsD66inaCwCdzDpO8wgLxLyDHHwsJe/EreLUQobTgmMf2yZ
 w3x2UgG4f7OBDcNRaFZkTCfTbe5gXrOpNmPQhM5P0h57C9VwiAzCeQl7dgwPIKXYiiGb
 9xDY0SwgqJJhJrp0xTvVuFTzsnojVJoUSKONXw9+vTq6gn8jz8xwrG75IzfNqQiONuXs
 mk+hosws7d636f+fdeU88HbnCPLQh9HtJsUfVESEptXi752p2N613S+fz2agDkXYj9VW
 h7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723525622; x=1724130422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmofXaNgST544n7NUVPZlVkPn87FdgINhtNwrqLrz/0=;
 b=uuArar5N8gh1Zdu1WyoffZ5BZHwGxQESkq5b4RD2L6a3/ZmSq0O3UL6xtO96YWewFx
 KdnLEEObipBS8io8jhL5wbwzyLnRxh5VyWuLLHlNCI1WYfx4sAx9lM/rsjbobBh7wzPq
 Ls4UkIFxha6zZc6j1ZUxXVNbvSoiya/5ZzVhranpFmLyDCpoznjlLgeuQiBUJTHBv7DS
 wnlv4tV03l8VzANLC6qtqvXUZ3Qio0vXSkUW76kIfpmbf7s6tz4EQi5ebD1/mPuDeI/S
 LxDiRBVMS5+BEKZChRJujhd9tpoEGR9M9H4Brlx8/J3NhjGnnvYrTR1RTT2UfGscTNWK
 pByQ==
X-Gm-Message-State: AOJu0YyuZ82o/FKUqtGU10YkBrOztihwtdJZA1572rDXK74bGoH1ogws
 qdgOM3hVnncDy+70R8emebBErZCXuGrZslMQP26JpXDLNDVXjcWuC9R/iXb9
X-Google-Smtp-Source: AGHT+IHE1Bttp15Fyz5slQTT97xWWFX2RAj2pUkOPUS6xKRln7Vn0Z4eID3DcRk2HibzR5zjEnEGHg==
X-Received: by 2002:a05:6a00:3e18:b0:70d:3938:f1c3 with SMTP id
 d2e1a72fcca58-712551054cbmr2847800b3a.3.1723525620110; 
 Mon, 12 Aug 2024 22:07:00 -0700 (PDT)
Received: from wheely.local0.net ([1.145.66.74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5874ddcsm4846449b3a.28.2024.08.12.22.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 22:06:59 -0700 (PDT)
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
Subject: [PATCH v6 02/10] scripts/replay-dump.py: rejig decoders in event
 number order
Date: Tue, 13 Aug 2024 15:06:29 +1000
Message-ID: <20240813050638.446172-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813050638.446172-1-npiggin@gmail.com>
References: <20240813050638.446172-1-npiggin@gmail.com>
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
2.45.2


