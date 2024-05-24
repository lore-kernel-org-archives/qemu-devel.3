Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3228EC25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 06:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAOSx-0005x0-VF; Fri, 24 May 2024 02:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sAOSi-0005vK-GN
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:31:41 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sAOSc-0004Li-0M
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:31:32 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f8e85a0a5bso516399b3a.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 23:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1716532162; x=1717136962;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EIjSEoWVH4esNJv6IvTXy07mt2zfK64u9q9SYI0qCnY=;
 b=E1Dewc4o/ajv5NKv69Zw2St54r8QNJ/X9bZH/ejuyNfWO6z+qXH6o9zX0TOStL5b31
 Onw9xWwnIHjv/oYE/2ec71hzI1Q+K6xRu7XwnwxAX12zOTuJiND0vE/81BlVEo7L0iiY
 Dr5FfWopJRtfZc6NMZkA/Hfh16jqdxJls1Liueor+WS8F38BfJqt2sIWa3WqHnVNaDge
 copu1tHfpdN8RyplMiFO19rlurwQXY2A3Ckvq/aGmbQgA5c58ODg/QAfZqL7HuNQ/bdQ
 5lyfj+7SH9XmIc9X1Ob8+Y0wOnkLPd4VDDrMU6m1T1AEA6w75aHcn/8XammoVFbJk56z
 s/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716532162; x=1717136962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EIjSEoWVH4esNJv6IvTXy07mt2zfK64u9q9SYI0qCnY=;
 b=Kpt5eWMjjWuQWyJe+4cyryovaQN7g0mUF2G2rmufgyn3OQVlFJtzxg2fHrQPWfRTMx
 /gHDcgrLiqcodAmuqkQUKHkXpNbeeheNJ1B6Rez//RRNm2SAblXS554EOeQtv9wgAcBR
 QMbLhaMFbVlRoVrFw18TseIu28Xv95EBf+H7rSc0nhDIcoA+G8No9uhq8bdfAMQX0CE7
 orOIReFs1OeUo/PtzVfvySFnK2BZfVX3f18CoJeFMvlAZR7ITIOxJOdiPMPXva0gESSi
 mugzEKoozKTp5DjQIegUgm5nFFIkooxD8B7yjRG/ne3bua1zNhUbLVz1edmQOOwOvwaR
 a6yg==
X-Gm-Message-State: AOJu0YzGpyGYzJ2KlqTT0HHS2X6QAn+UzbsyI7NbPz0y2993nylpKJAr
 VRqYGe7MbVgyyeKbYzSAqjGxGAGyupDq7GnypwDqB4q+i4yU6ZyPkhkH7lJhqU7gMI3L8rOLvJt
 Ba0Oniw==
X-Google-Smtp-Source: AGHT+IF4zz2k2A90S6uwhwRK86ykXBWuUT/FdDvOYnRepWwO+aIdU28gD7MszU3IBmtXjkKTE4C3mQ==
X-Received: by 2002:a05:6a00:2a07:b0:6f3:34c0:13c9 with SMTP id
 d2e1a72fcca58-6f8f42af798mr1211822b3a.29.1716532161373; 
 Thu, 23 May 2024 23:29:21 -0700 (PDT)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682274bbbe8sm497918a12.93.2024.05.23.23.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 23:29:20 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 yong.huang@smartx.com
Subject: [PATCH 0/2] migrate inflight emulated SCSI request for the scsi disk
 device 
Date: Fri, 24 May 2024 14:29:14 +0800
Message-Id: <cover.1716531409.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42e.google.com
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

This patchset refine the comment of ther previous series:
https://patchew.org/QEMU/cover.1712577715.git.yong.huang@smartx.com/

Aiming to make the review easier, please review, thanks.
Yong 

When designing the USB mass storage device model, QEMU places SCSI disk
device as the backend of USB mass storage device. In addition, USB mass
device driver in Guest OS conforms to the "Universal Serial Bus Mass
Storage Class Bulk-Only Transport" specification in order to simulate
the transform behavior between a USB controller and a USB mass device.
The following shows the protocol hierarchy:

                      +----------------+
 CDROM driver         |  scsi command  |        CDROM
                      +----------------+

                   +-----------------------+
 USB mass          | USB Mass Storage Class|    USB mass
 storage driver    | Bulk-Only Transport   |    storage device
                   +-----------------------+

                      +----------------+
 USB Controller       |  USB Protocol  |        USB device
                      +----------------+

In the USB protocol layer, between the USB controller and USB device, at
least two USB packets will be transformed when guest OS send a
read operation to USB mass storage device:

1. The CBW packet, which will be delivered to the USB device's Bulk-Out
endpoint. In order to simulate a read operation, the USB mass storage
device parses the CBW and converts it to a SCSI command, which would be
executed by CDROM(represented as SCSI disk in QEMU internally), and store
the result data of the SCSI command in a buffer.

2. The DATA-IN packet, which will be delivered from the USB device's
Bulk-In endpoint(fetched directly from the preceding buffer) to the USB
controller.

We consider UHCI to be the controller. The two packets mentioned above may
have been processed by UHCI in two separate frame entries of the Frame List
, and also described by two different TDs. Unlike the physical environment,
a virtualized environment requires the QEMU to make sure that the result
data of CBW is not lost and is delivered to the UHCI controller.

Currently, these types of SCSI requests are not migrated, so QEMU cannot
ensure the result data of the IO operation is not lost if there are
inflight emulated SCSI requests during the live migration.

Assume for the moment that the USB mass storage device is processing the
CBW and storing the result data of the read operation to a buffre, live
migration happens and moves the VM to the destination while not migrating
the result data of the read operation.

After migration, when UHCI at the destination issues a DATA-IN request to
the USB mass storage device, a crash happens because USB mass storage device
fetches the result data and get nothing.

The scenario this patch addresses is this one.

Theoretically, any device that uses the SCSI disk as a back-end would be
affected by this issue. In this case, it is the USB CDROM.

To fix it, inflight emulated SCSI request be migrated during live migration,
similar to the DMA SCSI request.

Hyman Huang (2):
  scsi-disk: Introduce the migrate_emulate_scsi_request field
  scsi-disk: Fix crash for VM configured with USB CDROM after live
    migration

 hw/scsi/scsi-disk.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

-- 
2.39.3


