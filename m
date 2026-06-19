Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023E4CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 09:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waVtp-0001tR-0s; Fri, 19 Jun 2026 05:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1waVtn-0001sR-3A
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:52:31 -0400
Received: from forward100b.mail.yandex.net ([2a02:6b8:c02:900:1:45:d181:d100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1waVtj-0000XN-NI
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:52:30 -0400
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
 by forward100b.mail.yandex.net (Yandex) with ESMTPS id 0829D80E1B;
 Fri, 19 Jun 2026 12:52:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id JqPRggKd9eA0-MpRLFeui; 
 Fri, 19 Jun 2026 12:52:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1781862741; bh=iUmNYQyyvJr8o+sdi3XVlKgbsIiSKmLu78kgMaMlM+M=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=W2S/w2jKH8VktPOFuLPtkQI/8TFioJG1VSTFhYVpWW8g4ecCK9Y0ODD5z4FpYiyT5
 9T1m+vojxZw/X3IuLarMJOULwrm4EIF4mq+HDKSTGHhW2E5uo2U8Q2jeyZ96jnAgf6
 QO3gTt74fjQqHvjhZLPUP60rZBy7T+YtZgVwqMX0=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 19 Jun 2026 12:52:19 +0300
Subject: =?utf-8?q?=5BPATCH_1/2=5D_semihosting/arm-compat-semi=3A_Fix_aut?=
 =?utf-8?q?o=E2=80=91strlen_detection_for_32=E2=80=91bit_targets?=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260619-fix-sign-extended-32-bit-addresses-v1-1-47ae14f8e8c5@maquefel.me>
References: <20260619-fix-sign-extended-32-bit-addresses-v1-0-47ae14f8e8c5@maquefel.me>
In-Reply-To: <20260619-fix-sign-extended-32-bit-addresses-v1-0-47ae14f8e8c5@maquefel.me>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781862741; l=1558;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=vt1pJw4vK6qJ1CviyvMulF/rfkk/oBwO+p/inSo195s=;
 b=z6yE4GPSIzDvT3wp6LhM9lskzzBf3M+sbL7UW9xK3moMfeNSgh4k32miroktnOrXIxIkYwvQW
 ieJLTiIXZeUBZH76NAgw+Q7e6lDvhKH4AgxHL0S+OI1eUN6qOJBSoPq
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:d100;
 envelope-from=nikita.shubin@maquefel.me; helo=forward100b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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


