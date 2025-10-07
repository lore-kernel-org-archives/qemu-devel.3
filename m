Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0381CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 06:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v60tk-0003vM-FH; Tue, 07 Oct 2025 02:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1v60ti-0003rd-3z
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 02:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1v60te-00066m-Us
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 02:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759817402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AYBvNvFwZGV9H72LkqO/ANt0izDuPdTmYmD4oi4k9w8=;
 b=UJXpJ24R/a8BW7hs+unVb/GfRjvTbCoQLKxJL55O9DdHavMId09YMIB996Ci1tEYvvQ1Ay
 T4uGHOoXNxrMD1tU5q1Oizyg6QglGN3XM7qJufON4R0IxDHK1dQ/xTABKfk6diOWsdfrTX
 +j7QLHYuhG8zeAv1Vp39ZwBOl1uWmlA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-lykF3-UOPwS7Llzhe07NVA-1; Tue,
 07 Oct 2025 02:08:26 -0400
X-MC-Unique: lykF3-UOPwS7Llzhe07NVA-1
X-Mimecast-MFC-AGG-ID: lykF3-UOPwS7Llzhe07NVA_1759817305
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D02281800366; Tue,  7 Oct 2025 06:08:24 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F0DC1800576; Tue,  7 Oct 2025 06:08:18 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, mchehab+huawei@kernel.org,
 Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH RESEND v2 0/3] target/arm/kvm: Improve memory error handling
Date: Tue,  7 Oct 2025 16:08:07 +1000
Message-ID: <20251007060810.258536-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
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

Currently, there is only one CPER buffer (entry) can be delivered and
acknoledged at once. This conflicts to the scenario where the host and
guest has 64KB and 4KB page size. In this specific scenario, a problematic
host page can affect 16x guest pages, resulting in 16x memory errors
in the worst case. Unfortunately, qemu runs to core dump at (a) because
the previous error isn't acknoledged and current error is no way to be
delivered, shown in the following call trace

  kvm_vcpu_thread_fn
    kvm_cpu_exec
      kvm_arch_on_sigbus_vcpu
        kvm_cpu_synchronize_state
        acpi_ghes_memory_errors         (a)
        kvm_inject_arm_sea | abort

Fix the issue by sending 16x consecutive memory CPER entries for this
specific case in one shot. With the series applied, no qemu core dump is
observed in the test where (4KB) guest memory access is triggered by
'victimd' and the recoverable memory error is injected from the (64KB) host.

Changelog
=========
v2:
  * v1: https://lists.nongnu.org/archive/html/qemu-arm/2025-02/msg00897.html
  * Send 16x memory errors for the specific case                 (Jonathan)

Gavin Shan (3):
  acpi/ghes: Extend acpi_ghes_memory_errors() to support multiple CPERs
  kvm/arm/kvm: Introduce helper push_ghes_memory_errors()
  target/arm/kvm: Support multiple memory CPERs injection

 hw/acpi/ghes-stub.c    |  2 +-
 hw/acpi/ghes.c         | 29 ++++++++--------
 include/hw/acpi/ghes.h |  2 +-
 target/arm/kvm.c       | 77 +++++++++++++++++++++++++++++++++++++-----
 4 files changed, 86 insertions(+), 24 deletions(-)

-- 
2.51.0


