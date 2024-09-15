Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B182C35FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spdj0-0000u7-O1; Sat, 14 Sep 2024 21:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdiz-0000t5-NZ
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:06:50 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdix-00049e-Q7
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:06:49 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so1970201a12.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726362406; x=1726967206;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4bGD+HHT9hE1vC5vN+cFdhZQySMyDMT8fezz30sguFg=;
 b=mDZpjSDhCEHoJPCR55Y5xExGC5T0bExLysG4Qoj1a+PStjvcbuFCLBZwGJZsQkUMpD
 HEBoTg6YBL6wU/HE3qnZXRQoaBd0sksjrWLE4XLe/+lEpAModcMoy1cJ8C9bAY68O5yX
 jSxio3+KPxBQn3F6mSfB7bpiCPDg3IEXPr0gQGI8i4cUEBNj7T85w9mhN7QxCj2hErIe
 8mbEHKMSkBsOMUdCqwTDK0AZytV4N7pyYw7AnbvxwENe7kMQqnKzGY4IknHTwyCpmH1U
 vgnraHWUwVHGGuLONRR7gF9UCRy7oWMi3aL1s+jFx/G1j/qc5HMsoVVtckAtlo+MDrnC
 GCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726362406; x=1726967206;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4bGD+HHT9hE1vC5vN+cFdhZQySMyDMT8fezz30sguFg=;
 b=cmNF8VI6o1zye4sKZ1usDzzd6kGHArBbothss3XheS5mUVPUIBgyS6Uu1TUUikdNsF
 iTZ058ei2TS3lcTSbmwutyZtBQ9PQsJqyr4QiQ9ZKLT81iJXCISWWt0dKImfiTe8s7n8
 i++dZLKtvyiNQp53nNteW8fiJDkZz2HKeE/3NEU9szi/I4EcOKUbSntuVuOCEGXb5LEC
 9NGu+BvFq0l9eRjmRfsUoNJ5NTEtNfxZ6SVGauQ3TsZyGEuEto2fGlctqAVrssZBFi2/
 RsWV6IWSckxYCfQibhikWDxkNOXZfPlxFrnI8F212D/dlLFq21UJ49QjSoKUtle7uYfw
 KrAQ==
X-Gm-Message-State: AOJu0Yzow1aQI0VZYJk54hoDLKDBQBI4TGAF2opOvgG30JdoXFV704Aa
 KUuLe+4vFnc1Jpx66KT7rXY4fFmeIe09F/ZRfvmQ88mpB2JTmYcotRHKVoTnkXc=
X-Google-Smtp-Source: AGHT+IFZKa+kfAN6Dn59q+nSRWt+VamKm83Fkc8PZDy/DgFlDgYCzUR+UlDxblBzQsCXZAhp2Sh/3A==
X-Received: by 2002:a17:90a:8a8e:b0:2cf:c9ab:e740 with SMTP id
 98e67ed59e1d1-2db9ffc208bmr11350257a91.11.1726362405673; 
 Sat, 14 Sep 2024 18:06:45 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2dbcfcbb42fsm2218895a91.4.2024.09.14.18.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:06:45 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/7] virtio-net fixes
Date: Sun, 15 Sep 2024 10:06:38 +0900
Message-Id: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4z5mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNz3cLS1NJU3TQTI1NLY/NEc2ODNCWg2oKi1LTMCrA50bG1tQD3nl6
 LVwAAAA==
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 qemu-stable@nongnu.org
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
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

Most of this series are fixes for software RSS and hash reporting, which
should have no production user.

However there is one exception; patch "virtio-net: Fix size check in
dhclient workaround" fixes an out-of-bound access that can be triggered
for anyone who don't use vhost. It has Cc: qemu-stable@nongnu.org and
can be applied independently.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (7):
      net: checksum: Convert data to void *
      virtio-net: Fix size check in dhclient workaround
      virtio-net: Do not check for the queue before RSS
      virtio-net: Fix hash reporting when the queue changes
      virtio-net: Initialize hash reporting values
      virtio-net: Copy received header to buffer
      virtio-net: Fix num_buffers for version 1

 include/net/checksum.h |   2 +-
 hw/net/virtio-net.c    | 109 ++++++++++++++++++++++++++++---------------------
 net/checksum.c         |   4 +-
 3 files changed, 65 insertions(+), 50 deletions(-)
---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20240907-queue-f425937a730f

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


