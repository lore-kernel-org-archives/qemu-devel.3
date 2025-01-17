Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE10C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmm0-0002Vf-BR; Fri, 17 Jan 2025 08:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlu-0002U5-Bn
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:26 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlr-0003l6-6c
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:26 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso401427666b.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121940; x=1737726740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtCDv3d7Fj7JdhWS0o/IEH/Zvi/ajW/ZDQ9T4eeCRh8=;
 b=ijbLpktOx3ZPF0CEinUFtewiSich2KRhHN3ayksE7Gm05I3ZvR+wkX3sZ9eL/2a+pp
 A8UIfuABoyLqnWag8sC69SNwPjEBAF8x37uiVKRqQ8CBSPnp4ORs3RbnJ5VBwaoT33qF
 8RdnZGtvt7Bgs/9GALivxL5sT45Epo1nEmdEWSfCNIId4wcAPtWreLQcjGd7W3V2Rm8K
 BN1OwC8cPRQJFTbnXe6tjYvWZXp/KBKciFu12zKmsRHdO3FEua546TSRDTlIUGc9NzB6
 J13gpy3c5hphRM9vLWdHkhOb+XpqFzAivPo9dC7RswSWxeP6L3jZIaHN9QhM0Ph+XvQU
 iXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121940; x=1737726740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtCDv3d7Fj7JdhWS0o/IEH/Zvi/ajW/ZDQ9T4eeCRh8=;
 b=VhmicbRf98enW1OqU3S/vRl5mGse5fGCB3Z9TLrbX6UjxaSiV6Wk2+ZgCHo4EJh+/R
 lq4LmYzBOtFFy3Z+FVhJmwb+sqqAYr8IAlWUzrMVWH3YyXKkssnKmqTTWAmrmdpHzX7w
 uBp4OBTTWDZBvBBuIvak5gTNOYKMNAOPhWAq+FOr5FW6hKKQToH8nHkzH1+cYAY1fhZo
 8U91QNr6sZnNIYH2wyOnEq9Y4UI6SCtDeFD38/kq8NFn8xULY/BYv7wM8+0N/V6pqrus
 jsXe2+drvYNC2ErddpbP79o5p/uLpRpjj2wodJxcMw2VZeSzRIL6+BdKItwPyNmXQ0ZX
 nWIQ==
X-Gm-Message-State: AOJu0YxrYdv9ipw6EYh3cIX/dwwrGc+EG1mhKSqPs/9CbOp8UtvI0tmy
 4SPxEtZVFDWWmY/zBzGKKIsEjs/M30KUv8wKHE0OqMDKh14vRBILNNHSDcj+ojI=
X-Gm-Gg: ASbGncvGnscNBBHl5UAs58zZNfIcJDJ4PJ4gdLjqmLXcfOrACA2JwPKSeb5zF+Dj0wy
 sKlrfN5j44W2M/tK7xlXZv3p0S89Q3I/aje6VAxggn2GHyXjbmtd6rcib8MdBoAxzA4ATSyitSj
 MIXiZaEuNoBML9ay9Rp4G61L91HywLmiIsiJsx8oSEfAw1YS6XHvmGWBwjIGlQxW4iRjhxc3Wn7
 2mQ1h/JkGrsmfb+Fc0DxDtTt2UjxNPYNDXVk4RYDycUu5QZRRcVEDE=
X-Google-Smtp-Source: AGHT+IEot0OJi02dAtKnC0F2Jjse2aekavj1JmXqkk9hpxKnQkkCGBlBw4Mww+b1TQWuBZGQhwGUMQ==
X-Received: by 2002:a17:907:60d2:b0:aac:43e:ffa5 with SMTP id
 a640c23a62f3a-ab38b1ff088mr231210666b.15.1737121940138; 
 Fri, 17 Jan 2025 05:52:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f86fa4sm174040666b.143.2025.01.17.05.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:52:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 66A1E608DD;
 Fri, 17 Jan 2025 13:42:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 26/37] plugins: fix kdoc annotation
Date: Fri, 17 Jan 2025 13:42:45 +0000
Message-Id: <20250117134256.2079356-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

The function is qemu_plugin_mem_get_value()

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-27-alex.bennee@linaro.org>

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


