Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3782CCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFs9w-0001FN-DE; Mon, 03 Nov 2025 05:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFs9t-0001FB-On
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:51:34 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFs9n-0002Qr-Ng
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:51:33 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-429c82bf86bso1674488f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762167083; x=1762771883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h45K5EMFAkvswdeczwvHaEbI+3Rl1O7EQR8rwL71S5s=;
 b=bTqllwStyjiLjRGNZr2Ves+hb+w5lPbgGfv13Acqfd09TnUWqjUFz18hvaO9uslyGn
 Pfui6y5TaMY9gB+i9ygQkGzN/Vv3rfOBkd5RlfnPt7T6KSEAebQ9HKTgA+SAEEmttWtY
 UTGmuYsJP+LmHA3eAS/uDHJnsQAIE2Sw+tA0r5NJS5JsAzoXAlBQcd5Iv2wrSnowVv2O
 JqzTmQTBlecO1l4SBvB8MKWo0+z9yt4/GHEccDXBSZUa/nQ0fmineKDcf6Oo6ERXXum2
 FgbfWzU49V+O3xxSVCF4Rs1Tl8NqlTa5yYwzq7K25ep/4pe+ZmtV4rXzpqf3dczqsjWX
 Zjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762167083; x=1762771883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h45K5EMFAkvswdeczwvHaEbI+3Rl1O7EQR8rwL71S5s=;
 b=d8A/CRHe7CDh5igbge83AC9rpi8mJYb4+FLUO1ycZJB/1WOL1mwi2E8P1ztjRIUKMM
 5M7JiVf2BPLLniol+FanqAVYEd4m4WceGQSkgbFPAvQnYkuyYWGoyhc6BNsac9EaeXaN
 Gnyuqp7EdX68AInn13koDKRPXI8yA24N+Buhsgh1zq91ev+Llo9AxT9qUfO2x3ENXhpB
 VQr3ksonMAdFD5Qd3HHpVK99p65Y1YaYiYgP0iyvjV6POu2gfu1ISja2w8hNP7w8rhHv
 cZu7oU7ajSwFA+RUOphbl64WNtPXeanZtX3GUZjS/0BjNoYzJhzh3tDyy/2srgBFn7Zc
 JvpQ==
X-Gm-Message-State: AOJu0YygfrAABaq/EVMwr9A2IbnV4yq8wmndORr7KVEjtJABDvRJpNKY
 IpOU18lwEjpwIZ51HhVSJZQhcOdJ6BJOL//Xlbow1JK3NNuCgtM22y9QpqtMGKSNep8xHTakKCV
 XzE7vSFkxbUTs
X-Gm-Gg: ASbGnctRm6XyRzNdmYD/1YhQkalYsPoDw6y4sKv+TanEKNIVJqYiBjxVtva+Ce3cktN
 E3ic5UR13NzVGbViRUMpzMI+ocsPk+sG2M7/D/n/nhUTu3dOf2N9HI+9iwWyLZD9VY5Ye15ObAh
 MIZ9OePcB7sWZFYWH497WaG+42n0r/ZTbZ6npy3ZxYapQTMdo1e3oP9MdQbcWHRJtBR+3hBSj1c
 cl2db8KrBEuCwTmYXX4dz7deO9rkCPlkbRuXho5y4vFBPDxoSeLtAXPCUoHQN66jOBccroyv+ep
 GyF8f/xGnELr77WQFEcqiA4AZK7brIFHuXlaP/UzW4ozrnyBoKh3OFrOlNJCN4V5kC0J1TuEjZx
 rhct326gYDiYyE2kPyRaxiBxuwKJLvilblS7t+t995S2VqhLRb3pgtzq2hP8ZED2CQFQO6KqxUJ
 U6ayKXGjunbz/KJWbGwRxNpA3rl+8/vj/dAabS4PXGtAh+yLO5Sc/0P0zID6YDpeDRaa3lOA==
X-Google-Smtp-Source: AGHT+IFSjX5JxLySnTPkAtr3xKIgIWBtVk8ERmwpolWRdKf07h0luhAS9GjG3th+jdsA7t5zGRf96g==
X-Received: by 2002:a05:6000:1a85:b0:429:d2a9:5dea with SMTP id
 ffacd0b85a97d-429d2a95f05mr2681818f8f.15.1762167083037; 
 Mon, 03 Nov 2025 02:51:23 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c11182e3sm20055129f8f.11.2025.11.03.02.51.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:51:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] osdep: Cache getpagesize() call in
 qemu_real_host_page_size()
Date: Mon,  3 Nov 2025 11:51:08 +0100
Message-ID: <20251103105111.68294-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Cache getpagesize() call once, so we don't have to worry
how often we can call qemu_real_host_page_size() and
qemu_real_host_page_mask().

Philippe Mathieu-Daudé (2):
  osdep: Un-inline qemu_real_host_page_size()
  osdep: Cache getpagesize() call in qemu_real_host_page_size()

 include/qemu/osdep.h |  6 +-----
 util/osdep.c         | 11 +++++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.51.0


