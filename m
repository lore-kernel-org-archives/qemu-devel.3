Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96554CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gBf-0004uG-BH; Tue, 14 Oct 2025 10:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1v8gBa-0004u1-VP
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:39:35 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1v8gBS-0000WB-Ot
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:39:34 -0400
DKIM-Signature: a=rsa-sha256; bh=iWlVYS1uH3dKZoLPAvJDI+QRxJiZSSrFDqKZwedydYM=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1760452755; v=1;
 b=hv5oONO/yZDSXjYfV3qMukZBFMwQG9IqR76UuXlJziKKoYGBIp0BYckBNV5Z/XCLpJNSwb8f
 OFjkCpNolCraQScKdntrDxY06RKqUcCtJXPLQ6qWPGgMtToIZk1i1cgATuvfmmgcpxXPBv5dfyU
 HMr7Dg7HbB/eAyJsXsnzr/KiT89btMOI2Jjx+m257ygsOVzhhlE7TUUtRCRt4l/QinYAE3SZmba
 soyapBQULn7QQ0T0sVe1H0cQXW/pT4JI6UKYua64TDPhc36bagN3WG8M9YmxyToi+XNM9xXrnEH
 1RX44onk6DSHHfJ47IP3vYguvGrLVGrq9O2qYNVrzHLTA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id F012923BDC;
 Tue, 14 Oct 2025 14:39:14 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Tue, 14 Oct 2025 14:39:14 +0000
Subject: [PATCH qemu v7 0/2] Honor guest PAT on x86, absent Bochs display
MIME-Version: 1.0
Message-ID: <176045275486.7119.13003157223292391926-0@git.sr.ht>
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
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is a minor revision of of the proposed patch to disable KVM ignore
guest PAT quirk, on x86_64 target, when KVM is available and Bochs DRM
display driver is not used.

This revision hopefully addresses the points raised by Dmitry Osipenko
<dmitry.osipenko@collabora.com> regarding the v6 one.

As with the v6 of the patch it is intended to address the following
issue:
https://gitlab.com/qemu-project/qemu/-/issues/2943

myrslint (2):
  Honor guest PAT on x86, absent Bochs display
  Honor guest PAT on x86, absent Bochs display

-- 
2.49.1

