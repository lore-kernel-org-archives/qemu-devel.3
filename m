Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D500C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 08:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVSDN-0000BR-2B; Thu, 01 Feb 2024 03:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rVSDK-0000B4-Oz
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 03:14:26 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rVSDI-0002nc-P4
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 03:14:26 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ddb1115e82so372813b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 00:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1706775262; x=1707380062;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sZwzO3aeV6BAnlQoWqpg5ecpqrNWv4Wx+AnkyR/LbMI=;
 b=DKjf5ncdujszvWvI0cl+WbWoZG+gYU6msbqy+KEJm813htfC+TVbESHkuq5xW3zDMy
 DhkUKMMDpfDABhEqm3eFWsCTyvn5vhEaeYk+ztOnZuZJebJ5u1FGUuhbCczEj6g6NR0X
 Qz1WS4XJch4IE1TUTdvqSbJT8nY3qFHDypklmHWMy3fSj8MdhbuJRuNpMlkZULoN0EmI
 3RTu2l9iZ9k3K8MQZBkO7GQkn4Wh0U8k9iQsn4d2427oXXPimcs1XIq32GEtwM58znGx
 DijEf50gdW7qiBMDFhK4i3DE7JnLys5ClE6WYjcrhe3ltdnuTTWt7/D0YyzRTNoI64M5
 78vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706775262; x=1707380062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sZwzO3aeV6BAnlQoWqpg5ecpqrNWv4Wx+AnkyR/LbMI=;
 b=Mk8eJOWBStUVMaRc3Su5I5jnvs3LOwuLIXlU7KoqhL+0Z+NRSAjk/uTB4yTVoflwxe
 DVnCGD0SoOn00Utu162kHhJLERQlQmI2az0NngtXeLsegLzKdIsnAZ37Gqi10ydzoniy
 q1C9iP2Cqcs5G7iet9TDmt/saqIhsRYdG5AzZZNYpPmWWj3wfjIj4OndOBEgYKLwNZN6
 Nsxtk3krSRjEw4FE6/no5dVtskXOewgVelMrcXF8bpPzpyuTA/IGesZTFRosPASeeyod
 JDZDMM6+q1pgnh/Kj39bgSDxHIWU181P0kmd1ieo3NxgoUjIv8CZBVrNjOnhSW1pqEhu
 gsQQ==
X-Gm-Message-State: AOJu0YxiqnOaSZNW+gLDmTeUuQh9hZdbvRQmmDFpgXzXXcuhEvPVlWh+
 9T2KAwGudayBfCvvC+5RSexPTrTgeO4v1GLB8TcJtQ7nsU97/ew1XebItPMQJDYwVPjUfxmd2PB
 E1Ps=
X-Google-Smtp-Source: AGHT+IE0/ncd1WBGwtpwtc1owk2TNc5GQBHuqJgH8eh2we2bmykLpwKYgHNBUMd8PCxP06qWTC82yg==
X-Received: by 2002:a05:6a00:70d:b0:6df:bb23:b8f8 with SMTP id
 13-20020a056a00070d00b006dfbb23b8f8mr4354235pfl.7.1706775262209; 
 Thu, 01 Feb 2024 00:14:22 -0800 (PST)
Received: from ThinkPad-T14-hirose.hq.igel.co.jp (napt.igel.co.jp.
 [219.106.231.132]) by smtp.gmail.com with ESMTPSA id
 38-20020a631366000000b005d6c208fbd2sm11943780pgt.35.2024.02.01.00.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 00:14:21 -0800 (PST)
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Subject: [PATCH v2 0/2] support unaligned access for some xHCI registers
Date: Thu,  1 Feb 2024 17:13:11 +0900
Message-Id: <20240201081313.1339788-1-tomoyuki.hirose@igel.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v1 -> v2:
* Improved the calculation of addresses and masks in memory.c.

According to xHCI spec rev 1.2, unaligned access to xHCI Host
Controller Capability Registers are not prohibited. But current
implementation does not support unaligned access to 'MemoryRegion'.
These patches contain 2 changes:
1. support unaligned access to 'MemoryRegion' .
2. allow unaligned access to Host Controller Capability Registers.

Tomoyuki HIROSE (2):
  system/memory.c: support unaligned access
  hw/usb/hcd-xhci.c: allow unaligned access to Capability Registers

 hw/usb/hcd-xhci.c |  4 +++-
 system/memory.c   | 38 +++++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 14 deletions(-)

-- 
2.39.2


