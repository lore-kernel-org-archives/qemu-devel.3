Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C46FD007D
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoTy-00045b-St; Sun, 01 Mar 2026 16:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoTx-00045N-Rr
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:45 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoTw-00041l-Fe
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401063; x=1773005863; i=lukasstraub2@web.de;
 bh=f78P3av60iHXeYLfBcNIb/W7089vNVfF6LL/haLWLTM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rtyeHoIQ1hELXSDC9fTRDfHRsE9D7vOUwgHZHnrTKpdK9NyZuXVTM0osfMOWh2j7
 BVJdyjSFabD/HMULO/c8lnOXcICUYWg0baiMM51ldpzZz2QrXgwYuL3F6w3VW9U/t
 Q3m5h00KY/DLhWwDLxpnvAIyHglNycyvwM31tGKgH0V/vGR1Yu+i6vFlIMAYPmwqo
 fypgYjO/f72U3+oC/KW8fgc5e3tNnjNpvGM/x8/LgdTe4uLJfMI8DnNFwtT8NjlaC
 wirvWre3LabfD+WD63PR18v8XX4uYuuomkL8OwZcCeJiMWSkslsdYyMLmpfxDJmu7
 1xnYTeBy/wHIxKrwtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MI3tF-1vs5mT3idj-00AeCN; Sun, 01
 Mar 2026 22:37:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:26 +0100
Subject: [PATCH v11 06/21] ram: Remove colo special-casing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-6-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGhiqBeNTD70uw/p6JgNb47Un/lgKgFR0RKj
 cW/0WtmDGGJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxoQAKCRA1qwsonF2y
 WKcKEACz5Ko+1RxBBaW0GUN5cgepH5li9PmnSkz3sAfns+kO3rPEXKUnlN1rSoEJmT7kUsmzVT6
 V79qivxM1WXe/qkH+/pYO0SNk+lZJI6D+OSigslOYOdyjoVLPcIzClYBWDyUCcUa29n355tUCpG
 b3AmqRwdGE2lm/x3XoKusa4PhJiYuzaJLNgTBzPxfrEZxk0hzD8klOmdaHhcjS14bRVK3Y0/v+2
 hX5wdsryHrArYPXjc470lGi6ScsdpegAZmMI1nJ92HbdUUJ+vtNGGJgRQVFW9s1WwiCVpIYOSJn
 +q4h9EjXOTGO37wPY4+hxNoUE+DEPLHDABmmYEfAREv1EhV+1Fdm8w4eASRHhZYav/W6DOZ4c6L
 RuyPhLBZtxnmE1k0IbWFrLzd8P4OEhNBdnPiowDykRq17KjqdnMKZnsA9CHTC38wUwOcA1UxhMt
 Mt1j4AzF9/c282Ae814NASwa6cfM+nH5Jf07C8tMGrDRt4BmwnlSi/Ld4WmS9Vx7L1qehIiFZew
 ZeoDH+8gv5uvY3DrZpSkt4+O/eA4FCVJvT4rmVi07FS4Ynoqw6Msxz57m+2DYVBEbi6UubYZP5d
 IrWz9Ntl4keWdM93IyfcmoKsePCWZW8cGyHslzXnqPnaa43wGEvoW0WwuG8h1xohIIYzL/jHVdO
 eeWJo8AeeKQF5sQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:kRKcjyiF3CIf8NYeXL+Ts86vLfU8/ttkxMidfnS6C6sTDhEJ4Tq
 mlLQ5n0c+0Hu/8KQ7qnYUIzzksSpMQdBabIBAQbgt0rT4VEPcJl1WFWe4eIrq87XwFc8Zyq
 cOpir2mON7OhRzOiH/Wrbl+HUEH+SfTj4KOljd412p8JKgMrp2KFcN710dnhYyW2PcjlYfT
 Czjf9upmiWYyjDc5Gw+Pw==
UI-OutboundReport: notjunk:1;M01:P0:BojQrT3Ta5M=;GWI5o4rfUZIL4+p45fK51XW7rNo
 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
 PIaz6qRg=
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


