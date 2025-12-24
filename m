Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C3AE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRbU-0000ke-Ll; Wed, 24 Dec 2025 11:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRbS-0000js-Si
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:20:47 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRbO-0002aY-Nk
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:20:45 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so40374795e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593240; x=1767198040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AxhYYJxgmRWmlbk0eh1y7aeHXrMq6gvdF1ljgJj+Qbk=;
 b=CEqFi3yqimnVnsy1g82edllGX5RNvqD4hqibaiznsEf/Iy8UrAnHDUvV8lVR7B3V+r
 3nV3BAkmKm/V1YnB8WkLODtcdxYm6tykhMwaGiiuIrneRqUj+hqijUgFYptLlM0l1/mf
 73lDoKdwEfHnYngNSaW7UPdEAcYrkSdJvMOa+TttnG1QjdSMiMrF3bs8jFgiNCW/TnUt
 rDKHq/BXbvYe2Zenqof2vWAb3W9GyjOVut06FbdfidrwTfZEhoLIq/90gjfBh4HumZjG
 JSo8k08r/5YOlRRWaytFCD9UFaSWbey8QrEjS3YZfDl8DeejcytmxVf1fyZQySK/7MIv
 x+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593240; x=1767198040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxhYYJxgmRWmlbk0eh1y7aeHXrMq6gvdF1ljgJj+Qbk=;
 b=oLPHPqTunKCtz6mocaT7HVMgn2QsjMo/Ux1ZxnLsyusjL9XT9vTcE7WST4bgpP3WoS
 NZ4X0T72MXEFwFqS1m7Sgz2hk4ULOTTNL4KfpnGc2elPwUb+BXu5UFBRcW85U9TGQLJ8
 RUcWskE+ukhPnYcITy1yvOeGx5CW1OOWV714SKwPXh5/J3O/9CYCJW5owSe5FmjCOl4F
 a+dduXC5qYlnHndhqjZ/8j5KFnldlpSE53cTFMBjBxkoz8Ioq20JJb9aecPWeHqAUy/j
 u/uOUaIZaFPpOPS9lnpxOUOxesORjGykAgDTmCtDatW3Yi0f+3OPjKa4s65TdX0693wf
 t/RQ==
X-Gm-Message-State: AOJu0YzbFeg9ZnfxmXu96r2SC1H3iknt0aDxArx5rPt0CbuqS3d6DAEq
 1Ni0HKvHxn/ikLIKf/zT3FR3p15wE3WBWm4WyLDmB00fbYs9CUGt3LnFPVkqU3TmMCDoDDpXCW4
 sNs+cyYU=
X-Gm-Gg: AY/fxX5Ufow5vPd+4BP36SEkCKylAEl0TWPuaCm241P1+M9lUgI/+buQnBmVplOpLH4
 Ta6MIt6IOp/7/ky+3YcfLe3+lmOuep9T2CiQ/PgwB+m3FCIuPJIU/mt4VQYoi4CqXkNaWpGo02u
 94qTUQAD5DdKu+0dPZpdPRfgDcO0usDgaUCaP3cd6PDtI1JAtNA17DkiOnxZG0fcfhqTK+thnEu
 ZbRYxHz2FuMy0rFlbeOBpfOMg4j6NC1r6VLmLbE8IVbkBx7d4bIDwZZ56LeXQBBMQwiTW7J2th6
 cxA/lJIUNFdWx8l9GOGXXvLBlycrvoBwen6+V5HYL8CtpnRV9PyUtfaxI1r2mHbG+NNWnbhpVWs
 etSSxvIZDvMn3enLRhfgr1IHezVD6DxHy6pBqo33p+Gx1WU1fOySzIleEb0P8/MpYTIQpajtx9B
 n7ZZ6+NUnCEbLLvqJKVZImChUv5MlFwKJA6xTob+MQgvuN9RWY9iNrfV8=
X-Google-Smtp-Source: AGHT+IF+OkJK6JEc1VR3EMY/6mv0RO8qYRlEqjOinYo/gife2LvDZdOvWaDfIDjGVi65XAlCFq2CGw==
X-Received: by 2002:a05:600c:45cf:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-47d1954a550mr178878905e9.12.1766593240072; 
 Wed, 24 Dec 2025 08:20:40 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346e48sm294805905e9.2.2025.12.24.08.20.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:20:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] target/s390x: Use explicit big-endian LD/ST API
Date: Wed, 24 Dec 2025 17:20:27 +0100
Message-ID: <20251224162036.90404-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

S390x is big-endian. Use the explicit 'big'
endianness instead of the 'native' one.
Forbid further uses of legacy APIs.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_s390x-v1
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (8):
  hw/s390x: Use explicit big-endian LD/ST API
  target/s390x: Use explicit big-endian LD/ST API
  target/s390x: Replace gdb_get_regl() -> gdb_get_reg64()
  target/s390x: Replace MO_TE -> MO_BE
  target/s390x: Inline cpu_ld{uw,l}_code() calls in EX opcode helper
  target/s390x: Use big-endian variant of cpu_ld/st_data*()
  target/s390x: Inline translator_lduw() and translator_ldl()
  configs/targets: Forbid S390x to use legacy native endianness APIs

 configs/targets/s390x-linux-user.mak |   1 +
 configs/targets/s390x-softmmu.mak    |   1 +
 target/s390x/tcg/insn-data.h.inc     |  54 +++++-----
 hw/s390x/css.c                       |  24 ++---
 hw/s390x/s390-pci-bus.c              |   4 +-
 hw/s390x/virtio-ccw.c                |  24 ++---
 target/s390x/cpu-system.c            |   2 +-
 target/s390x/gdbstub.c               |  26 ++---
 target/s390x/kvm/kvm.c               |   8 +-
 target/s390x/mmu_helper.c            |   3 +-
 target/s390x/tcg/excp_helper.c       |  16 +--
 target/s390x/tcg/mem_helper.c        |  71 +++++++------
 target/s390x/tcg/translate.c         | 144 +++++++++++++--------------
 target/s390x/tcg/vec_helper.c        |   8 +-
 target/s390x/tcg/translate_vx.c.inc  |  38 +++----
 15 files changed, 215 insertions(+), 209 deletions(-)

-- 
2.52.0


