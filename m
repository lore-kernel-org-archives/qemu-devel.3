Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2358E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMt3-0007Zr-2C; Thu, 02 Jan 2025 10:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsr-0007W5-7Y
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:16 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsm-0006WX-Ot
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:10 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436202dd730so82200315e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735830786; x=1736435586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFrtobX5dEs1+8eScAKkWEL068+5vqZlHD9HfY3Xigw=;
 b=PetL/AN5Bt3ZQ2hWaDxfJUVCc4KTERzx7mPTyVc32cwDjKFWdAEaooDPeiGgEGB+Ai
 fWpFyaCKO/03ijk+dvKTArUg/stnWnPdLrqKaReumPSlZpozxI7ERjHnKQdP/y9Cz6bi
 Bb+Y6LjIMKabcDCY/H2LeVip8uTpV3JXL52U/q5FZFYAg7RvKlttHb7ydavE1fkyEViM
 UhbliJYQt1MB4kSfKJlfEVtrvgMcRk2VUYjlmUeOSZW8Z1fToToRXmbNvK6FEmiIxrKi
 qak6+BsnYea0eCzxIVsEdTCwkCMNT7dgprxirdiuU8SODJbQQCNo+LexMtFBhAK674wm
 YyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735830786; x=1736435586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFrtobX5dEs1+8eScAKkWEL068+5vqZlHD9HfY3Xigw=;
 b=pY7PcHocwA/OfufrE9fQ+5uY6zEW6M/ZLx5kcUROu6cuH9aX6fZLR1IlMYQD6R5Dv3
 nksFMCpHgwai8pYbNqi8pmORSrJNu251e/s/bgBx35s7pG6Kw/NybiICR9cxxvCuE3UB
 E6q0pbNnj3c8A33u4/LSjxHftTBv/+NP6GsjaMrD6ZQc/i5rb3Z5b/DDT9CvSKaqD2nP
 IT7kqlq+kxyeDKWkLklWCVhkeqHTjo++ci5B7saoE0H4lFn947/unfKoJ5RC0MiHi/F7
 NBwcJXe73EHNC8c7rObrMFcyGNgzwp0pJDjRwjgstaYT6wZeTAPzduBsEg94qnb8dh34
 C9Pg==
X-Gm-Message-State: AOJu0YzisMX1bOQaAfNLPvoBOH+Ngvqs3zPBsLVxgzwGS1SfqvUvJA1f
 qh5Oi26giWdvHUnImlSG/yar/C3BwqR/DG6liCQ8xE627HdWSSxbW9Gh53N3RJ+t9mYuclR+ALj
 8nE+GRA==
X-Gm-Gg: ASbGncujTQaAM1SewAj6XdVezxHJ1WRC4G/wARp6LBzoE6XYlO8XlKOId+WRvlbbNuW
 wLKAvBk2o5pvgAi1kL8HKzyTM+VRDiDHYCaoJQ5KZVFUSKMShZkq19hKEZF/MbKlgRAjId7eQoK
 JlR4jJlY+eKhtJQEMI/7fhTgrVtlst0T6orWm0/sDWRIv2MUhNCd13H/RX7wJnLbT6k/qz7QDPp
 MEwitbmXtCj0geVsdC1ugGs0Bx901QyyWHKidAnHLT5x9fQmKlD7pP1lD7zg8XBwRds2Q34uxxH
 JAv/HE6RzFXoGkFqmLUS2/lltS24oFU=
X-Google-Smtp-Source: AGHT+IG/G+SOkzORKVD/o6ASkr5fO9mx0JfNmsKJ7Gla6VMABAXRLSF6p/tnYJtslQmk4vxbpciqig==
X-Received: by 2002:a05:600c:4710:b0:434:9e1d:7626 with SMTP id
 5b1f17b1804b1-43668b5dff4mr340379215e9.25.1735830786184; 
 Thu, 02 Jan 2025 07:13:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b1f6sm494669595e9.31.2025.01.02.07.13.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 07:13:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/10] qdev: Make qdev_get_machine() not use container_get()
Date: Thu,  2 Jan 2025 16:12:38 +0100
Message-ID: <20250102151244.59357-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102151244.59357-1-philmd@linaro.org>
References: <20250102151244.59357-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Peter Xu <peterx@redhat.com>

Currently, qdev_get_machine() has a slight misuse on container_get(), as
the helper says "get a container" but in reality the goal is to get the
machine object.  It is still a "container" but not strictly.

Note that it _may_ get a container (at "/machine") in our current unit test
of test-qdev-global-props.c before all these changes, but it's probably
unexpected and worked by accident.

Switch to an explicit object_resolve_path_component(), with a side benefit
that qdev_get_machine() can happen a lot, and we don't need to split the
string ("/machine") every time.  This also paves way for making the helper
container_get() never try to return a non-container at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241121192202.4155849-9-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/qdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 57c1d9df3a7..bc5b60212a7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -818,7 +818,12 @@ Object *qdev_get_machine(void)
     static Object *dev;
 
     if (dev == NULL) {
-        dev = container_get(object_get_root(), "/machine");
+        dev = object_resolve_path_component(object_get_root(), "machine");
+        /*
+         * Any call to this function before machine is created is treated
+         * as a programming error as of now.
+         */
+        assert(dev);
     }
 
     return dev;
-- 
2.47.1


