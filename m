Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6D3FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrcj-0002ng-Cj; Mon, 04 May 2026 07:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcN-00022J-Di
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcK-00015Z-KV
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dJKu4geQlHBf6lMxppaNvhNAzdufK74d/8yyA8VcsE=;
 b=hT+zUrmzvAhULmZjBMmPsdGcGc5eo6qBtzf+pnfOqLTIm8hzSZh7LVGj5iOyJ6V6dcc261
 NafalVVgESj+j3yMhOZ32YKI2BPevoYy0s9X2SKoxBNYmgh7QHyiy+DstQs/NQJct5XEMT
 iiIfMldudq748SP0A+vLAOxjYwJOftI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-HDi1kYHgMW6cd0UT88kUng-1; Mon,
 04 May 2026 07:37:38 -0400
X-MC-Unique: HDi1kYHgMW6cd0UT88kUng-1
X-Mimecast-MFC-AGG-ID: HDi1kYHgMW6cd0UT88kUng_1777894657
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4843E19560AA
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:37:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECDD319560A6; Mon,  4 May 2026 11:37:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:13 +0400
Subject: [PATCH v2 25/46] hw/i386/nitro_enclave: add instance finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-25-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tbNjVBuNQT1J/I99CQO+THdkJr89PRbTP6A2UGBoPgI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtmBKol32OpJV6oTQ8cR3y1lC51DJYEKUI1
 S2tEmx7FUGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5Z1RD/9i8R/fipjKEfksf2lx9vzypHpkp2xUNzocXZqK7JZpEs69FWntDO/1zYUYvkedP9EVL0t
 PDYptBhb3C5Ts+wLC/doT4yilggEVZlp09Gia4NSwMx7a7Jf/uHzmPXQLVG4ZGQvQi5//6+NOrk
 N6A+XFOi143N5GHmFrCjZKq4N7WkafE5BT1dGxFsbcerYN6R99yb1iAnygqTJHPJdlFJdnsTleF
 xdkHZoRYzIE58E402RewfKbh0ayowuOMKFmR9+dpiT+FOcMIbFDeLVzFp3jnxgTU2jY0OeYuzdH
 r15Bg1oJHEdkmTY1dcpKGtYXUnMcQmAvXGk2vz7CMpfw1gGRAKRpN79X8qaEo5shLOh9x7Qeqy+
 B9NsN646SQd6OQ4gJQnmc1PjapKxfVolUr/JH8k9FrESsgiVp2y1u0njgawgIp8JJyWV20Q8Yfr
 nBap+muQK1ITURyz8Og2KrlelDAylUkBv3smMRnD4MXRiBs3IMqCpx0dI3yPA3wtlGJ1uYFVvdw
 n/z+37lCVEEUq5xoIXopTs2WTNvTzPNS5JkPUZQcrPmRnU2aFZOwTXlbKEjBMEMbdh7jjrEL7YU
 UxVaj/Zj0CRNIVmeuHOwPQYHdDQwCQLHJSYlrkBCHH17rulRlx7vGFlTr20T4nYyE1GfS/eBXN+
 WeDYngWxepZFmBw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Property setter strings (vsock, id, parent_role, parent_id) were
never freed because nitro_enclave_machine_info had no
instance_finalize.

Fixes: f1826463d2e8 ("machine/nitro-enclave: New machine type for AWS Nitro Enclaves")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/nitro_enclave.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index a29f0044d0e..1ce9ee3358a 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -337,11 +337,22 @@ static void nitro_enclave_class_init(ObjectClass *oc, const void *data)
                                           "Set parent instance identifier");
 }
 
+static void nitro_enclave_machine_finalize(Object *obj)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    g_free(nems->vsock);
+    g_free(nems->id);
+    g_free(nems->parent_role);
+    g_free(nems->parent_id);
+}
+
 static const TypeInfo nitro_enclave_machine_info = {
     .name          = TYPE_NITRO_ENCLAVE_MACHINE,
     .parent        = TYPE_MICROVM_MACHINE,
     .instance_size = sizeof(NitroEnclaveMachineState),
     .instance_init = nitro_enclave_machine_initfn,
+    .instance_finalize = nitro_enclave_machine_finalize,
     .class_size    = sizeof(NitroEnclaveMachineClass),
     .class_init    = nitro_enclave_class_init,
 };

-- 
2.54.0


