Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43B7C44502
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 05:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfWMc-0005Xo-AR; Fri, 03 Jul 2026 01:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wfWMY-0005VI-G2; Fri, 03 Jul 2026 01:22:54 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wfWMW-0005w9-LJ; Fri, 03 Jul 2026 01:22:54 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635LT8T018373
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 3 Jul 2026 14:21:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=6SxS8nVg3xnGkGVZhxJ3G3DZU8jRBJGr+RtAwqpbPdU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1783056106; v=1;
 b=QgYN2xsCcD3xLna//lkUa8qytMBfIhKXr/m/42WJSe23dJFVmFc8yRSPhU5iHenl
 OZo6Vl9ITdMn+SLCFkupO4MY+6oQg9Sc+S0X+8aLSXo7WIg1kHpXhlL2Yn2aOZfy
 J2zWXQsg9T7VQmRg9umr+me0rHqZD634DFtCKEzEJC/Ay3/lp+gOBphyJ2UTlY8F
 J/WMZcB5vh7ReK9I2StGrBSGxpXdNQRufr2y3gfv80If2ATSAD/9pC9f6QzyjXiD
 g9wjXkQXuVaCnS4h3iqzXu843CfMCjL5FURg/d0yNvmc8z06Ey+Az1PSbDIt89b8
 cOfEwrXXkc073eh77wa3Hw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:19:22 +0900
Subject: [PATCH v2 6/7] migration/ram: Fix ram_save_complete() return value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-ram-v2-6-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
References: <20260703-ram-v2-0-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260703-ram-v2-0-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, linux-edac@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=813;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=/MegIW1B5Ph/z9o6j3vpknjkTxLfDtRU9G3pSaGuRSs=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a72+M7k1Jrb37eu8tUIZdTP/fDhrsTP61dfWWHw81ej
 daUOadjOkpZGMS4GGTFFFlSinZza0TXfipMiG+BmcPKBDKEgYtTACbyWIGRYb35lvigt8rvKyvE
 9bymzzeZZbXGY4aDYdXFyOD70p3r2xn+6cSvM9obe2Pl/b7mtusfv7tx/UrJSzz61v/wL9mbbfb
 WLAA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

ram_save_complete() and qemu_file_get_error_obj() are documented to
return negative values on error, but ram_save_complete() inverts the
sign of qemu_file_get_error_obj()'s return value. Remove the sign
inversion.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6bc7f705d31a..e1c191ec4383 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3431,7 +3431,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
             int err = qemu_file_get_error_obj(f, &local_err);
 
             error_reportf_err(local_err, "Failed to write bitmap to file: ");
-            return -err;
+            return err;
         }
     }
 

-- 
2.54.0


