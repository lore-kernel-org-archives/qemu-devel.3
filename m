Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E31C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwOR-0004WR-9Y; Tue, 25 Mar 2025 01:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO5-0003yx-Tm
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:42 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO4-0005vk-98
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:41 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so6729663a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878779; x=1743483579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVYa7fx+hqBI4AoRMYooEEzjwHkUuA977fGAq/tYFYA=;
 b=Fo9Jdfd2HzEwy7ULS/jtJiDDnUkEyur2N4qFzQYUkGs7DNO5nJ1FZ/jEr2SZAzgfVT
 sCHqP14I3lUJa5wBv38mbTTAIiC7syKYOGBaJ9Y8qi4v5SlpthZbvkRbs+n7zvJUoBEu
 WyQsDDByOKUMP4rNZUwUothMrpTjOOsNIzw53Fu2uvDKA93WZ9MBXCW8R3nxlydy4ahy
 oEMRMBooseF6at3EnNrXp1+OOtELy5MR1dItV3FMtULGHec+8OFoT9e3qNUibpI8uAbk
 Rq5oZ9BmfMITIML6FQNTuHkv00SaQrg8N266fiAuDc0535f5ATznrJ6sy8TGgsAPmMjN
 TS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878779; x=1743483579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVYa7fx+hqBI4AoRMYooEEzjwHkUuA977fGAq/tYFYA=;
 b=q7wEWmh3hmtdhnA1pGIwU/19MQMKOj3AcXID8N0e1lTntoUah41Bwb8pNVBiSPpOGR
 0Q/lGR8V3heRjkCHZHkHxk96ctWMMvOcKEo4rGQcyPerL/Vg+obKmunzJVVxTjrTFbPo
 G7KC/BhN4N/rJ8iX/EcGl/3AtF1nzKy7CP3hJyqInQzEvcf7ul53ORFFlSdRbYrzQox6
 aKatdqX0u+Hhy7qTpyLYyqxifhkjHzM4u0fQn/A6UNmEKgiMrjMFABg/QSa1BWd33Ahj
 P+2xEevJAlrvbu/p6Zpff3iuJS9VHE2wTv5DhtN2hM0bwonRgZA34S5Lel+3xYand1uo
 pEXg==
X-Gm-Message-State: AOJu0YztuosnkY7Rur4oPhdUSzYhAE3g5J4u2yj3EppQwM+3zv4+JgZL
 /EAySvah42AvlGy1I8KvAmTuRBrxgWPzqS5l8o3l976IbV0pFG2ftew2tNVXXDQcY2tXtCAL0ht
 t
X-Gm-Gg: ASbGnct6rb6V8fMUToMdygArie5q+6prSaRxKN+hoknj1zslkgx2JoW7sJlWDxU1okT
 FBV3LTAG4vVgotVFL41VSVszvdK2jL1n6F9CjYqOEnbJByEtKtJh8PX9mOzf9ZvqMA7ESnE5n6a
 ituzFSMarSYJlNtENvcmGFugoDvHQz3B2jXkVLOJTJdv87rBaf9CetepDzz7RohK6KWbbGXq72V
 8BAdibHOJDxfAdGE4xwzMwumSkgnl/stqb5/We+GGzGkBivEE7bs8AfjWMQ9mkKES3ammg6AWb5
 Fza9XMf3n1aqoajLjgFfR5zidkR/tAHn+oeOlSVyRhPH
X-Google-Smtp-Source: AGHT+IFQAPoKluqA11lspPIcUM+K4oeubg7R44UKiLeIG8htmcgA7CTFmMh6CBhixpXbl9nw4lJFrA==
X-Received: by 2002:a17:90b:35c7:b0:2ee:6d08:7936 with SMTP id
 98e67ed59e1d1-3030fea53b6mr23779109a91.20.1742878778703; 
 Mon, 24 Mar 2025 21:59:38 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 18/29] exec/poison: KVM_HAVE_MCE_INJECTION can now be
 poisoned
Date: Mon, 24 Mar 2025 21:59:03 -0700
Message-Id: <20250325045915.994760-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We prevent common code to use this define by mistake.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/poison.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index f267da60838..a09e0c12631 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -73,4 +73,6 @@
 #pragma GCC poison CONFIG_SOFTMMU
 #endif
 
+#pragma GCC poison KVM_HAVE_MCE_INJECTION
+
 #endif
-- 
2.39.5


