Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592DFC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmWy-0000O7-KJ; Wed, 21 May 2025 12:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmWw-0000NR-Ps
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:42:58 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmWu-00068U-Ha
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:42:58 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ad545e74f60so825983966b.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845774; x=1748450574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0a25YJ3ujuVaK6grnr7RFfFKuFN6alJEkh1/pjC8mIg=;
 b=zO80YuY5i2gUGpY6nODPriKVXDLVuu3DOfRuxv+pMlme+aGlVvC7g/DKS9j6Y51aGZ
 2aZWrFJxzMEG6jH7/70dfizjufpLnTaZFfEKOX1aKizL8WHbpl+xdPBWdggdRyINKPI3
 Vy05JkDC4N92tfhFgu8byGsaUtcBr4PgMhK0v3egCpYJxOxG4A2m9OwuUjDvuN2sDTIN
 Cr7NsiWB42yoi4K+L2/8brjpktkA7V4nflZc7La4ewVSoxshiEAJG6WnUwKnNODeGkvx
 w86qc01MLK20Gu8T+yXgHUDW60MlQvRi+f+/O0R8i7DYh/Hu9Bhe31calDhcB6VWxTYx
 l4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845774; x=1748450574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0a25YJ3ujuVaK6grnr7RFfFKuFN6alJEkh1/pjC8mIg=;
 b=lRGYGE0UgydxPsZGAFOTi7oppgwh8gFLQJbijA7euaBvpcLCTr1EVOlcQBkKlpt4j5
 E0sn1VyBkBxZ7Dvr285BMAh65yWBwTl7GrUjNNHtOcxS5gqDtelGjsNOSn6ysJMlDoml
 8pRCR2hnpurHUpSrDEkM3CCCRHH73IIOca5baEJ4DqVC4q8M8gueb+FKgyX+P49+ZyuJ
 vRYoZ6kQAfXb16sMRpJ3ogcEvcQLTGXhAz35XITeLrFiDxKMgBvnRHFCoTB7cZICsrSc
 ZgBFF8qMw4tJ1HWLela+8ul7y4DSBXNnUTwcaywomsWPB4WtvKLIl7m/ZfPSTG4mCkNC
 sCZg==
X-Gm-Message-State: AOJu0YzZvFQmxLIClRTw5udosN3soNijnvMRPYPJKBK168UZ2Zs0g9mj
 1dGHcrmsxzXsCg/wiz4Pe+Lkpw9vcpf8KTZxprm5DvLF3M243fUzZawrRk0NDCbGxUk=
X-Gm-Gg: ASbGncutV4Q0l7u0P2Uleq1yZ/6dEMoxDQCOhqA8JADdzTulkXrEZDEL/BZZR86h1an
 AnJj5rueKrRycbg0ctO2MLI8dcnD7Og6uTP9DNwkB+sWOD1sWS1PzIfIprFl7N4U+wT6Svr6Ofb
 O27VSXlzgkkZI7FiOnAFDvabcDG5oSs5UgryR0lRwctaoJVesqVjQEz4YQXjfD5j/0ktGJClUAt
 Ic6lbTvihG6CUFSH5DDIYN8Qv5TXXEyxy+bDjrbjim28jck89YI6Az34sj9U4QTuH1zblRX+uSB
 xUxNOPDbeOAzTCL2cGEIm/8Ur45hEDyzkclicNNHUANjowH84Mh8
X-Google-Smtp-Source: AGHT+IFzcf3zimTZmjOwrxCtU5WdmHmOfTA0E6FwyycadXPVMGctWkrnyK9oBTyf4Jg7rn8f+H5oxg==
X-Received: by 2002:a17:907:1b0d:b0:acb:88ac:e30f with SMTP id
 a640c23a62f3a-ad52d48d9d3mr1977975966b.20.1747845773535; 
 Wed, 21 May 2025 09:42:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d06cc3asm929413566b.39.2025.05.21.09.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:42:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 571845F9DD;
 Wed, 21 May 2025 17:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 02/20] gitlab: disable debug info on CI builds
Date: Wed, 21 May 2025 17:42:32 +0100
Message-Id: <20250521164250.135776-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Our default build enables debug info which adds hugely to the size of
the builds as well as the size of cached objects. Disable debug info
across the board to save space and reduce pressure on the CI system.
We still have a number of builds which explicitly enable debug and
related extra asserts like --enable-debug-tcg.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 118371e377..19663126ca 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -24,6 +24,7 @@
     - ccache --zero-stats
     - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs --enable-fdt=system
+          --disable-debug-info
           ${TARGETS:+--target-list="$TARGETS"}
           $CONFIGURE_ARGS ||
       { cat config.log meson-logs/meson-log.txt && exit 1; }
-- 
2.39.5


