Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321A9CF31AD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgXn-0002zy-IJ; Wed, 19 Nov 2025 06:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXY-0002qv-Mj
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:02 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXX-0001tU-1o
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso7002965e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763552397; x=1764157197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63iFUpPNC5YuIoBQc2FwNOaqtjMFWESDJWVTrrUl1PY=;
 b=hsjwLhBZ2xy9+Yp/CeZjuDItkorVYb+UR1beQJHNh23/9q2JsxCy/5vWqoRDB2wzEs
 ghdnGnsmXJkU4dLQ90M3V3d1eG+axjiuk6PdVpv2kTs7QPTT1ECCFFsyMNICOjFJjZ0v
 +1LS1zvLFqsR1E+ijKE/BxIPCIiBLKl96h0s4m2midDw0FwvL4emG8GfSnX+P6zwCUv9
 qctozXAU0ImrjRCKpOV8YV36s74LRijmk2KYWtO1Mj7SIwMth43hXnBnQqN2MrDviG+x
 /EdMdKug0FNQ8BI2hRXghK/AICF/TiOjm5rJtFmcHa3TMMFlarIyzUCr3G7T08kiMFTq
 pMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763552397; x=1764157197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=63iFUpPNC5YuIoBQc2FwNOaqtjMFWESDJWVTrrUl1PY=;
 b=MhoQMta3NNVOWw26AuXWXK6eIvGeSAuheabsndP5VVsL0C0K8XUexad5fQdWfpT/B2
 laxvtILhyQh8xAIW4lNTUjseXh8kR6iYe791EZx2PzVD+jaJsy03jciXjVmEaa8w8axP
 GD1qSq9tgt6glgjgrH2Oc/IMr7gDc95HUiB/dh8UGlvfSFooNkbDlydn2AeKpJNLPv7v
 o/ZhfIPMHnc4gG5GNgaa0wTtJrDZ7OWBcMlcryNl+FdC+YcR6P5UA93ZsiW24b/J+rm4
 Bvu64IidLEM0hc7bdMP0jMBXjgBqF9sEI2eGMOuEHHzIqgXQgG34cf/LlfIhyAYAWTaC
 i48Q==
X-Gm-Message-State: AOJu0Yznt560s4HDfFyzAMFnHDKZ99KIDdj0/wajh/KM/zG7uVagXj1V
 UuX/uaAms485hpp7V7SbginzJCQnwqr72jLoELdbulFnY8JYQdBRcrZVRfunfwSQ3s+Pt+W8M73
 RAsJ3
X-Gm-Gg: ASbGncvT0IAo4HFgbEm7WrJExBVvIyDrQBwWolKBT6hlIoGRsT+7Zk/4L9AO4/OnaHe
 HxuQ8Wc2WbjIn7g/2mVHAGJIDpyxrUCaH5SGuML5tCNDHYa2ZG4XfCjjtwnq/4VcZFO0rCxkrzs
 QrQl80R78r4LP0qK5lr2oyLuCgNGJBi+MpcVjG2udmXdD5lC/ChPvO1IeC8xIcn9ZGiMadDiN5d
 soY9kzhdSq/zACZMycqoQ0mX0El3QWiWWNryEjqtZniZaMaRbn07MJqqJSFCrUrjJ4i0Vzpl1mu
 pnXwMdM0ilS58HUF9vfiRfjm9RaNzMWQGHYrmPXpn/OvAHxtPfR0zmLiKvSqtceS5/j2jJSNBQ4
 26Dc+H/0G7jYwekXjJAxjCSFBU1m3ogKpNXPUHU2049D9/9XAkktY36rNBVMINhKLth1YMqfWDH
 gglZ8laRZNIGQ=
X-Google-Smtp-Source: AGHT+IHS7V6+W5gohjYHnFRU0MFBKD06SaibLMsA/OkXcgE2zyODUPjrnLqbfSmgt5A2iEL27kkMpQ==
X-Received: by 2002:a05:600c:b93:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-477b18efb58mr23587075e9.13.1763552396912; 
 Wed, 19 Nov 2025 03:39:56 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b0ffef34sm43885775e9.2.2025.11.19.03.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 03:39:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 982F75F8C8;
 Wed, 19 Nov 2025 11:39:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 3/9] contrib/gitdm: add group-map for Microsoft
Date: Wed, 19 Nov 2025 11:39:46 +0000
Message-ID: <20251119113953.1432303-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119113953.1432303-1-alex.bennee@linaro.org>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
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

While we do see contributions from the top-level domain we want to
catch the linux.microsoft subdomain and those contributors also post
via other addresses.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
---
 contrib/gitdm/group-map-microsoft | 8 ++++++++
 gitdm.config                      | 1 +
 2 files changed, 9 insertions(+)
 create mode 100644 contrib/gitdm/group-map-microsoft

diff --git a/contrib/gitdm/group-map-microsoft b/contrib/gitdm/group-map-microsoft
new file mode 100644
index 00000000000..989a307b6db
--- /dev/null
+++ b/contrib/gitdm/group-map-microsoft
@@ -0,0 +1,8 @@
+#
+# Some Microsoft contributors post from other emails
+#
+
+# Some posting don't use the main domain
+linux.microsoft.com
+
+wei.liu@kernel.org
diff --git a/gitdm.config b/gitdm.config
index 2d75dd4deee..8206c0af8a9 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -39,6 +39,7 @@ GroupMap contrib/gitdm/group-map-facebook Facebook
 GroupMap contrib/gitdm/group-map-huawei Huawei
 GroupMap contrib/gitdm/group-map-ibm IBM
 GroupMap contrib/gitdm/group-map-janustech Janus Technologies
+GroupMap contrib/gitdm/group-map-microsoft Microsoft
 GroupMap contrib/gitdm/group-map-netflix Netflix
 GroupMap contrib/gitdm/group-map-redhat Red Hat
 GroupMap contrib/gitdm/group-map-sifive SiFive
-- 
2.47.3


