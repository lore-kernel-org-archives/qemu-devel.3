Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50188E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEu4-0004nj-8y; Fri, 10 Jan 2025 08:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEto-0004du-Ce
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:04 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtm-0004iD-CK
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:04 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3863494591bso1151726f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515081; x=1737119881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ebmv3px8s5eWXQBk7u+pfSYVu0unZ0+wASKaGNOifkY=;
 b=oh0fVO0b8JJk0T3tfrR9oIzTqnkNkIf0Y7Biv1IV4fXqjUYhgJjJ9Yw7QTIYxHUkl6
 Jji3A5yZr9RfBkN3C46hmCr8u53Jr4psvXTThy/e4XrZzVTxiCMH2cAhUhx2uqwxs3n/
 sbbX40cxRkHop7oz5Mqotaom7NRz8V2cfkJuUQVdngC5KOJU+oisq6m+yQ0UqPsxUZwh
 wLp4tebjPQoPwylX+Y3gixBSmB+X3mD5pQd2iRFcmYpUrVgw789zAaOdaxh3fcF5RKhS
 0CkJDrs16db8BSQNsxLvKxdZ7+B7hyhwXzyFrpwL/vPCY1SvG9owxX9jYYOVdZvO797Z
 bSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515081; x=1737119881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ebmv3px8s5eWXQBk7u+pfSYVu0unZ0+wASKaGNOifkY=;
 b=leEPdf8dmwUXcP91EhTg9Y/d6BnGYBqD8Ip8+6pIIrMAsuJtsgPfVJUWBQ1YtoggkP
 bR5JbQH8IyFQrG/YSLZbPqXN15yg0FqkJ4PIMrIXhNk6ZlAkRDGdaPXn/44nBdoEXRu0
 LgJwq3lliRV3ierrNPHIGv/OdYGVxZ+CGwfU3fRJXEOR0YeS146Gdm5u2RVM2T94swxA
 BjPkY5h8M5IWWbjYAaVvkPSyLwi2p128AGBOO5N3+1LctvgviLcuMd19B17S7GFx14Iw
 w1no77eQ6F5izJJF/mmhwj8Dq9m6ZKYvvJ1OQsRy1314i2Zo0DfIYyKV4IVtiEsWWybJ
 bTLg==
X-Gm-Message-State: AOJu0Yy5a17/Y6mD4Az/85uNJ36uReIaovgipWfpFKAuxPy2R+kVqb0t
 L4afUjcreHlNjp5nxo4ts3RgngTxaeJVF+Yyy8rP0sc/843Gb/fQ+qFQqLXEWbA=
X-Gm-Gg: ASbGnctfu6iEr31ng4jWDcndz8EBPAbzXpTViSoAV7YHchM2Tlv6/TUIVIvbd8fn1BC
 oEwTDaitHcsvNaLYfaELa0LU9X6Etr/vwbyqSgY3VTJBpx4lNwJWaGy0nlDG7lpohMB4m0ZBCVo
 ugxvJTKIvzlTkywUlZjJ1yY8hGHwCC7ee8qoUd17v6Y+jxyonWaYLXPhNojHGyM+o9uw2PcEpZu
 U/13u/D6UcfbNzW/1JHz9RJnvTES2ydWMv3yQJYn/Nl7UnqSPP7frw=
X-Google-Smtp-Source: AGHT+IHjwtosyxKoKf7O09U/e+VvFu9iGKYJw5Gs2gCOBNqpbfTK6TLv99rqFbEqbkeEriXKSXmIiw==
X-Received: by 2002:a5d:6da1:0:b0:385:eecb:6f02 with SMTP id
 ffacd0b85a97d-38a872ebe97mr9819351f8f.28.1736515080872; 
 Fri, 10 Jan 2025 05:18:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c990sm4570400f8f.56.2025.01.10.05.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E5B475FC85;
 Fri, 10 Jan 2025 13:17:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [PULL 09/32] tests/functional: update the ppc64 tuxrun tests
Date: Fri, 10 Jan 2025 13:17:31 +0000
Message-Id: <20250110131754.2769814-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-10-alex.bennee@linaro.org>

diff --git a/tests/functional/test_ppc64_tuxrun.py b/tests/functional/test_ppc64_tuxrun.py
index 8a98d18ab3..05c6162b5e 100755
--- a/tests/functional/test_ppc64_tuxrun.py
+++ b/tests/functional/test_ppc64_tuxrun.py
@@ -85,11 +85,11 @@ def ppc64_common_tuxrun(self, kernel_asset, rootfs_asset, prefix):
                                drive="scsi-hd")
 
     ASSET_PPC64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/ppc64/vmlinux',
-        'f22a9b9e924174a4c199f4c7e5d91a2339fcfe51c6eafd0907dc3e09b64ab728')
+        'https://storage.tuxboot.com/buildroot/20241119/ppc64/vmlinux',
+        '8219d5cb26e7654ad7826fe8aee6290f7c01eef44f2cd6d26c15fe8f99e1c17c')
     ASSET_PPC64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/ppc64/rootfs.ext4.zst',
-        '1d953e81a4379e537fc8e41e05a0a59d9b453eef97aa03d47866c6c45b00bdff')
+        'https://storage.tuxboot.com/buildroot/20241119/ppc64/rootfs.ext4.zst',
+        'b68e12314303c5dd0fef37ae98021299a206085ae591893e73557af99a02d373')
 
     def test_ppc64(self):
         self.ppc64_common_tuxrun(kernel_asset=self.ASSET_PPC64_KERNEL,
@@ -97,11 +97,11 @@ def test_ppc64(self):
                                  prefix='tuxrun_ppc64_')
 
     ASSET_PPC64LE_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/ppc64le/vmlinux',
-        '979eb61b445a010fb13e2b927126991f8ceef9c590fa2be0996c00e293e80cf2')
+        'https://storage.tuxboot.com/buildroot/20241119/ppc64le/vmlinux',
+        '21aea1fbc18bf6fa7d8ca4ea48d4940b2c8363c077acd564eb47d769b7495279')
     ASSET_PPC64LE_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/ppc64le/rootfs.ext4.zst',
-        'b442678c93fb8abe1f7d3bfa20556488de6b475c22c8fed363f42cf81a0a3906')
+        'https://storage.tuxboot.com/buildroot/20241119/ppc64le/rootfs.ext4.zst',
+        '67d36a3f9597b738e8b7359bdf04500f4d9bb82fc35eaa65aa439d888b2392f4')
 
     def test_ppc64le(self):
         self.ppc64_common_tuxrun(kernel_asset=self.ASSET_PPC64LE_KERNEL,
-- 
2.39.5


