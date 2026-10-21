Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0D606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IZudDU2O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJR6r-0004WP-Fi; Wed, 21 Oct 2026 03:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR6p-0004TX-2I
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJR6n-0003zq-KY
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792569097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWiu4rdH5d4Ohomxfbbk+J9JlwPMqxTLl3rEhWFpI9s=;
 b=IZudDU2OrPikMADmgxVi/TmMfZN5/VAm9Av/K/dHxvVxRMIDFG7HmLfFazdVe06NiaB+lN
 a4qhfkYJ0J3Xrt38bkGPuxSKtu7Mfg0Vbdsmvjduf5jKHcEFepvG42q1oetEExc790Ydte
 k3kM4utOhc9oYc/VwF6HNDYLjjX48DA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-6YvJ2dskO-yPHklQrKmoDw-1; Wed,
 21 Oct 2026 03:51:27 -0400
X-MC-Unique: 6YvJ2dskO-yPHklQrKmoDw-1
X-Mimecast-MFC-AGG-ID: 6YvJ2dskO-yPHklQrKmoDw_1792569085
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D5BF1800591; Wed, 21 Oct 2026 07:51:25 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9B351956087; Wed, 21 Oct 2026 07:51:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Oct 2026 11:51:06 +0400
Subject: [PATCH v2 3/9] tests/launchupdate-test: fix fw_cfg leak
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-nohmp-next-v2-3-85471fca83db@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=761;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=X2HUHDf+UkIywAf5xGFW5GDIxuTg6SMnnUvGwLSGYRs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2G7sXbtCZ6+VoA/0Wt2VQCZ+7zXD8JHy97dAF
 TQO8c6oi3GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCathu7AAKCRDa6OEJdZac
 5Yv5D/9eB20Pqh+b/Vly4fLmJw4wWIRRV6op3zTdvQgrql0Xp+XU1JvanBIQGBVaRkyPJLnMXS/
 Rk9vSraxN2sXe5LFyw4pl5F3ICgcY/Z0Y49G0RcG7P/cLCkbuqBCLKpPnV4LUQ2NXdaONlR/qLf
 FHDrNrpIpUnekTzXsEuPnB9GwJFwz6VVLIUYUBdGfr0sekxmPErR2DeF+Fs4ELc1SZrXTTdUjXW
 oMiUB2zu6JsTWH7UAU2ITjknPiQdg2rYeijSO0FF0ws7VL3UR5qIIdzuT0huYUpHhS4XNexrI0B
 Qg8UukrlSPGHvnubsk9dZ7kjSFM/9NncZgk1euonwoDUWNyONSZM9Zy2VGC8LhN8tNLGHeP68Sf
 RkxmqPkYauaa6FQTDM/KjDRwp3TNpvZRVSK9EfYt9O33yFatmSLPFDB0EAM3LTobzjNcIH1iZRr
 lP5oAJzxhbRBySH2yRwM9VuxcVAPAWYUtVdLpqSQ7BmtyOLvwKJ73ZcdlDhCNIishhb/2FX72rs
 51gxbng1RZ4vtgsI+hXROf+slPDw0o+7DKXWwIjTJljV+SZxnUEDNlzJsFAXepnAgrJa64yejxr
 panEvvphD0jIiMhizgspzEIqSbFgQZU8vwBl10iL2nf5l2fQt+wqwxv08d2EihvEwwhNsaUDeaQ
 zhFNmHCfM3wvQ9w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/launchupdate-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/launchupdate-test.c b/tests/qtest/launchupdate-test.c
index ea35da81feb9..beec902caa6a 100644
--- a/tests/qtest/launchupdate-test.c
+++ b/tests/qtest/launchupdate-test.c
@@ -148,6 +148,8 @@ static void check_error(void)
     status = le64_to_cpu(launch_update.status);
     /* should fail with LOAD_FAIL since it was not IGVM format */
     g_assert_cmpint(status, ==, VM_LAUNCHUPDATE_LOAD_FAIL);
+
+    pc_fw_cfg_uninit(fw_cfg);
 }
 
 static int64_t get_image_size(const char *filename)

-- 
2.56.0.116.g6de20f6092dc


