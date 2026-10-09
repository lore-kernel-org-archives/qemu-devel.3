Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C4CCA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBHz-0003YI-00; Fri, 09 Oct 2026 10:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1xFBGX-0003R1-DE
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:08:13 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1xFBGQ-0007xl-W8
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:08:00 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-3a76ac0bdafso14877801fa.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791554877; x=1792159677; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=levx75WN6oYiwS6hj9C4hjIr5S0ppJDSoXgWvKXinPM=;
 b=AJyDsyy3fmoBt24qY/XOekK3/W5rAwU/S12xhlkehgrA+Ptb73fHGCHxvD28AyuUQn
 4hnF6zdKDe906cq1x/i34VkDjohJ+vuMC8bRm3gS1Mp4pfft5YSPSqfBb6xDwmLcL/wx
 XzkXvqZklhbaVBrqoFuaWUo7SuNRYPoQLLj3c+TE8V7hdHkkBoIx5CoE8GGhBTJBOCaq
 Z6CEI0Og3GggRSSJd5iszFo5O1i9/p+lNgNolminrb+uWt//Elang3QQ10+3TAOkNitA
 9caLEF44DXCkdiX0gIZ13JV6sigoSdvLrkUfFvWxNyb+6nkyH1uWoa80gWMOBee9dFxQ
 tSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791554877; x=1792159677;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=levx75WN6oYiwS6hj9C4hjIr5S0ppJDSoXgWvKXinPM=;
 b=yhHHKIGTxA6D6UtkZ25UjSa2hjciby3iGjT7OSfdUnIo3NQKCKChjeENu1YYHxZ9g5
 Rrx9FPPQyXYUgVgs80xkwxRpih+wwS5XL7VrbzVtgkoAjTd+Gyv0R5rioi/4MACngPz3
 EUyl2ctorPu4AssOBGq+yqj18gRo/+xGOKJ98POVU8Khjjr9BPRdrb6PCZ+pPSBjNSSp
 UcKT1ojpQzmmTcg0+OMHdeVWXqnfDD06oCZovTNPy/+725MaLdrl95BMpScdnGWT7EKr
 dToOcV1sC/MCV4n/TZfLRjGUg2EkXedOunB3PPv4dGO9FjlYGky6nWzz3jQzJy2txrHb
 5YSg==
X-Gm-Message-State: AFq9FYIduC46kmojGZ5SBVh45YcDXdX25Yuq4qsu+tz6rgWNCGdHV3SS
 yaqM4Ce3s3ahYriBEcQWjBrzqyQfDt8jKS3xUtgNI5E8ozNgyiW1GZTqCMFi2ERIDZM=
X-Gm-Gg: AYBFou2IENWRSvbMJNUUEy53ji3t7NaWGGm1PLu7PvYbWwSF2xGzQYBPOknfUdywxQg
 mdilwcBkNgzZqB7eD16K1uRyvWo9+NtbD7WcCVME4y/N8xKarBXqGrq8vqiS8xv3S5LDWD1Zaj/
 79Oo6e+5HfRZ6+oGgxqo4dQKuoJD7kNX9Ysc0Q0VfjjL12S7tGKx1gwBHaXh3U/V5q3KIcpdOul
 Kho+9pq9YHI8/bA2xN6VIMEh8sUWABPke8GZXGY2dPm8eVSPM4jK7q69ZR1eFbXmIBZXzfQsJ+o
 e0G/iq6EraN14AG6orNIQMawovtEfRcD5gr1NTUddTyw407+VLKj49AqPCY4JqUuDSkip+DBXn8
 I+IzNgoz5KNzb7PB+NSBPuBqZON+aysnOcULgCc9tRqlWubzem1LtFQWsB0o38Y/RVDbt/IzBdt
 6aF7QvfKtvupjKPkcg7QlVxzBjR4vaPeTvXqWzm21JmQ07reC8whvN/pEYiRTKT+tUqvWZAEkGT
 Ofo3Q8evigwYHkzgPJJ0o/uwKHveZQ/YciTqQ==
X-Received: by 2002:a2e:a99e:0:b0:3a9:a2fd:595a with SMTP id
 38308e7fff4ca-3a9c5398e41mr4643251fa.3.1791554876266; 
 Fri, 09 Oct 2026 07:07:56 -0700 (PDT)
Received: from localhost (broadband-5-228-114-10.ip.moscow.rt.ru.
 [5.228.114.10]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cd783csm7080471fa.32.2026.10.09.07.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:07:55 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Subject: [PATCH 0/6] hw/riscv, target/riscv: implement initial N-Trace
 filtering
Date: Fri, 09 Oct 2026 17:03:01 +0300
Message-Id: <20261009-upstream-ntrace_filter-v1-0-8f061c9b24da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABX0yGoC/yXMQQrCMBBG4auUWRtIKxX1KiJlTP/UEY1lJhWh9
 O6Ndvkt3pvJoAKjczWT4iMm71RQ7yoKd04DnPTF1PjmUHt/ctNoWcEvl7JyQBflmaEuHOE57rn
 tI1OJR0WU7398uW626fZAyL8bLcsKq9EzCXoAAAA=
X-Change-ID: 20261009-upstream-ntrace_filter-c8e0af3a5dfa
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Alexei Filippov <halip0503@gmail.com>, 
 Grigoriy Bereznyakov <gregoriy93.gb@gmail.com>, 
 Konstantin Semichastnov <antikostya2@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=YJTlnAgkpsWdT+kLqCjSf8/cCsRq5r+Wbmivauv4+/g=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqyPQW7SatB8ctJgQ9UzE4G04S0q+atCWuODe8x
 79GA2mY9ZeJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCasj0FgAKCRBIiqVupVDe
 dsMFD/9djZPCGZkF8ubyan3i5taRWXKTuvYGfbjHR5Lkdc872t9uRxHK0UDTLE00ryrjGGogEu3
 xIG0rB0pdrbEjKxwOxY+mxw1CXAZtARg6xDLrOFBQ41c4T174lQZb/i9anBNOosmQJyeEuM/bL/
 RgZiDaOOKeDLWQyxGoLu/K/+e1DvN08KttDeVmIowyoX1qUorWMtKSPR4h6CyubrZ4uHf2qg499
 CIn3x/udpRciYpjD+OXgzIaMZgaBNWn9h0xhDB3pVjwK0TkJgJkZTF/EYKK5sr8aHlBsB66o8bl
 JEPWyMy5EhWNEVkX2B90H70tCVQMc64znL3P7y+zhdCj8+zFy9kXOmVGlmBUBJEBFVjkuHyaedl
 Umy9js9u1Pn7MhlfnZnAYyUE1d1ki7MzxSvI/3sskGxC8oSjvXRgzMGs6XUjER65lYfUkNesQqm
 KltKEtZ+HgOvlKHYbEqrMNUGB/b6sIHvTFqCdO/WGVnahza6VNbZ1VNyUqIyxA72MXnOjqPxp6D
 Xfl8w+1rjm23rGsvQppz8IlXwgGZwZ2X1xHHs6dJimRELO/GToZBqp1JBGu6PNUTWAAlXd9J2ir
 c8BV+6/iKDMuU4PI47+cIxi8nBRxvlZCqoQbBr79d3y3Zv3lAiu3zEuQDilMlSqwT8oM34bjU/0
 tBFrAcIlYEfZYIw==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=antikostya2@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
This work implements initial instruction N-trace filtering from
RISC-V N-Trace (Nexus-based Trace) [1] and
RISC-V Trace Control Interface Specification [2]

This is the third patchset of several upcoming patchset series,
that will ultimately provide full support for N-Trace HTM tracing.

Patches based on N-Trace messages patchset [3],
which provides support for basic N-Trace messages.

[1] https://docs.riscv.org/reference/nexus-trace/_attachments/RISC-V-N-Trace.pdf
[2] https://docs.riscv.org/reference/trace-control-interface/_attachments/RISC-V-Trace-Control-Interface.pdf
[3] https://lore.kernel.org/qemu-devel/20260918-upstream-ntrace_msg-v1-0-16a56ad8e0ef@gmail.com/

Based-on: <20260918-upstream-ntrace_msg-v1-0-16a56ad8e0ef@gmail.com>

---
Konstantin Semichastnov (6):
      hw/riscv/trace-encoder.c: move trace_running setting location
      hw/riscv/trace-encoder.c: encapsulate icnt counting
      hw/riscv/ntrace: do not use gen_updiscon to gen IndirectBranch message
      hw/riscv/trace-encoder.c: add N-trace filtering definitions
      hw/riscv, target/riscv: support initial N-trace filtering
      hw/riscv/trace-encoder.c: emit PTC message when trace started disabled

 hw/riscv/trace-encoder.c                | 475 ++++++++++++++++++++++++++++++--
 hw/riscv/trace-encoder.h                |  63 ++++-
 target/riscv/cpu_helper.c               |   8 +-
 target/riscv/helper.h                   |   1 +
 target/riscv/insn_trans/trans_rvi.c.inc |   1 +
 target/riscv/op_helper.c                |   8 +-
 target/riscv/trace_helper.c             |  34 ++-
 target/riscv/translate.c                |  10 +
 8 files changed, 569 insertions(+), 31 deletions(-)
---
base-commit: 898044eefb4ad0904adca95c325ab7cca772320b
change-id: 20261009-upstream-ntrace_filter-c8e0af3a5dfa

Best regards,
--  
Konstantin Semichastnov <antikostya2@gmail.com>


