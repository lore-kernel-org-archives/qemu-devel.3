Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46112E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIw9y-00019h-QN; Wed, 04 Dec 2024 15:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIw9w-00018X-CB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:39:44 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIw9u-00088i-IK
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:39:43 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7f43259d220so139869a12.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344781; x=1733949581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7uEWKx4UMORhXv3S4HTDKbGhL+95awbPajLQt+JOgxQ=;
 b=u+nCcx+QyWLLCOTF9do3pZjcVyRgOWu67KWPvva/dShE01ix4/MpBSzNxD/2YyowOn
 cDbMxlV7GKPHvS1x0tq5dAMRTc3IM9h4KJ7t1y+VIFGV0kc5VzNhcr0fIE2kmpzigxep
 /stMNaIUJicq2sl0UJ/AMYFElwhQxRp8nnMLj0xne1TAw7tydPgBXbZpqeAoutm0RDA4
 cnXtK4skibJPvCFv9snGP3re943C7yswD1ApHKB7qLqwWRAnBPZXGMDODbjPA2i2lZvo
 vWCnFanZD2fR+LEfPuAM7LN0hcE7Y0Y7Q5y2j3lJZPQ9q0ptrWlJLixP9GwHNkQDvYgT
 XXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344781; x=1733949581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7uEWKx4UMORhXv3S4HTDKbGhL+95awbPajLQt+JOgxQ=;
 b=GsuJIJD4KA3wgI2rPTucFqapB/00M4JDbWNLFKTTnUZjbb7FKnUTR56fyxeC1glbNo
 T0e9zxnRxa4kOusMjEwRaAD7Gr7czF3Yy3D2z8LwNDPhY8WGPxRUiECW9EB/tJbVJD8q
 m4tFoY26QvsmaaS2PQVlYL/IbBxL3mPK/gfomZ0MiFTXAs/evMhYyL7ZOQiXa7obfykT
 I3+1BE31cq/p/3CbMvkzpB8SounEsKKNB1km2EyOVkiXBuVDOM3z/LOLUGcyOUjo9v89
 O/GyLzEpNJpJx73YsWYXi92OgWp6Yd7Jwm7bHUsixcgh2gZRVTaxNGvhoT70vSj6xPTu
 kMfQ==
X-Gm-Message-State: AOJu0YzxgtQqN9hWh7znyZwzKBxYiFJcBGA26D5PhPTtCNxyfaOO7FqV
 Bv+nNydYYMe1Kt7hE4M+zzCBn5ZIcsLSHTb4qvTcCbVIOglVt2ykXDW/+6O8USinpLV/vjtGUQC
 D86E=
X-Gm-Gg: ASbGncvTN4QiiEUzBz1QVsxewfvK6cvZR9O90PCVwhtfTHNwoYapF3R//YsIqf1KFMC
 0eeNBe6lj7IuQhCfTnpdeNeDowkZEtnq+sBWVxdZTW5Bfs38KK+BK83yV2M0/tZe0nA6tFDTbQo
 U5pelwRTOwBSNBFb+WuTs6ERmj2zFcynbm8D9PWkQvDy2kQM/I/U/mrXvcKwoco5xIDlKnUQrN6
 dBGcXlL7JONpDENOATlz6xGWmUwhQi4uPpqnYRNux0QKFAe+EjU5z9zYZ3eb66t+UqPryJmOpUI
 m6rorTkT
X-Google-Smtp-Source: AGHT+IGRmHH8Jghz9c6dmEXgPR1s3p0wyJTu/hoRK3vkNtXhjUhWYATNR7J22jzmrXEKaAwl6P+5XA==
X-Received: by 2002:a17:90b:2245:b0:2ee:49c4:4a7c with SMTP id
 98e67ed59e1d1-2ef012101f6mr9882558a91.18.1733344780742; 
 Wed, 04 Dec 2024 12:39:40 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2700cc6esm1873117a91.21.2024.12.04.12.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 12:39:40 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 alex.bennee@linaro.org, Alistair Francis <alistair@alistair23.me>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 0/4] Minor fixes for Arm documentation
Date: Wed,  4 Dec 2024 12:39:08 -0800
Message-Id: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

Reviewed following things:
- system/arm/cpu-features (options)
- system/arm/virt (options)
- boards documented and listed with -machine help (arm and aarch64)
- grep object_class_property_set_description hw/arm: ensure all options are
  documented
- reviewed boards description
- reviewed all Arm features (FEAT_) from: https://developer.arm.com/documentation/109697/2024_09/Feature-descriptions/

The Arm section of the documentation is in very good shape, and this series only
has minors fixes.

v2:
- ensure link for orangepi is http, so we can't switch to https
- left patches from v1

Pierrick Bouvier (4):
  docs/system/arm/orangepi: update links
  docs/system/arm/fby35: document execute-in-place property
  docs/system/arm/xlnx-versal-virt: document ospi-flash property
  docs/system/arm/virt: document missing properties

 docs/system/arm/fby35.rst            |  3 +++
 docs/system/arm/orangepi.rst         |  4 ++--
 docs/system/arm/virt.rst             | 16 ++++++++++++++++
 docs/system/arm/xlnx-versal-virt.rst |  3 +++
 4 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.39.5


