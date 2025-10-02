Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969A8CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 02:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48hI-0006on-LS; Wed, 01 Oct 2025 22:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48h9-0006nq-Bv
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:26 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48gu-0004hb-F5
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:22 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-27d69771e3eso2834515ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 19:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759370699; x=1759975499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOPeXicLAafrLttDNmWtdjRbKocV0eal4eWIHoa6qlM=;
 b=fJlZrnVc64xZjagllZHNBa0Y1+kO6Cn7HewtL+XO3bwUtrGEkD1y8r/YQo8GgRquOe
 85gfOvwJv6YySJUZ7LxUzMDu6UZ3GnicPiGB8D7SGLnsWFHMHScSWs+TXxffiI3+CRFJ
 8Xxm3cUazENJM1V6kx0oudjT1nwottgdQgW7OgSfvNHOp0xT/EAvFZnCNaIN8kRWn8dG
 IcSrOXnFJEV4Z7NJon3O5u/DS2S966+AO699Kx7foIRd3zjz3zriVCtwvUgtL6zXzUQs
 w6WvLKK6uTFeCke7EFlyuI1QmaIQLXuKghPqcINO4sdToKyfiSjx8gu9CLFOAfCIUr0Z
 Dd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759370699; x=1759975499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VOPeXicLAafrLttDNmWtdjRbKocV0eal4eWIHoa6qlM=;
 b=VZ/2u3zustmBZH7EovLyKpl8pAtvzPxR6nCqVNNGFrHkfublOgPQ7r3qBfW+fyUqdA
 iD4wiVfMC9ClEjEa+MF3H54Ht8DgxGnSlSPr+l2yoPanVb9EdJVFF/coIeje3XTp3JUY
 wUFbkEuw1GvBeJK/Q+AhtPUAX/Z1lMJJ2LTdBX1R04AGjnvvWqDgc0YnkMxA1KrQGx1M
 WKvCz6OKjTS26X9ntZoXtiJzCPJPgTmb1LIjPSjMQUjyw6BH0A8OdofvJhXfM3ZYuuoE
 6NR6kdkOk77D9Uon7g9swxjWhLaYBNv6Ze08LdxKOYzbYXdeQdAd2PVcYMaXAKPru4YS
 KeKA==
X-Gm-Message-State: AOJu0YyrtGghZ1NN+D0m68b9CTJhbolCIh5ILPkm5f1QRl6Oq2ig7NrG
 tOPGU6qXeB1e4CDm5bQIhBlaegsww17ITcAXig+RDR3CoAWVpu+8KfNWH2Z1cZ9kiCU5zo2+D41
 TSVbq
X-Gm-Gg: ASbGncskyIyZ9h/gaVp+3bW9kRvR6/+7dE2HNsiWmlLBQh4IrTjN+LGUIAb10PX0AVL
 g6YY2F/i06jbYUw/U4kmwE2rmfqete2RubbOeBmQbF5Q/q8pf3VOXWpu15l1eOAH2Cu4xDQI8qX
 TeZ208ngahSR/fOPiI1IWE8ZUSMz4PN6a1on8FSiENtiiOITAHtxHkYKaqkrLSAKN9r/EftK2Aw
 9KP9Fj8KkMoQIUrCj6ECWYC80J5fbrVZNqkeEaea02YFWnx7xyH2Y+SMi+4WYOEN6YnP3p51W5M
 oZ9ESvi1x0C0eB13XuGEOd6GNIEc2dxYiAqrL64+M73dn36gvBZSoFyphHHEnuzJHzwKX2K0NoF
 yp97f37LQ/L35/GgbCzdZuszRrCCoyAktgGLIXp0Wyk9DSNIFj0e1N5Sp
X-Google-Smtp-Source: AGHT+IEjdPsBhCaiASj+rlbTXJD682sqXdWjz5+iN+jcmd5NMS6PXOaw6l0sQrgslKzEfiSF9wWgig==
X-Received: by 2002:a17:903:1585:b0:269:9a8f:a4ab with SMTP id
 d9443c01a7336-28e7f442cb7mr62869465ad.60.1759370698706; 
 Wed, 01 Oct 2025 19:04:58 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d95bdsm9476735ad.119.2025.10.01.19.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 19:04:58 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 2/9] python: Install pygdbmi in meson's venv
Date: Thu,  2 Oct 2025 02:04:25 +0000
Message-Id: <20251002020432.54443-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002020432.54443-1-gustavo.romero@linaro.org>
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
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

The upcoming changes in the reverse_debugging functional test to remove
Avocado as a dependency will require pygdbmi for interacting with GDB,
so install it in meson's venv (located in the build dir's pyvenv/).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 pythondeps.toml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pythondeps.toml b/pythondeps.toml
index 16fb2a989c..98e99e7900 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -33,3 +33,4 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 
 [testdeps]
 qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
+pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
-- 
2.34.1


