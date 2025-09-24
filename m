Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7F7CAC5AC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 02:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Evc-00037L-Nn; Tue, 23 Sep 2025 22:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Evb-000364-5j
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:08:19 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1EvZ-0002dt-8F
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:08:18 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77c1814ca1dso4822043b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 19:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758679695; x=1759284495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7IKE+UgQbwjYQbDe2+KyzEk5pzBNRctV0JxsiSB+t8k=;
 b=XG0SFd6VykRdW/pPL+gT/hcNfK1Pxg0g0ur3N+NvJu4Yi8MeXo8+9sU3W4q1IzZbCa
 QO48Oa0EXQwxCZJsigCDNYlln7dTNf/tNtOxsoe8468ueRP1asr69cJJahYr8QWQkwur
 pCyDFzwHd9txsd/ZzHHzcsjimzX0JrnzYMvh9YyIyUja7mdCSNTBtM3J0+oVTELQq8HH
 Qlc6vrismruTuM5F/v6ElIlM5VSO746jtsQB+EHsh3op7gGtEp73POuzfEJmjNRfAH6K
 nDDI4Vt/D0NxQDnpw/iQ9cgpXrI0jn9PwW8Ovmw7HpOKMCrIV56gU5A2Je8ZPROUd/k1
 96pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758679695; x=1759284495;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7IKE+UgQbwjYQbDe2+KyzEk5pzBNRctV0JxsiSB+t8k=;
 b=qcb5efhuf/n7N2o/2JPE9l8oscDM/weCAqlELvsUI4T9JMLk9/cJ1LTuGzgYphIGi5
 EHqfGCiFxDQ05GpbtWxgx8lH8Q+8XUMPxnYoias+/ZNlHRBLa+6y97OYiML2ptIOwbqZ
 Sf5t80Wm9r4OPf2PRg4CgkTYamzDBCulQiWXhbj5ZVgGT6cEq8XyjuSbw2e4D9/K33ii
 ovx4F+Z7rhvYU6GR269nLybOvKd9fJqt+C9boAMUowEdsxJ4Pkzz0ZjG8LX6t4ITGMBa
 kBTRGGCGfy3duIloZUjYZfe4tzcj1lXlcVaJUB5dibUm64IHflJ50fFgpiyxL+dAjV20
 FKDA==
X-Gm-Message-State: AOJu0YwIK3NseyeDzKmH72/J3+i9Tx6Lemod/cARHt/0RqtOFx8M2oqh
 kc4jHBqSAdqp0tmcsaGITWw/ZHzvmsk6Xv4JKhM9kjvCCj9lQQZjIc38p4K2U3TmSEpEpSI4NQI
 tt99p
X-Gm-Gg: ASbGncsjICOyZaEBoknfOiu5kZZi8Uw5Xo0FcJLXwQqPLkjtgQY1j3Xs8RIdOv647eI
 U49b3h8zDDSQTCurxNhvU4onv2+U21gxNCJppE09mHgzJWmLgUENddrCThj+jWNVTTjSc2SWO/H
 xUMhGfkxd7L/qgcAevKRpnPvVfIRlnPhc9xKVeK3EW3AlXDDxoKQ2it+35Zma9XU09h/oH1jpID
 4htIvCWU2Uz/Vh2kvZXrSF0KJNvJLsTsgnC9G0fH90zL8xBcU1zZyMhrGkk+8FXOkR2QC451xw/
 7bOdAwus9elbeb2DIx1cFRVXCADKjvPbrT2GhZaFwDra/9O7pivn39bN4/JvEi1+BUPLCTPcEfx
 ki564zQ/0hoLftPa1BU/kkP2Gp9TC
X-Google-Smtp-Source: AGHT+IHzFmhEv/pSx4mK7XX9frXlwNcFSFxIY7ZQvq43xe8+7BXDUCSkLERi+esm2ozv62TP5IHTuA==
X-Received: by 2002:a05:6a20:158c:b0:250:997d:409d with SMTP id
 adf61e73a8af0-2cffede02c7mr6979032637.60.1758679695086; 
 Tue, 23 Sep 2025 19:08:15 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77d8c3adfd4sm15929130b3a.82.2025.09.23.19.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 19:08:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jonwilson030981@googlemail.com
Subject: [RESEND PATCH 0/2] linux-user: Support MADV_DONTDUMP, MADV_DODUMP
Date: Tue, 23 Sep 2025 19:08:11 -0700
Message-ID: <20250924020813.3909287-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

This is a refresh of

  20250506173423.1312788-1-jonwilson030981@gmail.com
  [PATCH v4] Support madvise(MADV_DONTDUMP) when creating core \
  dumps for qemu-user

using my suggestion of expanding the interface of page_set_flags.


r~


Jon Wilson (1):
  linux-user: Support MADV_DONTDUMP, MADV_DODUMP

Richard Henderson (1):
  accel/tcg: Add clear_flags argument to page_set_flags

 bsd-user/bsd-mem.h             |   7 +-
 include/exec/page-protection.h |  21 +++---
 include/user/page-protection.h |   9 ++-
 target/arm/cpu.h               |   1 -
 accel/tcg/user-exec.c          | 114 +++++++++------------------------
 bsd-user/mmap.c                |   6 +-
 linux-user/arm/elfload.c       |   2 +-
 linux-user/elfload.c           |   4 +-
 linux-user/hppa/elfload.c      |   2 +-
 linux-user/mmap.c              |  38 +++++++----
 linux-user/x86_64/elfload.c    |   2 +-
 11 files changed, 85 insertions(+), 121 deletions(-)

-- 
2.43.0


