Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEBACA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRDq-00038u-0S; Fri, 05 Sep 2025 03:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuRDk-00036f-Dw
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:50:56 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuRDh-0008RZ-FV
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:50:56 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b87bc67a4so13041545e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757058650; x=1757663450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=en/zZvGh5vb77Zx8HQQIP67quTNtVCsQSktFVoRlQXM=;
 b=OC4jrob+6jN4rzdzPmRCraGUw+UmlA9icfglmTnOwtcs8orRiIezyCFm8NWtCBg7n8
 +gJfie28H8BoaFChB8MCzmUevFCsLZz4OjRe1h4OUcHGfQzadUgQ8UCU/ZIV7XVLDDsa
 WxTb8QC5B5Fwdb0wTH9A0LbXrl44g5loKIdsHlHMC176x26p5BQ1/WpmK9T4HbqIBtYj
 dKfPoKTxYvWwq4BEv4pD4BDnn9sN0poxdOFyFW5lNhuXJGebRBr1KBipg+5YA4g9m+Mh
 2U4eDhkWAExwgEmWngOicuEXOMm6Z3p9V4aQn7AkPrMjPvCJz08NFNVRERHDKn6N9N3E
 N07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757058650; x=1757663450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=en/zZvGh5vb77Zx8HQQIP67quTNtVCsQSktFVoRlQXM=;
 b=v9ZjQGnWXQZ6Jy48v9Qh+zxNsFOvBhD4VolZhYlcodli81nvbuo6cEKGbG0twwIHuP
 wmBy6ax5/IBhyxtnj/kZq8iTDj+GAugN3P3HAZyyohoecq7bTDHEAuXL03AdKTAxO+7m
 4tXQXu5V1YSnr4bDGFALxZrLzZyJT0/KdmuKTc7rmJsIHIIEzi5j5OokC90YPlHMgW9Y
 N568Ni9kHPstGAbTzTrN3Tz0U2miPunIxZyBbJXsTaQHp+6BzPXdRpG/skT7Eks6rQJS
 enbBB4bFaomDu5IPiSWDQLvcLo0BG1teXpsfInES/0ovDyvivm8COm2mKFyKKLoFNw0Y
 FL7Q==
X-Gm-Message-State: AOJu0Yyt7xhnUWAZPYYH3Lf8EuepD8ZS4iK1wL8D2Zb4u9LxLngPQtEB
 IxAVN5KlGXZ1bLA7yZRFqoTLpzE9+x/yQWE5kHh9pDfTMBSQuJ9RkViFd5DSiHNSETFyHAeum+j
 jo0h1U3I=
X-Gm-Gg: ASbGncv5OHy/rnLwucsT3u1HlJMwFviyXDoDmG3k2jqH9DW54HUkBQY6TVwwhfpA/HH
 mApWvwbqtxJ9FHSbly0z6VWAFaw5zKmnCO18vngyo1UKwFHvbfPSpp29NqPfRtrSamloKhsgDVa
 W5gZbaoVXdr9SHkc0AEWxOAX29oAjQVSLDkgbQ8AukXTE7VJcj2uqFUU46JPlE96rrqHHQrP7lQ
 2Ng09WcpSZdm/Zx/3FXsuqYOxGFcWXyjkTedT06+fEyiyiWzDDBo7jJGmRNprRkYT0GtEy3fyH5
 AmBbkkjY7pxtjREvDo5VN/QCCQozTEXJ/aA/4xprj52e9co9w+UDNYpR5vl1mlkpMjqnBtm/YgD
 CGMMGBXKiVvcKzWN4bQDlUZaYNkxkStHIaMU7TiuFphFvJqQuoA/5Kabe
X-Google-Smtp-Source: AGHT+IHdKbfKc8azpcfoe2BdCGzO1U/RNFCYfdVZ6oWLwaGj69Fe1r1EHXEGzvCnol/w/t3lFvtUcw==
X-Received: by 2002:a05:600c:4ecf:b0:45d:d5c6:97b4 with SMTP id
 5b1f17b1804b1-45dd5c69aa1mr17259915e9.9.1757058650241; 
 Fri, 05 Sep 2025 00:50:50 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b98e77231sm143760715e9.12.2025.09.05.00.50.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:50:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] tcg patch queue
Date: Fri,  5 Sep 2025 09:50:40 +0200
Message-ID: <20250905075048.100496-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

The following changes since commit baa79455fa92984ff0f4b9ae94bed66823177a27:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-09-03 11:39:16 +0200)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250905

for you to fetch changes up to cb2540979264c8d3984e26c5dd90a840e47ec5dd:

  tcg/i386: Use vgf2p8affineqb for MO_8 vector shifts (2025-09-04 09:49:30 +0200)

----------------------------------------------------------------
tcg/arm: Fix tgen_deposit
tcg/i386: Use vgf2p8affineqb for MO_8 vector shifts

----------------------------------------------------------------
Richard Henderson (6):
      tcg/arm: Fix tgen_deposit
      cpuinfo/i386: Detect GFNI as an AVX extension
      tcg/i386: Expand sari of bits-1 as pcmpgt
      tcg/i386: Use canonical operand ordering in expand_vec_sari
      tcg/i386: Add INDEX_op_x86_vgf2p8affineqb_vec
      tcg/i386: Use vgf2p8affineqb for MO_8 vector shifts

 host/include/i386/host/cpuinfo.h |  1 +
 include/qemu/cpuid.h             |  3 ++
 util/cpuinfo-i386.c              |  1 +
 tcg/arm/tcg-target.c.inc         |  3 +-
 tcg/i386/tcg-target-opc.h.inc    |  1 +
 tcg/i386/tcg-target.c.inc        | 91 +++++++++++++++++++++++++++++++++++++---
 6 files changed, 93 insertions(+), 7 deletions(-)

