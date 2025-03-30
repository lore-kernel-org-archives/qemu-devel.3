Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D09C28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 21:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyznz-00075x-RQ; Sun, 30 Mar 2025 17:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyznu-00075D-8D
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 17:02:51 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyzns-0007pS-Ll
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 17:02:50 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227d6b530d8so70032185ad.3
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 14:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743368566; x=1743973366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PNL+sq7ReZolDVsxymrfkswoHp0GBOU+QPgWgEqFXL4=;
 b=likGt/Ykhmqog2Gvz+VhgTkun0GeymYBRoo7U96XiSDB/z1W72KyBHn/7xSjEOL34d
 +B1wZ8sjhiQugcbTjOvs6IMCwWAsC/PhUK3EzSIPOe02OQtgBW9fN8I+WP8D949yqmjw
 gyNcpgYiVJ0ZbN/H7c8wAyy/l9YJMmCBfBLUqQy4aEureTI+w8exY9Del1IV6MzGc8Oi
 cpJ0EGX8Z1RRfozlEA21/UK3bky23tPHvIit33t1i5iANJXi4KOW9NO+kzdfmPdppGdM
 jQpzQNrOrFaJfqvIk3b4SX60e/42P1QgUJprcF5BF+Mtt/1c8U3pJQw58OO25TkS3BqE
 ta+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743368566; x=1743973366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PNL+sq7ReZolDVsxymrfkswoHp0GBOU+QPgWgEqFXL4=;
 b=T/XvN65sq5UedX3yPYUQoA8Fw5iO5gKpAET7uXvKJaSs8L+jl7pg9pl9XE4W+mrIiG
 ZUKMEO8vYXqCb8WR0UPv7UZn4MQVEXGQflYYDiv92yewjw3LSQMdcFNQxOiukYSMqKDO
 xjgUDX6ZEO2wp7BkQ7ztR+RmwWWxpdJyl1mZlwoFBRTk35mkR/1+Pn0d3jIVIe85jawn
 9iD0cMMI9dTTouLfZXkohh/n9wtGWwgzrD/rixEIfaGLYzhPllHfum3VvbyBruRp7pah
 7Nj+vs2RR+FBkuzrB6Y+q7WI0p+KdtSaCvJO0sCVCdDmc6F5hyxf2HHPL7uTX89xjMog
 B/rg==
X-Gm-Message-State: AOJu0YwW3EXk+7PAUwH0iY7BRpV8Qzb3pIWHcrntyQBilq3VO6z8zxsD
 qhKhPFy1tRpvdT9C8/pDwOOHNd5dRs7ASL1RvBhj/2tbMGyFMURhvcGEIZBOgrA=
X-Gm-Gg: ASbGncslnCCkRpaxx3Ms5rsmWWOs8mo7JqhPoc1gu253GQd8I6eb8BBxWGb8DhGLU5a
 UtXOvQEBGk1eabzjsZqBzeKNBDm1vyNxZZupKz1GWj3kVPqRyqzMt+6elBDftjSzCtgekMJhTG+
 Ui/gHtiCN10PayUAN7X5qAq0zGRO2LlNe19Js6b3NXoWO4zn11kbxfC5eLw3AqszXDy7CHk/4E8
 M6p2zuePJ4YM2eqqOrviKShpfdvj7nWLi6fY62IfmTUFY/0lleV7DEKoQY7IDRYj6P9CQGMLkDQ
 dE5HYdyL6ZrytlD90jArIG04CSwOaGyzmNLzY58omFsIhG0yMNs=
X-Google-Smtp-Source: AGHT+IFa+U54/pyPdM2Sn9OtmNcfJ8aMebUQgKLNYkShT2gyEr+m0MlEMRpleRaqPf1Kt2zLv9C+Hw==
X-Received: by 2002:a05:6a21:a4c2:b0:1fd:f8dc:833e with SMTP id
 adf61e73a8af0-2009f7785f7mr13311194637.30.1743368566123; 
 Sun, 30 Mar 2025 14:02:46 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:2018:65c1:9e7e:5b0:1e97:7aae])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b6a08f7sm5218166a12.29.2025.03.30.14.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 14:02:45 -0700 (PDT)
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org,
	philmd@linaro.org,
	thuth@redhat.com
Cc: pbonzini@redhat.com, balaton@eik.bme.hu, marcandre.lureau@redhat.com,
 rakeshjb010@gmail.com
Subject: [PATCH v3 0/2] GT64120 PCI endianness fixes and cleanup
Date: Mon, 31 Mar 2025 02:31:53 +0530
Message-ID: <20250330210155.74295-1-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

v2: https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06884.html

Rakesh Jeyasingh (2):
  hw/pci-host/gt64120: Fix endianness handling
  hw/pci-host: Remove unused pci_host_data_be_ops

 hw/pci-host/gt64120.c      | 99 +++++++++++++++++++++++++-------------
 hw/pci/pci_host.c          |  6 ---
 include/hw/pci-host/dino.h |  4 --
 include/hw/pci/pci_host.h  |  1 -
 4 files changed, 65 insertions(+), 45 deletions(-)

-- 
2.43.0


