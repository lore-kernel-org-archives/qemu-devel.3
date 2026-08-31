Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337D3C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x14SV-0002tc-Eb; Mon, 31 Aug 2026 12:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14SP-0002ps-Ru
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:02:04 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14SO-0001hF-AO
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:02:01 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cc891373e0so32606255ad.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788192119; x=1788796919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YzyunjGqwnVL4+zZqn+0tH9PAMSOhSLwwJCF0/mtHPY=;
 b=pUDmWVI0HIDx/EWyd2DlCdPGAlz2fZTKRb5sJaiFswf1WvWiszxmeC1zXhgn0bYEzy
 0weaRJunpWmWpuJ6YBkbVLu0KRKZEkPYhalDW0m+0vSIjfQcO5hvWkpM6O1QT+DDHdQL
 Ue0jSirhdAVCubCyI9jWg510RBmo/2CHeE2KBQk6+/BN7boPv3o50K3AHQi7WZ46xlWR
 OgIFCET61btr6RuuuNN9mr/nNFarainiAundsdmSlXjB3mt6LsOa9KGzd1VuLzDIhJAR
 GkNWEkfwTztnFcHJl3xEMkAxc0UHHDMAk9NtpQvDGRKu4JqEhoEi1Wdck/N3+YBj/KGo
 RJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192119; x=1788796919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YzyunjGqwnVL4+zZqn+0tH9PAMSOhSLwwJCF0/mtHPY=;
 b=Jl9IaAVQ/de4Rc5KGTR4NaN/qxgDPegYYVD0vNB0t8VkuULaGg+zKr7BRZTX48ozwG
 3cCned6Anrs4Yu2UIm/OfIioaqitIlOrvePJf/hajE2CnX4iTyzws9fY/ry0OeQmdrMd
 S5wX3SQgAMNS1IEmFEQpJJyd8L5JWolJ4oppk7mmmDxMEfJDA9CyRCMT8bk8ZL5SLIXe
 sOl0m7BsdbmptCpKvIt2F0ekUFm3eewseVQZ4Tg7kWsdtbfL57Fg3N5NIdD+VNFLeKqX
 WhUpVwjr128ZgEYfmOrQzGNKfWKR+RrCAt+B5xQnLQ7IbteUKzh7eI/4DNlmfkZO54vp
 4pig==
X-Gm-Message-State: AFuF++kJGYQWStvl5NJsMqXbzbwCPEdXU1eViFymxuVPZKHw4MoMpWl+
 uizV8SuoZdogfOTMqyo0vtzTpjBISk9vcUPzireZ7jSyMaIGe6FH0LpH5Y0QMLiZYJP2NxJ5
X-Gm-Gg: AYBFou2W8aANHi4ISa7fXLiRhddfsnvOw6vygj0qvr53KMgH14OebAcpCBSkW4AM5qc
 NMmyf3Gm1cBt2RAV2l/V7NXDwVEw4dmfonhaySsVT1eyc5m/veTS/5stqiLUza1W44yQXdk5rna
 5uM93WVyTaKmV9YfI5Y+c6f12UO79Bt4vZ4kYmnrZ9kFvVZ+6xPyLZ2GIIxBxbzMSbEwcG1EPVi
 gWyK9OVkMhfCWPG0HCBpTJm5QyN8xXfsfK3AhcIwXMYKZHW/5Aknj/Z6GCxTyTnYuOghueFJJAw
 6292VJtGlBOClOfH0kt9Q6kdeC3Vq3eHDtUf8NhAxrnapZ1vRYwGTdklq1s+dtPOnSmGGvxUwwQ
 9I+cyn6j3CoEXVKs3tD+l0Ar8L/v42SovNkBduAzxrDd2gCs+77GMSxMMmiZfWMdu9XuqtwxmcQ
 7c2TTHsJ620oRSiSgWf1ztE4Cb6C0Jfac3yUnUsFhel0Etz2Vg6DOwztXZuLOLTu9X/5cwQIJmF
 1xi/gqe
X-Received: by 2002:a17:903:2c9:b0:2d9:6db:9fcb with SMTP id
 d9443c01a7336-2d906dba09cmr192172265ad.11.1788192118814; 
 Mon, 31 Aug 2026 09:01:58 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b28ab0571sm22689520eec.4.2026.08.31.09.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:01:57 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V14 12/15] xen-block: Update tracking iothread users with
 holder name
Date: Tue,  1 Sep 2026 00:00:33 +0800
Message-ID: <20260831160038.221776-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831160038.221776-1-zhangckid@gmail.com>
References: <20260831160038.221776-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Replace raw object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/dataplane/xen-block.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..9dfe06e1be 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,15 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
         dataplane->iothread = iothread;
-        object_ref(OBJECT(dataplane->iothread));
-        dataplane->ctx = iothread_get_aio_context(dataplane->iothread);
+        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
+                                                          &io_holder);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
@@ -652,7 +658,14 @@ void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane)
 
     qemu_bh_delete(dataplane->bh);
     if (dataplane->iothread) {
-        object_unref(OBJECT(dataplane->iothread));
+        g_autofree char *path = object_get_canonical_path(
+                                        OBJECT(dataplane->xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        iothread_unref_and_put_aio_context(dataplane->iothread, &io_holder);
     }
 
     g_free(dataplane);
-- 
2.55.0


