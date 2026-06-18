Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF911CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCAG-0001mL-V3; Thu, 18 Jun 2026 08:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caixiangfeng@bytedance.com>)
 id 1waAW7-0000FS-SL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:02:40 -0400
Received: from va-2-111.ptr.blmpb.com ([209.127.231.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caixiangfeng@bytedance.com>)
 id 1waAW2-0003k3-Sz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1781780542; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=plykjydmcTvYtBKCoMjR+fOzNxD+AhqHdlHc+poZiJs=;
 b=iF9RZ0N0AppioSRY1g2QxvFz5pFJlddXE4ikJr5GW4gOKELrF4BYQ6pmi1ov6nrvcWSHR1
 UkM9WUjE5Uc+7DdhUmRAD/18lf+9mfZpAZB1A+gBc7AWa1AkmyYKOo9531fMG5uqx+pv7c
 xMSEO11wBrVJ5gObtTprLkZ4ok4D7OjdcljdCE+tDA8TGLIs62wsOO3ho7X56bEouGWL/d
 XI2h9Rs6znERHoep4hzaInEnQhGymRJOqvHgIHVTj7BLKGjIDP1URZnlKAvXJsOzxklPLC
 DNwpxo3azxk1UDO4MIWmat5KSilB2mlBM7FSnKJHARJ4QaYy2I6eLRXxGGWF/Q==
Subject: [PATCH 0/2] xHCI PCI has a QOM reference-cycle bug on hot-unplug
Date: Thu, 18 Jun 2026 19:01:17 +0800
Content-Transfer-Encoding: 7bit
Cc: <caixiangfeng@bytedance.com>, <yanfei.xu@bytedance.com>, 
 "Fabiano Rosas" <farosas@suse.de>, "Laurent Vivier" <lvivier@redhat.com>, 
 "Paolo Bonzini" <pbonzini@redhat.com>
From: "Xiangfeng Cai" <caixiangfeng@bytedance.com>
Message-Id: <20260618110119.3084296-1-caixiangfeng@bytedance.com>
X-Original-From: Xiangfeng Cai <caixiangfeng@bytedance.com>
X-Lms-Return-Path: <lba+26a33d03c+f56d1d+nongnu.org+caixiangfeng@bytedance.com>
To: <qemu-devel@nongnu.org>
X-Mailer: git-send-email 2.55.0.rc1
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Received-SPF: pass client-ip=209.127.231.111;
 envelope-from=caixiangfeng@bytedance.com; helo=va-2-111.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jun 2026 08:48:01 -0400
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

The xHCI PCI wrapper owns an embedded xhci-core child via
object_initialize_child(), while the child's strong host link points back to the
PCI wrapper. On hot-unplug, usb_xhci_pci_exit() does not unrealize the embedded
child or clear the host link, so the strong back-reference keeps the PCI
device's QOM refcount from reaching zero.

As a result, the xHCI PCI device is unrealized and unparented, but it is never
finalized. This leaks the controller object and prevents finalization-side
cleanup from running, including DEVICE_DELETED emission from device_finalize().

This is independently an upstream QEMU object-lifetime bug. It can also have
latent higher-level effects for CPR orchestration: CPR relies on the new or
re-executed QEMU being launched with a command line that matches the current
source VM topology. If management relies on hot-unplug completion/finalization
signals to update that topology, the missing finalization/DEVICE_DELETED event
can leave a stale -device qemu-xhci or -device nec-usb-xhci entry in the CPR
restart command, causing a previously unplugged controller to be recreated after
cpr-reboot, cpr-transfer, or cpr-exec.

Xiangfeng Cai (2):
  hw/usb/hcd-xhci-pci: break host link cycle so device_finalize() runs
    on unplug
  tests/qtest: add xhci-pci unplug finalize regression test

 hw/usb/hcd-xhci-pci.c           | 12 ++++++
 tests/qtest/usb-hcd-xhci-test.c | 67 +++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

-- 
2.55.0.rc1

