Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F36CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4YS-00026K-Hd; Mon, 01 Sep 2025 09:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut4YQ-00025U-ED
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:26:38 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut4YO-0001NB-6t
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:26:38 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3c46686d1e6so2896680f8f.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756733194; x=1757337994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3w1FiZdw8VHp7vBmM8UDjk+CIU/+vapRQH5dsIqp3U=;
 b=JMMIjHc21Gyf55mLU+3iO9MDoPBtodwm6oLBJfctceJ8CXBou7BxqrdfFQcPq24WH6
 F3hbW9Fp0pplJyUSluipe4F6tnWLH6dNxg4qZi/j45NNlWpQwr6vHuf3P5C2+sCX5bQA
 FkyJiFQUEsc/EimrG83MpBc/5vgqGDkKXl5cLyJGDJJIwCPh0ZddRESIhLQI6mTMPzdD
 rKNO+b0hM3psBkvQNv3tqSrAxdNSpgLeG/Z/bvRfx4oQO2umva2lJOOJq+tZXb9KUkB7
 I7TaOGGqatsirqsQFDdTiXdVVmpyfxig3M/VQghHkTggO1gyQvxfZL8GGz0lPC2C7Ufp
 quVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733194; x=1757337994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3w1FiZdw8VHp7vBmM8UDjk+CIU/+vapRQH5dsIqp3U=;
 b=YsycJBf/NEQSdFf3kfBqsnNPtH4uxjwMcyckrqwmUcOzf5sFJKjaP1g7/KMdyF8ZZj
 rfnvl/2YyHUIlvgef4LG4d8WQgtJZ5JxT0XGpHpDUQnulAbZ5/Fbgy37/RXAl2wtszJ0
 fT6jBDyDEIRmBYvHvP+QKOHSFRUnM7/Px80+3V4hgEwzOiI9+UQ269HwLo8R1COVrFdB
 tMABZtR08L3ij8CUey47MxTm4aYimlhFKafhTg4hSFlSDigpI2Fgu7Zoh0opRr3WmTZK
 N53KR9zk9sLyWJzMjuR1vZcQbZPEiIGoEi+9CmskRn3JDmT/o73lMU+aUmaP51/qWYjl
 2QgQ==
X-Gm-Message-State: AOJu0YyHtCbbnAH8/skrXIIa0GGWVppRdUqTKFSNsPEAWr+/r2z5IBZH
 SugKsSrCAxlKtu0XXzCT8QVZEp8BMKLTb+R19Qc9zom0E1OzYlrFsBl5ocPP6WU59SrJorqqVva
 nOZH3
X-Gm-Gg: ASbGncvbVWW5dvR4wm+kw+tWgSsLgy4GsNOrr48FkLBPzIy68I5z2AIuh5oizGS9RFU
 b/1omuDUpLYtbPgfeUmolgyI3ob+Ca3LrUGw1PbZ9Brhajc0TCQAo6SzCJ1LNqPkKNqurRXC+Tm
 6GADwhehEoX/Pn8+lYmRcd1PbrulC8Yb822sV/Y7CuNtKjHvn9bO0Y239uud/aXsm1Y5CCEb24X
 0pfZSp3zMRJ13vIrXDHmZ0/tls6sZ1bffyQqWdHZy6UmMtr2kzn3Ql8t/zfqW7A4casWF8M7PqL
 dnGqJ2Hf92vmsYeK+xCZzMI86qDZIkx8Ixxmi0Dn0jnGk2C1Xikb4q0ly0Wgm8tfgNhg2VmZhVr
 zIuh1hYGAxzQ2sWvzWVLGPYYf9cIRvLXVqX6h4OCLdaN++Srww6hMJJwSE7ySXfdyyrNh+dMLmL
 dR3nRPolE=
X-Google-Smtp-Source: AGHT+IH/QAHlxPbNMTYaJUtn3zT3bO63FA0TSMUQyXWPqmbg4KgBIu8+2jjlf2Aul+/W+uLb9CMgDQ==
X-Received: by 2002:a05:6000:230d:b0:3d7:b12b:1312 with SMTP id
 ffacd0b85a97d-3d7b12b1a47mr1452198f8f.9.1756733193793; 
 Mon, 01 Sep 2025 06:26:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d15f7b012csm12130896f8f.63.2025.09.01.06.26.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Sep 2025 06:26:33 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] target/ppc/kvm: Avoid using alloca()
Date: Mon,  1 Sep 2025 15:26:24 +0200
Message-ID: <20250901132626.28639-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901132626.28639-1-philmd@linaro.org>
References: <20250901132626.28639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

kvmppc_load_htab_chunk() is used for migration, thus is not
a hot path. Use the heap instead of the stack, removing the
alloca() call.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d145774b09a..937b9ee986d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2760,11 +2760,10 @@ int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns)
 int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
                            uint16_t n_valid, uint16_t n_invalid, Error **errp)
 {
-    struct kvm_get_htab_header *buf;
     size_t chunksize = sizeof(*buf) + n_valid * HASH_PTE_SIZE_64;
+    g_autofree struct kvm_get_htab_header *buf = g_malloc(chunksize);
     ssize_t rc;
 
-    buf = alloca(chunksize);
     buf->index = index;
     buf->n_valid = n_valid;
     buf->n_invalid = n_invalid;
-- 
2.51.0


