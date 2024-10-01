Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C679CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveAX-0003Z9-Kg; Tue, 01 Oct 2024 10:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab@kernel.org>)
 id 1sveAS-0003PG-1c
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:48:00 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab@kernel.org>)
 id 1sveAQ-0004bP-19
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:47:59 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 21102A4313E
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2024 07:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193F9C4CEC7
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2024 07:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727766251;
 bh=YxTGQndDRXUrIv1rcoZzDFrSZkpN1CHT/gS1t6B9Ipo=;
 h=From:To:Cc:Subject:Date:From;
 b=U48KyXApci3UtxQWQZGJOivaoaBm54OMwNhLIDUKNMLk/lKydMXiobmwy5JQap02V
 ycIF3JFoJWdIMs/UAvzUC3/ph6sbhe+8p9rONZY8gMkG5DaG6tCMFpQh+YRcE7TrE3
 o2L/4EL8amY1ChcXXLqz796i7CFCMGM34YgBOWVx5K+r0l42fRA+2OayziUVTvJAur
 WG4RpsH+W6KDcvbDE3UWuyXneac9Sa2ZoAHqJDlHanFq5uo1JxlRYY4tF6WRsj5t90
 DsbjQketoBNk9Ar24iXB5vVQSgrEKe9hgWNIWvnXkFPCTKafUu6+l69lJCe1TiOWuN
 0QE6YNbFDuxzA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab@kernel.org>) id 1svWvY-00000001V0L-18y3;
 Tue, 01 Oct 2024 09:04:08 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 00/15] Prepare GHES driver to support error injection
Date: Tue,  1 Oct 2024 09:03:37 +0200
Message-ID: <cover.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=mchehab@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

During the development of a patch series meant to allow GHESv2 error injections,
it was requested a change on how CPER offsets are calculated, by adding a new
BIOS pointer and reworking the GHES logic. See:

https://lore.kernel.org/qemu-devel/cover.1726293808.git.mchehab+huawei@kernel.org/

Such change ended being a big patch, so several intermediate steps are needed,
together with several cleanups and renames.

As agreed duing v10 review, I'll be splitting the big patch series into separate pull 
requests, starting with the cleanup series. This is the first patch set, containing
only such preparation patches.

The next series will contain the shift to use offsets from the location of the
HEST table, together with a migration logic to make it compatible with 9.1.

---

v2: 
- some indentation fixes;
- some description improvements;
- fixed a badly-solved merge conflict that ended renaming a parameter.

Mauro Carvalho Chehab (15):
  acpi/ghes: get rid of ACPI_HEST_SRC_ID_RESERVED
  acpi/ghes: simplify acpi_ghes_record_errors() code
  acpi/ghes: simplify the per-arch caller to build HEST table
  acpi/ghes: better handle source_id and notification
  acpi/ghes: Fix acpi_ghes_record_errors() argument
  acpi/ghes: Remove a duplicated out of bounds check
  acpi/ghes: Change the type for source_id
  acpi/ghes: Prepare to support multiple sources on ghes
  acpi/ghes: make the GHES record generation more generic
  acpi/ghes: move offset calculus to a separate function
  acpi/ghes: better name GHES memory error function
  acpi/ghes: don't crash QEMU if ghes GED is not found
  acpi/ghes: rename etc/hardware_error file macros
  acpi/ghes: better name the offset of the hardware error firmware
  docs: acpi_hest_ghes: fix documentation for CPER size

 docs/specs/acpi_hest_ghes.rst  |   6 +-
 hw/acpi/generic_event_device.c |   4 +-
 hw/acpi/ghes-stub.c            |   2 +-
 hw/acpi/ghes.c                 | 279 ++++++++++++++++++++-------------
 hw/arm/virt-acpi-build.c       |  10 +-
 include/hw/acpi/ghes.h         |  34 ++--
 target/arm/kvm.c               |   3 +-
 7 files changed, 206 insertions(+), 132 deletions(-)

-- 
2.46.0



