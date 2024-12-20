Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF1AE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfft-00062S-J3; Fri, 20 Dec 2024 11:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffr-000624-Qm
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:24 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffq-0006sJ-8b
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:23 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so1583010f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711380; x=1735316180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSFuFL9xNcXeZjUhN0taCGorfafBajTB0KXjdJQex7o=;
 b=e5S/ztp/QoIfgIMTp6dSj0JSsDoQn1tzckdnrxGPfijel3XbVWzSDop1uVhPUL/abt
 MI/DV0xdLuK+1yB6oeM9CMHiayUMxk652092OYat/wXDFY4R8PlWoSqmSk14l12++Dgj
 4Ji4oNGJCp4q25YJDZLd5RA1rdnm6/JJyJE6QeDGudLtAyLCiZDmxG0sTZxLKcEmt3yA
 C6Df/SrJKe1OgrAbjiaFM7Vp3d6wdv6s3hI/EFQsJsJwqTcWZVnqeQeWzM3k0tZPv4mU
 UB35jkegeY7s8XYQVAhUvD3AcSSrJqmfaYsRmTlCTO26QOjCQeBmZAE9WMqM38NbkDb/
 yRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711380; x=1735316180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rSFuFL9xNcXeZjUhN0taCGorfafBajTB0KXjdJQex7o=;
 b=CwKhStN+mpyy3ORcn/RaGGGQF57OGIKtB6DrPSBaathZ31JB+PLuy6eSFAMYJBuqzU
 VokoCwOpAB2byeC6Yn3kHvUv1YPb+gBsfew9+yqAWElEkSaT5nfO8Nj0XZ9fSQmPPl83
 h/Sw8eQ9b/c+BAb3FGE5Bf2t2II2+XtO6WWdbZf3Ie4HcwJ7VgwcNeVQRp3939uUVdzu
 AOMbohvSeUZD4XI3xLstFNHMHFYYwU2MaAV6VpHr3F/x3Fr2E7AhLNzIXxwri/mGA6KR
 8bjPmn3qAHeTmlRIrPkyxY977iXm3G5XQCJUX5TxC/SqQ6Ep5/mHWLj24dQLGIuo7RT1
 gw2A==
X-Gm-Message-State: AOJu0YySPV8HkdKRmG7YXUnUyRdhHlNxyamujRckssSX7HONRkQSdvR+
 5AsLcraxiLFc5unpEKy+YEtnaeOToWTIeRb8aoiGXeSIKS7MaF8h2qKFFuAKicrpNzY6tW4Uw5/
 v
X-Gm-Gg: ASbGncuXwPloltbwrlCdvifjX6kp0nQKR/9i1UzAXhleDzo2eCgZyd4v2s8Xu0yPLK7
 SNBLw03DVeOii9aaktc4uKd0W//AMZxgGTh7fENZAzevo2W7IXHYrzv5Bqo+2Yv+Pm3M+iSqj/O
 edwyYK4Bv4jxAsZrFVph+jb7KrL1UcSZjgkcEraLhNZUPOy6jjRMHf5t+OSQXT/71pJ2/eyd9ol
 thCk28V3sITQ/zMo+1zpt/pJHG3ZU8RsSNwXdf9zSyAuzRm301kqg18Tqb3+G5pb1MhvxV1vxU=
X-Google-Smtp-Source: AGHT+IExFLN0hcho9Qk1+jv9ob9GaBQ2FTkTbmeo1g8hgJaoidh3feCHjoNwW4hJHzQtx26fbBDrGA==
X-Received: by 2002:a05:6000:70a:b0:385:e176:4420 with SMTP id
 ffacd0b85a97d-38a221e2c89mr3563841f8f.10.1734711380283; 
 Fri, 20 Dec 2024 08:16:20 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8474c2sm4324687f8f.55.2024.12.20.08.16.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 06/59] tests: Explicitly create containers in
 test_qom_partial_path()
Date: Fri, 20 Dec 2024 17:14:57 +0100
Message-ID: <20241220161551.89317-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Peter Xu <peterx@redhat.com>

Drop one use of container_get(), instead switch to the explicit function to
create a container.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20241121192202.4155849-5-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/check-qom-proplist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 79d4a8b89d3..b48e890577d 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -610,7 +610,7 @@ static void test_dummy_delchild(void)
 static void test_qom_partial_path(void)
 {
     Object *root  = object_get_objects_root();
-    Object *cont1 = container_get(root, "/cont1");
+    Object *cont1 = object_property_add_new_container(root, "cont1");
     Object *obj1  = object_new(TYPE_DUMMY);
     Object *obj2a = object_new(TYPE_DUMMY);
     Object *obj2b = object_new(TYPE_DUMMY);
-- 
2.47.1


