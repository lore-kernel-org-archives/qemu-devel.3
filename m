Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D58C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 13:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFYVv-0008KI-NV; Thu, 15 May 2025 09:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFYVs-0008Jt-6z
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFYVq-0003an-BK
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747315236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eWAQav3oZRwcI4Yz65PWMHYpkd524jMlB/PEv9XTogA=;
 b=cmrIlqHC9p7ZarC2gOx0DiJOhf6nGkKA7c0LO27uHLvAJjpWt7KMwldEYq/hpM9WZLoiHw
 +2hhP0tJXslZaGF5NOP5PALzY/2NQyE7SqGQADIEnhj+gUgWZYv2vGmPXLXixogipn9My3
 +BSY+4uI1RubbnGe5zK0J/QMEiPygwo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-KDYnmGJBMSiQFDnBlRBPkQ-1; Thu,
 15 May 2025 09:20:33 -0400
X-MC-Unique: KDYnmGJBMSiQFDnBlRBPkQ-1
X-Mimecast-MFC-AGG-ID: KDYnmGJBMSiQFDnBlRBPkQ_1747315232
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1F641800447; Thu, 15 May 2025 13:20:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFF181956094; Thu, 15 May 2025 13:20:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/4] hw/microblaze: Endianness clean-ups and deprecations
Date: Thu, 15 May 2025 15:20:15 +0200
Message-ID: <20250515132019.569365-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks to the great reworks from Philippe, the microblaze targets
can now handle both endiannesses. I'd like to suggest now to use
a "endianness" property to allow to switch the endianness of the
petalogix-s3adsp1800 machine. The endiannes of the other two
microblaze machines should be hard-wired to little-endian now
since the big-endian mode likely never worked. With all those
modifications in place, we can then finally deprecate the little-endian
target binary qemu-system-microblazeel since the qemu-system-microblaze
can handle all use cases. This will help us in the future to reduce
our compilation and testing times.

Thomas Huth (4):
  hw/microblaze: Add endianness property to the petalogix_s3adsp1800
    machine
  tests/functional: Test both microblaze s3adsp1800 endianness variants
  hw/microblaze: Remove the big-endian variants of ml605 and
    xlnx-zynqmp-pmu
  docs: Deprecate the qemu-system-microblazeel binary

 docs/about/deprecated.rst                     | 19 ++++++---
 docs/about/removed-features.rst               |  9 ++++
 hw/microblaze/petalogix_ml605_mmu.c           | 15 ++-----
 hw/microblaze/petalogix_s3adsp1800_mmu.c      | 41 ++++++++++++++++---
 hw/microblaze/xlnx-zynqmp-pmu.c               |  7 +---
 .../functional/test_microblaze_s3adsp1800.py  | 17 +++++---
 .../test_microblazeel_s3adsp1800.py           |  5 ++-
 7 files changed, 79 insertions(+), 34 deletions(-)

-- 
2.49.0


