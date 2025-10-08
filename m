Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5F2CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 05:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6MWZ-0000JB-Gg; Wed, 08 Oct 2025 01:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6MWW-0000Ic-HA
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 01:15:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6MWU-0004Gc-Nv
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 01:15:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso50405215e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 22:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759900532; x=1760505332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n1d0kh7stPXoTC2hUJFmtwdYc61v5/MLY+/lEebOFzc=;
 b=RR6HRPB9I8xQn+0LTRWVaPbb0keoNZy68QgXTOiqmOKYMdhsDfk8P3pP2XLBtvzEtQ
 FYcmRseuUWqeMAoOFl1ATIFnjzqtkvSqWZWF15ynlTnBt78X07T6fWKiS9fZj++zSbdU
 kO6ShQ6D4Kpz2HnlYLONHvTjXpCp0z+atY7Ok/sBaLTkmbyO5+ekOgsXYfK438KUL3N6
 IG4hOCVKGTuG4jR5FLY1uK9HOBiqp2dsV1EVHQbFuK6vw2Qy1geRkj+cFdZ4zVb1C7j+
 nFjKoASNU3mWo+xvzI+3cEygPmlBxujEAhf+aVMpPIar6+w/pHEh7Ok3Kiut/SMMhBJw
 x8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759900532; x=1760505332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n1d0kh7stPXoTC2hUJFmtwdYc61v5/MLY+/lEebOFzc=;
 b=HOxUsIAo6JXUEKvq1vTane6CPVkKBrgnhCWwNCftQ1IIwV1tohZJ7ARRxdUyWAeCnu
 rKg8JIJJI0z48nNYfBlSU7uC9H69xxAiFiXbcSLHeWOV7m0GEoFlt69NDjQX6S4nOvGm
 32ltPTveh1FJab3HEvVlpbnTEEYxhx6Rlj6CuoACen9eMF5YQZNCKSsz7nmxsn/mZSLz
 x//5pUThaYaCJ0/uePUgc0jHGbBmi/AHQpjT3cwg7rCz0xjJya8fV7f9BoEGUji0dKUI
 q1z8+/jlokWvgaPyJ3KEIfbzxlgVeqChiR25TlAQ3nyPeWuMtiPoOumnJ6ZYpgfPNMeC
 CbMA==
X-Gm-Message-State: AOJu0YwokqcUBhJZHnvT6RyfyrIrYAGCOzARLs0y8bozMWo+yVT/ZCvX
 OaHcEJU2RF06ake2tDsXsCCk0gx+5tSrQj+kyKq/zjv4DB4v/KHlxJrvbtUnzMONQ+0MnXudKz3
 P7Y9mTd3Ifg==
X-Gm-Gg: ASbGncvBD7k4Z1N8E7rXWd20zNGkJg2G2Jt8gGtRnRImPtLNA1yVMq7bKhXWOVjltKL
 IvhnKnhL5cYtyilY3PLda2pSGsiYQtp6rpR6MrF3ydDqCezvSFrGViXlGtIqjs+NEqhy4fhiVp9
 vl1pDm+ucU7MaNI+/8/sDQ506jUUrx0Vtdy40bflrG82J//eCsP/69updh+AJYlC5dtIdaNbjZP
 9k4oMIqdZs30C2j936du1kH7xxxqwbY6ei0Q7D8Xk3bWrAUqH7SG9Uy5hQ2707LKZFKD3iATjuk
 vfdIK3cJmHhdbTILJUitkrdfMzGzAvWjzeeDftwEfHdeUx3YYUrsjxbh2HvYSnMQWxT284AO7mD
 LxgUc/U8QAyMX8nOzQY576x/aml+pM9BL0s3WzIkN9Cjl8dqqL76YjR4IBuJKmrWcypzTWDC0ub
 vXQUUT5EzzhGx0o6eAGjSQGpGz
X-Google-Smtp-Source: AGHT+IErENHVTULC7odCx0/dguwLlVjj+YNUffH8pZelcr0H+WLw4v8KmjSGGAM8ChjviQaSHfHPJg==
X-Received: by 2002:a05:6000:2509:b0:3ee:147a:9df with SMTP id
 ffacd0b85a97d-4266e7df9d1mr981809f8f.39.1759900532002; 
 Tue, 07 Oct 2025 22:15:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9703sm28519467f8f.30.2025.10.07.22.15.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 22:15:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/xtensa: Remove all uses of target_ulong type
Date: Wed,  8 Oct 2025 07:15:27 +0200
Message-ID: <20251008051529.86378-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Remove the left over target_ulong uses in Xtensa frontend.

Philippe Mathieu-Daudé (2):
  target/xtensa: Remove target_ulong use in xtensa_tr_translate_insn()
  target/xtensa: Remove target_ulong use in xtensa_get_tb_cpu_state()

 target/xtensa/cpu.c       | 6 +++---
 target/xtensa/translate.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.0


