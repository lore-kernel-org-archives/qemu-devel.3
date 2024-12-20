Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B88E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOT2A-0001n5-UO; Thu, 19 Dec 2024 21:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOT27-0001mb-Hl; Thu, 19 Dec 2024 21:46:31 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOT26-0000Gz-2C; Thu, 19 Dec 2024 21:46:31 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-728e78c4d7bso1135439b3a.0; 
 Thu, 19 Dec 2024 18:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734662787; x=1735267587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3lvSKK+435kbQZaCpAH5OUYgwsxyTh6C6VnzyfHBWOw=;
 b=URumiUxTEyygbQunhMrCOqX1AssRN8O4Ts1FBNzCuJfS30oMfNo0GUK4sQNsmT8/+l
 8Kihv+5UyRFT6/R9rmTyLg+4UzCuen8aNwRLIt8InCIvMRezexbYcZkvh3l9hc5QAAI/
 Cw64lLMr6JyZwgpJapKxwh2pRhSWDMJ0JTbP4qySsEn74YmD+uNM+q9vDB8wU9y03dVu
 uhatm/9+0zb4xrmDb8Gnc5Dth2+qIevqi2tacKyvu3WivtynVEcz5Dobibx+C2yGckEs
 sLap+l60dh9y7ax4oOA3ZEbovyV6j+TEUXx8mHLbQyYf4JJVD2c92kz3YwdddkLX4DwO
 HozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734662787; x=1735267587;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3lvSKK+435kbQZaCpAH5OUYgwsxyTh6C6VnzyfHBWOw=;
 b=cW0HQvwBkJN/FPTMsLqLlJic0f0k5GYFWfoHGs/5jVZqwKRdwAk/R538uoLhdn4rYq
 UUN6sS9E1WgLDtbaQGBFvph8ya31GmRWmGvOJjGQPJB7H3wbToKR5B2OoYYptcx689Fw
 T9/MOr3TKDJIc4v4EhHjTtKwyxob0QmSukrRlOBY4qvXp0p49rsN3GPZRJ0YOkLQiGcf
 DuzquD6rEqMl73o1sUev/zcgfPs2pvfT2UomW4RjSNQm7bEQETgl1V3YCgLMLsX1UEHa
 EsCoEoQpSPuA9fpyOsIrhmwFPePvOQbyuNkrg06AtxVsuS1q9tmfh+ndfYdbQkhvmbEo
 J2tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmV+q9wK/o0cCdl19OQfo8Do3v13KfJvuSoocaK1RcL2b86xf9URJAkomM0j2vfW+PpNVGVXQxHw==@nongnu.org
X-Gm-Message-State: AOJu0Ywu0pq1pGX6Ho/+/wAzbfHxnuwc5qEBp2PqQ8Oiv9x0zlCXHCXB
 vgDF7nwSnBGXeFNj7jQPjKFyEuDSfoGy+j1wVhp6eIXMg41RdI39yZFbPQ==
X-Gm-Gg: ASbGncsA98fkVKaWvhaghXM3Pm5ZcfcYN1tVMrG/hOlVryjIIbnwjR4jgjGcGX2e3q7
 EGZjrHG8nDZ2wDMXtDYH/R+V8cm0+P5drZBaubxvl2cLsvLTTtgWKbyqxEYr7lo/7vHdCTG6hjb
 rcbePzpXTxvRYl28ymaIxqUtgjonJUyx1NMWZZZuonXN/pEJZqWbdogiJiYsMLXzNOybL02BIMg
 aRBdQ4L3uzdtCx7pvePNw7m/6THsLEzczM8Wu6OVdfrr9JA0EKXl9oWSmArPepEf3mYMtEerNpV
 pTKBUrsFqA==
X-Google-Smtp-Source: AGHT+IGV2MNS8wzzmBeYVVss22YW60YmiajwAbYjd2A58kdwaf9RmPZS2Px/ACE/kRT/BQqekCljUw==
X-Received: by 2002:a05:6a00:bd1:b0:725:ebc2:c321 with SMTP id
 d2e1a72fcca58-72aa9a29ebbmr7746235b3a.4.1734662786604; 
 Thu, 19 Dec 2024 18:46:26 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dba99sm2037830b3a.92.2024.12.19.18.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 18:46:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 0/4] tests/functional: ppc update and download fail fix
Date: Fri, 20 Dec 2024 12:46:13 +1000
Message-ID: <20241220024617.1968556-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This updates test_ppc64_hv to the character-based console handling,
tidies up repo handling, and updates the image.

Also add a patch that keeps other functional tests working when some
assets can't be pre-cached because test_rx_gdbsim started failing for
me.

Thanks,
Nick

Nicholas Piggin (4):
  tests/functional: Don't fail the whole test if a pre-cache fetch fails
  tests/functional/test_ppc64_hv: Simplify console handling
  tests/functional/test_ppc64_hv: Update repo management
  tests/functional/test_ppc64_hv: Update to Alpine 3.21.0

 tests/functional/qemu_test/asset.py | 11 ++++--
 tests/functional/test_ppc64_hv.py   | 52 +++++++++++++----------------
 2 files changed, 33 insertions(+), 30 deletions(-)

-- 
2.45.2


