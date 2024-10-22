Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5B5D1CDDC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CZi-0002dQ-7j; Tue, 22 Oct 2024 06:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CZ1-0001p2-17
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:36 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYy-00024d-Is
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:34 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a99eb8b607aso588256466b.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594591; x=1730199391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2jXJE3FbWlzhHC2JLNXh46hRwsq96dE8ivUr/Ry4PY=;
 b=itvKW5FyYgWnPx6VY1MhYfAcczcT2WZGWcPHTBM/4/I+0zdtsgRW84Kao7sBue26CF
 G/EsiBvcm7YkrxSN23L33NIM6M5Wsp1zMuBuHjr+rmorWjk+Q19Jdv8QfHhDJsCrhI27
 EpT5nSEHUG+9vyNfwEZ5DEJEzxJp+fvmi/dzmI6iGDMJEfMZ/6pgPTa8ZwOqUKfSRsbM
 cKTNNGbD1SLmxN92m6c+rCvze3wDfmN1b7Q1hhvJDcUCnQOowQMbVjtJMwTNU68AzgQr
 ohfsOxexNXTEm76CzJgf1TRlUyQDCiebJqNj24LfooC5x8VwXUWiGWrMBklb00I5/UMc
 EZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594591; x=1730199391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2jXJE3FbWlzhHC2JLNXh46hRwsq96dE8ivUr/Ry4PY=;
 b=QLO7tJm1pTJss1p3jErNm4J0ir30oI5acoKwE1V0LZfleESxEiIAOjKxV8iFZ1vnkK
 1J8pVyQ9U2wYHbRg/xQSnwS7LYJ34OLzCcPDMpAY69CiSvOacsbsQGNcpbHWeUGAoWuC
 PS13ZYj5EdVG7f1Py6+c544ziL4SwXe/PaZBdXe8v3DMgL8pffNRqUcswGTMWDsgKtQl
 n5LiuLL5JoxYgzAUCpIQitJLkb2WA+74rgcGcB+W7qN9uSnZQyixR4KD4lgoPXWn1y05
 IguixgI0/ECatagFfjplkqAWonpgLBWKBuK4KRJHChS+renIo3msTM5teQlzPuxJk79o
 0+ew==
X-Gm-Message-State: AOJu0YwBoBuivX0eurMbxf25bMivhn5QfTIrgQ711JwjENDKtIFL01+3
 HyrQ9NsUvJaHQVXpe1AmyxL8U2iSWj2/DdC/DyQWDTWIweKlIYDLFtn1yS9tDg0=
X-Google-Smtp-Source: AGHT+IGUejPeSVv+t0DCi7SW64a6BptBW33UQRq4rjvBjk+8TQgWaYTlBD5pezBspgvI4FXlscux/w==
X-Received: by 2002:a17:907:7da5:b0:a99:4aa7:4d6f with SMTP id
 a640c23a62f3a-a9a6995d6f8mr1533790966b.12.1729594590554; 
 Tue, 22 Oct 2024 03:56:30 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912edc33sm321455366b.58.2024.10.22.03.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:56:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 99FE35FA0B;
 Tue, 22 Oct 2024 11:56:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 11/20] MAINTAINERS: mention my gdbstub/next tree
Date: Tue, 22 Oct 2024 11:56:05 +0100
Message-Id: <20241022105614.839199-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Make it easy for people to see what is already queued.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b84787ae1b..81396c9f15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2978,6 +2978,7 @@ F: gdb-xml/
 F: tests/tcg/multiarch/gdbstub/*
 F: scripts/feature_to_c.py
 F: scripts/probe-gdb-support.py
+T: git https://gitlab.com/stsquad/qemu gdbstub/next
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
-- 
2.39.5


