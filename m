Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C40C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 20:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcW2E-0005cH-JM; Mon, 27 Jan 2025 15:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tcVYC-0006gL-5I
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 15:17:40 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tcVYA-0000U0-ND
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 15:17:39 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-467b74a1754so67550411cf.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 12:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738009056; x=1738613856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m+4AY+aIcsFifSg6NxmWCaZNdEgX06WNWe8R70VVWKk=;
 b=M0aeLFUQ8SHg8Kvei716jvtQmNexk3e1extMtd0MPeKPcviAfP05PdkT6igsVNC6Gg
 BkqY5yV5htRE0nGQJMZMqeqK8XdhuCULgqybMArc6K9q1BJcQHCce3Xw+xObcX1qIjwR
 k/26j9zBxbjDZj3qKYWZJ2dectxiYylannT+OYWzfZbMko5pt7xORMuefvqHrqeETO1X
 6NGIs651i/+0bKdEJ3CyOtcpkA5eYOEY9VWGLsNJ+3GysiR9jw7FkOqCVC3qltVk+eXH
 7dRJiwyxw372b4UQlh7eapz166Tqnc1X6ONvgbGkFLD6k1P14VVEK7s4EASYcE0XZ4ut
 7g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738009056; x=1738613856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m+4AY+aIcsFifSg6NxmWCaZNdEgX06WNWe8R70VVWKk=;
 b=Vr/43levNVx//BvLxwQUh8w1oHgpDe3evGYk4VTGOL4ebLlo3caUS/HNseRzowxpSM
 g69kjOA4vx/F/zjPDAkeK5M5IHWaqaKXOPo/s5FY5WPnjmSe6q+pO4ng0BHFBpoQ5yFh
 6pJkQuZnS5i1NwjaoHR705yGgpZ0kmr1HeTe04OWfaY/XwJbmF/Nna3cRlW47n7gkKjq
 AZG6Cn7zfxN04RNDN3DlhJZ0cy/Knfocf5bWfCWwtH0VYRl+NX+usr2/B/FO0nQH78Bf
 Ws8v54/GQvJO/2qsCr9hIiySbp4Vib+qAKrB8FdvoKi/nnWFetgnAdSefLHzo1FqeT5h
 vWsQ==
X-Gm-Message-State: AOJu0Ywyj8OS2W+wDl5SIFVxSsZD8OjjvWvvZIO/+IqiWANb4+OC0w7S
 Fb6S/IiHeKspzN3L/KtqtI8z9Ol4E40pHM1q06392S7YAeairK7WaUq9MPAOC2c=
X-Gm-Gg: ASbGncsIP+tvm8Qee6JHGlzG6ylj/t3cSQyIeA4JEaZIv4D9TPFFm0Q5K+v+0kLmwq+
 +MqblxhOE/PyZVuBcl7RlRKOPoa4Ozd97UFO2ubL20an1mV8ZWcfXk6Rh9qIUiIX2cHxKYMx0Q+
 O1CGpw80EZAej6tnfSIcOR8UZBw6Ro4163FiAhH3xYImgXZ1jehv9UZ7K0sNG+UqNhrNoIAAiA9
 i2cpY68RAavaE0AAB0iRFG1qfOQknd8gjNsa184lTEjTmPJUPNbUszDprpcQg9UK4X4SMIU9OUZ
X-Google-Smtp-Source: AGHT+IFXRswBqMcfThZa1S6hQ7NTDlnfOTRSCWtiJR132xtw7TIcfCE5Dvg4V1tKKmFeX+xsc4RR2A==
X-Received: by 2002:a05:622a:24c:b0:46c:71f6:819b with SMTP id
 d75a77b69052e-46e12bdd346mr595964991cf.49.1738009056546; 
 Mon, 27 Jan 2025 12:17:36 -0800 (PST)
Received: from luke-igloo.. ([18.4.85.124]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e668636e5sm42601081cf.4.2025.01.27.12.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 12:17:36 -0800 (PST)
From: Luke Craig <lacraig3@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luke Craig <lacraig3@gmail.com>
Subject: [PATCH 0/2] plugins: add tb convenience functions
Date: Mon, 27 Jan 2025 15:17:32 -0500
Message-Id: <20250127201734.1769540-1-lacraig3@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=lacraig3@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Jan 2025 15:48:31 -0500
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

This PR extends the plugin API with two functions which allow convenient access around tbs.

The first, qemu_plugin_tb_size, provides a mechanism for determining the total size of a translation block.

The second, qemu_plugin_tb_get_insn_by_vaddr, allows users to get a reference to an instruction by its virtual address rather than just its index.

Luke Craig (2):
  plugin: extend API with qemu_plugin_tb_get_insn_by_vaddr
  plugin: extend API with qemu_plugin_tb_size

 include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
 plugins/api.c              | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+)

-- 
2.34.1


