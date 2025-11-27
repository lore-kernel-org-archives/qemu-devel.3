Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C77CD116E4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 00:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOQ8J-0000N1-T5; Wed, 26 Nov 2025 19:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vOQ8G-0000HE-5q
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:45:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vOQ8D-0006dl-4o
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764204306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u/fXoJToLdKEKij/eR5ApefqDGv8GlnzKMPFVuGT6kE=;
 b=Emg3y1eaQYQkGXiwtzhbU9PpgHA276qylDUnQjs4zh6fZzP1LxndZzmAgcE4s807yD9GIK
 /oMKEbjOuoJnd8/+YvE5ebvV5SK6cSA7xOcNzy3ebwj0XbFlPrMdHuDaxN/I5uS35FeWFP
 UZDun+mDRCH26dJ6HX37Ea3Su2ousGg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-3wZVIi_HMdGscNG-mgXpIg-1; Wed,
 26 Nov 2025 19:45:02 -0500
X-MC-Unique: 3wZVIi_HMdGscNG-mgXpIg-1
X-Mimecast-MFC-AGG-ID: 3wZVIi_HMdGscNG-mgXpIg_1764204301
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C2A31954B14; Thu, 27 Nov 2025 00:45:00 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.67])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 754211800451; Thu, 27 Nov 2025 00:44:53 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, gengdongjiu1@gmail.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH 0/5] acpi/ghes: Error object handling improvement
Date: Thu, 27 Nov 2025 10:44:30 +1000
Message-ID: <20251127004435.2098335-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series is curved from that for memory error handling improvement
[1] based on the received comments, to improve the error object handling
in various aspects.

[1] https://lists.nongnu.org/archive/html/qemu-arm/2025-11/msg00534.html

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


