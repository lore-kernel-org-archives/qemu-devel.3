Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65D9CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcnE-0003RB-4Z; Fri, 21 Nov 2025 20:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMbaJ-00027g-R4
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMba8-0005T4-QJ
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fcIBzXudHPYvY6QmF4OmsaPzhsA+4LiQymdChLvcMTo=;
 b=Pii47RRizrjwm9x8EmtpY2YOBBQ7RKNqyZFNxODwKrhkmIa9ab2IY/ZlbN0bcSMKGT/i3T
 kEF9L/7Piqa+oJ+uKgcsEqNYqpZ5ULixa+zGfskjSOZ+So9cO3Q2IjirlCWZR8ykdvAkTV
 qjfHGSfhRNuAxHmOuhgflzvlvneuvAY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-Dq2pCknkP6KXf0MRWBD_yw-1; Fri,
 21 Nov 2025 07:14:48 -0500
X-MC-Unique: Dq2pCknkP6KXf0MRWBD_yw-1
X-Mimecast-MFC-AGG-ID: Dq2pCknkP6KXf0MRWBD_yw_1763727284
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FD4B1800650; Fri, 21 Nov 2025 12:14:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19398180049F; Fri, 21 Nov 2025 12:14:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 835E221E6935; Fri, 21 Nov 2025 13:14:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, alistair.francis@wdc.com,
 stefanb@linux.vnet.ibm.com, kwolf@redhat.com, hreitz@redhat.com,
 sw@weilnetz.de, qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 philmd@linaro.org, alex@shazbot.org, clg@redhat.com, peterx@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, dave@treblig.org,
 jasowang@redhat.com, samuel.thibault@ens-lyon.org, michael.roth@amd.com,
 kkostiuk@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 rathc@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 marcandre.lureau@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org
Subject: [PATCH v2 01/15] error: Strip trailing '\n' from error string
 arguments (again)
Date: Fri, 21 Nov 2025 13:14:24 +0100
Message-ID: <20251121121438.1249498-2-armbru@redhat.com>
In-Reply-To: <20251121121438.1249498-1-armbru@redhat.com>
References: <20251121121438.1249498-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

Tracked down with scripts/coccinelle/err-bad-newline.cocci.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/audio/es1370.c | 2 +-
 ui/gtk.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 9873ffadab..566f93f1ea 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -228,7 +228,7 @@ static void print_sctl(uint32_t val)
 #undef a
         error_report("es1370: "
                 "%s p2_end_inc %d, p2_st_inc %d,"
-                " r1_fmt %s, p2_fmt %s, p1_fmt %s\n",
+                " r1_fmt %s, p2_fmt %s, p1_fmt %s",
                 buf,
                 (val & SCTRL_P2ENDINC) >> SCTRL_SH_P2ENDINC,
                 (val & SCTRL_P2STINC) >> SCTRL_SH_P2STINC,
diff --git a/ui/gtk.c b/ui/gtk.c
index 48571bedbf..e83a366625 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1197,7 +1197,7 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
         type = INPUT_MULTI_TOUCH_TYPE_END;
         break;
     default:
-        warn_report("gtk: unexpected touch event type\n");
+        warn_report("gtk: unexpected touch event type");
         return FALSE;
     }
 
-- 
2.49.0


