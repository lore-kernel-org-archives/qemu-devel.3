Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FA4D33994
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsK-0005ZM-RS; Fri, 05 Dec 2025 11:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsE-0005XP-SF
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsD-0005lu-1U
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:38 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso18665335e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952895; x=1765557695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXbBYub2MS8i04tvqhtIXtF2IbcS7oxTb9sSEv4XHCc=;
 b=nwskXBlB7Ue+un+rNBPEO2PY/9p4kZyHvXB7VV/uQxOGtRkcLGWsrOQ7IgM1KpsOys
 lpulKR1OPyRbj0iKaF5GR4c3ajrM9AzrWkITgvy4v0J8BWmAD5svnmiWVJEkM15IKofX
 qCmNZzXO5PD5HSBAvnsXKwcPbZoMOVNknkrT9p8EifYzc+tSDMO26Jb6TYeuLppJ6NWB
 ud4YLXNDuJ/TOSwnYzstw45wwXOgpOj6Q5uvtIwS+PAy7NlKDiVY+FtaMsn5iwKieEdA
 Khe12NO+8jgHJWh0/r5IxibW4ZpZXAxQFDiRDPX3s6Vx68iLSp1284pDDmRPhNKTZUWJ
 GD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952895; x=1765557695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jXbBYub2MS8i04tvqhtIXtF2IbcS7oxTb9sSEv4XHCc=;
 b=EuXLihxJXXME82DHeprF3YcwZzL4quQl16SQTr2KAjs521VVSDI4xPOk4slz1RStXU
 ZypwU5W8cV3GUt0KN71YSRNWEdhZtxIsEJv+c1yF4uNAOns4mwBJleBwri6G/BhVtea3
 /Fm/srbcNfpymAeCljXxipULrtC0q10NhaN5TjxnmcA2yBuLVV0bggnJy0qZCqgo90Ls
 D6N+OUOgvRgGrsEoaQghUw1cJnipWwIQ+S9VHbh+ehTcx0BqQNcZD30ifYO7+xy/8+Yk
 /Y3m9pZk3X74DJSjzJGZpmfOkDEnd3MEQnphmUZmnU5nE/VPKBH87RKGEXNLol9qUMvo
 NqCg==
X-Gm-Message-State: AOJu0YyuxM6flmtHV6w6aLUfFMhUTTkSUB+bHf7YC7EF8RuqsBMQbqcq
 U7+MHDdiH0qAHTxS6Lgfy91jyepG+JRnOJ2wnaRRgiM0sIvHpZDiK/JBf9KE4yOX2Dk=
X-Gm-Gg: ASbGncslRn45KCQWwV0O5LUrqt/SJoCvL7jQ2mTBJKsK1/TXmB4mph1brPwDmw99DTP
 ZhHsVJ/6tGuxjc+iP9Wd/cpLRrLzivAYKGHhIqkPVoAZDi5+mZvx1vrsy7aFFkGXrtK69kG7g5H
 wl0CelxxMqrP8c8PfMj4mfoqIWSBR8vw3yv6uybwDDFf6g1csLI4LrM+bwApuqk+h7ioI3Zj7wT
 +9qtyxT09yc/5KUbXw4HCQzFb0wR3jnDU5Py9jaL06pY3Lt4mYFGaoPXW9X1KKT8BJ5k8KAfB9y
 tb3UIGmxAowc4DI1HbmIgbKtjUl0oeuWjQY2fl+YYnZq41dObAsUqTU8KyyCeJVh8ZnbIXGAgUq
 ato+d/qZx1ckQauO9KV6CQrygHWe6LMD/6WIweUC/ywtdKwZl+TVhxidzhaTyLKX381bE/6n4I2
 ykK5qMufgIWDcHRrsO9TPtiA==
X-Google-Smtp-Source: AGHT+IHf2FwZnc/OHJ4ZHn3xusttHovu+yJwJSTuCs2ZDPAJDIjSaOyUY/wU0+o1hTxu/5rE5wAAzA==
X-Received: by 2002:a05:6000:40c9:b0:3ec:db13:89e with SMTP id
 ffacd0b85a97d-42f73174445mr11481885f8f.7.1764952895223; 
 Fri, 05 Dec 2025 08:41:35 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee71sm9475639f8f.15.2025.12.05.08.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D7B05F915;
 Fri, 05 Dec 2025 16:41:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Delevoryas <peter@pjd.dev>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org (reviewer:Incompatible changes),
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [PULL 14/14] aspeed: Deprecate the fby35 machine
Date: Fri,  5 Dec 2025 16:41:25 +0000
Message-ID: <20251205164125.2122504-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Cédric Le Goater <clg@redhat.com>

There are no functional tests for the 'fby35' machine which makes
harder to determine when something becomes deprecated or unused.

The 'fby35' machine was originally added as an example of a multi-SoC
system, with the expectation the models would evolve over time in an
heterogeneous system. This hasn't happened and no public firmware is
available to boot it. It can be replaced by the 'ast2700fc', another
multi-SoC machine based on the newer AST2700 SoCs which are excepted
to receive better support in the future.

Cc: Peter Delevoryas <peter@pjd.dev>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20251126102424.927527-1-clg@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 9386cffba26..ac31a2bce42 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -308,13 +308,24 @@ I2C devices connected to the board can be defined via the QEMU command
 line.
 
 Arm ``fp5280g2-bmc`` machine (since 10.2)
-'''''''''''''''''''''''''''''''''''''''''''
+'''''''''''''''''''''''''''''''''''''''''
 
 The ``fp5280g2-bmc`` machine does not rely on any specific device
 models, it can be replaced by the ``ast2500-evb`` machine using the
 ``fmc-model`` option to specify the flash type. The I2C devices
 connected to the board can be defined via the QEMU command line.
 
+Arm ``fby35`` machine (since 10.2)
+''''''''''''''''''''''''''''''''''
+
+The ``fby35`` machine was originally added as an example of a
+multi-SoC system, with the expectation the models would evolve over
+time in an heterogeneous system. This hasn't happened and no public
+firmware is available to boot it. It can be replaced by the
+``ast2700fc``, another multi-SoC machine based on the newer AST2700
+SoCs which are excepted to receive better support in the future.
+
+
 RISC-V default machine option (since 10.0)
 ''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 70d3a99d79e..e61a6438fef 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -175,6 +175,7 @@ static void fby35_class_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Meta Platforms fby35";
+    mc->deprecation_reason = "For a multi-soc machine, use 'ast2700fc' instead";
     mc->init = fby35_init;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-- 
2.47.3


