Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48860C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMNnT-0008Ct-ND; Tue, 03 Jun 2025 05:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uMNnQ-0008CQ-LB
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:19:00 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uMNnN-0006qe-JZ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:19:00 -0400
Received: from [157.82.207.189] ([157.82.207.189]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5539IXBq068202
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Jun 2025 18:18:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=BtkQBQP3QXrEeSVnyAQHZxgpjEs7FQH4FGu8EcZY5iQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1748942324; v=1;
 b=OX0+3spSkaFGTZ88tHoLXLFiSgBolE4GyYlWWHGV4+kNnoAHa24iIIDEH4rNBTcS
 kCk73yLkOhS9nYpFy/oPXG2oTJ1HWhGvcGKNVXFgA1FPKKIPBDxHsOnwcAclGAaH
 dUWRfurnuemi4DHUHJp/sRRidk23b0usHUrfc6RsD2SqC22TLlUZ/TvItWsd8mXV
 MjMxaLnWqF1Ona+k4vm+71JuiNY73zlY1/WbmVYS4jYoWclypOno2PtZFIp1OTnZ
 XzssVRgU7sPJiwZkHQGmMbj5ndl0sYSrDTvEiYBq6veyySFUuVaTZFWWpEP6zj9a
 iQetQeBekjKncMBVrV8vxw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 0/2] ui/vnc: Do not copy z_stream
Date: Tue, 03 Jun 2025 18:18:27 +0900
Message-Id: <20250603-zlib-v3-0-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOO9PmgC/12Myw6CMBQFf4V0bZu+EHTFfxgWbalwfVDSYgMS/
 t1CTExczsmZWVCwHmxA52xB3kYI4PoE4pAh06m+tRiaxIhTnlPJCvx+gMbGCirktdRGGJSug7d
 XmPbMpU7cQRidn/dqZNv6F4gMU5wKqimELqXQVaPmHiZi3BNthch/Vi7Y1+LJ0kVupJbF8WRZ5
 UNLDBAgLzy6++yIMuQ2oHpd1w++nzfE2wAAAA==
X-Change-ID: 20250417-zlib-ce3034f8bc3c
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@daynix.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

vnc_worker_thread_loop() copies z_stream stored in its local VncState to
the persistent VncState, and the copied one is freed with deflateEnd()
later. However, deflateEnd() refuses to operate with a copied z_stream
and returns Z_STREAM_ERROR, leaking the allocated memory.

Avoid copying the zlib state to fix the memory leak.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v3:
- Rebased.
- Reordered the patches.
- Removed the extra allocation of VncWorker.
- Removed the worker field from VncState.
- Dropped the Reviewed-by tags.
- Link to v2: https://lore.kernel.org/qemu-devel/20250531-zlib-v2-0-b75c4b4769e1@rsg.ci.i.u-tokyo.ac.jp

Changes in v2:
- Rebased.
- Link to v1: https://lore.kernel.org/qemu-devel/20250417-zlib-v1-0-34fad73b843b@daynix.com

---
Akihiko Odaki (2):
      ui/vnc: Do not copy z_stream
      ui/vnc: Introduce the VncWorker type

 ui/vnc.h              |  49 ++++--
 ui/vnc-enc-tight.c    | 456 ++++++++++++++++++++++++++------------------------
 ui/vnc-enc-zlib.c     |  47 +++---
 ui/vnc-enc-zrle.c     | 122 +++++++-------
 ui/vnc-jobs.c         |  13 +-
 ui/vnc.c              |  83 ++++-----
 ui/vnc-enc-zrle.c.inc |  20 +--
 7 files changed, 407 insertions(+), 383 deletions(-)
---
base-commit: 6322b753f798337835e205b6d805356bea582c86
change-id: 20250417-zlib-ce3034f8bc3c

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


