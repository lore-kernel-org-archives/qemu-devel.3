Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3329ED2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 02:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3QpF-0001XQ-9q; Tue, 22 Oct 2024 22:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t3Qp9-0001X6-RQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 22:10:13 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t3Qp6-0007dN-1M
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 22:10:11 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3e5fef69f2eso3320788b6e.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 19:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729649406; x=1730254206;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x/tVDeuX18wdQozFQJKEkUhQ98GKhPY0MI4/ZNxhsVo=;
 b=Zc2IeZVoHRF7x9li5Q5K5VEW28ypmS4hDqHalbkllGNO1U2VPMCwrJ/f1j8jwKHxkl
 61dSKvn/lTGtDOjzZaWvfBuqFDK1rjFtMGoBL55xkg8+maUFYYAXNLd1P1Tu8KRHKCTS
 tOxHaDRuchm/Gw/NzqXQv/KhL74Hwg0w9iyblyFaAYxwV82PX7Gfx9HSjpBOgauNF+hM
 tAXRSOfWtN9+CTzzyatxgyhCtjcW88vJAeIivRXgbr00zM7VPolNnfDN5Ih2cHsyDEti
 xcN2eojfpAL5ewvQpZbu7VonEAa53E4ELVHGM0C2X9tVEaS+0ofI/uKI2JrX8nQLacXU
 IV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729649406; x=1730254206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x/tVDeuX18wdQozFQJKEkUhQ98GKhPY0MI4/ZNxhsVo=;
 b=q7SZkaFi9tV1UHXomqoq8fOoFwujIReDFoeDJE9Ymtbtl2I3FUEIx2gK+TLohRe67C
 MkriFMIRFKy8USpQxuSfbeEd2v2fcraTEPT/RpCbrEV66Iam9EKylvYfUSnT4sk8T9GM
 2pF8Fd+xdVp4KPubUwa5r1JCXTNTDHNmOEtFFfAyeHl3eAYPrMKHgXiSXMqHdmmG3TYW
 CBU0+TpFoUeRu9P+5/UEpKuIDvc5ElCBnpqnPOs47UBlEcZg5i8+opy1bs8DgTH2t+mu
 3NZH8vHp9zTAvrYv+BSampS876WgeiXQKZU9VogaPG7dsdazHxJYX17vUjiN7lXG0DwQ
 qmDA==
X-Gm-Message-State: AOJu0YxhNLRLn//ID2y37wo7aOSZouKgX/RKlk8m7MjQJledGpYwQ5hz
 UF9yOtXvJmSGOwLYqSNvrFt4m73u8oFS+WRa985ywoiKfgftqdrBWWNIP0vUdOwcDxW1K94WA78
 VSOgo8g==
X-Google-Smtp-Source: AGHT+IEyb25McYMvrW3rqcLBYUwMot8hsN3jsRloMUlWESnlOxnwBjaK/wFIbM8yxRBNRkYTWyLFkA==
X-Received: by 2002:a05:6808:2f0c:b0:3e3:9a29:c6f2 with SMTP id
 5614622812f47-3e6244e663amr1160317b6e.6.1729649405183; 
 Tue, 22 Oct 2024 19:10:05 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.172.41.198])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeab5839dsm5861849a12.47.2024.10.22.19.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 19:10:04 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RFC 0/2] migration: Skip sync in ram_init_bitmaps()
Date: Wed, 23 Oct 2024 10:09:49 +0800
Message-Id: <cover.1729648695.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

As discussed in:
https://lore.kernel.org/qemu-devel/ZvbQ0RQx-zxOeo4Y@x1n/
RAMBlock dirty sync in ram_init_bitmaps() appears to be unnecessary;
this patchset attempts to eliminate it and asks for comments on how
to do so.

Please review, thanks

Yong

Hyman Huang (2):
  accel/kvm: Introduce kvm_dirty_log_manual_enabled
  migration: Avoid doing RAMBlock dirty sync in the initial iteration

 accel/kvm/kvm-all.c      |  2 ++
 include/sysemu/kvm.h     |  8 ++++++++
 migration/cpu-throttle.c |  3 ++-
 migration/ram.c          | 30 +++++++++++++++++++++++++++---
 4 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.27.0


