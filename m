Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538A606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iRhpMCrp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLljI-0001s4-0o; Tue, 27 Oct 2026 14:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLlhW-0007wf-3s
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLlhT-0003Xh-FM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793124905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjzJ86NcoOOpiqoXBZbehS0Nmy6hg8V1H9Fb+oCNfGQ=;
 b=iRhpMCrpmb93p78yttMF8+Fa4PKWrnSrZBkisJzWBrrsU4r9Sw3HUgWqS2xPiPMc6z3fVZ
 Zzk0UYMhnsJuB54rDaZ2KJCTxUOQrhL13Bib65gwk/Fbqx68SfDgaXKHEXit0EugYMrbWz
 ldId09VlzCA4SVJpUcMYTvhKW9j+OXI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-6LQe5KMvNl2nCJ5O0yFuYg-1; Tue,
 27 Oct 2026 14:15:01 -0400
X-MC-Unique: 6LQe5KMvNl2nCJ5O0yFuYg-1
X-Mimecast-MFC-AGG-ID: 6LQe5KMvNl2nCJ5O0yFuYg_1793124898
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ACCB18052C5; Tue, 27 Oct 2026 18:14:58 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2AFAB18005B4; Tue, 27 Oct 2026 18:14:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, xen-devel@lists.xenproject.org,
 Sergio Lopez <slp@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Bibo Mao <maobibo@loongson.cn>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Xianglai Li <lixianglai@loongson.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Song Gao <17746591750@163.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 06/11] hw/s390x: mark 's390x-ccw-virtio' as a secure machine
Date: Tue, 27 Oct 2026 18:13:55 +0000
Message-ID: <20261027181400.1752951-7-berrange@redhat.com>
In-Reply-To: <20261027181400.1752951-1-berrange@redhat.com>
References: <20261027181400.1752951-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 's390x-ccw-virtio' s390x machine is already declared secure in
docs/system/security.rst, due too its intended usage in virtualization
scenarios.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fda5ecc9ad3..15b16ba99d0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -986,6 +986,7 @@ static const TypeInfo ccw_machine_info = {
         .name = MACHINE_VER_TYPE_NAME("s390-ccw-virtio", __VA_ARGS__),        \
         .parent = TYPE_S390_CCW_MACHINE,                                      \
         .class_init = MACHINE_VER_SYM(class_init, ccw, __VA_ARGS__),          \
+        .secure = true,                                                       \
     };                                                                        \
     static void MACHINE_VER_SYM(register, ccw, __VA_ARGS__)(void)             \
     {                                                                         \
-- 
2.56.0


