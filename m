Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C97C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2h-0000GM-Fb; Wed, 02 Jul 2025 06:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2f-0000En-Q0
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2a-00034U-Qh
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so45357195e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453411; x=1752058211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/APTWbGW7rZ8FBTlao+ogZlUyv21mF4KMebEL0i1Uo=;
 b=N82fNRHLyet3rbJ/Can7Ngy2qJp2dkQuLnGtmNqe3rhCXRkJP0eQn6zDUgaa3Rd741
 d3tmOs3n4iBU6/E0sh48/ChvLlVNMjnCbxfkzP41u4UX/CpXeInh4wg6xYGPDKONI1+R
 kWRM5f4jVGfad/x10nInq6IguVMO04SK1PkyHKM8RVfKsBKhuykwMyK1qVQJ4jW86zp/
 BtIbo2iwTq6PLP38aJLXIN+cY0nk6Jhd7ME8xGXXhH+LqoCFFrwhB9obfDvMZZr/0L57
 PV7kKomM1o3Yhm3KNCJ1l/RPjbCScLPDa2OlGtBNFJoJHH5LJ0chTA0EJNYD5OsHgKga
 ORhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453411; x=1752058211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/APTWbGW7rZ8FBTlao+ogZlUyv21mF4KMebEL0i1Uo=;
 b=fKa4/o4Em5ZqkbBw1UhsHjJcxinuwLZ6w2KKcvyivoqW+CpH3yAC7XCjOypiTgHsvE
 MsELuUABuoL1SOA2VStBQrMuAEM/F2usBL+7VrlTLPtfaIWmdbCzzwLdiPRF/cXWHJoK
 E9lw647vkXy4bu73iWq6/PI6v5xxOBRZzN99I1Hkt5SAtUcm/Gz+zfUewOu0B49Xe+Cc
 s0eWa+LR3ZAZE3WIR2eQfiuszmHHvyN7H/Og5/dV3tfEJYnR5pp3+Y8L0l1/wgFTFW5k
 smpn4vMlSsHF1IPpFUKSxfpN1WRSAq8aiH2XDOvX7D+j7twDHQOtgw6l4lM7IlLAsC+B
 clPw==
X-Gm-Message-State: AOJu0Yx8gmf6g8i0RtoIUXMGWQEQ3QIdZgRT+VjPT9GToEPxu0yiQYH0
 /VrkAD0r76AF5G6rFw+wJAuKXeTYm+WV7okpwSE+1LnMYcYWauYgYKB4Fjgi6yJ0e54=
X-Gm-Gg: ASbGncu5uSaOuQpthDn6l7PRc1ok4bx17IDJOKV3Ap95pftkurLr1pVLi6kTmjsRpaD
 cl/1g9wC7e63EFna9J9Myf8BikXFWxV4TU1kYSF6kSKKa1iET2mypQNNsMyPqP54Sf9yzcFLIMS
 BQcX5p617WRr8S78PxhrO8M2+4PWNJETxf6O0dUmWw1the1rnn7GRlELdaH5Xw2XECIESk/KL4r
 kXPmxAQOLCCBafOpJ4Ek42ILlgZNQ2fp7V2bOupbwzspYpRR9QpWMF8JCNC/jSA4DNXy+jWwwjz
 4Wumf2p1mfxFgovHrWbOW4/2gNdYQJi6R+8UYvFHTF0FvsMTFGnrJmjpfpq0vQk=
X-Google-Smtp-Source: AGHT+IELRRvoVnBIi82ZAKHIbZuX3UcAh5YiEqUP2YbQBXGgK2S/mAVejazCouJnEcyINOJdCBt5jg==
X-Received: by 2002:a05:600c:c096:b0:442:e109:3027 with SMTP id
 5b1f17b1804b1-454a3a312a6mr17196265e9.24.1751453410837; 
 Wed, 02 Jul 2025 03:50:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453b35309casm29327895e9.1.2025.07.02.03.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:50:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E1025F926;
 Wed, 02 Jul 2025 11:49:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/15] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
Date: Wed,  2 Jul 2025 11:49:53 +0100
Message-ID: <20250702104955.3778269-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Seeing as I've taken a few patches to here now I might as well put
myself forward to maintain virtio-gpu. I've marked it as Odd Fixes as
it is not my core focus. If someone with more GPU experience comes
forward we can always update again.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250603110204.838117-8-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-14-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 850588fb64..52f0164edf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2684,7 +2684,8 @@ F: hw/display/ramfb*.c
 F: include/hw/display/ramfb.h
 
 virtio-gpu
-S: Orphan
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
-- 
2.47.2


