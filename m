Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE047C369A2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 23:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0qty-00014P-NM; Fri, 04 Apr 2025 19:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0qtp-00012i-BQ
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 19:56:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0qth-0008W6-Ov
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 19:56:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso17464025e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 16:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743810986; x=1744415786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aI6/QNHO+U64TvOyvKD5h8vG87B2DRjyXKveSfZqwJY=;
 b=U3k2IdXl/eJFqY6P1dWHRxiUAzZWx4tp9Y2iYqb2+8SPP4XS6jHPVPGD3a5qEO6vmd
 HSJJu+B/NbXNT8F8jOtjpnKHuSljIdmC/ToqF5fD5s2LyctN5Oe4PxLCybKDOKcSX4Yi
 OQy7mauJUCZpaPJiOUzAv7kgjZ4uEOwtJwNdEvyHI4Q+Dme6okcLo5t/M1mdGk43tDGn
 JcDoisG/dqdVznW4gt42w32Yul89KfwDXe2C1MJJvL8x9hvaPaWGetCOcplKVO/yqaJ+
 DrEFkjwq2yhqgoHdd0Em7TvZ5D6aJQZsaeYMQp/XkckY5gKI12e1Xe98wDYuXuqZY0C+
 LmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743810986; x=1744415786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aI6/QNHO+U64TvOyvKD5h8vG87B2DRjyXKveSfZqwJY=;
 b=GPa4/k1z1QDTImOaaX0G/iMVktoL7Gsfpv90ucL+ZSTOIDdDMEW+g9SF9rpRtKm+Cs
 p4KsHjXmlpoyAC9gEhrcaK7Yy7VeDdXQROAI6q5AWHF6h4z0UCVGQRDGyWbyuNRmyfvz
 EM86YMGJnS+8r8vF7d2RmanFcM+0rq4vS7SH2hW3AFTjiohwVKjzF4Ah5TPCWelcOxot
 c9vZ1ey20MSG5AQDUtJK68PJ0+/iZ5IinFkFjWv2hhqx1gzFkHesPlMJrPtB1zF8alma
 jdQIH1yDAeRxYq11kRs1y9Q0ZtOY4+b0CQKspcSciwGagYz/oJo2ALGcrXk95uKndmP+
 0w8Q==
X-Gm-Message-State: AOJu0YwbE4cecRegJ4IKmH2/urdXhKTchKBlOfd1tG7YL1L0rpnTZJbc
 gnow7n2Qipa/vYXNuQAxCLZkR7cPpGFGCVnL+enkqDHSeV6CncaJANHZVtDcVvXFU0v/rxm8Tj3
 F
X-Gm-Gg: ASbGncuA2yuFKcVA9PhMEXnUZMNiB3RywIzCoLK68A4M8kYtjnqxE+34mDTHZbWMmzl
 iN6CF8eObGuydgh5lDtSMLA5uUU2fQuB8cYsmm2g0RDcJT69q29iXaQKemvAtBKHJOneeYt8ljF
 i4SB0EPBbX+RQw++Fj3QzdQXDVF2zN5+nOIIMjVmt7BpFHVu3pmJYizGlJfVypPBbH22ZeXtvpY
 NICftzscWStVm1Y+11N9Ils9Ck6p0BIvSAjx69JPVPZ5MgCLBP2a15RDQ74fM0qfNMUFAYjVSH0
 Vai96I9oh0XpaSw7bPdHn1dRkEgXJTj9zvG5bUem/lIjqZSmFIMZHYKmk09nlvmTYN+ivbf9pOV
 haK25sV9S+0uLAJdG0mDOenySvSP2evic1KY=
X-Google-Smtp-Source: AGHT+IHqUl4lj1tr4poG4B1ruTa9wX7cUYwExMOmzO366Z8RtOLsq/LmJ3TFG2vDCjpkT5HlZgFzLg==
X-Received: by 2002:a05:600c:3587:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-43ecf57d332mr44738535e9.0.1743810986524; 
 Fri, 04 Apr 2025 16:56:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1663060sm62271955e9.14.2025.04.04.16.56.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 16:56:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 0/2] tcg: Convert TARGET_HAS_PRECISE_SMC to
 TCGCPUOps::has_precise_smc field
Date: Sat,  5 Apr 2025 01:56:22 +0200
Message-ID: <20250404235624.67816-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

This series is similar to the TARGET_SUPPORTS_MTTCG replacement
to a 'mttcg_supported' field in TCGCPUOps, but doing it for
TARGET_HAS_PRECISE_SMC, adding the 'has_precise_smc' field.

Based on tcg-next tree.

Philippe Mathieu-Daudé (2):
  tcg: Introduce and use target_has_precise_smc() runtime helper
  tcg: Convert TARGET_HAS_PRECISE_SMC to TCGCPUOps::has_precise_smc
    field

 accel/tcg/tb-internal.h     |  3 +++
 include/accel/tcg/cpu-ops.h |  8 ++++++++
 include/exec/poison.h       |  1 -
 target/i386/cpu.h           |  4 ----
 target/s390x/cpu.h          |  2 --
 accel/tcg/cpu-exec.c        | 12 ++++++++++--
 accel/tcg/tb-maint.c        | 18 +++++-------------
 accel/tcg/user-exec.c       | 10 +++++-----
 target/i386/tcg/tcg-cpu.c   |  1 +
 target/s390x/cpu.c          |  1 +
 10 files changed, 33 insertions(+), 27 deletions(-)

-- 
2.47.1


