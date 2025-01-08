Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC2BE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV3i-0005gj-Dp; Wed, 08 Jan 2025 07:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVUwS-0002cc-E2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:13:50 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVUwP-0007tf-M6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:13:43 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216281bc30fso30537845ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736338420; x=1736943220;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qMShpxxlgZk7ivSlzKAuGIG5z3yJv+Ts7KMBgEzCc+A=;
 b=gOmn7MC8W9FCrGtVfnPXA0pSgEVmFtU/vp07wgWLnBUFXwxwFJAKEiqY0sA3Y8PPXT
 CVEyxUmt30Qkch/McQFtfCsadGwEkk8iOCceZCJrGC+99JSzXiA97PqB551WIqDoT1B+
 353OgCMJXn0SzTZG+/rNNGAAuA401ZxQydxVeq1sefKCZJYPE+8A6yZHFo0SlrgTENws
 00O/c+QdnmQ8veEFUzEt9q3Dk4DMK8O2DYUOuopiKiYuLfmogT37cEcDfShXqitlb2VX
 dUy2iBo73i6uuwMzRANRvVTUet5Aqq5AH8eezCtSH31Q4f1zHt6+t5ftzE6pPVihcgKq
 2Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338420; x=1736943220;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMShpxxlgZk7ivSlzKAuGIG5z3yJv+Ts7KMBgEzCc+A=;
 b=FTv/031PduMbLjZ3ZjNDcDpzlvbG6D7jb4mL5sA1ELbvo5hTv5TURxAv7KM5KBL/Td
 05tuAhLOt9StU/ZFYxNUGJieBytgqUXsuwQ7Q6bBDa9dc6uhLZaQY+d++VnW5IMT2yFc
 tCD12m1mWuYSfP7oFBCwBJrivhGiyP1AesMNtV8oH/vXh0i1wiI3pmwmGpup8tChNRti
 pQB6UhKZyKO+CYhICnZgfVz28PNk5YXmU5t4aroYABNlrrqY2oHub9fEqbdM3X5OyJoe
 9yMK8VdprawEj60u0GN6ogY3m35fYSCYPQen3KcE+wfZ4MuPnTuRWDD3er1kztjkaUIf
 xa/Q==
X-Gm-Message-State: AOJu0YyxqEvdyfrkl5Ew7UQzub9LlqtlG7Z62YHC0+mv45BSNVV7osR/
 3yFMBuD1xPl5tM55J1SVnHlr/+rIKmU/JH/tAJNFTrXLMDGbPw2+5bvAPf/Tfxs=
X-Gm-Gg: ASbGncu5fUjKrfv5w2iQz7xS0kifizhehyGd61LFCRkqgUiUAo00s/vAKztv2U+dSYq
 nL8RP+3KJkDkX0kpWS2TQ6d/ifEBT09ZH0RtAR6ic0/i3KnVop/rWM8kZQdexH1YT41KuManmH0
 xvH9qUNRdhCuYpFbEs1qc0RXSfDcCrZq5hnCojVOK1AtY0OJoYCsZuIW/qQdh902DyVKlj0hWoG
 MYY3Tj2GKBFJaLTnfknLeLekueyfrYV2/G55KATSb/QjGkHhnov3n8+Ltg=
X-Google-Smtp-Source: AGHT+IHAi2cNp8BpVaGCtzaMkDvyuBW8eZwL5MYmrAr2CZyZZr5P69cSREB/fYOTTHlkHtJPIZn7Zg==
X-Received: by 2002:a05:6a00:6c89:b0:725:936d:4187 with SMTP id
 d2e1a72fcca58-72d21fcec01mr3812894b3a.17.1736338420286; 
 Wed, 08 Jan 2025 04:13:40 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-842b1ce01b8sm27462272a12.20.2025.01.08.04.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 04:13:39 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 08 Jan 2025 21:13:29 +0900
Subject: [PATCH] virtio-net: Fix num_buffers for version 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-buffers-v1-1-a0c85ff31aeb@daynix.com>
X-B4-Tracking: v=1; b=H4sIAOhrfmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIyNz3aTStLTUomJds6QUYxNL42QjC/NUJaDqgqLUtMwKsEnRsbW1AC7
 C18dZAAAA
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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

The specification says the device MUST set num_buffers to 1 if
VIRTIO_NET_F_MRG_RXBUF has not been negotiated.

Fixes: df91055db5c9 ("virtio-net: enable virtio 1.0")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 06f096abf678..b241cd4bb48a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1992,6 +1992,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                                     offsetof(typeof(hdr),
                                              virtio_net.hdr.num_buffers),
                                     sizeof(hdr.virtio_net.hdr.num_buffers));
+            } else {
+                hdr.virtio_net.hdr.num_buffers = cpu_to_le16(1);
             }
 
             guest_offset = n->has_vnet_hdr ?

---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20241227-buffers-6bd3493c287e

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


