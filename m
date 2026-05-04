Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB86CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrcr-0003pG-O7; Mon, 04 May 2026 07:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcn-0003Rw-PY
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcm-00019E-6I
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xc4SYT3UnDMGDLgyYV/qbHsyXvfJpgId4SJTPvnG1QY=;
 b=Voal91GO1/1uKbf3xrIUQ1A4fSwJDuLerhJugPkA3AFc5hNu/V+zgjlncAF1OzLSTgoySE
 TqK87WYyfijZToMG27Haq9wPMUPKCRaGgA+IURtUx0EiCEx7ZWaJzLbWi0JNX8j74WsvL2
 llH0rf6T/Kz1u8fdSZIy7fPNdJEYScI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-J3WzS-EkPz6dGcGkuAukjA-1; Mon,
 04 May 2026 07:38:04 -0400
X-MC-Unique: J3WzS-EkPz6dGcGkuAukjA-1
X-Mimecast-MFC-AGG-ID: J3WzS-EkPz6dGcGkuAukjA_1777894683
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC9BE1800348; Mon,  4 May 2026 11:38:03 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55F951955D84; Mon,  4 May 2026 11:38:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:17 +0400
Subject: [PATCH v2 29/46] accel/kvm: free device path on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-29-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+3VxTolW7meb5x/gWd6Oe4Wp6U24+GJpNUhUzxlJdXM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtXo4gNvFN5HsiKYwHneoRWVXav8hTQaR9/
 EN2lVcNGwWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5ZBLD/sF0VqaziShcXG9xeWw77zl588M9pJcs/ZQYVWCQ/IlBXh6bm8n4cPzffKDtQ2gIiXl61L
 Jr4LMbhviar5ovhH2XAExwvFs9afnt8eUouzjp8SeXuyJP0YfBAFUv4TzVWf0ss3pNW/tAg7L8W
 515m8v8/PJ5lesgjc1Nhq/J7iIWcaaCzU2cSY6SuwMcj3NQMcr6rW8UUfUvIoXBEpiH7c1ZW/ZV
 qnz6SzdjDGs7QObn4kfnCmbKSqPX21a7xHibrBfcJnzU6MkFoYGWQsTTHocJD3pzQQ1MaxZhLuY
 lSwdZ6V9u3Sl7Yu6Tdv67VU4m1pqlk97jsvqEkUwZA/PxllwpLko7g87kU8KQj0ty3epXf/XZ07
 /q5BUE9RucA/DClbHWmQ0Qkb7MfiN+Iauic9XmHlbZLW52mytAJGqT0ZUX2QmbAFJFFE2ADbhB7
 NLKx+SB1UHoMuYCMx4xW3+I7uFstuQQusPAsVWMRXxKtiFAbtwUvAFf1sIRI16rObmXGQ4GjTIn
 2fVAj8PzTqeHVr9efIy8+uOeid87g/p26ioZJWvGAwBg7+Vk8IUxsDbdlUK3dqhRnoQCXSj/947
 gYhADucZ10I9ZlYiw2Vxkk3VdC0EHtwW89V339GzANaCA7dpi1DD1WBbgFos8tp93+aiSRvDxim
 IlRoC1M85MVVM9A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

kvm_set_device allocates device via g_strdup, but no
instance_finalize existed for the KVM accelerator type.

Fixes: aef158b093b9 ("Add class property to configure KVM device node to use")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/kvm/kvm-all.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 92af42503b1..96f90ebb240 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4342,10 +4342,18 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     kvm_arch_accel_class_init(oc);
 }
 
+static void kvm_accel_finalize(Object *obj)
+{
+    KVMState *s = KVM_STATE(obj);
+
+    g_free(s->device);
+}
+
 static const TypeInfo kvm_accel_type = {
     .name = TYPE_KVM_ACCEL,
     .parent = TYPE_ACCEL,
     .instance_init = kvm_accel_instance_init,
+    .instance_finalize = kvm_accel_finalize,
     .class_init = kvm_accel_class_init,
     .instance_size = sizeof(KVMState),
 };

-- 
2.54.0


