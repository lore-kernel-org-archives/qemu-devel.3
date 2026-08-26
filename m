Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21B9C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGwq-0006X3-Li; Wed, 26 Aug 2026 12:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzGwo-0006Uq-Dy
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:57:58 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzGwm-00035O-Py
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:57:58 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a5e392b2b3so1856570a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787763475; x=1788368275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VoM33mpXT3RRLOZ4hTE7xoq2+FeMJU9XxB2rhWcx78c=;
 b=NP/MjiTxAVaQ7cfXuwBtP1dDovzcNS+SqhZK5PrSOzFRTg1EBzITw69G4qNHQ0tIc8
 QMJMm+toCtRPluq7jxQY4cj1yL95Io/c8aSgsJVJbMUc6iGwtnfbE5Kpg60U7cL4B5mt
 dfcCRKwa+fVQX5mJp3KYAWfdLvcyMm1HB4ZDvGG4VibcotXobHpzT8Q1Ygpec0Rq2FgZ
 5owJ+ozK928AVS+NoUqDCw3pJy7WM1mwCtYzP7RNDF5VxyBJaCfpqKcCIs5we8fdsqqU
 9n9nUpWbtt9mWBXOoM99wPiUVRp7juhf5uikoytu24vHLX0XfwSJgSI0PsNyAWsVwYX1
 LT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787763475; x=1788368275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VoM33mpXT3RRLOZ4hTE7xoq2+FeMJU9XxB2rhWcx78c=;
 b=CiCSoWPNoPk2SlOX0TmHxXntHxNauWG4gN4q5Xj+oQPz2AWyiWzvWk/lpRENrQ/yoo
 Zz8CwliG5dnmXlWgqZgHSE1zZT/cXKoGoPMOGvcY0x2SC2vVMGnrtgpv1LEoWiucbFby
 pE5s0hUu2qYYUuenJ+vaqbzuUMSFifCd7QuYdizYlrN21OOMFKVa9Wym9VOdAD47Bb3K
 tI1Sb0KSuJo0rG9Ud2xPWoEfzehlRmwM8DkM5+jfkXtbCMHcZJZ4ce4cKmIFrqg97D45
 iyNQ96ho+Lpv9V/vN0b8VH1YJPDZD/i08s0H9OUs/CqwsSchFonT2HWCeKXrAKVP8Foe
 hDqA==
X-Gm-Message-State: AFuF++noFMxDQy4BPnp+f7RnMqfDwVCriAGPoqT3OTo/cheA7BDpP+KP
 4nQGwkFizAEaHCA5m2/nSN2NKpmg/BJ84HGsRelAbML4/YYJxYSuiVJx4lJKUO6JKNVW1uJcSL3
 Q5wpL
X-Gm-Gg: AR+sD12xuq1v/mf3N7z4a2um3tJVOaWiyGOe+pZHno77a+pZxd7eEaTGXWnDLxjHwtk
 VgovPD8Xs6F20beSrG5nknKt6rLi7yagl5WjvFYYgVh3r78nOF5iDWZU07fY8ok2E8PMA1eTxp6
 Z41rukB3mPDvGuADN4gPe4/PkAFpz6zD7aOzMRsmDfWZQAd+f+MtlntN5C5xcHD2//F34o+g5A/
 Kc9SATxFpxxDSlLI35Dvl08Wqmr3FnY67AIszSsmJgwsscY8gt/7NlQnMtc5/lrDcE4vViBkYfR
 k/hwJS/oKICM2h5mGSLXjjnS/31ano5bXKXDLZjrYJ7OYxqa9HYcTQYalK6CtnjfzUvqY+jBBxu
 s70x0SMTjeied63hcYCKwgNRrhsxLfPzq6EO8Hm6T9hmU2NKsxWnIlpctgSe0bQAOZbePzNROlq
 0ppVt2l+udnZiL/f8l1dFbeLUL5Mo0I05IFfber9kZJcSms9qy+0KMRi4SVoLqk2PCEvY=
X-Received: by 2002:a17:906:628b:b0:c16:66dc:3ab7 with SMTP id
 a640c23a62f3a-c250c4f025fmr956591466b.10.1787763475297; 
 Wed, 26 Aug 2026 09:57:55 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac46sm650557766b.29.2026.08.26.09.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:57:54 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 4/5] iotests/nbd-commands: cover NBD_CMD_BLOCK_STATUS with a
 payload
Date: Wed, 26 Aug 2026 18:57:46 +0200
Message-ID: <20260826165747.3768674-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826165747.3768674-1-den@openvz.org>
References: <20260826165747.3768674-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=den@openvz.org; helo=mail-ed1-x533.google.com
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

From: Denis V. Lunev <den@openvz.org>

With extended headers a client may name the meta contexts it wants in
a request payload. Our own client never sends one, so the server side
of it, nbd_co_block_status_payload_read(), is not exercised anywhere.

Export two meta contexts and ask libnbd for each of them in turn,
which is only answerable through that path.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/nbd-commands     | 20 ++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-commands.out |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
index f0b40feb6b..683a8303e3 100755
--- a/tests/qemu-iotests/tests/nbd-commands
+++ b/tests/qemu-iotests/tests/nbd-commands
@@ -141,6 +141,26 @@ class TestNbdCommands(iotests.QMPTestCase):
     def test_commands_extended_headers(self):
         self.check_commands(structured=True, extended=True)
 
+    def contexts_reported(self, h, wanted=None):
+        seen = []
+
+        def cb(meta, offset, entries, err):
+            seen.append(meta)
+
+        if wanted is None:
+            h.block_status(size, 0, cb)
+        else:
+            h.block_status_filter(size, 0, wanted, cb)
+        return sorted(seen)
+
+    def test_block_status_payload_filter(self):
+        with self.open_nbd() as h:
+            self.assertEqual(self.contexts_reported(h),
+                             ['base:allocation', 'qemu:allocation-depth'])
+
+            for wanted in (['base:allocation'], ['qemu:allocation-depth']):
+                self.assertEqual(self.contexts_reported(h, wanted), wanted)
+
     def test_cache_past_end_of_export(self):
         with self.open_nbd() as h:
             self.assertRaises(nbd.Error, h.cache, size + 1, 0)
diff --git a/tests/qemu-iotests/tests/nbd-commands.out b/tests/qemu-iotests/tests/nbd-commands.out
index 3f8a935a08..2f7d3902f2 100644
--- a/tests/qemu-iotests/tests/nbd-commands.out
+++ b/tests/qemu-iotests/tests/nbd-commands.out
@@ -1,5 +1,5 @@
-......
+.......
 ----------------------------------------------------------------------
-Ran 6 tests
+Ran 7 tests
 
 OK
-- 
2.53.0


