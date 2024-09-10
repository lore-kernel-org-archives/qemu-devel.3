Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D528ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snz33-0007St-W7; Tue, 10 Sep 2024 07:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snz33-0007SB-9f
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:28:41 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snz31-0003O3-QT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:28:41 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c3d87dd4c3so2588548a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725967717; x=1726572517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2ISkgkEmCI5cff9FmpAnJPIY9AIpzWQ32iu8oi9pu8k=;
 b=y0smUsRQuTrIk15uVENKxZAxPKjyuBY3EqWnCZTK4xSwqdaK8Evbr0aGS2tmr+NG0U
 cHLlmIVS4fBE4mbZDO3nILOtetJkIvErnk6E1AZKk2odzeJ1Ry/vnPQbg1ElOKXsfxhn
 dVxvm7T1NN80j2OQ66WkEfwkQALvPm+QE/bDJDgszXJROni1/ojE/cfgBjewiCkGLSc3
 iaFGQAKkg0wBCmLf7vfIQqT5dpJVbRSsv0yRRs6UfHsHW8X7vxzf+/k+hIfn/JjAWCXX
 wAubMedMfmInKTn1kIohV+Ilw1XyYG01M6XxtOBdP1ithtirsjOXTfJXAJ1l71XPTLMe
 7XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725967717; x=1726572517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ISkgkEmCI5cff9FmpAnJPIY9AIpzWQ32iu8oi9pu8k=;
 b=FL2b9K58bZNcDJc5NBdNLiKAfJ71OQplC8psNxBpw1hHg1b/Xv3xT5DWKUTkqz1D2g
 G4rgtj1qZLazfLBuKSId2jEwL//Yk8fO1Nyv2ufEZdUyClOeR0jj4yfxcVGTRrBsaCSR
 GmKE1rx6ULaDsv0neiQsga2OeY7HkWvDAEpO5h67J5l3gTcvy1Z8KVJsLUbcC6J+Mhjo
 IchcJPr5bcXN6VHwzlW6Wcs+Z//MmSJav0bwq7pfyKyiF6srRlXI1gKXbuUm08Rm6r8A
 aoPm9Qe46sdfUp/rnJKjBrQdRW2lQaUmLIGSEPNpXOThIVx74xJXVETEa56XKJcaj91Y
 d/qA==
X-Gm-Message-State: AOJu0Yylz+9W/sh3A687kk6dsFQOczBcNZPStTO+L8JpXyrjDc7HX9ju
 HGBELKXEwpknHgjp2ntLff5T36j1Ht588zy+LhVxkm/rvDVhD+UKo0O7bAEN32Ljo0agiS2VXHC
 f
X-Google-Smtp-Source: AGHT+IHKOrK0OMUESpDluzghYxbwsv5LqrEbyRMWXZWr1hMDej4+GYkuCjRc3wkgdr4FgXiY6lELOw==
X-Received: by 2002:a05:6402:34c3:b0:5c2:58fe:9304 with SMTP id
 4fb4d7f45d1cf-5c3dc77b0a4mr13913635a12.1.1725967717123; 
 Tue, 10 Sep 2024 04:28:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41c65sm4113767a12.16.2024.09.10.04.28.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Sep 2024 04:28:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>, qemu-trivial@nongnu.org,
 Anton Johansson <anjo@rev.ng>, Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] misc: Rename included template headers using '.inc' suffix
Date: Tue, 10 Sep 2024 13:28:31 +0200
Message-ID: <20240910112833.27594-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

Follow Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Philippe Mathieu-Daudé (2):
  target/hexagon: Rename macros.inc -> macros.h.inc
  tests/bench: Rename test_akcipher_keys.inc -> test_akcipher_keys.c.inc

 target/hexagon/idef-parser/README.rst                         | 4 ++--
 target/hexagon/idef-parser/{macros.inc => macros.h.inc}       | 0
 tests/bench/benchmark-crypto-akcipher.c                       | 2 +-
 .../{test_akcipher_keys.inc => test_akcipher_keys.c.inc}      | 0
 target/hexagon/gen_idef_parser_funcs.py                       | 2 +-
 target/hexagon/meson.build                                    | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename target/hexagon/idef-parser/{macros.inc => macros.h.inc} (100%)
 rename tests/bench/{test_akcipher_keys.inc => test_akcipher_keys.c.inc} (100%)

-- 
2.45.2


