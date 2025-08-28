Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CEFCA1001
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFo-0002ZH-Ii; Thu, 28 Aug 2025 13:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urdlQ-00008o-On
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:38:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urdlO-0000KG-8I
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:38:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b49f7aaf5so5993775e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391882; x=1756996682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaaqeFg6YWA/VaFX9J9PW6xyun3eIcbEMeFHq6CsG9Y=;
 b=uRvQ/QW91DzuLOckr8fCJQTrDFx/jRcbuBZjjqP+7NjebCVGomUst68VitN+BrBYwr
 tPamH3FOKdnRk5ih00ooqPPOdeakwC2HBlsNfsWFMOu+9ikVmLZt93SfZ2/cuGj0uy2h
 4rUKYPpYNfnE3IqI1+WVRnXOmApWOmBGftAwyZsE3kSzOt5mjGzXgIaUpsShjtXd5d0n
 SflC4TfOoXZrxT5aifUHZz9zQSV62wRL+/QN8A8zZWQYhCXj/Eei0cGHEJ620Gq7Yprj
 Yu1pfemv3jAXt7xpHhStOutP7V6eWYOY8tyJT+KBKzhwoyEKVrtc3kyX0rMaM6toTxLj
 q5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391882; x=1756996682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZaaqeFg6YWA/VaFX9J9PW6xyun3eIcbEMeFHq6CsG9Y=;
 b=a4JEFe+BIEk1XUBCGFwXUkzDMm9zkrhg7n7XYCo15EkDRxwgoa9oWawNIk3OlYIwKs
 euniq0lpWUDpRwQwYNrR3/T7DN9JqdJGtC53tAkN9IXn0nfIBsrMHnRbml3VNP4BGD8x
 quoq+qvnHDBrJ2eANdrL8E5Md5HuB7tp7y7Od8fyfbkUNNQpwyIE1vyL5jyPvgUXUslx
 1SKYoeLksgnzTN1eeHe/eu1JwxWSSsKaodrJP05v7SrZdvgeg6ys7ff3pyjkkdqNpON2
 NlespKd5RCXzc/9kZURhrmGgFPfctvoIlaX22zpKjmRWZr4DBDmCmLvO0ThiJYODt8ux
 YySw==
X-Gm-Message-State: AOJu0Yw1BVJYX6ff+qf1g0x15OKi+qVz/FkbXeIitV7I+Jt71BP/KLpV
 7/osK8v0lvD7wxQTMAjzBFv5OsYepUDuNLV16eK9sEAgjkoTU/SpuRFYDnx06t+K/W30cQZYUWZ
 V/dJQ3jA=
X-Gm-Gg: ASbGncsuRoLYonxKds8MwL/L2GL7oNIfg6u0Z6FDK/tHr2lEu0C5+lGhDo+HnYOX1Gm
 wQCWCNEkmtueWwLD9kMUAgi9gcFGg9LERRfLtpgl729INp4HlbyPAJswTOjbj/Qju16sj1huHBc
 ESkyZYp9oobGFGIAW8YLjs+KtGIZNkmzq/xzkbfXFEm75BJG8RxRYKoYTgNUf/SW1N+bDJ6tVQd
 2aUZqZ5htdvhONq9e4teER5NJpC/uGB3/ZVn5BGngfzKjOHnXg77ciAg4KLhHll2cACkfY0OzCU
 uuLUiMz4ZD1IRTYrqDRl6g7UmIJ5j2vbFZGgiVxAUbIzivIj9hFfiGxDyDMqb07qf5+5NFdEIg2
 PYjB47yLGCpiYJXJFw3+unpAwGRf15zkbabCqipRcbyuIPnWJwyLyHo0FER0NMNHOQnbl92OT
X-Google-Smtp-Source: AGHT+IH9NGbcSFaqbMrIkPOtnVSA/MCM8mtkb1ZT4Bgu3foAQyUCnBKPfnzJJk8x8xLtZl01Qt2Dtg==
X-Received: by 2002:a05:600c:4f4b:b0:45b:7692:b47 with SMTP id
 5b1f17b1804b1-45b76920d55mr31224495e9.29.1756391882489; 
 Thu, 28 Aug 2025 07:38:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711212566sm24139836f8f.41.2025.08.28.07.38.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Aug 2025 07:38:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] hw/mips: Remove mipssim machine and mipsnet device
Date: Thu, 28 Aug 2025 16:37:58 +0200
Message-ID: <20250828143800.49842-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
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

mipssim machine (single user of  mipsnet device) is
deprecated since v10.0; remove for 10.2.

Philippe Mathieu-Daudé (2):
  hw/mips: Remove mipssim machine
  hw/net: Remove mipsnet device model

 MAINTAINERS                             |   6 -
 docs/about/deprecated.rst               |  12 -
 docs/about/removed-features.rst         |   5 +
 docs/system/target-mips.rst             |  11 -
 configs/devices/mips-softmmu/common.mak |   1 -
 hw/mips/mipssim.c                       | 249 --------------------
 hw/net/mipsnet.c                        | 297 ------------------------
 hw/mips/Kconfig                         |   7 -
 hw/mips/meson.build                     |   1 -
 hw/net/Kconfig                          |   3 -
 hw/net/meson.build                      |   1 -
 hw/net/trace-events                     |   7 -
 12 files changed, 5 insertions(+), 595 deletions(-)
 delete mode 100644 hw/mips/mipssim.c
 delete mode 100644 hw/net/mipsnet.c

-- 
2.51.0


