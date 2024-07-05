Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA8CC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPec6-0002BE-Dh; Fri, 05 Jul 2024 04:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebL-0000wg-NR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:33 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeb7-0004BL-Au
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:30 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a77bf336171so194562066b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169234; x=1720774034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42dfRSdqLtSCAsO34FUpCEGuS1QIkfM9imEkVZpHhnU=;
 b=GfWbHettglD/1qZJ+xJdCZ4Prn2MdsbYFm4H9gVmVkC74u3N0jmiZ3/4SWsHuwlvIM
 xxywDdITQJyAEunfjBTpvZfz3L2Cys/AiyNNFN4eDPELh+ROI73+fSGfC6QXgL0uDs6E
 JlCWzBF2Bj4WiX1dKAX4T6ojOQH5CG+cx9XAyk++eS1n2D2g6K/AhPdtIcO2i83wlG0w
 N+O+0RyTdI6S2y2Th7Xe4zSBj89lWeCmUVfJUdwOPMFhw0rzikfkXm4I1vnkIqDLdQsF
 P1LNM+gRlljvmNrNVVmD9ESNn3VhhLQaxDuzE/UKUxmVIx4lHLsiyK8wG9lZf3Sue+a8
 8KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169234; x=1720774034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42dfRSdqLtSCAsO34FUpCEGuS1QIkfM9imEkVZpHhnU=;
 b=PAGlG+eZE0j4DT/AGZlGEtcpLXsEEN5nmDUDsjMFxwW0hZm1lZWo4EAfdpfnwnedzy
 smRbmhgh7lfcSnt8AKqXY8xSd/4KMbhPR9EeGqP/gni2A+LgkmeEOPDxrErE9tScWVRy
 nb+sNrPQayJ2nM19VAliGN7YEOIeAfVeDTmUGWxTbKvlwLnG/2oBIn4pUUxh21Fn64eo
 oppRi7UuhCKS/uHf2+rB4HzTKM6v/pOQolNGRF0mPX5DyYf0F5qGvseQ7FsxPX9ISghx
 8lMMOXoKh7gssmuRFyvQbBYB0B95GezGn/7ozxeHNQrFdoMpnvj3SWeEFGktdFKhWTu1
 KRgg==
X-Gm-Message-State: AOJu0Yy0rFJSmeu1hOXOierkcoLHPF9Q9zUznYsxZYbhRVnFgoCsA8fz
 a8EdFQdP+HNszyNSj+LYqu4TCPf7XSFnDX0afTRsZ443xnps5cObC/mlny2hYUM=
X-Google-Smtp-Source: AGHT+IERQtXO/lSildv7YfdLiTQqGhIu/s50ufihwva0gyWZEBGvTmIMU0XYvjX4tHT7LWrcdNsuZA==
X-Received: by 2002:a17:906:348c:b0:a6f:6337:1ad5 with SMTP id
 a640c23a62f3a-a77bda9cc3emr285297666b.27.1720169233689; 
 Fri, 05 Jul 2024 01:47:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77dade9b61sm3514866b.160.2024.07.05.01.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:47:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B2346211E;
 Fri,  5 Jul 2024 09:40:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 19/40] linux-user/main: Suppress out-of-range comparison
 warning for clang
Date: Fri,  5 Jul 2024 09:40:26 +0100
Message-Id: <20240705084047.857176-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

For arm32 host and arm64 guest we get

.../main.c:851:32: error: result of comparison of constant 70368744177664 with expression of type 'unsigned long' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (TASK_UNMAPPED_BASE < reserved_va) {
            ~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~

We already disable -Wtype-limits here, for this exact comparison, but
that is not enough for clang.  Disable -Wtautological-compare as well,
which is a superset.  GCC ignores the unknown warning flag.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-15-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 94c99a1366..7d3cf45fa9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -843,6 +843,7 @@ int main(int argc, char **argv, char **envp)
      */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wtype-limits"
+#pragma GCC diagnostic ignored "-Wtautological-compare"
 
     /*
      * Select an initial value for task_unmapped_base that is in range.
-- 
2.39.2


