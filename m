Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C0CC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJX5-0001Lg-Vo; Tue, 06 May 2025 10:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVD-0001dh-PN
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:36 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVB-00027e-CA
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:35 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c14016868so6745553f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542551; x=1747147351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+FSjo3zQJ43AkDQz9GvWQJa1a1nTj6bZg/diWjzRsDs=;
 b=Ai2M75JAQPmQ1Rw315vxHsu3dTGYWemx9jC2nlSDYVoX026sXq+e2qMn48/KuKMCpH
 kOLr09IqLx5Ws8dIBazcVNFuYrXu9y0Z5eEtrupXPwAhJhpHM71iSAKMxsYz36zRn9Yi
 pboPA8FEb65jiVrCZxefRbQSlgzdRYZyyZG46hC+DW9+/ItDPqI5wq9+jQvzOgZnESXB
 NpwJhDapylKaBqr1OoZ45JbuOmJxg/8F/IgLOLceoJ1ha9u50DwoG3Jg9cda8EH7tlr0
 I4NReCkmj7hGZBAC1QCGEpQk9DW0z6OQB6HwkiRQ/1vcLZqZjD/D5SrlqZAVJL2yZbNW
 9KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542551; x=1747147351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FSjo3zQJ43AkDQz9GvWQJa1a1nTj6bZg/diWjzRsDs=;
 b=TTCkOx2yQ5zJXxHOkf00wzSSasxZwrXE1ObjSxUQfKnWGYPDkQY6tzGjmrK6V1olEL
 jDgZoPelpFqvgOSu83zPQVsID8Od8a9unfY8xlg4SrnVB2M5jrtK8ad7XA/GGvPgcEwI
 B/b+3MhJ6b0d0p9qd0aBrwtWYbYAETssyBtVa9qbzxWMT+Uf9SscezgHwfW3AC4j2k7r
 lpBtF0cJtAEBuaA6224IGQ+WrE6lIzIQ+d4O0yyjo7jpF4FL+CAsx36VJkkoz+EIsfgM
 En1YgjUtj0EEcHdfGn0H+udUPqNr0EiGuSQkHXDJ7qU0qtlZ0JKrTfeRsfeDDvGYoDZ5
 0z7Q==
X-Gm-Message-State: AOJu0Yz6RBTnBarxkwtsGUULyumAmYFKob87TS39UgkCWb4r/+SDYqne
 SesABg56B6o+u1p4UH9XhtnKOrOEJOPmjYKp+K2rSE1NoNapYmFVdjo+z1gTmELgLacUviIyOac
 b
X-Gm-Gg: ASbGncuN053OPVV28/8tfAwsJzISbVBrPFN7txY95omuvGET3YfXuuqHqpMrLa4cz+B
 4fgI3lr2dVw40eGO4ynqFp9p987cVRp2AuPll3FiNwrgK842sPuAZ/q9Xkmr22KUh3fG52QWo2j
 j2SR48wj4lPHO1b9zW6ZbTzoYjV4riN5F/uInfmDSlo7aZzOaPGKRtUiUF6H/D2uGDmwtoLWaRe
 Gp+UaOVz1g/p1IqUQcG3QOdrGa+CZbp9zRqDJGaEQKmBuWU1Ja7s1LJx9bz2q9cGTqH5jZHScsS
 wtAVg6dphTi5ssKMQZU/MoATk3AaiQ4Mm61051+z3nO0INU=
X-Google-Smtp-Source: AGHT+IHpL9vc/91wbyNI4qHUuWmGEzBqPKnXmdkGc05wJfMd5AQNf9mZgI22lcxXBrAo2Sk7riKUKQ==
X-Received: by 2002:a05:6000:2507:b0:39c:12ce:6a0 with SMTP id
 ffacd0b85a97d-3a09fd76353mr9587238f8f.21.1746542551578; 
 Tue, 06 May 2025 07:42:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/32] hw/arm/virt: Remove deprecated virt-2.8 machine
Date: Tue,  6 May 2025 15:41:55 +0100
Message-ID: <20250506144214.1221450-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9c4efcd8556..4ef3f043a21 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3632,16 +3632,3 @@ static void virt_machine_2_9_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
 }
 DEFINE_VIRT_MACHINE(2, 9)
-
-static void virt_machine_2_8_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_2_9_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len);
-    /* For 2.8 and earlier we falsely claimed in the DT that
-     * our timers were edge-triggered, not level-triggered.
-     */
-    vmc->claim_edge_triggered_timers = true;
-}
-DEFINE_VIRT_MACHINE(2, 8)
-- 
2.43.0


