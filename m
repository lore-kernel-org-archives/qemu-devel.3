Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA209D7879A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAWJ-0005Kx-2w; Thu, 21 Nov 2024 11:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVf-0004ev-AQ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:28 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVS-00080z-Qc
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:27 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-432d9bb168cso13391685e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208293; x=1732813093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGcTlsR7h0uL9l7JMzB9rSwqOcrfMiHg81PqrjL5LmY=;
 b=xX42+2L8GenXbFOnmeMFRQ6m20v6+DmGPoVE3IClm0GsABI2rvgBi28mUIAeAgfI6K
 pMgBbSL3suh8MaCLO3aD9VayEInpGIFfglWXLwpg5nUiafamuVsll6/gz0UgfEJbV+ka
 Os5rkom0lnkfVyyvHAvdFhqrwpLX/VDhElBrJ40fiyr5agxQFBinfx5ZIpe1UHlwZmzl
 JSLhT3kJ7DFNCxB5/tHEmvhyoX2Jcm7wGCeIXItRL9Fj1IfZ21XLEZtWtRC5WSRlwa6k
 8OSPAtDscwcaZsdMphCQhqNmIyhJAgsstfQqPPw+rDEYWBYBD/y4Nv4psGCtxRyIIjmw
 8Fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208293; x=1732813093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGcTlsR7h0uL9l7JMzB9rSwqOcrfMiHg81PqrjL5LmY=;
 b=Nde2srTLYmI885csj6IUJGxEPvkNXLqMYFNcZe6Etu391JNCr619hqHlDNN9UGY85g
 uN/rR7mOPeYKMzEGtJQW8j7Tkr36bOM/8bgMUHe2WjKy6OX6PrmlhSYKA0wKs8CseDqQ
 hFIp749iSp/aYlhdXsPgqxn4XDQuDS6K0406P0gU/NE4TzoSmsPkrKGGMHtUBnYeTBNT
 txoXDRhklnyoWRgLfff2bfM16flzKgF4BaxXjJqKdcxfFASbedrOQR6EmCiEXr2pof6n
 UqWWXSkytGLf3oGnOCmH+Wnk4Nagft3O32vdIdrSck11J24dpucGzXW0XU0flE6pbhyO
 lasA==
X-Gm-Message-State: AOJu0YyQqKQO1ywTL4SfZEr8V77+9zLqJf0pLb4KjqsDAj9G9g25hCjO
 JWPTpNjkkjraK8NmJKzqcySXl/2Mz7jK8WLVyyMMndBF1cITVZYvFkHnLBObnnM=
X-Gm-Gg: ASbGncv2I403x2PduqTcj577j3X45o5DSQdoC2YbPDHlUYBPXQfT3xaGxxYOfzXZFSG
 F9HLOpegM38b8r7xisHU3jTDMULBjyWDdfLbfy+V22szpabIm7su6sU7hBYApY1GR8QeOh8au3t
 HsB6wBUns32SKsIDCqpiZdHPyL64mqNnVHKycYZmf5Se8v81w6iKSkONGoO29cO3Wf9vY1jrCHr
 5QMFYn/QDTXrNOpmNKn+0zjfjq0D5+ndT9Y/BufejCVAuZK
X-Google-Smtp-Source: AGHT+IGivVSM4iXmyGe9ts9qo7V/VNyalRyaK/3K4hnRsaWTip+g0uC3+13I9Lc1O5RmotPl3tN/mw==
X-Received: by 2002:a05:6000:184f:b0:382:3210:a965 with SMTP id
 ffacd0b85a97d-38259d4f8dcmr3665940f8f.24.1732208292676; 
 Thu, 21 Nov 2024 08:58:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedebfsm14660f8f.100.2024.11.21.08.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:58:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6426B5FCD7;
 Thu, 21 Nov 2024 16:58:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 10/39] tests/functional: honour requested test VM name in
 QEMUMachine
Date: Thu, 21 Nov 2024 16:57:37 +0000
Message-Id: <20241121165806.476008-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
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

From: Daniel P. Berrangé <berrange@redhat.com>

The functional test case class is going to the trouble of passing
around a machine name, but then fails to give this QEMUMachine. As
a result, QEMUMachine will create a completely random name. Since
log file names match the machine name, this results in log files
accumulating over time.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-11-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/qemu_test/testcase.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index ca13af244b..f9c9de1166 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -164,6 +164,7 @@ def require_device(self, devicename):
 
     def _new_vm(self, name, *args):
         vm = QEMUMachine(self.qemu_bin,
+                         name=name,
                          base_temp_dir=self.workdir,
                          log_dir=self.logdir)
         self.log.debug('QEMUMachine "%s" created', name)
-- 
2.39.5


