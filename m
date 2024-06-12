Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29560C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQ0Q-0000uq-Gk; Wed, 12 Jun 2024 11:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQ0L-0000WM-4C
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:35:17 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQ0G-0004JP-39
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:35:16 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a68b41ef3f6so2070266b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718206509; x=1718811309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJAQlF/zpzEh6ZUd/TIoqAhEJRcTvj1Vbf876k6aGf8=;
 b=cZ46bjnhFEGwLZvSGWoADNpD/YVZ41q5eecuckD1Ev31QTtqGZumLNHrvahZh4Btbi
 UgYwhILlzFXWPbXf/yMkcSInE4swQriC+I20uECIHGD7U1ezCYzwubjepmOGbwKDI+ds
 kVKWNxKt6y6hNmLTKerdxx33Hk0bVBJfWeMcTUF9MvtxVzx+D4n6degYAsKRNq20YqMb
 WoS9w7xQwUyjEqyvrlkzdEfK6rAWIySO/UshpXRTfJLDPniHPRDf7g2mczr6eatWObnQ
 HvWkcgNc9xklvUItlCmook5cpNYHPuUQpWjaoJU2Yj++D5BNN5nH1bE0fGQ9NwD1Ps6M
 SAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718206509; x=1718811309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJAQlF/zpzEh6ZUd/TIoqAhEJRcTvj1Vbf876k6aGf8=;
 b=G1gN0wTrdZtAAe1GSflgWuaxJHSlyWwJr3Iq/gaEd1TtbQU8O6svUXGUgH4QnRfMob
 IsOvzIoSxnDxdL77To/t8fJDDMNBWlYfYjubEO1hU8ZfoWjGwCiicFrPsQf463LdCvt0
 j3Pjmb28jbQX66r1vHhoIQhrEQNu4p5FSxMn2hfSLikGlSitpbFz+nhJfzVqL3AeoBx6
 x7Cir6vU9pn8GGVsqYNNBjk29/j79NhJ8q5h8IxMR15oPZvjwSlItuyRk1n5TuvJdRuY
 sXHnmM/CXw1RKEC3mPaKKKH8AYN3vMh9mbG2GCb8qHviTmxDrh4CQa4lZzmjvPiLBYNF
 tnoA==
X-Gm-Message-State: AOJu0YykhMCxqBJ7Tq1y5/I+RVuqap3u5/WvAyYdJFnW14rTTHoIJbAw
 8tkFSfQ4WJBFqnzrMsXROX7EN1KnYDA7xQUh8dzwD2zTdrSf/Um+SazVzXiksyY=
X-Google-Smtp-Source: AGHT+IEUiek7G0JZYXLhDU7k/lAdd2/r6kUwG039veuUiD6xxCOyuZljXlDyYhWaBzPy7woxoD/XUw==
X-Received: by 2002:a17:906:898:b0:a6f:23b9:4e5f with SMTP id
 a640c23a62f3a-a6f4800a19emr122891766b.70.1718206509163; 
 Wed, 12 Jun 2024 08:35:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805f9f3dsm910164966b.95.2024.06.12.08.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 08:35:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A48F5F939;
 Wed, 12 Jun 2024 16:35:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/9] include/exec: add missing include guard comment
Date: Wed, 12 Jun 2024 16:35:00 +0100
Message-Id: <20240612153508.1532940-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240612153508.1532940-1-alex.bennee@linaro.org>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/gdbstub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index eb14b91139..008a92198a 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -144,4 +144,4 @@ void gdb_set_stop_cpu(CPUState *cpu);
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
 extern const GDBFeature gdb_static_features[];
 
-#endif
+#endif /* GDBSTUB_H */
-- 
2.39.2


