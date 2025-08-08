Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6789DC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 11:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLJ6-0008G0-B5; Fri, 08 Aug 2025 07:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukLIt-0008Cp-Th
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 07:30:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukLIs-0002xy-33
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 07:30:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so13407345e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754652628; x=1755257428; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lrF3xfwhZvsgde9LRbw3CH8R8zsZFMrB75SHxCEtqMg=;
 b=iWxv3oe9APdM89Ne40hBprArq00NaXlP+kCK2dGI7YG6K/RCA0ANYsPwiVRvjDVSmw
 LD2lbIsodbPhX5PV7yVeuCqEbW0yu1ep1+/ymr574++eusyExb0sDiso08j8OCQx1DQt
 GSKjLyoFqZPGdpK7JrTUcQW8zMKjmNCCHJOEA+fv7LFkaYWpAgOlHVmDzJifmbkgKr3O
 Q7JseVpcOk5lvYd5yomesEDcSqzyp+fCXCUNPGnsLZhrSZrL5gcQqguc3vWvQatoa7ri
 0OYJQeGtgKgP6gb2OrCqRQ1mEwkB9BDsCsQtH1sAdj5F8PB3sucVtNZYECzKwfmbNqsm
 gvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754652628; x=1755257428;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lrF3xfwhZvsgde9LRbw3CH8R8zsZFMrB75SHxCEtqMg=;
 b=DAnJ1ByuMRKIHfYGAOW7G4cd5KPuddQGg5MVxw633a5JM3uMEqANtJI7lXrWHJVtT9
 nLn/KFuZ3FLK5QYk6YazThOafXLXvyF8/YtKmQEvfYHaOFKPhYvTgNlgx0bbKjlyWCAq
 CJpIao7kNn1w54fKvhvy80762/nlE1uQ0OsR4NvNErnxJkVjiSO9vHaPGk4EmvIpC+gI
 nQ/v38om4Er1KJdflwuQGxHB0ysnMriQjcuDFptGsilZL1FiVb9UfLHuzcnojrYfNUyo
 x4STVYA9woegAD05g+mhVHZ+pAfjEBnukBAOB+bYJ9wrbWtO+DDWwYOHIcm6cOBw+rAd
 Z0DA==
X-Gm-Message-State: AOJu0YzSQFkq9jZAqLjQ1beTDjRQRdjjXuultmab4q3V8+FnF6s50CQA
 87Do+MkIHOc1ntEBSOYgj69TT2q9WrxBagYtFAOh0EFKYYVqzkgpO+ng5Gcao+9kyjs=
X-Gm-Gg: ASbGncuNHtt08106S5Exn5j7jmJGi7yCPwgDU/cqznjfFRdA+tPAIIryl52Wrc9aWuy
 edZovo37fyOjlB2ZvORknmgJErWQRil/OX7YH4j9mTnIkJzH3rd87HhRxbCchEHhLJAeYAlCCJl
 P+YupbHiK6CJZDv5n8zsPrGxYfxrEno25XRvYF8hbl3k1+EpmV06eRLK82hSYjioFNUFLFJ9tdH
 R/JKv5+QjW3TIoi+yDjvi+STxzHQ/H9mHgbLIYvG3CWMpn4zLTBTzNSSufbnoe9a4Mwd+GHvigh
 Db91a/REMsxD6crrqgeztM9HRak1QedVeeNihc7fL5wogIvBhT3BPGXXFFcGwEaGEuf5/KT2YIW
 0MOEHXOa2bAAqyAn3s+Z8jK1CjfpsQFuBfEEShzpBZLKIJ5Z+zLitRfYirwDLNjyS8DEj
X-Google-Smtp-Source: AGHT+IHV1Tn6k/k7yY/oBu36czyrL/9lX0OLbBajlno/BZv2QHbqjB7KLle7evdk+fXtmJKgQX1WUg==
X-Received: by 2002:a05:600c:1ca8:b0:458:bc3f:6a72 with SMTP id
 5b1f17b1804b1-459f4f3f38cmr24149625e9.4.1754652627782; 
 Fri, 08 Aug 2025 04:30:27 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440194.home.otenet.gr. [79.129.176.114])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9386sm30034248f8f.18.2025.08.08.04.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 04:30:27 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 0/4] arm: Add PSTATE field registers CurrentEL, NZCV, DAIF,
 SPSel to gdbstub
Date: Fri, 08 Aug 2025 14:30:12 +0300
Message-Id: <20250808-gdbstub-aarch64-pstate-regs-v1-0-14ba70be1b3d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMTflWgC/x3MwQqDMAwA0F+RnBdoRKXbr8gOtc1qLk6SKoL47
 xaP7/JOMFZhg09zgvIuJv+lgl4NxDksmVFSNbSu7Z13HnOarGwThqBxHjpcrYTCqJwN2Q0U6U2
 UfA91WJV/cjz7+L2uG3VOl/ptAAAA
X-Change-ID: 20250808-gdbstub-aarch64-pstate-regs-e061c1911d85
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=PuccmVGBVsrZiT/EprjAfRqCdyHFk1+JbXGERGfIDfg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgprQTBEQUFvQmR5bkhjSDkrQ2RBQnl5WmlBR
 2lWMzlISXA1eDNIZzlEdFl6YThNRmppRDZCbHdOSVU4U0NZemVzCktLMWVNZXFWTzRrQ013UUFB
 UW9BSFJZaEJNeGNHMDVFb0ZiemgzQWRFSGNweDNCL2ZnblFCUUpvbGQvUkFBb0oKRUhjcHgzQi9
 mZ25Rc2prUC9qS0RXK1RWd0xNUGNjZHpndENndG5VcXhEY0NlQzNMb1k0OGF0S0Y1enZMN3A5eA
 o5YXhBSlVBKy9BeWl3eUpweXllOWU1ZzFFSTFQaGxpMDdIdWwwTHZsNHdsamZCSEptaC8vWTA1b
 kdVeGNuVnBSCkkwazZEM1l4MmY4YUFYaElxay9IN09rb3kxN2dnZVBKUXRKVmd3NldWL1VaYkR4
 cTM4MytaeXpDUWRHL3JUS0IKSG42SkRQMzgvYlFRTHQ1ZjNrWWpoK0pUd2xLY1poK25zNHZXMHJ
 0T1RjTzFWcExwN2Vaa1Jna3pFeTUvd1lZUQpObnh3ZEh2YXl5ODUyMHFqVFVUbnZpSTZYTnRPb0
 xkUVBEVWVldnViSTNsdFYwMTJGZCtlZ0NqZkNrT0RPOG9OCkxGSk9abVh5SXJyL1R1U2luVnpmN
 E92eUxKbzJSWm9EblJkcHMwV0ZDSno3ZjBEV0dtZ3ZqUVFzWmQ0WXF5YmIKL1VldTcrelU0WmJs
 aFQ1U0pOSTJ5QWdVYk9YT3A5NU5ZbzRGUHR1RnFvUXlWV3oxMmtGNlpMUFRoRXpqSHliSgpuTTN
 5MHNtc2JDamdGREhsMCt4UFY3SWFsRkxmWkNVT3h4RCtjaGQ2eDU1RFZEd0t6OXdhQWVlaHhhWX
 NrZit2CnIxOG5TeGlQSWx4L3VBQ0dzay9udzlrNE9TZ3ZtZE9QWlNabVc0TjBzM0trdklsYk44N
 WhBdXNpN0VYVk5YWVIKU0FPaDYraUZuUklreUdXWVo2L0pXNnBiOGFMZTRzRVJOaHN5d0dLYzVY
 V21hY014Y3dBVFNtWkNLZ1M0UDVQNgpYemZmWC9Ec0phRmYxODlnYks3OHdBNEliU0hTK0tWelN
 MeGErS1pIa05WODBrSGVkbWpZR0RaUzFGaTUKPTNIR2sKLS0tLS1FTkQgUEdQIE1FU1NBR0UtLS
 0tLQo=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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

Expose PSTATE field registers to gdbstub:

  (gdb) info registers
  <- snip ->
  sp             0x0                 0x0
  pc             0x40000000          0x40000000
  cpsr           0x400003c5          [ SP EL=1 F I A D BTYPE=0 Z ]
  fpsr           0x0                 0
  fpcr           0x0                 0
  vg             0x2                 2
  pauth_dmask    0xffff000000000000  -281474976710656
  pauth_cmask    0xffff000000000000  -281474976710656
  pauth_dmask_high 0xffff000000000000 -281474976710656
  pauth_cmask_high 0xffff000000000000 -281474976710656
  CurrentEL      0x4                 [ EL=1 ]
  NZCV           0x40000000          [ Z ]
  DAIF           0x3c0               [ F I A D ]
  SPSel          0x1                 [ SP ]
  <-snip->

This also would allow plugins to access those registers.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Manos Pitsidianakis (4):
      gdbstub/aarch64: add CurrentEL register
      gdbstub/aarch64: add NZCV register
      gdbstub/aarch64: add DAIF register
      gdbstub/aarch64: add SPSel register

 gdb-xml/aarch64-core.xml | 35 +++++++++++++++++++++++++++++++++++
 target/arm/cpu.h         |  1 +
 target/arm/gdbstub64.c   | 29 +++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
---
base-commit: cd21ee5b27b22ae66c103d36516aa5077881aa3d
change-id: 20250808-gdbstub-aarch64-pstate-regs-e061c1911d85

--
γαῖα πυρί μιχθήτω


