Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DABCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeX7-0006Fh-RW; Tue, 28 Oct 2025 03:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeX5-00061S-1w
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:54:19 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeWz-0007oa-Qt
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:54:18 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-475dd54d7cdso10541055e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638049; x=1762242849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1wTqGfxroYNlh7jZZ0rSRCtHsLrALGGJnp3dDpAgqg=;
 b=wJhfBtVzLUX2Bh214UEnMFJDj+QqdhzoLFa9CgUIQNk1j5WVPB9X0A/K/kmJE2Uskf
 3jwecax4vPX89blMn+fRoHwOYm87BwJ3kGb/oZmatIS99Fk7YN1AAVCIrdY88i/xo2H6
 e25TW/uh44DONbp0jXWFo4xEe7xcggCwdr3QU2r5cIOzBZAf0pqcXgzJWuI1fUIQ7FN9
 gZKzfdX15WwSWDVwt47FQEaZDWv7anr36fmCZyRYmR+sU/nrx7Bhkd692vQioJJNiLAW
 NJc2SBkNCqgWlEMKJsCsy9oP8AOpMQhGeQd2i5g8ijSsreVTulabL0aQShzIRHJnddND
 qEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638049; x=1762242849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1wTqGfxroYNlh7jZZ0rSRCtHsLrALGGJnp3dDpAgqg=;
 b=b5xWIDCuT1GQSWui/XnLhAiqmbw1WiSQ47jwHD7AD0aC35vPhwpOxlYWS6EFkgr4hv
 AQi1VMPJQQj+RjztLj0WmvmEr4u1HOijj+1dM/eFL0vWnZ/Kx+Sys6fy99zT4RzI161q
 Obl4uGH+Tu84ks7rEcCbgLQgBbg6T0ubdwqhRxI8BfKZQooKmw1I10BRsiwnAyH3+px8
 4DKu5kLFshObp+roHg8sVo6bsFcDrYv2HwlN50QK2GUaxWEyiAXezDo7/CHkinh+zQM/
 GeYo004FIjcfAAIEFkDBrFKQu4reqT3uutUkNFXLRl8ww1hOyaqx7AX1Rg0hsZvX3RSy
 A4Pg==
X-Gm-Message-State: AOJu0YwbemDh+ZR9t4cPB/uNlZ10psIELkM48ilE9r7P6mqti7iINsff
 H5gfopNRTkjOgi8VtCAAWzk5yYCr2RB2Qe3cAdNMjARONpRxYGtWd6H3sbGq9hFTRBmroIWH0rj
 kiGbdwQo=
X-Gm-Gg: ASbGncuozaWM/uzgdAcULKaxtruNkjo8BirhOUtafJaa7acuETJpUanEXZImu6B5Rt9
 NT45AvrqO9fr+KTifhA9m+bKRWbgu7nC09bCqCo1F9Itxrsw1YVWwx/91cvNB0Cjvi+yMORbZ64
 9qzOtZbDuTC/XrrrQCQsm/iVRVt1dClwW2kBWP6BsqiBPkFBBqBWpjCcWH9dePjRlFS+YebiXcz
 P5tZCMpA0OLU+ZmRDxFD6TjcJLn5INftIk1LZHosGaZpyhw/kClUzoOeyW084Ka/F/YpulXhhaZ
 lR9E/mSKnJntUP2/+JaSGra8gN2ogVJin0Kig1Y+uuWNPvsYmXh3y8TMARoZj3M7kThs8rkM6cv
 Zefoo3i44+TDE7WW5CrWVIMIrC/+obIbXXaSfO9YPpYVcrRLXhwWAN9IKM6vvuU+IMb24kbx/Br
 TzPSZnLIi73aGoMZyMjdrXBN47TCj8+snPHUMAekMQcLcBJtQXCsbj2xs=
X-Google-Smtp-Source: AGHT+IHzMjeoNH1FNiov7bailjR0kfGRCe945nTHWe/NpzoLLvG2p5nbrnDm+uv+YLheRb30msxPQg==
X-Received: by 2002:a05:600c:4ecc:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-47717e6ac1cmr23026255e9.34.1761638049412; 
 Tue, 28 Oct 2025 00:54:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477184ff5a0sm14742405e9.6.2025.10.28.00.54.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:54:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/23] hw/core/loader: Use qemu_open() instead of open() in
 get_image_size()
Date: Tue, 28 Oct 2025 08:48:50 +0100
Message-ID: <20251028074901.22062-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Vishal Chourasia <vishalc@linux.ibm.com>

Replace open() with qemu_open() which provides better error handling
via the Error object, automatically sets O_CLOEXEC, and supports FD
passing with /dev/fdset.

Currently pass errp argument as NULL.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Message-ID: <20251024130556.1942835-4-vishalc@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 477661a0255..c9782d67e86 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -74,7 +74,7 @@ int64_t get_image_size(const char *filename)
 {
     int fd;
     int64_t size;
-    fd = open(filename, O_RDONLY | O_BINARY);
+    fd = qemu_open(filename, O_RDONLY | O_BINARY, NULL);
     if (fd < 0)
         return -1;
     size = lseek(fd, 0, SEEK_END);
-- 
2.51.0


