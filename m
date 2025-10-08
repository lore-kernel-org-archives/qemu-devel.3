Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30E0CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 14:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Uw4-0002Ee-4t; Wed, 08 Oct 2025 10:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6Uw1-0002Cv-EP
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 10:14:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6Uvr-0004TA-DV
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 10:14:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso60517235e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759932852; x=1760537652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HMtJ9Bh3gq0ohWVQj4zIGGKICthhP+e2lHMmVOlS6Lg=;
 b=tO2YRzSAL2oSpiJceBV9vc/CmMdqQ/aDh0BgEnCiuw8EYevQ9mLVuhAWETlC6N+5YI
 pIJPBvGmhhroisiBYIC6+TbCzOKMh/2JFnBLcW+b4QC+7slwOZnxLm/bmNe+6Zv+6zxa
 W0d/bjiKyPSIHvS3w/fPjVcTsPwt3fpoWg4oJixfv5/Gch2aubT43MsPRaYktLHCn1hm
 RvW74fAy/pjGfpZBAFPJezBp+XVIc58hn2uupclPZp/1LTUYPur5TPg2PjvSXR2HhmGk
 U/4j3P4K6f2laBzPt0LIZX0uCNpvA1W9cuLk2GaTm5/Q6BB9jfmjEcjVYVW7oM8ZxZZQ
 viUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759932852; x=1760537652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HMtJ9Bh3gq0ohWVQj4zIGGKICthhP+e2lHMmVOlS6Lg=;
 b=Oqzd3VUzSa2HtlsS5MtdMMVal8Z8P7efB5Q7NsPIC31kAp4XDlZ23JXn3rVlQyqKyF
 6EoycZ30LL813fnes9G1SbCqGUPRfv0FEqqW3/nmZjM+OeVlRT2lAHDB2FO4QT3rY/2k
 eFmH/Ma451CPp1YI6ahzHN5kntIgvRIOKv80hjsPPZ1uyshobP8gJlubhLlSWOl6PGyr
 NrTSZfdcxqR6xF/kIzJ/bItvkwMxk0Jv/IWr7YRTkVGIoKk64/u9uctyO0r/6fkfO3uL
 ih+9r9YdXlk/g5sve523HyesUTgdiDd93jNx1r1YchEWEDWuRVaBBktyqTJzV39kPH3F
 SXww==
X-Gm-Message-State: AOJu0YypGAaSTn8W8KMgL3FYcW162rh5OCU8dfsIYQQehrv8M0b0VhXe
 jk6o1fGnZc14K+c0XN75miP6SoGv8gQojfORdogwjXzEyJyz0BBJYDhs8OYf2uXERvSIKqTm7Cx
 rIIUlAopzmg==
X-Gm-Gg: ASbGncv3boz7ROP1++tv8M8N1H38mrH/ys1L6yCFLYR2Mdg0FTf1eHvbr4alSZajFdg
 0HRcVgPDzd57jfA00HgYti4qXsyLGH+iPBgYdI9+axSjFqrFZSRyerCbvItH6e0+vrX9JQMCbCj
 3v2OLKr00BK+Nr1X+QNm7UFax4AKqYvdzG/AdwEl0GSx+ibXQMCv6LraL0eXGBR/GI3GBK6xJF7
 FfQGKGw/O4tU93wqjYEZFPisy66SfjVusCAh1qCaUiPCYkY40nsZFPhtkGZuU9vRoQv4qGzQHj9
 GiG1jvGPG7sI7NSNpF5Re8dMgAs3AemtJxPZv3dc5Gh26qoW5HDZXyEHG+TSpAyCJzrUzRAyo+9
 kxk11DEv4X60DginK9+IEwGWUL57/2BbZp32ynqSM1G+1BfWOrQV08Y9KbhkAYJaibd7/CYZSVO
 GLm2k/22bvewLCtg60Er2N1PTG
X-Google-Smtp-Source: AGHT+IHUCSpBMFPqbcq7SkdE3XP9sPVbkUUFggbr2OUQ9ALvV4dDmq/NFngapaFsAphRXDgbVLknAw==
X-Received: by 2002:a05:600d:41f2:b0:46e:456e:ada5 with SMTP id
 5b1f17b1804b1-46fa9b01934mr22776195e9.28.1759932851921; 
 Wed, 08 Oct 2025 07:14:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c0e35dsm40839755e9.8.2025.10.08.07.14.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Oct 2025 07:14:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] target/s390x/mmu_helper: Do not ignore
 address_space_rw() errors
Date: Wed,  8 Oct 2025 16:14:07 +0200
Message-ID: <20251008141410.99865-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

v2: Addressed Thomas' review comment

Philippe Mathieu-Daudé (2):
  target/s390x/mmu_helper: Simplify s390_cpu_virt_mem_rw() logic
  target/s390x/mmu_helper: Do not ignore address_space_rw() errors

 target/s390x/mmu_helper.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 
2.51.0


