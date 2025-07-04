Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1EBC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdTb-000251-Rs; Fri, 04 Jul 2025 06:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTW-0001mJ-7S
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTU-00073a-1N
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so5739345e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624214; x=1752229014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y+PveYXLiA/YiEmWDBVO+M6ycQoq9kMKoK80Idtoeg4=;
 b=PwGTotdw4qSzJIA8sok25yS/ri1tlAKaT5+/L3zfmf+deFByg/WEGhyE68ZdbIsT4E
 +wzyimaN97Px7+7pyceJF+/YJDlW6zOYw7/0sRbBAb7f43KM8eqx18AscxQ1i/9WhzwP
 bV7SgFIC0NCc0Mab41AxU2pbBSuFBcI7Bs9ZkJS1yTquXZe0Fk1c8LYYgXY94hKqrN+H
 5Fs9siTMBvusSSgz3TS0SVL+BgjxtksGO+x/c8jI4UATgEkey8oDDUGFHinPT7Ywwg2X
 z+pXKyijUA7RzXeRf9kur0sPgsG37tPNf4At83zDtz1tLzXcvrSrVRLdq8NXJqU9d5D9
 LoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624214; x=1752229014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+PveYXLiA/YiEmWDBVO+M6ycQoq9kMKoK80Idtoeg4=;
 b=Nl/Ob+HMIT7rVVQUqZK2J8ad4PNFbcj6iSEwtf/0O+H9TbI8Rc8bAdv49nMkSe+j+P
 8E45y+BoQEv5qxcTRCJSywG2WJ7Gti7Gyk2vIax3mdJX4/xEfXkiTCG/fznOMVAPsD96
 Hh6KeG7eYbqHqVp6qe2eSFNBXiJZZi5PBSgdt90CImiQaIsKk7xFRf/zUcJhgSrT8ViA
 nz/GfoMYihDEjBKdCpCBbEAranyElfKDZ9aPK9jK5wSLf63QtPEb+01xiy6659mEhctj
 C443hpCp+egJuMaseEew8i6ZW3esV/jyJd6D/n3sBlbBODWahNXDeahlyDLsCT27nq+0
 yR3w==
X-Gm-Message-State: AOJu0Yx9I3dWFLHB8IN9v/9SsB+L7k6DMMD+ni1yUYq3eEloS139JwxW
 ejqACpt7yi+7dz9KReENnHoBOYmUeWl+o/Z8N6PR2oLHiGp6r71KSeFZR594yKykgKrExr3kC7U
 8lV09ETA=
X-Gm-Gg: ASbGncuso7ER/WEp041hWlq9Fl8nNsPm26jp4AMAwnX7x/nJtcM94neknVr2gmg1oXQ
 pqVolwipl0aucyT96MQvQ6+H6UDZdQc+9EiqMHo+9o/UJbYopiChPH+cOnF+2qivoLjJ1ijXIsh
 8KjElajReB2B0mWmOkYS8375Eq4U05aH6nVDw++Kmdo1N5U+PYTRwriUo2iM1/HfRpLX0+R7lCL
 kabz0f024TdGmVxjOEx0L1vYMJcu9Mh9OLvUo6IDIHx6zuRJuwODr5GcQNxgdJmtOnHk20nvdRb
 LEt490iJwuDRGowN3gDdNrIuXmqn5IwV59PaQYemuhNLYupyESATzDDN9CKbzgXa00LxiURVq6W
 of26cx9gLnXuD4L3Vgg//7gJ0tyyvO5+iNYv9
X-Google-Smtp-Source: AGHT+IGFTx1K2rmHQ96EsEDBmY9hRME8t38BxzRUf8cI34gybe5loQexvtIu6h/ihL33Ig4MdoljRw==
X-Received: by 2002:a05:600c:528e:b0:451:df07:f437 with SMTP id
 5b1f17b1804b1-454b3115054mr25775265e9.30.1751624214110; 
 Fri, 04 Jul 2025 03:16:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b10b8c89sm25814525e9.38.2025.07.04.03.16.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/31] MAINTAINERS: Add me as reviewer of overall accelerators
 section
Date: Fri,  4 Jul 2025 12:14:31 +0200
Message-ID: <20250704101433.8813-31-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

I'd like to be informed of overall changes of accelerators.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250703173248.44995-40-philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fca98e12195..bfd59f64122 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -495,6 +495,7 @@ Guest CPU Cores (other accelerators)
 Overall
 M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
+R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: include/exec/cpu*.h
 F: include/exec/target_long.h
-- 
2.49.0


