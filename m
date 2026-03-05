Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07142F3D32B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBMa-00089m-Vg; Thu, 05 Mar 2026 11:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyBMS-00088P-MG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:15:43 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyBMO-0004WX-M7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:15:38 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so51760385e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772727333; x=1773332133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BhSDeaS2AJHX5CUBcf6BI4SHh87iv33YvsmKEPazhmI=;
 b=lE9NG0L6Cih689QjlnYKigOKZuuoyjKOeTZLWMJWMtLVdsyLHg1pVfq6DDSt5oMHA2
 yaDnHQqTlTAvmvO2kzGbzJ9Go1nA8M6KOwO0SOLCF45gJcLXgzDzaO/3ruyEqwWqyzZ0
 al+A84vAsM/so5sGnmdX5R4akI/2AKeG07veWIe8PSUpJicLyG69pAQwynzZMIkTa1NP
 H53TO/1sk+PPDQGAOyzLxSl5WspY4FMYchwju4r6FQ975/ImhTX1fnn8gWnjnTWkJz3G
 ZAfmhSnoXCeY7mNCaJmLXwqaHXK2AbpMNPbeeWYRJbuXWSevRUI056wLEEh+0T2tIHF9
 sj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772727333; x=1773332133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhSDeaS2AJHX5CUBcf6BI4SHh87iv33YvsmKEPazhmI=;
 b=sNNbY1FomKkLmq2waN0Q/LIN3gb5ujJSbGbrfxko3oj3o8UoyJFIm93B2Zm7VgDsW1
 EkMOANnvpZGq/VLdOb7eE/5CJ/Ha+SQPuWqYApa1baj8iV3cXBZK+bikDXHL3Q6G3cH3
 iScScY4TLFF6ERbQF7sbD4dWnqJACXScQCGHsjO0ih6D6+ss7a3+K4SvpL/hPZUANPHi
 A8If+Jyt1DBicK5u70aJrBWtxolTqxR/mmYb1o4lvq/Zla/900XIQpdhLzKBcDdvXdOQ
 IyxAA0oL0tT4wVLa1ItvYp5phxaXqOSiPJsvfTjn9dgMKVaeSQOwtYP3J3Gk1ir3PMBT
 IBlQ==
X-Gm-Message-State: AOJu0Yx+oc+inKjyrE/gDAJoVJNsuaNRjaic8y/Jig7t5dGdyGgkdtLe
 tDQFanircok7IU7PWZEjlMoxBDRgGeVflvwNh/Xg9CaIQ2CptC30shkTXCzVoKihxvrOrqnSxCh
 HYKW1
X-Gm-Gg: ATEYQzw+gEQfIq4avea2YH6sFlXC4NhfynJGRLIvESYDyhQxLqJAcUAjI8JxTAUk3+e
 BQ+eY/ess1ytmJXziRG7LV6lov6SzumUtZJ6MlwsZWlL9L1PKpRmn7OIWE3J2meF4cXN/ELidEV
 37Twia8wN5Pr2KBfhgIjcR05FRov6x0ihhafZNMxjVHxo1Zhd6EA0a9GIOecaqMkbWuzFJq0B5V
 SDyRjembn2oGuZyBgED6we/AyQdMvYt4xVCDfqvLqWncccp2jFzxQue/wsUwFP0GUQ47OlENf8T
 D6om2dEGlDAS2QaWyMQgBgomeJfN2zxmmJ2WgByjxm4VYoE0klnM/pwYwSQFkgAN2cVCzfIkXzK
 JDtlhA5CyE7Zv1aDNz8HOaGTbxlK9j8tNlksdXp5h+eZ8hYppoCIlcR9J5jdWc/Gj+ccvwPdqe3
 GRle9457BfFEUI8jyk4KowFh0SvMBt40/9KnuQQyL2EJ8I5wpAlSR5gql4joEG6sbiSUC1PWOVb
 AobIFAlsH2d2h133KXx6i96IPOvJPbq01B6gwZqRg==
X-Received: by 2002:a05:600c:6309:b0:480:426e:9d38 with SMTP id
 5b1f17b1804b1-48519889c5amr108363165e9.27.1772727333219; 
 Thu, 05 Mar 2026 08:15:33 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad01d2sm53466465e9.3.2026.03.05.08.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 08:15:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 0/3] tests/tcg/plugins: Fix sanitizer issues
Date: Thu,  5 Mar 2026 16:15:28 +0000
Message-ID: <20260305161531.1774895-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset fixes some minor issues in the tests/tcg/plugins
code which the sanitizers detected.

Patch 1 is the one I sent earlier today, and has been reviewed.
Patches 2 and 3 are new.

thanks
-- PMM


Peter Maydell (3):
  tests/tcg/plugins/mem: Don't access unaligned memory
  tests/tcg/plugins/mem: Correct hash iteration code in plugin_exit()
  tests/tcg/plugins/patch: Free read_data in patch_hwaddr()

 tests/tcg/plugins/mem.c   | 95 +++++++++++++++++----------------------
 tests/tcg/plugins/patch.c |  2 +-
 2 files changed, 42 insertions(+), 55 deletions(-)

-- 
2.43.0


