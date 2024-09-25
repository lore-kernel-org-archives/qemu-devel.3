Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAF6CCF9E8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stVYX-0000Xb-Bp; Wed, 25 Sep 2024 13:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYR-0000Kl-F6
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYM-0000bo-Pq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cbb08a1a5so149495e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727284308; x=1727889108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPetPS+iPOZ9YsbRPGkth2UTt050VfI/4VOs20g6hTI=;
 b=XcxIY7M1EYFAY3vrRYScs0HQkfxAOqKXgCWtsuNtWDp1XZd/OUGc9vSuLWOttclUuO
 WgqvZLikah66c/FTWjYZG01L9w4GxBfZikhwCtTcfUp5DAyIPCgZnHADvVS/0c+skh8w
 tZAvSOyJfrtaymtsZk3R0znA4UunVMtpF2l8bdrBvyyB8RTYcT1i5IVY6SNxgCCK/xNH
 wleqXY9ohUigiQuPXUmCwXskUmcETLMxL02KH5le9AmEOHbcQDDog6xjLDPYHwIKEtk1
 C8sBSXyl++w0yXMdXbHCteXNbvL0PDyBv5b8kKP1lQC8x1riThE4xEEUK0UWVcuvTVVj
 OsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727284308; x=1727889108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPetPS+iPOZ9YsbRPGkth2UTt050VfI/4VOs20g6hTI=;
 b=vqBY0Q3814aT2Y7iLCFWFhsHDRgS9K2GYR4Gre42TDiEj25iXb9qTSEas72mBP39ho
 b41sez9qsZdY2d8S4PxivdXSK6nNoNQ3uq3yu6I3A1RJKXn+50rPaSVPBnK+KcjKb7k5
 x05yFDZmd7RfGzpEzfaLcZxEKw6KNJUCeTKN5rScdCJLtTD8SB4hrRhbt4kR41qKXNyy
 Isyo8VTQRqRrv0ovOELdl5vq5E5KXdTzlvNnsiQ9my1I6tRaXy63H7AxVcWKN5y2jL5h
 eRnB9oIl7265eJL5J1q+0OGxqTUqRoaTeTlwhRg220L0bIiPSwaU6LNhXdrBsLULOLqY
 7mYQ==
X-Gm-Message-State: AOJu0YypZ6RZB5SnyThpuJbueayzFK8rpJxTFE5dMpNS2oHFvB8aEJmB
 mmAUNAVgYUeSK/6yDeFDyTWMuYdXLTqaNT8MCYC+eR92yDYu5IKoT4NO+baNyCI=
X-Google-Smtp-Source: AGHT+IGBCTHIWfSfgWAoxWqUTo8+jlKpLyEBTIm6tcnrukMNtvBJLrfotsddLNAtN5yhINvOVzR10A==
X-Received: by 2002:a05:600c:1c05:b0:42c:b63e:fea6 with SMTP id
 5b1f17b1804b1-42e961362e8mr25316905e9.22.1727284307691; 
 Wed, 25 Sep 2024 10:11:47 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e90cd2d3dsm44179475e9.1.2024.09.25.10.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:11:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C5475FA77;
 Wed, 25 Sep 2024 18:11:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, kvm@vger.kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 08/10] MAINTAINERS: mention my gdbstub/next tree
Date: Wed, 25 Sep 2024 18:11:38 +0100
Message-Id: <20240925171140.1307033-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240925171140.1307033-1-alex.bennee@linaro.org>
References: <20240925171140.1307033-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Make it easy for people to see what is already queued.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ac2252303..f34b8843e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3028,6 +3028,7 @@ F: gdb-xml/
 F: tests/tcg/multiarch/gdbstub/*
 F: scripts/feature_to_c.py
 F: scripts/probe-gdb-support.py
+T: git https://gitlab.com/stsquad/qemu gdbstub/next
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
-- 
2.39.5


