Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A50606A327
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=njiP/oKm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xODiK-0000A4-A0; Tue, 03 Nov 2026 07:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xODiG-00009Q-KG
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 07:34:05 -0500
Received: from out-134.mta1.migadu.com ([95.215.58.134] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xODiE-0005Ln-Lg
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 07:34:04 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=9TU7yK9VL6zNNDRLJ8saOcFPLxS/49DWunAlRBXOquk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793709238; v=1; x=1794314038;
 b=njiP/oKmRmonB9A08591ojgPvZXaE0xASZy4pvagWBOer9MZKk0ouRJnJU4qvWf/TpqSHFrn
 FtAR8MZSwI0jQEG/U4NfuJocWkivSNezD+g9i0T2rwKs1kZzDRZcIFQHSS663jSP3BAzErWzpgQ
 sdkx99eCKa6RuBy2BGMfOTrM=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 45ea074fc63aeeb9;
 Tue, 03 Nov 2026 12:33:57 +0000
X-Mizu-Trace-ID: 45ea074fc63aeeb9
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, jamin_lin@aspeedtech.com, philmd@oss.qualcomm.com,
 clg@redhat.com, peter.maydell@linaro.org, kraxel@redhat.com,
 marcandre.lureau@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, junjie.cao@linux.dev
Subject: [PATCH 0/2] hw/usb/hcd-ehci: fix the abort after a failed descriptor
 read
Date: Tue,  3 Nov 2026 06:33:48 -0600
Message-ID: <20261103123350.1253202-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.134; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

2b2a0e4f465a ("hw/usb/hcd-ehci: Check for DMA errors in
get_dwords()/put_dwords()") lets a guest abort QEMU by pointing a
schedule descriptor at memory that is not there.  It is not in a
release yet; 11.2 would be the first.

Patch 2 adds the qtest: it aborts QEMU on current master and passes
with patch 1.

Junjie Cao (2):
  hw/usb/hcd-ehci: idle the schedule after a failed descriptor read
  tests/qtest/usb-hcd-ehci: test descriptor reads that fail

 hw/usb/hcd-ehci.c               |  14 ++++
 tests/qtest/usb-hcd-ehci-test.c | 119 ++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

-- 
2.43.0


