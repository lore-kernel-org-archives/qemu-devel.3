Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B809CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJreI-0001Pl-B0; Mon, 04 May 2026 07:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdu-0001Jd-FC
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdq-0001U6-SA
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uN4d/Ai32GNB01MP0kVHTE8CTIe9T+EFJ95fCaxFhxM=;
 b=DMf2N/o2TjCzxPJM6/ZyH68pWHSW41Xhdb8qWygG0rvEaYP7Xi72fwDJxFVMGii1xZaq3o
 bo9pxh/hBxNHuzEZGsNOV5KaIaO1hTmSzk36eKaLoRKmWWgF2wl5hSEecEKGqKVY1wlwET
 hfKPMoBg0zuofbj5KzicUzlpG3kLp9A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-HR5T5EXFNwmf2kJhHhzYIw-1; Mon,
 04 May 2026 07:39:13 -0400
X-MC-Unique: HR5T5EXFNwmf2kJhHhzYIw-1
X-Mimecast-MFC-AGG-ID: HR5T5EXFNwmf2kJhHhzYIw_1777894752
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 558F0195609E; Mon,  4 May 2026 11:39:12 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28C6330001A1; Mon,  4 May 2026 11:39:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:29 +0400
Subject: [PATCH v2 41/46] hw/ppc/pnv: drop extra ref on PHB after adding as
 child
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-41-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=888;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QLJRPPI4OhAwrexFX8/IzFHm2ibPBZdLsobimTM9SOo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRuqxZtILqQZ/YW6Xjh/H9/JZT69ixll/KSw
 NI+rrm7uYyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbgAKCRDa6OEJdZac
 5ZGjD/9h9+WsQce9b+cImLwAJ3lpV3NTJGaGshmo12ZKwmZlh1h2MvxL5bf7arIrCHBZMpZlDpo
 EU1o/x/WCexFUM3SoZJZBO/FikLpBK/hQmlUEtR7P0Fv2N9rqjJWAVLp5sZ0/hF9BnMCAD+uJ0h
 2ErXitvXfE+B6oP45OD6MjDR8WJpveW8oWvPBG8J+AwXI1FnWQ8Pt8NDLrwTWZ3vgxbu9+zZAL2
 yJnSvrQMlmK1Zz62SmnLyX6s4SMhIr88JfrcA3AFiu3y/GRAcPIItNXfZgNC5ECygw5/vKw878+
 AtD4qDNheFtaKktyIllMdFoS3+OxPDZAov64DemqckM5idkOoVI8QGlgYcgAJ8LVMux7fVdMXsJ
 KqYkxAbiUFwl142OT39ut1tePgEzvEcamJE9MdJOD3745w6ScA1Ezyt5bglT3sMUGpMFxr4lel2
 26B0p/mVQDFBrfC0MADG2DQA6DeMEhL8LAnmstn/ec34hoZ5xrZAqhPn/irtwfzBc2UpiOMb/h5
 Qag7U5+WSd7gU7o2WQthD6HPXMxYE9ByqOcB1kzwHp9x4M2Nl7SCBThFow1yUBTZjwUKZW734Kp
 km19oPoxbKbAzQanPkwloc8MNsQt2Yv/D3TXoioqjVwLzHwcGMHPECq9QtyN237UYaN1oX2crsd
 3gTbmnpSecdM8cg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

object_new() returns an object with refcount 1, and
object_property_add_child() adds another reference. The initial
reference must be dropped so the parent becomes the sole owner,
otherwise the PHB objects leak when the chip is destroyed.

Fixes: 0d512c7120a2 ("ppc/pnv: turn chip8->phbs[] into a PnvPHB* array")
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/pnv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9ed918fa6a1..8306754d9ad 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1696,6 +1696,7 @@ static void pnv_chip_power8_instance_init(Object *obj)
              */
             object_property_add_child(obj, "phb[*]", phb);
             chip8->phbs[i] = PNV_PHB(phb);
+            object_unref(phb);
         }
     }
 

-- 
2.54.0


