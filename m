Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B7606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i2i8ijVN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJR6p-0004U0-QY; Wed, 21 Oct 2026 03:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR6n-0004SS-HJ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR6l-0003zM-BJ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792569094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DO8OeMb+C+EUDoAt5gPWzSeCXRyILLDCf3aXuMCRFo=;
 b=i2i8ijVNP4pjLqLfmQ9EQi9vkhsG5YruCoSBZ9Nmz2dKc73O2bIWvQTWlZ9WDso9I8+elI
 5scLU5+s3k1a1K7G6OjRbwJTyYz0tHiQswo4lDiccEXb509F4WwUcKv5tJk8fUHHS15YUj
 s22hIevIUClhR0n0JzV7pcHYK3GpTlY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-kmyb-YKPNVutpIxs314zTg-1; Wed,
 21 Oct 2026 07:51:31 +0000
X-MC-Unique: kmyb-YKPNVutpIxs314zTg-1
X-Mimecast-MFC-AGG-ID: kmyb-YKPNVutpIxs314zTg_1792569089
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F27E71955F61; Wed, 21 Oct 2026 07:51:28 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2451E1956088; Wed, 21 Oct 2026 07:51:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Oct 2026 11:51:07 +0400
Subject: [PATCH v2 4/9] igvm: release found memory region on success
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-nohmp-next-v2-4-85471fca83db@redhat.com>
References: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
In-Reply-To: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=821;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wBMEnCG6NX/SrNvdiEREVxq3Y1p2VuUlUjKNL1jFJqw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2G7svaHG4HKe964hg4gbghz1LJx4EFl6HrRR2
 Oh8CM7g0zWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCathu7AAKCRDa6OEJdZac
 5TpvD/4yU3ApEJRs8JEtgCJ7s+haeWhGrUjS0UzaO2B8R3E1uVb014cbSgThx4vGrTAxgdOY+WO
 D2czUsOWyI467vewnw8zLmxyHLtumuHek0gNvh/4Ecki2QEpiSklerjac4orYoavBBNJjVE0z8w
 yyWMq+44Ram1YqA0VqNOmJDRAdgQpZu8sI5uanenojxIHTfgTUVaOcInVp6kZAnKJAZh8+O+uNz
 NxecSHmySQE2aL3ZUtu/F4n44hoWvj19xeck3HezXvH36Kihc4dpI6197RL6Vd1GYg+jUiChsOX
 xieRMgwTKoFw/A4P2Ub97SPSA9t9U1tPdvIN4SKuRVI9Te0fgaQWUXojPoLNFG3W+vz+L7JVNFc
 zzOpEE1qGKssbMzJEJonMn+Ywh4zjXVVPqNyJ+Yu5ZURIZB0XaoCMVm9RCK0n/BiZB+fT8dcn8h
 2ScR/PRN6V6QDn937PWVzfEbSnYmgd6oSNo+6Nz1WhA82F/H0OYD0fvrvf43eaYsDklFKoUzbXz
 uDHADz1E20h/tnzqYSRXkrccUj770K0D5ym5dCNGU/AUAMOmcHyGx7KRO3NnQ2MPOWO07x+C+jV
 4RTvNeqHLaAClo5GCq1Oviy/PP9MhcNx7JYWw7AgMlnXNXcVYa40oyUrbARmJPYFrk2iAyTW9YJ
 uYdffsM4D7F9hgA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Not only in error paths must the mrs.mr be released.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/igvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 58f3097e8518..7aa76441d0d0 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -268,9 +268,9 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             return NULL;
         }
 
+        memory_region_unref(mrs.mr);
         gpa_region_size = int128_make64(size);
         if (int128_lt(mrs.size, gpa_region_size)) {
-            memory_region_unref(mrs.mr);
             error_setg(
                 errp,
                 "Processing of IGVM file failed: Could not prepare memory "

-- 
2.56.0.116.g6de20f6092dc


