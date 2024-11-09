Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655D3D5E37F
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 19:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9r9n-0005MW-Hv; Sat, 09 Nov 2024 14:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t9r9m-0005Lr-6o
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 14:30:02 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t9r9k-0000Zs-IJ
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 14:30:01 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so4658611a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 11:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731180598; x=1731785398; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B+WxSF1opKNrTfYkJEp0PcCn5M38LmtVZg2zt/KxSfs=;
 b=hJwgmZmU/9rsZ+f+TvdyJrqE1iVAWTVPE2S+LdBIAyqAz8FUrdk52hzGY62lRu5YFW
 IPh59oOM44scqjAH9MXf5uC/bGM21AwRD5eGxONeVOqkbXN/xjprykcppShfP+u0CmZ6
 NljpGQW36mH+nI4cBG6qUHN+51Zs0GTwv545MT/4MJZrGypdYT/JgjtulenyTdlu/RlQ
 MoBRN4bjgH5uzL0VCMEiEcSTixh1j2iwG0VU/48fHVbbm219r7qG5Co8fWsXgYvh00DS
 DrJjhO6Xa4Fwl6Ge+Vx3ytVNFxdp27rGigK11ivuhKWYS5wcgzyEUzlLQtR6M+PjDtli
 qvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731180598; x=1731785398;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+WxSF1opKNrTfYkJEp0PcCn5M38LmtVZg2zt/KxSfs=;
 b=dw3osqvSDJ35g3sGJdOj03/jt09P6MJbyTXrUQT/iCF9YcWg9ingXKp2QpwyuQSvcx
 fl8t8vKdpz/MFCadTEOM3cVPTwNUJzZpJQuhc2LtcuZM/dWWex90Xg+ZKjwHEjYG1GUR
 qLr3jFPpTX41tvuFMWfS0HXNXFNCWoNKjvTaCcQE6flJuk05Wbxmid6h7cSwQjebD1Pj
 V6sLEs2qr0L2fYD6Ob0pYP5nj/3wIxvIPi+AZVf/BJFHDjMhAnAMHz2O13itwFGXxcAj
 tipL5zeI75xjuFAi5f8XdPz/eWyirAJ6vrhTliQljtlp2JecW0x82hZjw+Lwe5YDjNYC
 DmaQ==
X-Gm-Message-State: AOJu0Yz5+9wpy9FiijDf1ndLpemTjRscslYiS+zYX8Hiy7TOosbwICpX
 s/3A6tpanJdaKl1vVda6FQs9OGymKwWD+QqbsdxVbBTfPsTRXr+FP8kWppG5bmPyFhub0zQnIuV
 fexmn1g==
X-Google-Smtp-Source: AGHT+IE0wqFgMLc0Ntl5OdkhvkpyHFC3Gi2fxd/XfFOMnZlsXXVLC3FLyGSkRG2ZZxVsOqrdkxe8wg==
X-Received: by 2002:a05:6402:35cd:b0:5ce:d4ec:caef with SMTP id
 4fb4d7f45d1cf-5cf0a328f4cmr6129591a12.15.1731180597706; 
 Sat, 09 Nov 2024 11:29:57 -0800 (PST)
Received: from [127.0.1.1] (adsl-201.109.242.226.tellas.gr. [109.242.226.201])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c7c241sm3231204a12.75.2024.11.09.11.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 11:29:57 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sat, 09 Nov 2024 21:29:36 +0200
Subject: [PATCH] MAINTAINERS: CC rust/ patches to qemu-rust list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241109-update-maintainers-file-rust-v1-1-f4daba6f782f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAB+4L2cC/x3MwQqDMAyA4VeRnBcwMin1VcYOrY0uMDtJqgzEd
 7d4+A/f5T/AWIUNhuYA5V1MfrmCHg2Mn5BnRknV0LXdk6j1uK0pFMYlSC41VsNJvoy6WcF+jMm
 76CJRgLpYlSf53/vX+zwvTA+OFm4AAAA=
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=/7BO1hMK7hZ4Hr0DVBWdfzLGKnVvPJFu1mmsba0RnbY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5MN2cwdkV4cjNXelRYYk0xZWpmZEJrWk5yV2t1CmZKZlloUkRZcW1KWWVUbENU
 eUdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnkrNE5BQUt
 DUkIzS2Nkd2YzNEowRnVBRC80ckRFQ1BVTWF6ZEwyK0E2OFZNcjEwWG9rVHc2RFNreTh3dWsrSQ
 plYUhZMDl3REV0WHQ1QkRtN1VoK1VwaVpxcUx6ZXUvWk9jSkh2Um9yS1hhUE91aGpvemZUZGl3O
 EhEVVdQdmlCClppMDN1WE1OK0YzVmlFdFZObUVxSVJXWDNJemlJZ3VSWng2RTNiMGxvR2Y0Rkp0
 K1d4TVljTEIxR3BvWVNMV0wKV01XRXE2NnQ3VzUyRlFwNFlwdWlvM2ZqMHZONk5CQVRVTHZaSXp
 ES2syS21DY2dyZ3U5TGZBWEpNK0FFUnp4YgpLNkFoWnRkdlpRMVphNzB3bnpDQVpZV1RYM1liak
 1ON2J1b0drR0J4Y3lENVc3aDVHZk4wQlZBVWlxZlpza1ErCkQxUExkUGdYSmR6MC9NLzFGVnpqS
 zBsT3J0T3A5ZGdvUnNTOVZLaWdxRWF1ZWtyZWozT2tZbWZXMHpQS0M5dDkKRUxNUFZVaU5wYVFz
 Ty9NYS8zeDJTN2RCNnRZUzdaQTFoeS9Bb3VxdXA0OUZjRGdvWk5aVURsb1A4ZGdSUlBXNwp1U1p
 4Tm5SdjlaTHloMmt6VUsxMUQ2cktoblJjSWU2QmRJSWtTYURmcE52bGJUM1k4U3lHdFd6ODhWUW
 gyMk5PCm5yNnpibS9LaUd3NklDU09oSU1aMVRraFpuQjEwR2hwOU5JQUljSzlHUTU3dTV6Nk1SV
 2I4UnQwVHZDVTNETnkKMnk2eUZPK2JnY1JzOEM3Q1ZvMWd1QkJ4M21XOGZaclJHdUp4NWcvZEsr
 V3pjWGpNeUczKzhweDJiZitBcFRZcwpRRU10K0FMSDl6QVkwemE3cDRSVlFlcGRsZmVYWG1PTTd
 OMURKcjVNbFlBUmVxZUczOVpMaHZXNWJxMENzT2xiCjFlZCt4dz09Cj1CcnlyCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

As of CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix45Yw6gVHXozRQ@mail.gmail.com
we have a new topical mailing list like qemu-block, qemu-arm, qemu-ppc
etc but for Rust related patches. Add a new MAINTAINERS entry to touch
all files under rust/ subdirectory and additionally add it to previous
rust related entries.

See also:
https://lore.kernel.org/qemu-devel/CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix45Yw6gVHXozRQ@mail.gmail.com/

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 095420f8b0..373176e445 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3338,6 +3338,10 @@ F: rust/qemu-api
 F: rust/qemu-api-macros
 F: rust/rustfmt.toml
 
+Rust-related patches CC here
+L: qemu-rust@nongnu.org
+F: rust/
+
 SLIRP
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
@@ -4241,6 +4245,7 @@ F: docs/devel/docs.rst
 
 Rust build system integration
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+L: qemu-rust@nongnu.org
 S: Maintained
 F: scripts/rust/
 F: rust/.gitignore

---
base-commit: 134b443512825bed401b6e141447b8cdc22d2efe
change-id: 20241109-update-maintainers-file-rust-5cbd97b7b11a

--
γαῖα πυρί μιχθήτω


