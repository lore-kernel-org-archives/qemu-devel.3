Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9FAFC591C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYCn-0003V7-TY; Thu, 26 Feb 2026 05:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vvYCl-0003T7-Eg
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vvYCj-0000XB-IP
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772100164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=46BqGBYYM9dSuygcCaSPOsAMZPKuzW2y+ObN7UbmmlE=;
 b=edjrFcenlS41j+IIVcab99cX96Qms9Qw/4qAL0PuQht8aTb+9Y3NfhUhEtWqYJYsObpEcH
 qOfLq+CU3dLj/PFHuGcOfOUo1v+nYUj0rJv10NJqY/jgunkehbD4tMTK2mm8cqKh2DB9MA
 Rb1enCrI6/6nGyg7l/tW36s4V8foUtc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-6lJ5UwAlPGKA2L9hz6Ss3Q-1; Thu,
 26 Feb 2026 05:02:40 -0500
X-MC-Unique: 6lJ5UwAlPGKA2L9hz6Ss3Q-1
X-Mimecast-MFC-AGG-ID: 6lJ5UwAlPGKA2L9hz6Ss3Q_1772100159
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8125C180025A; Thu, 26 Feb 2026 10:02:39 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.35.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32CF91800348; Thu, 26 Feb 2026 10:02:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH 0/5] Improve traces on migration failure due to cpreg number
 mismatch
Date: Thu, 26 Feb 2026 11:01:28 +0100
Message-ID: <20260226100232.500781-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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
will be handled in a separate series.

When the number of CPU registers received in an incoming migration
stream is bigger than the number of CPU registers seen by the
destination we currently get the following error:

"failed to load cpu:cpreg_vmstate_array_len"

This series removes this cryptic message and explicitly outputs
which spurious registers cause the failures.

Available at:
https://github.com/eauger/qemu/tree/cpreg_vmstate_array_len_traces

Eric Auger (5):
  vmstate: Introduce VMSTATE_VARRAY_INT32_ALLOC
  target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC for cpreg arrays
  target/arm/kvm: Export kvm_print_register_name()
  target/arm/machine: Trace cpreg names which do not match on migration
  target/arm/machine: Trace all register mismatches

 include/migration/vmstate.h | 10 +++++++
 target/arm/kvm_arm.h        |  2 ++
 target/arm/helper.c         |  5 ----
 target/arm/kvm-stub.c       |  6 ++++
 target/arm/kvm.c            |  7 +----
 target/arm/machine.c        | 57 +++++++++++++++++++++++++++----------
 target/arm/trace-events     |  3 ++
 7 files changed, 64 insertions(+), 26 deletions(-)

-- 
2.53.0


