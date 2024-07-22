Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58230C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrSh-0000R1-2Z; Mon, 22 Jul 2024 07:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sVrSa-0008TI-T7
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:44:08 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sVrSY-0002Pd-3L
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:44:08 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-368557c9e93so2126083f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721648644; x=1722253444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydlMY+jO++7u8l188uJ0hLZA6tG2qknv2DZngIO06PQ=;
 b=F0HqShY1QnLxz1EMPYdZH2hTBm2L1ubND4xq8hIQKnOWmfxmzHceXjMh49B4hQNu9w
 FMUBKp+MwB1nar7duXUh2mQAxYjKiZ7Bx1dyCORUOq0R4XAJo6wfRX55C9TvEDTxD672
 wbXiO8jPi7PqKHjHwm4jK9UTGfx9yNRpZmS/mBPo4eLI8eDWZQT+RrdDSeb6CftnAvPF
 Yt5OjlEpy1fzndVYF3+JjCSDm3w7MmAKHs3b/CmieByjgknmbnQquOqXErrI+i7+V77w
 IkcMqCCL7EEX7B9yhEQa5y7oiD1Tek1PHnmx2yOFXLjo8BptH/7bNQT3nYd/93ma8/9b
 retA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721648644; x=1722253444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydlMY+jO++7u8l188uJ0hLZA6tG2qknv2DZngIO06PQ=;
 b=H4GbkZ65i9HDxJCVPW5080ScJzYqPQLR3iL8Thv3yEvvDh4+Hxc0gAy78XCp9XPrIs
 oiHt8FCz+IT68bfhZqN4EReeBEH7T4Hkd3w7ezfC91XLzazfHXMAHseWpvG63155XjkX
 gf184cYK3Yozp6It9sUFH/RBHE1yl5YOMyxmfS8f7/3eauezqsAg9pynOEQWr0KaF0UC
 iidh2/RIm9MCfepHqLZj7dqnSAQgFGQVEv2IbzmvGVY27N4g8D6KD7vpRBqf2oSRsgOi
 rsb729I1PEZkxlFfyBl9/ZRVMmxPDY+JSKZd2Pvn0W6IqFIlt55T0VQ6VvHV3H/dsTo3
 tHpw==
X-Gm-Message-State: AOJu0YwFIQAfJr1Fa6pp5dqHrHZl2aN2va05Ht2PfOWXfaGwyxKu6NPF
 Pwflbgi/Y7d3gA2+NFbjLTkC8LgAGhNsfaM/8vXsuA2PR5KfKSfBZ3QGYDKYG6YG5OUMMp2PZ5v
 OCko=
X-Google-Smtp-Source: AGHT+IHHrgzKVftCc25J9a9x0QUtEGPKrDPNc8rb7Pqz5V5cJGT4thPtOlGflRhWpU9nk3i08luVzA==
X-Received: by 2002:adf:e689:0:b0:368:591:9bc1 with SMTP id
 ffacd0b85a97d-369bae6ff54mr4738790f8f.46.1721648644391; 
 Mon, 22 Jul 2024 04:44:04 -0700 (PDT)
Received: from localhost.localdomain (adsl-231.37.6.1.tellas.gr. [37.6.1.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787eba8csm8323513f8f.91.2024.07.22.04.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:44:04 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v5 5/8] .gitattributes: add Rust diff and merge attributes
Date: Mon, 22 Jul 2024 14:43:35 +0300
Message-ID: <990592c7c93a3b2b692dd773c4c9191a82146a80.1721648163.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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

Set rust source code to diff=rust (built-in with new git versions)
and merge=binary for Cargo.lock files (they should not be merged but
auto-generated by cargo)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitattributes | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitattributes b/.gitattributes
index a217cb7bfe..6dc6383d3d 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -2,3 +2,6 @@
 *.h.inc         diff=c
 *.m             diff=objc
 *.py            diff=python
+*.rs            diff=rust
+*.rs.inc        diff=rust
+Cargo.lock      diff=toml merge=binary
-- 
γαῖα πυρί μιχθήτω


