Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E434CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SQ-0004aH-Gs; Wed, 29 Oct 2025 11:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8SL-0004Un-G2
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:26 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S1-0002uO-0X
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:25 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b6d345d7ff7so248221266b.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753061; x=1762357861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYa79bBACSHKuE0pZ4iXVTr8fHkW5hyXRoUJItryceQ=;
 b=mkvN5+c2R/8o6wfpg1U5s/lCbqvpSsn3iXoou324N9ghbph5CODmzxDhtHwWenY0vq
 3CoBoORceNRLEqQWiFhXAUHM04EuYMKE/JTiT/iH4CRQeBV22th/dMz7rcAE8wGLCkCT
 2Bg2R0f4WU1vodjiKBJgvfIKyr6WpCsCDWQHSVul6Lmzyegb8bcuyZAqszyF2Xe9Dtkq
 5ud9ejU7JDIxTYXDCRnAFFDkYLyVQ6fRcbiwqGAdnU4jD+wK7VekbAxgX0DuA1bm4YJz
 qw5HWCiaeRk1liPppFHzCebpInnfz9mzY1ceSTHN5ccS+Kyt6efVxiPv/l0PodUM5UVo
 reng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753061; x=1762357861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sYa79bBACSHKuE0pZ4iXVTr8fHkW5hyXRoUJItryceQ=;
 b=KlxCkjRyPyPvgQEFTTvLgsrHAHD9I+8C2FnKupre4upnevT8wqrUvEGgvyymJRuynn
 BE0xH/MBOqDr+7zUBwtrKkomMAJlY4xejSFXO3dZRxVQs1QSiQMu1//HMUvhkXy+trH2
 BZcTUhhrYl4UUnBPVa8kmAy2MpSRadkzeTI//p9GdQ8r15N9YNLduBpu/kQg3TdtpE+U
 OA/sr9aTzu1Cr8GiS7LrUR51m62beU6LjFpeyIen7zPOIO0ZE/DKTN39F+Xk6jsYys8B
 qhxLvMGiiQ+0axZBsOcwKfbqMV6w4bWA6pyJQmLkxoz8fH0vqkE+Rlx0PnDs4LKu4Rdk
 GYAw==
X-Gm-Message-State: AOJu0YxnQk6d2aQCDKosOn30FlkRlEkzdm6NQ7FRvfs0uuSeaYq3YVRe
 0OoWesRb4xD3j8vxFtdeeTCMB8STpwXRXGB1Q7c4hKrpSXgsyv0e69/cWK8TF3rHhq4=
X-Gm-Gg: ASbGncs9iOsRU3gaqEteur/tHPliEky1tfl0NO21lmh6Y9yLttIloJpBvfxKv8uOveS
 htk9EKMPi6y455F9rr5DxEyct3G47jxrqt+OMxY2h1lB5M4uM0gIn7EYcIBNpAFt4oHdbCV3ske
 WNj3O9dUCLcT7OryVAF+Dq62hlkBHdWswd5Gyd1G+Ohj6/6zWWbpTJak/hSOs79IRjqEfBOIKcQ
 CjJfs0wbX4BwSmhvIEjNNoNDH68HXaL/u4LC5SomvkeMrfJj/OkmefxTDTnpXK8A6B596mu6Z0B
 MTGmwvv2/6Xz6AIO86o7/P9VZPDM/tnZZUrxNQsU+/Cy83Bw/JOIYLf5QpRKFVUS1mKqH8iTTxZ
 TRsuLuF37D3F2Ta3cwidPii0XTdp5K8KSCmKexlntJI6X+R0ih670MlWFbsnXEhqrtMRg0pv4U+
 sF
X-Google-Smtp-Source: AGHT+IGIeUByh2IK0sfxB2LNBgWWquh+c9uJUD3+I6ncNhqMB22dJ7G4NVDCsTEXywasLNBfpxh4jA==
X-Received: by 2002:a17:907:7f94:b0:b3d:e757:8c36 with SMTP id
 a640c23a62f3a-b7051f28d17mr10480866b.3.1761753060791; 
 Wed, 29 Oct 2025 08:51:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853696a3sm1458499966b.27.2025.10.29.08.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 09CDE61502;
 Wed, 29 Oct 2025 15:50:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 32/35] plugins/core: add missing QEMU_DISABLE_CFI annotations
Date: Wed, 29 Oct 2025 15:50:41 +0000
Message-ID: <20251029155045.257802-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Most of the memory callbacks come directly from the generated code
however we have do have a a direct from C callback for the slow-path
and memory helpers.

There is also a reset callback that calls out to plugins.

Like the other plugin points we need to disable CFI as we are making
function calls to dynamically linked libraries.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3175
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251027110344.2289945-33-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/plugins/core.c b/plugins/core.c
index 35a252d2729..8f8bc7219c2 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -668,6 +668,7 @@ void exec_inline_op(enum plugin_dyn_cb_type type,
     }
 }
 
+QEMU_DISABLE_CFI
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              uint64_t value_low,
                              uint64_t value_high,
diff --git a/plugins/loader.c b/plugins/loader.c
index ba10ebac993..0dbe7bea263 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -318,6 +318,7 @@ struct qemu_plugin_reset_data {
     bool reset;
 };
 
+QEMU_DISABLE_CFI
 static void plugin_reset_destroy__locked(struct qemu_plugin_reset_data *data)
 {
     struct qemu_plugin_ctx *ctx = data->ctx;
-- 
2.47.3


