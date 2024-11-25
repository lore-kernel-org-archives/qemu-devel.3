Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1FDD58D5E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFazA-0007ms-IQ; Mon, 25 Nov 2024 10:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFayp-000704-FR
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:27 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFaym-0002Yp-5x
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:27 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434a2f3bae4so3267925e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548379; x=1733153179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4ComUgm0VsNi+m3XoSttwvHYd1J7DrWJSpG+S4G9WI=;
 b=B3YpDNlMGxd+8iyWODfOeyW4BiTsIh8KCx8Zm0CiBAgmCvVr2mrdhy0kj+guX87B+G
 Q4cMTRK3MB2UvL71puxy/6n5497NZU5nLXswdDmY73TobgWF2c0VrmJnzYZiuqdQ3Kpk
 Pegy9nHkZsHrSa4f/SuZbF/mHSvvvD9fgm5W8CAFpKogPZWoLN6D5LYkU4lGbO6nj1/8
 0oCaRlm8Z0hOvEBAbvR05YBlBZIbHE4chHgReKp7iJ/wrkLgxPo1F3yRwJLnqdxWIxxW
 9+iZQWiN/ZBcem4e391/WKiyxFnkBPdXmFUPGVCIzwJBpophDlnX6hTTm7K04wR2Vh8g
 TFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548379; x=1733153179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4ComUgm0VsNi+m3XoSttwvHYd1J7DrWJSpG+S4G9WI=;
 b=fW+JKPLK1Zm2ihmdCfkvquUMKrUazNoAnP/y8Ojnn0ibgzYE//76o1icaaCyzwmX/C
 F0Eo/Unt1x2zqvbTaORwW41obIeLvlkZeJCn/wmgEVlVroXdA6hu7/0jVcEKtC0TrH3X
 nAoIsNmTvfccQnMWq14TPo4R0hm67RRlT8sxh4rKDQBwEVbAGSyNRvDakUTA7mB20/EK
 tzndbKvW7r/KV1NI/Xrsjq1kq2wnXiQ7v4YC1KyRXtWEfK4vMJnv4smFYyi74u7GoBkh
 VQBKTCuoX0HjDMm2aj+JIhnbMep3Iua2EiJuB/TpsKLyN0Tua1DPbrX40XTjshBx5+Hq
 /swA==
X-Gm-Message-State: AOJu0Yz8GKlXP5qIS8V0W6jSrfd7FVJAMe42TGWMzb1qxS730ktx7JJA
 TFe++7jU7+VVPyqIPQvvKsIEsPzYYMGCNz4F5k+Wp4F5IV9iFJJdtTUqlNvuHBw=
X-Gm-Gg: ASbGncv42vppowTgHbvnRXdIVP6Y7Jx5YA22Di0x8Hh0b9qM5JMCPTT2BEEVxKzKXuK
 eR0EUGE+h273A/Ng66nXyXAhE8rCjp7n2xFjHzhUxwbaIQIVdKjxskS/v1dmW3V1HQTSdR8TObu
 eM8LoE/HJCmAh6yQpnrq2kJKUt+yx7pDzZANQERqP0FI7HMN3n4h1Bq1HOnw7dxfElAlPf7uvjS
 lq+YQEXPlA7Mmeadx+dvixnWnnt8Xa1mcSra31IF55aSxdH
X-Google-Smtp-Source: AGHT+IH722bugulfuUBYdRcspq0o7wykmZNoQ3Pgu+dwnJDb6T6mtjejE09gTz9OyFxIeHpyLjBQlA==
X-Received: by 2002:a7b:cc06:0:b0:431:59ab:15cf with SMTP id
 5b1f17b1804b1-434891a1dc5mr97627645e9.19.1732548379059; 
 Mon, 25 Nov 2024 07:26:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a0c889c5sm26615595e9.2.2024.11.25.07.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:26:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AE9F962644;
 Mon, 25 Nov 2024 15:21:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 21/28] plugins: add missing export for qemu_plugin_num_vcpus
Date: Mon, 25 Nov 2024 15:20:58 +0000
Message-Id: <20241125152105.2100395-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Fixes: 4a448b148ca ("plugins: add qemu_plugin_num_vcpus function")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241112212622.3590693-2-pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-36-alex.bennee@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 622c9a0232..0fba36ae02 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -803,6 +803,7 @@ void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
 /* returns how many vcpus were started at this point */
+QEMU_PLUGIN_API
 int qemu_plugin_num_vcpus(void);
 
 /**
-- 
2.39.5


