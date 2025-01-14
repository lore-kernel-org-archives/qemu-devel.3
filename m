Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9ECE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFz-0005FY-E1; Tue, 14 Jan 2025 06:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFm-000586-B8
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:39 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFk-0005Rw-6G
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:37 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d3d0205bd5so8202267a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854715; x=1737459515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rem+PqKJwtTryCp5+P2h89dN9I6AHO+TdjB2QsczI6k=;
 b=HCwijRHQX4KtBUQ1rV9vfaEQA0knAV31yJpJI9J9JpCyWV4c6oBsWbXpRpXjrX/03N
 vTWCEttGgS2lt/fDSRqUrXS9dIU95Tufklr84u48zXYLr6xMMVJBiL7txgE/2dYpJs7k
 Zq/8IqsZJMWvy/umXOIKXH7EsLxUv4ho0mW9fR5nZjrmjSwrK+pSuP9dAX7ukZkfGn6g
 /xAjaP6INOlCFrrffg3aNXKmwH6r0MLkdVPlC4erHFzIOmWoot4JERSJEsZZM3+dzANu
 UCiIQ3NgtHRGQg70NO3MU1Ias5orWZqkknjAwk/e4EqctyxUcOAsfde1RB6hEEs2zd/O
 RE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854715; x=1737459515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rem+PqKJwtTryCp5+P2h89dN9I6AHO+TdjB2QsczI6k=;
 b=HKNobZCY9ObC2EkJZX+TlNcM1tuMf2/3oMcBPVCyHkQpJcUgiYvn+b7Wv/wHihZO+L
 XWj0cHUcOwShUcf/gSh8gQ/8VaMbAmOPShfJbixwl7wVyNsz4AtejQVPo2WobFLCLNe/
 dD7iJ/IczPnJvltisI0AKhPIJd8W9BCKWrccC6dhdphFls3UYi0/Ayg0kwUWY5qiPVEE
 cuAbkvvfg5/my14WESqlbdXpyx/Fx3668ypbaeWRjVaMbq5kjCNf0opz8Zn18NT2ii1i
 A5ywV6nlsxh86S+911/GBVYa7bp/Fit0tpF3Zu1wWr2eAx4wssP7h2PM7UdaEmlHen7k
 lMWA==
X-Gm-Message-State: AOJu0YxYg8qLKX+vjwE/NHXoVvBvkEmnpwBGjBMXCBTqPFRj78vZ32zJ
 rwCykSklBNYetIuJ7xR48vIauSjWVGEGdmdKPHSbhdM0t2NIpnNuJdKrSgq/sCI=
X-Gm-Gg: ASbGncuXfG/0/57IhxD62CHLEN+Xl4JusCzoXOnx0+DHpDlWQg/GTVdaOjlfdihYcp9
 npPmvgMjkXB85vhByVRwyulHHHdeN00LPPTPXRvWXHD8lwXjqOGOyph0Zd11cVS2/jz4wZrgVXV
 FUa1t7BX97xJumDu9Q2GhAChn0GutwKJGvnKFOzaebILzepDApkm8c7hLA4vX4K0MizLU+LMkL6
 iZLCFYabU9bFU9lLmb1LPxelI5zsr4K+rB30GYDVdL26t8IyPT2v4k=
X-Google-Smtp-Source: AGHT+IFoaWY4h7fBZuQrDxOq4ZsslzzDssSeH/U6q/T0SB/sDE2XlJwrb9gUK/QOasbvjpSlptNKYg==
X-Received: by 2002:a17:907:9622:b0:aa6:af66:7c89 with SMTP id
 a640c23a62f3a-ab2ab670587mr2365693266b.5.1736854714725; 
 Tue, 14 Jan 2025 03:38:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90d73a9sm622380666b.58.2025.01.14.03.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E39A65F92B;
 Tue, 14 Jan 2025 11:38:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 33/37] docs/devel: add b4 for patch retrieval
Date: Tue, 14 Jan 2025 11:38:17 +0000
Message-Id: <20250114113821.768750-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241209183104.365796-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 69df7682c5..65c64078cb 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -433,6 +433,20 @@ For more details on how QEMU's stable process works, refer to the
 
 .. _participating_in_code_review:
 
+Retrieve an existing series
+---------------------------
+
+If you want to apply an existing series on top of your tree, you can simply use
+`b4 <https://github.com/mricon/b4>`__.
+
+::
+
+    b4 shazam $msg-id
+
+The message id is related to the patch series that has been sent to the mailing
+list. You need to retrieve the "Message-Id:" header from one of the patches. Any
+of them can be used and b4 will apply the whole series.
+
 Participating in Code Review
 ----------------------------
 
-- 
2.39.5


