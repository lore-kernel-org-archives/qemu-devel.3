Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97195CCD18C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 02:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v73JZ-0006IE-AX; Thu, 09 Oct 2025 22:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1v73JW-0006Hl-5X
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 22:57:02 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1v73JR-0001kS-D4
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 22:57:00 -0400
DKIM-Signature: a=rsa-sha256; bh=DZLVBJFOfvnvxfi4ZdNBm94tPeMa5yIS7KdpAzPaM2c=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1760065007; v=1;
 b=oV/vU1jv5xEcwugyL31gVAiEAvYvVRpPR6Gb/iogPSy5YIyjRgew4ZO0tMIUE/MkftWjV+Wv
 MZybKUgaCgGUBdqUn5fbCGB53YWB4ABuXaPmxs7p5KX57ZYpogbsMMMdo96ub48hu0hLpsw+t6S
 FIvvmNzJL6uKBbOs+ijCr5P4OQO+RLt6TpU6zs0V5dE0DaPq2SIu0G3fqFzLzD3eVM2hhxJvki1
 fxE+neF5MsePqTiySJ+gnckmwqR04C6lh/zjiRPjjduRgl7FdcfDZ78NWdgbsJldN6DntKl+OpL
 iWK2b/Txja2116SUonUp9RV+0Y7S6hHxW/RbTtt3DkG3A==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 45E2723AD7;
 Fri, 10 Oct 2025 02:56:47 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Fri, 10 Oct 2025 02:56:47 +0000
Subject: [PATCH qemu v6 0/1] Honor guest PAT on x86, absent Bochs display
MIME-Version: 1.0
Message-ID: <176006500714.5527.9159197863408802401-0@git.sr.ht>
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

This is a rebase and revision of the proposed patch to disable KVM
ignore guest PAT quirk, on x86_64 target, when KVM is available and
Bochs DRM display driver is not used. Hopefully, it alleviates the point
raised by Dmitry Osipenko <dmitry.osipenko@collabora.com>. I have tested
compiling for x86_64 and aarch64 targets to make sure no compile-time
errors are raised.

I have also tested that this issue is addressed by the patch:
https://gitlab.com/qemu-project/qemu/-/issues/2943

myrslint (1):
  Honor guest PAT on x86, absent Bochs display

 accel/kvm/kvm-all.c        |  1 +
 accel/stubs/kvm-stub.c     |  1 +
 hw/display/bochs-display.c |  5 +++++
 include/system/kvm.h       |  9 ++++++++
 target/i386/kvm/kvm.c      | 42 +++++++++++++++++++++++++++++++-------
 5 files changed, 51 insertions(+), 7 deletions(-)

-- 
2.49.1

