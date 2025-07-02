Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBBDC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuwo-0006mc-J5; Wed, 02 Jul 2025 06:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwe-0006hO-CQ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:44:05 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwV-0001LD-2Q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:44:03 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60768f080d8so8993591a12.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453032; x=1752057832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLr3MJ/hu5ri+yIW2Higb0CF3yMxJGbnYgVNVmgIUMg=;
 b=O5PMxqy4iMSOkUClgCUw5CUpEb7QadPTLouK5ZC++umieIFNDF+Y7WsXwkiUVulpR9
 DTUEQ6/4EUPaN3uGJcDdisLu0ZqfVVm8vRhtuTzXjZ2DFIW+G5bQFRCnvOD7jxXstTpd
 NMiRZNR2qsERnWAQ2GBBQ26yGI305DLU2l2iOnBXxQyCSHZIM8kul3qYCVTnj4Fe8M15
 bv7uDMQ6/c76yUhfvC4e/B38pBRVHn4ZUNx9k+dr8vwW0BO/91AB5mb/SB+o2OckWAdo
 b/gxNfLMkF8srYc7Q1thpq0wsmIp8sREqX5m892r9jN5nF6VnjwI6lN4rD8xuhpnPsQE
 ETTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453032; x=1752057832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLr3MJ/hu5ri+yIW2Higb0CF3yMxJGbnYgVNVmgIUMg=;
 b=AM+RU3M5VWnvlSv0PPVLWH5VWPxwRaGdHw4qJ5zEsHfkd/JHj36SK/vuAi0ayz/kv5
 XI5L1zAgGhN6mnY6oeG2CSL1AEqNPW3vqfwjfo5kgQx9VPrJqO5EbGgXcjOu+oAABCR8
 tdiiLtcD//cNpsQ6q//bOvp4YaL+i60lftOXEby+WBo46gJuafNvFUvjqihC0xCLrxud
 SWweemsAAXwJ3Xa1PIGrDgN4Ez8tLG8j1ndIu2eeZx2AC8GyEx/EaWiZDA25G8OIoubj
 uaMCHfaUULqk3QuFsvjcxbbDhfkyRdVFfcZIHwHWts6/AXMKFCXH+XA+wH1DjwCMr5VX
 zUsw==
X-Gm-Message-State: AOJu0Yyk3Tp9W2cuBwN0Q1DUFZVqxPOGZWY7T0Vg6jDQ2BqFO6iTxATO
 x0PYfGQwe3pggnMjLlZ/v/C49fzMVG8pPd6rXxBeI1KBG1e9BeYIZewKz8f6STPncjQ=
X-Gm-Gg: ASbGncv3UGRS3UlwbbIuACnbqtX5+iv8xISEPdl94J5BhuMSY25zcVRkUYDL5cOkcyT
 usv+pWJ7RnWFg6wWf0xZRe80P/LCURM4xloKGUrV9EsNcVMqYkuH7Jx4p0KuiB5iHsiGY4/unxN
 RKKOcv9p/LRk6XVp3SY8R2ZTVc+bKgNSgA/S5NWQgw7V7bFbgyy/zd/XYrz4ua31WYEQPxlrBRT
 iQfjaeUwyYbxSxJtD4F9qwf87W9+u3S3kLQhNhcc1QoAOQh0tZtB4PMK5tBBmuxU2hQwEv8F2tu
 2tz8eIZxmHXq8cLwg1uX9ccXMNm9P94xef29/o32WJ5XA/uT1V5KluyeHcwpdQ5BblfMxar8tw=
 =
X-Google-Smtp-Source: AGHT+IHY/tlr/4cJkuxKspkJDQ0GrrBOjNRqv8XZUAwe9Lpcxre88iXZoH6XyMBPGBCkiQQRL7AAvg==
X-Received: by 2002:a17:906:dc8e:b0:ae3:aa8c:e8f with SMTP id
 a640c23a62f3a-ae3c2bf3c7fmr211376466b.2.1751453031571; 
 Wed, 02 Jul 2025 03:43:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353e8d978sm1048072666b.183.2025.07.02.03.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:43:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 378735F930;
 Wed, 02 Jul 2025 11:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 14/15] MAINTAINERS: add Akihiko and Dmitry as reviewers
Date: Wed,  2 Jul 2025 11:43:35 +0100
Message-ID: <20250702104336.3775206-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104336.3775206-1-alex.bennee@linaro.org>
References: <20250702104336.3775206-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Thanks for volunteering to help.

Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250603110204.838117-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-15-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 52f0164edf..3932a6e56f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2685,6 +2685,8 @@ F: include/hw/display/ramfb.h
 
 virtio-gpu
 M: Alex Bennée <alex.bennee@linaro.org>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
+R: Dmitry Osipenko <dmitry.osipenko@collabora.com>
 S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
-- 
2.47.2


