Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09579D39403
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8EiN-0006sN-L7; Thu, 02 Apr 2026 05:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8EiN-0006rl-0k
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8EiJ-0008Pi-Ij
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775123505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dvD7kr6qa0gf3uuGoC8zI/GSEnrtReOjUhhel2z+Gvw=;
 b=QWyzs09MdZJHsoW3wbry9V54DbVC7PgZXboXtQfz+0ZTAgvVn0RQAhInjxuyBwnFsfMQFa
 luPzGa84PlM494VEX+Z+ESsWgdbacwaBbkIS0qBIffukxZMWiEYX2iAG1/MJk2DpCWX3YZ
 coSRFuo3qrf1VMSKtLX61wyELmaN90U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-073jfFt8MbqVZQGPrdJfGA-1; Thu,
 02 Apr 2026 05:51:42 -0400
X-MC-Unique: 073jfFt8MbqVZQGPrdJfGA-1
X-Mimecast-MFC-AGG-ID: 073jfFt8MbqVZQGPrdJfGA_1775123501
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C28FC180047F; Thu,  2 Apr 2026 09:51:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77DCB196B088; Thu,  2 Apr 2026 09:51:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for-11.1 00/10] Deprecate the qemu-system-i386 binary
Date: Thu,  2 Apr 2026 11:51:22 +0200
Message-ID: <20260402095132.29245-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

This is a follow-up to my 3-years old patch series here, now with the
universal binary initiative in mind:

 https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg04541.html

This patch series allows to run qemu-system-x86_64 in 32-bit-only mode
(by renaming or symlinking the binary to "qemu-system-i386" or something
similar with a "-i386" suffix). After doing this, qemu-system-x86_64
should be a full superset of qemu-system-i386 (apart from 32-bit KVM
support, which however is not required anymore now that we removed support
for 32-bit hosts). It is now possible to migrate a guest that has been
started with an old "qemu-system-i386" binary to a qemu-system-x86_64
binary that has been renamed with a "-i386" suffix.

Thus we can finally deprecate the qemu-system-i386 binary. This will
help to avoid that we have to compile a lot of the x86 stuff twice
once we'll finally be able to drop qemu-system-i386 after the deprecation
period expired.

Thomas Huth (10):
  target/i386/tcg/sysemu: Move target specific SMM code to separate
    functions
  target/i386/tcg/sysemu: Allow 32-bit SMM code to be used in the 64-bit
    binary
  target-info: Add functions for querying whether the target is i386 or
    x86_64
  cpu: Add a way to detect 32-bit mode from argv0
  target/i386/cpu: Allow to limit the 64-bit binary to 32-bit mode only
  target/i386: Select a 32-bit/64-bit default CPU during runtime
  target/i386: Adjust the suffix of the CPU devices to 32-bit/64-bit
    mode
  hw/i386/isapc: Adjust the check for valid CPUs in the isapc machine
  target/i386: Support migrating from i386 to x86_64 target
  docs/about/deprecated: Deprecate the qemu-system-i386 binary

 docs/about/deprecated.rst           |  19 +++
 include/qemu/target-info.h          |  28 ++++
 target/i386/cpu.h                   |  68 ++++++---
 hw/i386/isapc.c                     |  18 ++-
 system/vl.c                         |   1 +
 target-info.c                       |  37 +++++
 target/i386/cpu.c                   |  59 +++++---
 target/i386/gdbstub.c               |   2 +-
 target/i386/host-cpu.c              |   6 +-
 target/i386/machine.c               | 222 ++++++++++++++++++++++++++++
 target/i386/tcg/system/smm_helper.c | 104 ++++++++-----
 11 files changed, 483 insertions(+), 81 deletions(-)

-- 
2.53.0


