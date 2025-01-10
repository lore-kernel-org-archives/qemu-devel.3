Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B61E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEu3-0004my-7E; Fri, 10 Jan 2025 08:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtq-0004ep-Uc
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:07 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtp-0004jk-1k
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:06 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so14975205e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515083; x=1737119883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmJfHdSIrhF7DqbSGthB+vsg9Cqg949CzBqeZjoPpvs=;
 b=x+Ajv7ej5tMAdlRs1CEEQcMYR/yoDlqSIacuk3ooJ4ozSh1+JJO6wd6xqLT8wiQuvY
 b6S/F9NMWW9QYYjL6QNqzKv9Fvxk0VpMqPJ3PSls70g/CZP1AOryuG/r4jT7lfkrXTsP
 0GZeZgs+rvpV0JAKOr6qh0nm955jhBr84uSGS80yi6sYnlCcsDdLqKppcgDeESTNCzE9
 lnBFJFkydwgpEBThXSbRrzUZHbfK3urxCmcXROuAf6hT/bZC6VshtRULPMQu9gNJqfb7
 S9KdtPKQl9JbJPLIlGwfNFbe0JTMd1tbqFERDT90r9QW4Subp3WGLp6xUfXy436DdWAs
 pmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515083; x=1737119883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GmJfHdSIrhF7DqbSGthB+vsg9Cqg949CzBqeZjoPpvs=;
 b=WjSc8bJXM+bOq+5YNMOvxWShz4B/EXlccoKVonp9y2PAcLrRt2p2XzAH4yn3tgIk9B
 gZgHR05FqWsBuQQ+WVe3Qg1/mOcLF3AaJBbjt7HGM7d+oHcUSf95MbcZrk9tkRqko8kq
 x0NRFbnshbwRfEjp/jc/uFbSJdMincwrrkO82nD0Mpsggy6mFHDaOYnsceUljFz4JUbG
 vwvTS9EGSfsHMBSjNsiUOkhP1IiD51T+8lILZkRDHXgfXQ5C/AfW+sEk2pezHND4yl/4
 z5FJvvZq8b/wW42DYwuY9E57gvPoB2DTeAEFMYMjTsLpCltNn0c007PU+aXaj8Amfbkv
 PEdg==
X-Gm-Message-State: AOJu0YzKk//oUdLkoERgSiEabIqqdnST0HYvel0J1+ZrHseEeCjoIbDR
 RFjXBk8CIPBretVyXvMz3OxZwsdyOAh/n4Z/AEHZTNFzIZbkVQJNQgrV38NTd1s=
X-Gm-Gg: ASbGncvIGTrjQS2a1RgvCecjWpC3MsjkSdxoSgsOZZrGG9grGJaRABPMeAuvB+3VIJ3
 LN2C6bZPMSszEz+G/+go+d32g1FqJR/2HOKmCf2JTEVxGTCIGjJ4rzjSX+5jXn25AMbZ5KkK6Y+
 j5jZjcWjBesgxqV+R5yBq21sQZISpg8XpfJF109WgPS5UlJLpIbR1Uepu7DVJAnCsDFASTQchDW
 VXiTKqx/D/DWX66+L2bSR4g0GFAODCRbugYOj4IDSN2kTVZx3La6ic=
X-Google-Smtp-Source: AGHT+IG6Bm1NKHT3WBZQnxfDkk2QSVzFiVI7fYGRgIkZphAufU6b5yDgkjZxD6Hkj4XKVk30IweNCg==
X-Received: by 2002:a05:600c:4314:b0:434:a802:e9b2 with SMTP id
 5b1f17b1804b1-436eedef4damr28778655e9.4.1736515083416; 
 Fri, 10 Jan 2025 05:18:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38428bsm4555990f8f.37.2025.01.10.05.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:18:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 46D056017C;
 Fri, 10 Jan 2025 13:17:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/32] tests/functional: update the sparc64 tuxrun tests
Date: Fri, 10 Jan 2025 13:17:35 +0000
Message-Id: <20250110131754.2769814-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
Message-Id: <20250108121054.1126164-14-alex.bennee@linaro.org>

diff --git a/tests/functional/test_sparc64_tuxrun.py b/tests/functional/test_sparc64_tuxrun.py
index 1c2c005630..3be08d6102 100755
--- a/tests/functional/test_sparc64_tuxrun.py
+++ b/tests/functional/test_sparc64_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunSparc64Test(TuxRunBaselineTest):
 
     ASSET_SPARC64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/sparc64/vmlinux',
-        'e34313e4325ff21deaa3d38a502aa09a373ef62b9bd4d7f8f29388b688225c55')
+        'https://storage.tuxboot.com/buildroot/20241119/sparc64/vmlinux',
+        'a04cfb2e70a264051d161fdd93aabf4b2a9472f2e435c14ed18c5848c5fed261')
     ASSET_SPARC64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/sparc64/rootfs.ext4.zst',
-        'ad2f1dc436ab51583543d25d2c210cab478645d47078d30d129a66ab0e281d76')
+        'https://storage.tuxboot.com/buildroot/20241119/sparc64/rootfs.ext4.zst',
+        '479c3dc104c82b68be55e2c0c5c38cd473d0b37ad4badccde4775bb88ce34611')
 
     def test_sparc64(self):
         self.root='sda'
-- 
2.39.5


