Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D175FCCFA05
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 11:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGbxs-0005ap-B2; Wed, 05 Nov 2025 06:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbxo-0005V1-7T
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbxm-0001lD-EO
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762343165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h6qiOvnT4caE2aUUMlaO+sPYkn6fZYHMWXxvHV29T5E=;
 b=Ge/y6ewkX0ew0aOF7rUcwW2QZUHSsROUblbJi7x/EmXjq8EW0T5MY8uvZxmECW6T0GeBAy
 Z7rTkeJ1C3FchkW44hsk9Nf1pCpf/M5tapOUKhgZG0kXY4tFcw5sBj9hu4KRsvB+F468wm
 QU/aPffRZ4TNNI6iyg97GDCdeo5ArcU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-pQun26u3NWy_TKv3BZoZmg-1; Wed,
 05 Nov 2025 06:46:01 -0500
X-MC-Unique: pQun26u3NWy_TKv3BZoZmg-1
X-Mimecast-MFC-AGG-ID: pQun26u3NWy_TKv3BZoZmg_1762343160
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77076195605F; Wed,  5 Nov 2025 11:46:00 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F24861800451; Wed,  5 Nov 2025 11:45:54 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 0/8] target/arm/kvm: Improve memory error handling
Date: Wed,  5 Nov 2025 21:44:45 +1000
Message-ID: <20251105114453.2164073-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In the combination of 64KiB host and 4KiB guest, a problematic host
page affects 16x guest pages. Those 16x guest pages are most likely
owned by separate threads and accessed by the threads in parallel.
It means 16x memory errors can be raised at once. However, we're
unable to handle this situation because the only error source has
one read acknowledgement register in current design. QEMU has to
crash in the following path due to the previously delivered error
isn't acknowledged by the guest on attempt to deliver another error.

  kvm_vcpu_thread_fn
    kvm_cpu_exec
      kvm_arch_on_sigbus_vcpu
        kvm_cpu_synchronize_state
        acpi_ghes_memory_errors
        abort

This series fixes the issue by sending 16x consective CPER errors
which are contained in a single GHES error block.

PATCH[1-3] Increases GHES raw data maximal length from 1KiB to 4KiB
PATCH[4]   Supports multiple error records in a single error block
PATCH[5-6] Improves the error handling in the error delivery path
PATCH[7]   Introduces helper push_ghes_memory_errors()
PATCH[8]   Delivers 16x consective CPERs in a single error block

Changelog
=========
v3:
  * v2: https://lists.nongnu.org/archive/html/qemu-arm/2025-10/msg00372.html
  * Code and changelog improvements                            (Jonathan)
  * Fixed GHES error block status field and improved error
    handling in the error delivery path                        (Igor)
  * Fixed ACPI HEST table and document                         (Mauro)
v2:
  * v1: https://lists.nongnu.org/archive/html/qemu-arm/2025-02/msg00897.html
  * Send 16x memory errors for the specific case               (Jonathan)

Gavin Shan (8):
  tests/qtest/bios-tables-test: Prepare for changes in the HEST table
  acpi/ghes: Increase GHES raw data maximal length to 4KiB
  tests/qtest/bios-tables-test: Update HEST table
  acpi/ghes: Extend acpi_ghes_memory_errors() to support multiple CPERs
  acpi/ghes: Bail early on error from get_ghes_source_offsets()
  acpi/ghes: Use error_abort in acpi_ghes_memory_errors()
  kvm/arm/kvm: Introduce helper push_ghes_memory_errors()
  target/arm/kvm: Support multiple memory CPERs injection

 docs/specs/acpi_hest_ghes.rst     |   2 +-
 hw/acpi/ghes-stub.c               |   6 +--
 hw/acpi/ghes.c                    |  78 +++++++++++++++---------------
 include/hw/acpi/ghes.h            |   5 +-
 target/arm/kvm.c                  |  69 +++++++++++++++++++++++---
 tests/data/acpi/aarch64/virt/HEST | Bin 224 -> 224 bytes
 6 files changed, 108 insertions(+), 52 deletions(-)

-- 
2.51.0


