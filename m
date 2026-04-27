Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C9AFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRtB-0005AH-PT; Mon, 27 Apr 2026 15:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsw-0004gB-A6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsu-00082I-TU
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5iQUKbZP8zujOPvMI08chGq/OJpRT5TuzZ9VyP7o4g=;
 b=R75bSFiX9eNcuNKvuUmR1OHVRMUWCM9IFKId7QwRsxZPWjVDE/ilFsUyLGx0RNmwIeLci6
 7xs96wyWLVmpLEppu4Lz+d/igN0zUYrggh1sPLBegLiex8WSiaLbFUODq0qutmieUwzwHJ
 J/Q0Nzd1UUSxgcaxHcxG+PwvQ/afUgU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-7Goht9LqO8ybHpsB2T8qdA-1; Mon,
 27 Apr 2026 15:44:46 -0400
X-MC-Unique: 7Goht9LqO8ybHpsB2T8qdA-1
X-Mimecast-MFC-AGG-ID: 7Goht9LqO8ybHpsB2T8qdA_1777319078
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 051EB19560B8; Mon, 27 Apr 2026 19:44:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B76719560AB; Mon, 27 Apr 2026 19:44:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:21 +0400
Subject: [PATCH 22/41] hw/i386/nitro_enclave: add instance finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-22-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Alexander Graf <graf@amazon.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ky2BNto0UCWYm+5t0f6AgVp5RVCDBWwnYNiNyNbKi5s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVJtiinN1Nw+U1eSXwgM7UXadi6GnL7vyCA
 QCzbvybpieJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5WraEACm+lrN9ji+8C+X8qXlo4uk2Ipv9iD7FwKo6j3IA2pKwbk4TiXNjW9SEPu++g+P1VaadQK
 3bleSRmh091TM5S3SxIgUaezpgC7rxHXYNiPj6Eg/GYiMHJOrG8Dg31PzyhS9BMzX24fURuuQFB
 IPbYcvVijojvWNkRCI27Tu37rHQf8+AKEeUV6qKSLZLPTn5NNUO11P5e1EMp6wgeIt4W2Qq/9YY
 cRVA4lwkj1C+s8LxhlBtP3Hno70NcLxtglo79ZDTuLyh0/12HtagEdDltSmIYts0IG5lKXs8Jq7
 55PtwKybV/6tDqQ6Vkxjq+68SgyTfZIDv8j/UTLVkwL5Aps6o4xCTWTxgImS4szB55N7stG/iF0
 mXZE6zLVeXtROJv3QDQ+ulugf83DMLyVKYJGTSe4IQ4EcpyRpX9siK0fzrYUVw1D+un9dSWo+X9
 n2AsPMPwpgl475ltsqlK/6VFbq/osU8DFb5EQq4BfNwYD9/ykOSWAAqwvVcW3dJja3iVUKs+PPP
 /uLxI8Lu9f44rBaAByzuTdIscJ2t+BwCm6BIEwhDpTl/Fwg2TqYIxYmhuFQP4Wmf2v5Jgs993Y1
 LSkJx3OwIxdaBanhFeURpcwR7sea54O5CuLRC2koIQkwTyVUygCtNKSYgYQto0SNZJygy5Xw0o/
 EwJx1tJzlK6DGpw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.53.0


