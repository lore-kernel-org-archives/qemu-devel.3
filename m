Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC08C38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl08-0002gh-VJ; Fri, 05 Jul 2024 11:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzv-0002bB-MD
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:20 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzu-0001Hg-6d
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:19 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a77c349bb81so135810666b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193837; x=1720798637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMmvQJJsx2DzZLMmy3nNlACqKsBlZyZqjVhcXblbIqc=;
 b=nBorfrRyWsoOAHoVOXgomwqnm7d5LAGTo2tozBUYS1MMaNyuuxrYZMqpn9JYp9zT4X
 JSzKvL9/KX+IDCFV28c6xNDfQzmYHqInMot/8oxJ0CyC4JkkxKrhpqXfi35rkSGjnuDv
 L8hX+PE/6wroKmXuUe5TEW99qhy0Jzyn6RXDkaWvgi5iUwVeEa2F1npNkkB/W07iI+aJ
 CaHMhsT2QLrOCDjZXNT1WAN8MJMtk+A12nhne5VztlU/bO8mneAql0CfB2rn6wNEb8dA
 dGHOyWX2Azv/cpkeZx2JgVUiyQ9vwL+SJ1ueXzymlTJOhjPzdV/PZO3kYT6A8FuZbcfA
 Avtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193837; x=1720798637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMmvQJJsx2DzZLMmy3nNlACqKsBlZyZqjVhcXblbIqc=;
 b=c3cpdPR8wnLB97U/admKbDycJyKo4bGnQSx7PuqRzF55VOS0akBDwoHwmD9eAByZmZ
 u4gz2DzUx1oUZaLKSJR0SdywqELfKQAM1Es7u0dg+DyNANIbmi9IIytONwKP2eBFb/I5
 IX73UJwCxbVR16adeEKCbgMiSgIp5NM+poMLz/gYFC83V+8mDG46G6oW+DWNAJzLhAvT
 W0fgXNgCP2NWiEtEjn/6JD9/vD1mHqr/otDU5eyKvI+j2juTZSiS4ItHjXrJSkbKqbYJ
 bOEGgpVb+TeQLTGORS0hiBLoa5ZQYycX2U+AVPPngeN2kDQt0IK2ib/h7fYC+5A4L9u9
 +vxQ==
X-Gm-Message-State: AOJu0Yz4dNkmmWmeFkU/f30bISYTCfe0NfGD/m6Yn0/yglBUNHkVWwvd
 LhWF6C4AK5HYpB7HHXwe/LIMZy8HfGAt0+4jWtZ/hw6WAcDU0qNKB8HbNGFE0V4=
X-Google-Smtp-Source: AGHT+IFa48Cz+gmVleoTPkMnhutlTxVHuN9HPPpERa5+T8e5HfULn1vcLkEeNfXBKCfwg/5N1uOglg==
X-Received: by 2002:a17:906:fa0e:b0:a72:8d2f:859c with SMTP id
 a640c23a62f3a-a77ba48deb1mr321164466b.33.1720193836475; 
 Fri, 05 Jul 2024 08:37:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a754758168asm302976066b.80.2024.07.05.08.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 311C96213D;
 Fri,  5 Jul 2024 16:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 23/40] plugins/lockstep: preserve sock_path
Date: Fri,  5 Jul 2024 16:30:35 +0100
Message-Id: <20240705153052.1219696-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

We can't assign sock_path directly from the autofree'd GStrv, take a
copy.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-24-alex.bennee@linaro.org>

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 237543b43a..67a779ee9d 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -347,7 +347,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 return -1;
             }
         } else if (g_strcmp0(tokens[0], "sockpath") == 0) {
-            sock_path = tokens[1];
+            sock_path = g_strdup(tokens[1]);
         } else {
             fprintf(stderr, "option parsing failed: %s\n", p);
             return -1;
-- 
2.39.2


