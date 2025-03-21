Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861DBC28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 03:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvTF7-000321-MV; Thu, 20 Mar 2025 23:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tvTEz-0002un-CF
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:40:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tvTEv-0007pc-AT
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:40:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224341bbc1dso29743345ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 20:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1742528406; x=1743133206;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ROHQb7T2YGN96zBb98eOUrJ2ybHb6R4yei1nyh28JSU=;
 b=FnosAyxy0fgqo+HK9bcmfgtilz1HUFRk5vZKrsIHakN/lxPRlevMQqMsmwz187yBF3
 0hYy0Qy7lpXJWS9KytYFKThv7Zs0WO8HCcVQpp9swJg+OYsAk9nmEUiklYGaIw93HT7P
 GGM0AQOhxO+DAbgOp9u6M6k/SYfhyhIw2C+rlhqvNWKttoxQxuxgwl+WM/2O/5um0/v6
 +N0rYDJeX+4L7Qn980pft9QlJA2QXKobiiVlRtrI2s41Q1u/8iJ1B9wVceIyEAahIaj0
 gGyNLITN/XHwQwC53AD5LUipXwaxL45UhkpXdq7pAA0xTBoQ4rbJD7sqaRWccGCuuBSK
 NliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742528406; x=1743133206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ROHQb7T2YGN96zBb98eOUrJ2ybHb6R4yei1nyh28JSU=;
 b=cbuGakjC2MbJsW8TMntYud6HQDkyF34B4lA3MFXkTm7lKxG31UnwM5XaDzjRdqRY6s
 ZACiTQheIS4UNuMisREqRwZrnWHO2067NKg1sJwU+ym3eJJpBO4W26XFZHnEWB3h7gRa
 DPo4y867tCz99lRSPMSQuoI5MBzvnAsEjpuzSUkbE5ygvYEijxmorZ/sohU1zZatd2jQ
 QCoX3ZatFdEwCQQIAy+byS5uGVj8+NxDaE/nSSFknL2COkTBuKBuTfKS4WIlN0KWvN1X
 lUoKX3k8mRwfp1xvRei1iPegR3TxU/Q8d6ps9Ml3SnxoC8yx0yEe7ta38PjEb20xqhRk
 jmfg==
X-Gm-Message-State: AOJu0YwJCWSZnT1ySF4tLMvdiDG9dvkz6cgWHdhtufb8WtQIZ+MY6OHt
 d/g9StOINDNFx2JG42DFWok08Ug91mBOGw2axLd5goVhyca3dsP0HX4mjgH2HO+XUMEjFxAwSqV
 JZdvy9q1h
X-Gm-Gg: ASbGnctEYyEEqrWnPt5VHomtDC3fyYAOuEW6YeEB71JU/fHxmQ4o3HD2hlYbY8Odws2
 NjfXc5R1/UnRD8lKtHvvWOKG3y10116sHDLQH2YRhi/y1/a0SanxrDveqeChEV+Zi9yIHOaGPlV
 ALh+L2xJJYv/WAE1/fCtNCB1IRGt9x9yK5YsO1AYAdEiyKrN6zMuF9qAVizsdyiZoRhiMgqwuQf
 zWIXqDtJMt2RuM7EKVo7+5zMxzZp3huaHHOdyArQ7vrIyWqtHARSCBjrewrRuhi3Wms2lmlGJTm
 h3BLbqoPIJAZrnqCeif6rUJS27oRCwxDSCW75Ljrpxwpwbq7TWcF6Pm74bygChecUg==
X-Google-Smtp-Source: AGHT+IFommm0cbvYfXWIAQkH7jpGDVij84F4MALAf5C+XzqCKMWlIp3mXiw2o9hN99HdnDrI7tBaug==
X-Received: by 2002:a17:902:fc4b:b0:226:38ff:1d6a with SMTP id
 d9443c01a7336-22780c68a1amr30657955ad.7.1742528406171; 
 Thu, 20 Mar 2025 20:40:06 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.85.74.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811b8075sm6079725ad.128.2025.03.20.20.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 20:40:05 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, dengpc12@chinatelecom.cn
Subject: [RFC 0/3] Support live migration for qemu-vdagent chardev
Date: Fri, 21 Mar 2025 11:38:10 +0800
Message-Id: <cover.1742527956.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x629.google.com
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

Our goal is to migrate VMs that are configured with qemu-vdagent-typed
chardev while allowing the agent to continue working without having
to restart the service in guest.

Let's justify which fields should be taken into account for struct
VDAgentChardev.

struct VDAgentChardev {
    Chardev parent;

    /* config */
    bool mouse;
    bool clipboard;

    /* guest vdagent */
    uint32_t caps;
    VDIChunkHeader chunk;
    uint32_t chunksize;
    uint8_t *msgbuf;
    uint32_t msgsize;
    uint8_t *xbuf;
    uint32_t xoff, xsize;
    Buffer outbuf;

    /* mouse */
    DeviceState mouse_dev;
    uint32_t mouse_x;
    uint32_t mouse_y;
    uint32_t mouse_btn;
    uint32_t mouse_display;
    QemuInputHandlerState *mouse_hs;

    /* clipboard */
    QemuClipboardPeer cbpeer;
    uint32_t last_serial[QEMU_CLIPBOARD_SELECTION__COUNT];
    uint32_t cbpending[QEMU_CLIPBOARD_SELECTION__COUNT];
};

parent:
No dynamic information is generated. skip migrating.

mouse, clipboard:
The mouse and clipboard should be set up identically on both sides.
Skip migrating.

caps:
Store the negotiated caps between the client and the guest.
Should migrate.

chunk, ... outbuf:
The spice agent protocol's message transportation between the client
and the guest is implemented using all of these fields, however the
message loss can be tolerated by guests because the issue may occur
in the real world as well.
Could skip migrating.

mouse_dev, ... mouse_hs:
The mouse state can be reset after a live migration since the agent
working inside the guest does not heavily depend on them.
Could skip migrating

cbpeer:
Since the cbpeer would lose the data it references to if the qemu
clipboard data was not migrated, this field can also be initialized
after live migration.
Could skip migrating

last_serial, cbpending:
It is necessary for the agent to function after live migration.
Should migrate.

For the last_serial, saving & loading its value to make ensure the
client receives the most recent clipboard data from the guest after
live migration.

For the cbpending, saving & loading its value aims to inform the
guest that the clipboard has been released and is now empty in
case that the guest acts strangely while supposing that the
requested data can be properly retrieved.

To summarize, all we need to do is migrate the caps, last_serial
and cbpendings fields of the struct VDAgentChardev,

Please review, thanks

Yong

Hyman Huang (3):
  vdagent: Wrap vdagent_register_to_qemu_clipboard function
  vdagent: Set up mouse and clipboard after live migration
  vdagent: Drop blocker to support migration

 ui/trace-events |   1 +
 ui/vdagent.c    | 102 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 85 insertions(+), 18 deletions(-)

-- 
2.27.0


