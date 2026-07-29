Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AF9C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpBAN-000631-8p; Wed, 29 Jul 2026 16:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randy.schifflin@gmail.com>)
 id 1wpBAL-00062k-VU
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:46:14 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randy.schifflin@gmail.com>)
 id 1wpBAK-0001vr-D8
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:46:13 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so811159a12.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 13:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785357971; x=1785962771; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uoACnHuMFxN01HY8s+53i8QmVq1IN/T+I4dTLUIYYx8=;
 b=NmPLajDUzsEPSXM52dSbbziSRTgBzI4VBjhqt2wTpw7c9V7HKp2xU5dmO8umswZgdK
 4RoZ0DA2gExIYeVFKL7CBALJgR1nP9nj9v9efu5Ltwf49VO+Vjnwn2GvTWNY2/mM3lcm
 +1TQlZ0hB+tKKMs47SfdvMPPyXBt7PucUtfPKZ9S8yCsi4kbOZZIgTjicIiMB2LcOPqc
 ZOvjkaPjsj2LMGjhP1IbdkaDg72R5kd4AgxuzmVSa0cAyB0xl15xLlUTjhOL/SXDbNdH
 8r+Wox3+rs+nr02lsrkzYOopaDUeGObfyKYZZzPQGj8tlIJPg8zqyskvSR/W26j+yJfV
 dkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785357971; x=1785962771;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uoACnHuMFxN01HY8s+53i8QmVq1IN/T+I4dTLUIYYx8=;
 b=YYIsEy8BxUOdDTH2Z14AkCsfREqxkT0mxMuOB2e2S/cXhb+SdCzGY6EzT8QfAiP2JG
 cxdZFx6g88r4Sm7g1i7B6uRhzwdt9lZ/0gIHi8qqsJ5lcWvqkJePszmf5CCcrC3EZUMA
 dnXMoDruvQYcd920l0ZyDY4T9NCY7OWMBYB1yhk9cf/DteoenVqD11aPQjO/HS7Rt94Y
 cUBrCdbxTxppZct8aF/yO5WCwGp5c8PpZ8D/IrYrKk4rdCa99dwExqgWc56labw7bxgc
 spsHuY8t0FV33Sid/AWfg0CMtANxE2kWk9GIuEIAfN5AlTO2U6bACADLlQWS4ymzcsbz
 R7hQ==
X-Gm-Message-State: AOJu0Yw1hWf+Ya/rQejphEaNvmuPv9DNBVnQ3zizx9uljLxgpatK+2R3
 7xC1pZ60Dyozk4Pwijw9vzaZBdkm7BGgOqry+cqBL7Vfx8TW3M81bSO5
X-Gm-Gg: AR+sD10U1xs4MCPFcAkJyoFuEXeKdvlwEdLojJLyHcRVQ0xfs4wNm0l1NmQFymOpJrN
 OLj4NewHkL4ML1hyoBK0Iu5jF20E4hTlCZ4PN7KmCDfmm1GjrVEvPh/vQIoFMg6IO969MQQcx7Y
 iK1WJ2I9zMrUDRTFgY2St9azT4ouN66jXZHo1PQpj9TsMyql74+cNJHgeYbNd2kXHLx+QSu3uyQ
 pyGbjrCnsqa8p9LybAJECbHd804lhwBNgqT3py24Kx82stXhMwup9/w+izpzUXgZgifd0Z2xXyt
 FUNQ2NF8kywDAOjYFhseZXW194IcMnqO+z0o/WXR5K95p3/e2M1eJ0RyCJX/5m7VdF/YHLBBfdJ
 691CFWP7eojUwPqj9eWtfRVWPrCC6J8570yM1Sy5e18sWSNredN44kIi2lFVpErWBXEuElVRmlE
 1MMlgGChkb+RFykRGwgbrsyUKE6f7JhpHvyhzEaLD53s7ip3SbqMPINovB4CCdUwudkaJxRXk=
X-Received: by 2002:a05:6a21:486:b0:3c6:3c5b:f2e1 with SMTP id
 adf61e73a8af0-3c8ba4b37a4mr9809718637.32.1785357970509; 
 Wed, 29 Jul 2026 13:46:10 -0700 (PDT)
Received: from devone.local ([2600:8801:100:1910:66a:cb3f:f6a7:d5f0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b88e12sm13032389eec.11.2026.07.29.13.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 13:46:09 -0700 (PDT)
From: Randy Schifflin <randy.schifflin@gmail.com>
Subject: [PATCH v2 0/2] Fixup TCG for SH-4 FPU instructions fipr and ftrv
Date: Wed, 29 Jul 2026 13:45:04 -0700
Message-Id: <20260729-fixup-sh4-tcg-fpu-instructions-b4-v2-0-2c1c0fe04672@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFBmamoC/5WNyw6CMBBFf4XM2jGlLTW48j8MC+gDJpFHOoVoC
 P9u5Q9cnpvcc3ZgH8kz3Isdot+IaZ4yyEsBdmin3iO5zCCFNMLIGgO91wV50Jhsj2FZkSZOcbU
 pPxk7jbVR1rXBKdUFyJ4l+nw6G88m80Cc5vg5k1v5W/+xbyUK1KoynRJVqG/lox9bel3tPEJzH
 McXKZEpjNIAAAA=
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-trivial@nongnu.org, 
 Randy Schifflin <randy.schifflin@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1785357969; l=1667;
 i=randy.schifflin@gmail.com; s=id_rsa; h=from:subject:message-id;
 bh=yZKHFa23mNbAEUEKZHQ6pnP+lZxiJbShDwWeY8g4LXw=;
 b=U1NIU0lHAAAAAQAAAZcAAAAHc3NoLXJzYQAAAAMBAAEAAAGBALXHj1ozDvr3TmWcPoueK1kIy
 Q3yQ7HL5bbiu8J+P0QBzcchmw5nwN0avQmreXhYuMhz40g0dhCJPnJqNHg1FBflQPz2cgY7Utm3
 9lQrK/CQqWsjRwXMinMR7LrmtMFp9+up7MzdXoxmTLgPsKJ/dQmx0rUHx++mUSl8zl7lHO50YVD
 hsw1RHrkrXlxnUjRi+jtjgErRHvoRwSZpKc44yR62wV8chkTMnHtrn8hgL0Hh+jhHteNn4JTQB/
 wme8MghhliXR5oh9xirpeLlS9S4TBY3Vdk6ccgvncSS4uF/y2ZAAV5sNiLZ97OFkBhIQ0bXhVx9
 w1LPMkho650Iu9da5/0koNheHS2KAVC2FdPTyaxvqeFAsAB8fCprfh4lpShdcVpyChdd2KXFS53
 s9MAUQmZjG0pQvS/dqGCCDWqo7cY3J3VTMXwVtdzYkgZt5eMajL7z8VljXQ08ZgAStdizC/rHNg
 wy+fIL+6kgxvL/NhJwoiAWhC4D+xQY7SXjJGTvwAAAAZwYXRhdHQAAAAAAAAABnNoYTUxMgAAAZ
 QAAAAMcnNhLXNoYTItNTEyAAABgHxMsr/v/10IrtSN1214o0LP68YJSeF6n2JnjNf6pHSxD56oF
 iGMTLEgKfDSLker0ehRHiOByP6AEoptEnmz9uNgGjEsMStaFpRA0rSDVbGNuvCJvk10TTSrSbIY
 GLbDr+W/T5AhjVjP179ToUajA1gnx68QD5Zo2nP9VepqoIVXgTLXvsCg+Hw2u5Dyd5KhNquG+Ph
 lO1yx9egH2vZ3q0tzX+8uhiIbcXOB5dpQBLCL8TeZAV4k0ihjt3xGX6IvQXJIEF3l1GqwSWSW2g
 mkMvFzuTECP+FXvV34P9JDC1Ihq+XtjHFdvMp3pV5Bqn/zPtQRBfz7ZZwto99B5TuEzluzwqVVK
 gizX+3Altd4XUufliEPH4pxCOLDPavWes3mid7iDqZC8XjOFDvnrAsHqV+pg24U4IZSPu0HhHn3
 sdX/MmqR5nTGqrKx3z4LiHFMWH24HOGEseW8A27i25pIXeZ9Tv2R5z1mjF4YQFppIRjhxiEywrX
 M7jE+ot+ex5keAQ==
X-Developer-Key: i=randy.schifflin@gmail.com; a=openssh;
 fpr=SHA256:7gww1tlDoVPb7symWGdTNhRWcHyTORA23OcjS8eyd8Y
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=randy.schifflin@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

SH-4 manual for reference: 
https://0x04.net/~mwk/doc/sh/e602156_sh4.pdf

There are two issues with the current TCG code generation
for the `fipr` and `ftrv` instructions. Firstly, they incorrectly
check that the PR flag of the FPSCR register is high. The manual
states these instructions are only defined when that flag is 0.
Secondly, they take as operands a vector index 0-3, but treat
them as offsets into the floating point register list. Vectors
span four floating point registers, and thus each index needs to be
multiplied by 4 to translate to the correct register offset.

This PR adds simple TCG tests for the `fipr` and `ftrv` instructions,
and fixes the issues above by ensuring the PR flag of FPSCR is 0 and
properly translating the vector index operand to its register offset.

Signed-off-by: Randy Schifflin <randy.schifflin@gmail.com>
---
Changes in v2:
- Lint test-fpu-fipr.c and test-fpu-ftrv.c to conform with style guide
- Link to v1: https://lore.kernel.org/qemu-devel/20260629-fixup-sh4-tcg-fpu-instructions-b4-v1-0-4356b305f971@gmail.com

---
Randy Schifflin (2):
      target/sh4: add tests for sh4 fipr and ftrv instructions
      Fixes TCG generation for sh4 `fipr` and `ftrv` instructions.

 tests/tcg/sh4/Makefile.target |   7 +++
 tests/tcg/sh4/test-fpu-fipr.c |  72 ++++++++++++++++++++++++++++
 tests/tcg/sh4/test-fpu-ftrv.c | 108 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
---
base-commit: e1705a25aff35635c360bbaba4c2731d019a422a
change-id: 20260629-fixup-sh4-tcg-fpu-instructions-b4-963cdafd33bf

Best regards,
-- 
Randy Schifflin <randy.schifflin@gmail.com>


