Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00BAC3ABA0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 13:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpSNC-0000ED-Cn; Tue, 04 Mar 2025 08:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tpSMs-00008V-4D; Tue, 04 Mar 2025 08:31:30 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tpSMo-0004Yg-VU; Tue, 04 Mar 2025 08:31:29 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0D088A44D7A;
 Tue,  4 Mar 2025 13:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C32C4CEE9;
 Tue,  4 Mar 2025 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741095076;
 bh=lVWHChPEXjI/bHXulgoGRI0WzVhFif47e2xu9lXivW0=;
 h=From:To:Cc:Subject:Date:From;
 b=aEqNlCMpfTebC7bzdTgNCYn9KZQa5KGWmVdaODpkZ/SYSzRb0hY9k1ZeDEBAztyKh
 P21DKubI9mCc4ypOBguOXhH0wJdO7nPamHUB5c/oPSxUitJzFoZd6yJh+gY+DEFwfI
 Kbly95uAPgpbUmjKkOXFWm+0fzMdUtErzoEyAdy8t70HK/M4uDo5rGNXypw6vnhzOz
 VYgTJ5s2IU0dY6qCUByOaPjveY5+6RJMdltwqIQybVfxrXh5mITtpZtqgqkQdW/AIb
 jQa95jl/qVn22ZLCd5zZCe77B+bDu47FOpr5b3f5caxvk5QJ6IeDD5IZcnFisty7z+
 nqBcS3PhxFqwg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tpSMc-00000005rnM-1lsf; Tue, 04 Mar 2025 14:31:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH RFC 0/3] Attempt to add GHES for x86
Date: Tue,  4 Mar 2025 14:30:55 +0100
Message-ID: <cover.1741094512.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Igor,

This patch series comes after:
   https://lore.kernel.org/qemu-devel/cover.1740903110.git.mchehab+huawei@kernel.org/

I'm basically trying to add support for error injection for x86,
without success so far.

On x86, the notification mechanism is different: it is via QMP.
Yet, from what I saw on Linux implementation, it works on
a similar way to GED. So, I ended implementing a notification
via GED.

HEST table build seems to be working OK on it, and the
error injection notification for x86 is called. Yet, OSPM is not
receiving any notifications.

Could you help me figuring out what are the missing bits?

PS.: there are some things at the code that require polishing,
plus there are some extra printf() there to help debugging.
Finally, we would need to add x86 CPU error event at the
ghes script, but I'd like to have at least something that the 
OSPM receives before improving it further.

It can be tested with:
   $ ./scripts/ghes_inject.py arm

(Ok, this would be generating an ARM processor event , but
I guess Linux would at least mark the event as read, even if
it doesn't recognize it)

Mauro Carvalho Chehab (3):
  acpi/ghes: move use_hest_addr out of acpi_build_hest()
  hw/i186: add support for HEST table with SCI
  Add a GED device for RAS notification

 hw/acpi/ghes.c           | 16 ++++-----
 hw/arm/virt-acpi-build.c | 12 ++++---
 hw/i386/Kconfig          |  1 +
 hw/i386/acpi-build.c     | 75 ++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c             | 41 ++++++++++++++++++++++
 include/hw/acpi/ghes.h   | 25 +++++++-------
 include/hw/i386/pc.h     |  5 +++
 include/hw/i386/x86.h    |  2 ++
 8 files changed, 153 insertions(+), 24 deletions(-)

-- 
2.48.1



