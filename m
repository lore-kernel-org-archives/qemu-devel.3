Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00D9C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwrw-0007p7-OL; Thu, 25 Apr 2024 07:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwrv-0007od-F5
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwrs-0008Ai-Jk
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34c1fff534fso204561f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714042938; x=1714647738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiSgNxRXT9EJcnQ8aO7qTnStvPwh3mzz93fTZzoT/NU=;
 b=VOrNwkjEc18XDYZn+sCdPXF09AvzrAv6uTFbdrdv2L5DxNnyWPIyaLdVGDhpfwYsi1
 kYBOgtZo2EATtxrtPUkJk7axCF1UcOwP+sPAOi9quSXHTl/8pP0rDcaotA1ebdLE8YLn
 794fwgrGxGE0fGgraq79JHMEHJrmi6qSjh2a0ATvlUqnKDMOj16WF+qPUnEMxnjfk+6O
 Rm1Kg7UmsqEMNJI1glB2I04m1v8ab5iZVGB7p539WX/rrkpXA0eG0qzTuZ8oZFHPfUHN
 watrBGVN9V0GnLIajZHkP4DwY05b6OxQvC5xqaUW9ZPaNPJ5Qjs68BxwfXyPCpYMyxyW
 CGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714042938; x=1714647738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiSgNxRXT9EJcnQ8aO7qTnStvPwh3mzz93fTZzoT/NU=;
 b=T+dLKBBBg57vOE121PBtb/o8j/mXbN8mCL9WIqWqsOwOPrtLdviadIyaVTolw7xSho
 au1Xbyv+bmnMtC7yTR+9p2/1L4ckDlB7JhPaAWQHGYrMz6hsdeHV7xaI0EWqn6A0QzNE
 LIioyvJ/AGZR5Cx6NfKTlkqxc8n4ydPsnfV5WERE8iF72FS4FjUJmlDuP3kGgwJYTvsE
 t5uqZDZL0qEUXw0GXrtMkjsDCeoVDwykciTzEDQcTepCrjicuiygR0X/0AcBeBF96Eui
 /RgumpeF4e/2FU4my8okpdg6PMH2Pnwn3bqXOy3CRbreU7z3Q4dSbvzd8s/jor/GC98J
 9YUg==
X-Gm-Message-State: AOJu0Yw1PGSn5JAv/Mbpb4hfRvMsv2F6WNaUvW16E+XJ/UApLBpRPBZ2
 TlbFEMDfRBc9e0J1YKhp+SxgKJWMl1Ec91F9lVlZoyqcr4fYwlEba0cAdEvfZkV9gf2gd9J+YxB
 R
X-Google-Smtp-Source: AGHT+IGhQJMdjUzfkRipN6K78u1AWPOja9RuLHySGruzAQvqzc+/THb5+/v0sO6OeHnLbaa6kJroSQ==
X-Received: by 2002:adf:f34d:0:b0:34c:233e:f40c with SMTP id
 e13-20020adff34d000000b0034c233ef40cmr522061wrp.7.1714042938701; 
 Thu, 25 Apr 2024 04:02:18 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a5d6383000000b00341b451a31asm19488279wru.36.2024.04.25.04.02.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:02:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Maksim Davydov <davydov-max@yandex-team.ru>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PULL 03/22] python/qemu/machine: add method to retrieve
 QEMUMachine::binary field
Date: Thu, 25 Apr 2024 13:01:36 +0200
Message-ID: <20240425110157.20328-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Maksim Davydov <davydov-max@yandex-team.ru>

Add a supportive property to access the path to the QEMU binary

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240318213550.155573-4-davydov-max@yandex-team.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 python/qemu/machine/machine.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 31cb9d617d..f648f6af45 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -328,6 +328,11 @@ def args(self) -> List[str]:
         """Returns the list of arguments given to the QEMU binary."""
         return self._args
 
+    @property
+    def binary(self) -> str:
+        """Returns path to the QEMU binary"""
+        return self._binary
+
     def _pre_launch(self) -> None:
         if self._qmp_set:
             if self._monitor_address is None:
-- 
2.41.0


