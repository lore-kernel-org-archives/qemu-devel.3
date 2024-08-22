Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2602DC5320E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 09:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh4TV-0007Zj-7H; Thu, 22 Aug 2024 05:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh4TH-0007Vt-CW
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 05:51:11 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh4TE-0001zY-Sf
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 05:51:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428119da952so4245425e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724320267; x=1724925067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Y695RxzqZMUrq71VyB6/VGmqxSsE/5rqhX6uBUfH0k=;
 b=UjCuO5OqlRk6YUeKRZ6KgZAu11zSKY7quLIKiLf4rPToNvNBMOkup3SoJ+QmR9NUOI
 ZAYA8NvYqGn2d6P2L+cuMzhU0wTs4EV+3RG1TFbFBmA5Jfto8+zMo70OqbzncOWOL0Xd
 HH+eUWHWdpDw42uRxGXM8VLbNZMwlG1ksq9dbBiCjKmIfC5xwFnhsskesTmZck42Cgmn
 2YIN6d41xIcvm4U/3otXDXuXiYYbmWGjYbnnWfoFF4C7jaGkQfxFqAyoP3q0wuoLepWR
 QMfAzExxOefZlC/oUOYNsJX6YatoRufULJYULmzsrJmj0dEXg/UHAR+/vKbTYn99IOAk
 Lvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724320267; x=1724925067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Y695RxzqZMUrq71VyB6/VGmqxSsE/5rqhX6uBUfH0k=;
 b=IsAnJBwciGfvMeypBmVVK3c0Qn5i6QnD+YBAu4YplI1S4eFUbZe5hG2JR2vdZ1V5oy
 zk6Lh+Ois9EOQ6fH6ITHz/5Z7hA6WNVmhHhACsymkd2aooucdW6FfVAlvMKvS4ihr65K
 aYj2NtfPk8RfiMJiYn6/6tpmWSUrsOEOrXUQWYZPtDyUq3b1nhcXu/iwR4XRLhksZpit
 HYWbJ+CaVg81MDJW/9BOwMbR5ehvunkIQErGhKKKxHN+yhMNDv+uxN9idWk9s6g7vCHM
 EmJEAQZ5BUHzJyTLdHv5uM2mjET71I5/Fz9d3tkr5W001hrj0QJGaQWGwt21vu9JCVAV
 u/LA==
X-Gm-Message-State: AOJu0YxvnhCfh24d1Wtil6xyq//Mrlui3EUGWvqY6gnFP/xhdmX+ygb1
 P3cQbjW55+RPRUtkUILxson3MZDwVgcQW82fdkjZeh3rXP6bJCzBUWlLCcxh+Jk7B24EobGoIdB
 C
X-Google-Smtp-Source: AGHT+IG67ATmzsQrkaCNRJ5gb1BJ7J5T+3zS6KBrv8I0DTin7d/POJGU5degOlaTtnyWIszA8lFgwA==
X-Received: by 2002:adf:f6c3:0:b0:368:5858:826e with SMTP id
 ffacd0b85a97d-372fd72c65dmr3222880f8f.59.1724320266636; 
 Thu, 22 Aug 2024 02:51:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308110035sm1251615f8f.16.2024.08.22.02.51.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Aug 2024 02:51:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 3/4] tests/avocado: Allow running user-mode tests
Date: Thu, 22 Aug 2024 11:50:44 +0200
Message-ID: <20240822095045.72643-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822095045.72643-1-philmd@linaro.org>
References: <20240822095045.72643-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit 816d4201ea ("tests/avocado: Move LinuxTest related
code into a separate file") removed the Avocado 'process'
import which is used by the QemuUserTest class, restore it.

Fixes: 816d4201ea ("tests/avocado: Move LinuxTest ...")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/avocado_qemu/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index ef935614cf..0d57addfea 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -17,7 +17,7 @@
 import uuid
 
 import avocado
-from avocado.utils import ssh
+from avocado.utils import process, ssh
 from avocado.utils.path import find_command
 
 from qemu.machine import QEMUMachine
-- 
2.45.2


