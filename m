Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AAAC3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOgYE-0005oc-Kg; Tue, 02 Jul 2024 12:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sOgYC-0005nb-LS
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sOgYA-0008Qa-AT
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719938412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MYxs85tFB5LUy8hxs5TCNTpdgqH3LOw1D/B/P7AvnkE=;
 b=TJ6onc5syraMnoKM3OTYAOTdrSW+RXtTzqG4JPYvXR4W+bW2ivquOht6Znc3lYBLx64E0C
 TOhr6/wYKtXbpmM6s9RQHVf/yQce2+qR4KLi79oMbv3Igls8cqSZ1r3PcMumGX4xqeu9rZ
 NPR31ajhnx9wTLfEfOYf6Uypn1zBwXw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-1jqaFcBmP0K4j3YfkV7ZxA-1; Tue,
 02 Jul 2024 12:40:01 -0400
X-MC-Unique: 1jqaFcBmP0K4j3YfkV7ZxA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 994881955E7E; Tue,  2 Jul 2024 16:39:58 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.206])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7303519560A3; Tue,  2 Jul 2024 16:39:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, richard.henderson@linaro.org, hreitz@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PULL 0/4] Block layer patches (CVE-2024-4467)
Date: Tue,  2 Jul 2024 18:39:39 +0200
Message-ID: <20240702163943.276618-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit c80a339587fe4148292c260716482dd2f86d4476:

  Merge tag 'pull-target-arm-20240701' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-07-01 10:41:45 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 7ead946998610657d38d1a505d5f25300d4ca613:

  block: Parse filenames only when explicitly requested (2024-07-02 18:12:30 +0200)

----------------------------------------------------------------
Block layer patches (CVE-2024-4467)

- Don't open qcow2 data files in 'qemu-img info'
- Disallow protocol prefixes for qcow2 data files, VMDK extent files and
  other child nodes that are neither 'file' nor 'backing'

----------------------------------------------------------------
Kevin Wolf (4):
      qcow2: Don't open data_file with BDRV_O_NO_IO
      iotests/244: Don't store data-file with protocol in image
      iotests/270: Don't store data-file with json: prefix in image
      block: Parse filenames only when explicitly requested

 block.c                    | 90 +++++++++++++++++++++++++++++-----------------
 block/qcow2.c              | 17 ++++++++-
 tests/qemu-iotests/061     |  6 ++--
 tests/qemu-iotests/061.out |  8 +++--
 tests/qemu-iotests/244     | 19 ++++++++--
 tests/qemu-iotests/270     | 14 ++++++--
 6 files changed, 110 insertions(+), 44 deletions(-)


