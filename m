Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E942F4610D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fdO-0000ew-57; Mon, 23 Mar 2026 09:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4fdF-0000d0-1H
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:47:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4fdB-0005XW-Qx
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:47:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so1209895e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774273663; x=1774878463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=29B3TWrmp9HDLZHqMIvZLwgmE1azPiN6lT1eZf7m934=;
 b=fgN9PWkY079NolkSxGUfGGt+rw+9LDJVQXqiQ6XZG32ih964QIlectFfvSc9Mo3A+Y
 miZLD+flIp8ctH1ntSH2P3TxJ/uCMXtAdrF9Tb16TOMqujGacM+So8lUwSgTveO/gDQQ
 9iY69F46vTBr7I0JM/8p3MZ6WLMA7KzHvIcQmXpwYRm8kt/e5Bue5qDe/Lb4+W48kUd8
 hVQBVToH7z+TaVhtXXySncWhVOv0J0E5SHmTyFyv/1c7D29GmqJfgUKEojpfT5PG4HM6
 ddyFRQK0aeAL0PZMp0QVQrEFlk2AhtjsThI+yBXHYA6XyFjLRPyUdKG92eCkLu7nDuBm
 H7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774273663; x=1774878463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=29B3TWrmp9HDLZHqMIvZLwgmE1azPiN6lT1eZf7m934=;
 b=UrspTdOLaZ09hoN6C+TIu6+XVvs+MAcCma3/tM0mzarzzZlhFTyuTWZ1UpvbWGHHsb
 9gRd8WlsWuCb9VsYCQ0MQZ28HKzUJ30BAJSjjGUdDCyyNMDw1PSXoGNwkFmkTSt5sh3i
 VFQGe66ObCkV4fSTDj1G2aSmIhfpGT2kVrXLQy61FaxMuyPnG1zegjULKZTevoaUQLgM
 /kxJ38P/jP+FWnaLT78I1JBREtFTpo3UymAbgIJGK4hzKcGZRQyeZU0SVsgERh4ij5oN
 75AT+XtQTdeGVv4xZwosOgw0xrNqOADZJWlisS+azBwZYEbXVZpO3Mxhd3b/vrHW7hux
 dDRg==
X-Gm-Message-State: AOJu0YwhxGGC4EMwvz+Bi6eZ/Hr78ubDw/pyVi4IiI70dRg6HDD5pLFR
 5+V00ARg3SZ6A3AR7eMj3aR7Vg8OLf3hZN/eRMXbKAAkDFjd5GrlBHS7xrWgNL83orWN28gA9qs
 LzEtooIM=
X-Gm-Gg: ATEYQzxxcbRCLEoqg3V6MSniYg3PyLB21aCOtswNCNLcxwmU+LajqfPvK52uI1LAmb6
 c/HUTSHSuOVkt3sV5ZpDMucfxDqEEewqwQYAMLV01vVZ5xDHYC9LZDTWFx2iBhdGmiL1bTloVbN
 ZNbq/pvstaD9OTt1tMcqfyqY7/DphL3wTVKdf31HlwGMsrNS/aOPwK6ynt5vMXjk+GW+q6LmHz7
 VzD8Um9SeCSReQA3p3aCwUDmWuWzqaZm3qOSWXNQNRmchgAZ25lyxZDfGUXpUWzwniHPhJmF2/B
 CwnjUr/Sno/2vjYwaLT4VeH699nASiWX7fS6ZAy/lObvKhoHusffy4oVq6iAf0TTOSRhjrAhrBR
 i8QThsSIsaZmLmxltiiEMIvizMuNfu3l9Y7xOp06+pm1Wd429BL449rAnmei1XgVnYJ6ZIFnGhD
 scvDNaWUMe3qtmKBnIbExN9l/hTLnnwOUoHmwjZ9+jt9UiLv06EpNfnPczB/WKVQzncynJgV6uO
 CLbAQKKzaah+XMPQNO1CnbZk0AJ9+s=
X-Received: by 2002:a05:600c:c493:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-486fedbd0b0mr179937445e9.11.1774273662699; 
 Mon, 23 Mar 2026 06:47:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b646b0d3dsm28308143f8f.16.2026.03.23.06.47.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:47:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] MAINTAINERS: more updates,
 orphan "overall usermode emulation"
Date: Mon, 23 Mar 2026 13:47:39 +0000
Message-ID: <20260323134741.4114629-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

This patchset updates our MAINTAINERS file to remove entries for some
people who have let me know that they no longer wish to be listed, in
the same manner as the earlier patchset I sent a few weeks ago:

https://lore.kernel.org/qemu-devel/20260306120555.2035421-1-peter.maydell@linaro.org/

As usual, I'd like to say thank you on behalf of the project for your
work on QEMU, and for helping us in reviewing code and maintainer
duties.

NB: this leaves the "Overall usermode emulation" subsection in the
Orphan state.

thanks
-- PMM

Peter Maydell (2):
  MAINTAINERS: Remove Riku Voipio
  MAINTAINERS: Remove Igor Mitsyanko

 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.43.0


