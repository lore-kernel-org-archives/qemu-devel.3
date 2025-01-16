Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBC2C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSU8-0003jj-Vv; Thu, 16 Jan 2025 11:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTf-0003Go-Gp
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:15 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTc-0004RW-36
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:14 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso14147055e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043930; x=1737648730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtnW/LF2WEplKztk1bREiMVmkuT4ROwnxcTr9QA0i2w=;
 b=QFo+xNI40ZL14pqbuw6qLawIN59c7r6FTGbQjh8tSueeHU8bktzyMSObfBElJSI3kN
 4pBcEdz2NtN0mzYuEkVn2UV7bcM+fpuzy1Tz2bffxSfxVhzlSHp10W4cUdb2YRHIpaDa
 ovzUsDstIHBLIaqRBGslPuUmtzZ38LicuhoaVJ/Go//iXRWEI7fGvemRANZEURANUglF
 qs17ZP3Npvy9pSsTa6/X9kx/pZgV2mNa5gvGfw+TTOtnaRz7PmXnyQDwTxzrznULd56x
 KhiCWVTD8M5FlyCMUV8w/dulbyJbvrOesWqSMEpq/QbK8NHEigNDiDYq6pQHpj7cXg4f
 yiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043930; x=1737648730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BtnW/LF2WEplKztk1bREiMVmkuT4ROwnxcTr9QA0i2w=;
 b=vZb9l1mKJq0Ppktzc20KU6TkcwhGKmYTLOpG/cTxk0Q/08h1otg3sTD1tHJ8SCsCui
 vIcPO8IACOYUuKJ9oXDx/wIiVDFsXMPcde/z0hABwifjoGge2IDysh+aFLCdJ2Sz04DE
 uFHy3xkcOPdu5gy4BZG6heQ5vVmq2yncgJyXTApDwlxQIBAwxEfytnIsFwkNn+o8qY+u
 ALHyZjUjW5AdATPObLR12Lw+g9wKTQ5blfI9/D0D39dnaWinXNxTn4VYbaEtjPnbycQV
 SueTD10hsyU5cIxb2cpmSSaskJRbAGRG8JzCFiCx/g4Is94XZA/PDrP7LPPeGX/S7rY/
 bcUw==
X-Gm-Message-State: AOJu0YxO3h2ljTdNzfdvEZnmGtHLM5s13Jb/79TW1IuEI57cFkCPNuNY
 ELbHJ/bHN4vysmCQTAYVMhAAlQw9cU9fScluHKnQ/ZsHD0fjil80kZHlFCUm864=
X-Gm-Gg: ASbGnctybfkVKXkyrrn3A9Rl71PqLmTnAavHobbBRTNBjREA/5MefTxzEYVC/Hfr/gk
 OOL6cjn/Yv6LVuVIJI5tNxFa2aoIF8wz1+WYWgp+5c/Lv+WfQ5c76TfnbcRX/nx24lr9rKV26Ki
 P32WXKiR9OKDJiY942SIwBTz3X8Xpi1xXKfoULmQKhv2zY8HCXESnciVddFu8r5nSNA/+nVvdIy
 qzaRtJ/bsuUZa+e4fw8kjNjP810sQ7PWd/9c/2lbXHZFLYuXNFL7pI=
X-Google-Smtp-Source: AGHT+IG3UpHH73jsqPqvImdUtKjmMEIeuuv9skBbBM9xMHdQHm84O/zNiRWlWWyXTkYjD4M0feZSkQ==
X-Received: by 2002:a05:6000:2a1:b0:386:42b1:d7e4 with SMTP id
 ffacd0b85a97d-38bec54287fmr2772092f8f.19.1737043930201; 
 Thu, 16 Jan 2025 08:12:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753c60csm62649535e9.36.2025.01.16.08.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0B3A16084C;
 Thu, 16 Jan 2025 16:03:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 26/37] plugins: fix kdoc annotation
Date: Thu, 16 Jan 2025 16:02:55 +0000
Message-Id: <20250116160306.1709518-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

The function is qemu_plugin_mem_get_value()

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 0fba36ae02..3a850aa216 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -583,7 +583,7 @@ QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
 
 /**
- * qemu_plugin_mem_get_mem_value() - return last value loaded/stored
+ * qemu_plugin_mem_get_value() - return last value loaded/stored
  * @info: opaque memory transaction handle
  *
  * Returns: memory value
-- 
2.39.5


