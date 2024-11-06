Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63589D59F53
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jXP-0004ox-AQ; Wed, 06 Nov 2024 12:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jXM-0004l3-Gr
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:09:44 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jXK-0004ZH-Ta
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:09:44 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so51373f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730912981; x=1731517781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jWErWBIj0F5t4NqhpwMkB48eX+pCqWPGB0s4Lu9mBc=;
 b=HYtXn5Pzduuj92zX5OTAoDfe74B2Zphhk+LfTUeDmZL+FmB1a8L0/GhRmTdQZW7O4R
 yWUSbp62zzZWOFF8PACPT8ASoomsnnhNBgJK78wPKPg8yIviyyodFfb7Rbnt7+S/Jnj5
 s1LAkFYHNX0EezhnwIPXlTvsI7XgqoSB+RUhNWLhEHB3NwzBbJv+RICtT5G201LKwPvm
 puFmuOzRX2F73iPdfo9a4WSaDrT82SZ6mI6eVMp8iJlFpNpD5HmqNHUhQwvyHIjBR+eT
 rrGYleZc+KIl/mHOLXauk509vjJ1QQeW2q2nvQu7SnjLVnEzaEfpATpsZCPjuJEPi1ze
 8dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730912981; x=1731517781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3jWErWBIj0F5t4NqhpwMkB48eX+pCqWPGB0s4Lu9mBc=;
 b=ogHmelDkF4hLqREbuGCWl3TrHsn0GQ8m1PlMpfOFTmcL4s6ZlCIKj+S6iIi7eP1x6O
 7VoJ3Pp4oVz3Jipndcm7SLI75gvU+cPKs/T4nyvA8r59U5mwmVxCpHgo1HdpcTye4Mkx
 TGAB/2H8A1+DePqoaKZGiqu9f0UDCbMfmHhHNceZd2wrknfOBZKGxBJXIMSbOkjS0hme
 2ubGHZwmieI3cx344blFWOUYPnEVilOZeE8T0YXcirpU9KticZtDH4TKjWiz31Aek1A+
 /CegNyhKET2+luN5ekjQx1uvGqP8keygVKcqKVqAEmkHyevlhMQG6Pfgvihtdrag28rQ
 eCKA==
X-Gm-Message-State: AOJu0Yw7j8JQM+tRr+U4BO4ds/LUyNOasZci+dDae7zNrRF5wmTeX/R9
 P2gpK2RRYJzFi1Z3WJnw3ZjK20vK0CXvuVpm8oBuMXGKw2qTq9tzsJ64IFAFBrNw58r5Fa0JPvU
 CfzmDwOY3
X-Google-Smtp-Source: AGHT+IENvxwklMYEMZJ2bbJdRQFP5fBspdM89APcqT/Zdroi4rq1J64cK7tB2cKA2iHddQMwmwR2FQ==
X-Received: by 2002:a5d:59ab:0:b0:37d:43a8:dee0 with SMTP id
 ffacd0b85a97d-381e81cf361mr2871422f8f.17.1730912980679; 
 Wed, 06 Nov 2024 09:09:40 -0800 (PST)
Received: from linaro.. ([193.32.126.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b2d13sm28918935e9.12.2024.11.06.09.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 09:09:40 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/3] plugins: add missing export for qemu_plugin_num_vcpus
Date: Wed,  6 Nov 2024 09:09:21 -0800
Message-Id: <20241106170923.2976750-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106170923.2976750-1-pierrick.bouvier@linaro.org>
References: <20241106170923.2976750-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42e.google.com
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

Fixes: 4a448b148ca ("plugins: add qemu_plugin_num_vcpus function")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 622c9a02327..0fba36ae028 100644
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


