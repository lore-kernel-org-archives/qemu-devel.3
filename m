Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92023C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrWl-0006u2-1V; Fri, 30 May 2025 00:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrWi-0006tS-Qb
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:39:28 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrWh-0006ru-4g
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:39:28 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2351ffb669cso9117405ad.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579966; x=1749184766;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sFnEkxpqDtfzprFYZUgRLN1d2YY75A42mlPHJtM+n4U=;
 b=j0x7us4BI421Pgkklfp9P0nvl5Fix61Gvcj0wAP4tIDryBHOOoWNN6oVjTic0q8z0n
 nhWenctsujeQurbGO+8ngxUSR2HFEv5ZAgpoh7u+j80m1129Mtmeri6xGuNnqpc6SUQ6
 CkD5l/oG33P0ysqsJk0T7jdyGhEmrqb0hH6GiNEXQL7ifziDZjVx7XgoxXbSmvQSibp5
 /W3EY+ZHWq47XJuSIIJhD1dzGMW8BIZGC6kxysW2o6W5mJOCOK1JYZvh47erBIyNRB7R
 SlOxmAdB28P/mVe19gThu6bToo1rk1ZLL8ShcsK+Kgs8Nis1HBt6S47WLuhpcEVRsAVd
 Xd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579966; x=1749184766;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFnEkxpqDtfzprFYZUgRLN1d2YY75A42mlPHJtM+n4U=;
 b=oCqzNzThn7zIp2/4p+3bqMA5slBIwPkzJHVIewYcTNwVbzstdXBZpFvXlqnygXwtk2
 e6ImuPW5Su2jAs9drOnewpJvCQUEBb2/L2c2t5IGCeKFgftSys78QFld6UY8qr9hqtSP
 Yo5h71yR22MFNkqBdfeCFe/Blgd4/2EZoEY8boQ2QEitAlZKR7VYUoEj3ONfUBPfjikP
 esUGXXqtI/fWLKpgISkrh5sL5R/qaeZg5sSrNvbAb4j0aX0HgoDpgpX14EF62hZjkH1V
 HY2VQCz0QU3xMOc5PIhQrKub1y8Z/s7mBt4XY/nKyhwK7s1i8EsPJlT1KeOJp9epeorV
 vfOQ==
X-Gm-Message-State: AOJu0YyjidMURtHrNXjgME8ReNYHmtJdzlLBIf1Jb+aOGhnULCkBqDSP
 yhwFixqdTmisJ5WGOdjNAHlV8dN1/GY28jw3fyrgxWzF+vSeuVr6FUayRRSI3zJ5KXs=
X-Gm-Gg: ASbGnctwwR1AB3MnTUv/SdXtKKq3TE/rVrQV7xbfo3I8uqXOm4EenV3InbjZqJvHRuo
 eKDq6I8o8py+vfJ34Cm3Fgjjb1dtmdRU38COZMs7xVip9CaefQj9inAAQhJ9DD2/Pc5MOssFDKA
 uAt1vHnLzHaX+IHDBQiYx5r7VDpi7ckuHdGf33hyXuFP9XgqrdcRBaPfhqV5MtlwlqrfOUz+9ol
 /DtboA3D/is2xQvz3Y/Krh4NfwQVXsFzBW+LMfXupxUygZOwXFM38xuNHCWSoP8whe6ePmw5YSg
 quJZuusWcxjgzde8zwxpi6NDQlgWBWY9WE9cTFVn+ErNOz5Ysnw/
X-Google-Smtp-Source: AGHT+IEogidMLUTfTLR0ZTlwZY1Bv4DYR5+sXt9zklUm7IoGd+1UwSQf9/gZzC3A+sUjaxtqYD9InA==
X-Received: by 2002:a17:90a:d2cf:b0:312:1c83:58e7 with SMTP id
 98e67ed59e1d1-3124150d60bmr3061450a91.1.1748579965684; 
 Thu, 29 May 2025 21:39:25 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3124e2e8e4bsm355921a91.23.2025.05.29.21.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:39:25 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:39:13 +0900
Subject: [PATCH RFC v5 5/5] docs/devel/ebpf_rss.rst: Update for peer RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-hash-v5-5-343d7d7a8200@daynix.com>
References: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
In-Reply-To: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

eBPF RSS virtio-net support was written in assumption that there is only
one alternative RSS implementation: 'in-qemu' RSS. It is no longer true,
and we now have yet another implementation; namely the peer RSS.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/ebpf_rss.rst | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/docs/devel/ebpf_rss.rst b/docs/devel/ebpf_rss.rst
index ed5d33767bd5..739d0259a168 100644
--- a/docs/devel/ebpf_rss.rst
+++ b/docs/devel/ebpf_rss.rst
@@ -7,9 +7,21 @@ eBPF RSS virtio-net support
 RSS(Receive Side Scaling) is used to distribute network packets to guest virtqueues
 by calculating packet hash. Usually every queue is processed then by a specific guest CPU core.
 
-For now there are 2 RSS implementations in qemu:
-- 'in-qemu' RSS (functions if qemu receives network packets, i.e. vhost=off)
-- eBPF RSS (can function with also with vhost=on)
+For now there are 3 RSS implementations in qemu:
+1. Peer RSS
+2. eBPF RSS
+3. 'In-QEMU' RSS
+
+'In-QEMU' RSS is incompatible with vhost since the packets are not routed to
+QEMU. eBPF RSS requires Linux 5.8+. Peer RSS requires the peer to implement RSS.
+Currently QEMU can use the RSS implementation of vDPA and Linux's TUN module,
+which is currently being upstreamed.
+
+eBPF RSS does not support hash reporting. Peer RSS may support limited hash
+types.
+
+virtio-net automatically chooses the RSS implementation to use. Peer RSS is
+the most preferred, and 'in-QEMU' RSS is the least.
 
 eBPF support (CONFIG_EBPF) is enabled by 'configure' script.
 To enable eBPF RSS support use './configure --enable-bpf'.
@@ -49,9 +61,6 @@ eBPF RSS turned on by different combinations of vhost-net, vitrio-net and tap co
 
         tap,vhost=on & virtio-net-pci,rss=on,hash=on
 
-If CONFIG_EBPF is not set then only 'in-qemu' RSS is supported.
-Also 'in-qemu' RSS, as a fallback, is used if the eBPF program failed to load or set to TUN.
-
 RSS eBPF program
 ----------------
 
@@ -67,7 +76,6 @@ Prerequisites to recompile the eBPF program (regenerate ebpf/rss.bpf.skeleton.h)
         $ make -f Makefile.ebpf
 
 Current eBPF RSS implementation uses 'bounded loops' with 'backward jump instructions' which present in the last kernels.
-Overall eBPF RSS works on kernels 5.8+.
 
 eBPF RSS implementation
 -----------------------

-- 
2.49.0


