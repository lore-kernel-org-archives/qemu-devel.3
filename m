Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B89BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfV-0003T5-Ql; Tue, 30 Apr 2024 12:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf5-0002Qe-8m
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:59 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf1-0005dR-JG
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:59 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e0933d3b5fso26017161fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495733; x=1715100533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jfP2Xs16ecOHAKV51keNnHcyI2sGLGC6VRxN9Ns0ctk=;
 b=HppNUR/AHl5J4N5LwItCrS1ZZdycKUHGG/RBkKxAsJmKf4VRyFo17kUdDQJn1pQ01D
 BIvcXKdCK+YLI9V4HvGhXYZhYtN5rOX/7pCcMivrfBrJusMOpkf7lXL6NuE521CgmG9Y
 OUGov4EU/mmJ+YJgPfKY4nRETETLiZQf+HN9Ao+5AbySpLspPIsbKnyWCEFiv5bhXrGc
 7+peV9SgYD96a7oBXCmqknYOdQh5LsdgMU2FBYM5HCDeS+thwxKi/r7QoLNK7wY2OpOK
 N64X+UiB91p+nIga1MWLMPd7Md+XoAuSku3xegFN8bdbfYsNoLU2lBEMuGjV9N2pieng
 16/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495733; x=1715100533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfP2Xs16ecOHAKV51keNnHcyI2sGLGC6VRxN9Ns0ctk=;
 b=ZEXNAyb0tFG5oUA0+Pk5fxnl3eWsQt8VdxXSb5GTBxkVhtFMficZ2tMJwFHFDkll3n
 +Wz5lvc9IH/fqQBmNu4SQYqhF+Ylk9qmDN1FGyqPyfxMT/R8aqe/s1HiB47Lh7v9RkPj
 aunCag9SEhAvQ6EG7b2gT771ncQy1Al1h6kTCiePaCTuqIzyih2ZBQxrWv4rjtLxFRlO
 Hqe6iJSZi8H0Zc2t8JCWzFhQVJHkqzjlitX5mp8fVyB62pNy4jVj8TKA/nLL+Sqfrbhs
 nRn0DxV8be8frc20mJJf+IjTj8Pz3KMjBePbVBKDscZIdKx1kMh125OdOqcAkA73ARn3
 jREQ==
X-Gm-Message-State: AOJu0YzFJqar7pMpRfNBIS5BYm4+3kH15TYHGoqYpJE4AZzfaJWVWiFx
 K2IT44CrRqKzKd60OxeoFZJxWOEgvH+ep8yertO6li5p95UtL3tectA8NPXgkE6qtL+l0DA5vZn
 y
X-Google-Smtp-Source: AGHT+IHgbsLD6RDyFchRmVx0AoV5/tsayvrFiIXbdmJvb+PvU37+JP1vx644PhysajVYA8F4px0jJQ==
X-Received: by 2002:a2e:7012:0:b0:2d8:97f:451e with SMTP id
 l18-20020a2e7012000000b002d8097f451emr135211ljc.37.1714495731498; 
 Tue, 30 Apr 2024 09:48:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/21] hw/char/stm32l4x5_usart: Fix memory corruption by adding
 correct class_size
Date: Tue, 30 Apr 2024 17:48:36 +0100
Message-Id: <20240430164842.4074734-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

From: Thomas Huth <thuth@redhat.com>

"make check-qtest-aarch64" recently started failing on FreeBSD builds,
and valgrind on Linux also detected that there is something fishy with
the new stm32l4x5-usart: The code forgot to set the correct class_size
here, so the various class_init functions in this file wrote beyond
the allocated buffer when setting the subc->type field.

Fixes: 4fb37aea7e ("hw/char: Implement STM32L4x5 USART skeleton")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240429075908.36302-1-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/stm32l4x5_usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 2627aab8324..02f666308c0 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -617,6 +617,7 @@ static const TypeInfo stm32l4x5_usart_types[] = {
         .parent         = TYPE_SYS_BUS_DEVICE,
         .instance_size  = sizeof(Stm32l4x5UsartBaseState),
         .instance_init  = stm32l4x5_usart_base_init,
+        .class_size     = sizeof(Stm32l4x5UsartBaseClass),
         .class_init     = stm32l4x5_usart_base_class_init,
         .abstract       = true,
     }, {
-- 
2.34.1


