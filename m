Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DF7F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqun-0000Ru-L5; Thu, 23 Apr 2026 06:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquK-0006ra-C1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquI-0002Uv-F7
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:40 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4411e1eba51so3072738f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938617; x=1777543417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/XP138kta01scYB1bF3t+1hO+RwaAXtXBB09kK0OFo8=;
 b=ToGVwjIv4j9BOBJup9EJW7aRcaEKDmtJA/J6VlVxp/Lf9pcmYtoEba3ALXFTwjYKqr
 AhJ5m81FtJz0kMla6FRQEhZ6zXwzroo7RPuHdoGJgm77uEP+BIKDhWR6wmC/Zle6R1YL
 1rw71JHU7CodR2iK4/Z1pJLzxpUG13/rhNHvmrUvoEozGOfMizsiYF0dAISatSt/2z08
 elu3Skqk9xYCSyLfNLvBudruYjVE5XJUixu0LnSqm2bJHNTc8+e6I9l0/uzTxjF0euIS
 6Qa0FKGGVNd1kzRMtzj8SHIyMWCsoi5cxUG7nsJb6ItQTF0tOwyZOTasI+y43uXlMa57
 R8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938617; x=1777543417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/XP138kta01scYB1bF3t+1hO+RwaAXtXBB09kK0OFo8=;
 b=XVSWA01tnZZ6CmiJxhyfBmvrCxLnRBbiBW5CrFOs2SKG74dic08i1bt+wCnrK+RP5U
 bJV4hVBqjaTtZdhoOd35WkA4wzkeeisRtVIFBIYxZv0sdj2lMTUF7mRsh3gIVrjqu8y0
 qYh4cVE42kWMxqLhKXZ352f+WgwOl3Dv9///o7zMw7+PyAkrOXKqdULS5sH9GPlXnmvQ
 i3lmwgEQLNkkYJkBLZQf8FzI64wKjWtszYPXCqvjAyaDf1hROn47KH5Y2aLOAwenT/a1
 RLycX2aSBmEEtwxXEbtqFTR0phTEQs9FXsZ1/dkQHyyzEJ1u0A6s49pNmD5Bi+3h6Yub
 VzlA==
X-Gm-Message-State: AOJu0YzkpmPfE/hP+5+OsBIUt030ZwJOphOd5yq4XJq31hR/vmVBSIuP
 NntaGB2rHR79nYGgyAjpvV5T51Qyqk6+xPLBSM0GaR1mCWlLXPIYdGkcOs5m7pN5ZbV3KntfTKE
 B7BwZ
X-Gm-Gg: AeBDieuJ53dxeUmZ8Ea9bENJaU6OX2xRH7nx5TIjLddDit137FCB53ostst1HvYKNXf
 0BEgzee7CCt4PYKpS1PtyJl4lEbus5OKmoCHjCneJHUMIJx3oV5OG2gaJCGq1R9tiqugAi55pKd
 C88Fw2HBv+BoxC9esJptEGRIjYgXjb5phcQ1NWbh2bQFX+TbiRkvZ72mM+zgX/HTEwHvNnK/9xB
 O4kl2QOm5IW2mz+16qrrCYC1OpDZsMCjCXxbvdHetceCqgal5MD5/TPXT1rwkd8eIodbUCzALAE
 466yHjdijwreIhO5h7LBaK2X4YMx7xf6YVGdXGJKDJtQLhFmPICFKAQE3F6XYFOhMdf8+sRukBm
 V2JhQYadT92ADHVv42zm+VHGtX0bHjgiMmU4tLwZszJoBZmK3F6ysroymubUsewv7E8e7dXDE2Y
 oilGWOPn2+TIS7Qp/vBubtOuboFn5i/UVHq6ZGFprnibN1jj1n3ObjmoMshzuNG3sAZvXpM6thH
 9HZXpyHnRnUpyO12ZzzXGgQihdNLKQg28DN2JeW6w==
X-Received: by 2002:a05:6000:40dc:b0:43d:1bf6:927 with SMTP id
 ffacd0b85a97d-43fe3dc7558mr41960104f8f.14.1776938616734; 
 Thu, 23 Apr 2026 03:03:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/59] MAINTAINERS: Remove Xie Changlong
Date: Thu, 23 Apr 2026 11:02:29 +0100
Message-ID: <20260423100229.2941820-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Xie Changlong has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the "Replication" block filter orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Message-id: 20260416091654.316158-29-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed77b28c2a..facc4b499a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4384,8 +4384,7 @@ F: block/export/vduse-blk.c
 F: block/export/vduse-blk.h
 
 Replication
-M: Xie Changlong <xiechanglong.d@gmail.com>
-S: Supported
+S: Orphan
 F: replication*
 F: block/replication.c
 F: tests/unit/test-replication.c
-- 
2.43.0


