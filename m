Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D620ECFB43C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 23:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxEHV-00069I-IS; Sat, 05 Oct 2024 19:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHU-00068a-0L
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:48 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHS-0004Cd-Gs
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:47 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e09fe0a878so2336889a91.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728171224; x=1728776024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/zXeNhXvSBhl/WAbUQ1uv/gU4iJK694UopJPBkP5i8c=;
 b=LSZ7js2Tqbxpkop/uNsQqP2+/qG3BVBzUWSEpitU8ZCmlJIgOGXvBOHDvjGLm4UQJr
 ZiK7xzAA0cuv5FCcIgotIBOvQKeDATGA+FHUxXJ2cTnVSKuWeLwf1o9ZOQY3uPIE1rc9
 jqfOuJUbsfvPyuzKBoabtVpdFRPvthTgH0LL7YJj/63R7V3hpt5n/aYsgCAcuOxQQ7Qb
 CGENxrIsl/TwsqxWFdPr+yz6FEc5rSYO5k9WvJfn3CzQfBkbsDvRd8q8kp+mBzQvQHRi
 Uy7NGGaxQOyHPBc9G26vimZWSjjwICuqqA47yWIatYzQSgJaDSxK3sqJ7VT2M8XUJ9Oh
 eAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728171224; x=1728776024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/zXeNhXvSBhl/WAbUQ1uv/gU4iJK694UopJPBkP5i8c=;
 b=HssmV0d0avnrrL0A1jI9TxxAkE75FmvpvUz/3qK/+0wuqJ+JGs0J1evUD9FDReIN/f
 zpcE7lWyB3T85Lgg3Eb89gOvpbV9eJncJBZIJsxcjySlapR78d4GBsapPZsrEYAAlWQU
 t0k4w5a6WA01EIU6xAHCkUpgd7rPGVtokVtP+Y4bxdHfLTegkSGF67onZ5k0OkimpgeZ
 0wTLkPIa9xVrnQy31XDfyzC7Bhc6mpHigfAhbNZCd3o8rFBmD35ND8LJqiQyQPpeEn1A
 iEnGEKksf/C1fpcPKsdMonwPLhstG+kEm2Ef1voohNTXNV4h1XgHpd3bbzTLIFAvxm6y
 fJLQ==
X-Gm-Message-State: AOJu0Yycx4RWACh8yE+w0X2SyO7Y4e1ZNZFzl/SQ7VSwLe1YD1ghG3il
 JT4137iKM1R0576uHovfAzWJLY0q8XAaTrfv8yFocmr7SBEYdRp2MUGXHNGdhuWBMVX/4o5ZrjD
 v
X-Google-Smtp-Source: AGHT+IHZq/IlTFDjB9fF5QMXR6du4qc4n/Q2mwmd725A0Umfs0GsePPhtFVo/s/8K4layk949Qm6UA==
X-Received: by 2002:a17:90b:1d83:b0:2e0:7571:25c4 with SMTP id
 98e67ed59e1d1-2e1e63c1613mr9168328a91.36.1728171224444; 
 Sat, 05 Oct 2024 16:33:44 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20b129cc2sm2394600a91.51.2024.10.05.16.33.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 16:33:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] linux-user pre-PR
Date: Sat,  5 Oct 2024 16:33:33 -0700
Message-ID: <20241005233343.503426-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_LACKS_WORDS=1.942 autolearn=no autolearn_force=no
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

This collects some patches that I've edited prior to queueing,
and I thought I'd post them before doing the actual PR.


r~


Ilya Leoshkevich (1):
  linux-user: Trace wait4()'s and waitpid()'s wstatus

Michael Vogt (2):
  linux-user: add openat2 support in linux-user
  linux-user: add strace support for openat2

Philippe Mathieu-Daudé (6):
  linux-user/flatload: Take mmap_lock in load_flt_binary()
  linux-user: Correct print_sockaddr() format
  linux-user: Display sockaddr buffer as pointer
  linux-user: Factor print_buf_len() out
  linux-user: Add strace for sendto()
  linux-user: Add strace for recvfrom()

Richard Henderson (1):
  linux-user: Fix parse_elf_properties GNU0_MAGIC check

 linux-user/qemu.h         |   9 +++
 linux-user/syscall_defs.h |  18 +++++
 linux-user/elfload.c      |  12 +--
 linux-user/flatload.c     |   3 +
 linux-user/strace.c       | 163 +++++++++++++++++++++++++++++++++++---
 linux-user/syscall.c      |  99 ++++++++++++++++++++++-
 linux-user/strace.list    |  13 ++-
 meson.build               |   1 +
 8 files changed, 295 insertions(+), 23 deletions(-)

-- 
2.43.0


