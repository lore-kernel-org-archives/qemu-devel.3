Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FD8D6E2CA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIo3-0003wO-4J; Thu, 18 Dec 2025 13:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWImw-0003mM-Nl
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:48 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWImv-0007Kr-6b
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:46 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5942b58ac81so840803e87.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766082702; x=1766687502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6BGntqKFd1qeOs3HM5pbsy2UgQ8QcXcof4/Fo0gSHZc=;
 b=CL6nTjhaziDRxLZQ/CLw5VJSyY77Rpt7HTA9q3nwjqIUAtYAwvrli/QPWb1eiPsZtS
 STTgvebtpjHiejgd+TkRqBbFZxJvUfAWHNiw5rJOeLckF/uG49FUDQXxOT0Q8IKrCivC
 yl4AWkFSFULY0JsXbcDRvhBIVXqQWGVU+8ZIzf16fHkVBnYNN3FY97b54LTKXifW6tfb
 Oqt5PVHcFWx/W2N85nSV5FqmDFCeNmHXz4SdH3jyzOkHy3VBh1PcezvdPjsn+tK7M5sl
 cAaqWtu0xwJCLjHA4+39VAognK+wtWw14VvoJhZfr1+PYshJfmq34u/dpOf1iSdFhDhW
 UkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766082702; x=1766687502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BGntqKFd1qeOs3HM5pbsy2UgQ8QcXcof4/Fo0gSHZc=;
 b=oWVBfY1MKVKzVdJPSFisveSsvOhxRPR0oTFyAEDFHf3tUoWXyA1Yd8njHhnSYJkxAD
 ZbiGTGX3b6BIR3uY68sQPpmTBKpIWqLXyxMihjdfbI0yH/G0UvKSSSTX6PDmQyhohVAJ
 sA7uE9huR/uNYw+zav1E6BZNwJ4El7V/NvI0FwoXAiLYN7HBJD0M7BpGGZGHDIJNaHG6
 k/8GA7jHNKJnjQvvPM0DvuXlGONx3vS62YFn3ItlSkLf8FlF7vMxK1gRcAOXn9Wz7tKB
 Pn16bJxlNLfH1gfdG03Q47RMKKYmFfgST2bO1fCsbldG7bUjqp+oewP8vLAPes5cpAf3
 TLTQ==
X-Gm-Message-State: AOJu0Yy/9OpHH7lkAkCy6vMP7aVBGSYrOAaV8te5jHrUndQkwH0eyZwr
 70x1LxfDknqMkerBEjBDTPH5P0vKASTPg3lGeB5kAO7kQCCZlprWLmoSmUuzh1N3
X-Gm-Gg: AY/fxX75YOF8zeL5fxFLypRZAs+XKJXaz+wTIwv0GWB8IkF0JIa+ivdWIfG2izu75s6
 bJ9l+VLfqy1ZocmReCgmvQRaCovj135566hh1vid56HEk8Apwa28dK6fzgTWbQYH/nxLLVdmp1L
 CKjcqAlwnHfVta0fMqMWudz7kLtnLxmKWhDpVoDQBBjxrzCyfjbheGZVux8VpWZQSI3spMNLVIP
 ZUTtNrGgT1KdW98w6ccIKaUf+GvjjIzFhWRsCRgoMpbysbci+AbK0hla1koTrR/2m8+h+dwa8oZ
 w221RHlVlhbawB0UdFi7fXZ+Abw5nhj73OFiVi5Shjgh6UaeYo710ySGYvqOQcBnP0kSBqAw9l1
 chJsIGOt+HiAPb0Lq9S4a6p70CUP3OcUMvNnV0bnFKRP9GdppQH9zpNkwM2fxT4vMwg/TYf/HGi
 i4OTETyt4+iLxk0JVongXFcxA=
X-Google-Smtp-Source: AGHT+IGO87ou0IurjacOsA/i4cw51esYBqOTJ4iYrYLeEzL+gw+xUmDzWW6LorMhGLqO0C18UApQTA==
X-Received: by 2002:a05:6512:4020:b0:594:2e9b:f28f with SMTP id
 2adb3069b0e04-59a17d7203amr177885e87.7.1766082702028; 
 Thu, 18 Dec 2025 10:31:42 -0800 (PST)
Received: from NB-8855.Dlink ([81.201.19.27]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59a185dd229sm46777e87.22.2025.12.18.10.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 10:31:41 -0800 (PST)
From: Aleksandr Sergeev <sergeev0xef@gmail.com>
To: qemu-devel@nongnu.org
Cc: halip0503@gmail.com,
	Aleksandr Sergeev <sergeev0xef@gmail.com>
Subject: [RFC PATCH 0/6] More extendable PMU subsystem.
Date: Thu, 18 Dec 2025 21:31:15 +0300
Message-ID: <20251218183122.408690-1-sergeev0xef@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=sergeev0xef@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:32:42 -0500
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

Currently, the pmu implementation consists of two parts:
the first part is mcycle & minstret registers (let's call them "builtin events")
and the second part is mhpmcounters.

The builtin events are supported well,
including implementation of inhibiting, filtering, etc.

But the implementation of mhpmcounters has few problems:
1. Non-builtin events are vendor-specific.
   The vendor, who wants to implement them (including filtering, interrupts, etc),
   has to write exactly the same code
   as which is already written for mcycle & minstret events.
2. To implement custom events vendor must
   hardcode it right inside the general methods.
   So if there are two different vendors with
   their own events, they would write their code
   right beside each other, making the code
   harder to support.
   Also some collisions may occur in event indexes,
   as it is a global enum.
3. SBI events hardcoded right inside the general code.
   As they are not a part of RISCV specification,
   it should be up to vendor to implement them or not.

To solve these problems, let's:
1. Generalize code, handling builtin events & mhpmcounters the same way.
   So if some vendors want to get logic of builtin events,
   it would take minimum affort.
2. Add special callbacks for custom events. So when vendors want
   custom events for their machine, they would not have to
   change the common code.
3. SBI events are now implemented for virt machine only as a demo
   of how a new pmu subsystem works.

Aleksandr Sergeev (6):
  target/riscv: Refactor counter index calculation.
  target/riscv: Reimplement Smcdeleg/Ssccfg via read_*, write_* methods
  target/riscv: Get rid of hardcoded SBI events.
  target/riscv: Rearrange custom hpm counter api
  target/riscv: Add PMU events implementation for `virt`
  target/riscv/machine: Add smcntrpmf registers to VMStateDescription

 hw/misc/Kconfig            |   3 +
 hw/misc/meson.build        |   1 +
 hw/misc/virt_pmu.c         | 142 ++++++++
 hw/riscv/Kconfig           |   1 +
 hw/riscv/virt.c            |   4 +-
 include/hw/misc/virt_pmu.h |  91 +++++
 target/riscv/cpu.c         |   8 +
 target/riscv/cpu.h         |  96 +++--
 target/riscv/cpu_bits.h    |   4 +
 target/riscv/cpu_helper.c  |  34 +-
 target/riscv/csr.c         | 470 ++++++++----------------
 target/riscv/machine.c     |  11 +-
 target/riscv/pmu.c         | 708 ++++++++++++++-----------------------
 target/riscv/pmu.h         |  26 +-
 14 files changed, 769 insertions(+), 830 deletions(-)
 create mode 100644 hw/misc/virt_pmu.c
 create mode 100644 include/hw/misc/virt_pmu.h

-- 
2.51.0


