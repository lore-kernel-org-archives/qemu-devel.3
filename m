Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317BDE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOLJu-0002xH-5D; Thu, 19 Dec 2024 13:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOLJq-0002wT-Cd
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:32:19 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOLJo-0002aA-5Z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:32:17 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7265c18d79bso1330782b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734633134; x=1735237934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NoMVdzf7dEnl3NQdwGbML5tlJY5JdwY7hUGe8zVB6Tk=;
 b=ZBgWtrMlvKb39i6v0ZmtnGMt8pyJoS81VWnjLD0eE3Q9IvsIjUEjuER+5HjmobFPJU
 wCLXxa2bSI5eiC+i0SN7sphjPOKkVIMC7e2oz4BnlUtszfV5xUGlND0xI8aYkICt27Pp
 7xqHQl9iTQ0mhHMHnksoqPX8yzmBN1uqiyQTtZRAcHwp4VhdHTsJvO3njEP9tB+sUQfG
 c98iVfC9U5FDapr5fGgbu55rhuA5WhJSTque6L5V3iRFTyZiuZkqfp3rpvMFsDnH6e3e
 0+T1X4tTkSO1qL/wDWtySqHzjWR9lmRT9Po5xdYCLhlpd5ThsSRLyUeVINqElP6noOaN
 JZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734633134; x=1735237934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NoMVdzf7dEnl3NQdwGbML5tlJY5JdwY7hUGe8zVB6Tk=;
 b=en7DhvtYJA9VqJH55seTWn8cOm+L2ZBbAsFuI+L6Kwlc36mAShrwRuvDMV/Qj1lc2H
 tL27cDhwaugzVL2BigLnBzVq/1AzxhajsrPqQWaneJUsBiRF0crxAXEUazHjLc9zak3t
 VaW/One+yvz51mAjxz8/8GWDBigRO08L0qQalm6akURMozPBMm2f4asVk4wLcanXwn30
 OTZki+vuxcDQKsXAtrPZ4gD6yYohOZLg/iPKH140X81nvU/JVjq4Ul9elLVu486Ujsfs
 AEwc6rfnJW/02ax/6S5GuW/eB4r5AIzUJg52GOK6KTQc98mlFt2t0IH3qlcTYHhiuRaT
 0KBQ==
X-Gm-Message-State: AOJu0YxC6LmmtXSImV3sb2ao5hKznCbPzNqiNj4PEMI27001KB4g+tEs
 i5IoEZc/zuFMDkiiCN2b/SlOl+a0CrOUgdcTHB7M/tWx9y40MXAyKznBW9RLkcoGbXLjzg2W7Vf
 1sTc=
X-Gm-Gg: ASbGncu1klf6ml0jooJQrpZhqFkQIG4GsfazfgWuh9EhbaC7lzDzxBE7ajG9tUsw8WT
 lWy3UlwJCBNnOdneJWib2Mt2edSTdai1FSF1IUS89+Jqp57lDjnsQMlx5MJljhD95Jou7bIXwsA
 8oLsaOvEK9dylumGCJjS43/HReiI/ZaSNV3JF/6yW5d2FCAqftQZg8QZ+r4K4DeLdFgX0LY7hOC
 /I2wmeGijGkHMz+9W4VlTpmUZjkI8Y4+A0pP93saXS5egfS1xbUhg8A
X-Google-Smtp-Source: AGHT+IH1RIHjckoVdXLtfDrC5JBvOGaa4S0Ps3ubbOqCu3ObdCi9E/lTdV0oqoo+Bj/Hh71Yf2zrdg==
X-Received: by 2002:a05:6a20:d80d:b0:1e0:d848:9e8f with SMTP id
 adf61e73a8af0-1e5e046decbmr235871637.13.1734633134142; 
 Thu, 19 Dec 2024 10:32:14 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad90b302sm1624733b3a.175.2024.12.19.10.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:32:13 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 0/3] Change default pointer authentication algorithm on
 aarch64 to impdef
Date: Thu, 19 Dec 2024 10:32:08 -0800
Message-Id: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

qemu-system-aarch64 default pointer authentication (QARMA5) is expensive, we
spent up to 50% of the emulation time running it (when using TCG).

Switching to pauth-impdef=on is often given as a solution to speed up execution.
Thus we talked about making it the new default.

The first patch introduce a new property (pauth-qarma5) to allow to select
current default algorithm.
The second one change the default.
The third one updates documentation.

v2:
- ensure we don't break migration compatibility, by using a specific backward
  compatible property.
- added some documentation about migration for arm virt machine model.

Pierrick Bouvier (3):
  target/arm: add new property to select pauth-qarma5
  target/arm: change default pauth algorithm to impdef
  docs/system/arm/virt: mention specific migration information

 docs/system/arm/cpu-features.rst |  7 ++++--
 docs/system/arm/virt.rst         | 14 +++++++++---
 docs/system/introduction.rst     |  2 +-
 target/arm/cpu.h                 |  4 ++++
 hw/core/machine.c                |  4 +++-
 target/arm/arm-qmp-cmds.c        |  2 +-
 target/arm/cpu.c                 |  2 ++
 target/arm/cpu64.c               | 38 +++++++++++++++++++++++---------
 tests/qtest/arm-cpu-features.c   | 15 +++++++++----
 9 files changed, 66 insertions(+), 22 deletions(-)

-- 
2.39.5


