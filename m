Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37299C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdt-00021T-SZ; Fri, 17 Jan 2025 08:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmd2-000142-AH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:16 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmd0-0002HZ-DM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:16 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaf57c2e0beso431614766b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121393; x=1737726193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V25rdshuWsL/Iwjc7wONea+6ItK7iYQ49yGh8fic0Lw=;
 b=LYjr1+Kb4Pj++4sILjbE2aZzGOT4VZQ8doWxoQS4Jhi9HaEXFlsYf+NRtW2FX1qKyP
 B3k2melCiR8lBRlzCfdzR/xdVTLZ8EuHq3osr9VK1rgY8e5R2/2YSQxxyHcubTXbLJSF
 LuLsVn+10csz4MarnPWkRGPJYq+QhW30/CCPruyYBb+EemiaM5eSFyggGY+6yMIBFTkE
 SdW2qpKWXPUbUdeKEOicmfjEFFwLfEIkyZShpi/45fObFMQaX8tHKqZEUee+R5K0zzh9
 JXN7+0E94/pDUV/KgQtlYshdi85L56HQTncI8E/fGDjnrjKxmRNNuMYjhtQz01BoZVx3
 0pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121393; x=1737726193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V25rdshuWsL/Iwjc7wONea+6ItK7iYQ49yGh8fic0Lw=;
 b=bJAD26sGQxHDs5NufPuegY5WaOfLRD27zNziBaQCXRb6CIeBPGYQJH968UXxDl70mH
 SqX2x1Eu1uYtIys/+ZzUNhwAwfN9GP5zWbfHwoavhp4zn7gOdZZdfT+bRF/Mxal2Jl/P
 DlVYHMzA7arQcX41LiEWOQHcQnWHkIfPEmxQF22shUP4meFhEpazqZdsUsyqEFdgc6BM
 7OjflLWU4E7enmDhosCM0h+EO5GJkCGmFjABEWhF3C0XUnhQlMtzoBGlYsHqPsXa21TU
 edKRUnYPAJPz9ItU4MmjDhhlVEDXDscg9dGIkTXMdJHg6lO68aWNSwwgzM7QaTOMXFtR
 B0Fw==
X-Gm-Message-State: AOJu0YzGzlXE1O1hBLscpgPkrBzz77ZTCDP6g1aF8H7QFSMBoOUvv2Iv
 MZnJR2dmSfjgJm9P4E+QFXOp813j+RCC7oL/xJL6IXnvYEUMnfNVN57j+gOXkus=
X-Gm-Gg: ASbGnct1FV7ig5b9ZVbX/yXjU3UCldyghEHIfFz7qB9PhvZB7ol0RfwPZMeNhsIl6+s
 F0r0URttLqI/jwUyA4iLa0dZ4q9J6HuvfYPI1dUqV3aZspUzkyXALOadt8iti7KRo5x26tG9HU7
 7ocIWb2R/aKn1bgT/jaDbnYScMonXnl902m//KzsOD65mTTLzli/buwLG9OHJkAFVrwQ1gUYjfP
 W5cVIjT9AJUhlSmSnlkhM7XU31bMnzsyCr2SSiDq8O0Ae08/gtL0gA=
X-Google-Smtp-Source: AGHT+IFtnfSdunR5M6gm4uB2EhZNqAW3bEeL9NB/Jb/BnMVUN3qY5OY9ZTy/FMFghU9ht9Hi71YPhA==
X-Received: by 2002:a17:907:1c19:b0:aa6:acd6:b30d with SMTP id
 a640c23a62f3a-ab38b4c63f2mr249497966b.48.1737121392679; 
 Fri, 17 Jan 2025 05:43:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce20fasm174375166b.66.2025.01.17.05.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1005A608EF;
 Fri, 17 Jan 2025 13:43:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/37] docs/devel: add b4 for patch retrieval
Date: Fri, 17 Jan 2025 13:42:52 +0000
Message-Id: <20250117134256.2079356-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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
Message-Id: <20250116160306.1709518-34-alex.bennee@linaro.org>

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


