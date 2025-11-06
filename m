Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1877CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 07:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGuQL-0001eS-R6; Thu, 06 Nov 2025 02:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan_salmon@163.com>)
 id 1vGuQI-0001e6-71; Thu, 06 Nov 2025 02:28:46 -0500
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan_salmon@163.com>)
 id 1vGuQF-0005K7-Dx; Thu, 06 Nov 2025 02:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bp
 ACfAURtyUw3Lb4RS8O/oa7wAycogaQ/LLp7zbYBkw=; b=PgeOhifoVK8N2x0H2A
 HCGk6tKCZD0ZdfEeCTYR3LgcfSTfPMG+mToxFJSeaq2XGA/PxJ94BKiZQUK6nX8C
 EtCumZFvT/OJMMBZxoLheVdzWgfzLf5am9jyjWCcITrSh4z7y/q/C2532oTkSxiG
 QMqC9YezFh7tgBFit29ssEz10=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wD3b6AUTgxpUifSBw--.36751S2; 
 Thu, 06 Nov 2025 15:28:21 +0800 (CST)
From: zhaoguohan_salmon@163.com
To: philmd@linaro.org,
	bmeng.cn@gmail.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] hw/sd/sdcard: fix potential out-of-bounds read in
 rpmb_calc_hmac
Date: Thu,  6 Nov 2025 15:28:18 +0800
Message-ID: <20251106072818.25075-1-zhaoguohan_salmon@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3b6AUTgxpUifSBw--.36751S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw43Zr48CryUZF13XryxKrg_yoWkZwb_Za
 45ArsxXFnrJr13Gws8Ar47tFy0ya9rA3ykGF4DJFW7AFZIq398tFnrtr4fA3sxCa1UJF1D
 Cw4q9F1Yqa1avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8k-BtUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 52kd0wpxrkt0xbvdzzlrq6il2tof0z/xtbBgBj4EGkFnXyDkwACsv
Received-SPF: pass client-ip=117.135.210.3;
 envelope-from=zhaoguohan_salmon@163.com; helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

Coverity reported a potential out-of-bounds read in rpmb_calc_hmac():

CID 1642869: Out-of-bounds read (OVERRUN)
Overrunning array of 256 bytes at byte offset 256 by dereferencing
pointer &frame->data[256].

The issue arises from using &frame->data[RPMB_DATA_LEN] as the source
pointer for memcpy(). Although computing a one-past-the-end pointer is
legal, dereferencing it (as memcpy() does) is undefined behavior in C.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 hw/sd/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9c86c016cc9d..bc2e9863a534 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1161,7 +1161,8 @@ static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
 
         assert(RPMB_HASH_LEN <= sizeof(sd->data));
 
-        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame->data[RPMB_DATA_LEN],
+        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
+               (const uint8_t *)frame + RPMB_DATA_LEN,
                RPMB_HASH_LEN - RPMB_DATA_LEN);
         offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN + sd_part_offset(sd);
         do {
-- 
2.43.0


