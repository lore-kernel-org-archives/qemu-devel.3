Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FA5C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVPA-0004Vf-AB; Wed, 22 Jul 2026 07:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rangolit@gmail.com>)
 id 1wmLMt-00008C-Sa
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:03:27 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rangolit@gmail.com>)
 id 1wmLMs-0002fq-5v
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:03:27 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c16794450aeso880741866b.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 18:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784682203; x=1785287003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qROMMcxHf4isRrUkdba+z8CKRJ2KBgA2iSFDFcYe2wA=;
 b=TOXb3xPLeBvDk8dCJJtI9ftokKxwHjwzsU4WjiA9f4oFC5FR7FYsD9FukklVTdBbmI
 Mf0ok3rZscws2KTsRoEHB49u0idJPqKBSpmmTtXiZusv90NNWinY6WW6pjajPo9aSV6a
 RPABSZ4/+oL2036Unh0YhRTjn6iJhsa1jqCHl5ExzLgPTqbjMy9v68Vb1T1rbVuOZSHG
 vDtwc/w9XfRmItAQseRhYvJt60jySr0JOSML6+ZM00hSWbuUHd9FiZurokIAb79Q/LQp
 cqw8t76nykHTd8xy16/cls3tDy4s/yePvqGKN5QxKa77pM6xntYbRwl2b5d7eeGehdg9
 g2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784682203; x=1785287003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qROMMcxHf4isRrUkdba+z8CKRJ2KBgA2iSFDFcYe2wA=;
 b=Evy/NaX3N7HOVpujwgFDhGguDJvJ+0CT1CL8suWhNR3/nqUAWQGI4Sm24KIEb68QED
 FUmz5mxgG0kZMn1CVoMqTh7y6R4zZ6Zg8Tw0vqVmbJXIiSCVh/4t/gftKD3x0LRhN3yI
 GqZ/JmH1n7u0Ku1wvYqM9gwmcPt3GF3khrc3DxQqU7C8Gdpoydnk5+1LKQBIq3DmWVkc
 vFUt6dJHSRGqhdyEsG1Bdo3ggQA2MGGPxomvgnuDKp66b00LYVG8SPaK6fNZ1MDDsOct
 M1nzJjW0mZ0IvxlTdbC9bfaqRs5Gesuw9fXXaukLqUfVDLRkwxNVR5S0++9DakT1V47e
 UFtw==
X-Gm-Message-State: AOJu0Yx/RghWJWeAQzFQx+AgUGFN7dnRNkQ70zxyYCuiBuinTMjNkIEy
 Tx2U/S62v20QtLs1QWka7OxD35TMShjwTl16+ka0+iNbCeXtqDMFYIRHReloWhaM1b0=
X-Gm-Gg: AR+sD10nMj5L4t/9gn8cwnoIUWFUzV2fPZqWv6zjSc9w0E0aXkvNIf39EOizwMbD0Fu
 sJusnKMRTnH8URqvO46tpzHkJ3vHYqVf/958bBtFFUyQAJ6HKwMu/Zu75tmKOaUcypZYBzdl30U
 Jn5hrC6adQy6BqRf9YUc7zgnu7Uzvx/5ejBHHiQY0akmJiUAVeXqKn/pwg+ZC11dk4sff6FhKt4
 +yKvB95gFxHaVD9/NErJuiMkBeJ7LKv9nkqvZQob/ozvvFSvZa+SD31L2UfgAkWrvt5yUTQTuz+
 KOxlqwh/Tjt+QY0OcJbFiiq1LFYpiSjMQ584kBenYSOzdmlSzqjM/vZ4QX5sYDqMt04XvEnHEgt
 +cnIgdPYbnyAthhPpZd+4OZFfBVbgciiI7jpUoLqAXIJxSI2s0XmrYYvMum3E48IlrQ==
X-Received: by 2002:a17:907:3cd6:b0:c16:12b6:243e with SMTP id
 a640c23a62f3a-c16b4797e93mr992368566b.44.1784682202434; 
 Tue, 21 Jul 2026 18:03:22 -0700 (PDT)
Received: from Arc ([109.245.172.88]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32ebac95sm32694066b.47.2026.07.21.18.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 18:03:21 -0700 (PDT)
From: Konstantin Nigmatullin <rangolit@gmail.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Nigmatullin <rangolit@gmail.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 0/5] iscsi: fix hang after abrupt target disconnect
Date: Wed, 22 Jul 2026 03:02:49 +0200
Message-ID: <20260722010254.424820-1-rangolit@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=rangolit@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 22 Jul 2026 07:46:11 -0400
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

When an iSCSI target disappears (for example tgtd is killed), QEMU can
leave guest I/O stuck and then fail to exit on SIGINT because
virtio_scsi_dataplane_stop blocks forever in blk_drain_all().

This is a stack of problems in block/iscsi.c, not only the documented
default command timeout of 0:

1. NOP dead-session detection never fired in practice because
   iscsi_get_nops_in_flight() stayed at 0 on a dead TCP session.
2. SCSI_STATUS_TIMEOUT was retried like BUSY (up to seven full
   timeouts), so drain stayed busy for minutes even with -iscsi
   timeout=N.
3. In-flight coroutines were not cancelled locally, so with timeout=0
   waiters never woke.
4. After one failure, queued I/O restarted another long wait, so drain
   never stayed idle (permanent hang).

This series addresses those without changing the default timeout value.

Verified with the GitLab #3067 recipe (default timeout=0). After killing
tgtd and unmounting, the guest correctly sees I/O errors, and Ctrl-C
makes QEMU exit cleanly instead of hanging in blk_drain_all:

  (initramfs) umount /mnt
  qemu-system-x86_64: terminating on signal 2
  qemu-system-x86_64: iSCSI: NOP timeout. Reconnecting...
  qemu-system-x86_64: iSCSI SYNCHRONIZECACHE10 failed: SENSE KEY:UNIT_ATTENTION(6) ASCQ:BUS_RESET(0x2900)

Residual host messages such as NOP timeout / SYNCHRONIZECACHE10
UNIT_ATTENTION(BUS_RESET) are expected while in-flight flush fails on a
dead session during reconnect; they are cosmetic and not a correctness
issue for this series.

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3067

Konstantin Nigmatullin (5):
  iscsi: detect dead iSCSI sessions via local NOP failure counting
  iscsi: stop retrying timed-out iSCSI commands
  iscsi: cancel in-flight iSCSI tasks when the session dies
  iscsi: fail new iSCSI I/O while the transport is known down
  iscsi: avoid null iSCSI error strings after cancel or timeout

 block/iscsi.c | 124 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 113 insertions(+), 11 deletions(-)

-- 
2.53.0

