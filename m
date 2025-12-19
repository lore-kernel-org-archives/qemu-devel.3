Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B67E66882
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 19:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfqZ-0000cn-JS; Fri, 19 Dec 2025 14:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqT-0000Zs-En
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:08:57 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqP-0006nL-RA
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:08:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47a80d4a065so10311625e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 11:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766171332; x=1766776132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C22/vs2ZfJSDD5oYLXLbIlcB/xOvGQzCI4efey47eBg=;
 b=Z5g7qCdcGVC3M69Jtop0aljbgmXGI/zbMj9VnadVKdnaFVARr7FPzLFwOrr4knzeH8
 Bh/vumKANatVEYRDWYiBz/41o0ZcvZjxQHkLp2AHPhOGX0d5L2ymgCs73aU1krv7VvgI
 qQKM+uUAqJWzihyHjZgyOLXel1ONKJq+pgrOP/373RQRzyczVDugNZkSOQ49Jcqo8KkD
 Gw/z22ZPZdxkrHCHYOqOp3t7ZqTWpS+LulRFP7hmB9R6eWmGbxEnw2KGOuAwTQ5CqWXL
 SMGSAPQZrmJ3AXmzV4wX8UhvxdiZOpR173HQQhzP71HYk2dsiDlgKslvmwKaMuK9MlSO
 XNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766171332; x=1766776132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C22/vs2ZfJSDD5oYLXLbIlcB/xOvGQzCI4efey47eBg=;
 b=IxZdGK0JMZU4Y5BYI1B7rqRQR5zlwSnUBX3e246UDJRVRrQhxXyZ3susQASrZrdDhG
 F10i+x65npPiscqcs8NHs22mFG6Vz5PQbwo0ar/okUoms6oqcZKNtB+8N0olKDIhY1uL
 d/L825xazzNJmQGVtukmFOtFx255BO3O5byqNVFt6CJDxyFY/LhMIp3XNKrcPFpWCvNh
 F5FKjZEKXJcYkZpblqkrN/OJh8X57KqeUbLiSP289eXBmz5JryOvvUO7D1RoB1HggUqe
 r3RuBYMTIZQPXCNiGtnUweS5IVFyo1Y2I7CC4ypCN4mmYXMqXR1ItPnFELnsYOTTwzV/
 gohA==
X-Gm-Message-State: AOJu0YyZKdalO0KmnbV2Rquzw1EWgFNznxIwEtBrcntqdqXNbAUHLphT
 S4HfdYoNQVZmuOmhuTT4c3YLpnkzT/YMnYb7Xt45AQMY8J+220xSY8EOHRxrU5bI5gA=
X-Gm-Gg: AY/fxX6rki+KiAY1grXNSwOrq11u3dUoGqkIIhEMpzGJtGrPhf1yPXJya25fi488oe2
 KhVcFOxwc03hAbdNFEOBovFEi47SLUhsXQNfAR5FhGfhqhQhLh8f7lTTvUJ5cDr0F+5tZi8aKje
 TQUFTb55qp60GXHhslknZmeVlf/0M4O9JKse2+WVShtHrz7nw+4xBBF6p3S+llWftJIhm2cjmJ/
 W6ZsCokOg0f7ryTXXP4h53JvH0z1XiBbXmH1WdzwE+aZbgvLTHbjaukjsqdlMuSWIqJi4chlR6b
 592WcAmvL/HUagkKsxwg8cK+dqmgHnKJD4xJ7qpP4hqihys3tMflqGNwzY3x31wTrRmxm9Ucb3m
 baaogC3DwXvukdGjpZZOC2rg+peqe1bvabqT0k7wZQLkdJUfNSlZ0kpa3v3u9io27P7Mq8Vnjoz
 A8+HXOEuGn9l/DgAXBgDobww==
X-Google-Smtp-Source: AGHT+IHGmEV+VQa78mOCnE5VmcRAIGLmwzvCTF2gan22LhZ2i10uvCYF+aQhAqQKrce5z+W5dw/AWg==
X-Received: by 2002:a05:600c:8819:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-47d1957b7aamr35236735e9.20.1766171332138; 
 Fri, 19 Dec 2025 11:08:52 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b0d5asm111088195e9.13.2025.12.19.11.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:08:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2463A5FCCB;
 Fri, 19 Dec 2025 19:08:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Burton <mburton@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Bradbury <asb@igalia.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: [RFC PATCH 03/12] contrib/plugins/hotblocks: Print uint64_t with
 PRIu64 rather than PRId64
Date: Fri, 19 Dec 2025 19:08:40 +0000
Message-ID: <20251219190849.238323-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219190849.238323-1-alex.bennee@linaro.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
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

From: Alex Bradbury <asb@igalia.com>

qemu_plugin_u64_sum returns a uint64_t, so PRIu64 is the correct format
specifier.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <46f83ac83c6cabace91b9be85da2547ff7b08204.1764716538.git.asb@igalia.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 contrib/plugins/hotblocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index cf4d6b8c363..40d8dae1cd3 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -87,7 +87,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         for (i = 0, it = sorted_counts; i < limit && it; i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(
-                report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
+                report, "0x%016"PRIx64", %d, %ld, %"PRIu64"\n",
                 rec->start_addr, rec->trans_count,
                 rec->insns,
                 qemu_plugin_u64_sum(
-- 
2.47.3


