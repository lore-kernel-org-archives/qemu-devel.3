Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEF0CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nNK-0004mF-A8; Fri, 17 Oct 2025 12:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNH-0004li-GX
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:15 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNF-0001BV-47
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:15 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7811fa91774so1995141b3a.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760718728; x=1761323528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=t+bkDNmoH15S+lChinfSN+jdgthbTzjws5ZrYryrD6U=;
 b=PYT40OIYPUapUex2Gozdb3Fp4TJDhZu67flw9nT/lLeS1c4nfKB0N/3G8yacvSi2xn
 PNZUr3mjG/wiWWZZgT3fZMkrh3StMATVxnuqH1uPAeXvplFhjH3IT56dzwaBO4o6JShq
 MasH52EYjjtmOPg3DKldOaXjqiqLGi1o7h7jCHcM47RWuLmocWVTUhjJwh7nfLgutV9R
 wX+bMfY1tCHn1gouiuCg1vhxOsK3mPdppG8AOHdqtcXnTPXHLl6CGle9rckmjkUFGyVa
 ZlomGXc2mlam/tO3ymoydh3Gl5fKloa6roOacaNChy/DG6+7aEPmt30QjDOj3vYVM6P7
 oDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760718728; x=1761323528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t+bkDNmoH15S+lChinfSN+jdgthbTzjws5ZrYryrD6U=;
 b=P0wYV9irFJiAJMXUCo9bkQtX6YJ9j4uPa8OKC+LVnZHcg0ysSaJc28JiVIRjS2dKS0
 r6NQeEI5aW20tbFtnam2s214rSUOttfD0s5gmhmhhsDogLu9i0Qe7wmSt8n71gti+Yq7
 N/LytCTlg/PuTs9IwuREWSdQ89HAkXAM+H/WJumQG3oZ4F2Txi4eUaGVmWHrTI0sVMmI
 jaWvUvgnxgHa8Gp2ZX6WrVfGmUElVGTOdlIT+Gr9416ZTYrgLrnQc9miGX62adh1Icht
 X0kgDUz1vLzIvi73pxSOXEImx7OKU8NRrl7DqSRkWBqFmsdkijlDCJgqk3Zu+gi5pPmD
 Xcmw==
X-Gm-Message-State: AOJu0YxjdO36Jxy5p5/ifv5Vp7svims4sCbGR1q4RdqWxV7KW33FU3cQ
 owPyXP+xEX9l/hnH626y6LTJ0nJqs9/ajPshQQWWtqEUAfUJsZ0ky8C5yJ4ew39bYRKL+tiSkAH
 LYOdoZR4=
X-Gm-Gg: ASbGncssY7Zw6EiwdX/pAkSxh+UOl7wcDFpRBMR6WV61VtcbUiPpgiq54j5007ImtSt
 3w4odEE62uti+9NTBfQAHafpgAf4gQhThjf740RC/HtrdC4zBigY7diSsF5FdUjmvXPQKcZGDge
 89D9w4pmwrz4u/enq0jXpmDFDOSX8HGFpiOzNKfXaR0190U6aqUYbM8o0l+FH7cvJRHdGGAKbWq
 4pD7F+sJADd5qWNSAaEQU+nEUIudOX8NczE+JpE8SWOLuHVVGFmWApz/dBM/g7kWYnypLCBhtrz
 wMOBVNNjSNB9kDwH0/NVMO679SCkAYzD5YELnIzZZRmpZz/as7II3MV9oYwhK8N0vTUuOAwNJZy
 iO8uU4PsWHBGPthA/7zZq4W3a5z7gQws90BeR32Z35QeIDR4a589quc2YautmnftxPF9c27E2Bj
 odg5RcaAJStocOgF7I
X-Google-Smtp-Source: AGHT+IEOre9hHvJiko9oSESPPpipCCDt8tCuNm3Y3SSaelM9Pgo8N+svauGv3RjtaaMrjDlGJlxmlA==
X-Received: by 2002:a17:902:e5c2:b0:26d:72f8:8d0a with SMTP id
 d9443c01a7336-290c9c8c7c2mr53593365ad.12.1760718727839; 
 Fri, 17 Oct 2025 09:32:07 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm68667715ad.65.2025.10.17.09.32.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 09:32:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/9] tcg: Remove support for 32-bit mips/ppc hosts
Date: Fri, 17 Oct 2025 09:31:57 -0700
Message-ID: <20251017163206.344542-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

While all 32-bit hosts are deprecated, I have been unable to test
either of these hosts for quite some time.  Let's remove them first.

Changes for v3:
 - Remove more 32-bit code from mips tcg_out_call_int (phil)
 - Remove all reference to dup2_vec from ppc64.
 - Swap order of ppc dead cases removal patch.

Changes for v2:
 - I'm going to leave Phil's docker changes to Alex, since there was
   some issue with build images vs cross-testing images.
 - There was a error in the v1 ppc configure update, a 'fi' not
   removed with its corresponding 'if'.  There
 - Additional cleanups for both mips and ppc64.


r~


Philippe Mathieu-Daudé (7):
  gitlab: Stop cross-testing for 32-bit MIPS hosts
  buildsys: Remove support for 32-bit MIPS hosts
  kvm/mips: Remove support for 32-bit hosts
  tcg/mips: Remove support for O32 and N32 ABIs
  tcg/mips: Remove support for 32-bit hosts
  buildsys: Remove support for 32-bit PPC hosts
  tcg/ppc: Remove support for 32-bit hosts

Richard Henderson (2):
  tcg/mips: Remove ALIAS_PADD, ALIAS_PADDI
  tcg/ppc: Remove dead cases from tcg_target_op_def

 include/qemu/timer.h                     |  13 +-
 tcg/mips/tcg-target-has.h                |   2 -
 tcg/mips/tcg-target-reg-bits.h           |   8 +-
 tcg/ppc/tcg-target-has.h                 |   5 +-
 tcg/ppc/tcg-target-reg-bits.h            |   8 +-
 disas/disas-host.c                       |   4 +-
 util/cacheflush.c                        |   4 +-
 .gitlab-ci.d/container-cross.yml         |   6 -
 .gitlab-ci.d/crossbuilds.yml             |  14 -
 common-user/host/mips/safe-syscall.inc.S |  35 --
 configure                                |  26 +-
 docs/about/deprecated.rst                |  13 +-
 docs/about/removed-features.rst          |   6 +
 meson.build                              |   2 -
 tcg/mips/tcg-target.c.inc                | 331 +++----------------
 tcg/ppc/tcg-target.c.inc                 | 391 +++++------------------
 16 files changed, 154 insertions(+), 714 deletions(-)

-- 
2.43.0


