Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BC3CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7P-0000iS-4d; Fri, 15 May 2026 06:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq76-0000bi-SA
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq75-00016r-8f
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so45660535e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842188; x=1779446988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s4bMqeaqqVIhpwFG12+SoiibGvlQN/iUNnXG7PwJyPw=;
 b=nd9qV+UelVcfZMVG5f1i0g5oX2Vq/17m3STrQa28xF54R5fJdOGlub6INXXEUrFF5I
 IIDMq0q9H989Fw9m6BTbPhDWUr10DnR8A+iF+2kpeTIZJ7j85tHDzRYac21kBMTqKGMJ
 +3vxPyVlFfFORd0uPqRM4WA2gsurObkRcnPHFzcebZV4Op+SUUTt3JoU2jhv4sz3gBQT
 S3sr+nwMdF5WIHr3BiYpagjacof8ePj9yObu3T12DpGzqh8CCzR0VD58PPmTGsaWJZxj
 06RslDQXIymIge4+j0qLO8Xw5HCxM37fSD3rOUlkf5bXJalgT3xDNh2wgkYWdmRt5RdJ
 atcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842188; x=1779446988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s4bMqeaqqVIhpwFG12+SoiibGvlQN/iUNnXG7PwJyPw=;
 b=UUysL9KKU6xMuU38AcfjZ8o14rXTtdPuY8Dsu4fbhBPbcxRnxDYiAb+qFr1HoHwLj3
 RkSIct65vww3nu/g8/p0jcRB1vxbQ7Rw1P5+W5bdi4VH+UUKh4xDT35WYw1NteKIQPCQ
 P/uNZqjsLA692NaSZGJr14SmporBBkN6BzuYHDFG2ZtfcREorplZhcN2PhAIahJmmqYH
 D1XkfRlYvNVgE9R6rCn0FXgjc6OknuvHdEYXhQT5WBr0mHLqa7oNKVRWgvYxRNFDwnnF
 vwVpta+9801/7yXHu9JOgWZXgOyrmerDwTFpHKDDYS1w1S28Y5aqGR0KfKVJGiMOjtFm
 /AyQ==
X-Gm-Message-State: AOJu0YxiGEbcI0rlZA9q9Skwc7atBbnx2uSeyQPApX0+Z+6YpG9lIy81
 ypHwQ1VnjTQMAllw+gqYJzQRC8fPWkeVWHqKP5NemlnciABfz3QTqyhslxg+WhRcFLVZz6uHKsG
 cXhMY
X-Gm-Gg: Acq92OGLkkjRjCVzzeG78hW+PlQFtooTSIHyNGpa3t6TwWr0qmjYauseBBrmcryi4oq
 bF8DjmdpFQZXnzmB9NvOOQOPF4PxowZ253IIUYjB9gy4GbTk2ySxCKYQRYOLq57i0863PKVytFQ
 5HvGjUKmDtOaCTKIJtZQAk9lhICfoXn2VWz4UEpt/nP1o8IQXH5hKsjFwYweemmGqzK+a+EoNky
 YDPM51DLmao7q+GuJhqQ+po5ybnarOSKWZZu9gozNXPGpszq7RilyK0kuKFcoa3/jr7z0Z/5MF9
 9OzGJJpH8poUZ87xK0EOw1EvbwvDACgmsuVGHn4eYSPgteDjcnvM3m7lwxgZ+d9lwC1brr9OBg6
 6wbQQXqi7IAK3hGzD4I3bg8ecWTyc9/Uh1r5ZW26qp1EMxXWLJteQgP1/pYnaP8d49Z/zdB//aY
 grCaA+tVcU5fE7wEXb3jZaeL0bi1cetNW2i4aSz6faHgdCUuX0vWFDoSCjpC5WzSJWw4YrB+GEk
 /UdWQWfnGcPPMeBL554g8Fv1zj+/Jc=
X-Received: by 2002:a05:600c:8b56:b0:48e:8741:fd4c with SMTP id
 5b1f17b1804b1-48fe632536cmr55553595e9.18.1778842188245; 
 Fri, 15 May 2026 03:49:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.49.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:49:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/23] docs: Document TIMEOUT_MULTIPLIER for raising test
 timeouts
Date: Fri, 15 May 2026 11:49:23 +0100
Message-ID: <20260515104945.4145203-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Our test infrastructure allows you to set the TIMEOUT_MULTIPLIER
environment variable to raise the test timeouts if you're building
for a slow environment.  (scripts/mtest2make.py reads it and sets the
meson test -t argument accordingly.)

Document this so it's not a secret feature only known to a select
few.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-id: 20260427161132.1463385-1-peter.maydell@linaro.org
---
 docs/devel/testing/main.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 0662766b5c..b01a374865 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -52,6 +52,21 @@ Before running tests, it is best to build QEMU programs first. Some tests
 expect the executables to exist and will fail with obscure messages if they
 cannot find them.
 
+The timeouts for QEMU tests are set conservatively so you should not
+in general find that tests time out. However, if you are running on a
+particularly slow host or with a slow configuration (such as a build
+with the clang address-sanitizer enabled) you can globally raise all
+the timeouts, by setting the ``TIMEOUT_MULTIPLIER`` environment
+variable. For instance:
+
+.. code::
+
+ TIMEOUT_MULTIPLIER=3 make check
+
+will run with all the default timeouts multiplied by three. You can
+also disable timeouts entirely by setting the environment variable to
+``0``.
+
 .. _unit-tests:
 
 Unit tests
@@ -959,6 +974,9 @@ Python. You can run the functional tests simply by executing:
 
 See :ref:`checkfunctional-ref` for more details.
 
+The harness for the functional tests also honours the
+``TIMEOUT_MULTIPLIER`` environment variable.
+
 .. _checktcg-ref:
 
 Testing with "make check-tcg"
-- 
2.43.0


