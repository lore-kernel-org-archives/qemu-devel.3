Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE479C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoPp-0006Sd-Jj; Wed, 21 Feb 2024 10:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcoKq-0000nB-S9
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:37 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcnap-0001nl-3J
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 09:29:05 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e45bd5014dso1496205b3a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 06:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708525739; x=1709130539;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LOWeQZKkpHY3S/TYS2ARTLU2Fl4Tz5Q8QZ4qlJVZvWo=;
 b=pTVGWaMGCLDVEDpkEUDbHCtalKkHg9C8oySpDK9dAtCsdtSQkmkE3k/4MJBn2hF9Jb
 EWZYfq+FViAp83eHNQNaCxX/cs6oaydtWIksW2/e6xVcdlyyKNgfEOMPNilNg7bXlkDX
 92+ggRG+uuGzNf5YrwNShV5epai9XKXvM8l9G+uEi5SE8iuONxEd83tJv37q7ONk+HSF
 tkTNMsW6LD97ixbBZU0afLu17yVneVf1GfiEHVAnia6J0qnLASYwCTt7nn4RgAQXyr8+
 BuqvkyLlqNVIvLeD4USdvD40MMpovWBWS6SBTzZSwY0/N0TGlBAQ+swTaEsgpcaxAwRg
 eRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708525739; x=1709130539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LOWeQZKkpHY3S/TYS2ARTLU2Fl4Tz5Q8QZ4qlJVZvWo=;
 b=JAE56ZYeC6GbfwXgLmthD55n6HdEdsOVxXQORo3f5EonfbZBjYLBwY2Z4QDPoQXi1z
 RX3kJ7fcbnISqLcpHCoLAnA8gHJo+2zCwD5mHctyHg9BXzranQVLqecTA36Pg1h1eWIx
 WUEGSQhG02B3fKyrZDcoZYvhsFYwTNDx+gyaNP/NASFU/x9lMkO/fqP0r4rPua4v/2S6
 GudbBKre7/Acj+47DYn7y/FYCwvHWgkB+mAJoG0C74TokAzR03/j8hjlGcrUOQNUpIbx
 wn4ZkohuMDxM6/55cWgBdbQBHjJphoytVO5GzUs9XWDLer/rVeGzYHqSJkxS2c5vBbjC
 7RXA==
X-Gm-Message-State: AOJu0YyS9jqUngCugkwHgJcW3FjqP+sK/5xOZ6SbQqgMxVdb3P0gF9k+
 gWgUhIXC862jcO/4MZi1Ske4BLCN5ZLFWKnatxA3W/NpB60rweFL/lu5xonBphjCwtqzcAu7UB/
 nQGYgBQ==
X-Google-Smtp-Source: AGHT+IGmCzHur7OKSBq/9+wyemPDkdujuNVLB99HBhiKAvwXpN8P0dC+goSoZIHjYmjJy7piQYeOTQ==
X-Received: by 2002:a05:6a00:9a0:b0:6e4:7b27:2887 with SMTP id
 u32-20020a056a0009a000b006e47b272887mr6726614pfg.7.1708525738613; 
 Wed, 21 Feb 2024 06:28:58 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 p129-20020a625b87000000b006e4762b5f3bsm4480030pfb.172.2024.02.21.06.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 06:28:58 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v4 0/3] Adjust the output of x-query-virtio-status
Date: Wed, 21 Feb 2024 22:28:50 +0800
Message-Id: <cover.1708525606.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v4:
- Rebase on master
- Fix the syntax mistake within the commit message of [PATCH v3 1/3]
- Adjust the linking file in hw/virtio/meson.build suggested by Markus

Please review,
Yong

v3:
- Rebase on master
- Use the refined commit message furnished by Markus for [PATCH v2 1/2]
- Drop the [PATCH v2 2/2]
- Add [PATCH v3 2/3] to declare the decoding functions to static
- Add [PATCH v3 3/3] to Define VhostDeviceProtocols and
  VirtioDeviceFeatures as plain C types

v2:
- Changing the hmp_virtio_dump_xxx function signatures to implement
  the bitmap decoding, suggested by Philippe.

This patchset is derived from the series:
https://lore.kernel.org/qemu-devel/cover.1699793550.git.yong.huang@smartx.com/
Please go to the link to see more background information.

The following points are what we have done in the patchset:
1. Take the policy of adding human-readable output just in HMP.
2. For the HMP output, display the human-readable information and
   drop the unknown bits in practice.
3. For the QMP output, remove the descriptive strings and only
   display bits encoded as numbers.

Hyman Huang (3):
  qmp: Switch x-query-virtio-status back to numeric encoding
  virtio: Declare the decoding functions to static
  qapi: Define VhostDeviceProtocols and VirtioDeviceFeatures as plain C
    types

 hw/virtio/meson.build       |   4 +-
 hw/virtio/virtio-hmp-cmds.c | 702 +++++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-qmp.c      | 684 +----------------------------------
 hw/virtio/virtio-qmp.h      |   3 -
 qapi/virtio.json            | 231 +-----------
 5 files changed, 724 insertions(+), 900 deletions(-)

-- 
2.39.3


