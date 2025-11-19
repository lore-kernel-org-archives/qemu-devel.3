Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C560BCF31AE
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgXa-0002qx-BK; Wed, 19 Nov 2025 06:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXX-0002qG-4m
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:39:59 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXV-0001tE-Cq
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:39:58 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso2748105e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763552395; x=1764157195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p9AizpaX4sVdo9wOuyFetTfOXb+TgZzExlLqjEkh1s4=;
 b=KyotmqHaD9hz/i3STBa/TcefvJZzfgrlnqA0AbSifum3S2e/2NF4q3C4doh1BV5OqQ
 ZXKYx90ON+FxWf8JZwEnUkHfc1K/K284rb6GIPTmkyQKyv27YVK3u4JXMQtJShH79k1s
 G2vUiBjzsACfYoIq3H+2Kr3tpFurtmLAyz2Ury9QwBD4KKqSDs3cz/+xkP2aefeit9mD
 Lr24o2p6xPHXYdFd6YI2IMqT4fc6qL25axR8JyCkVcZ4Eh2f3r5cFq72mrjBZglpBwLO
 uabIJEmDpEUfsd2tcNG/zyJLBqx2cbB98rPD/nLQPLLVTouJH3UkTmP9vhQNMY9CjHaX
 nEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763552395; x=1764157195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9AizpaX4sVdo9wOuyFetTfOXb+TgZzExlLqjEkh1s4=;
 b=KRw+K3gGaVLpBmL7oiOL5Rkc08ELigRXqg7q/CnQdxfQVhhPLjJ5T48M7yS0ocA0UE
 L0kmviOz4W10bLRuSgAEvEKdB8XF+uomcSxYGPAHRX/9GaRQSDSi2F0bhSgUSB39+cEA
 6HuyKFfLxog0azXBCEJG0ya3xnG/rzNKxwdlbEKJyLmqg72cdzxd0OZJcQehRKjbwSOd
 jHb9s+WrqZw07yk5WWiecjrRh/cRXmeFT6lEcxeqFrx9MJS/YW/iYrL3zlCUzzKGctm1
 IhidIN0qUG/oQFTksR9C/UYzVFhzyV7UV94FNJpGayVrWpqk+yh9m+4tBaRrqPUpXkna
 0APA==
X-Gm-Message-State: AOJu0YyplBzKAQ4LNQuq6v+kM0oVEmMTJ5rIk0IXMA5yN8eoX/+osf0x
 usk69NSp482kPokr6MgIR3TR2+KNtyCjnutsn3FfrcjyHcrzKRbU8zn96U1oUHvaPbAi8FWvGVO
 4CsyK
X-Gm-Gg: ASbGncuJy4YBYl8vuSBXoBgf0Wso+8sFIxmes1KDEZZZXTuopzdVcoOsJwoizYkwqdr
 ieiyNorKT3jNNikM2vifjMg7kpJtzR1nus7Ea6bLzNG+Cmh7g4O2s31JXINFyUO2k9G8GeSWU2H
 Ox4TtKCJZPkbTuEejKuyf8S9xCX6v0XkwxUEjPoadaT8js71IONnK2V+ovTqSu0CMcUz3qcFRnE
 dOqQAfSx7l8qIiZO4YNbaYysvZ5xMM/hJ/evd1TOEpFR5bUKS9WP8V8/YIZpvhDmNpQKMgkgdQv
 1jB9TlI15e/cTvB3GbOOBSbn9qaYBZ97AzhRSRWVPLQu6FvOyjq14z7yaH7gjwk6L2NrZXPJjf8
 c3G//M4T2NFXEwQnoZSFPM8mfRsv4U4z2KI5SrIR0VmkjKV2RSS5wvjTspdpVsS3VOsm/cpRn3N
 k5Ct7iZlv0fueN0KhSgN7KGA==
X-Google-Smtp-Source: AGHT+IEoFShTOvldW61QB80A0j4h1Ztn8sXXqY2ZF6su+hUZ65xKuNOe6OuiWFWsMYIYY5vGSv6+Jw==
X-Received: by 2002:a05:600c:1c87:b0:477:a1bb:c58e with SMTP id
 5b1f17b1804b1-477b18c1aecmr25530405e9.7.1763552394953; 
 Wed, 19 Nov 2025 03:39:54 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e84a4fsm37418602f8f.11.2025.11.19.03.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 03:39:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 52D605F83E;
 Wed, 19 Nov 2025 11:39:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/9] gitdm metadata updates 2025 edition
Date: Wed, 19 Nov 2025 11:39:43 +0000
Message-ID: <20251119113953.1432303-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

As another year draws to a close I thought it would be worth checking
the current gitdm mappings and if we are missing anyone. As I didn't
have much time to go internet stalking in LinkedIn so most of the
non-corporate emails have been added to the individual contributors
group. As usual I'll only finalise those when I get acks from the
individuals involved.

I've added a few group maps to account for known company hackers using
different domains. With these changes the contribution profile for the
last year looks like this:

  Top changeset contributors by employer
  Linaro                    2969 (37.2%)
  Red Hat                   1893 (23.7%)
  (None)                     493 (6.2%)
  Intel                      315 (3.9%)
  IBM                        281 (3.5%)
  ASPEED Technology Inc.     231 (2.9%)
  Loongson Technology        227 (2.8%)
  Oracle                     187 (2.3%)
  Nutanix                    133 (1.7%)
  Academics (various)         99 (1.2%)

  Top lines changed by employer
  Linaro                    110080 (31.8%)
  Red Hat                   90792 (26.3%)
  (None)                    25410 (7.4%)
  IBM                       12750 (3.7%)
  ASPEED Technology Inc.    11811 (3.4%)
  Intel                     10608 (3.1%)
  Oracle                    8574 (2.5%)
  Loongson Technology       7614 (2.2%)
  Nutanix                   7404 (2.1%)
  Microsoft                 6927 (2.0%)

Thanks,

Alex.

Alex Bennée (9):
  contrib/gitdm: add a group map for SiFive
  contrib/gitdm: add group-map for Huawei
  contrib/gitdm: add group-map for Microsoft
  contrib/gitdm: add Nicholas to the IBM group map
  contrib/gitdm: add University of Tokyo to academic group
  contrib/gitdm: add mapping for Eviden
  contrib/gitdm: add mapping for Nutanix
  contrib/gitdm: add mapping for Qualcomm
  contrib/gitdm: add more individual contributors

 contrib/gitdm/domain-map            |  3 +++
 contrib/gitdm/group-map-academics   |  3 +++
 contrib/gitdm/group-map-huawei      |  5 +++++
 contrib/gitdm/group-map-ibm         |  1 +
 contrib/gitdm/group-map-individuals | 14 ++++++++++++++
 contrib/gitdm/group-map-microsoft   |  8 ++++++++
 contrib/gitdm/group-map-sifive      |  5 +++++
 gitdm.config                        |  3 +++
 8 files changed, 42 insertions(+)
 create mode 100644 contrib/gitdm/group-map-huawei
 create mode 100644 contrib/gitdm/group-map-microsoft
 create mode 100644 contrib/gitdm/group-map-sifive

-- 
2.47.3


