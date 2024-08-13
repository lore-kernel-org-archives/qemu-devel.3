Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76B7C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy3g-00054X-61; Tue, 13 Aug 2024 16:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3Y-0004m4-Ns
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3M-0006BB-MN
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-428ec6c190eso45335595e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580615; x=1724185415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KDdZuSuiVhnWoZHnKqWrh7zo/0jiKBE4EcFSl+sGnw=;
 b=uz+LQiadjM+BmePIRXmF7F+6pDYcAAsc30SxzpmA7qNHYS6KfUN0wO3tPMhlg2ZtBO
 3lLjzB3UTlAnNqdx7OPBJaK3b5kmAvIWsUWp3ebExDOK75R0mlZthjLNj5aOkXdFp5cu
 22/YOb8rwZsh4WTITDU53smKE47TzwZ60Je2/E9o8+KPib3lkf230/47gw5O9hIl0MXH
 q5/yGiqYNyhAjGKgiANErKn98y8CNEq8Z71Qp3rzgg5jxCGf7A1bWmHC/888PDZ7iYeK
 Y/1Sy7wZAvb2CPof6/GJIWWNMlysmzACfw7ZALGSOvP2adL7w+efkBBpIbBJshAVEz1t
 Yoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580615; x=1724185415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4KDdZuSuiVhnWoZHnKqWrh7zo/0jiKBE4EcFSl+sGnw=;
 b=ZLMeQTfzx5nBYwhSIbU2WzMhnSFdcO+SvxnN3ZctAXwCGcZeECuR2BBvH+3AOnjmdV
 f6tBMr09dpV9YNy3Aozm19GcJrqg82KScC7RjXskuFW4dPPNAb/+TJkGkSnNPNj8ouOp
 XYQuAcw/ZcrjccLJcHIJLOj9+yo2+azt85gikfhe71xabDA+12V70awauzM4I010mgAI
 Xz4owfF1JLgVd53XIShehJ+y670CXcNsobkNFCNAQh+LmTRPLxl0/BZBA1GGVusCrEf8
 zpoj9aY3HErF9LWYAR1s0rFNCYlLf7B8aQOasz2UjOY3p7K/3Exfes7k2qYS7F8MSMih
 afcQ==
X-Gm-Message-State: AOJu0YyrRMVAWghpX/32ElaG+G5lO1NyFbCbbVoak+TtMhRFnVh4MJOz
 5hIk1SF22BCheGjdeExjk1l4q2P1xIpmUL5MX7/dwGpQa5Btv2HLbsnZY5Evu2k=
X-Google-Smtp-Source: AGHT+IGG4BwgTjQUccNi8P3sQj9A6II4AYnB4PGbLoGYZE4fKFdWnkZpoRV3PqMexpKds/kZ78uLjw==
X-Received: by 2002:a05:600c:511e:b0:426:61ef:ec36 with SMTP id
 5b1f17b1804b1-429dd1e551amr4907685e9.0.1723580614570; 
 Tue, 13 Aug 2024 13:23:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429deb810f5sm667535e9.44.2024.08.13.13.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A52215F92C;
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v2 03/21] configure: Fix arch detection for GDB_HAS_MTE
Date: Tue, 13 Aug 2024 21:23:11 +0100
Message-Id: <20240813202329.1237572-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

GDB_HAS_MTE must only be set if GDB supports the aarch64 arch, so the
test if "aarch64" string is present must be against GDB-related
'$gdb_arches' variable and not against '$arch' variable.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240804161850.2646299-2-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240807114059.2339021-4-alex.bennee@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 019fcbd0ef..a3aa257fd3 100755
--- a/configure
+++ b/configure
@@ -1673,7 +1673,7 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
-      if test "${arch}" = "aarch64" && version_ge ${gdb_version##* } 15.0; then
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge ${gdb_version##* } 15.0; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
-- 
2.39.2


