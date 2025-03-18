Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B24C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOvn-0001KQ-Mt; Tue, 18 Mar 2025 00:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvX-0001EN-Fd
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:50 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvQ-0008S1-FL
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:38 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223fb0f619dso85478595ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273494; x=1742878294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qcqbwr1tVieUFzv+VyvLW43sytu+qG57UDVEiNckHsM=;
 b=gGMR0+ebnWltOhA42UyQrGS+6d3lbdI4swqqOnbN5qPlGIY2bNJIP20MaBXOdi7/cx
 fVUgSvo4JS3wAzCodrdmcZlF1wyV9BczRIzgNnF8yE4zOafYdKFHkwABew/5kZPuCSGy
 2Bpny+Xz2SnS0He85DsXjaqra1+ITm8bmHTd46aOA4u91LXUhKxfqpsNDuq79DB33Kzy
 sdrOMp7PDU1iJg558vc7QQoWeroAnOAv/jnaheSmUeOabhEdoB+4EcmEw/DFUeIC/PRH
 NetPUIIxOBb7qQmgZGjxGxIMVIjwOML9hDbXI0ehN9uTC8TNa5ApD2Do3yGa+AF4nd2i
 CiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273494; x=1742878294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qcqbwr1tVieUFzv+VyvLW43sytu+qG57UDVEiNckHsM=;
 b=opnxorsD3+ofwx3VU/TebytGV3LV9J8ybuePP2oFAtyw5W7+K4DHZS39khaqHEx8y0
 sVFJQzu4CgJ3CkXDxqnCiZcxueA4S/wyonVbRvwo5LutVhhsiIloCyNGEah4UaIBmTuQ
 yFdSyRmCEUkquNBYH/Vw+9D7HjKZRXzG4ayI8o3aW/sMM9yyzHPyWMQ7QhhH4YhwcdZV
 QDXjVqm6o+iZ09EvpG2slrdBqsr72wkS1I/MWK/EHb3IHsWth+e8oVN19ibN3ooCPS4o
 ddpv9RtYNtZ/3zgSLLufc4U7QfjonHb5x7aySCRhP2C7GrbQnDtPRDXtFNnKpp14DsaZ
 c+BQ==
X-Gm-Message-State: AOJu0Yynfhs1r+5Y8VldBFyYcmuMNa9DA5zqzkkCkNGJn503ODMKqjjM
 U9dOrAfB6db7HagptMmkmyT3aJXYMsRncyrulY+9EMUINIw/GTMwMk12LmB4TYwZ2mY9s5lzhrB
 R
X-Gm-Gg: ASbGncvsMkSeq+BxThZ4Qj4i/BdJm6Qo3jNOwapFLVG0byZtwSwS9m7wNccevyQim90
 S6RoHR1knXcpCTU69B+90JmDHVrWsFRmuYvbUSb0GsxztK2Fq2+AfdlvkXrgXgYWYO0slMjZzf0
 x9BmtVmzbjYs/mpUsYFgDYKdWDAHlDYjLtNetToX05/w+mad6BenP3J337F+i7cSg4IWfNbP0l0
 1cqdSLbe6ilemBEYXYtjpsEbyDXwwL6PTFgKj5D8F97DrB5ZILryz2wonIIQflEVOv40rPidIpc
 QlIec+UfQ+9w/6wVJqu+JKBk2PMP/G2cafG7ga8osqqu
X-Google-Smtp-Source: AGHT+IFfMoeTTqls6zY+hsXszh3yHhLtBiG+rzEGqdr9nPsWVicrdsS6kI4KP9BQloEuNsUFe9nCuw==
X-Received: by 2002:a05:6a20:d81b:b0:1f5:6c94:2cce with SMTP id
 adf61e73a8af0-1f5c12cd664mr22674037637.30.1742273494052; 
 Mon, 17 Mar 2025 21:51:34 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 01/13] exec/cpu-all: restrict BSWAP_NEEDED to target specific
 code
Date: Mon, 17 Mar 2025 21:51:13 -0700
Message-Id: <20250318045125.759259-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

This identifier is already poisoned, so it can't be used from common
code anyway.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 902ca1f3c7b..6dd71eb0de9 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -34,8 +34,10 @@
  * TARGET_BIG_ENDIAN : same for the target cpu
  */
 
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
-#define BSWAP_NEEDED
+#ifdef COMPILING_PER_TARGET
+# if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
+#  define BSWAP_NEEDED
+# endif
 #endif
 
 /* page related stuff */
-- 
2.39.5


