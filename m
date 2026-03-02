Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A05EE9B359
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0eL-00033Y-3F; Mon, 02 Mar 2026 05:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx0e6-0002y2-4j
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:37:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx0dy-0001pP-OM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772447810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FE8U0nsaFLoWqF5Ob+XYunjpAnsrlC100n1+ax6jNf8=;
 b=IoPiJ8PerzjIwkhMfA9UYYCej1LZCsD0PfyxJ2L25n0zJgW51G8neVuVUd5i5nOB1qT+xD
 PPeWonV+ABIpST4o1lbFecUBhfWEwygNdkoEZA+rmectNzNl89dht0FyAsYWHtC6rcSzQO
 cuDwvuqyUQjChnIKmBBfSAlPANvx9fI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-SyPNF7N4MZWlTSPD7fxZhA-1; Mon,
 02 Mar 2026 05:36:48 -0500
X-MC-Unique: SyPNF7N4MZWlTSPD7fxZhA-1
X-Mimecast-MFC-AGG-ID: SyPNF7N4MZWlTSPD7fxZhA_1772447807
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6276D18001E2; Mon,  2 Mar 2026 10:36:47 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 888331800666; Mon,  2 Mar 2026 10:36:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v7 0/7] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
Date: Mon,  2 Mar 2026 11:35:22 +0100
Message-ID: <20260302103640.1362564-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series applies on top of
[PATCH 0/5] Improve traces on migration failure due to cpreg number mismatch
https://lore.kernel.org/all/20260226100232.500781-1-eric.auger@redhat.com/

It introduces an infrastructure to explicitly tolerate some
mismatches between cpu cpreg indexes/values on migration.

We especially handle failures due to an attempt to migrate
more registers than exposed on the destination.

Once the infrastructure is in place we can handle the following
known issues:
KVM:
- removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
  from v6.13 onwards. Causes forward migration failure.
- unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
  register from v6.16 onwards. Causes backward migration failure.
TCG:
- We can eventually remove AArch32 DBGDTRTX register which was
  erroneously defined.

Both series are available at:
https://github.com/eauger/qemu/tree/cpreg_vmstate_array_len_traces_mitig

History:
v6 -> v7
- complete rework after Peter's comments in
  (https://lore.kernel.org/all/20260126165445.3033335-1-eric.auger@redhat.com/)
  Especially it does not use properties at all. Do not feature hidden regs
  Also the initial series was split into 2.

Eric Auger (7):
  target/arm/machine: Fix detection of unknown incoming cpregs
  target/arm/cpu: Introduce the infrastructure for cpreg migration
    tolerances
  target/arm/machine: Take account cpreg mig tolerances in case of
    mismatch
  target/arm/cpu64: Mitigate migration failures due to spurious TCR_EL1,
    PIRE0_EL1 and PIR_EL1
  target/arm/cpu64: Define cpreg migration tolerance for
    KVM_REG_ARM_VENDOR_HYP_BMAP_2
  target/arm/helper: Define cpreg migration tolerance for DGBDTR_EL0
  Revert "target/arm: Reinstate bogus AArch32 DBGDTRTX register for
    migration compat"

 target/arm/cpu.h          | 32 +++++++++++++++++
 target/arm/cpu.c          | 75 +++++++++++++++++++++++++++++++++++++++
 target/arm/cpu64.c        | 34 ++++++++++++++++++
 target/arm/debug_helper.c | 29 ---------------
 target/arm/helper.c       |  5 +++
 target/arm/machine.c      | 70 +++++++++++++++++++++++++++++-------
 target/arm/trace-events   |  2 ++
 7 files changed, 206 insertions(+), 41 deletions(-)

-- 
2.53.0


