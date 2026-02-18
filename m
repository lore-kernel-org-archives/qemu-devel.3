Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBF5E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7J-00078T-1O; Wed, 18 Feb 2026 16:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7D-00076q-Hi
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:48 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7A-0007Eo-O5
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450179; x=1772054979; i=lukasstraub2@web.de;
 bh=f78P3av60iHXeYLfBcNIb/W7089vNVfF6LL/haLWLTM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Yp4tOQ06WdUYZ8ff75X5uf0cYTNcJyp6jnitLrgnNCCPTudcuWPzFaNoMAdRkSjR
 DLIAZZx8homeNHUIDIMKQsTgG/4Lpax4I+aQwC2lEFXFHdSQHS8RSRTA0Dr7H0GUk
 g1nG7ytwsfL9MY+GtRf+vmVJtS/197lwzq5+fBbc6zKDDz6v9mraaWTerRxQRVva7
 Jvi9nxxvWoCHqBSzDUfIRF+Hi24waOCcqQdvudBi0qY+OtNlF4JJej82mfj4+wovC
 QSkw5+wA3wLEussZ84a+hnnVGWc9GtPj2i8tpyQe+ZSEAzzWofvsE36RU33m3J8wB
 qW1rhIQL/S7qEPCsMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODmf-1w8ZcQ0yxV-00Noyw; Wed, 18
 Feb 2026 22:29:39 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:26 +0100
Subject: [PATCH v9 06/19] ram: Remove colo special-casing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-6-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=vR/wp6SYVr5uUbTS+XPqPG4RkOoroNdE8dtNpsOBphM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli880oGmJmd9EiGMFm3K3u0pREa+Oy4hBW6bm
 eFczgshoKSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPAAKCRA1qwsonF2y
 WK/UEACw/E81Xgb6dCDANntLFMDK6kAVDiCrNhFPPymAsmhp5u3sKHnsAWQ8CK8/qYBVMmSV9zX
 6lQkzrsp91MzDPuFMWqJXI2URTlSWBqkMH9jPo51jkmU6QXOnThA2eqz0zFSQysJtIM28J3AChJ
 2WqLL1EpzP61lMwgqpoJ0d2Ae1MxSIChpRuBIaMpMkCCyxt6TzJbAWqcJU08Mo/6E8ArvsarPAL
 q8WeaT40zveOBV7KHTQswMXuzdF+EQrLBl4H1q4Tj2kbgbsE418V13EOS5pye7TjvfZeOddzGgd
 Rt9/5qThJdcxLqt0Kck9hoJHUFlGXl8Uqbqnhx19b702ucgs0MzUAbX4fFKQx78gJQ1RwQ1U5Fw
 zWNK5Qec75m97KQCtwa0XCr2U4Oo0DD/KNV8Gw64m9FN1WgoEwFvlEfiv/AJVdlLFhA8cffa0+n
 H4qHd2HdRYXUCWjE2oBXCRgB5HV10yXWv90NAui0u06ep5zquTq6I1xXHUS8nVOISNt4TK1A13N
 bS1wuaun7yfpiIAW7osREzHT1ToG0TC8AZEyt9Ls51HQHV35vE8YeqLsWk4L4fH6GCVag6XROim
 XwGaKOGU0FWSzCwIxhzk6gh6wMqXFOIEr5KP5AJNbUQakcHq07WRQTDCM7Bd1zAShzenrUAWJ4l
 26whjFtbjXfiTVw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:09ZDwWuWrhXjLkgeAQ+5Y1LVrtt5BPlmiOZPS5r+9SFZ4Mh8Xnf
 t6J1s8oQqU5Fk7MYxz6qCcnajvXHe4WkOEJLv+EoSuEM/csM2wThIXY8fwPVwbU5/sL/i1z
 wpEGvW5x+mLNAV4ELzNpYZ2HDOIzUW1RFLB+QgRGKt4XbTuQrCyCnGYYWHD30GwPkHOP1Y1
 VBjrF+oteso07Ob60pFqQ==
UI-OutboundReport: notjunk:1;M01:P0:6bPWy/yzLgI=;YNpUZzSAhRrfCXxu32RiBLRJZW1
 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
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We only enter colo state after the precopy migration is finished
so this if is always taken.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index aebf77aa0b861e00516d6f1090aebefdd0d97e54..979751f61b30d6c4b878866b50=
11507e7c519176 100644
=2D-- a/migration/ram.c
+++ b/migration/ram.c
@@ -3116,12 +3116,12 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e, Error **errp)
     RAMBlock *block;
     int ret, max_hg_page_size;
=20
-    /* migration has already setup the bitmap, reuse it. */
-    if (!migration_in_colo_state()) {
-        if (ram_init_all(rsp, errp) !=3D 0) {
-            return -1;
-        }
+    assert(!migration_in_colo_state());
+
+    if (ram_init_all(rsp, errp) !=3D 0) {
+        return -1;
     }
+
     (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel =3D f;
=20
     /*

=2D-=20
2.39.5


