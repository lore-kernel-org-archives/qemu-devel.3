Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D844FC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPSO-0002Zw-Cx; Tue, 03 Jun 2025 07:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPS-00086w-UL
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:23 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPO-0002EU-A8
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:22 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-adb47e0644dso550958466b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948537; x=1749553337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/Bg8Gn8FEOfqUQYMGn4nlmzkMaoZuvkpVzWIx9k58M=;
 b=DbWS8NNPI2w+VBfGT1aXXzIAIV0XdiyH57LA524KzK3mlBG9lEuIgRriAQqBakGUrN
 E3pbPEO833s7q8/O+zEOz1PZyyjxCtUctAZ7jbLUJArMbOcUWOtHsbPzXOwmbhgJhhbE
 Zv0VMHGWy5W51SckUWzHfrjpooscKnPEn25bL1OjTrWorTXglpu0cvhKWRx0RjjsjhYd
 L8O2GRz1BagwB/p7eyirrY6bmM/6Z6iCCzLAkj0lt1Eh0D5x8HoPHv6luSJ6+u4gF/Ar
 IY80ow41Es+rpCHMBpU78ZngcFySDPAWsg2sSzPNFV3Jm73Av4nh4j0YSKXxjMM8oEiq
 eQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948537; x=1749553337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/Bg8Gn8FEOfqUQYMGn4nlmzkMaoZuvkpVzWIx9k58M=;
 b=DCPDQokpg0XJ0aiZGanzcIhgZwV916B/uwBQE+uiv9F2b5wEVBcl8ZA/znpc4x2UK4
 itaQVgcomjHmWmVQaYa+nmj73fhWtTTuUApZroq0wk/dyiYKqBcoMZxIfIDGTcq1cFGF
 7PM4JF9c9XIXeCEcBoG15Hug9FeaanJ/jUGOFJ6TkChAP7uGRI1r6/e0PngHVY80Jydc
 n82hsXsycwumyyLOrIzum35JityxKLT913cQ0nZk/b6tJPmyM4b4csrdkjv/fhIPD2t8
 vrs7PPu5e+Z82i2PGkelAae0NjPi8hzJHdIHuoly6Ies2Q/Aw2nC4mhQr0WRRVlqxUyb
 7Gng==
X-Gm-Message-State: AOJu0YzCb1L3mN1Vor59OoXwaATPMeIFX1OTUW40NfunRMC97nY9AayU
 SLvpipoCjrZhttWuj2sf8VMwyOSHfJb6DfTzi8vjIBXHSkdlfGpTJL6rvC9S0CWtC0c=
X-Gm-Gg: ASbGncs1+hHLebr76eGxJGW5wACtyrz6O2I0hj29MiNbVYXHhVyyY4kfSh9TRkEtSTp
 0buJnxOC/B9UkN//AJx+LuTtvSt0ThPm+PUt9FYBQ0cpkaZL+UE0bsTp6LX6f4JSvSjfFTMzBwv
 aRCb4M8+PYuDOaI6S8ulveEHicuhLLdGbWoluXV3u0r+QR3kEW3QsXEwzRMaD5ahiTxslFzi701
 BgLy2Z9sVGD6vlpEyHdgV/kXNCQHoKEoIT8pJ+uf8IrPipHh93e9NAfT/DaOzsdvRCeNO916Yyw
 AcvG/GsR8hkC19yOdJA4aix0hNuqC66pSIzlc3eKYI54QuU+6Wm8
X-Google-Smtp-Source: AGHT+IG5hTW2H+UOmD8b1pfi9+QNZib07xsS7Pn/UttOS2X/BP1bjtJ5mdFQ6xEw1OvFvruAawlCYA==
X-Received: by 2002:a17:907:7245:b0:ad8:5740:9932 with SMTP id
 a640c23a62f3a-adde606b27emr221329666b.26.1748948536557; 
 Tue, 03 Jun 2025 04:02:16 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82de84sm944856766b.50.2025.06.03.04.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 380B75F9F5;
 Tue, 03 Jun 2025 12:02:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 14/17] include/gdbstub: fix include guard in commands.h
Date: Tue,  3 Jun 2025 12:02:01 +0100
Message-ID: <20250603110204.838117-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/commands.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index 40f0514fe9..bff3674872 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -1,5 +1,5 @@
 #ifndef GDBSTUB_COMMANDS_H
-#define GDBSTUB
+#define GDBSTUB_COMMANDS_H
 
 typedef void (*GdbCmdHandler)(GArray *params, void *user_ctx);
 
-- 
2.47.2


