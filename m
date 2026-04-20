Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85097F588DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEpGs-00031F-SR; Mon, 20 Apr 2026 10:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wEpGT-0002z3-0N
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wEpGL-0001Mf-Gt
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776693965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dsucsObgYvq2jiwaIy0SjqfSzFmZVsn4y3c+ddn6E6U=;
 b=ApVS35f/ASbbr2Ya4hYjeD0LKIBjp70hXA3Q0SLPbTuUA52ND1fUhC92QCzK4Xs1sCyEFz
 sEc605X8KoLBMtnfJ4w5LPl1Q72u54DPNocdcjeJGvdOXv4UNu4K+TP7sJ9xwvpc2N+UKx
 /Ym9vxoHU6J1WLt1ojIH3Ig2V9oWHFo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-5Ob1Fkd2NcGv1Gj4UHDU9g-1; Mon,
 20 Apr 2026 10:06:02 -0400
X-MC-Unique: 5Ob1Fkd2NcGv1Gj4UHDU9g-1
X-Mimecast-MFC-AGG-ID: 5Ob1Fkd2NcGv1Gj4UHDU9g_1776693961
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 722961800659; Mon, 20 Apr 2026 14:06:00 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F3D3180047F; Mon, 20 Apr 2026 14:05:56 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v10 0/7] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
Date: Mon, 20 Apr 2026 16:03:50 +0200
Message-ID: <20260420140552.104369-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series introduces an infrastructure to explicitly tolerate
some mismatches between cpu cpreg indexes/values on migration.

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

The series can be found at:
https://github.com/eauger/qemu/tree/x-kernel-mig-v10

History:
v9 -> v10:
- main functional change consists in the introduction of a new
  ToleranceOnlySrcTestValue migration tolerance type to handle
  KVM_REG_ARM_VENDOR_HYP_BMAP_2
- See individual patch diff logs for more details

v8 -> v9:
- took into account Seb's comments (fixed ->type check, rename one function)
- collected R-bs

v7 -> v8:
- rebase on top of v3 dep
- removal of target/arm/machine: Fix detection of unknown incoming cpregs
  which is integrated in prerequisite series

v6 -> v7
- complete rework after Peter's comments in
  (https://lore.kernel.org/all/20260126165445.3033335-1-eric.auger@redhat.com/)
  Especially it does not use properties at all. Do not feature hidden regs
  Also the initial series was split into 2.


Eric Auger (7):
  target/arm/cpu: Introduce the infrastructure for cpreg migration
    tolerances
  target/arm/machine: Handle ToleranceNotOnBothEnds migration tolerances
  target/arm/machine: Handle ToleranceOnlySrcTestValue migration
    tolerance
  target/arm/cpu64: Mitigate migration failures due to spurious TCR_EL1,
    PIRE0_EL1 and PIR_EL1
  target/arm/cpu64: Define cpreg migration tolerance for
    KVM_REG_ARM_VENDOR_HYP_BMAP_2
  target/arm/helper: Define cpreg migration tolerance for DGBDTR_EL0
  Revert "target/arm: Reinstate bogus AArch32 DBGDTRTX register for
    migration compat"

 target/arm/cpu.h          |  1 +
 target/arm/internals.h    | 54 ++++++++++++++++++++++++++
 target/arm/cpu.c          | 82 +++++++++++++++++++++++++++++++++++++++
 target/arm/cpu64.c        | 39 +++++++++++++++++++
 target/arm/debug_helper.c | 29 --------------
 target/arm/helper.c       | 15 +++++++
 target/arm/machine.c      | 33 +++++++++++-----
 target/arm/trace-events   |  2 +
 8 files changed, 217 insertions(+), 38 deletions(-)

-- 
2.53.0


