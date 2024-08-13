Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE57CC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy3V-0004WJ-Ej; Tue, 13 Aug 2024 16:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3O-0004NI-Ts
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:38 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3K-0006AU-U0
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:38 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52efc60a6e6so7859453e87.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580612; x=1724185412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GxFDxNA+tjm9dd3YyBkmqa3TunWqvDtTEUpcD5o2pA=;
 b=hwTr3WemTnyV45lich1ruVLj/Mk3k2/xVr5v7MoW+gf02fTgn6xi84bNCf+rtp3900
 WXa4iCsOponY6jVwHmyPkH75oPzYzbkVYLFKjT1PR5qWmIrK3kD3iNL1kVCtR2SQn1CF
 uM4jOk+LffYrtKBacXfimTRQXcFkdV0sD0DKsgugv+tfOWY6ia+X73Jry1D+cWsc9So3
 F26NyfLdhz87b7Ddxk+uWH85gTlD/0QEYD6PLWfLsds2UkpXOiuLw23micVEBq4RXIpT
 b5WnHIETZBNNc743KylVIVWRWlIBs0IsDuqp1U2dvQ7V9gHssBGUnoCw8RjcRx00sYP+
 E9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580612; x=1724185412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0GxFDxNA+tjm9dd3YyBkmqa3TunWqvDtTEUpcD5o2pA=;
 b=mzmoKBUzF/AKeH2Dko8EqKXjtwBFLSxMisC1wBv90cPkgcedcQKZkIrWDQy80S9anz
 x91c/IxHCEkg3/hyvqr/4Fl5BhqoUflgU6oIrXLr/vBS1bQBSB0vHZ9wDtwvJ85kSKfB
 3B9Rf/WIHq2Y/cD+AyzJPOzWyXNs+9OPWYQR3oyVP7aHdLw+BCoJTC/NtThWIi6EqG+3
 zt8DR4gZHwIgLhPyeQosS0KazT/E4cO1u2MxXwZ5dYvwRaeVzn+Lsje7TPJhxbo/tfjt
 ttnTFz3E7kztXRTMQ4jdlClMZb6QuGQ3cyOiq2B9ozxJErvb0YNY+/AmCkTbevg4MG7A
 ItYw==
X-Gm-Message-State: AOJu0YyQ5o5M99ksW1uIFhDvtb8P96uqmbsMxRuSFfmW3IZQG35FpRnG
 7ykheeNZR69FTIy1zEQmdeK1M4HLM+k0BVcf+tGPTIafk0MWPYCgr/gPzZnCIns=
X-Google-Smtp-Source: AGHT+IEUMCc3Ienyb2xKePCOpVC42gkxrBNTS2Cyv2ISCCU732EPWZCy5QObJF5tqt1Qzkezm1Dx/g==
X-Received: by 2002:a05:6512:239b:b0:52c:8596:5976 with SMTP id
 2adb3069b0e04-532edbcce45mr270967e87.55.1723580611264; 
 Tue, 13 Aug 2024 13:23:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429d877e066sm32268685e9.1.2024.08.13.13.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BB7655F930;
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
Subject: [PATCH v2 04/21] configure: Avoid use of param. expansion when using
 gdb_version
Date: Tue, 13 Aug 2024 21:23:12 +0100
Message-Id: <20240813202329.1237572-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
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

$gdb_version is now used in more than one conditional case and its usage
in such cases may increase in the future. Therefore, avoid using shell
parameter expansion when using it by setting gdb_version to its final
form.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240804161850.2646299-3-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240807114059.2339021-5-alex.bennee@linaro.org>
---
 configure | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index a3aa257fd3..97de85d710 100755
--- a/configure
+++ b/configure
@@ -1103,8 +1103,10 @@ fi
 # gdb test
 
 if test -n "$gdb_bin"; then
-    gdb_version=$($gdb_bin --version | head -n 1)
-    if version_ge ${gdb_version##* } 9.1; then
+    gdb_version_string=$($gdb_bin --version | head -n 1)
+    # Extract last field in the version string
+    gdb_version=${gdb_version_string##* }
+    if version_ge $gdb_version 9.1; then
         gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
     else
         gdb_bin=""
@@ -1673,7 +1675,7 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge ${gdb_version##* } 15.0; then
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.0; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
-- 
2.39.2


