Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D27C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEw6-00085R-Ap; Fri, 25 Jul 2025 05:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufEvt-0007uN-BY
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:41:42 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufEvr-0006N4-4t
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:41:41 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60c4521ae2cso3468317a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753436497; x=1754041297; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0UFH0U9J42hJqVY9BwnRayelwThvtCZGW+7aPdEGwJY=;
 b=TiXIrz0Dd08xaWbsZ82VuBX7hvqtWcWh2lEce9WfZenkkmTFbfyc2Ez7/TuhagXI0F
 kb4fNSStEf34+fSAcnsdRR1RqoXrv8K1hgFrrcpvfCUutxqj+BTQDuwWRPMl72y4iux2
 msU2dhVwwAASDz8JcQhkgGkcNzlxThvMofA7P2tzcgX4a0iur5YeNZuHSIYR5RNmJi7p
 SYYnLY3nAmvFwSrkUu3Mcz/YoBkw9o6DpfSjIRrX6qaDx5fLd7RoQ1m6VRz9g/PLQsbC
 1hYCr4IdMZV87A+yeA7Z6P2+7CUdYAV+1h2yOTdrwgPUPA48MjhjPuwlxkZGf2lhV1iz
 9Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753436497; x=1754041297;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0UFH0U9J42hJqVY9BwnRayelwThvtCZGW+7aPdEGwJY=;
 b=WRkRlB26EV+qlNfU4W1/ojp16g4TdyYA2QzN4ydWGNUM4cTT2rDfyms/nS8i6+4+3y
 KWFd94YBAWAMtxNp9FrRrg3fNiS4RJCUQpnzlUNkP061OMObYzCoYBMDLKosVyLevYiL
 L0vova1uWMBEVF1w7JqesQmZv69303w58ZrtvQd+EzQswc8RzVQ4fGkzebOLVtzfwHUQ
 2U4AAOvDTyafxT3jNywHIacN1wbi5fHuyc/gM+XiytwyINi0cx2KKe92g24SCl9EWI8Z
 jPMHraBJ/EmnHN63KMe4QKRIsLCHsFLnai+tY2733CZM9ENT5/8T6Qwptl0Ohg9hHvuI
 4atA==
X-Gm-Message-State: AOJu0YygMCtp2hVNp8Vk8LYc85Tqj/7RvMI37iS9AFAqMDVKOI8Lua6r
 J/FckYp29joVvoZtRhJCaDv/NHkhOmlmt2BVfF3q/HW33KEq1XEf4Ux1AZhJ2TzQ0byNDHIL/vw
 ABHma
X-Gm-Gg: ASbGncvd4s9cV8UmvCkOMOya6kCgdFcmbR1YWU0NQM3YorzoQ6OLM58B0P5XJd/f2Xf
 lSpxkLc9iVhIinOuKxoQQY5Z7RGiEc8RD4muPCTWN7Zs4ZZUAjirbekXoXW+xjLePEYDZp7hIjA
 KboWLJrmuyAxbiVATd1DfTEUp8iJ11LnhinIwQMTStYxXOSp88agGA1ZHoFs9btRkfg/x/5DQp8
 yuxVOKn8852Sa0JXlBLwNYsqCVtgViShOS1qsrERE26F8LvaAzd/PMovURMP/+FvVrtcAAXnZRZ
 oss2v/fOBSVZ+nNg9aBO3Oxr5MzX7qlMufkW9pEIIaUOZB0kXVVLdNMi+tJPCLfx7l35nSdd/zJ
 qAr/Xp70Dp9YxDJ1rZLD21jwXIaB1GqkIS94P8jjldCJOsx/eN0Ko1JmeVUKvpbUhGfKHngutvD
 ROaA==
X-Google-Smtp-Source: AGHT+IH5L+13QT6j3GYFqxtj0wesQKdgNCyNH+YvW/t3iihDjO+ovbWZsWwYgfArWxgnUrFsvTReaQ==
X-Received: by 2002:a17:907:9404:b0:ae0:35fb:5c83 with SMTP id
 a640c23a62f3a-af618f03c51mr152363866b.28.1753436497075; 
 Fri, 25 Jul 2025 02:41:37 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47ff42fc5sm243280266b.143.2025.07.25.02.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 02:41:36 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v3 0/4] tests/functional: add CLI args
Date: Fri, 25 Jul 2025 12:41:21 +0300
Message-Id: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEFRg2gC/43N3wrCIBiH4VsZHmeoazo76j4ihs4/E0JDnRRj9
 57bUZ1Eh++Pj+dbQNLR6QTOzQKiLi654Gu0hwaMk/BWQ6dqA4JIhxim0Mx+zPVI3IesU06D0nK
 2g4gWCoFEZ6jkLetABR5RG/fc8eut9uRSDvG1/yp4W/9iC4YYUsFHRfsW91Je7s6LGI4hWrC5h
 Xxa7KdFqnUySHGONaaGfVnrur4BhYLgXREBAAA=
X-Change-ID: 20250716-functional_tests_debug_arg-aa0a5f6b9375
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=doq9BfAZx7ETAExc6LlxvweGer5vZrQy0wjhotqmpcw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9nMUZQTnlvNmlnVGh5dW5ESm80ZGpiak9ZVktCCndQU0dUTVUxQ04yMm9ocmRG
 SWVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUlOUlR3QUt
 DUkIzS2Nkd2YzNEowSjkzRC80c1NXUW41WHNtbC9Mem5nYXk0MGZIN2V4RDIwNXR6Z2dPSFNuaA
 phZVhzMGZuMThEK21QTmhhcTJxV044NFQ0bWh4UmY0MW5zdWhpN1huYjAwL082VTE1b2lXN3Jla
 0J0Vk5SNDRtCkE4cmFjQStwV0Jkd29WWHBIeFZXSUY1aFhUTUdKWlMyK0wyc3BYdGtnaFJNaklR
 blpXbWE0TnNSbGlnL3ZIeHoKSmZMeGhYcDNlR0t5WDMyYW9sOWxVU3VNVG1LVTBvNVRnaUNSM0d
 1Sll2WlFTeXFJaUZwZ01YSFozaDZHQjdPVgowSHdSWW1yaTVRdG9MeHI4aGIrYkppc21JSGNDRz
 ZuTlZMY0FuTmNhM2ZXMjBMWVZRclJEUlVWcXpyK1dubzJnCjhqMmZBOFljaE12elZncDdENHNwW
 HZLV0U0eVRDMTZxbEk2ZEYwQjROOTREeXZBQUdLSHArRlVCRzVuREZnbEsKaWdzdmEwanRWSUVJ
 aTZveWVVdUFEUmZoRWI5dVRIaVFodkkxSTE1WGV5QVhDek9id1hoazRxOGwyMnZJVnNyRQpCRWV
 NTGk4UEVrK2JUNzRzSUdzREVrQjYwVDI4N3lFejNONC9PMnluS1M4UkZueTdXWERrVWVOQ2h6R2
 J5SDhCCkdVbzRDcEFIUnplWEY4WlNORHU5U0JWcWZxLzU0NmxjY3ZmcCtLWUppVGpHRmpHdW9ZU
 G1UMHpVRzZQS1hKbWoKaFpieHVQZURVOW1tZk5SbSt1ak9wMWh3NFJSR0pING9FY1RGUmF1MWFF
 OFJIQTVNRVdsTUtmQWRkckIvWHVzWgpsOWtaTjVHUUxrc3lVZktTRmJtaEIxdVZNNTFTck5lSmp
 od0RlNlMzWW9hSFhhU3R5eDgwRHJSeVpmRmhrNWhZCmhucjArUT09Cj1ST1Z0Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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

This series adds extra CLI args for functional tests, useful for
developers that run test files directly.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v3:
- Merged with other patch series
- Made argument values into class attributes, and parse_args into a
  class method (staticmethod) (suggested by Thomas)
- Link to v2: https://lore.kernel.org/qemu-devel/20250717-functional_tests_debug_arg-v2-1-4f0d991e16f7@linaro.org

Changes in v2:
- Store stdout handler in `self` object (thanks Daniel)
- Deduplicate handler removal code (Daniel)
- Amend commit description to mention PYTHONPATH (thanks Alex)
- Link to v1: https://lore.kernel.org/qemu-devel/20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org

---
Manos Pitsidianakis (4):
      tests/functional: add --debug CLI arg
      tests/functional: add --keep-scratch CLI arg
      tests/functional: add --list-tests CLI arg
      tests/functional: add -k TEST_NAME_PATTERN CLI arg

 docs/devel/testing/functional.rst      |   2 +
 tests/functional/qemu_test/testcase.py | 104 ++++++++++++++++++++++++++++++---
 2 files changed, 99 insertions(+), 7 deletions(-)
---
base-commit: 4bc8fb0135ac48cd1c8f0698976b7d73c60b7caa
change-id: 20250716-functional_tests_debug_arg-aa0a5f6b9375

--
γαῖα πυρί μιχθήτω


