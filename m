Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA36CF9C73
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5DN-0002EO-EV; Tue, 24 Sep 2024 09:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1st5D3-0001er-7Z
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1st5D0-0008Ue-57
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727183041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9TzJiPbue6ZM4XJgTlzabYUdWmkITNbnAqP3qVgNyk=;
 b=SajSPJLst2G2CwXt/fCboALQsupqFas0nlq3yQkNAQJu7fx6ly98VbGHcsLcGp217Bb8mt
 iFYjbbB55GCWM9qUxFIsH9cNTAhIOwN9GTu5bPhwY+hMSQpIDiHFQWpGVicCex7AUJvTU9
 z3Ek7pNdOlo548VC9lYA9zggtkbbVi8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-3h8Om9LSNWWEozj5_S4ECA-1; Tue,
 24 Sep 2024 09:02:52 -0400
X-MC-Unique: 3h8Om9LSNWWEozj5_S4ECA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEA2B188FE97; Tue, 24 Sep 2024 13:02:47 +0000 (UTC)
Received: from localhost (unknown [10.39.208.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCC481956048; Tue, 24 Sep 2024 13:02:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Hyman Huang <yong.huang@smartx.com>,
 Laurent Vivier <laurent@vivier.eu>, Fabiano Rosas <farosas@suse.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 03/22] hw/qxl: fix -Werror=maybe-uninitialized
 false-positives
Date: Tue, 24 Sep 2024 17:02:02 +0400
Message-ID: <20240924130222.748369-4-marcandre.lureau@redhat.com>
In-Reply-To: <20240924130222.748369-1-marcandre.lureau@redhat.com>
References: <20240924130222.748369-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../hw/display/qxl.c:1352:5: error: ‘pci_region’ may be used uninitialized [-Werror=maybe-uninitialized]
../hw/display/qxl.c:1365:22: error: ‘pci_start’ may be used uninitialized [-Werror=maybe-uninitialized]

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/qxl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 3c2b5182ca..20e13ee98d 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1301,8 +1301,8 @@ static int qxl_add_memslot(PCIQXLDevice *d, uint32_t slot_id, uint64_t delta,
     };
     uint64_t guest_start;
     uint64_t guest_end;
-    int pci_region;
-    pcibus_t pci_start;
+    int pci_region = -1;
+    pcibus_t pci_start = -1;
     pcibus_t pci_end;
     MemoryRegion *mr;
     intptr_t virt_start;
-- 
2.45.2.827.g557ae147e6


