Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342D9F589DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuY3-0005eR-Ui; Thu, 23 Apr 2026 09:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wFuX6-0005Wg-G3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:56:06 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wFuWu-0000cB-IQ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:55:49 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63NDtV0L080520
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 23 Apr 2026 22:55:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=IXLPhMVbP01PLG2+dRp/eAaFEn9u1APxip+wQX8V2lE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1776952532; v=1;
 b=c+XAhzexG0VY45iQOL9rIj0nnrU60dHLW9EpezDRIWC78onY2WUPhzr+NJTEikLJ
 u8QbO4JRjlstXAuF9U3lnzxG4OUgwpTfzXvfmcBsNz0eP2S6Leje7GTVUCcuc2oS
 3S45/HEcAHjwF39HAm/9AGtexzh+qq24fLpsJunjtcHJj5SrTR/vxkDeFazwfgnv
 H8u3QroCI/7J3mMAFonKUr0eo7YJpyxm5GN6P5T+GPzHrtfpl8VoopQ/fST9/WWh
 C2s2G51AxFomWNWWRnKDM7cJV+S/CfoKsrAF+mX0bcpLI2AI2NUsnMsbD0dqPYpR
 KfXz4GIwL4IOczqcukAa+A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/3] audio: Fix unsigned PCM conversion edge cases
Date: Thu, 23 Apr 2026 22:55:20 +0900
Message-Id: <20260423-audio-v1-0-e1d6b65c76f9@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBSE4as0b61JW42Eq4hFMXgWSKsiEXdXL
 L/kn7kowDMCVeIij4MDr0uCzgR1k1tGSO6TyShTKGty6WLPq7SFhUapcmVBqd08Bj6/n7r5HWI
 7o9vfMd33A+6g6wRpAAAA
X-Change-ID: 20260423-audio-464e1e90304e
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

Building QEMU with recent Clang from Xcode reports warnings in the
unsigned 32-bit PCM clipping helper. The warning points at a real
conversion issue: the current code mixes unsigned arithmetic,
floating-point rounding, and the wrong midpoint for unsigned PCM
samples.

Unsigned PCM uses a bias at the upper middle value of the sample range,
such as 0x80, 0x8000, or 0x80000000. The existing HALF value names the
lower middle value instead. Around that boundary, the conversion code
can also wrap before promotion, and the uint32_t clipping helper can
compute a value one past the representable range.

Fix the unsigned conversion paths by:

- converting before subtracting the bias, so samples below the midpoint
  do not wrap;
- clamping the floating-point clipping result to the integer endpoint;
- replacing HALF with an explicit BIAS value matching unsigned PCM.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (3):
      audio: Avoid unsigned sample wraparound
      audio: Clamp unsigned sample conversion
      audio: Use unsigned PCM bias

 audio/mixeng_template.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20260423-audio-464e1e90304e

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


