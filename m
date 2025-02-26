Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF11C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI9B-0006fU-48; Wed, 26 Feb 2025 09:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI8e-0005Rh-Gj
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:12:01 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI8b-0007aD-02
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:11:50 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f325dd9e6so3628566f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740579105; x=1741183905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuqYR0pzDjdy/vyGlSpH8HOM+UQ/7j7Yz2MNCfS9jD0=;
 b=CRTv6jGwcVOcFhb7e+kixVY2ru8fgiwegX4zJVs53vmzXrmU1OOsYeRmvEFfdgOZT6
 G2IxmsmHO9fhJE+3bnRaDR7Ry1vv1eSdpNxZDKBz2K1raA0G+mjOSMPmySxRjkdQ+oIL
 OIOCPUXmuujaPjVd256yT8i3jHKoT4cPx7GsLl4r7mURE9+0FwNjKy7Tn/+vgd2efk/w
 sxJ57i8v87ayid8FauWULwk9FQ7jx54OBMgLyq6rRnrmB1KmMOKyTVuVwJf1+aWQwpvo
 iS28x0d9fxTneHrgiPJaQYAwc0hAHbq9EecvYXBvvctTROl7JrBPv/ji7nRVP7nj+xEM
 cxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740579105; x=1741183905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fuqYR0pzDjdy/vyGlSpH8HOM+UQ/7j7Yz2MNCfS9jD0=;
 b=aYDHgSQY42dJ9vfxrdNDCvFL8Oenlrv6uFrXo3TkpXNgJwKSzao5G0+++JNWAGvpDk
 xWg2hK5KNAmnAWoCaqv7cf59KcgCNLYYoSxTL2b1wNNDXWRmoi4eWgkGpKEevVsCxFm0
 LzQNKYA9qEtT7hviEkXUCQGtzdJMHGMtzDbza0QL/HyRSlOVQAezB/EErDUmX3Lz4EK3
 3FMhQ3edKpb+S4u9PW3erlTlZRO+JFKnKRVoZM7RIdLF/5XLBzGjEtIeM0KqTzOSk6Rx
 gOzUvmZ4x95UioQ3tEVbqVFTPiWAZqZ8i9BbpyHipt5WXRalaWf99sJ8momedm0dGqP+
 9isw==
X-Gm-Message-State: AOJu0YyurnLKkSkFY70brUEKY437iOBopKd638TLO3A/PyqDeftVfeyg
 aubf9ihFX4ajLojAoOqDd/Dz2yomurNTh67goF7EgBjpoTx7N0tmjapNtoh+AsI=
X-Gm-Gg: ASbGncuHhc5QsPA9EY7h75hiySL4M0w3MX1fq5HFOdWVTLOW9xtIKCLS+Z9+xL85gsx
 aYLzQfuSMUbcXC6tFYQIe6t5FVk5ecPr6sZOMmAf6U2i+InKDnpUrLobDUupx5LpJTQ7BgWHD84
 gncHqRXf+vunD+d+baCFRnjCD/5lFvX35E1U8KXCsm4VTxzS9MkksR7I4NKwMFdKYRCJI+tjMd0
 TzlQH8rzGsyzUemghiltcqM7y43CO+jsmMr00WeEp9BXI+RQ8XmBYQun2mwO49Z3dfXVwlZLDVB
 Ja0T8wsgaoblJ3KhnMevHimeKx01
X-Google-Smtp-Source: AGHT+IEmzqR4yIfka9lOETpiDzckm1tWP2Y18QUXSLtp5vMiS3CsE23MxPF1Mz98RTU22xNbxa1xvA==
X-Received: by 2002:a05:6000:2a9:b0:390:dd1c:45c4 with SMTP id
 ffacd0b85a97d-390dd1c4886mr1650668f8f.12.1740579105275; 
 Wed, 26 Feb 2025 06:11:45 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab2cb1063sm33164325e9.2.2025.02.26.06.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:11:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7972360605;
 Wed, 26 Feb 2025 14:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 16/25] plugins/loader: populate target_name with target_name()
Date: Wed, 26 Feb 2025 14:03:34 +0000
Message-Id: <20250226140343.3907080-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

We have a function we can call for this, lets not rely on macros that
stop us building once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250225110844.3296991-3-alex.bennee@linaro.org>
---
 plugins/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/loader.c b/plugins/loader.c
index 99686b5466..827473c8b6 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -297,7 +297,7 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
     struct qemu_plugin_desc *desc, *next;
     g_autofree qemu_info_t *info = g_new0(qemu_info_t, 1);
 
-    info->target_name = TARGET_NAME;
+    info->target_name = target_name();
     info->version.min = QEMU_PLUGIN_MIN_VERSION;
     info->version.cur = QEMU_PLUGIN_VERSION;
 #ifndef CONFIG_USER_ONLY
-- 
2.39.5


