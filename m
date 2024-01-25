Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE35CC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2Hp-0006vI-OJ; Thu, 25 Jan 2024 11:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rT2Hn-0006tm-Bh
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:09:03 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rT2Hl-0000Ms-MP
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:09:03 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2906bcae4feso2656265a91.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706198940; x=1706803740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCathHofE5nAYfNrhxY2aVLV9v0ArUIt8XjBeYaXknw=;
 b=nV7oklE8XLyDNG1h8pPPZDV0HJpyPNSHtGsSXybhNYYPSwIfO+vL4jmmRVeghYAKb4
 8H7sZ/6yzAgKE2kRg2WemgEU+zjCzQjf6S9lFtFF21czmUo7lrmHelgjJBeJMy9jx0B0
 +8AoJLriop7uVaxuOLHZV5H1CHi1Tgylqf2GMrpyVZLdnA3YzX2xaRhht8Tuga/WIhtg
 XSfd1VMe/7XS5/a4+kV+qbonrYH7ur6QoiIgRRpPh68rX5yjhpvumaOFTpsrRCU/8gNJ
 0/mqN03ZCfK+icKAuL7x9DKxTKG3ma+1ydNeNnV4+ZnPNR2it2L05fHzwviiGju0z3Je
 AmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706198940; x=1706803740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCathHofE5nAYfNrhxY2aVLV9v0ArUIt8XjBeYaXknw=;
 b=wAmIkiDLrM34rmDuN9mXMyKc9zre01tOkil/ex25NmB/S1Q6nhNmCh42+N4WyEXzZT
 NrDYBMTzU60EK/Zjmdc3eBjMNlRlw3NxeLadfk/p1KTkljgvHF8OZAdqq3UJJOgz1HvZ
 aq2QypSuchegNM7sznUZ/WbSNEQpG2KNDU5aHlAwQaG3aPRPDbAN7rTtGLnBK7LEe4ub
 lMwsrfBMG4iHl3Zegge3rLKsZd7mUP8VWb4rd1x3pxu0Va5+6O7B188Sv3lBhRpskpay
 LU3MFmdb6wY6jZH6FF3YZnPIEfmbloLZd+309O4KoljRuJBmGkE2JG4zpyt3fkvMx38l
 yLzA==
X-Gm-Message-State: AOJu0YyHS3YEbm2SMaDfegwi32sUZOhZK6XArGKEHzix7y6Grl+1Zopl
 tzUWYqY0vf9LtrKDJI9bIHboY1UtAgR9K9nCrEvMxMx1trNGqm9a01DCkkHl
X-Google-Smtp-Source: AGHT+IFunAMcsDDVtG2FVN/xFXc73njkvk6lKoRcGL9Tem3cdEhL1zxhpgXOASFqGX0JtpN1Jb2BqQ==
X-Received: by 2002:a17:90a:4411:b0:28e:73c0:85c with SMTP id
 s17-20020a17090a441100b0028e73c0085cmr783157pjg.76.1706198939712; 
 Thu, 25 Jan 2024 08:08:59 -0800 (PST)
Received: from wheely.local0.net (110-175-3-177.tpgi.com.au. [110.175.3.177])
 by smtp.gmail.com with ESMTPSA id
 oe7-20020a17090b394700b00293851b198csm14190pjb.56.2024.01.25.08.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:08:59 -0800 (PST)
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
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v2 3/4] scripts/replay-dump.py: rejig decoders in event number
 order
Date: Fri, 26 Jan 2024 02:08:34 +1000
Message-ID: <20240125160835.480488-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240125160835.480488-1-npiggin@gmail.com>
References: <20240125160835.480488-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 scripts/replay-dump.py | 56 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 35732da08f..a1d7ae0364 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -144,6 +144,19 @@ def swallow_bytes(eid, name, dumpfile, nr):
     dumpfile.seek(nr, os.SEEK_CUR)
     return True
 
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
@@ -203,15 +216,6 @@ def decode_async_net(eid, name, dumpfile):
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
@@ -227,6 +231,21 @@ def decode_audio_out(eid, name, dumpfile):
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
 
@@ -257,25 +276,6 @@ def decode_checkpoint_init(eid, name, dumpfile):
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


