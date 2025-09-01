Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8816CCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Yk-0002D9-CO; Mon, 01 Sep 2025 09:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut4Ye-00029r-3H
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:26:52 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut4YX-0001PI-ST
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:26:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b627ea685so37220185e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756733204; x=1757338004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyXvNak2OKRXWskNTtQkqe4CdzhDwlWUh7NjxtzZsaw=;
 b=HAADyh58WM/GH4iVOgJQIBK6lBjhBiL6Y9NEkFNukdFWDJxfnCATNzPdQcmvaALLMO
 MK16xVnwtLAjDb362yA014QnZn7lBQBGnVAI5xzql1iyswcBo67d8mlNCm6mDlGE34L3
 YMyW7SKKw+zA+JQBb7bZkrYoieVxYBki7IUKCw1wqNCUXsNajpzcWPNLcqkrco7I57Fk
 eolhf0+ixYuM51ZJQL/aj/ZT+XdTwIu3W27vIA1BmlQF000+FJbtaVVZmT4D7lYGIQyR
 PhTsEqFgIR8f4u1SxJpCcrhTAWcQa6HEr56+Ppjaz8IX8XNRIexCT1rS1fsbjl9Jsftu
 VmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733204; x=1757338004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IyXvNak2OKRXWskNTtQkqe4CdzhDwlWUh7NjxtzZsaw=;
 b=GU9glkdXmfQLPoi+BKyTsfyUj7vE8yguarD/botQhwPPFO4BFdlKnlsAtw8iOl/MGN
 AMLhooXoqMpwjQvYq0G2Ci44rj5mmu73/YnrF2PojAG8FyKgNo1aEVaQwLA1jUSuuX6r
 Xu9ZRflGU6Bgu4ZTj/K96oYZRm/mpi+BPi48i8LSL85uXd/R72HEyPVmoInaFoNQwC2d
 Q5ATc6FlZPsy/az3M7e2/eC+zqonyHJq5VQ+f+e+etxSdkT0BN2NOigfN5i4mrkm5wEB
 Alz1+NJ7XrzDK9yfv8CHi1akvd+XlRi/XXh7vRH5gfT5JxVMk8hU6CTzQ1JhovOfjKNr
 ynVw==
X-Gm-Message-State: AOJu0YxtShdnopSC68k8pk9iVFKHuvJ22LE/cWu5t+k6fuezgkwuWuwT
 XPtdwozfJK6eEjlyDsTSc9A3262QiBWq0suc5Z7Ohd7IHTUYzeZ/ONQZGAqj+k/HtOLzw6NBu1J
 umP4J
X-Gm-Gg: ASbGncsGQf9V+DlBok9kh/HrtF4W8StpNGiOyAFzoHnh73ov7mZmK0YEGiTAsST4VjO
 LgNqr7eZj80+ylO2kUxTMQIGUuBtZOcgIkyJehd+HWsOFHLmwGEqqMxL9orRA1CBGbvspygXKMX
 1HICLPkbjwYLutL9AFtHiwq/awy9u+MadbaDw+A5dqEULnBQYBtidNI6oMRg9CoLBEzifGP7dZd
 eFIaHtqhAR830KjyCU17qaCaZRFfgsc7sdPOKTIIgsOJfKvpo7/5dYKJ+S6ZYh3SfZOeMzDlH8T
 pxPvEp9XESJ2h+yfPOS4vI19EByM3Tj9HCJeKgQ5KlFyN2kMCVS/ezBHXI91IfffifKLqWrv4Ee
 1pIPFm512KqopqAQHcfU3Ue+QtOSKLkFQfQzcJLyu91wCFmKOT3gMZmAuq1CHwyWPe/jlmqug
X-Google-Smtp-Source: AGHT+IFxk1oMEs+7TSEUZFjOaTMjdD9yFbHhe/UTsg1JhXdhq8eWAumv9rYthd/OcoCrSH7dulAkvQ==
X-Received: by 2002:a05:600c:8b22:b0:459:dde3:1a56 with SMTP id
 5b1f17b1804b1-45b855b3b23mr62404115e9.28.1756733203643; 
 Mon, 01 Sep 2025 06:26:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c93sm240511515e9.14.2025.09.01.06.26.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Sep 2025 06:26:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, kvm@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 3/3] docs/devel/style: Mention alloca() family API is
 forbidden
Date: Mon,  1 Sep 2025 15:26:26 +0200
Message-ID: <20250901132626.28639-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901132626.28639-1-philmd@linaro.org>
References: <20250901132626.28639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/style.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index d025933808e..941fe14bfd4 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -446,8 +446,8 @@ Low level memory management
 ===========================
 
 Use of the ``malloc/free/realloc/calloc/valloc/memalign/posix_memalign``
-APIs is not allowed in the QEMU codebase. Instead of these routines,
-use the GLib memory allocation routines
+or ``alloca/g_alloca/g_newa/g_newa0`` APIs is not allowed in the QEMU codebase.
+Instead of these routines, use the GLib memory allocation routines
 ``g_malloc/g_malloc0/g_new/g_new0/g_realloc/g_free``
 or QEMU's ``qemu_memalign/qemu_blockalign/qemu_vfree`` APIs.
 
-- 
2.51.0


