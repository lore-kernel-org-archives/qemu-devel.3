Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7228CC5B555
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 14:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLN5L-0002ml-PE; Sat, 31 May 2025 10:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uLN5H-0002kM-LH
 for qemu-devel@nongnu.org; Sat, 31 May 2025 10:21:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uLN5D-0007nL-Gr
 for qemu-devel@nongnu.org; Sat, 31 May 2025 10:21:15 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 54VEKrPY069146
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 31 May 2025 23:20:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=fPPYi8yqmkf0sqo12GAd2rwE/Q+D7WvQg6S1NeccAT4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1748701259; v=1;
 b=eSsHzBwEdbwZtLbHVJVJBx2RjlRfVKYos2jZnQ2HILN9g77mpYAnJv+kyDoirMAx
 1aiDR+bdbsWGBHWXHGuwy6xg8yEQ+ipwKqWeJf0zIV0kIVX6F/684JX3417kKqwd
 Ko+WCkPNMFRVhkdRlKtRDRJo2ACHjFkbB1oQ4FXTWUYbexpMsmcFulyz33f7YJMa
 ZBVxyEHp2y77yvQWpHS4/c26+NgNk+T2VacMIFnWlcIIpQPSKgolM5ngtOj+/XeV
 taMM6rsuOzuuElaUdvevJ5tfvE5Lu61fTHMiyhpJcy1FhZdyO4nXbHrptmcDucHV
 2IKXRwTY6xm4hOtvKGu9BA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 0/2] ui/vnc: Do not copy z_stream
Date: Sat, 31 May 2025 23:20:40 +0900
Message-Id: <20250531-zlib-v2-0-b75c4b4769e1@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADgQO2gC/13MSwrCMBSF4a2UOzaSl7Q4ch+lgzxu7QVNJJHQW
 rJ3Y4cO/8Ph2yFjIsxw7XZIWChTDC3kqQO3mHBHRr41SC4vXIuefR5kmUPFlZ4H65SDdn0lnGk
 9mHFqvVB+x7QdahG/9Q8ognHWBON7ZQet7M2bLdB6dvEJU631Czn4+qqZAAAA
X-Change-ID: 20250417-zlib-ce3034f8bc3c
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@daynix.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.15-dev-edae6
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
Changes in v2:
- Rebased.
- Link to v1: https://lore.kernel.org/qemu-devel/20250417-zlib-v1-0-34fad73b843b@daynix.com

---
Akihiko Odaki (2):
      ui/vnc: Introduce the VncWorker type
      ui/vnc: Do not copy z_stream

 ui/vnc.h              |  14 ++-
 ui/vnc-enc-tight.c    | 341 ++++++++++++++++++++++++++------------------------
 ui/vnc-enc-zlib.c     |  34 ++---
 ui/vnc-enc-zrle.c     |  69 +++++-----
 ui/vnc-jobs.c         |   9 +-
 ui/vnc.c              |  56 ++++-----
 ui/vnc-enc-zrle.c.inc |   2 +-
 7 files changed, 258 insertions(+), 267 deletions(-)
---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20250417-zlib-ce3034f8bc3c

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


