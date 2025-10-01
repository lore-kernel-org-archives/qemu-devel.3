Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5EDCCD183
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v40LS-0007sC-MA; Wed, 01 Oct 2025 13:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v40LM-0007p9-3i
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:10:20 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v40L1-000353-Tw
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:10:19 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso27656f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759338592; x=1759943392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEJm4wFcOou8aAv0mfkgr1uH/LFSQt1dKK+lk8G8z8g=;
 b=EawRu151i0sdHZvcJ2QboORosxAPnJNWNdvfD3SD0qgUTqQG1G4S6+ezhUVfE/WAI0
 MlnBJo3lx3szjH2eFtNdh2czlI3gG1ki+/3hQuxMfOqFHnXrbj6K9kAGShI/s+Yg5zdj
 jWH76EIMGUL2rN5uqVCrLaPAHVTCV3JsVFtfSoTKVdyHdVICv77hbP8z/reFAlZ2njpU
 s4yBN1L8g3smek4j2duvN7G9kgqKlFuZYz8R/+uyBnb20IVajHCuXJ3kv8Hp6OxemjNP
 CLFN4Q23sOhKTyACk7Cipv2g7sHOAMKZF4xbTT65BmAXtf6tqEehQcoKsHqQTAddBQ/9
 GZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759338593; x=1759943393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEJm4wFcOou8aAv0mfkgr1uH/LFSQt1dKK+lk8G8z8g=;
 b=VYEJeZ2hubr63edb1ROppxscArMO+YKhkRlGvYY9NKeiswb01edBIjdRB/3qN/eZV1
 T2iJ13TPMCIpBrL6KXIKC2oFozW5Nvmiz27kPjpT2QHw2iGVDOXvhXnxjZ1jOsN4tG+D
 dt+pPEmRetT99rNttgQE8pDJ6AbzU8mvwB4765Y/Byy8TSCdQF3fOKorjkcbh7agP6qX
 WyMiiqvreYqPW+oHkOUofi6X1h/6aMfBjJSPqYtlwsc6ZoTixNdPsohp7XTqR/+NMfjw
 ZaVvLRmcRgddwsHPkjsBzhY3GwLc4GGtgw3VWh7z/jTZw6UUP8t19qGNNh8D8UIeX5Vb
 Ykxg==
X-Gm-Message-State: AOJu0YwP2SSV2IUPEB7jqGzhAm0o6qCZm7tJ+LgEaxUir6K6Ju7f12MU
 BMUCX4VJg9XfCGQ+l9kq43PTX3RrJVgww4fzKz0SXdKTTONrufOBrob2QQwHcEvDjxc=
X-Gm-Gg: ASbGncv028GeD74S244BEq9569JYZow2uWnXN5sBJkBPnDBBJch54TCbirbMhGebR10
 f6iVXXSFENkFBgtNF/nE77SS2mcH0Ya4v1AysO81Smrk6rKXl2z+ZhY/TARHIv2bP9C6n1R2flC
 9QSlVkZRREwxyOUF0UkD+gZ4thZDW9N5qTSWVnMVMT0GHDCnqCaT3yN3tjBKHA94zNFCdD67KTc
 dMfPS4LDWvHbq7i2q/IDxUcbK9CisDGRI+SxID46oADC+DOlBKxEvFGOQippWR5GyEQfnpXATwi
 JnRCZLi6zTEmFpqH4xjeJIY0hwfu2zeZwxpTCX8gCBu80lvt9J7+mIJBG1JUd3O/p7Q9GxpgHc+
 u+jjf4OwTVZtOTf/calU7BPYiHeh9raQzVV6fIbjt/R2bPsrXOOdXKW5COg==
X-Google-Smtp-Source: AGHT+IH+eGQvfq0dd09/abXjKeyHmIGTJLHNNe2W+UZDsQPn8A9XSJ1PMINbgePAFnEzgBb0zEtmLw==
X-Received: by 2002:a05:6000:24c9:b0:3eb:df84:62e with SMTP id
 ffacd0b85a97d-425577ed5f5mr3673161f8f.3.1759338592576; 
 Wed, 01 Oct 2025 10:09:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e691820c3sm16705e9.7.2025.10.01.10.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 10:09:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D049D5F809;
 Wed, 01 Oct 2025 18:09:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/7] tests/lcitool: drop 64 bit guests from i686 cross build
Date: Wed,  1 Oct 2025 18:09:44 +0100
Message-ID: <20251001170947.2769296-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001170947.2769296-1-alex.bennee@linaro.org>
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

With only TCG available we can't support 64 bit guests on a 32 bit
host.

Fixes: 5c27baf9519 (docs/about/deprecated: Deprecate 32-bit x86 hosts for system emulation)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-i686-cross.docker | 2 +-
 tests/lcitool/refresh                             | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 4e8b3a8293d..2998764065f 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -178,7 +178,7 @@ ENV ABI "i686-linux-gnu"
 ENV MESON_OPTS "--cross-file=i686-linux-gnu"
 ENV RUST_TARGET "i686-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-linux-gnu-
-ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
+ENV DEF_TARGET_LIST i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 645959318a3..185a47cebe6 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -216,8 +216,6 @@ try:
     generate_dockerfile("debian-i686-cross", "debian-13",
                         cross="i686",
                         trailer=cross_build("i686-linux-gnu-",
-                                            "x86_64-softmmu,"
-                                            "x86_64-linux-user,"
                                             "i386-softmmu,i386-linux-user"))
 
     # mips no longer supported in debian-13
-- 
2.47.3


