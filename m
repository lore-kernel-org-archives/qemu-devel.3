Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A99C5DF84
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJyB-0005sn-UO; Tue, 18 Aug 2026 09:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwJyB-0005sY-0I
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwJy9-0000Xj-Ig
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787060107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8o3TdsDmTmZflSq3Tpd/g79z8JVPD27QnuhbFbpfBc=;
 b=jDj3rt1Wdj7bch14ahtLEHi1Znc2UPWlbtZzzDnwolfq6O2uewuKG5sfO/b3kRefbu+Vj+
 5O8jarMwxykLBke4MH6ATUvXbGfQUVWDZu3s8btAJ4pb9GS/CzXSTC1yozV1VzLr4MXCbS
 Y98G5q/HGJCHcnfVxnX8npe5ntoGlP8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-liqlYVApN9-xwiD55RNtMg-1; Tue,
 18 Aug 2026 09:35:02 -0400
X-MC-Unique: liqlYVApN9-xwiD55RNtMg-1
X-Mimecast-MFC-AGG-ID: liqlYVApN9-xwiD55RNtMg_1787060101
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B5451800847; Tue, 18 Aug 2026 13:35:01 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9ED7180049F; Tue, 18 Aug 2026 13:34:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 17:29:27 +0400
Subject: [PATCH v3 61/74] qdev: adjust PciDevfn declared type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-61-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KhDByEWBnxUC3W2CWL4f0/aEPfmWCB/L9BLd30y2XBI=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqEX3OhUQYZWQQ9WYLcRUE6typV/1Muw8QGkZzz1ScuoEwN1
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqhF9zAAoJENro4Ql1lpzlndIQAKbI
 VSVo2lZXQldFUou7YmgRCd0brmjcAs3ApiLTK8kfcTBnjUBeq2jOznD9PD6OkD3iWNgAaGU+bTJ
 Ekrji3GgnPyylfu68Qx2i8oNu1E34uRHMFugvt1+5LPrGJznyeVL6NU/TnVhyBIH4GBSeppbf4c
 8eZCFfcqRuUNPFWQXM3pvLEbkVIs6bbyh1wSJtaDgJWjGb8wfYuOvjDipaJiBQrrZlInyOyexHe
 3vYIMeKbG/5U70LNFi8jgynzdPIxlnv7jgUe54O3k4kddMfeAhb0HhZCbQwjGQ2bqRyj9sP4OpB
 rXJVZrKWnIE7nP70QV1uNeKs/VG5UXfJd7/tHRKlOmshAmWMl8BLOcHZ+1lm2yC43D6ChjMkeQX
 +UHXJSA/ZmbQh4tChvTicWbel8gThLs9w/fZ7cNBvWcv1JCAU8nQ6ZcHYlBy1NhYbpkFtZonHun
 sOSEl5Le12KTb9J4+cO6thS0QYkU5Ea8001StHd8gV/6WQklB2DVxjD7HFy2Q/DUHudXDokIgGV
 JEv5XpNdWjkSE5D505iEautpSuBO8x07P3ObxjluqvQ6P+32461hKsRvP4SID719hK3zFbGehjF
 BpPWiS1UM9C7caw5xbB559rWUazDl404FDRU+M8sVaxt40VUHtzB9uv3f1ylUKkQV2D28NpxJod
 vOdoN
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PciDevfn is a bit special, since it accepts integer and string as
setter, but only output integer as getter.

Unfortunately, we can't declare an alternate str|int QAPI type for it,
since: branch 'string' can't be distinguished from 'integer'

Rather than declaring it as "str", use the common type instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties-system.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 5bfdfe1ab9d9..3381de1144d6 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -904,7 +904,8 @@ static char *print_pci_devfn(Object *obj, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_pci_devfn = {
-    .type  = "str",
+    /* The formatted string accepted by the setter is a CLI convenience. */
+    .type  = "int32",
     .description = "Slot and optional function number, example: 06.0 or 06",
     .print = print_pci_devfn,
     .get   = qdev_propinfo_get_int32,

-- 
2.55.0.543.g5ebe2ebe4ea8


