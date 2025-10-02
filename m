Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37744CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4FLz-0005iz-8O; Thu, 02 Oct 2025 05:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FLx-0005ih-K9
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:11:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FLp-0002Qq-7l
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:11:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so3853965e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759396295; x=1760001095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a1oDZtgfQj1AEXLAp/9Jq9EbKylalsDC8EAcrLKgO6U=;
 b=o5/+p6kAPuatxg1PAYN72+tdetFXR5JsRy2UCFUl0UiGm9cynn3DZrxtMbfg/rzkS8
 /D3WtzokZNfRrEIota+Tzg4nBgwr6UmY4meCWTUvF0AmM63J3Dy04vAGiXb1RmUTcgOz
 NUtlxbmhb85vUtXzSRw5BzWdvy+0UWyNdAHnEk83EYzfwHNDBt3WJCbMab2X9UjaweNN
 rwdIASgFiiSpTARE3+dKaheQ4q3Iru/62fTKuaDqdBs1XHkxOsZU4DZBqHW3eJ0+x3YX
 t82S5HooA6pvIxHNTuUwRloOl6DmlWM+PHWJDsyplyECJ2gapSlUNZYEnUlYka6MfxrC
 96fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759396295; x=1760001095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a1oDZtgfQj1AEXLAp/9Jq9EbKylalsDC8EAcrLKgO6U=;
 b=lYjvhKEF5S5XWsnGSSEZDBlI8OnV8uvNFdce9FO8H/7gBESqkDkKAJtOjiNTsiDb1q
 VoAdb8Bp+UbnN+VRioo04pQCntsyskDR5ra+01w60f2X0Jy1IMwazv8lcG8TJsAjFMOb
 TvRnsLsGbPq1wNEs8PvUT8uhdXp1/yQSHvwlaPI1A5+v7gaBqd8cxLQzFvfNHU8kwrX/
 yU4z2G4xuijIPY1v514k/n2QoHahJ6gMhr+phREq5FAboShpUsUog3foFC1u4Qwy8qUm
 Vcl6R82+P7/TN8cCwxGbuQ7JH46K3mLUYLVD5WhzF8ZI4Fksx5IkA7a/UWtKjIUjLysq
 IlEg==
X-Gm-Message-State: AOJu0YxmpohfUQHW7tpZJDkyVG6i38GXgvNjZmqhsd4JhfVQO/TkfqNp
 EYvr2FVd4MW9Ket5uOzkT5w7iFjzAR1X+vSGZySazeE07k3O2nDKB5gN2nhmbKSbBUMvV/jGupN
 bRO4WbKf+RQ==
X-Gm-Gg: ASbGncvXGrJcyS4/2vDV83LoxNHm5en5uv74wMPaCh0UCDhGgpWP+1rWkcDxXZN4yh3
 kXS4ugvG8OQUVE/Qkn88KkqciGAsMH4S3tWrwzZRQZixxreQzy2WzdZp41Txj2TfwYzR4PHCQ6O
 PO269bi0JUbrooD+oi1q4HHqCW55qjQAimpAjBAIx3iUoyYLuxgT7ZFDVhyY27Rn+qZHfwGLet0
 Ga5oSTgsIpI6d+GuMJS+eC0eJMbTs5BlS6wk+bb5ohoRv3tbCFO6gYBzsljWUvB7VeGWnBXvAJ8
 rleUF7tRkVx+hJ8ZtQY0bsrd7ZH8Pft+3zf7uLtv1k1PxlM2D4/Oow9PesVP5tZJxUGX1Kr9C6y
 X6Q0NBUvwd9ZnAPLDp0N10UM9fE7LLcYYeDeD6z65G3AqbxWS6DxEFDhR5hEOxrTwOQjWQymwMJ
 TFNTDJpSr++ispHNYu62qHZxkrP8p3Pw==
X-Google-Smtp-Source: AGHT+IEu19JFLiim7ay5Dt10UOAVNAIS3cr21wQ2bqVpaQlLv+VYd0u2XepJtzPSMDQncsgWALjNPQ==
X-Received: by 2002:a05:600c:19cf:b0:46e:1a60:c995 with SMTP id
 5b1f17b1804b1-46e68ba9850mr19688135e9.2.1759396294675; 
 Thu, 02 Oct 2025 02:11:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c3eca22sm55045305e9.4.2025.10.02.02.11.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 02:11:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] target/s390x: Remove legacy cpu_physical_memory_*() calls
Date: Thu,  2 Oct 2025 11:11:23 +0200
Message-ID: <20251002091132.65703-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The cpu_physical_memory API is legacy (see commit b7ecba0f6f6):

  ``cpu_physical_memory_*``
  ~~~~~~~~~~~~~~~~~~~~~~~~~

  These are convenience functions which are identical to
  ``address_space_*`` but operate specifically on the system address space,
  always pass a ``MEMTXATTRS_UNSPECIFIED`` set of memory attributes and
  ignore whether the memory transaction succeeded or failed.
  For new code they are better avoided:
  ...

This series convert the following methods in target/s390x/:
  - cpu_physical_memory_map()
  - cpu_physical_memory_unmap()
  - cpu_physical_memory_write()
to the address_space_*() equivalent.

Based-on: <20251001175448.18933-1-philmd@linaro.org>

Philippe Mathieu-Daudé (9):
  target/s390x: Factor diag_iplb_write() out
  target/s390x: Factor diag_iplb_read() out
  target/s390x: Replace legacy cpu_physical_memory_read/write() calls
  target/s390x: Replace legacy cpu_physical_memory_[un]map() calls (1/3)
  target/s390x: Propagate CPUS390XState to cpu_unmap_lowcore()
  target/s390x: Replace legacy cpu_physical_memory_[un]map() calls (2/3)
  target/s390x: Reduce s390_store_adtl_status() scope
  target/s390x: Reduce s390_store_status() scope
  target/s390x: Replace legacy cpu_physical_memory_[un]map() calls (3/3)

 target/s390x/s390x-internal.h  |   5 +-
 target/s390x/diag.c            |  55 ++++++++++-----
 target/s390x/helper.c          | 122 +++------------------------------
 target/s390x/sigp.c            | 117 +++++++++++++++++++++++++++++++
 target/s390x/tcg/excp_helper.c |  19 ++---
 target/s390x/tcg/misc_helper.c |   4 +-
 6 files changed, 179 insertions(+), 143 deletions(-)

-- 
2.51.0


