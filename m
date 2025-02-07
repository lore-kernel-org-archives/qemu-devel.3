Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C665C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 11:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgM8o-0002W4-IN; Fri, 07 Feb 2025 06:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tgM8m-0002Ve-L8
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:03:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tgM8k-0006Om-GG
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738926196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tbM9CuVu36PPibrDw89XRxqtWkXgC2pjRfq8eqbXE0c=;
 b=iTKCltT0xdzqGZ+4yTBFVAPQZQBd1BMQpkIKn1WUpqsDIgobVeTrRhvKYOH61+fy+IyyEq
 XD2Nrfh4g/DP66IK/X+0Ye1HFRZ6omOvKkT5DSOrAvCo4pFqFmbvf50qGTvJh0zGGffXfH
 hfVy8KZf/nzam8vfoFKjQF+2b+vbwjY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-sgBEqSZGMV6s4az5mD8VXQ-1; Fri,
 07 Feb 2025 06:03:14 -0500
X-MC-Unique: sgBEqSZGMV6s4az5mD8VXQ-1
X-Mimecast-MFC-AGG-ID: sgBEqSZGMV6s4az5mD8VXQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9B3A1800875; Fri,  7 Feb 2025 11:03:11 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.67.24.130])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32BBD19560A3; Fri,  7 Feb 2025 11:02:55 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 00/15] arm: rework id register storage
Date: Fri,  7 Feb 2025 12:02:33 +0100
Message-ID: <20250207110248.1580465-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

[Note: I've kept the cc list from the last round of cpu model patches;
so if you're confused as to why you're cc:ed here, take it as a
heads-up that a new cpu model series will come along soon]

This patch series contains patches extracted from the larger cpu model
series (RFC v2 last posted at
https://lore.kernel.org/qemu-devel/20241206112213.88394-1-cohuck@redhat.com/)
and aims at providing a base upon which we can continue with building
support for cpu models, but which is hopefully already an improvement
on its own.

Main changes from the patches in that series include:
- post-pone the changes to handle KVM writable ID registers for cpu models
  (I have a series including that on top of this one)
- change how we store the list of ID registers, and access them
  basically, use an enum for indexing, and an enum doing encodings in a
  pattern similar to cpregs
- move some hunks to different patches
- update the scripts to generate the register descriptions, and run
  them against a recent Linux sysregs file

What I've kept:
- generating the register descriptions from the Linux sysregs file
  I think that file is still our best bet to generate the descriptions
  easily, and updating the definitions is a manual step that can be checked
  for unintended changes
- most of the hard work that Eric had been doing; all new bugs in there
  are my own :)

Also available at
https://gitlab.com/cohuck/qemu/-/commits/arm-rework-idreg-storage

I plan to send cpu model patches based on top of this Real Soon(tm).

Cornelia Huck (2):
  arm/kvm: add accessors for storing host features into idregs
  arm/cpu: Add generated files

Eric Auger (13):
  arm/cpu: Add sysreg definitions in cpu-sysregs.h
  arm/cpu: Store aa64isar0 into the idregs arrays
  arm/cpu: Store aa64isar1/2 into the idregs array
  arm/cpu: Store aa64pfr0/1 into the idregs array
  arm/cpu: Store aa64mmfr0-3 into the idregs array
  arm/cpu: Store aa64dfr0/1 into the idregs array
  arm/cpu: Store aa64smfr0 into the idregs array
  arm/cpu: Store id_isar0-7 into the idregs array
  arm/cpu: Store id_mfr0/1 into the idregs array
  arm/cpu: Store id_dfr0/1 into the idregs array
  arm/cpu: Store id_mmfr0-5 into the idregs array
  arm/cpu: Add infra to handle generated ID register definitions
  arm/cpu: Add sysreg generation scripts

 hw/intc/armv7m_nvic.c                 |  27 +-
 scripts/gen-cpu-sysreg-properties.awk | 325 ++++++++++++
 scripts/gen-cpu-sysregs-header.awk    |  70 +++
 scripts/update-aarch64-sysreg-code.sh |  30 ++
 target/arm/cpu-custom.h               |  55 ++
 target/arm/cpu-features.h             | 313 +++++------
 target/arm/cpu-sysreg-properties.c    | 713 ++++++++++++++++++++++++++
 target/arm/cpu-sysregs.h              |  22 +
 target/arm/cpu-sysregs.h.inc          | 164 ++++++
 target/arm/cpu.c                      | 111 ++--
 target/arm/cpu.h                      |  73 +--
 target/arm/cpu64.c                    | 133 +++--
 target/arm/helper.c                   |  68 +--
 target/arm/internals.h                |   6 +-
 target/arm/kvm.c                      | 138 ++---
 target/arm/meson.build                |   1 +
 target/arm/ptw.c                      |   6 +-
 target/arm/tcg/cpu-v7m.c              | 174 ++++---
 target/arm/tcg/cpu32.c                | 320 ++++++------
 target/arm/tcg/cpu64.c                | 460 +++++++++--------
 20 files changed, 2308 insertions(+), 901 deletions(-)
 create mode 100755 scripts/gen-cpu-sysreg-properties.awk
 create mode 100755 scripts/gen-cpu-sysregs-header.awk
 create mode 100755 scripts/update-aarch64-sysreg-code.sh
 create mode 100644 target/arm/cpu-custom.h
 create mode 100644 target/arm/cpu-sysreg-properties.c
 create mode 100644 target/arm/cpu-sysregs.h
 create mode 100644 target/arm/cpu-sysregs.h.inc

-- 
2.48.1


