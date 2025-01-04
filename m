Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7446E77197
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyuT-0006yA-8A; Sat, 04 Jan 2025 02:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyuR-0006xg-FB
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:49:23 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyuP-0001My-Qf
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:49:23 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2163dc5155fso177712865ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735976960; x=1736581760;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2h+Z6KGAocZY9ssdYDPG8vWiVaY52bfept3SN4O9ir8=;
 b=2m+1u19j/Y6iySfxi1jw2QNeKSOD/T9H7Di5y9RXhWvy3WlvXg/6Rpx1hekhg+K7b6
 BFeoE9Va3e2/hJpAvbWbpPOrwehfKR+UP7Q2tuj5OmvzDYx7teIpLROM94V/svGaxr8K
 K1L6uYDpEk/UA3WqDhJEVbV1bsIWEZOCTV8K1J0uuFjzadn5gFPqY6gMMusryz/1ykg1
 AlIInqKvEdvmYSfL313qSIQ7kgGfn70KkjCni8MYHJK5Q1/iW2yq8T/tjlQM0jhJcCc5
 a703Xaw2rYAeVtkd3Ul1Gi3EFAzxAE8irRxr2WsSYaptTrnqtuJ836pihb+m1zDVV1wQ
 oHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735976960; x=1736581760;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2h+Z6KGAocZY9ssdYDPG8vWiVaY52bfept3SN4O9ir8=;
 b=TeVg63HPdcn+mO89tKGrXHZpQ369WquLH9C3/Yhc3gHdheNBWy7npOL5Tcaf/GUfTf
 MPzB3lwCryhpF9t/CKw3NFtIq6jVQ3B+ikozdy3e7osRUL7w8KqTTog2heUyj2olXrYI
 DFanl5terb/lDU8D9G/QzNuaBdHK5bLj3SgFLnW032D7xC0U+omPM/lNnuJ7u6IJQHg9
 LvDF7FyQZq7bRubEgWPRxqV6NVruABwsgI2DTkHvaH27fhAc/5CgRTxHxFkTnleORiKE
 jOBiwHZq36rJD1gazNh4L3WG+tTNPYLQxcg9RAqr0gYR9ROtaineNb3rmPPIbXlhNuYr
 h0Xg==
X-Gm-Message-State: AOJu0YzvrIx/aIPq3By8tL3PTxtfjcglZ8vQQn9kgPgCXs2xdgwC/j4C
 R7cg8TsArksn4pvt4vThYYdsIs7veFklejjbO3+XDmj7VmaOLpzmpYL0UT3Jv0k=
X-Gm-Gg: ASbGncvTZ8XKa19RIYtMQuvTBRkBcjsV1GtjCAVnBYfd/phzlqlv/nG8u3V48xZvzor
 ZfK2Qikr9llYSNi1qFkB5HbOQ7JNu1UP3iSyZNtYtLDI8hJRjaAtgCAyqzIDCz75fbjlqCDlzJB
 fdLo/6wG2Tr10OJ0a1ealv+YokaqumZg5mI0YgO3LHYLiBhJ4PPgSSbjh7t2DYSn/HV+p0Ouj6t
 XDTkiMEG9FrhOM7Y1zOseWEAGb/G4EVm0W399YE1HwPaLMa9Blqf81LNoCU
X-Google-Smtp-Source: AGHT+IHuVkdnGW/DCAWvMEG5nSg480teyybHwod0XE11mxMngbq7GlMJkhBoDnqycIhxUm0Q5+sz5w==
X-Received: by 2002:a05:6a20:7350:b0:1e1:cbbf:be0 with SMTP id
 adf61e73a8af0-1e5e04a2f70mr98340197637.22.1735976960459; 
 Fri, 03 Jan 2025 23:49:20 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-842abd593bcsm25264710a12.16.2025.01.03.23.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:49:20 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:48:54 +0900
Subject: [PATCH v4 2/2] virtio-net: Report RSS warning at device
 realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-auto-v4-2-972461ee87fd@daynix.com>
References: <20250104-auto-v4-0-972461ee87fd@daynix.com>
In-Reply-To: <20250104-auto-v4-0-972461ee87fd@daynix.com>
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
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

Warning about RSS fallback at device realization allows the user to
notice the configuration problem early.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6b2104c6b68d..c6a8e6055909 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -829,6 +829,8 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         if (virtio_has_feature(on_off_auto_features.on_bits, VIRTIO_NET_F_HASH_REPORT) ||
             (virtio_has_feature(on_off_auto_features.on_bits, VIRTIO_NET_F_RSS) &&
              !ebpf_rss_is_loaded(&n->ebpf_rss))) {
+            warn_report("Can't load eBPF RSS - fallback to software RSS");
+
             virtio_clear_feature(&on_off_auto_features.auto_bits,
                                  VIRTIO_NET_F_RSS);
         }
@@ -1344,16 +1346,10 @@ static void virtio_net_detach_ebpf_rss(VirtIONet *n)
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
     if (n->rss_data.enabled) {
-        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
+        n->rss_data.enabled_software_rss = n->rss_data.populate_hash ||
+                                           !virtio_net_attach_ebpf_rss(n);
         if (n->rss_data.populate_hash) {
             virtio_net_detach_ebpf_rss(n);
-        } else if (!virtio_net_attach_ebpf_rss(n)) {
-            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
-                warn_report("Can't load eBPF RSS for vhost");
-            } else {
-                warn_report("Can't load eBPF RSS - fallback to software RSS");
-                n->rss_data.enabled_software_rss = true;
-            }
         }
 
         trace_virtio_net_rss_enable(n,

-- 
2.47.1


