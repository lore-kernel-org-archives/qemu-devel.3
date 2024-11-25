Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2391AD58D42
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 13:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZ1O-0002P0-7I; Mon, 25 Nov 2024 08:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFZ1M-0002ON-I2; Mon, 25 Nov 2024 08:20:56 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFZ1I-0005mJ-Jt; Mon, 25 Nov 2024 08:20:56 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7fc1f1748a3so1134612a12.1; 
 Mon, 25 Nov 2024 05:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732540850; x=1733145650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fm44R6TqVgX4bZzNLQ4CIktvVZnqRhLeoZNvH1sZIpg=;
 b=lEx0R4crY46XDqI5BV4kGdPfpbyd+e5VT4431vk+w+59b/6VR4DwoqiXIOKKCVH+B2
 UJ5uRh2qXjpBSEtWjWnaMYWnF14cPJNVXsKiIqS+daCz7cbk7thMkX7FeR8D1vFVnH7p
 ArAkrypoOB7MNfcRXvpbObKONCoNEDghO2qcC7M92A2UbVzQzFLoICEmGSAi/TTYgMNs
 JscRH72gdPylA3eHRBY9Ew4DtfrjvOhTSCW1qBZBWWposjVOPOyemZiZPtFXxHVM1i4x
 G23JKfgMtwCIgnqzZqICQ38+6CZY8JSdt4srABB/WDgmPmDvldw34Oe5ueMx6FnELrlH
 6j1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732540850; x=1733145650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fm44R6TqVgX4bZzNLQ4CIktvVZnqRhLeoZNvH1sZIpg=;
 b=Ea6yTGJ3A5Ajb7GLd1y6c+yJVLT31k2ovUv8aG9qIKf9v0sy9xwuxRiMEYreHqO/6U
 PdjQSHkU4iVGHi0oopAXUxxNRgSuz6Xp3VVDs+i1w/y+Z7peBtxME+jDeHhqCKbsv/Pr
 WlGTfjk8IVUgymLuTJC6umEueZUGz26IhK8gX0bJRlS1UH8RgTYR1nXZj8cWy3yc7viD
 dx6eKUammlST9UiLuSsO/pILRlWoD8Is5e9vLKAHFiRNZk4qrvlMwaPg0vBrNWF4kKwk
 yio71jkrAuq/Rnpg/NoKL3tk9g8DpBHBkJyPbq85Kq4oFiVU1kVN5gTFzegMqwOAb2tR
 Tkpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiAGTlfO6m8WFHGlrIqsrNv/5or/n0wE7CF1JRC5zp4FaNerHCiUy/3HMijEzHsq7MqRExEFGwCbcA@nongnu.org
X-Gm-Message-State: AOJu0YzcNgktbfXm/GkB1C2h/NvnXRYMLzdDYJdUK7FkkwSbFNl5wHuH
 LGnJBA1rnqoegKIsv2Qhe795vBXUtFjy2w0mwy8UW3oSHrFU2+DV1CI1TQ==
X-Gm-Gg: ASbGncurNs9eX72eJuoEGhVkl1rKoqCmC69eLT6LfFBEEQgByoS5JHYrg50RR08Z0zI
 XShVT0TK2NXw3yqJKlWHFUJEa6guVxzGb3pKtv/XhqzWFJa2KBnoCP3uQK+oOJeEGRJRaTp4v8m
 vrw2cJqtWZJAIfHlU6nYvtsMJPZ4IUWy1U/4H8QPVcEjFDLj4aLIoRPmGwak2ceEgvbx9Yz6Kk9
 LHwLxiBzlGFKSLTwDoQWQO+NXjNWqfRU/x3XpDTSHbgDRIXmtWgoF1tZsAPA1rqaPOHD4rADojT
 w+OtNA==
X-Google-Smtp-Source: AGHT+IEqbmuYgSlCLw5U94NtvosuJEtzHz26AAQhu3qjzT9Ji1uSvdf3NyzqawIUw31pu1BssasVKg==
X-Received: by 2002:a05:6a21:7891:b0:1e0:d51b:10c5 with SMTP id
 adf61e73a8af0-1e0d51b129cmr261531637.20.1732540849534; 
 Mon, 25 Nov 2024 05:20:49 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcc1e44d5sm5616721a12.32.2024.11.25.05.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 05:20:49 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PATCH 0/4] ppc: various fixes for 9.2
Date: Mon, 25 Nov 2024 23:20:37 +1000
Message-ID: <20241125132042.325734-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Some small last-minute fixes that mostly fix recently added
or exposed issues. I'd like to send a PR with them for 9.2 in
the next couple of days unless there are objections.

Thanks,
Nick

Glenn Miles (1):
  target/ppc: Fix THREAD_SIBLING_FOREACH for mult-socket

Nicholas Piggin (3):
  target/ppc: Fix non-maskable interrupt while halted
  ppc/pnv: Fix direct controls quiesce
  ppc/pnv: Add xscom- prefix to pervasive-control region name

 target/ppc/cpu.h            |  8 ++++++--
 hw/ppc/pnv_core.c           | 11 +++++++++--
 hw/ppc/pnv_nest_pervasive.c |  2 +-
 hw/ppc/spapr_cpu_core.c     |  1 +
 target/ppc/excp_helper.c    |  7 +++++++
 5 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.45.2


