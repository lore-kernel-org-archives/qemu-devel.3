Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5736CC52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebnK-0004Ns-CZ; Thu, 15 Aug 2024 10:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn2-0003PJ-EU
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:25 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn0-0000DO-7m
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:24 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7d26c2297eso125796066b.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733361; x=1724338161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AOhP2ldyW9UA6bgoSKwypPabALbgykDRW8dOBoMAIA=;
 b=lLj4QVBvlQoFeurEdEgjWfYD5kb9gn2VDyHmg2dMYG62EXDUNRAEXoaRsaIEnLnGbE
 mjLn5y5ERcarD/AprsvNQtye1Je9XlPxSAozqYt3iCRcMrLgquWQbk3xqCF1GGp+fefK
 X2un2xKnGNj2XH/Hr2Ssp4FTp9JUD83rjS+qeGiZoAE7jpbFieaGS/o31CeUddiWXRCf
 ukb98IkrFkwWqvtt1vj3fra2w73Zguw0Dpink2rJ1TFkQmxMADa3kCyWt5a+6D4380K2
 5hngoaLn3DNb1ob3Mhtr3v2x0RedQx5XklpNgZPmhU8bEKsDugYteEKLPmJCSaOU15dp
 9FaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733361; x=1724338161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6AOhP2ldyW9UA6bgoSKwypPabALbgykDRW8dOBoMAIA=;
 b=Q/XyubXhtb7zya+t0CTymL2n5SI4Q6fhPdgx/JidklTS9cyStSs2d0lYodEpEr+5gx
 bnO0QU+OL6RGr8tCafSVitIPgGXbBHosrIMiH0Us9ss/VNMfGmt+QMKEmGdfWEYzUl2k
 1ovT6oVV3bP/5iR9ZwlEG0vOV9zsBYALkaU2AJNDXcp7KGigMBgftMn+G7Q8edink+IO
 JclFwDXbs81ECVBDCjPbFQlBpF3PYLj6pHC3m+ONn6qy4QOx260znkLR/RxgFLeUxjUg
 KBgTeB3aAos0mHV0p5D86aLAHpct5pzNV4i0prIKQYfPuGZbmqmVAvVsC3QaDfnlNr7s
 u24g==
X-Gm-Message-State: AOJu0YyT9FREyIzf1ymc8FG2Qd9fRFtDhAndUzpMGCwH3YEBLx7OYcpJ
 wrmmodsXVdLK6fzfrUXrm/HZ2u3nE+NXOMjm3VWvC/rCUodjQGpk55I1eFgxkFw=
X-Google-Smtp-Source: AGHT+IGTR7+5pIbUmpdxbLtANIQPNulj2j4SMqLKCNgnhSxUZyB6aSJXv9qzgNLMrIcPORNUVg3hkQ==
X-Received: by 2002:a17:907:e2e2:b0:a77:d773:54ec with SMTP id
 a640c23a62f3a-a8366c0beefmr428795666b.8.1723733360172; 
 Thu, 15 Aug 2024 07:49:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cfb47sm113120066b.74.2024.08.15.07.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9E07F5FC0F;
 Thu, 15 Aug 2024 15:49:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 10/21] scripts/replay-dump.py: rejig decoders in event number
 order
Date: Thu, 15 Aug 2024 15:49:00 +0100
Message-Id: <20240815144911.1931487-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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
Message-Id: <20240813202329.1237572-11-alex.bennee@linaro.org>

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


