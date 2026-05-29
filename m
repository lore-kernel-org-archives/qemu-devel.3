Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F31CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 20:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3rJ-0005bf-CR; Fri, 29 May 2026 16:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT3rH-0005bE-7o
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:31:07 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT3rF-0007fz-5W
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:31:06 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8421fde5583so309601b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780086663; x=1780691463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IplNSkAvsnN9ha21dLx+1ncLate349s2MaU9dIbwYYw=;
 b=H5C7qeCJysWNuXbcoyPT6Oaveg5v51SM00HZpF9OyAGbShOspeAc8/bulTXq1etRc+
 0FKKFkAuiBGZOLtOqT+qe5gkpG/juI/Fi2EyZKT0mG/m66TxMZjVVUFJSIOYQIk0Vylj
 v+Bzh93s1nEaxG39A4kYoPB8P1qjwp7PxkqR3CYd5Gc/XJhgWqWAyU+CAULlsfsv73a+
 OaF37ZDV9DT6iEOJR2lhsGwG6kLb7ePXMsEpxVnFrO/CWr6UYQlluCO1JhKHzXC5BXIW
 FF14QFKdeAKnoLwlQlGrGnYBWpR1/K8jj2TIcmYcB9BxdnjwQuZfVlXwMSYDLJ8ApmFn
 cW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780086663; x=1780691463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IplNSkAvsnN9ha21dLx+1ncLate349s2MaU9dIbwYYw=;
 b=HPehKiSdD8eCVLYJo5db0DqE+lfAkI3QMSEpM3MEpWuO9IlMkPdwcimqtpkqMYRSSV
 zHO5TxuW4llAsqnbap8OQzHqS4apt3lxc5W2wDnE0rFS0p1CYiw7XuMSamAqv3LpGoYs
 Idpd/h7OwXS3n+r0p0qjN6Bw9Xj44bAuTivKZmV3lgBxwSnH4kxwTMGDDUCyc1dGfWym
 pD+Si3hhLIawnwBG+PeU1+vR2bJX4vlkDRySMp9ZZE/w5VWb/b9+u3TKPXR3DKbmv7I8
 DIXIsf5vSSsxB0mFTNZDx+ExxbprOu/9SWVaPSqNYTb+xitsDSayuusr7EQUyDMNqtZ2
 HAHA==
X-Gm-Message-State: AOJu0YyYUkO8b5mgbZqiKbgGY1yi4Xa2xFaYU7IbBhZYPst4oD9IGJ9h
 rCgPd0KHwYkzg0GQEa3WwzNHj482Zy2hhCWuSucd+ZtPFjZigDNE3RdlfXIcDkMdQVQQsmcItuJ
 DTjZNjTA=
X-Gm-Gg: Acq92OGSQIRsCqtAz+nsw4RjgkqeN5waXY0eSxj0AKVxrYWMtubZM7N6ZB1/XEy8rX7
 uIf9s/f5Igsx0J//+ize4qL4QE8sCaPAiEGx2gc4ho7Z+xxihibIEyA+CPm7pKwHGQKGOBUI8v3
 MAfzV0nXgXBuOhqML1ZX8ypcCycZC/cSoTlYa85k5StFUrLY22QshHOn0s4kR2rttaZdYr06lr+
 KzEZW1YNe4/QolUP64IZBjkBNohLgRSanEDk6Bb7zhWxjGFOCHRlw1hLpvsaaDOlhn9M8NXsr9f
 hmv1O0OmNAVyCPu/eTS0KgM/yq4s0rFkRf1JciTJsSicEElsz7QJssQB2VdCFm/hdeemovVDJNK
 J9kHI8b4B8uZnLn+VQGAe4N4Wi8CUBD0LVfP+I5m1nrJm5qdgRZkXd24gD5HLI21DwXTzmCUtuz
 0omJZx/aZ/aepo8h9eYtcW4eP3j56lLxPk32MZMgI=
X-Received: by 2002:a05:6a00:908a:b0:835:cc47:6ff7 with SMTP id
 d2e1a72fcca58-84225736f6emr935976b3a.50.1780086663131; 
 Fri, 29 May 2026 13:31:03 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214b02365sm2720237b3a.8.2026.05.29.13.31.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 13:31:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] tcg patch queue
Date: Fri, 29 May 2026 13:30:58 -0700
Message-ID: <20260529203101.290947-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

The following changes since commit 81cc5f39aa3042e9c0b2ea772b42a2c8b1488e76:

  Merge tag 'pull-target-arm-20260529' of https://gitlab.com/pm215/qemu into staging (2026-05-29 12:58:25 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260529

for you to fetch changes up to c9349965ce4a1548a0b19dc3cf859a461d525f6b:

  tcg: Optimize INDEX_op_mul[us]2 for 0 and 1 (2026-05-29 13:03:58 -0700)

----------------------------------------------------------------
docs/devel/tcg-ops: Fix reStructuredText format
tcg: Optimize INDEX_op_mul[us]2 for 0 and 1

----------------------------------------------------------------
Philippe Mathieu-Daudé (1):
      docs/devel/tcg-ops: Fix reStructuredText format

Richard Henderson (2):
      tcg: Massage fold_multiply2()
      tcg: Optimize INDEX_op_mul[us]2 for 0 and 1

 tcg/optimize.c         | 90 +++++++++++++++++++++++++++++++++-----------------
 docs/devel/tcg-ops.rst | 16 ++++-----
 2 files changed, 67 insertions(+), 39 deletions(-)

