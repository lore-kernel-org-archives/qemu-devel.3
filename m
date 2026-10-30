Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D47606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XmBQNNfa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtvY-0007BG-7h; Fri, 30 Oct 2026 17:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvW-0007B6-AU
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvU-0007nr-SL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793394854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vrbEIo4OkHrhfMA/8vgFZrIeCgOwIf31uNqzcq04K0M=;
 b=XmBQNNfabp/hZxJO+hssSjHOebh7n0omHPDlLxnlYXHfi8XliuRL4uABOA48yWWp0dup5H
 pHHMog39HZhKtPN0HP3LcHNXxRzRK23BeJq8YU2vxSyv50BuNeeggsAPxNKor49lUTMoX4
 7TG5xfGsOHN1UYNZftou7FIUYaDUgS0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-ZgteYAmjNw-GsY4wXOpfdg-1; Fri,
 30 Oct 2026 17:14:13 -0400
X-MC-Unique: ZgteYAmjNw-GsY4wXOpfdg-1
X-Mimecast-MFC-AGG-ID: ZgteYAmjNw-GsY4wXOpfdg_1793394852
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DAB11955F6D; Fri, 30 Oct 2026 21:14:12 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C9AD7C6; Fri, 30 Oct 2026 21:14:11 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/10] Various ASAN & tests fixes
Message-Id: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
Date: Sat, 31 Oct 2026 01:14:03 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=O5qj4mgjlG3wlRGgpQpxqseW/WK70LnU5hn2aWAXRf8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5QigIppgu2WMxFVRxmqM1uXclGN3rrPmlqPGz
 pa8SYiG2aOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauUIoAAKCRDa6OEJdZac
 5UBWD/9jx8dVgfv0fuptH8t5cpYlJFLsEMYqffZ7y15PeIDk9hsGjC6Mr/veDyxtNyfMKybo+ln
 6Kfc3lQT40DO2OGQeuHQGq464SLevXVipbd4uA9SB0fMrOf2sdn0XPmN4ff1hDk1Idkj/G78A1U
 8j50coET+cYasFJmcMcMFiwTWWdODk3znxn1M0VyQVo4SpqvAYl4wHFOnn6Q7WBwj0n26fKDgB0
 thUYPXIH6V07MEN+qPUELDsGRlZc/epSK1WbZQ6jGV6QznJB/BvS2p0DF3OIZoPq6xfBZkVXLZi
 2F2nV1gZTgkkLEySZxNAJCc4egah8exYgasew4N11OOwdigiPKxJq6i1anQtHBR/tgmSDfoqJLs
 ijeE+PWBvFQEE2MWwIRe7LlHqT7wMzt6JIOW/KjWZYF62XVCvsXlD/BFM+fIouZgf2RfwC0mThj
 bktfAqT692texfXo6Y00ojRqQRShdHg5s6iRTn4vnVjSeBZiTcskpy7cLmTewzvmhIi/k0h9VEO
 s9Tzbkk46kc1Cp0EyMie+LbutIcaEepNKNKxXFN2l0h6j8KxDywDtPyE1vhKG6Aa5eaUuFKz2Hr
 9wLbYVs5lV4cTx8k0C2b9OWz99GGXc8WO5wuzP9pCx+l93SgPCrJ6a7ionAuh/JhVhA61DjQ8B4
 0a3CuaLOuXrmbGA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 7f36b1fbeb1f6f070cd5f8eddb3edbcafac15440:

  Merge tag 'pull-tcg-20261030' of https://gitlab.com/rth7680/qemu into staging (2026-10-30 08:16:19 -0500)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/tests-fixes-pr-v1

for you to fetch changes up to 02292db33e050fc68eec423c27d459ac4c28694d:

  tests/xilinx-zynq-sdhci-test: fix GIOChannel leak (2026-10-31 01:13:57 +0400)

----------------------------------------------------------------
Various ASAN & tests fixes

A collection of leak-related fixes.

----------------------------------------------------------------
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


