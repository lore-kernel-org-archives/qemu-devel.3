Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA2DC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7afL-0006PS-70; Fri, 18 Sep 2026 11:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1x7afC-0006Oe-8c
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:38:11 -0400
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1x7afA-00039t-AO
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:38:10 -0400
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f1801fso960227e87.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789745885; x=1790350685; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FUpD8nPPXBGJwj4TnJqaqM1mwHJehiYlqvMHpoAzlIQ=;
 b=olwgKlG4Np+P3XzabnstxAQPDLAA4cvUE4LCdWHb7IPhc/TwwaYWAIbNEDs1HT6ToP
 f5iXeG8t15FyVEN9BriAhblPYCVvBjRQ3dj7xWkABrwAd8HW2VEVmFGIx9vQJiV7rLgV
 O4Z44gUWfjdWf2vQ9zl1d0nFwtLOHSa4UnHnoNxbHr5+qzpm6GXzpajP6bDxcB660JRE
 MbT/Gmjl1uzwBxEwz+xCRpeloFJx+igGybH4wHfA78PbkloesBoV7qrJHMrXxPzbsvgo
 i7c1cZ0ADZfYJ8bj9+rjQr/32Gn0b4u4Hsdl3s2D945Ml7UeQUa74AjDAH9LYAtSWSUf
 aSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789745885; x=1790350685;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FUpD8nPPXBGJwj4TnJqaqM1mwHJehiYlqvMHpoAzlIQ=;
 b=ApL+ofVxt8L4OuQw8Ombg7ZkaRvlFL+XgNqfqZQ4V2ayNSZxZI9Ts2xE8zBYWan3Mb
 tZm4ZvJq+O/rM4b4oH/LCAd98Q34zl6O5RdZFiRybuu1XT09V+503aXRSz8Jj1UVRqRa
 V4GlPeqdm1kpDMnHHYSuZMX6WFOWAHwVS8MHXs8+8ykX/Tfpqz7qppEK7e/5BWD3yGOy
 03RevsoYOvAnpIy1csGZrNp7sOcsITolfT+a6nF+qyuy1iQaLCej0KEVMbDkda/t8HAj
 Jy4TRntANxjmf099aKEOH4tMFliONc40bbhkh6g4uYwBmp9xKmyBLx+vyKVZ0w+/o97l
 aKVA==
X-Gm-Message-State: AFuF++md42M8vX/X3z9oayJppg/tXdLImT+w3iwHtesk2GJkonv9i0XJ
 nADvH4oAUDnGfbH/l64f4NR94W7x1Vb1v3oXNFZoMO4SZIy2YUEGKHoUvxTEyIr4
X-Gm-Gg: AYBFou1h5QkvJ2/L68clo5bm9/lt/p+uMMUZYI3zE4xvmbpSK4P85pXIw2V+YjyPDYg
 /TWN042+azlwP9Vt6t7XE1ssfpPm20R/jxFbsqWP66/09Xc37dQ6yo4tN3/lSCvS0N8HCHtjqsB
 yBkv1aNnmP9TGfrQ2vwF0/AhOGQeX4hdreLmNTvziQuDcl9RMptjPtS1YrGjWTz1qFzx8FYQcJi
 7mGIcRFYoHxf5iVyLjGpI1BWzoA0I6I4z8Ix8Fw2Y+uhMZsbbCudwoP5k9m5pisdzx0w7N71vwV
 HOzDpnUpcH4pOPCCrDdi76hcT1cnbbNG3O/ywRg+gWxSEq5P303qqJBNvG4SR288XQoUpdmzbCl
 ba9UPpyhsVEoHPAo2bACpMKmMqHxUn7S28/NdzHBlpe3Mm9oiNWXNclin4EfwHaZwbFjpgF3Cw2
 Ue0giBO++xzW7bC/LK83/PAM5otT6h8U053VUUYNECrsMKBuLUjdXddy2a67LVQW1LUswy
X-Received: by 2002:a05:6512:1295:b0:5b6:183b:d211 with SMTP id
 2adb3069b0e04-5b8c1952ce6mr942367e87.56.1789745885176; 
 Fri, 18 Sep 2026 08:38:05 -0700 (PDT)
Received: from localhost ([213.79.119.14]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8c270ea53sm547547e87.12.2026.09.18.08.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:38:04 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Subject: [PATCH 0/6] hw/riscv, target/riscv: implement N-Trace messages
Date: Fri, 18 Sep 2026 18:34:36 +0300
Message-Id: <20260918-upstream-ntrace_msg-v1-0-16a56ad8e0ef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA1arWoC/yXMQQqDMBBG4avIrBswqYj2KqWUmP7qFExlJpaCe
 HdTXX6L91ZSCEPpVqwk+LLyJ2bYS0Fh9HGA4Vc2udLVZeNqs8yaBH4yMYkPeE46mCqguVa27WF
 BuZwFPf+O6/1xWpfujZD+K9q2HZz9DIZ3AAAA
X-Change-ID: 20260826-upstream-ntrace_msg-4ce83419fe1e
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-riscv@nongnu.org, Alexei Filippov <halip0503@gmail.com>, 
 Arseniy Semenov <ar.semenov@outlook.com>, 
 Konstantin Semichastnov <antikostya2@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=YG30fuVRnrQodiTsh696jpPqEgIOiVfpDM+8xfUqhpo=; 
 b=owEBbAKT/ZANAwAKAUiKpW6lUN52AcsmYgBqrVoNPInQXWulW4ro3s3+vJFjLSrxMqLiaJ6gg
 AHeC6hFtPqJAjIEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCaq1aDQAKCRBIiqVupVDe
 djPQD/dB6IHTZoOu7JD8a/EsVAm97Edq4QjPtG5WP3hQiIeJrfraEtoRqnRkwksy9gkNr0oUp1V
 2sEA56A/Ds31ZoDariCeRD+sHztX5XfUvXE9pzylSD63CW5M9UkdT5jXZX5MK46IqXbzrpvCHUy
 EX8pt1yKXD87jvMuVknJbNMrT1qxeTa+KeEYx2hnj1I/Y6aVRd5zr6OweuO8/np9I3R7s5htcEs
 h2NFfgRlaiEPhNYQ4loCQl0h/rRIAcI2spG8mh0DFqFU/PkEJGHrukScBvzDj1hbettgLaCsFxh
 UClwSZLOVADylAFneuhm+Ou6+omjvXJlmpIeKRXvSD4WhOJR2eanm6r5nh/5EwnZrEk92vADmSg
 Nt8+fQ21q4b7ElxaTHT29kzzXXOJkv1IdkiDMEx2qyCgWF4tRVS+hHYedi/k5rL9l9EBUZ+5/Xg
 M8571ID4DOhgkzeJPL97LeKBU9qwVDncyjqwKeMFV3eTEX4S2+3Gy0d013HUzMWj/jRfMKAuoTu
 fSUniobMJYAkI3nXUPan8hyc/YME38d2e9KK63BgmYKPRnliWOcWwPp0btB/tilQ04Jla/YmV7a
 b5n1oVbyfclGu6d2OrkBNCD7azIrJaXWmMdQpsvgxhhBCnyHqbZe7b0fXlDO2JkqSzkPcSd0u5v
 tpcMYGU9/Tbm0
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:36::10;
 envelope-from=antikostya2@gmail.com; helo=mail-lf2-x10.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

This series continues to implement RISC-V N-Trace subsystem.
This work implements Synchronization and Ownership messages from
RISC-V N-Trace (Nexus-based Trace) [1] and
RISC-V Trace Control Interface Specification [2]

This is the second patchset of several upcoming patchset series,
that will ultimately provide full support for N-Trace HTM tracing.

Patches based on N-Trace core patchset [3],
which provides initial support support for N-Trace subsystem.

[1] https://docs.riscv.org/reference/nexus-trace/_attachments/RISC-V-N-Trace.pdf
[2] https://docs.riscv.org/reference/trace-control-interface/_attachments/RISC-V-Trace-Control-Interface.pdf
[3] https://lore.kernel.org/all/20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com

Based-on: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>

---
Konstantin Semichastnov (6):
      hw/riscv/trace-encoder.c: support ACTIVE ENABLE EMPTY of trTeRamControl
      hw/riscv/trace-encoder.c: Support sync messages for N-trace
      hw/riscv/trace-encoder.c: Implement Ownership messages for NTrace
      hw/riscv/ntrace: emit PPCCD and Ownership on priv change
      hw/riscv/trace-encoder: emit Ownership after ProgTraceSync
      hw/riscv/trace-encoder.c: implementated SRC field

 hw/riscv/rv-trace-messages.c   | 114 ++++++++++++++--
 hw/riscv/rv-trace-messages.h   |  23 +++-
 hw/riscv/trace-encoder.c       | 303 +++++++++++++++++++++++++++++++++++++++--
 hw/riscv/trace-encoder.h       |  22 ++-
 hw/riscv/trace-ram-sink.c      |  19 ++-
 target/riscv/cpu_helper.c      |  11 +-
 target/riscv/op_helper.c       |   8 ++
 tests/qtest/riscv-trace-test.c |  45 ++++++
 8 files changed, 502 insertions(+), 43 deletions(-)
---
base-commit: 2684ff8fd5995eaeac86fc08e3e2940fe8cfc6ba
change-id: 20260826-upstream-ntrace_msg-4ce83419fe1e

Best regards,
--  
Konstantin Semichastnov <antikostya2@gmail.com>


