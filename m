Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDE1D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 14:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ4jn-0008Ae-F3; Mon, 01 Dec 2025 09:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vQ4jh-0008A7-UK
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:18:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vQ4jf-0008HE-Jc
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764598718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fjVuwMuQk+TIdqAM6V25ft//hI88Uk8wLROpsXh0Djk=;
 b=B56iRSA7P376/U3JFT9i1FnW2ZrFCkMUNLO2mil9UzQ4daSEkK5I6zZr67Zvn2TJZ5wnSy
 7vHvVUFuuSnFtdW4niOnrI/V1UOTTrRUezw+FHKirbr6q/14EZvYz0GdLXuYJXD85xyBDr
 UeiDg6DE+N5HvP0nSnaP+3NIR+ZbGoA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-njJqcIqjOeuoWUrzOkjElg-1; Mon,
 01 Dec 2025 09:18:34 -0500
X-MC-Unique: njJqcIqjOeuoWUrzOkjElg-1
X-Mimecast-MFC-AGG-ID: njJqcIqjOeuoWUrzOkjElg_1764598713
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5283B18011EF; Mon,  1 Dec 2025 14:18:33 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.76])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 367611956095; Mon,  1 Dec 2025 14:18:26 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, imammedo@redhat.com, armbru@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2 0/5] acpi/ghes: Error object handling improvement 
Date: Tue,  2 Dec 2025 00:17:58 +1000
Message-ID: <20251201141803.2386129-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series is pulled from the series for memory error hanlding
improvement [1] to improve the error object handling in various
aspects.

[1] https://lists.nongnu.org/archive/html/qemu-arm/2025-11/msg00534.html

This series doesn't have any dependencies and can be merged by
it own.

Changelog
=========
v2:
  * v1: https://lists.nongnu.org/archive/html/qemu-arm/2025-11/msg00969.html
  * Commit log improvement on PATCH[v1 4/5]            (Igor)
  * Collected RBs                                      (Gavin)

Gavin Shan (5):
  acpi/ghes: Automate data block cleanup in acpi_ghes_memory_errors()
  acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
  target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
  acpi/ghes: Bail early on error from get_ghes_source_offsets()
  acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()

 hw/acpi/ghes-stub.c    |  6 +++---
 hw/acpi/ghes.c         | 45 ++++++++++++++++++------------------------
 include/hw/acpi/ghes.h |  6 +++---
 target/arm/kvm.c       | 10 +++-------
 4 files changed, 28 insertions(+), 39 deletions(-)

-- 
2.51.1


