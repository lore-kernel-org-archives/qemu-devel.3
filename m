Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A3606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ewu51bv9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrGu-0006hp-TE; Thu, 22 Oct 2026 07:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrGt-0006gr-Dt
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrGr-0007DA-DZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792669664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5l/XuPhAYD0emy7OQjadRYGx0b1N76jPKkvytT4cZUQ=;
 b=Ewu51bv9ZKC7sN1fY2nDf5iEPDXCdeA5QtgfGn78PqGaaoy2lBY53VvK82TLHdv7cABB/w
 nssmcWeiE+ocKMWj8n1sU4c3LahhL11uOMY1o6BQ1BiknzpZ1ebEkjp5b3D55vqGCxEmmN
 gQhCdg8J9vYLy5FZ1ERalnxks702YxE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-QtreKEItNGSDPbxCDMAjWQ-1; Thu,
 22 Oct 2026 07:47:33 -0400
X-MC-Unique: QtreKEItNGSDPbxCDMAjWQ-1
X-Mimecast-MFC-AGG-ID: QtreKEItNGSDPbxCDMAjWQ_1792669651
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E3F31955F25; Thu, 22 Oct 2026 11:47:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A881730000E7; Thu, 22 Oct 2026 11:47:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 00/10] Various ASAN & tests fixes
Date: Thu, 22 Oct 2026 15:47:13 +0400
Message-Id: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NXQvCIBhG/0p4naGvax9d9T+ii+lem8F0qI3F2
 H9PFwSDLg885zwLCegNBnI5LMTjZIJxNoE4HojqW/tAarrEBBiUrGElta4fRmpxjrSquGTQKMU
 0kCSMHrWZt9jt/uXwkk9UMRfyojchOv/e3iaed3/DE6eMggSOpWiqQourx65v40m5geTyBD+XM
 +A7F5Jbn4uKa9XWopM7d13XD3VJpsnzAAAA
X-Change-ID: 20260906-nohmp-next-771b029cc0f2
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
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uGWqcxwRHcP2DRJt2/YVlma7JgdvWUlxtWF3e0xv2Vw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2ffMUjdbsIZihsLwJUrLAVgVnaB947RcsCMys
 TpK75neEeWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatn3zAAKCRDa6OEJdZac
 5YNJD/98QXJOuJ5h2GBKF9yllriT9YRiCtILJ5kaBSNuvNteI0D/asYne9H7BP8P4MP2yo+91xi
 gCWVKky98l75N2Oqx1TTS5bt3DvXHuziYkgnCp3v14+RPtAT8EnKc6lToh8/49JueJ8ATykjGys
 QGCB4QWgVWz1aCxYvEO+ZyowRBOdaOJ7vpAvwKU6Vbz67RhdOJI83DG8VIheWMYMv2/ksamzNM+
 P0/w1PgZohb8STQcovgsuv8SPjfpV54ol2V/PcRna49CNdeIFCuGboTIEPu4NLkGjyQtdoFhJhw
 1RGph5hLM5xoxz4wDRP1bvAOTUQ+RMY6ACKhRnav/6IbFVoW90x/lp0bad9S4t+WWAuuWKwtkRS
 vOCa9yfLEvuMsLKFy1x5q63HamlnkUo70/pF8xhT1Kx7iuVsjse+h8YwELF393vIKziZCRbEtBD
 LgSoiRZXT5YKbmR4S8hpCrXfsiYrIs5sBja4bHhHeaheu+pOhRT21ilbkG9g37nLbZVYYxvuNtH
 V3DRYoOtHAwkmkWHQlz3+RqSPA8UPdZu/C5FOKNA6rRYx00uSMIrBJ2mSpdSGzJnomNqKs5bsQI
 oWXVEr+vj1FRapGyufFuqYtM/U054CJjAgZV7oR6N2uD+Y8lOzCoCC5IADe6Gkbo4uY90NXumhw
 7xAQmc1zM57UmBQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Hi,

A collection of leak-related fixes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v3:
- add "migration: tolerate NULL ram_block in vmstate_unregister_ram()"
  to fix qom-test crash with IgvmMemoryRegion
- collect some trailers
- Link to v2: https://lore.kernel.org/qemu-devel/20261021-nohmp-next-v2-0-85471fca83db@redhat.com

Changes in v2:
- add "tests/exynos4210_uart_fifo-test: fix buffer leaks"
- add "tests/xilinx-zynq-sdhci-test: fix GIOChannel leak"
- add "glib-compat: fix g_autofd fallback warnings"
- rebased, collect trailer tags
- Link to v1: https://lore.kernel.org/qemu-devel/20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com

---
Marc-André Lureau (10):
      tests/launchupdate-test: correct g_auto usage
      tests/launchupdate-test: correctly release qs
      tests/launchupdate-test: fix fw_cfg leak
      igvm: release found memory region on success
      migration: tolerate NULL ram_block in vmstate_unregister_ram()
      igvm: make IgvmMemoryRegion a QOM
      hw/s390x/ipl: fix short SCSI loadparm buffer over-read
      glib-compat: fix g_autofd fallback warnings
      tests/exynos4210_uart_fifo-test: fix buffer leaks
      tests/xilinx-zynq-sdhci-test: fix GIOChannel leak

 backends/igvm.c                         | 99 ++++++++++++++++++++-------------
 hw/s390x/ipl.c                          | 10 ++--
 include/glib-compat.h                   |  8 +--
 include/system/igvm-internal.h          |  9 +--
 migration/savevm.c                      |  3 +
 tests/qtest/exynos4210_uart_fifo-test.c |  6 +-
 tests/qtest/launchupdate-test.c         | 20 +++----
 tests/qtest/libqos/libqos.h             |  2 +
 tests/qtest/xilinx-zynq-sdhci-test.c    |  6 +-
 9 files changed, 91 insertions(+), 72 deletions(-)
---
base-commit: 8967b2fe1b2aaae3c29e207d85fab901d580a2dc
change-id: 20260906-nohmp-next-771b029cc0f2

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


