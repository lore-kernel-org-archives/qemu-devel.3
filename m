Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EE6D1D462
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdr6E-0007Lz-L6; Thu, 08 Jan 2026 09:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5y-00074P-Hn
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:38 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5v-0000jT-AL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso24184475e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 06:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767882874; x=1768487674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6tH0CF/GJKELoBmGqjsJGSOS1a50aHiTGJ/qCRa94o=;
 b=HS4Qf1jSb82GjuDAbydiaDt/Eq83vsu8awTfomJ+OQlCi5rZ4LJO5j4enPSPWw1NGe
 LoYslHzbFB8ymK5PDtr4jTT1NtotBfSCKaeKCgscWJCiaBm+ZcngXPW52j9w7+6X0tbA
 OVI+wDDJNxFdsWqhEvkQjv99ew0h4psNfVy6TfuLvIA9Wclst9gNFKMF8P781IXVUqMQ
 9P0VK20EmFroxRNesi4s/3FBteuw+f8db1HkOE9C4q3I5DJvMga2tr2xBINGSFDnJg4s
 Dhlninp/BZwvgo9gqhR5I9tdSbD510fzE091ytZALInU9KXEBuBKDntjibtrBIRQrtvA
 qDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767882874; x=1768487674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M6tH0CF/GJKELoBmGqjsJGSOS1a50aHiTGJ/qCRa94o=;
 b=FcLidnFQC4a6i5yQvCRnE3GMkeG7FykVcdySpXqkr8yA3WulHGd1NBDcicPgqt3VOD
 dy/HYg/dEAfkXBMhnq4nxuS+spBo81bF5SzregST//GbfdM+iqm9cEcV5lke/Qdv5ltx
 fRVxRwnxkOMKtymnV2UTCwmp4dm1gQfUtBxm5epdA6TN0TaQkeHAHb+SQSc/l3ngC9Ui
 2i3BDcOmsaFogf6A7jumy61ErvvmtKr9rCr84xJqrZUSWLPGWq2oFf5sjMozGbw9QFps
 4WvXKp9nTklOsV8f44sahXRAkZtaM3RB9Z2iLXPjqLWWk+8dZN8fDAnAsJ8LT7BOXRaw
 9+gQ==
X-Gm-Message-State: AOJu0YzkaMWPUdkmr3nkvFuPUtfVgjutbv640kBcxlh/d1D1inojtwPF
 MOVdoDcMd85Fh59MfckfWG23IpMLLQUTfLr1IlLhX5kXImR1gPDZchCtJQ6VWURycTM=
X-Gm-Gg: AY/fxX6rwKDUzSSkRg59VLPy4WvnNWe7XuY55yntWtmxUt6RRkm6zUOsU/uIz5xsPoi
 69fdUNi27TUqi87uhgIiFIQUa9cZJjvb2ApnEvpp/7j4Y9p5KmDR1HhD3gIdD3iHJYkP8wBySfM
 2WDk5MKtQbq5R3ebStBt5h2iYyJUZkpcXvNtdZRVHRaBX7dwrPO2yRtIOSIuSsPI6Fhbw8oe08V
 pZDRzwVETnFtZJ31Nbq9YzlPumn3n5pFrWHBVyADpIIrR2xv2zTJ+OGbR8B+JaZhcrFFDCxJkjK
 G0AihDNvEP8/san3jdpAOic4fizl4AdTdAtIPqkOLAXuIH8zAzArgm5OLBWRO7WZgm70BjHcgTX
 rW3/cjFjkLM/vv3ChGOjkOcL/aRJggWEuRWV7zEZCC4o5lrUm8mG/7ReoDv5Lc/DB9H5KJ+muIw
 Kytg08dJQpJDo=
X-Google-Smtp-Source: AGHT+IFQ2b7jHgSZCCtLDyudNjBkpAYBfcgv7i5tpvjUUC07gUibqxAEQZnVr+TfhdHtcSVluMmqnQ==
X-Received: by 2002:a05:600c:1392:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-47d84b34673mr79074405e9.23.1767882873727; 
 Thu, 08 Jan 2026 06:34:33 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16d2sm17391256f8f.13.2026.01.08.06.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:34:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E9D995FADF;
 Thu, 08 Jan 2026 14:34:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 12/12] include/hw: expand cpu_reset function docs
Date: Thu,  8 Jan 2026 14:34:23 +0000
Message-ID: <20260108143423.1378674-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108143423.1378674-1-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add a hint to the developer that this should only be called from a
reset chain.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/core/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f6f17df9e64..9f938e00492 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -811,6 +811,9 @@ void cpu_list_remove(CPUState *cpu);
 /**
  * cpu_reset:
  * @cpu: The CPU whose state is to be reset.
+ *
+ * You should refrain from calling this during CPU realization and
+ * make sure this is called from the reset logic instead.
  */
 void cpu_reset(CPUState *cpu);
 
-- 
2.47.3


