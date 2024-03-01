Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E82C54E55
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg86p-0007NP-8P; Fri, 01 Mar 2024 13:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg86n-0007Mu-PD
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:59:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg86m-0004Ku-8X
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:59:49 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412cda08022so2742685e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709319586; x=1709924386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtfJTO9TdCzL5i6d7LjIfwE/FV4OnWItChimAYUDyq8=;
 b=pd74+PDhBwRykPDzoMQjve0GsXlz7jkEV+eHlzjYx1nBB1vBN/f1LHAdHdaB6Oaze7
 V/FHcIOTmNzFJDHm28895Wv4fiN6TFlczxxib6RPa9JjtwTOjd3DVof1nV4gW3fhyDtg
 v6t3O+yCqL1xfiM/e7cidMlkJsY+94JrfyPOrrk/j4R/PdqZkiTfqVD7Vy7v6kocLc+N
 sxozAeCLRhbFhQfyUTRpgrn4iz1V7KlfFeSGP0Adykj5r8CXkpnBjRwgab7LmGJ7SGa9
 hO2wz/JIwpqNAy/7ejxKBq8hZFiuM5UzYHNra2SJKnSZvsJM/TUXaPHe4okJx6qbZL9d
 mZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319586; x=1709924386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BtfJTO9TdCzL5i6d7LjIfwE/FV4OnWItChimAYUDyq8=;
 b=fHBem9Khz8160vIMGovcIOTT7nBWUXQxKukGKqRDhpCFzXHqR2UGFAVncz/LevdECK
 75yvmB6G/d3y3B0TCwcnYH9kgKZqEATlDOVxusdIN9tatD1KcQvbXV+pNxxpQ96eHOT/
 bv5VLvM116Z8pZepoado5Gyl9i6jCx2NIoCcMw3ldBlacgdqwmZ3MOcHqwysGRZfCiXw
 fP5fOG2LtnGlPK3Zkm57AFBL18P8kF4lq8S4VzMt76tGWn5PBKn7rfSVjXYqcVdkvpul
 iEhevjjkxHrrg0PcpvQsYVwcDbs7kkAcvEE8QQNQdNE8u/2srhDfb6CF+S2GTtUXpQ8D
 FodQ==
X-Gm-Message-State: AOJu0YyZCuE52Kw6cf2z7b55dsqUVcim/Vm6KzmuSHGMz6eeulhP/zCN
 RbgFLqaoSlaoZvKEsfk+LY28RAMQWZTDLSA7uTW4TLFtVv1PYM88a9e3yqiSLq0DboRb1d4+hW4
 GtNa6ZA==
X-Google-Smtp-Source: AGHT+IFEUub7geG0ha7OxaS3A67neNZZ/2YR79NIdWDyKHQh9hyYlQg6wJNIxlmEy5miz7USjjOGRw==
X-Received: by 2002:a5d:6a08:0:b0:33e:fd3:8f4c with SMTP id
 m8-20020a5d6a08000000b0033e0fd38f4cmr2012508wru.1.1709319586405; 
 Fri, 01 Mar 2024 10:59:46 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.84])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a056000009100b0033e17341ebesm3737235wrx.117.2024.03.01.10.59.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 01 Mar 2024 10:59:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/i386/pc: Remove pc_compat_1_4..1.7[] left over
 declarations
Date: Fri,  1 Mar 2024 19:59:33 +0100
Message-ID: <20240301185936.95175-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240301185936.95175-1-philmd@linaro.org>
References: <20240301185936.95175-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These definitions were removed in commit ea985d235b
("pc_piix: remove pc-i440fx-1.4 up to pc-i440fx-1.7").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 5065590281..b958023187 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -288,18 +288,6 @@ extern const size_t pc_compat_2_1_len;
 extern GlobalProperty pc_compat_2_0[];
 extern const size_t pc_compat_2_0_len;
 
-extern GlobalProperty pc_compat_1_7[];
-extern const size_t pc_compat_1_7_len;
-
-extern GlobalProperty pc_compat_1_6[];
-extern const size_t pc_compat_1_6_len;
-
-extern GlobalProperty pc_compat_1_5[];
-extern const size_t pc_compat_1_5_len;
-
-extern GlobalProperty pc_compat_1_4[];
-extern const size_t pc_compat_1_4_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
-- 
2.41.0


