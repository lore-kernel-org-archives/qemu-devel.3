Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770BDC88E5A
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 05:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5GLJ-0004Jo-OG; Sat, 12 Sep 2026 01:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x5GLH-0004JB-8l
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 01:31:59 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x5GLE-0003Ss-Dn
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 01:31:58 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68C5VLEv094585
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 12 Sep 2026 14:31:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=V2+Epo0c2GY/DFiaKG2Et35W6UvlmmPBMb67zAt4y0E=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789191086; v=1;
 b=bbGLps/Qad5QVa27vkyocSztx2Axev3ZmUdksvCpvws7bm2OtPTnOGMVsDVpxLRg
 +bV7pziNSRL1tACf/5TGe+ZyhW2dLmTldhlj8vC4wj+Y68uIFFzm1hoSSYmrGgLl
 ktDLsL4vklHWKGL2DtjD2fGBPORyjOb9IiP+7prFhhpdPnznCyn6GHRr0B1g06gz
 ytmFGdQtuoQ0jJtgdUsSRyvllHJfT/B8I2zAYwd9C/6zhCZ9yxZsIX3xqQPX+njS
 FfbD7j9ee/dpNGivgGEIbv/H9JArT6ETCMr53x0+04jVZNTKtIT0ScXkk8xW+0Tq
 6ucAm3W0R6FjZZTOcadmdQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 12 Sep 2026 14:31:14 +0900
Subject: [PATCH 1/2] hw/tpm: Block CPR with unsupported CRB chunk migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-xen-v1-1-ebd6a2aa519f@rsg.ci.i.u-tokyo.ac.jp>
References: <20260912-xen-v1-0-ebd6a2aa519f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260912-xen-v1-0-ebd6a2aa519f@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=Xb9shzDcgBjih+DLOzkq3JaxRgPplJIoucYMwzbkpXU=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9aSx8tfX17v99lB6lLvj7OeL2c8ri77/m32no3K25NPv
 vPdU/Q7uqOUhUGMi0FWTJElpWg3t0Z07afChPgWmDmsTCBDGLg4BWAiZT8Y/llGGG+bNbPm2KT7
 z1NOqxze4CLt3bL/0Au1jKYElh/Xw18wMiw7M030y3tOi437Fu1Vcfv4P3/1LavsvdOPrfQty75
 81okRAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

Currently only the normal migration mode is blocked with unsupported CRB
chunk migration. However, all CPR modes stop the VM before saving.
Stopping only freezes an outstanding chunk transaction; it does not
clear it.

tpm_crb_pre_save() waits for the backend request to finish but may leave
command_buffer and response_buffer with some state. Those fields are
then omitted when allow_chunk_migration is false. CPR preserves guest
RAM or selected kernel resources, not these GByteArray heap objects.
Block the CPR modes too.

Fixes: a8aa1b220c71 ("hw/tpm: Add support for VM migration with TPM CRB chunking")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/tpm/tpm_crb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 54fa2042b5a8..943809103b63 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -482,7 +482,7 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
         error_setg(&s->migration_blocker,
                    "The tpm-crb device does not support chunk migration with "
                    "machine version less than 11.1");
-        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
+        ret = migrate_add_blocker(&s->migration_blocker, errp);
         if (ret < 0) {
             return;
         }

-- 
2.55.0


