Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B86BD5C0FB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 05:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9dZk-0006NK-NM; Fri, 08 Nov 2024 23:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t9dZi-0006N3-TR
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 23:59:54 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t9dZg-0000fC-9w
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 23:59:54 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e49ad46b1so2514681b3a.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 20:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1731128389; x=1731733189;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dRjhDPuuKRsrkljpAqH6ytUbaVBB6SVXyTI1N+QGL0U=;
 b=P3rypPH/m8TZ8oqAeDDDUrQy1U2El67rHhra6/cNdl79AZKcz6v7zXj3hy/Ev4Dzz0
 IHuym84DIK5G9YDctfbmsK4tk5Qn1eeQss3JXPbbm5tX9+w12B4b+vOVawomD1XO2yex
 cAN7dTKz2G4lYww22ouvg05feME86JJXc907tKaqrnEOJY9kK27otuQ770IXCSZ7fUUy
 PKgAvtUEWZvQ0BPpG4AKJgpzvoJjVkd4Rt3IbNaSPHR2smGjuvTO5/1wRyayfak2tGcz
 /nv8r5gJmIfIkD45wHznUTbsn19bIfafsO5dfpWgheoOCH4LOzANTqlz1gqYoqLlfCml
 mNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731128389; x=1731733189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dRjhDPuuKRsrkljpAqH6ytUbaVBB6SVXyTI1N+QGL0U=;
 b=kORpEaZ7mqUO+UVRv6/Ke7Lo8hMHE+NdCDMjwsav4nvYUISEtvE4toYofCCAd4anN3
 HZjR6vijlneDN3/LnfOGU8fTXNCudJyX7SmpiSnB3yuPw6kwgyq9Am9z6U6HHtHLz2+L
 M1nw0pPO94899oRyNL2YHgFI3IXa8CCSpn4Bgf6LT1snXcp40cqGghgpjGJAX55h4uYT
 12S5zt1fQH43rY/ipFY+2KK7cV6y1D8plloo8oPd+/rRhDo57VzX6lEJ8vzQyKM/6vZb
 IkDmKRnOWtsAwt7d0LV1w6zZ/IKkriFOPilJsBCzYV0xvZ8hka87d+KRkglHkh1MbvIZ
 iN+Q==
X-Gm-Message-State: AOJu0YxSPa7bA+dG3wXUojlXj45RHSrXg7NtbZT6sJyBwmzj2fwiVmwg
 R4pscHIkXbyEY6uoeOLv4SIHYEfyTcJulSKuokJUjADvOtbo4mory4hsWDtmliY/QkKfVqJibQn
 VkRLJ8w==
X-Google-Smtp-Source: AGHT+IFnXaDxl3W6Cww/oTHYQJuVcnnSdsv9Pqb5LJSUdFBTOXDbGdtXcpjXdvPRfXGEkP57YntIGg==
X-Received: by 2002:a05:6a00:3a14:b0:71e:6a13:9bac with SMTP id
 d2e1a72fcca58-7241312915emr8135605b3a.0.1731128388925; 
 Fri, 08 Nov 2024 20:59:48 -0800 (PST)
Received: from localhost.localdomain ([118.114.63.54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9ac8sm4718365b3a.79.2024.11.08.20.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 20:59:48 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Wei Wang <wei.w.wang@intel.com>, David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v1 0/2] migration: Skip the first dirty sync
Date: Sat,  9 Nov 2024 12:59:40 +0800
Message-Id: <cover.1731128180.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The first iteration's RAMBlock dirty sync can be omitted because QEMU
always initializes the RAMBlock's bmap to all 1s by default.

Prior to that, a pre-requisite patch was offered to maintain the free
page optimizing behavior.

For more details, please refers to:
https://lore.kernel.org/qemu-devel/CAK9dgmZSmoydJkFQP5VXfN21etMZc_bNq51R+if08F+NTApN_A@mail.gmail.com/T/#t

Please review, thanks

Yong

Hyman Huang (2):
  virtio-balloon: Enable free page hinting during PRECOPY_NOTIFY_SETUP
  migration: Do not perform RAMBlock dirty sync during the first
    iteration

 hw/virtio/virtio-balloon.c |  2 +-
 migration/cpu-throttle.c   |  2 +-
 migration/ram.c            | 11 ++++++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.39.1


