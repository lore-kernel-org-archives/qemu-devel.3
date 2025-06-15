Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA72AC61CE8
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Jun 2025 14:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQoo9-0004aU-Lt; Sun, 15 Jun 2025 10:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <algonell@gmail.com>)
 id 1uQoQs-0007LH-FA
 for qemu-devel@nongnu.org; Sun, 15 Jun 2025 10:34:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <algonell@gmail.com>)
 id 1uQoQq-0005VG-Sm
 for qemu-devel@nongnu.org; Sun, 15 Jun 2025 10:34:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-453066fad06so26829275e9.2
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749998038; x=1750602838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rs6Qvqw8PYN5dg7MGjWVuDjKN/0wmQ/9o3ZBnfwK26w=;
 b=FkaP/slj9O4Hqy67ZHM2PQ64+ws4CRG4bY4vzrEA9/Jr33rvJYL9OlzC7Lfi8Rhlom
 ZFd4d72gQzdlrzVtP+VG6RKhOqpmLGpMcyMHSQEt7qrDclJgw1E2sNNKraF2qnl2hNWE
 ATIAQe0TqJJm5dPrNgetqtMptellagKR4gYA1hnqBdVj9c9r7kEdwtPB7DA9f0N/reVo
 ipaxbTkThT1+Herxzywiu61QoCMqw2c32w0+4BgaQFcFUrUxUAg9mRmI2EmbN+LqBB1V
 0iMG5XPVrL0PgovTpueSS+0lMnnpj9mXSkWWFO1uoIufyw4Xni5DKfGIgvxCAwaJ5NeJ
 zOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749998038; x=1750602838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rs6Qvqw8PYN5dg7MGjWVuDjKN/0wmQ/9o3ZBnfwK26w=;
 b=ZklKbNXTWYTWT5B4DbyT62wl6vF7RT9w2duSusF5njTjb0p5jwVkqyQi8ZUn6tMEf+
 aBzL4uQ2MJXnmnUeYq/LbFXZugUh+wdo+ECLWngvPoZuzbucVWkZImeF4mE4uoelwkVD
 CzuuUuFdAMYkilYVt85IGltvffdB5n5Jg8sq9eMcAYSvCECtvH8eygCrfBxksmnybWjJ
 CfA5D6pKLQgiyNMNXoxVdnaA/IJ4+b99pA+ikhDrB7jt64uIJS5g4AzK7BpceiRRYJad
 GCRQOjESSeN8t1LDXSHD/78wKOqg3gre+Q/qfY17BuYJGn1NfP/aDaXYcR0GFgDDpOEx
 JXCA==
X-Gm-Message-State: AOJu0YzO/6KYaDh1O0hxA+K7dvOCt3U6v9yj+NRLe3taLlUHRvYRlvxV
 9aaAJThsu+R4DFhDEEwWi65yV9cqkB7RjR0ZHXm3lwSLZmHuvzitnFrBEtEduqMl
X-Gm-Gg: ASbGncu0EACQsZYZWilTwiqRH8V//rakFcose86nLRxbD1vFovBDU11n1kyb9gMBMqj
 QeqBoA+r3bUqZuRFtakqxK7Tb3NWoyldIy13AeJlzXesP5RIaE7eRLxw/cL3G+hnEHd3gTo3k3U
 0SRF8NP1QeoHO99NusgqYTjIzwNkEGejD+kUQvfQDSfPIQCWKC261YQ3O/knP8B5kby9FIKI9gW
 vVBA8FuN8ko/XNe85n4kMS/mX1m8NEdhUzSGSpEJvz9p23TsQR/mC6IOWkKM4O1u1Z3EMue1azo
 REKfKDyW7JEh98HkP4TGflmFIlz9QakMLWpJP6Cns0Df4fsnYSCWidCKgyBXSQnbVTHy
X-Google-Smtp-Source: AGHT+IGoV0Zc0CGLrIqipgI0QRhDkCHsOAxcLcbpAU2dmliVIXcfsSFIQELElT2a0Yj8L4ZxLYWM6Q==
X-Received: by 2002:a05:600c:5020:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-4533cac5d29mr59257575e9.30.1749998037865; 
 Sun, 15 Jun 2025 07:33:57 -0700 (PDT)
Received: from ip-172-26-2-149.. ([2a05:d018:458:cf00:674c:b768:6d8:37d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a7e980sm7737749f8f.41.2025.06.15.07.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Jun 2025 07:33:57 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: qemu-devel@nongnu.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] docs: remove repeated word
Date: Sun, 15 Jun 2025 17:33:03 +0300
Message-ID: <20250615143353.5542-1-algonell@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=algonell@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 15 Jun 2025 10:58:03 -0400
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

The word 'find' appears twice, remove the extra one.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 docs/system/introduction.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 338d3745c3..4cd46b5b8f 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -81,7 +81,7 @@ may not be optimal for modern systems.
 
 For a non-x86 system where we emulate a broad range of machine types,
 the command lines are generally more explicit in defining the machine
-and boot behaviour. You will find often find example command lines in
+and boot behaviour. You will often find example command lines in
 the :ref:`system-targets-ref` section of the manual.
 
 While the project doesn't want to discourage users from using the
-- 
2.48.1


