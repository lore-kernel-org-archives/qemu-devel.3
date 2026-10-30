Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C235606A322
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M8tCYkBX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtvo-0007I6-6F; Fri, 30 Oct 2026 17:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvm-0007HE-1F
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvk-0007oz-L8
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793394871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OA8EGTh2LHyTjCsrhVyov8/0G+bygoDTe9ff+wGFdgc=;
 b=M8tCYkBXtY6XMc5hUCtWGkB1vUjZ3/X3cpb8hWc8+foy7hpGZpNcYKWnra5C1GKZYOH99X
 mhgPpqp1vI4z8N0sd8HLDvrnTrvtp9jZ8S1Z9KGaCdEbRgonXajOqWB4JjwKOJY+tGnxee
 ct8Ryhvs/8/7LNYeD72WSMRlBvgmgEY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-9Sdrs21yMq-4QQzrdhpRqQ-1; Fri,
 30 Oct 2026 17:14:24 -0400
X-MC-Unique: 9Sdrs21yMq-4QQzrdhpRqQ-1
X-Mimecast-MFC-AGG-ID: 9Sdrs21yMq-4QQzrdhpRqQ_1793394863
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10325195608D; Fri, 30 Oct 2026 21:14:23 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E0961956087; Fri, 30 Oct 2026 21:14:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 31 Oct 2026 01:14:06 +0400
Subject: [GIT PULL 03/10] tests/launchupdate-test: fix fw_cfg leak
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261031-nohmp-next-v1-3-9a9fb205cf3f@redhat.com>
References: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
In-Reply-To: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=852;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ef1xoJkzteTxrvRwuDSN+2T9qcVINSpbeSwRRP2z4p0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5QigNEowxRvfYgNJPLJ9iZy4vLXDg9MnCxjQr
 rNuCuOnONuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauUIoAAKCRDa6OEJdZac
 5dmWD/4oG7CaNDHHc1QcnJHoNfDR+v1mMCA20NWKBmL0AeT5YL2uVgg74ms3O48LH+kiSG56FPE
 iX6pOAxfKXJi+13BNPe51cxqpTPf4ZdAHuVfRdcWs0Fq4KxV4S8KYnVJo9LCYI2mQfv9k8kJA/o
 vsI0cVT25Fpxvrg8+Z4yWrcTdSKPU/29J/PWWI4oKEA65U8iBTFIcQ9aHXxbzVJMfJdR1XmwyG7
 cypwavd0K5M6sAck0wUQE3WLkxSMKYLk9vjiNbDo62ccvvb+HqMpNA/LGWwctix1u7zLG5867RZ
 9M/EIibufgKeV5d3Ub4eiSTW5EFtGx0dxBRJbHNIZdvm1dniLan1L1C2n0AT34bZ2rza0yCTS/l
 CZnykMbdsW/tWM0Bndp/tffXyCOoCOXBLmSOHNUF8x4CKOk3t0/2JTD3uLwK0Z5PGdtUYOX2eBw
 YYITfevHEwcNSWItEfvIHlsOXHzB7F8pMqeWHSS13ncJVjqiSynBAfCsMy+O7e0bEmwIIfDdUCc
 cp5SD4ssJCXypp2PE2BQP7jhQhLxXlCANV1e7OKWuD1CKrImTL+Q0gnL5sgc3Z5KAinEp2/oB5t
 g57VYh0mJLFf0vu4wrtMhyOimq1uSnXYkVngNk4o2KXle3x9Xs1CT/kfKijZVf6OR0VEp04sbpf
 agkyaqDqOCdZxSA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
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


