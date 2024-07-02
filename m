Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E7FC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVfL-0001Sw-MK; Tue, 02 Jul 2024 01:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfE-00019a-24
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:48 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfB-0007Fh-HR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-365663f51adso2267665f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896563; x=1720501363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXbwBlxU331VYAjhHl0SMCsb+VRuyHw+K3ZyG49lmEk=;
 b=DJRdSkedUzVs+NlupvIA2E0EEAdXTmNh63d0IChjIFh1Ev1GNCQym4zT8XEP6phyJl
 XsYFnyJqSyttJ5oQILVWIKlnE51TFR7L3n4h93XWD7LeJKHn3NhLiJGgWgWY4T3MiRi0
 WAWBjgcW82qpdAWAUvEI3dTbgJOVNLtxpnb1o0g1hiii+aLSM8FjRzeFtDmY0w9LI7KM
 2wL7Ktahe1IpWm8mK3ZPVN033Zk065/S0PUaMBcTCIclYm4ap+eGqRC4HjrIyrwiU7u7
 LaCPk4kfC2CdI7Rl572yjyUcS0U2K1ah9ZpDQwzk+crxKmdo1B0K+EQvheXoViUK7aeG
 DQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896563; x=1720501363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXbwBlxU331VYAjhHl0SMCsb+VRuyHw+K3ZyG49lmEk=;
 b=jaa3tYsFVFu29nt0NNb97nqsXmb/I25QY5nCquzRybOI2/nj27pLDlZt+rXwg3QSAp
 4dq8ofAwecAFqv9mdoHqXyjZ8dK5xqHDpf5TLBrtAAhI0MFnwxNEodvQOJ6gLMdYFuHB
 T5SkPqWEpA/6Kh5gn/SJkQE/o0nyUaJ3J6CooQ21j8HlaOa1rPvWaL3p7McnJUtb1SRl
 Uf/b7Fl+1YzVY38In0UN3Y2L5rSTDrRas5o1acAgOcR+c9lORJlXnseN3cBZ0o90/xm0
 Us8ktU38qKc3hZLmmV78CTc+ckdH6UdfFU2rlajMZfhLe1xeSJGtwi1aRgt3DmhHePHE
 ib2A==
X-Gm-Message-State: AOJu0YzCz4miHpJo2q0yaC37DfCwYL+l4ggH7XtA//IvJ5g5lX35Yb3D
 Z68ijpGO80nRG/P1H/XqG9PYo40HEdArTx10fewsuqKxdb3lzby0suGSOpHY8lQMBbWyuyq8Nuh
 M
X-Google-Smtp-Source: AGHT+IFVujcSisPo8JytqnbS/Bt4UbwjzCyHVB4GqXU3Z3T7peLMM4Ijc2ZNravMiXJwy/bvaQYsmQ==
X-Received: by 2002:adf:e98d:0:b0:35f:276c:ac5f with SMTP id
 ffacd0b85a97d-367756bb740mr5016036f8f.40.1719896563060; 
 Mon, 01 Jul 2024 22:02:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367892a4817sm400158f8f.10.2024.07.01.22.02.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:02:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/22] hw/i386: remove obsolete manual deprecation reason
 string of i440fx machines
Date: Tue,  2 Jul 2024 07:01:04 +0200
Message-ID: <20240702050112.35907-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The automatic deprecation mechanism introduced in the preceeding patches
will mark every i440fx machine upto and including 2.12 as deprecated. As
such we can revert the manually added deprecation introduced in:

  commit 792b4fdd4eb8197bd6eb9e80a1dfaf0cb3b54aeb
  Author: Philippe Mathieu-Daudé <philmd@linaro.org>
  Date:   Wed Feb 28 10:34:35 2024 +0100

    hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240620165742.1711389-14-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5705d6e155..9445b07b4f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -688,7 +688,6 @@ DEFINE_I440FX_MACHINE(3, 0);
 static void pc_i440fx_machine_2_12_options(MachineClass *m)
 {
     pc_i440fx_machine_3_0_options(m);
-    m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
     compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
 }
-- 
2.41.0


