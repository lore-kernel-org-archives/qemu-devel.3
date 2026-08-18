Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC6CC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 00:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww7f2-0002H6-W0; Mon, 17 Aug 2026 20:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7f0-0002GJ-T1
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:35 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7ez-0004Gl-E3
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:34 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4b21f71613fso2303804b6e.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 17:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787012791; x=1787617591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9/yfjQTPEtrC9StG3ocPwJnsJPDokp/jOBq4p+yXhWE=;
 b=X1vXIy+RcXfnGqf4InClTTDtDC/HZwrRWHkVy1+698wzVB+poA+W+OHrOFzhR18uir
 ss6C9Su9REkJWjzc49Nciouqqyp81yNrmNV+qPK6GF6KaiHltXTo4xLcpJ2lvUy7lM0Q
 +QN+0jeiQjSGW4La+F1bay8FyxxnUSG8TExbPeorqP7jOjEPKCdR5xBrif3FkaxVSX3v
 xCnM/3E0GU7bGuRTGCesnWLotcnCXxT4T366nOPmt7L6xbWSaWmX7NFfPEv0mxXcWtA2
 hW5Nc3MlhCI+jImFlA3sov7rEe41G7J3z40T/0CboZE31ZBrWtZ/kae+kaX9G+YGroyf
 /CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787012791; x=1787617591;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9/yfjQTPEtrC9StG3ocPwJnsJPDokp/jOBq4p+yXhWE=;
 b=dA7vd9pdoFXcwOUA//nZcDzpbuApHljv1wFH8dFqUDKWdEwzMxupx8/L5M7Pf2CqrP
 bs6x0jiCI9sEeHUTMEDeSfniGWn1x85mnVAG8A77MgKwIB8cOjPqoOwhMgU2QloYT6YN
 o5p0l/NGC8WXqVJkPys5E9CMuibhBfXt99TLNYX3NFPXOTvrxPjdin6VLdLvxLuHqNIF
 MO8X+/tldZ5MHB9IMM6pW4QRaKce4R4QaT56zK1xFmxVCP2ncXQDpwbciM1wxwqHKgyY
 6U+ww6hInzd3gZtsbCdWJRtT6V7iLyVwr4lFMiBt6vU2mDXkIfhtDOYu4ikICxDZb4D8
 2o3g==
X-Gm-Message-State: AOJu0YyNIQs/X5nixSe0WZHnY9JiyUavmpSwxbQhgNGkLhqjIOaX73yv
 UNoUeU9ItanhSxixxUgxWs+Y6881BzOW4Et3cZvEeWhbxCD18VSxFYN6f9XfCA==
X-Gm-Gg: AR+sD12uFzWtam5zkWpKKHaMh9eTTPZIvsVyhkJ67C5SDsrKx9jvOTiFklqoOZWY72V
 hgNOhC9B+AcZrpHTDAPpI/W0lNUYt5WBYpK7MDrsf/6hrHPt8kaA0lwJQVv24OhwQS7pqd0SV+f
 MWf2Ee6iLFQb0s6JfvPcdRMPMUdERBQ91cdsPIypxf0YQcz8pW9qB0QqbFlFkzvcSOtGIYeEKV7
 k1OVq5n3DbFT7DWA+JZCp1FqAnL8oIC1rrd1Gq4egbmJhA6tbZEfG9BkrVRqkzJMgP8pU8v89gh
 ooRa9N8FoPzXoz/OrrrFqeOAPLT0Y5dme0LQcSJip2jd1aEQNixWcrK7lcXpF/QIviom1fRt+Kj
 vikEXlNfCfaG8pX2sQKSJV3CjzAu+49ws9E0MaT01SAN8LdMtXuEDxvh9QRp86/SYd/rqMtCZIr
 reGxK7O2fVZfGLfat6gCly33iV7oWC+Xb61k+k0hxY5GfChvcB9Lv8vdR9mno5sOhHzOe+kqwPl
 Plfw6BXymY=
X-Received: by 2002:a05:6808:5142:b0:4a4:a693:9d87 with SMTP id
 5614622812f47-4b297517839mr4579257b6e.5.1787012791534; 
 Mon, 17 Aug 2026 17:26:31 -0700 (PDT)
Received: from LAPTOP-86EU4LQA.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2960dfc9bsm1715165b6e.14.2026.08.17.17.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 17:26:30 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH v3 0/9] arm: add Cortex-M85, SSE-310, and mps3-an555
Date: Mon, 17 Aug 2026 19:26:20 -0500
Message-ID: <20260818002629.172827-1-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch series aims to add the Arm Cortex-M85 CPU, SSE-310 Subsystem,
and mps3-an555 FPGA board.

v2 -> v3
    Removed ppuintstat variable in iotkit-sysctl
    Moved add GPIOALT2 register patch before add mps3-an555 patch
    Add gpioalt2 state field to new vmstate subsection for migration
    Rebased onto master which includes bug fixes to existing models
        in armsse.c and mps2-tz.c
    Patches 1, 3, 8 still needs review

Signed-off-by: Simon Xu <simonxhy0404@gmail.com>

Simon Xu (9):
  target/arm/tcg/cpu-v7m.c: add cortex-m85 model
  hw/arm/armsse: add Arm Corstone SSE-310
  hw/misc/iotkit-sysctl.c: add SSE-310 support
  hw/misc/iotkit-secctl.c: fix AHB secure read
  hw/misc/iotkit-secctl.c: add SSE-310 support
  hw/misc/iotkit-secctl.c: use GNU C case ranges
  hw/misc/iotkit-sysinfo.c: add SSE-310 support
  hw/misc/mps2-fpgaio.c: add GPIOALT2 register
  hw/arm/mps2-tz.c add Arm mps3-an555 board

 docs/system/arm/mps2.rst        |   6 +-
 hw/arm/armsse.c                 | 208 +++++++++++++++++++++++++++++++-
 hw/arm/mps2-tz.c                | 162 ++++++++++++++++++++++++-
 hw/misc/iotkit-secctl.c         | 132 ++++++--------------
 hw/misc/iotkit-sysctl.c         |  88 ++++++++++++--
 hw/misc/iotkit-sysinfo.c        |  22 +++-
 hw/misc/mps2-fpgaio.c           |  35 ++++++
 include/hw/arm/armsse-version.h |   2 +
 include/hw/arm/armsse.h         |   9 +-
 include/hw/misc/mps2-fpgaio.h   |   2 +
 target/arm/tcg/cpu-v7m.c        |  41 +++++++
 11 files changed, 587 insertions(+), 120 deletions(-)

-- 
2.53.0


