Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D51CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTIm-0006Zi-D8; Mon, 24 Nov 2025 04:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGW-0004nW-2U
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:53 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGR-0001pa-K3
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:46 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b3c965df5so2085287f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763978021; x=1764582821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1AdHiWKLNOb+I70h5V8aPENIr+UOI5rPE51IDiCYPk=;
 b=L5WIGFZyMdjT+vo00ZhjnHVGLLefHD33TO38Ra+pHTyKameiRNLbXZQIL3lTTPbZvB
 jvMuzcQ85c+2kz9QYAPdbfLSBJ7M2p9wZLYWWCi3HVm+N6SxiV5tfkwwm191xfPGbrZE
 Q94Iu4DA8dNzZsfmXlSHezLIJmU8D2bf5MiZmry1pl1k4fP0b/xcnV9yNoTWg0Jgv2VM
 FtzSRtmrm1GR8uqBhiatRR0RqvoAVaFxzWycWDpSqtKfFQmnPDvpVkODCUeiV35iDIyD
 6Lf4wawiyCg4bYkj5PEscC23n7IVnRt6FoJm4azWtSrrwMeK0wfBccNAFUQ6S5kDyNrZ
 cQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763978021; x=1764582821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n1AdHiWKLNOb+I70h5V8aPENIr+UOI5rPE51IDiCYPk=;
 b=hTErx28t1VNoxcMbUCXgLrm04ZHsUNQ/NWXkYT8OnH9+XtwnENG6/50SB/Z0sMpTLH
 Lptq7PyG8cVajt8aIaK2LD02WvFM1R7f6HyHKyWA1TD4+4lmzJEcrOUGLRQS9AR9f65q
 siog/X+syDC7roTEykgrCqRMsON7rdEg7EwcVLlHwjAWIcb/1aWRps/wX9+fEGmPE5rg
 UK0tkoEAHZPw8v4z1AbwkVw5pj8t5PlAgDKLTL1LJf2m5934gimoTevBMLqeUkMYQKRR
 H+RLItGO54mv1K0SO3V2amnFfZAAxiD344+sr8Uv25sfwVt15QtAXeBHuOh8Uzcz/GHx
 B2Zw==
X-Gm-Message-State: AOJu0YwLsSJofG1GZOvErloF1cwBgw8NyFl3Vz7N85LCtueuuIgKkQPf
 kEjkeAMGbkoJBmcj4bind/rW52peBr7yW+UlQnTtAGhWrcT07XlhBY74MVEXwLP7AQg=
X-Gm-Gg: ASbGncvueVpDbTEcGvNsi5pp5RQEHRBQJT5jjHErWeVcg0NIHf/kYZHTIq0IBAxk6Zf
 FVje1kZzYmA3SZHP4fd2NQT3LRqYWGxYRp7nxoBoN+RWN/KdUw8thrXTQ5Wjd8QRO6QqV3w/PW2
 Y8WjjgQVSG06YlKFoNX1f+TYfSG7ZvJ+jhXWhP8IZcU98V4zqHYReNnHwEcVKvglivCayyuJFiT
 UDBjD/0nbDUqn3dDUC9YaYsyB5XIbVEMAF35Q6UAdEJeqvw7zZ9MvHGcnr97q7BZTJZ3MnrrKyN
 Jtk73IjTVbtzq60fzWhFztXas/mVespQkrN0MvgHEz6MNlaehA6fvmbcOU8R86hMAuD8NpYPY0c
 ZineOBHgQRUSEAum8d7s5+c2QS4dKMoJAuA7zFY2kWlVXzEXq9oi3UewUH7hUngKd9ZIXlMr0gu
 VYd3ED9Qgz80o=
X-Google-Smtp-Source: AGHT+IENYQD+dsQB44XoexfLHNb/eFVa46Mw2GYbzOjbdkK08P9mMdkiQwgRLCUlr3PNa7yw9icI8Q==
X-Received: by 2002:a05:6000:1789:b0:42b:40b5:e64c with SMTP id
 ffacd0b85a97d-42cc1d0c3bdmr11539054f8f.30.1763978021301; 
 Mon, 24 Nov 2025 01:53:41 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f3635bsm27680374f8f.17.2025.11.24.01.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 01:53:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C753460216;
 Mon, 24 Nov 2025 09:53:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PULL 2/6] contrib/gitdm: add group-map for Microsoft
Date: Mon, 24 Nov 2025 09:53:33 +0000
Message-ID: <20251124095337.537277-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251124095337.537277-1-alex.bennee@linaro.org>
References: <20251124095337.537277-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20251119113953.1432303-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
index 05a2dad2291..8764bf2f9ff 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -39,6 +39,7 @@ GroupMap contrib/gitdm/group-map-facebook Facebook
 GroupMap contrib/gitdm/group-map-huawei Huawei
 GroupMap contrib/gitdm/group-map-ibm IBM
 GroupMap contrib/gitdm/group-map-janustech Janus Technologies
+GroupMap contrib/gitdm/group-map-microsoft Microsoft
 GroupMap contrib/gitdm/group-map-netflix Netflix
 GroupMap contrib/gitdm/group-map-redhat Red Hat
 GroupMap contrib/gitdm/group-map-wavecomp Wave Computing
-- 
2.47.3


