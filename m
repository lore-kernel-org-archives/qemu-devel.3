Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A70FCD11DD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 02:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpIfN-0005Yk-2l; Tue, 26 Mar 2024 22:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpIfL-0005Yb-Gg
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:05:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpIfJ-0001wp-Ow
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:05:23 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e0d6356ce9so19733715ad.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 19:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711505120; x=1712109920;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IMrQNjap7NimL/Y3bzDVmCVdabyr6HixObY1Am7sLmQ=;
 b=r2WHCXaE2AwgvTkCAIQXlzKqQ3CyJSUc6dO3npLYSVEL9Gv8oQy9VWGhbnRo56GvrD
 swYBGcKT+hG/4iWNWhtonQmuLqGt74oHmHA50OdHXpwjZ1Ot8M9eYiqVC4uBu6HQHH4f
 GDoGoVvgGkooM4eI1srO+EI8gV1ZeHk0/QU7ZjuZ2EZAhCQCsV7VHPrlhCDsVotRFQ+/
 /gb1kFVJdGj8o4SutS0z+rLdad/cXzzUibgW6Vhw4hNhwCVjvbtpzkLOQDZeJurVnry1
 ljPtZNZ996944eorw5NN5FYe3RKruwN6jDo4cKysql5AfHNaEN7mkkRgLYtKOPTMxWok
 PJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711505120; x=1712109920;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IMrQNjap7NimL/Y3bzDVmCVdabyr6HixObY1Am7sLmQ=;
 b=rvVUPye+dYVedJ+UgBiCXdPGKYiNTfvkdt+MY8T/hTWKmo9lt4C4iqdTV+ufRUOD2R
 PfOC9u24du6yM9nO6lhchThgg7YTAH6sv6+0UvHAbFCBKyBscFpos9X1cAKVKqY4XO76
 39YfDyINP4Mv5W/3cW+q8ud0uPDm0mWnjflo0+Mn3XZVevZ2OeZoy9DCabkpje1YmeM0
 DR4f4cHeXhcgLcwyeuwpVg1JbBUeYajawp/oi3Rr/xeychcAcu3A0XxBeFE7OYXgPeCd
 ztPu9cr+gFVtc6VtcQlk/Giqc7TibU1IuH48fGmn7MsIsTwnnDYaMebMu62brO4MdHqv
 itbA==
X-Gm-Message-State: AOJu0YwCi7c80px5KOjlAwATrfZqQ3TExdza2dD3ylg/jJYELZMot0+r
 8psRMiw0Y96XsbDaz4Eu3KGX0+a+MwTSUUHdHZdDwo0/m5hcVf1R2sPwzGBfQtE4Mpq+QYRGxFp
 U
X-Google-Smtp-Source: AGHT+IEMFSO6vnjHmM7/ccWb+bJqpcAY0zdV2BcTmHeUzyRblLKQ9wECtsK12LgRuW2hXo27AUhUaQ==
X-Received: by 2002:a17:902:cec3:b0:1e0:b76b:cfb8 with SMTP id
 d3-20020a170902cec300b001e0b76bcfb8mr10411766plg.19.1711505120034; 
 Tue, 26 Mar 2024 19:05:20 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 p7-20020a170902e74700b001e0b5d4a2a8sm5639770plf.149.2024.03.26.19.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 19:05:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/2] virtio-net: Fix RSS
Date: Wed, 27 Mar 2024 11:05:08 +0900
Message-Id: <20240327-vhost-v2-0-0a89aa21b54b@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANR+A2YC/zXMSw7CIBSF4a00dywGrqWpjroP0wEv5Q4EAw1p0
 7B3sdHhf3Ly7ZBdIpfh1u2QXKFMMbTAUwfGq/B0jGxrQI49v2DPio95YdLhYEaFVkkF7ftO7kH
 r4dzn1p7yEtN2sEV8178w/IQiGGf8qu0otdAKzWTVFmg9m/iCudb6Aahr+0ybAAAA
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

Some recent changes made RSS unfunctional so here are fixes.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Fixed a potential problem with big-endian hosts.
- Link to v1: https://lore.kernel.org/r/20240326-vhost-v1-0-09bd85b1ba2c@daynix.com

---
Akihiko Odaki (2):
      virtio-net: Fix vhost virtqueue notifiers for RSS
      ebpf: Fix indirections table setting

 ebpf/ebpf_rss.c     | 9 +++++++--
 hw/net/virtio-net.c | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)
---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240324-vhost-5e26c8a2da5a

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


