Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C3CFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRuq-0002pr-PH; Mon, 27 Apr 2026 15:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRuK-0002j1-5T
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRuI-0000D1-T0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tw5Pz6kISkF6KqFnDKbV4J48BYB8c89DHYYaZAxmEg=;
 b=fTaHu+mmyF6XCoUl70/0Y7gzLXtlpl6kYER2w49Ug7/Tfx/Bha12yF7/pR/PxsDkz699Q5
 QPcM4juXDwdU2zSPb9WIqVIJ6jVZ6OjB3jRDM7h+M32roF98/inrVYX7yIBwfewQEnewaS
 TKkxviusdxn99rtV9Wo+zb8DR1eP5N4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-6hGOBmWaNsW2Vm7aygMAgw-1; Mon,
 27 Apr 2026 15:46:11 -0400
X-MC-Unique: 6hGOBmWaNsW2Vm7aygMAgw-1
X-Mimecast-MFC-AGG-ID: 6hGOBmWaNsW2Vm7aygMAgw_1777319170
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FCEA19560AA; Mon, 27 Apr 2026 19:46:10 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41E9119560AB; Mon, 27 Apr 2026 19:46:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:36 +0400
Subject: [PATCH 37/41] hw/ppc/pnv: drop extra ref on PHB after adding as child
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-37-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=839;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hrUoAdeW0FsiiSJDTGr0GcRKIqh6cuaaSL1z6lxFAPo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wWqiCTtJuQDEw1RwUnMaqqC9IuLDAg5htXc
 iWgqpDwb2aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FgAKCRDa6OEJdZac
 5bTtD/4+7qNBB2zipjY6/9ow4dez0YcGW8jeo7FfiSriSWCiRV5J/uE0n7KNEUNatQlwaw5p+Yq
 PRx5+iF8tHO/40LRPmOqJ9cjHs0kLSP/Mo79BBqtf18G6Yk1luw5YsqHD3kndx4UPTr9NyV04By
 fgK1yGm9NPDgmo2HgmleG4shId/Lss5LS5FC6B2bP7V/Nlub/RFeKNZjhJ6BNBrOlhC858xCAhd
 RsbRQCTnRA6g5i22UJI7TDaRu9NNd5qaEZ1GJlut7pcjb+cBA7jpDvkNkY6cBtDpvP9UOGjm+mR
 CuLkUs/EpeOZcKXGMT43Dq8UvDLnLoBh1X7sSo7e652uLNJ9N9kgFcJV4SBSyd8420AwG3oEZLh
 X90OkT05/X8Q68Jwy/FFSpCiOMliHnjc6dPW4ppC4c0wHvHIqP/ovJHq2eopx43RwFguiPvqjKs
 Uzu3RCca+C8GYJ/erFXcmC018L4efyzCcskgcmSgeHDgUotQlrgt5gjljBOyJ1bVM3QHjm4zUH6
 28c8laCYZ13v+RVARC9R2k4us2gu1YcRQUXv1lLoo+TiNao3BBuXreSXRzxF6+mt9m/OYIM3QZo
 jQx2+WDBTYvvMVbYHAvqjFcgF0Xsf6sF3rZ73/ZUJKNwHIr1EyvCtJnR5dRTXug6C6LIppnws8j
 ugX8WebIMfcDVzA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

object_new() returns an object with refcount 1, and
object_property_add_child() adds another reference. The initial
reference must be dropped so the parent becomes the sole owner,
otherwise the PHB objects leak when the chip is destroyed.

Fixes: 0d512c7120a2 ("ppc/pnv: turn chip8->phbs[] into a PnvPHB* array")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/pnv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 524563dcfc2..476255b722f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1590,6 +1590,7 @@ static void pnv_chip_power8_instance_init(Object *obj)
              */
             object_property_add_child(obj, "phb[*]", phb);
             chip8->phbs[i] = PNV_PHB(phb);
+            object_unref(phb);
         }
     }
 

-- 
2.53.0


