Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E13C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54IF-0005FQ-2l; Fri, 11 Sep 2026 12:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54I3-00059u-OF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54I1-0006ke-HZ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqbhsKNjbgDXlQcuFtKvsuc9htp5BzIptdWvWLI5SlA=;
 b=I+hfXxsedhmtLHHwPalpbmZPEXgY6oWx/2ULXH2CD/rPIGRWSrxgeiIsqYvdKFGOs67U7z
 qdAHxmUOBSYTetCgJfKfgKxcsYpjcz4CJxnoa6vOsKCw9X3iU6VuDKfoT4VhzpdHPZ472S
 IS212I5NPbTwlI61gqiasahoIHHJPsg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-KeZxKL_YNBahI64En4K7sg-1; Fri,
 11 Sep 2026 12:39:44 -0400
X-MC-Unique: KeZxKL_YNBahI64En4K7sg-1
X-Mimecast-MFC-AGG-ID: KeZxKL_YNBahI64En4K7sg_1789144783
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AC05180066A; Fri, 11 Sep 2026 16:39:43 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F336180034C; Fri, 11 Sep 2026 16:39:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:10 +0400
Subject: [PATCH v5 36/62] i386/cpu: convert strList property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-36-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SPRNseSbAdO6Ph77aIE7aq7IziNtT5hbLLPbez+gQAA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC26y1iV/AbIOdlmH8K4rZ7SSGuWuhsglgivM
 lOmDBS9dXCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtugAKCRDa6OEJdZac
 5UxlD/9+FVW1WEM/H5Nn/Kod0HPNKL7wApEp033LAvKI+i94jLwDQy2Ghb3mZGDDolabs+30tsC
 8NUYQhcLVGLOBvPg+rQhJt7BMaI64PdAr7cPb9DDDlRS+XcSPpyYve3b1l/nSDG/bLwa9qGDiAe
 P3f/Zne47ur2IffwA2R5mRzvvPJt59SJreDZjz+Sv2OFAgUsWFNiJeG+0AD+v+0/iZWj21axheU
 a639Fky0K/LiWxN80FDXfErk9SeBrIwMzIu1w/aKVEyVsQw6Whro4aAjnh2XBtjnT0wnPkoLQX+
 bq5wa5H9s+Kn8X8NH9fFjvr3e6A73Ex2yYySVwlk7wwqxtxbnkRydsNhZV8y9brF2PIW7Bqnp4A
 KwfLozwbhjj7g8XhJPVIMPt0vPF34Yen5Gq1jLhDAE+58A/ubLGffqpFbeGYgBbSRfVTgFmlC1i
 g8vvGP6v2vU0hm3itN93q56ekvdHIUmWBNJLDhWRfYBtX3vXQZQlbylANc19ExVNUiiSjSoKNRt
 k9hJW2MzzlD7N2kn0VSVeznIducHRxzPM0AhvBrggSeDx9jNJah2ntn3etYBbIVVAqXBvOpvjU7
 iKZ/oBwSitvV1jZ13c5YmccCgKGTTxk00U7k8bNXswxptfp82IMqaax+Qc0L+bjjUANaAiFWGJr
 T9QhpIKQPhMz6kA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ebce8e128224..f5a9d7c3d2c2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10974,7 +10974,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
      * QMP command: they list the features that would have prevented the
      * CPU from running if the "enforce" flag was set.
      */
-    object_class_property_add(oc, "unavailable-features", "strList",
+    object_class_property_add_qapi(oc, "unavailable-features",
+                              &strList_type_info,
                               x86_cpu_get_unavailable_features,
                               NULL, NULL, NULL);
 

-- 
2.55.0.543.g5ebe2ebe4ea8


