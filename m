Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C43BC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVfT-0002go-E0; Tue, 02 Jul 2024 01:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfR-0002WJ-RU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:01 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfM-0007OQ-OA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:01 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52e8037f8a5so3446283e87.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896574; x=1720501374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckBzbdEj+3o/s/LUD3LYtPTx7oK9lF8pkA5ZkoB219g=;
 b=GVx1YCZmWLkDQMFSQnVyq5IDJ9yS+WstoLkil5mQxqPxFSLZpwNiTuKuFsRPV0vNGS
 2x004ZKHROK3pgPw2pXdL/3f5kt7J1lnvgRLT50RYBU04cpBxBaUU0iTekfnicF0eSX/
 QLYIWnoxnBKKf7Y0Z4mIgPw9HEfV3IAwG8ei7fq5owSuEg0r3lx1zRCVRwOGc5NtqFnu
 rqJss0lUVQa6PT3tVwQTRlEdAlpRAoGhlS4MhZQQf+NmPBdJPh3kwNhwVm+CMvUJYXU8
 MPfh8Me9SIqbg9VsSeeT1JDC3gL/Yi1KDAnUH7b6swfQCcmfrHXpFSyQG8RSUNUxkk/R
 sGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896574; x=1720501374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ckBzbdEj+3o/s/LUD3LYtPTx7oK9lF8pkA5ZkoB219g=;
 b=BYT+7sDWVt8wtftUbuhDt/2w+uEhPH8UUgvqVwSEViAsvCqS9aT1z7TR0ZxUIgH/kY
 HaCQiJ7TdvpnJogFO+uOTqwMddxIYn1/5MdsvdhM/FEKATen8gm820CTv7Oh1YuK3Lao
 6h4J7AJi0LMpMcc6Z6CftZvE/ro1zzm1zavmJAz2wFtk13hkQnnUei4PX+XP3pGFNQZk
 rvvvxiNFE9f78knNiRyqbYixEPr/kY7BVz/PGJnVzupQiwhHdnwjdsbn5EU+Rc4AxxYK
 sghhxA9YigQX3cXStYue5L3dtXh9n8/Y8ExZFJB5LxaNc8qdI0QCc41ArNIlkG41xqES
 8Sow==
X-Gm-Message-State: AOJu0YwDg7dPEvrPHIHN2gU5RRopQUeBJ3uPjPolJnYB4pgXp1mHbseS
 sj1DJz42Nt1Mo+Te2IjF2IgjPjDMrokJyrsQGhA5iqFb1LJcZfjiBFQzafAWB7fsSFfdR4Li1lw
 a
X-Google-Smtp-Source: AGHT+IHuYyLWmbfp7HqwfMztJsjTsMO9hHkgvEf4+OOUzqNO+QdE51/N0cREA0/Iq0aoH8JWuVx+5w==
X-Received: by 2002:a05:6512:2309:b0:52c:e03d:dfd7 with SMTP id
 2adb3069b0e04-52e8268d153mr6350848e87.39.1719896574653; 
 Mon, 01 Jul 2024 22:02:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd663sm12079456f8f.3.2024.07.01.22.02.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:02:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 16/22] system/physmem: Fix reference to dump-guest-core
Date: Tue,  2 Jul 2024 07:01:06 +0200
Message-ID: <20240702050112.35907-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

dump_guest_core is exposed as dump-guest-core with QOM.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20240628-dump-v1-1-c581d10f3646@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 33d09f7571..261196cde0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1521,7 +1521,7 @@ static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
         if (ret) {
             perror("qemu_madvise");
             fprintf(stderr, "madvise doesn't support MADV_DONTDUMP, "
-                            "but dump_guest_core=off specified\n");
+                            "but dump-guest-core=off specified\n");
         }
     }
 }
-- 
2.41.0


