Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B983C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twewY-0002kE-25; Mon, 24 Mar 2025 06:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewH-0002hg-J0
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:49 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewE-0006yb-Bf
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:49 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac34257295dso877293266b.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742811705; x=1743416505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZF6S8L3UqVuJFuyJwFnFTJvE8XTZ2YC1W6E4Xyum+w=;
 b=lz+Gr030+9bVEhfHV2GCVI3biXPzNmMNpfveF3ZsgjAe4kPcvY8gZRmLGn95C3x5xV
 rXAyZwcy89sgCssgQ6Ft5AfQ2xFVdojj8znvuibHvXLWBirNrd/gkHKI0FZSRbMhEhwu
 jaA6CR5z72n3vbFsKjv9quZ/D6uACTcai9+IuA3BrTINYdS30dfuohZmd7hUzxlhNa73
 oIxLmphiG/KL2qcvUrltly6/k58U31ErBY+3ueuKBoQ0CHNV3UNTxVhYEEF4grk2LpqC
 tGC+N9HsXxFfnvELAalY7HAhXH6wvej3pW69xddGLbWbR5ikfeIAWIeWpRPrzETAWJDh
 a4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811705; x=1743416505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZF6S8L3UqVuJFuyJwFnFTJvE8XTZ2YC1W6E4Xyum+w=;
 b=KMJ4PK3vbhD0cXyzMmzWUk7kBFD1q/C3VP2wsL7GS791DNHQGFwW4U+joZEqTVdJyV
 iwc/177NOI0xcPgqiUkfm1f/CbSNf+mV96lfS4AUBgPW8fkNbiUH+wknbYTe+PL0MYNX
 AxuwW2jHCUt1/jxBVBD90hNOd+y7SOkRPibrfWR10EdzzY7vwlB+Pgsh5nEcMwfxspKu
 ABIK6UlKY9o6oI7MKaxGpPksKBQV+bc+8t2ox72N6xll0ysVk448rvt13NhhG5ouAYzp
 Q6OkKHYOPCSfRB/NKKLk+T9A938q3dBW8QmPT6eLcverg7BEN88dfF+LQjegaO44kzda
 cmcg==
X-Gm-Message-State: AOJu0YwSQ1OqCHPV7Z6Lx19unzWBOj+HjgxfCxkPMyZYIOF2kskftDKf
 xOOx+AL7KxTKPduC25P35CpBlhypXFksVuZnqBMfjoo3iZ82F+wz7k6Y5ZZ3DDU=
X-Gm-Gg: ASbGnctPFuelLl36bESa7ONsX0U8SW0yzrzRm61X02umxn6Gr1IB+TTKevN61hcDkBP
 gxwCrUXnFSlpa2nP2KoeOa5oev17DvvDzHrQYKCL7qtvBEWkgkb0No4aIhWzkIoFgW4jUoxFUWr
 WVTZvJ7qWin421e6Ny7iPief8dQe7A3ohAkYKBqLyhbpAt9loipxRnNUNN7mzcW/W7E9C/BORLb
 fllvsuWaITkwzaCTMc2QbvflC7GdHzt1t3mbQo7gtVH47RzlA2+AXuwTtPUor/ebPeT7PoKfF7f
 IhBaAiSN3S6eVMNnJ5vkWG8MWTFk3M5XSzsfEkOds2taVf+ERkDjwIorhA==
X-Google-Smtp-Source: AGHT+IHClczt71SkQU4FdPrknV8YMuAkrJavOE2AdhKjNiinf7mK80vrbnuykoxBItOVEu3so2gwvg==
X-Received: by 2002:a17:907:d17:b0:ac1:da09:5d32 with SMTP id
 a640c23a62f3a-ac3f20f81ffmr1184440566b.6.1742811704565; 
 Mon, 24 Mar 2025 03:21:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebccf89240sm5803429a12.31.2025.03.24.03.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:21:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C35515F953;
 Mon, 24 Mar 2025 10:21:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 02/11] include/gdbstub: fix include guard in commands.h
Date: Mon, 24 Mar 2025 10:21:33 +0000
Message-Id: <20250324102142.67022-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324102142.67022-1-alex.bennee@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/commands.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index 40f0514fe9..bff3674872 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -1,5 +1,5 @@
 #ifndef GDBSTUB_COMMANDS_H
-#define GDBSTUB
+#define GDBSTUB_COMMANDS_H
 
 typedef void (*GdbCmdHandler)(GArray *params, void *user_ctx);
 
-- 
2.39.5


