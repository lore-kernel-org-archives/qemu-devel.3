Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80BEC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5TJ-00010f-Nc; Fri, 15 Mar 2024 07:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5T8-0000x1-Lg
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5T1-0006pL-5O
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710501074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mUUFm/YQgpYBdS3K34GxW79Hy397pQ1HAvQ1hSkwbsc=;
 b=gk03CdtqLPGr7tkfwQp8wnfo/JpAAjXUd14aIiNi9gD+7dcWF0ZGfkAPa6/lQx4te1IJDa
 /5zAx2n5mV4Piy99JYCb1gdDwgiU+jqmhts60X7DcbCJyCJ45ia9y1uHI6bpBE1Na72JMD
 waOaaR44jeYlMtsw7a6ldYgkn2fuPNs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-H7_-m74hPzCMyTrKkfxdkQ-1; Fri,
 15 Mar 2024 07:11:11 -0400
X-MC-Unique: H7_-m74hPzCMyTrKkfxdkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04A2A38157B1;
 Fri, 15 Mar 2024 11:11:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D18D3200AD5B;
 Fri, 15 Mar 2024 11:11:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH 0/9] tests/qemu-iotests: Fix running with "check -ssh -qcow2"
Date: Fri, 15 Mar 2024 12:10:59 +0100
Message-ID: <20240315111108.153201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

I recently wanted to check for some changes that I did to the URI handling
in the block layer code, but I had to discover that a lot of iotests only
work with the raw file format when using a protocol that is not "file",
i.e. "./check -ssh -qcow2" shows a lot of failures.
While some tests could be fixed to work with the "ssh" protocol, too,
many other tests seem to be written for the "file" protocol only and
thus have to be marked accordingly.

After applying these patches, there is still one failure left in test 181
where I'm unsure whether it's a real bug or whether this test should also
simply be marked to work with the "file" protocol only. Suggestions are
welcome!

Thomas Huth (9):
  tests/qemu-iotests: Fix test 033 for running with non-file protocols
  tests/qemu-iotests: Restrict test 066 to the 'file' protocol
  tests/qemu-iotests: Restrict test 114 to the 'file' protocol
  tests/qemu-iotests: Restrict test 130 to the 'file' protocol
  tests/qemu-iotests: Restrict test 134 and 158 to the 'file' protocol
  tests/qemu-iotests: Restrict test 156 to the 'file' protocol
  tests/qemu-iotests: Restrict tests that use --image-opts to the 'file'
    protocol
  tests/qemu-iotests: Fix some tests that use --image-opts for other
    protocols
  tests/qemu-iotests: Restrict tests using "--blockdev file" to the file
    protocol

 tests/qemu-iotests/033                                | 6 +++---
 tests/qemu-iotests/066                                | 2 +-
 tests/qemu-iotests/114                                | 2 +-
 tests/qemu-iotests/130                                | 2 +-
 tests/qemu-iotests/134                                | 2 +-
 tests/qemu-iotests/156                                | 2 +-
 tests/qemu-iotests/158                                | 2 +-
 tests/qemu-iotests/188                                | 2 +-
 tests/qemu-iotests/189                                | 2 +-
 tests/qemu-iotests/198                                | 2 +-
 tests/qemu-iotests/263                                | 6 ++++--
 tests/qemu-iotests/284                                | 7 +++----
 tests/qemu-iotests/tests/detect-zeroes-registered-buf | 4 +++-
 tests/qemu-iotests/tests/qcow2-internal-snapshots     | 2 +-
 tests/qemu-iotests/tests/qsd-jobs                     | 2 +-
 15 files changed, 24 insertions(+), 21 deletions(-)

-- 
2.44.0


