Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF77C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 06:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv9X1-0007Qc-JK; Thu, 20 Mar 2025 02:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tv9Wr-0007Pd-EL
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:37:21 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tv9Wp-0003hS-E7
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:37:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224341bbc1dso5579075ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 23:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742452638; x=1743057438;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8pbdE8VlFJqequFn1LDdLzAu8z2hVLr16uI3jFECb34=;
 b=hAjZayHQYwrzF0zX5eH9DCe4ShqPQxYE0K2Buzuy6oSyRJBkLHqt0jBLCQBuOb0hZ5
 H6WBtX1/HQuthGzA2Lfy3a7NfrHZN010cVWLA49CZ6ZAFML262LDoL1mz7f/8F2ChxER
 mGyRzBg03GrEG9KGzw/k3EABOjYGhBzLnp0iOAgHQV/Sxp7xzL3gGnZH9lqwgKaCjYet
 otQGzB1xOteL+gAT+e0ZY31JoEOc9HSUFeZV+L3JjnPcc01lJ60eiky72/VsLBwWzpIU
 Pg0HVc11y0CwtXZgfImmEdCbBbepRC1ZfCSNvJGphJj8bL5rEG4mpGox8zp45UNBk8Rd
 EG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742452638; x=1743057438;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8pbdE8VlFJqequFn1LDdLzAu8z2hVLr16uI3jFECb34=;
 b=D3eyfKXCtl3CMyl+Zc9RYQ9fYllEgGxxBKtgecTBw3FBQwBUq3z9edD2NvQvyE2R0I
 QFHOJ6p7SCkNqxTwGkmHbOwpst1ICp8LJxlJUV+VpXLQnsrOwvFWu2Zuo7O01rK7aN9t
 0wpBMxO6Xsvt9kSn+BJxgyHIrChAOmCx84eK0tfDUgMLbGgbNScf1h8xCv8cya02uu8Q
 f5Irir0dKBkK6mK6mzpduzVFlwgTP4RZuMJYzzlkLzCLRB7DaTr4v98iJW/lcMyYrl/M
 5f38zjwQ2zswpFMDh1uXOZOIbTMPk+nYck9SrAbIbO9fkNZTcY+82mt5K4fyh3tufj+u
 47Fw==
X-Gm-Message-State: AOJu0Yxy4pyw8tEZoFy46XtLLrOvmD8f5oR/Xugi+dgNIhECGRdJ42UR
 Q0NZX53JKGp/ePbzDVDb0WMX+Ef/Go0yPlcACOPcvPznt8kpLmemtaZtV7XJFC0=
X-Gm-Gg: ASbGncvncgQh5lSvRE17O425n2fjwsTx2g+6wNUHqsbgIit2FZ/RFOHeXCfByrpHKLE
 X5bTCHAKbIW7Vz79J1nsqvtww/Z/cBs06kCQd8niB5X+G8FGGmN6DTBuU+s+b8JcenFmjdR22Aq
 xVvUjPSDmYmG+n7rRl4ZQICpRZi4Tw3I9KMn+zDrv/Gm0RURKBbWPF0yWIScKgQ7vBrPgGvgY3o
 nC+SBug7zCsam0aZj+fK9RlwONgS8qE7hqYV1eYhXsp7yvt5JFdy2G4H1pdLk8UObo87fzU4LzO
 4zl+K/3n85l2PwPTKhd4LjJ0JJFE3/2UAiSm0/GfJV/lQK/9
X-Google-Smtp-Source: AGHT+IEK6rIs4iEaIMtGYn8ae5qfoVBxNIH9T1+g6vaS1Am0DHbyTZO7cvAMP3BNmq0TqUuGk0spaQ==
X-Received: by 2002:a05:6a00:3a25:b0:736:4644:86e6 with SMTP id
 d2e1a72fcca58-7376d62c910mr8152118b3a.12.1742452637650; 
 Wed, 19 Mar 2025 23:37:17 -0700 (PDT)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73772f84ef7sm2417931b3a.6.2025.03.19.23.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 23:37:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 20 Mar 2025 15:37:10 +0900
Subject: [PATCH] mailmap: Update email address for Akihiko Odaki
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-mail-v1-1-28ddad2aea47@daynix.com>
X-B4-Tracking: v=1; b=H4sIAJW322cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMD3dzEzBxdg9QUMxMzY2OjVFMLJaDSgqLUtMwKsDHRsbW1ACTCR+t
 WAAAA
X-Change-ID: 20250320-mail-0ed646332e58
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It's too late but better than never.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 5f6df414e1f7..33fe75400fe3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -67,6 +67,7 @@ Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> Andrey Drobyshev via <qemu-blo
 BALATON Zoltan <balaton@eik.bme.hu> BALATON Zoltan via <qemu-ppc@nongnu.org>
 
 # Next, replace old addresses by a more recent one.
+Akihiko Odaki <akihiko.odaki@daynix.com> <akihiko.odaki@gmail.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@mips.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@imgtec.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>

---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20250320-mail-0ed646332e58

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


