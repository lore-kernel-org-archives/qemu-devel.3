Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94FCD6552D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyxh-0007le-C5; Tue, 26 Nov 2024 12:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxd-0007id-VC
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:49 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxc-00025j-3v
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:49 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-382610c7116so3155432f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732640566; x=1733245366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bia3Nu7mTs0/BpblAmMLwXurER5c+Mz/qR+4adC7kjU=;
 b=IU2mHCcQ5dlkAAZTitleBHD92plO4NoMit/+3XiQa+a/UcHk59Ihc5b+Gd3C6+F/da
 OlmR7J00bKt4reOIS+pysp1HcdPQ+3105noJgxD8PO8wl6tef3yCpuS7SXyg+UZRvHO9
 Yqa8fVIZffM7YLN40tIDca6VSnyrsj0iPauoAIl3LUAC6OLKAUPeiKb4hxZnp757kQAp
 qoj4SMOWaMBdv0G4o5IiglqWw5F49q+s1pZZsqrFwSuvPqxanVlR22QOvgt+tgsttEyY
 KVeqJ3oNSDziXDdMX/DF9dkwQkqQV2Z9zifLbdMHynKNtW3fw4GXXUzzaPV4fMn9s3u4
 hHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732640566; x=1733245366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bia3Nu7mTs0/BpblAmMLwXurER5c+Mz/qR+4adC7kjU=;
 b=KwooMzjCPFmSLxxTr5ZsEWc8HqaHZn/tYHFuHcb8blTIg4Wg+lIv0ytuR8+PugDULn
 c4Y5jb5JPbGe95dXeFMfsgQOgXE193jmkVasu3wiLisPjWyJV+gsJLb6Sa3Ig+Vc5NEq
 h0QhGmGMH2lfeK7I6546iwOuIS6KNT+js37QkebmKb8bGhhNghU1sPznO/RD9cosl75o
 NCEk6f1ifoqtq3MGRZaLAQ2QRtX2o1BcnCYmCkDnV0C1CpgTutslsNGGnDW/z7uAQDxB
 N8xjcLQ5EdZNLYnqr5b25Ygurq6MRaGboNiF09i0CTVTAb5mpVhdEjSjxE2HJr1y15N8
 8dPA==
X-Gm-Message-State: AOJu0Yxk+0AQrhLQu0YYPe7mrvARuvwH8iJuCs+G1zmdtZd+a8pgqVIw
 BTyIhYHI6Ar4VMNyXMVIxRB2fmw/6GLW5aU1fgdSdnav9Px6fdmXPecamOHqbb25Em6KWUE5+qU
 w
X-Gm-Gg: ASbGncu4cvDLf82o8NaOj8yJIsb0N0rqqUG/4xhVMeePjy0NscWmdd9YSmN59XF0KHF
 g/CEfmRDu8SNlWFBuW1FI9tl4SYg39sNCJblmdl33sesidAbHG25vTg5EU8K6OvZ67eDc/Cz6Ex
 7iUo1WEQB5mfGTo/w0+mucf4Li8PHlx0rW1HgGjIKoiC4wDO+wCnZN/UuM5ots5Mqth3OaI6l4F
 JfyR5oCdmWeSF7dnlQ5diC5pZ3lar6sJ3LrIFN0jsee1tkE6XX7WGyZ
X-Google-Smtp-Source: AGHT+IFBJTnwIjGEQcv3Q1Y1pKLdamk4Zr+ulniyLFiRryAYAoC0jnDo03NEXNrLVP+SYYLecxmkog==
X-Received: by 2002:a05:6000:a18:b0:382:49f9:74bb with SMTP id
 ffacd0b85a97d-38260b8c87cmr16058185f8f.35.1732640566420; 
 Tue, 26 Nov 2024 09:02:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a36c7a9fsm43017865e9.44.2024.11.26.09.02.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:02:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] docs/system/arm/fby35: update link to product page
Date: Tue, 26 Nov 2024 17:02:23 +0000
Message-Id: <20241126170224.2926917-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126170224.2926917-1-peter.maydell@linaro.org>
References: <20241126170224.2926917-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241122225049.1617774-8-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/fby35.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/arm/fby35.rst b/docs/system/arm/fby35.rst
index 742b887d44c..bf6da6baa2a 100644
--- a/docs/system/arm/fby35.rst
+++ b/docs/system/arm/fby35.rst
@@ -12,7 +12,7 @@ include various compute accelerators (video, inferencing, etc). At the moment,
 only the first server slot's BIC is included.
 
 Yosemite v3.5 is itself a sled which fits into a 40U chassis, and 3 sleds
-can be fit into a chassis. See `here <https://www.opencompute.org/products/423/wiwynn-yosemite-v3-server>`__
+can be fit into a chassis. See `here <https://www.opencompute.org/products-chiplets/237/wiwynn-yosemite-v3-server>`__
 for an example.
 
 In this generation, the BMC is an AST2600 and each BIC is an AST1030. The BMC
-- 
2.34.1


