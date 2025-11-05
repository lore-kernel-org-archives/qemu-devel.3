Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5071BCCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 22:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGm2m-00021k-VD; Wed, 05 Nov 2025 17:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vGm2h-00021I-23
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 17:31:54 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vGm2e-0007UM-Fn
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 17:31:50 -0500
DKIM-Signature: a=rsa-sha256; bh=Qwe2qD+NAv2Q5+n4zFfw72+MGaBuv9fsvyxivzcoKqs=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1762381904; v=1;
 b=SSy5/GlTq3Xo8xxx1YpmkmVwqlE/I7DN5H/9qAFU1p6IQDNtV3xpqyC7Z7P0r1s5EA8TKtha
 WVIo1Xz8d0JnojrjBq1NSuEaowdfEjpd19DIlsq72WCilztiuUFD0bK9NxUtl9WCU/BfRKeNHsf
 1cYoQsiAJ7ffUhxE4OtSwSVcF9UmcapVF7i7Nu3P6amT7grLqrnlMUskHJhNWEO23tzLqJDHQ6k
 XW+cMfKPWiKf9UTTyOAMJV919fWkbqQfqaOXKnTQ9p9umYl/BvTSj0kRHy0ZK5rn7Zo3qMFHAX2
 XsjhUXxDH728wXYhXhqTPZ2J3JLQQuM8wGU8n7KAhoIAw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 488E6240BB;
 Wed, 05 Nov 2025 22:31:44 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Wed, 05 Nov 2025 22:31:44 +0000
Subject: [PATCH qemu v9 0/1] i386/kvm: Honor guest PAT on x86,
 absent Bochs display
MIME-Version: 1.0
Message-ID: <176238190422.23756.12141073071212582632-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~myrslint <myrskylintu@proton.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a minor revision of v8 of the same patch to address concerns
kindly raised by Dmitry Osipenko <dmitry.osipenko@collabora.com>.

myrslint (1):
  i386/kvm: Honor guest PAT on x86, absent Bochs display

 accel/kvm/kvm-all.c        |  1 +
 accel/stubs/kvm-stub.c     |  1 +
 hw/display/bochs-display.c | 17 +++++++++++++++
 include/system/kvm.h       |  9 ++++++++
 target/i386/kvm/kvm.c      | 42 +++++++++++++++++++++++++++++++-------
 5 files changed, 63 insertions(+), 7 deletions(-)

-- 
2.49.1

