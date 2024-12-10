Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C66E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3HE-0003di-CO; Tue, 10 Dec 2024 11:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tL3HD-0003dL-Dh
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tL3HA-00028h-OG
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733848795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/hOg1lz5x0NChpp/h+7K4thveOeFs3O8kIO9rrZ56fQ=;
 b=J7vfZ2HI8ZZCvoAfOSQL81Z5voZXeO1P8nHtQzbsNV2FVL7PX6yfQDldiyy1ca7VEVpcT4
 uUcmHuK3C6RpQJzJEmPxDjqik4PX9uVgM6aChDPV/KrhKeJOkQ43q4kzrbwdKAnNry68m4
 8iJZFfj6qJC3Z59QrDXUj5QDlAq/Ces=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-UVXHjrz9PHq1Uzjfx2HuSg-1; Tue,
 10 Dec 2024 11:39:51 -0500
X-MC-Unique: UVXHjrz9PHq1Uzjfx2HuSg-1
X-Mimecast-MFC-AGG-ID: UVXHjrz9PHq1Uzjfx2HuSg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 953111956088; Tue, 10 Dec 2024 16:39:50 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 819B030001A8; Tue, 10 Dec 2024 16:39:48 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, eric.mackay@oracle.com,
 anisinha@redhat.com
Subject: [PATCH 0/3] cpuhp: ensure that cpu hotremove works the 1st time
Date: Tue, 10 Dec 2024 17:39:42 +0100
Message-ID: <20241210163945.3422623-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


CPU hotremove event is not delivered to OSPM if the CPU
has been hotplugged before OS has booted.
For details see [2/3].

Igor Mammedov (3):
  tests: acpi: whitelist expected blobs
  cpuhp: make sure that remove events are handled within the same SCI
  tests: acpi: update expected blobs

 hw/acpi/cpu.c                                 |  43 ++++++++++++++----
 tests/data/acpi/x86/pc/DSDT                   | Bin 8526 -> 8593 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8437 -> 8504 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9851 -> 9918 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15397 -> 15464 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 8990 -> 9057 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10180 -> 10247 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8477 -> 8544 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5033 -> 5100 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8598 -> 8665 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9885 -> 9952 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8384 -> 8451 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8532 -> 8599 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12319 -> 12386 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8422 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8439 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9747 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12565 -> 12632 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8701 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8468 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 12035 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 12980 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33837 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 8886 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13146 -> 13213 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10076 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8497 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8510 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8439 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9781 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9552 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13275 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8235 -> 8302 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8280 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8428 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8523 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 12980 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33837 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 9028 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 9054 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18656 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14612 -> 14679 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35785 bytes
 43 files changed, 34 insertions(+), 9 deletions(-)

-- 
2.43.0


