Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296E6C52D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy3u-00069G-OH; Tue, 13 Aug 2024 16:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3g-00057m-IW
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3O-0006Bt-HR
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-428e3129851so43533155e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580616; x=1724185416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0y9bR77UvCt8TQIygcd82Fr7RaUqdwHl6O1d6ILZIVc=;
 b=x9q5OvIhDUo3yhlEZS6ytgPKeMZKNcpdTsZr7ueRF5xVnavnPCY1RU/n7FT3Lx8Xv9
 RPckbAuuxZtl0PNbLD4f6MRLRUgUjEy6qkJ5KbEzO9bTHTsBzvtPx0iWBZs0pveKOruX
 bylQIX6Tx/sVP1fb8YqcJTbsa+lqRJ9s3sVVGwANSrUuJzJnYU97u0z4oKLys2XMeXDl
 bQ/hIf1Vpf5odfLjBiDiNV5n1L9EnrumiWu1rntWo+PsvS/wj3dQTO324eGwanPJXJOs
 ZnN3CRQAb+wxudCBLTYn/RG4u+AbIp3UcEHsQLavfHhJt/Otck1Ldji4S2ANiOWLTZDy
 D8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580616; x=1724185416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0y9bR77UvCt8TQIygcd82Fr7RaUqdwHl6O1d6ILZIVc=;
 b=fxC+wBgc190IrOqEf33MNmFIxZPsgLBok1I2lcHvQv8nZV/8uzqt9H55DixRroi0SF
 N+L+4e+iq7LKme1dbYYarUDXxOgs385EGxfF6faRhCtNeZLiNi0ai+fXx+j3rkr67ORg
 9GlLInLKQUwPNcxQ6JJvEyuonYCcQDrdgviMF9r9o2VwT+Wso5uPMlqttEAqJiG7ajU7
 l3cEBX+NRvaUU2dPNQ6CcxVbLCndLiJ1YE6DUELmTTiNqy326Ao5tcnlNT5Z8scz+te/
 vAvwS4YSz3iJ/bqoP0ijYPtjBV7AwqOyg6xGduAClV/78pu6AIZLwV8j4qlpgn/sVCMo
 ykNw==
X-Gm-Message-State: AOJu0YzDSOI7aPb74h2bFeoz9JnWNEXoj+pDc7/lJQgP0/MdWP0D584i
 fkUWZpJrK2w9+Xv6Kpttt6j2mkfU5DVASSWeKlwWIXhsE+RMJinHfgvtcXLDp6o=
X-Google-Smtp-Source: AGHT+IFM1gkXM9ToYjXxX7j0j/MfHmTCqLYgDpYtQrLkDfO297zIxetFiBO5Uq30pO6Vp4TTwfObwQ==
X-Received: by 2002:a05:600c:524b:b0:426:6320:7ddf with SMTP id
 5b1f17b1804b1-429dd26c229mr3693735e9.35.1723580615541; 
 Tue, 13 Aug 2024 13:23:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c750ec0bsm151656175e9.15.2024.08.13.13.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D18D85F959;
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
Subject: [PATCH v2 05/21] configure: Fix GDB version detection for GDB_HAS_MTE
Date: Tue, 13 Aug 2024 21:23:13 +0100
Message-Id: <20240813202329.1237572-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

The test gdbstub/test-mte.py requires a GDB version that supports the
qIsAddressTagged packet. According to GDB NEWS [0], this packet was
first made available in the GDB 15.1 release, not in 15.0, so this
commit fixes it in configure.

[0] https://www.sourceware.org/gdb/news/

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2477
Message-Id: <20240804161850.2646299-4-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240807114059.2339021-6-alex.bennee@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 97de85d710..d08b71f14b 100755
--- a/configure
+++ b/configure
@@ -1675,7 +1675,7 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.0; then
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
-- 
2.39.2


