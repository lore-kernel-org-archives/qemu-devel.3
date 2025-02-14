Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28570C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 04:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tin8W-0005Ti-OR; Thu, 13 Feb 2025 23:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tin8U-0005TD-V9
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 23:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tin8T-0002Zi-8k
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 23:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739506622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y6woE6YZq7PxsN07Vv6kJjlWyQ8cfuZEwVw6wv2u9y8=;
 b=BdrsoehABM/RNdnEocbonSG19vqg6Af0DbRUP6EaRTSxIQDWtBTLY44ufrIh5YqQtugSy6
 2o3RSQ2TpSBtHDfDnPdg+7TVuKYnd8wnzZZu7hBSAj2WYv9sDgde+H2SN9wr6P+SYSG+Ke
 GS/mY3I55j+dfmJ5lJ6yEi0aVDgIJdU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-afE9I8VNMNWDmJZGxkU22g-1; Thu,
 13 Feb 2025 23:16:58 -0500
X-MC-Unique: afE9I8VNMNWDmJZGxkU22g-1
X-Mimecast-MFC-AGG-ID: afE9I8VNMNWDmJZGxkU22g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BFCA19373D9; Fri, 14 Feb 2025 04:16:57 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.82])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DE4319373C4; Fri, 14 Feb 2025 04:16:51 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH 0/4] target/arm: Improvement on memory error handling
Date: Fri, 14 Feb 2025 14:16:31 +1000
Message-ID: <20250214041635.608012-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Currently, there is only one CPER buffer (entry), meaning only one
memory error can be reported. In extreme case, multiple memory errors
can be raised on different vCPUs. For example, a singile memory error
on a 64KB page of the host can results in 16 memory errors to 4KB
pages of the guest. Unfortunately, the virtual machine is simply aborted
by multiple concurrent memory errors, as the following call trace shows.
A SEA exception is injected to the guest so that the CPER buffer can
be claimed if the error is successfully pushed by acpi_ghes_memory_errors(),
Otherwise, abort() is triggered to crash the virtual machine.

  kvm_vcpu_thread_fn
    kvm_cpu_exec
      kvm_arch_on_sigbus_vcpu
        kvm_cpu_synchronize_state
        acpi_ghes_memory_errors         (a)
        kvm_inject_arm_sea | abort

It's arguably to crash the virtual machine in this case. The better
behaviour would be to retry on pushing the memory errors, to keep the
virtual machine alive so that the administrator has chance to chime
in, for example to dump the important data with luck. This series
adds one more parameter to acpi_ghes_memory_errors() so that it will
be tried to push the memory error until it succeeds.

Gavin Shan (4):
  acpi/ghes: Make ghes_record_cper_errors() static
  acpi/ghes: Use error_report() in ghes_record_cper_errors()
  acpi/ghes: Allow retry to write CPER errors
  target/arm: Retry pushing CPER error if necessary

 hw/acpi/ghes-stub.c    |  3 ++-
 hw/acpi/ghes.c         | 45 +++++++++++++++++++++---------------------
 include/hw/acpi/ghes.h |  5 ++---
 target/arm/kvm.c       | 31 +++++++++++++++++++++++------
 4 files changed, 51 insertions(+), 33 deletions(-)

-- 
2.48.1


