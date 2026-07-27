Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0991C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woG2p-0005ki-O1; Mon, 27 Jul 2026 03:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1woG2d-0005iZ-5B
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:46:28 -0400
Received: from forward103a.mail.yandex.net ([178.154.239.86])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1woG2a-0008W3-VO
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:46:26 -0400
Received: from mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:340d:0:640:ad51:0])
 by forward103a.mail.yandex.net (postfix) with ESMTPS id 1A8E28111B;
 Mon, 27 Jul 2026 10:46:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id EkWbDKvd4a60-60H9QhEp; 
 Mon, 27 Jul 2026 10:46:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1785138378; bh=2B4vRCYvN1k/6vZ49p509MJyqGmWpNAjeeP8YdsTSTk=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=lLF8Uun40ncTLw3V3wLKCVZUJv5xtv+19aNgjA1KvNRAaoxZgvM57hYlaFYSAKeJY
 a8W3jZKGUcuuFFCmdtt2Aksp9Me1VxB8RgxSMl5ZP+KP+R56zAFzMx+gyHbqjrmcCJ
 kGg7xNXxLMMpSqpeoed7o79Fz0GCKr9zeM6lMCQs=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Mon, 27 Jul 2026 10:46:19 +0300
Subject: =?utf-8?q?=5BPATCH_v2_1/2=5D_semihosting/arm-compat-semi=3A_Fix_?=
 =?utf-8?q?auto=E2=80=91strlen_detection_for_32=E2=80=91bit_targets?=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-sign-extended-32-bit-addresses-v2-1-6d6a01efed8a@maquefel.me>
References: <20260727-fix-sign-extended-32-bit-addresses-v2-0-6d6a01efed8a@maquefel.me>
In-Reply-To: <20260727-fix-sign-extended-32-bit-addresses-v2-0-6d6a01efed8a@maquefel.me>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785138386; l=1607;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=BzZSeICm8AayHgBINKwHmwSve//k0o/u7SDe2GO5JJg=;
 b=5kgZRZDQp3E3Hy/3hIPwV0bgw0jbYJmgK2bx+QG0RljUQvx3wGoNMxtAVlsj7s4J2mSETq1Qo
 7nvWhdXQMuWDtbdgTH0B+M45bxAbkAPw4cT9T4jv7p4dripnMSK4jVg
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
Received-SPF: pass client-ip=178.154.239.86;
 envelope-from=nikita.shubin@maquefel.me; helo=forward103a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

The switch from target_ulong to uint64_t broke the mechanism of passing -1
(0xffffffff) in arg2 to signal validate_strlen() to compute the string
length automatically. For 32‑bit semihosting, detect when arg2 is
0xffffffff and replace it with 0xffffffffffffffff. This causes an overflow
to zero, restoring the original behavior of automatic length calculation.

Fixes: 6dfbf9b6cfe ("semihosting/arm-compat-semi: replace target_ulong")
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/arm-compat-semi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 5e5f181b90..682349bd51 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -442,6 +442,17 @@ void do_common_semihosting(CPUState *cs)
             }
         } else {
             unlock_user(s, arg0, 0);
+            /*
+             * Due to the switch from target_ulong to uint64_t, passing -1
+             * as arg2 is no longer possible.
+             * For 32‑bit targets, if arg2 == 0xffffffff, set it
+             * to 0xffffffffffffffff to trigger overflow so zero strlen
+             * is passed to validate_strlen().
+             */
+            if (!is_64bit_semihosting(env) && arg2 == (uint32_t)-1) {
+                arg2 = -1;
+            }
+
             semihost_sys_open(cs, common_semi_cb, arg0, arg2 + 1,
                               gdb_open_modeflags[arg1], 0644);
             break;

-- 
2.52.0


