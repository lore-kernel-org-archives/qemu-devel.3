Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333D6C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tparG-0000tW-0z; Tue, 04 Mar 2025 17:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpaql-0000XG-7n
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:34:56 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpaqj-0001OS-D3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:34:54 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e0373c7f55so9507687a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127691; x=1741732491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtiqEtuzstbJtMIqpkXLIIVivSH/DtdTgEZN65u/fk8=;
 b=ehwGdeARXFwMF+VD6DYuTZDuPQ/K9Ty4ZkQFTmqlnVN9v4iG1MN1IXCXxHAmqHKwVc
 e1Z/eJs6dC84xUNNQghm6OKpkhXxe1WvLvrSLrp/gY4p2RTRmEm9TPdYP2UMKf+oZKu/
 lk6oFa1z7ksuXwEd/ECb5i1cY3dNGGYiG9nn8VsCDFYjN+muc95qQAGOsUP/I921L1JY
 Qz2mvTrrVlmd4FetorN1fF9ZcoTzoX2eYYgLuA5dBFE+udIq2YAsAq0Egsn1tQdTcUB0
 bCYCwDkVpALPiAw5uBZLjhrriqMMSo2mNdm1HiCPbF4i+gNFkf+1A04XSbeV9Rf1xnjA
 SA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127691; x=1741732491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CtiqEtuzstbJtMIqpkXLIIVivSH/DtdTgEZN65u/fk8=;
 b=dt5rg3/Ho7afv7GYK09MiiGeg5OeBW7QsT8hXyAO0sTT1Fnb82Ak9pdJnpvyLHu6X3
 b3aXetKVKSSsoLn44ZEBf0KL6fZMhC29+xISwCvURAabOEgLhmVqfrxAsRBWHQdzc4TD
 ta/CYI9cyUjMS965ogOszEVdq1vt8s3IGXUHL4Hovkm4MsioVCQbgFR8+bpqWJLCnE9K
 EgParph88qnzQVLvam5cMAvo1oj1uqFoZFA0M98/Rmm2eHSn95uKWFU+GJzTwNbsIf3W
 nsg3DHPjAPY84udKXvNksvReCMnQDf03f4qrMyRFty5lCzGDzRlO0MMD7DUZNukeNHBZ
 GGBA==
X-Gm-Message-State: AOJu0YzrnD4tf54/FNQzbXRVvOXKab1TId9l+pffh+LAwPLAZ5n+ZlDM
 azaZx7MJrXBOI1Ov/7b1QdUplGTl6sm93YvlEL9uNH0XbUpd3nUe6wpiWH7iM0A=
X-Gm-Gg: ASbGncssTBsItipW6bLlJAHfj+5LfVmjE8D7H8L5mtBp/kfdcBzPHPQUhaMV4jk00hw
 LAlV6NLQaky8TigJDjCbOtXr47SBEpTtAMQC+8WOdf/e+SRwYwuP0TDX8VMkPjEc5dbrGyUQx6q
 gLdBj3kxyNxY1hhahvbySIQpfZVz6LSgwf7xUnWMedfD0VyMZ+WTGObiqDoyNMqkNENOt0IOecW
 +qLpnkWLhUxQYyx4DIr9pGd2h0GD4SDrxcmS+J0fgkD/4mUWJA7tlBU5qP7zOk413dwiktgkIfs
 mYU2Ep2xT2kwxCTKdSKbHmMcdz8U/gqjkkHUpGDOiTitfRg=
X-Google-Smtp-Source: AGHT+IHIcg3K9jUhXo/E5kx6EphM5gxJvw044G5jVk1OuMrV/JcPBwe1r4ZvrxhDJKPJRzljuN2hzA==
X-Received: by 2002:a05:6402:4316:b0:5e5:437c:1daf with SMTP id
 4fb4d7f45d1cf-5e59f3c85acmr705000a12.16.1741127691584; 
 Tue, 04 Mar 2025 14:34:51 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3bb5abfsm8661689a12.35.2025.03.04.14.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:34:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 88AAB625FD;
 Tue,  4 Mar 2025 22:24:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 31/32] MAINTAINERS: remove widely sanctioned entities
Date: Tue,  4 Mar 2025 22:24:38 +0000
Message-Id: <20250304222439.2035603-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

The following organisations appear on the US sanctions list:

  Yadro: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=41125
  ISPRAS: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=50890

As a result maintainers interacting with such entities would face
legal risk in a number of jurisdictions. To reduce the risk of
inadvertent non-compliance remove entries from these organisations
from the MAINTAINERS file.

Mark the pcf8574 system as orphaned until someone volunteers to step
up as a maintainer. Add myself as a second reviewer to record/replay
so I can help with what odd fixes I can.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250221161443.2321327-1-alex.bennee@linaro.org>
---
 MAINTAINERS | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e7fc6fa91..16c2cb0c3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2542,8 +2542,7 @@ F: hw/i2c/i2c_mux_pca954x.c
 F: include/hw/i2c/i2c_mux_pca954x.h
 
 pcf8574
-M: Dmitrii Sharikhin <d.sharikhin@yadro.com>
-S: Maintained
+S: Orphaned
 F: hw/gpio/pcf8574.c
 F: include/gpio/pcf8574.h
 
@@ -3640,10 +3639,10 @@ F: net/filter-mirror.c
 F: tests/qtest/test-filter*
 
 Record/replay
-M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
 R: Paolo Bonzini <pbonzini@redhat.com>
+R: Alex Bennée <alex.bennee@linaro.org>
 W: https://wiki.qemu.org/Features/record-replay
-S: Supported
+S: Odd Fixes
 F: replay/*
 F: block/blkreplay.c
 F: net/filter-replay.c
-- 
2.39.5


