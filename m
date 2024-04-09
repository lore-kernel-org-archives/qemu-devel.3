Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22472CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru9J5-0002l0-5a; Tue, 09 Apr 2024 07:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru9J3-0002kf-Rq
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:06:25 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru9J1-0004uA-Sr
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:06:25 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e136cbcecso7591022a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712660781; x=1713265581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3FQPgleUWfRDGef1iWkLjCvtXbz/mnfJ9EOOpLGnyUc=;
 b=Tt4x7iMBkzFXvyuw6OlsPkuDHAvkEbqAUQVierVnBl4ytLnUXUEntugxmJxFSGaNEJ
 1ArMrN6W24RCgj2Jkx51SmrG5f9y6zP/22HxfbZrwqVmvyw+WowJ1FV1/CXSLhsfL2zq
 U8hsXPUg8drb6h0DhQmrt8+Ekm4cCh9Xz6Fc6g3RqE7H89EigbAv8m6zSs3PWTrZX3gY
 RCIdSb6jlKRuuRakMQ3+eYj74aFQjGWmRJzuTHrtYKwxJpm3cQAqM9SpGtAYP7PEg4fE
 NU4XLK4J99UgYGDlsyPm2csxF2cJAWbEFrWERB2k7KiSms0t/ghpbgimnRqomjEIXzcc
 PeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712660781; x=1713265581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3FQPgleUWfRDGef1iWkLjCvtXbz/mnfJ9EOOpLGnyUc=;
 b=g47nFjvilhji2qNNzAbXdX1/kqqPB+45wv1ZgsHADHJQHsj/9OZT4kvMe4XFQtl4q5
 RqZIoUnu52tVSjXh5Sj7sRqTpMFdmdqFJo99+0DecCHWCcNZmWDKRbhT7z1be/De3Y0F
 +a2bneip/DitQVF7QqWZCq1959cS5b3cTVT86tMswI9WW1BVBMouvEH+eX7uvAEUz0I0
 JvsrNF+R9K63rOcXFpZBupliyL7VlY9tFHu3Y2OaEH0u/tcEPWiTUJML2RzQLKVxChKA
 6vBgJf4gXVMcuLPqWziw/jndgs3g9QwrWEfCWlp4gbiAgaijdoUUXZb4a4mSrojyhANq
 Cbew==
X-Gm-Message-State: AOJu0YzyzkYG/ocrbBZoEDXA/xpdep+5xPFGTuLElL5idovkwf1Zi51y
 Z+qqt6nhjatzmoK3AASgehCcyHQiQ7PG4c6u/8w8eAIzIyj9fk9bRSAD+wIRbQK1/uWeRtTB7qT
 8
X-Google-Smtp-Source: AGHT+IGqvDODxoX3DFlA0LWdu4sIO8j207U7m8HOhL7itf1bazI+vvVqRzsOA0jmNjtmmLY1T52gOA==
X-Received: by 2002:a17:906:2514:b0:a50:9190:b751 with SMTP id
 i20-20020a170906251400b00a509190b751mr8303807ejb.10.1712660781615; 
 Tue, 09 Apr 2024 04:06:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a1709060d8900b00a51ba0be887sm4278105eji.192.2024.04.09.04.06.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 04:06:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yuxue Liu <yuxue.liu@jaguarmicro.com>
Subject: [PATCH] mailmap: Fix Yuxue Liu author email
Date: Tue,  9 Apr 2024 13:06:19 +0200
Message-ID: <20240409110619.19182-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Fixes: 6ae72f609a ("vdpa-dev: Fix device status not updating on config INT")
Cc: Yuxue Liu <yuxue.liu@jaguarmicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 88fb68143e..67c8dfad28 100644
--- a/.mailmap
+++ b/.mailmap
@@ -38,6 +38,7 @@ Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
 Timothée Cocault <timothee.cocault@gmail.com> timothee.cocault@gmail.com <timothee.cocault@gmail.com>
 Stefan Weil <sw@weilnetz.de> <weil@mail.berlios.de>
 Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@kiwi.(none)>
+Yuxue Liu <yuxue.liu@jaguarmicro.com> lyx634449800 <yuxue.liu@jaguarmicro.com>
 
 # There is also a:
 #    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>
-- 
2.41.0


