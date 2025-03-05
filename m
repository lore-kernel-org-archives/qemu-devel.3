Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6EAC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqqe-0008HZ-Bh; Wed, 05 Mar 2025 10:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqa-0008H9-Va
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:39:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqZ-0002II-4j
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:39:48 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43995b907cfso45221935e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189185; x=1741793985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdtas5HdXydL2NOaru6Yo7c9eAGwqywYol70/Ag2vxo=;
 b=HmwqVeeGNaoOvljc14e+kLmVhOR+pSufNLgF2rs/2aG2ixx2IpodkuRdtKb9fdrEcg
 kzGiMt9TIYBE8TiOgPAgBkuJLV3PI8hipAm6NTJrjilYlcle1LYpARSonx8n2HUpG+7V
 3RUJYQbMqcQUeD9Dk2EKWMCJ3yLslLbVkA3kCHqTVUCxFdKOLt3eHTe8D8EiajRSsz1Q
 gWU0Ag4YrHRACvAbrS4NeC3abfkBPfj+pMIQ/vf+Kp+yi/AJr3nj4uZ+OVOcGaEcQ99B
 lyKO9WT6w6Do9FVyNgO0aEG+0A0zHS5Kcm2Md/g1RqYXAm3fjsCCf8q0TWYHt+Owj3e3
 bmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189185; x=1741793985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdtas5HdXydL2NOaru6Yo7c9eAGwqywYol70/Ag2vxo=;
 b=WaWdCXIX4d2hCHelYgilSPtomu0A6k4MOiAjB+dLPMg6GJoElMYdObhmeAydmsHJaV
 BV1lbL+w6ThdxFp4wJlJEfEDMzIhFi9Q5l6Irv5Xy5QxwdsRX/t1paI5tLnw4IMycUGe
 LdLmu6RC/SUe9hEEdPM0xkK2KnZU2epejd2lv6dSGumS8t41AK/7SY3pDyQcPgABIuON
 y/DiLu4Uz8Pq1xUtgHnVDSjDxEREn+T+hvcyf/DFqfVBNuLrYRvsYT8FWdRB91qZPm6/
 f/vKWKbHi4nvIE1KWChEiyHx/dho6gNPwyBVqJgyZmFzsMI4uRelBK9VaKyRDmQaOHZ8
 9d+A==
X-Gm-Message-State: AOJu0YyP6Bq44AGTwUZb5Bg5gUD9+KFCOMaghxz/OFulEVsF0cYSV+vz
 jMGHXk+mO92UDYavLpTne5B+VLu1WzRrj3a20B7kygnrxjt7+Q15WQsFfQNsC6KasQbnAM+QkM7
 aNnw=
X-Gm-Gg: ASbGncscUd/Z8mRQ4fL/pf0THyp86nsBONge75I76n6Nl90eJcTzjCQOzIlJembB4xX
 Ic1ZlnEzDOxlW+qhwR3F3SLO/O8AmugaYhZASL9F4Rk8lwvpd+VlvQ1T5TmKUYgwjtAPxTAetRi
 bonncwXCY0jpiEuwD19bKGu1ZzpVJOCoYudLCJzYyXZhX+d+GKfLygmvDATZoNyYJflwFYjTd2/
 bjeZ2lEFgIFpkuvayZJm1U1P1J5G4c32C/bbcuijWH4mordM2cSPeyFmaf6tzMSGg2YyDQWJfJZ
 35CZe0lRT0rO4LqxjpAjONOZbi2N7zwnk0HmyukQXjccJfmugMmzvpDeG/adGbvRW5LCrcx3pRX
 vGRKgeYUo3opNlf8Se3I=
X-Google-Smtp-Source: AGHT+IGqmhu/i4tlWiizNzpPx8mEocXR9cuZYwCsTXNSpMVaO4jgil7kIFzVs+8gqF9dkMUyrm2VHg==
X-Received: by 2002:a05:600c:5112:b0:439:a1ad:6851 with SMTP id
 5b1f17b1804b1-43bd2ae1663mr24257265e9.23.1741189185145; 
 Wed, 05 Mar 2025 07:39:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42b7478sm20663345e9.17.2025.03.05.07.39.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:39:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 03/18] include: Poison TARGET_PHYS_ADDR_SPACE_BITS
 definition
Date: Wed,  5 Mar 2025 16:39:13 +0100
Message-ID: <20250305153929.43687-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
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

Ensure common code never use this target specific definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/poison.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 0c4ad04eb97..0ab7f0da1c7 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -47,6 +47,7 @@
 #pragma GCC poison TARGET_PAGE_MASK
 #pragma GCC poison TARGET_PAGE_BITS
 #pragma GCC poison TARGET_PAGE_ALIGN
+#pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
 
 #pragma GCC poison CPU_INTERRUPT_HARD
 #pragma GCC poison CPU_INTERRUPT_EXITTB
-- 
2.47.1


