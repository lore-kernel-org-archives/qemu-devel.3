Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9DDC3814E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPel3-0002oa-3y; Fri, 05 Jul 2024 04:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPekz-0002gd-Fl
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:57:30 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPekk-0001ug-Ej
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:57:29 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a72517e6225so153704766b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169833; x=1720774633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7K4IeYpitk17HZKWz2pT/RDMTcnxc4LGSaBH5+Jfr4=;
 b=C46NtmjitnL4t4ALGC5GJjTp5H8snTN0tRTMz5Ni5xp5uikAAwdVW71adnm2jiT5Aw
 1uwtzvf+IdVahFHbnBagZ1ZntXImS60LPCQW8URdDHzvrPpBkosR/y3p/V5Ns7Ge5uZM
 NHAtPVlur01fPyg7jdAwPpcS2PQFE1SC4Fk7vkzcf4Ne/GCmueUJn27NKP0g+MyxlaJn
 KJ1Z8qi1694XxPVE5eTw70Ct5AwrC/qrfP4S7DINF2KP790MDl56gNGEblxxEcoJitpP
 RPZIqKHWq4LQ9ECFmMBuneoexhNtSgWJQXZtdFXe7X76nUgRjg5E9CW11qNpcZqnn0eN
 ffjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169833; x=1720774633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7K4IeYpitk17HZKWz2pT/RDMTcnxc4LGSaBH5+Jfr4=;
 b=u1NE2QmcMZHkI1bKstjLZG/0lNHk/APzBNqYe1pxktAoAE6LDpZWxEgvMZBHNRBdFc
 VwrHG0tz1YXxtcczlDp2tFVRkzDkusrAu6uDjQ9uGxLD2s8E7lWjrRnimyHlbokW7mX/
 HE2D0P82mQPGwqJdHh5jAx3PAPCUFSEuovEUtv+1D61K0NPGzSDcVL82uuaUMbim/Mli
 E8rxTtpCEeeJ3vMM7OChwinQVS97zGAmeg2c6HKzBQUsJJ5n+v5P30NaCNEJW6HFagt2
 nDcrGhARHktY9hhcA4FBPb0M/+fFGIam+26uIoYXo+npblIVk/hdzih33h2SiGXj/Wbc
 sW0Q==
X-Gm-Message-State: AOJu0YwV69lGFRuOo+gpY4mnU55CJ8BFbca1F/EmsIpJUbHk9LO4eodr
 blygSg12lutuSMzCir9mDc8LDpIVieu5Hk0JmQ5Wo9WNEVJfyskx4QfBZcOjc9Y=
X-Google-Smtp-Source: AGHT+IHfh4gTsJT5+Azs0y4pggC7rqwjuJHmyWw3CHPh24bpITXZ4C0HH1X5sp393zxeSc/wLL4Qbw==
X-Received: by 2002:a17:906:494e:b0:a77:cf09:9c70 with SMTP id
 a640c23a62f3a-a77cf099d0emr55373966b.43.1720169832778; 
 Fri, 05 Jul 2024 01:57:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08cea1sm662435366b.156.2024.07.05.01.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:57:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E52E662170;
 Fri,  5 Jul 2024 09:40:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v2 33/40] target/arm: Fix exception case in
 allocation_tag_mem_probe
Date: Fri,  5 Jul 2024 09:40:40 +0100
Message-Id: <20240705084047.857176-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

If page in 'ptr_access' is inaccessible and probe is 'true'
allocation_tag_mem_probe should not throw an exception, but currently it
does, so fix it.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240628050850.536447-5-gustavo.romero@linaro.org>
---
 target/arm/tcg/mte_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 037ac6dd60..a50d576294 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -96,6 +96,9 @@ static uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     assert(!(probe && ra));
 
     if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
+        if (probe) {
+            return NULL;
+        }
         cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
                               !(flags & PAGE_VALID), ra);
     }
-- 
2.39.2


