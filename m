Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70183C54E49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIeX-0004yB-L9; Wed, 28 Feb 2024 07:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeO-0004bg-1b
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:04 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeL-000350-6F
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:03 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so65625811fa.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121779; x=1709726579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPogCxF/I1D7c/GvuPtEU4hQQ0c9+qX3NiL8uhsKxPs=;
 b=dD0GeyNPC9o+TRq+VI11rSW+JokwT/ODdvtNK4UB5XCi+ODxGm4WOp+jHMMtcX7Qgx
 JjcY+H/1Jub6tmeeQdZrgvAXi6sxc80dwkTMfB/IbzBvukre2Mqvu1li5lELSVkqHbOD
 /qjtqQ0/BYGn+ljGXUUu5rO6oeVJ6sNSRGH1kQnKy05hoSNLFwUSSbSvpkTxY1xp0I1R
 n1rka+N4Vr9KJUfMWUwAWZFZ8wyRtiEpmbsB3sueesKD93IIQsjPzpbDqlJi3fx5T+oG
 LiGhwDNQveJHj4gsbn5G0BWPP5MejP5/X67XBK/t1tDW0j9oxIoVKN8NbmRedik4OVYJ
 Bw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121779; x=1709726579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MPogCxF/I1D7c/GvuPtEU4hQQ0c9+qX3NiL8uhsKxPs=;
 b=TksLgPFAvU+TWnD04PakgK2CUCGfDkOY1My4mug+jFYQldK9NhBbKz8IRsgL2e7ZS0
 U98pM/qTQowEeHCD6ffN1kL9mclvVlASatFCJ1/gNM4aZfmLeGaJZMesg9XK3ouGPaCW
 ABUQ/EtMzKdz1GeQfnLTLgO9YFLQXMQDoXFutJZ2TNUvhBu/gKF3CXn5NFJqX1kb/8nW
 YBPBU6n42stTqYX4F+nwg594unJZJPttDF5dK+tNKh5092rHXzZCaRKOMI3oxtuf4BoQ
 64Q7/nw5uODXQqXPlCTPHSzzc6i0MEgQ27oh9KKJEVxIP1ADTrBxVJuwL46gRAAYn3zJ
 wxbQ==
X-Gm-Message-State: AOJu0YyboMdo4A1rYRzgz78yYt/5OY8mjbEGG1EkMBkmHBEbYUwwszOd
 /VqM+Av3VcbH6ZybOup9uW8vA0iecJhwo5geU/evyfzlTjjas0MqAarsxxhk0DM=
X-Google-Smtp-Source: AGHT+IGNZzDF2+hraEkK9pCPUTkNS4ST/Y1wSwc0D8mcJoLzxIILrvHsz4+J+Uh7dCZCHbqM7mVoKw==
X-Received: by 2002:a2e:834c:0:b0:2d2:463b:e991 with SMTP id
 l12-20020a2e834c000000b002d2463be991mr7666566ljh.29.1709121778934; 
 Wed, 28 Feb 2024 04:02:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s11-20020a05600c45cb00b0040fdf5e6d40sm1945992wmo.20.2024.02.28.04.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 04:02:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9FD875F930;
 Wed, 28 Feb 2024 11:57:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 29/29] docs/devel: plugins can trigger a tb flush
Date: Wed, 28 Feb 2024 11:57:01 +0000
Message-Id: <20240228115701.1416107-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When scoreboards need to be reallocated.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213094009.150349-8-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-30-alex.bennee@linaro.org>

diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index 7302c3bf534..1420789fff3 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -109,6 +109,7 @@ including:
   - debugging operations (breakpoint insertion/removal)
   - some CPU helper functions
   - linux-user spawning its first thread
+  - operations related to TCG Plugins
 
 This is done with the async_safe_run_on_cpu() mechanism to ensure all
 vCPUs are quiescent when changes are being made to shared global
-- 
2.39.2


