Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36166EB7EB6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjHV-0002PX-II; Wed, 04 Mar 2026 05:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxjHU-0002ON-1e
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:16:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxjHQ-0008SL-3Z
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772619394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rjA5evsciFS5mBzzKONT36IDw6gjPH6X2r0jPJjD000=;
 b=iixOWcji0eXuO9xPbyHUMr+iU3yHYkBBoI5UOTGAe9scPnq96dZdksxgQEN+k/U40KZqft
 y8KIOFb1LSK/WvV4MS3xKPpoLTE1E6U8Sl5Yt69XVVhl5PdpV2T4tdFvWJWJu6etxdUiE3
 OBUbY9Ag+uY4ifm+OCXqNwSxXfKorUQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5--Xlsfkd4O9uC0yVE2iWGCw-1; Wed,
 04 Mar 2026 05:16:33 -0500
X-MC-Unique: -Xlsfkd4O9uC0yVE2iWGCw-1
X-Mimecast-MFC-AGG-ID: -Xlsfkd4O9uC0yVE2iWGCw_1772619392
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1344F19560B0; Wed,  4 Mar 2026 10:16:32 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.89])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 27AAD180035F; Wed,  4 Mar 2026 10:16:27 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v3 0/7] Improve traces on migration failure due to cpreg
 number mismatch
Date: Wed,  4 Mar 2026 11:15:39 +0100
Message-ID: <20260304101625.1962633-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Mitigation of "failed to load cpu:cpreg_vmstate_array_len" (v8)

When the number of CPU registers received in an incoming migration
stream is bigger than the number of CPU registers seen by the
destination we currently get the following error:

"failed to load cpu:cpreg_vmstate_array_len"

This series removes this cryptic message and explicitly outputs
which spurious registers cause the failures.

---

Available at:
https://github.com/eauger/qemu/tree/cpreg_vmstate_array_len_traces_v3_mitig_v2

v2 -> v3:
- clear the vmstate array pointers on post_save()
- improve the print_register_name comment
- Collecting remaining R-b's

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
 target/arm/kvm_arm.h        |   9 +++
 target/arm/helper.c         |   5 --
 target/arm/kvm-stub.c       |   5 ++
 target/arm/kvm.c            |   9 +--
 target/arm/machine.c        | 115 ++++++++++++++++++++++++++++++------
 target/arm/whpx/whpx-all.c  |   7 ---
 target/arm/trace-events     |   3 +
 8 files changed, 127 insertions(+), 36 deletions(-)

-- 
2.53.0


