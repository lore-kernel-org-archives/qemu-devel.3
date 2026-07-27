Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C750C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJsV-0006aR-Vg; Mon, 27 Jul 2026 07:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsS-0006VS-6K
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsQ-0003jf-K4
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5UQGqeTaYi2kaAkB+026BcAjPwRZW9Yj5wzH4u9ATk=;
 b=CIUM+vo5YvAg0esckBw1nJVNHX6Du8+BPFepo8sbPmLGJk44jIkT+F6cJlrgrRsGwnf/1d
 XS4LmswazC3NfqR95YBhd1RnfroSfxyv2cMN/MQ36tycwU4vE+BLA3tbk08pZ6dnQ7QCxZ
 527LB7mc0wm6kY84nYRkUkQh7geb84E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-BLrv8nnUN0q04OGhaR7ezw-1; Mon,
 27 Jul 2026 07:52:07 -0400
X-MC-Unique: BLrv8nnUN0q04OGhaR7ezw-1
X-Mimecast-MFC-AGG-ID: BLrv8nnUN0q04OGhaR7ezw_1785153126
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EACF8180264B; Mon, 27 Jul 2026 11:52:05 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B732429; Mon, 27 Jul 2026 11:52:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:15 +0400
Subject: [GIT PULL 06/23] target/i386/sev: fix MemoryRegion reference leaks
 in gpa2hva callers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-6-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Mhhc24sMg3/r/S38Qe+3S85s7KlVq/EDYB1GAklx+k4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y+fGj1ciGYg3/G6BtXKbg01aMqoGrpUPrq6
 0Eq0DGF1/WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPgAKCRDa6OEJdZac
 5RgqEACKwy8dkLIU6JwSGzDKMtVXkr7DEfaFR3siAcCWRK56vUVxeOAjrGtp7g6AGSeQusDHnTK
 JRF379tFVLKYhql12Y2sMGF9OFA+0ttIeSgzujJhqZvpcL5Tpf6EE9UUE0aEjZooDJNCsw8/dik
 DnKcpLzXSHueyJCVcbtOQDzX+TxV3hwGaRu5NOykg1xIvJZdF0ydMrtgltiSAnpSanHNbIJ5mdQ
 ydwHv/QXaoEVbn9qGHsdRdXs4P9fAHUvkZtJ44zXps3+MPsFsXoz6r767J17oEcpyoBjBnwQ8bA
 y1BaM4Owwm/QPRRmlUa6DjdDrGphJ3QTfGkedTmfSuoK4vrXpK6EMeKwNs/sN/Mk6WAYGXCqkhq
 I15cWgKFMR35c2Ye/czw9wlQK26TSRXvjmSVG8YWcM0Pwt5ZWLqQnJFaG3Cl3G9r8rJuAJPRR1d
 0xfD+G+RUzGAqWtn4Zd/koJjhgwN2IrYcdIe9P1Umw1IdOzVjhIKoGodZpKLQWmMQCE0q/2RIpV
 de1L2pYHHjY+x/s9SGuqXnSHF7CrZ0udwZRsaItFM1RPaiFb3fkWnsmOCZBbcnnPKuF4tnLYZM9
 R2rJO7r8VbuZvKGo0un507lqwc6Ob7XeUeiCqcq1kx9wND0tUae5GEY2yB5L3XvBavWFaERtzie
 U01/X2mJUzRjcqw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
(inherited from memory_region_find()), but both SEV callers were failing
to release it.

Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
---
 include/system/memory.h | 2 ++
 target/i386/sev.c       | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 47a0e06fbf8a..2192fc9bdc5b 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1085,6 +1085,8 @@ void memory_region_ref(MemoryRegion *mr);
  */
 void memory_region_unref(MemoryRegion *mr);
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(MemoryRegion, memory_region_unref)
+
 /**
  * memory_region_init_io: Initialize an I/O memory region.
  *
diff --git a/target/i386/sev.c b/target/i386/sev.c
index debe6344ab4d..d7dcefc8ecf5 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1569,7 +1569,7 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
     OvmfSevMetadataDesc *desc;
     int type, ret, i;
     void *hva;
-    MemoryRegion *mr = NULL;
+    g_autoptr(MemoryRegion) mr = NULL;
 
     for (i = 0; i < metadata->num_desc; i++) {
         desc = &metadata->descs[i];
@@ -2063,7 +2063,7 @@ int sev_inject_launch_secret(const char *packet_hdr, const char *secret,
     int error, ret = 1;
     void *hva;
     gsize hdr_sz = 0, data_sz = 0;
-    MemoryRegion *mr = NULL;
+    g_autoptr(MemoryRegion) mr = NULL;
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
 
     if (!sev_common) {

-- 
2.55.0


