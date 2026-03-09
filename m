Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB0DFCA168
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzee6-0002dE-Do; Mon, 09 Mar 2026 13:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzedy-0002bv-SC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzedw-00025H-CP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773078225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wxPpL/2OvWS2kdiXl3YJ7yUrERPcOkYkS5msBXAXGwk=;
 b=E+XZnTr8rRF+uZfCW5DFElvaqxqx5uZe2wnCkTwUw2Xkuni8u9mLUMgcocfA2EENyymcUu
 wvtuGpMYi1r1i2tAmaWcnuQ5IjcCll0vA1vMuMPStad+MSzl+CtCYtlMMEvY1u4uCMhYI4
 qK8QQwF1YHIhxTKF+/+n4tyX6Gwzpg8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-Ky09bxJCPtOaoebdXgiYZw-1; Mon, 09 Mar 2026 13:43:44 -0400
X-MC-Unique: Ky09bxJCPtOaoebdXgiYZw-1
X-Mimecast-MFC-AGG-ID: Ky09bxJCPtOaoebdXgiYZw_1773078223
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-485389bf0daso8974805e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773078222; x=1773683022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wxPpL/2OvWS2kdiXl3YJ7yUrERPcOkYkS5msBXAXGwk=;
 b=cpLYwI5LctD9K44W+Uuf3M//RmAspJpUYnePJwzzsOzFBWiMB8KN505ZWtaY4g9KFV
 agoADNxra+wvTC4Tk+R3Jpe5zLe51ID815ELpbYZKhTgrXWBI0/rE29tbvtTIuGkoheu
 y3FIji4Q9meUR7/swjH02tkusjT+s/PCtY9y4AGXkiW+Ij9iCUGxF9ykK2Atsz+kmv9q
 yBHqJ2pFqwBYvqSCml8yd0ebO28kFBpD89OioA15hjUuEDLOWP5F6XqeDpqovl3/xcDC
 N0ZdyOV1VO/M+wHSMFD9gWbpotcoHLp46lqVP34ESFEvvG+33BKa6YMNPTjR1zTx65ST
 pw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078222; x=1773683022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wxPpL/2OvWS2kdiXl3YJ7yUrERPcOkYkS5msBXAXGwk=;
 b=OK8pTVEpGHCE+aNzmAbg0uFcnEo5caN7Mk6izwy3qaFmexuKxHF10Vr7Y9DXzWmoe9
 E0OKVKd/un1YF9WHiG5RZ+RyVs9MINUXpVWz+oO8ih3c1MVKKL/X0d3t2cCid7FV5Du/
 /tfdV8XrWA3M1MX3wpKWo4j4ZZ3L/9dl5GgUwyS3SU1/i1GKXyNQWbJSpW5t08wZ7dWX
 x1ABfjMNJiM+9o8kXk3grcGFUlHfWagYXvBed3BK1CPRSmALvn6iBGNFYR5Tv4Rd+9UG
 a3BS8MqDHHu51OGQby7HlFTIzpo2bkK7/8skiY1kj3kUkxrs4VOO62vTGG9Hjz86wI83
 OQAQ==
X-Gm-Message-State: AOJu0YznHbNXUUIrSvqldp2IR/5wGdCCmY+zjXBWjRVdzwbkQc7dExXw
 /IUII2Zx3j9QJGwqIQ6MSMkQXGV/g67v5qbXC5LXW3DR4rT9vC5CnCGKykFJvHZHmv502Qo+yXa
 AwDS0+xZXTc+2pP4KCLQyXPHuQi8FQh9SUEJcEeezT7cW4fL4hDtCDMMsdcXczwEt0BTkuSCWH7
 UglGYh8m+6LVNJ1een4jVLdAZ2eED+SSJv+WV1Gv8R
X-Gm-Gg: ATEYQzy9yduv7xNijGc9ZYheM+5cco+4STiuxgXpEp5wqu9XuhjqSKYvo4gPzru8eL4
 EGkNDEiU5IEc1aNtQO88xcOaJ/YG2TgVsrZvuaw8B5slbFwJTMB0KCXRXF7WplRqJuZZZ8Hc3rZ
 h+eZ8IIMh4WzNQg9GHSKdaymWQ9CmV4qyeUg4tEQewWhLZRm6U2r32U1QXUkVBkVb/bvGKyF7Ks
 kuUA9A1K8/N2KCci2B4GZrU2ZRVJatVU0zWx2uRoMZWJZOv2jxDDolBWIoIHPYWkHyHBQndh+sZ
 5aOBhLkY+64YW7UTzZUA//xdXI6kLKHmdrMk/imR3cKwh5laFHXRf9pi32siQriol7ApAyjZ0TE
 owJB8YyXVknaBKbOfVe2T6hTpupqfSkpP7XGr7/rBx0cbnyk2m7KcGFH0PGl4rPCrDkqRkZYgdS
 QCiADmkcU5tHIb8AxmhV13qmaDjsw=
X-Received: by 2002:a05:600c:628d:b0:485:39d6:e305 with SMTP id
 5b1f17b1804b1-48539d6e3demr82934925e9.23.1773078222303; 
 Mon, 09 Mar 2026 10:43:42 -0700 (PDT)
X-Received: by 2002:a05:600c:628d:b0:485:39d6:e305 with SMTP id
 5b1f17b1804b1-48539d6e3demr82934465e9.23.1773078221741; 
 Mon, 09 Mar 2026 10:43:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541acea11sm6492625e9.7.2026.03.09.10.43.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:43:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] i386 and NULL pointer dereference fixes for QEMU 11.0
 soft freeze
Date: Mon,  9 Mar 2026 18:43:30 +0100
Message-ID: <20260309174340.52174-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 1ae4271ab8dbfbf5dc28b36baa7f3fd5fd2215e1:

  Merge tag 'pull-11.0-virtio-gpu-updates-060326-1' of https://gitlab.com/stsquad/qemu into staging (2026-03-07 11:22:16 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 6ef6a0f04e5ea10e5c9aa31de939e5dcdfe4a58f:

  whpx: i386: remove SIPI trapping (2026-03-09 09:11:38 +0100)

----------------------------------------------------------------
* hvf/x86: compilation fixes
* whpx: fixes
* xen-block: fix possible NULL pointer dereference
* coroutine-lock: fix thinko

----------------------------------------------------------------
Mohamed Mediouni (7):
      hvf: arm: unbreak the x86 build
      whpx: i386: do not enable nested virt when kernel-irqchip=off
      target/i386: emulate: LA57 fix
      whpx: i386: enable some more enlightenments
      whpx: make Hyper-V enlightenments configurable
      whpx: arm64: enable enlightenments if asked for
      whpx: i386: remove SIPI trapping

Paolo Bonzini (2):
      xen-block: remove NULL pointer dereference
      qemu-coroutine-lock: fix has_waiters()

Pierrick Bouvier (1):
      target/i386/hvf/hvf.c: fix compilation

 include/system/whpx-internal.h |   4 ++
 target/arm/hvf_arm.h           |   2 +-
 accel/whpx/whpx-common.c       |  43 +++++++++++++++
 hw/block/xen-block.c           |  41 +++++++-------
 target/arm/whpx/whpx-all.c     |  37 +++++++++++++
 target/i386/emulate/x86_mmu.c  |   2 +-
 target/i386/hvf/hvf.c          |  14 ++---
 target/i386/whpx/whpx-all.c    | 122 +++++------------------------------------
 util/qemu-coroutine-lock.c     |   2 +-
 9 files changed, 128 insertions(+), 139 deletions(-)
-- 
2.53.0


