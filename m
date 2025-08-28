Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613C9C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau9-0003Pn-4l; Thu, 28 Aug 2025 07:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau6-0003NS-PL
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau5-0005mZ-5Z
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45a20c51c40so6758635e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380891; x=1756985691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PJHqiXggFgAiWZxXmkBYzyTnpBKCQII/0oqdzzevA9c=;
 b=rmo4zaZzEHlB9MQFJV+nlXzSoUQtBckp2aE3IuRm2nkDljgtl8qq4GHAKECNRNC+XX
 +eGjcI7jRpE9T4zKbZitFlYFqmkRUCSEW2kp/IeeVTfseaRwdcX9kVnqlq4sMZCdjBMN
 03sM9rpZtG4Ue7WRwykgfxY1J/sKNK7EYC/Dov0PaJBwvVz6azA/9aL/RcZiRmTrhLtB
 RnvV0YDWPDpnfOXuwrx8lSy+W4UjbgZWKfi9hbN2ebxNkrbtATbs8LmjJAysF5TQkT+w
 VDCDYMkD0UEStGkWPv1NO0ZnKaYo2RvqSs3njxwqEXCA6bvCc5/iRv01oBWq4lZcvvcL
 KlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380891; x=1756985691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJHqiXggFgAiWZxXmkBYzyTnpBKCQII/0oqdzzevA9c=;
 b=O0UZRkQmzcUL1xbBfS3hzoPmTuuyTvWazA+sUealGxc89miJJyYP1iyKm3kOTb4Bcj
 JWWQHQUQEgLA1ddFhNq8TPU8hmS5Wa8xAlambksHVjIxuScvcfSrBG+MhGmIVylfenog
 RHNIW/nwmUWnyGFpxNobV5zy9Gv1rrV7nLU1XC/lOu8UPlkPUcBoYcNkk28Mvh8HNlI/
 lhPzZIM40SNU5VLPOu4eyVQv589HIERMIgjw3ckabdNO5BW6BHgcQjmXMCivwMKvzLz+
 UXqCR8yewB+wgEulT808SJlyLb6TU4ahBIktGoFEqRSSp0oZ3erX7AjoVG1FB2a747AZ
 c2Vw==
X-Gm-Message-State: AOJu0Yy1iV2EDakxxgjtXHfmcuRBQ76RlojC3fuEV8W7X6EcLUAk8Q4o
 OcgemsGvEKr165q8sy6TcWaFXt8diNoKDjlEXdXVqM9n/f8v2r4CuGegTrXyukJHjXqqwYDDMlC
 vclia
X-Gm-Gg: ASbGnctljjf4KMj62+J0Gdtcv3XwKMBLs/igLznoYPvx6jC+17HEits+zCw8rc6mjvX
 eyGshxjtiRh7jUMYow9jDlSTepSfUshD8mZ/0GltKRr5bfI31UymU32BohSSYhvr/ebG42hN+6g
 faM5v0GQofyFl+ZJhHHIt22KAPvJ0Gt24YRiWs+x7a+AGux4XbI9wWCNEYbmQoO6udUih2mEiPT
 nsR5cHg3YiNRz4+mJbt0g04gThm5v7vz3g3yg388yZo+ykjloMauLwkjoPx91R9G0SeDNn0QSGv
 3/KeepDwWtli/bd2mNSTwFrab0poB+n/GMkLt01KQ+SXFC+nmqqqqcrWARARMKXyOnrtMZq91x3
 NGn3qg+CUvPgND34L9Wsyd5AfEQ85cSVxvxI2430=
X-Google-Smtp-Source: AGHT+IFB+sFJAUaChuPcDFX5JqYs4RCC4BdAfhhswTjcOhS3gLndld4L6BU/lhG7HhxGDNiZF6+PIw==
X-Received: by 2002:a05:600c:4747:b0:45b:627a:60cf with SMTP id
 5b1f17b1804b1-45b627a62cbmr132447825e9.24.1756380891492; 
 Thu, 28 Aug 2025 04:34:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/32] tests/qtest/libqtest.h: Remove stray space from doc
 comment
Date: Thu, 28 Aug 2025 12:34:14 +0100
Message-ID: <20250828113430.3214314-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The doc comment for qtest_cb_for_every_machine has a stray
space at the start of its description, which makes kernel-doc
think that this line is part of the documentation of the
skip_old_versioned argument. The result is that the HTML
doesn't have a "Description" section and the text is instead
put in the wrong place.

Remove the stray space.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-id: 20250814171324.1614516-3-peter.maydell@linaro.org
---
 tests/qtest/libqtest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index b3f2e7fbefd..fd27521a9c7 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -977,7 +977,7 @@ void qtest_qmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
  * @cb: Pointer to the callback function
  * @skip_old_versioned: true if versioned old machine types should be skipped
  *
- *  Call a callback function for every name of all available machines.
+ * Call a callback function for every name of all available machines.
  */
 void qtest_cb_for_every_machine(void (*cb)(const char *machine),
                                 bool skip_old_versioned);
-- 
2.43.0


