Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04ABD609A7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 07:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGCGM-0005AP-8M; Wed, 27 Nov 2024 02:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tGCGI-00058i-IW
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 02:14:58 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tGCGG-0002FK-Cs
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 02:14:57 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2127d4140bbso58154635ad.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 23:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732691695; x=1733296495;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EVxZHoAS0l6T6qHnkVAAH0XlqJRKaM6QoigOQruNJfQ=;
 b=vInYbGY0sTCgTcELBPha8l+nKXCXGtKg1NJfYSu90XeL9Ka4qAzWxXSE6+d+TM1QEG
 Nj3iXVtdqYAXH6fhyi8/1M2DRWHxL3OcpxHu4LEiQUJTnDqQjAafbIdCKVWX5E2p5QYL
 sXDLnPSvKqk3a6fPr1dM4hb1FkE4CSZvO9TqndGu2jTWRoV3DQsYTIPLKswWSjZXB+/q
 nD4ktgqxY9sQOgEKW91zk/18RnnM/I86zG5h0J+56L66LvbHm7sIQ0zVIgHWxJNL2AGS
 5WQ7j1wi/UT+RDlWUjgR6Rb8hpVb6C8XaHlh6rOjry3u6kTvmteWb45EVnAtkKakNd1d
 TGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732691695; x=1733296495;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EVxZHoAS0l6T6qHnkVAAH0XlqJRKaM6QoigOQruNJfQ=;
 b=mtfOGRIPPi1Cz65Xj6r14GFKLR4DgvKyvpCC1nH5hkmmRLsuf3SWT972CTsov5VWI0
 REywGbRAngzVU7y0GromprIqlcfOaf2KxqiEC9JJSyOfA26FsnTqiZtsidHHuRT9e7pZ
 vfYpFPbaZo41eapmaSM62paPa9Q76TWN/aQip820xwy69deM78WrZ7ij9UFNyl1DJPlX
 Y40ERZolYoT4p8MH3uXJFYNX8rFUFJcwEM4i4VrpE+FOxQS1J+g9vd71nEe6csIdulm1
 FOuINpSxmbSAT/BRWDCBlvD3zZyMpV7J0VG6uC5ytfDHT4ZYICydS7fj5kb/tgPZLt3v
 oyfw==
X-Gm-Message-State: AOJu0YwMkVj3yedBGrN74E7npyiypyYuUwlHJddDGkDJCWz47UBSnrgP
 HF1zQZ/QT3xlPf//Z7QSxGjgLV+BiXz1/+lyePUrC03+Xq2qOaW+6LoqkO+zVEg=
X-Gm-Gg: ASbGncvrqdM6IGMBgfv9TR4cK52U0S5kovcXYQqvCzDWaZB1c6P6Hp7y0XgJqGFdzME
 Lq3JZzRTHwkcdUFuQFkrMPHpIn05F5dKAQ0eSI2MflbtHxOhD8ZlbgKHz13ZK/Nva2SPBmNUJEa
 ppkpEVDlmyiBsYzQEXolypqysMKfOz/C4RYaUK8o17HYWEUTWqqnAGrGZa3xOm4fehkPcvowFgk
 w796xBy5TUXpXU/qpS6loXJPA6TothrlcTgddW5Ta7+P63J7mwNoQ==
X-Google-Smtp-Source: AGHT+IGnAmDV/VsnYFWi5bkfiYFoNo2ppbnSk3xIVkPRvjgH0nEUZUgoHW7tBcIy5Ld9sGKfXyARow==
X-Received: by 2002:a17:902:e743:b0:212:40e0:9553 with SMTP id
 d9443c01a7336-215018560cfmr28163025ad.32.1732691694861; 
 Tue, 26 Nov 2024 23:14:54 -0800 (PST)
Received: from localhost ([157.82.207.167])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2129db8c9e3sm96302445ad.6.2024.11.26.23.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 23:14:54 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 27 Nov 2024 16:14:38 +0900
Subject: [PATCH] docs: Document that hvf on Arm is supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-build-v1-1-65b8162733f0@daynix.com>
X-B4-Tracking: v=1; b=H4sIAN3GRmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyND3aTSzJwU3WRDMzPDJKNUcyOLFCWg2oKi1LTMCrA50bG1tQAdD59
 lVwAAAA==
To: Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>
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

hvf on Arm is supported since commit a1477da3ddeb ("hvf: Add Apple
Silicon support").

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/about/build-platforms.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 6102f00aec0f..d8b0445157f0 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -40,7 +40,7 @@ Those hosts are officially supported, with various accelerators:
    * - CPU Architecture
      - Accelerators
    * - Arm
-     - kvm (64 bit only), tcg, xen
+     - hvf (64 bit only), kvm (64 bit only), tcg, xen
    * - MIPS (64 bit little endian only)
      - kvm, tcg
    * - PPC

---
base-commit: 34754a3a627e1937be7f3daaa0c5e73d91c7d9b5
change-id: 20241121-build-c1661b2e728d

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


