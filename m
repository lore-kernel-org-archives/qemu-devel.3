Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8448E67A62
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQui-0001Xs-Iz; Tue, 03 Mar 2026 09:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxQua-0001TU-2V
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxQuR-00027k-DG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772548778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NXvKXyiLpbr3xemypEID2qhyZ1ztwiBOv/pMu/3qq8M=;
 b=YH83PaeRzpBc2SkVls0TGG7o453b3SvZbiLRT58TSNSA17kL8BPQVav3LVXgf3lWn4ht+6
 IZqI2lxxIoGrNJHsTfwidi1SFVgT7JUC5VRCJnnp3qupr72VKiEL2miiIIx++JeDVF3aic
 qkXeBxTiRQiV4+l1mhRA+HWLqhpW/Jc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-aGwU7SqxNeqKoLVSqj3B3Q-1; Tue,
 03 Mar 2026 09:39:35 -0500
X-MC-Unique: aGwU7SqxNeqKoLVSqj3B3Q-1
X-Mimecast-MFC-AGG-ID: aGwU7SqxNeqKoLVSqj3B3Q_1772548774
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 241B3180057E; Tue,  3 Mar 2026 14:39:34 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3682730001B9; Tue,  3 Mar 2026 14:39:29 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v2 0/7] Improve traces on migration failure due to cpreg
 number mismatch
Date: Tue,  3 Mar 2026 15:36:32 +0100
Message-ID: <20260303143928.1747116-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series comes as a follow-up of discussions held in
[PATCH v6 00/11] Mitigation of "failed to load
cpu:cpreg_vmstate_array_len" migration failures
(https://lore.kernel.org/all/20260126165445.3033335-1-eric.auger@redhat.com/)

It only covers the improvement of the traces. Actual mitigations
are handled in a follow-up series:
[PATCH v7 0/7] Mitigation of "failed to load cpu:cpreg_vmstate_array_len"
migration failures
(https://lore.kernel.org/all/20260302103640.1362564-1-eric.auger@redhat.com/)

When the number of CPU registers received in an incoming migration
stream is bigger than the number of CPU registers seen by the
destination we currently get the following error:

"failed to load cpu:cpreg_vmstate_array_len"

This series removes this cryptic message and explicitly outputs
which spurious registers cause the failures.

---

Available at:
https://github.com/eauger/qemu/tree/cpreg_vmstate_array_len_traces_v2_mitig_v2

v1 -> v2:
- Tool all comments from Peter on v1. See individual history logs
- Also added last patch which was previously included in the follow-up
  mitigation series ([PATCH v7 0/7] Mitigation of "failed to load
  cpu:cpreg_vmstate_array_len" migration failures) but actually belongs
  to those functional changes.


Eric Auger (7):
  vmstate: Introduce VMSTATE_VARRAY_INT32_ALLOC
  target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC for cpreg arrays
  target/arm/kvm: Export kvm_print_register_name()
  target/arm/kvm: Tweak print_register_name() for arm64 system register
  target/arm/machine: Trace cpreg names which do not match on migration
  target/arm/machine: Trace all register mismatches
  target/arm/machine: Fix detection of unknown incoming cpregs

 include/migration/vmstate.h |  10 ++++
 target/arm/kvm_arm.h        |   8 +++
 target/arm/helper.c         |   5 --
 target/arm/kvm-stub.c       |   5 ++
 target/arm/kvm.c            |   9 +--
 target/arm/machine.c        | 112 ++++++++++++++++++++++++++++++------
 target/arm/whpx/whpx-all.c  |   7 ---
 target/arm/trace-events     |   3 +
 8 files changed, 123 insertions(+), 36 deletions(-)

-- 
2.53.0


