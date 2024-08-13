Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04112C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy3h-0005Bn-K3; Tue, 13 Aug 2024 16:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3d-00051h-9U
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:54 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3N-0006BO-EE
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:53 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52fc4388a64so8199453e87.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580615; x=1724185415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKD7jTj6Nf0+e/1hZyzKkWpKuU283fm5mnyf6o/tDJg=;
 b=FIjgdpfIez5HdkW9Kg+ECabF4IWJ56stoQlCOLD7Gbch8BAjb8pwGw/W2shi0FvOw5
 j4kJW1EgUAR91p43/z83OmQncjeWdodnvGAEXPPM9j1gbnGGp4dgEqlwlHatkoyrY0yC
 mP0RQ7VsE3pFHXcdd8gs3iaFclLPJvqeZ0mds2Xq+jXx/nHUkOj1PFZugIH5e6l+ECy7
 dCa3eF70iduVf0IYeUuey4bBIYvRxe6K0MBoQDJV+1+pJzTVnvcdI9xM/2gcNlzEvqez
 Skt63o5zYw/r+iwJdqqrXu7wRKGl95UY3cqTa/7kibYfxAT79whJe4a+QNrZyvqkSKbI
 hXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580615; x=1724185415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKD7jTj6Nf0+e/1hZyzKkWpKuU283fm5mnyf6o/tDJg=;
 b=dnZBzhyVHs5WBwlJCyLAmLI99oEVwewBxVHYlUMCoqLhbH2do+9Ko0u0AarL8r3RKU
 vhLWleSBH6ZcHzF8W7aeIs6ohed5jaSazLa62eFn/SeMTEiJZOGTDEQrd2iVCyuBQWou
 dSGcoW+bJcx+IH+gfUsPZjI5shRYeF7ej5CrMoTlL39jMnt/OqxUXAlew/wNgZRV0KJE
 aOvgKO8bvsD+KkBmx25EXxIRth6lFnZG8pWNK2U7TItg4fuWfSvQ5cJ4kCWOkHEsoJ5+
 Fvzk6KrRT+7EEo1nIaj0QyMSrFH2RrvFtseUESj2ssXoZsXc/HvFyIq9MwZVtTA0acgF
 iNtg==
X-Gm-Message-State: AOJu0Yykiuz/LgilbPxMHnBvQLXeGdSXu6YcgTkCvMyHxbMEurf6LHWv
 0T+gjPpvxU9OOZkA3G1EaJnviYbUCvjbK6HXwY3zGvcRANSI6gWjCYSGuHi8MZI=
X-Google-Smtp-Source: AGHT+IFYzyLoE270W+WofOCfgUcyOUdrs+aYXrTSO0xXscbAltL5AOxMO0ddGDb3dLKASsg0cgJSog==
X-Received: by 2002:a05:6512:39cc:b0:52e:ff2a:217 with SMTP id
 2adb3069b0e04-532edbbee55mr307421e87.50.1723580614179; 
 Tue, 13 Aug 2024 13:23:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c9385d3sm11271592f8f.42.2024.08.13.13.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8CE945F8C5;
 Tue, 13 Aug 2024 21:23:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 02/21] Makefile: trigger re-configure on updated pythondeps
Date: Tue, 13 Aug 2024 21:23:10 +0100
Message-Id: <20240813202329.1237572-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

If we add additional deps for meson we need to ensure we trigger a
reconfigure to make sure everything is set up.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240731140232.22193-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240807114059.2339021-3-alex.bennee@linaro.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 02a257584b..917c9a34d1 100644
--- a/Makefile
+++ b/Makefile
@@ -78,7 +78,8 @@ x := $(shell rm -rf meson-private meson-info meson-logs)
 endif
 
 # 1. ensure config-host.mak is up-to-date
-config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh $(SRC_PATH)/VERSION
+config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh \
+		$(SRC_PATH)/pythondeps.toml $(SRC_PATH)/VERSION
 	@echo config-host.mak is out-of-date, running configure
 	@if test -f meson-private/coredata.dat; then \
 	  ./config.status --skip-meson; \
-- 
2.39.2


