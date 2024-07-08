Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A5FC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 07:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQixB-0001qg-T3; Mon, 08 Jul 2024 03:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQixA-0001pV-C6
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:38:28 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQix8-00022A-Ds
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:38:28 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so3412498a34.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 00:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720424305; x=1721029105;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rCSY0W9iL+t61dd1Hlu0W2EubsIgvsOQqg19HIV4E6Y=;
 b=fFv1UFGKg25MdLtY5f4VOV81hJG3NJrR3l0wYmjV7MBBCNUNj1+8BV4i79ZjObH2rd
 mP4rZrLhlVVYKukQh0eMXK3qMF+XLLGyzsUNnl/a/RE9Ss2AE+MdhHNsMGmVKqIq91mM
 SHTZdhWQvioQED77fe6tyQQjUWTcbHEyquVT8MpBjA5T7ZUPp0WjXJCREfO+kYCKGuMG
 Fg80MdSCJ7VgKUuR3L+kA8BhuqKXErTIEnRK6dZnyOWT9zRBFfbVQye/KnRtmefWRbCe
 7l1aQfLVZ+tGpNFD4WMetofBVD1wRXFVSEZJ7/lLOetbbCSVSKckQIrjGNJ8+cO9E2bv
 OCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720424305; x=1721029105;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rCSY0W9iL+t61dd1Hlu0W2EubsIgvsOQqg19HIV4E6Y=;
 b=b7urLhCfiHJ2b3LcXHSyy+Z/0hN2/1UpPeqSy23q53a5P1eoP+nB19pzvbXphPouTk
 zqt61sUA1Ls6AuCJnZfjB32KzQsZ6ZUNXqqet+61ChMe8rqiH2sBZHe95/OeGUOG+zsU
 1z+heRE2+gZ5B13IGekTCvVepAnA9C4991XATIBcTxAyZXVbapsN8ng+LmkRSkHJN8Yf
 X1osXx/DFdRyj7dUcmPJGkOILaxyXRrl9Z27K98O8B9H/5uX/jLZSKToTbc2lxBvWuYv
 rmbrDkYxCq2L/LaoMUQ3x5it3oGy7CY37XReD4oDCu6gKC+/ofi7JwT6+HSg4o4CPl0N
 ncUw==
X-Gm-Message-State: AOJu0Yw+s7gn2iLTnawjqEQaYIsg2Z3bT4viYPZ63qvjU1M6EAKC4v6m
 D7fRNb+2fUt3ArbFRfp5dT2WqZXBkH3p5p2AKPHYVpx4Ht8G05ldFddvE/y1w7o=
X-Google-Smtp-Source: AGHT+IHQc/SYMTQeOQAgrEZO0dnEbkqDCWnieruKNDhoF89gfAVrQtLOiOWmZ4JL7t24PBr5V6Pw8Q==
X-Received: by 2002:a05:6870:1496:b0:254:a881:cec5 with SMTP id
 586e51a60fabf-25e2bf1e319mr10813428fac.53.1720424304842; 
 Mon, 08 Jul 2024 00:38:24 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b0c9b8573sm5895030b3a.191.2024.07.08.00.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 00:38:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/4] virtio-net: Convert feature properties to OnOffAuto
Date: Mon, 08 Jul 2024 16:38:05 +0900
Message-Id: <20240708-auto-v2-0-f4908b953f05@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2Xi2YC/13Muw7CMAyF4VepPBNkW+UiJt6j6pAmhnqgQUmJW
 lV5d0JHxv/o6NsgSVRJcGs2iJI1aZhq8KEBN9rpKUZ9bWDkFlu+GvuZgxkEvUNC7+0J6vUd5aH
 LznR97VHTHOK6q5l+6x+QyaC5DEjMdLbEePd2nXQ5uvCCvpTyBecoON+ZAAAA
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x329.google.com
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

Based-on: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
("[PATCH v10 00/18] virtio-net RSS/hash report fixes and improvements")

Some features are not always available, and virtio-net used to disable
them when not available even if the corresponding properties were
explicitly set to "on".

Convert feature properties to OnOffAuto so that the user can explicitly
tell QEMU to automatically select the value by setting them "auto".
QEMU will give an error if they are set "on".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Added patch "virtio-net: Remove fallback from ebpf-rss-fds".
- Added a compatibility property.
- Corrected property type name.
- Link to v1: https://lore.kernel.org/r/20240428-auto-v1-0-7b012216a120@daynix.com

---
Akihiko Odaki (4):
      qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
      virtio-net: Convert feature properties to OnOffAuto
      virtio-net: Report RSS warning at device realization
      virtio-net: Remove fallback from ebpf-rss-fds

 include/hw/qdev-properties.h   |  18 +++
 include/hw/virtio/virtio-net.h |   3 +-
 hw/core/machine.c              |   1 +
 hw/core/qdev-properties.c      |  65 +++++++++-
 hw/net/virtio-net.c            | 278 ++++++++++++++++++++++++-----------------
 5 files changed, 251 insertions(+), 114 deletions(-)
---
base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
change-id: 20240428-auto-be0dc010dda5

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


