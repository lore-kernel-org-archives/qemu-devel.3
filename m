Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B59C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJMq-00038Z-Ml; Mon, 13 Jul 2026 12:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLx-00028m-Bc
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLt-000050-BC
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493f25d47dcso763745e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783959471; x=1784564271; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l/eQjitMw18Qe9Ui0KlI29FJvX4xdr6hqn3sd1tnSrQ=;
 b=tMLMDDEEm08SbngcfocuOSqVHko1O1ek3DVL6Dp+IFx6RuM/UnsB6E+XdPsJvW6wuY
 +zZP69Edo9LA0sqT35CBo//jIapH+ZRRENvM4HvMKdsatADBOjrObuUSWnP8piNqeLSI
 7RoHs91d7uAF7HjDD+XZFzjR7S+d8oQoQAnZ86TKZyIuALwYuSivvEfYwEVfM+/4Lwl4
 eOsvxtSQpX00Gv/5E0b0zuQ8Pit4o7XCdFAkQT932GK2aknEC9teiUBrvM2gHD2+phAj
 kwDkxkzvTq3U4SEuZQpl2K2MzUuJ6BJKZXtquD13/jyiy6Vvw6V4/gKKOnUktshPzbPc
 RNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783959471; x=1784564271;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l/eQjitMw18Qe9Ui0KlI29FJvX4xdr6hqn3sd1tnSrQ=;
 b=WNPilTUPkePJu4/PACaO3qU6ogsVLLZ7IUdu3elMpgnbfRnGx3IPc0nfY2C1JvnLGp
 3kA5mfVFsQMom597k5r6bkV886ZUYKS8D97KDmu3D7ds/AX9T9GkkZiIwV5j6bTNVIgT
 BDgEG6n8VU69RTEePZ6V9kO/tcgWcfl2SG1dFy4BgizleixxUzjYNF4EBhqJf0AGictc
 No/3z+9OqmiltGEzutQAJsxlMIYqfEVuPugXxF4n8/1Sz0NdbKOlSqD8IHA91NKWPM+A
 34nybSKZXCntS8WhfX8J8OEjewtAaJT8z7ewBZqGdzeaX4XSQWsQ6e9J7qWSgkoFnZDR
 ximw==
X-Gm-Message-State: AOJu0Yy1vYOZG9NgYQJmuxJhm02Go5u8TubP2VRp8HYFe1tzr8AgeK7M
 cPpEzeyqYEDBqmQDc8+V4wc1HAOYHAN13Tumdl/V0/HCG9oJR5e5PNmwNRge9nzVxWw=
X-Gm-Gg: AfdE7cmMMymtM+2q9Y/ltGxqiFuyvvN7M15RKKxf2AsB6vUwMrPURtx8LN9efLtK0c+
 pMQF59SXBueoVbsGoIccOPE6tYM6pkTascfs5+zCEcbb9j45xF+ikZGQ+iMQcVcnIVaB/IboLJj
 y9ytFnZHPu0fq1WLRzvaitwF+JGzp9CpxVhnm4/PXv2HzluB+YlnNbereTuLAx+74wfGG9Zj34e
 8Bu/oCwDGZAswy+oTiNoYF8Ab57RZvsIGiUgmhv6/MrTZRnvyGDEXxGrZaEVKCysxp4zoF7Rbr1
 C1Qb5wAghESqnxgDNOhG0LQQ+XbQ/N+xB9dNpG5O0p13RO7cBja8rYFzqDzXsVFU2X13PoxXPDi
 YSn/UI74CDibJbxrWMnE6W67p01zwHd1S3KV1rajeIH3UfflXlPTqOwfH7uuZGgK15koFr9nUTQ
 zSQZJn4ZxKe4Ao
X-Received: by 2002:a05:600c:5489:b0:493:e97c:216e with SMTP id
 5b1f17b1804b1-493f8851d4emr100309805e9.39.1783959471393; 
 Mon, 13 Jul 2026 09:17:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950872424asm7786575e9.1.2026.07.13.09.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:17:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 13CB15F954;
 Mon, 13 Jul 2026 17:17:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 6/7] contrib/gitdm: Update Qualcomm entries
Date: Mon, 13 Jul 2026 17:17:44 +0100
Message-ID: <20260713161745.53889-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713161745.53889-1-alex.bennee@linaro.org>
References: <20260713161745.53889-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Add an entry for Qualcomm Technologies, Inc.,
include previous quicinc.com contributions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260707153003.58914-1-philmd@oss.qualcomm.com>
Message-ID: <20260709080040.4157324-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index c07dffc51bd..aef20c4949c 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -40,7 +40,8 @@ nuviainc.com    NUVIA
 nvidia.com      NVIDIA
 oracle.com      Oracle
 proxmox.com     Proxmox
-quicinc.com     Qualcomm Innovation Center
+oss.qualcomm.com Qualcomm Technologies, Inc.
+quicinc.com     Qualcomm Technologies, Inc.
 redhat.com      Red Hat
 rev.ng          rev.ng Labs
 rivosinc.com    Rivos Inc
-- 
2.47.3


