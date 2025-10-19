Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A7BCCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 18:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAY99-0005BF-QO; Sun, 19 Oct 2025 14:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY93-00058Y-Mt
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY90-0000Z9-Lu
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-273a0aeed57so58839995ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760898516; x=1761503316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XtJrLacd5eTKoBcY36r3Knxdl1/OLp4kb841lhmrzXk=;
 b=dZEoywNWmnpj2zMLCABIGxbyvyn9OCtng2Nro79l3XqZ/cQHFm0BexEzu546nXasej
 D3gQn/Fs0A9zI8+hbwmH7cIXdSbq1eE1zhVmjKyrc1icuvzbJiwKVZ07ttdPxhwKM6oQ
 7X6yAb9K1ifmlgyIAXTBCNszgXgYwpmCzBqSPB6vfB3qDuV+C7233WEjQB3kDpJBWB2Z
 mvRqNEChv/Hr3l/H5RZrcFbH8g7za0g6moMUgG9no7qsEO+QsdSfWMGmI7Y7hR240dWm
 nNlzVGSg7vrcFMR5PkxXE+nBqK2q+MECOlpIFn+j8b4Xou20tLkeU/jZEglBt0MS3Q19
 tHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760898516; x=1761503316;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XtJrLacd5eTKoBcY36r3Knxdl1/OLp4kb841lhmrzXk=;
 b=AWtrb9u9WvHUuLW4rTLawkEmJXlZg4eWM/9hHLM46Oa33DhVFP+8oR5yFA2pRiuWcp
 KjKmMFi8vzQDG8pjY8zT3K9JCFuLnncn+b3KnL8TNwV+F46MdzzZ6TeVdzdhHUU1LTcU
 dS1buZxksb9/Ski7R9SyWnQiNl3aSH4U+ESmiGihStdUGMKxszPRcWHad+eYNWnLEMeL
 iiMIcuiQznT6VdBlJS3lxjrEBUD2eLPPSW8SZFysRUWJNLn+tnzc6RH6ZYSfwY0x3iRz
 M+hubDSeERStq14LHBR61snvudsbZxTaSleQ3U0gsxKk/IY+6ALjzBMTLZLk/YuSe+jk
 lePA==
X-Gm-Message-State: AOJu0Yy/wfTFH69k0dxx4Ag2P5banYoRuvdqSBXn+9WmUTPIXy2WIWgJ
 CN5WfK3iM4VTE6xTul/n9ZatE8pRD9E6IIokPkmrCS9Abxed1ehYczLGU7wp9+ofcZKYLe0PSzH
 x2r/FTGc=
X-Gm-Gg: ASbGncsv86b5B7JBqBgVhRlJGdKeHiGi6QV7GCfUFZpmV9JVnu4whDUPsQ1HV/xUe9q
 x1JWMtWNpIPAqFAXt98HnGBu43CIrHxqfUI6LaNARizhr/zzhfDpM6oXQUXgfzgRTyQbUNP4eYp
 jhEungGKOu9fRSq9+SFkFwqLozZFlP6zpLtv7441gEoX7yRBKvddyUcHBLaEkkz8DRZkX/w9rAy
 c7QXCG6z1fscqESVnjtyIGRaKc411JYfqXBq7cXPE7XmFugM76hPle7nfWdBqhe33bWLuGEnSwB
 dk6xhsO2bZLrFxG89OkpMxRAi9KIglHEOYq/ww4hLy4Cw7iVXOzQqRs7ID+Ovd/bd1L7NqX6wU5
 0WJn23ocPO6MhsE5fbrkLFSS0tEvL6iQxQ35RpkgnoudNA/17kaROwkvbMlO70gwgONvfVRkKpp
 14Czsj9jP8M4YYSsIe
X-Google-Smtp-Source: AGHT+IFsyOpmEUM6b+VXDNsqah6EdEBTdsAtEtya/TmARMV5WOncG93us3NT0q4Dp1YfT9jWHjPgFA==
X-Received: by 2002:a17:902:f541:b0:292:9ac7:2608 with SMTP id
 d9443c01a7336-2929ac72697mr14585445ad.8.1760898515755; 
 Sun, 19 Oct 2025 11:28:35 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebccf3sm58985775ad.1.2025.10.19.11.28.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 11:28:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] tcg patch queue
Date: Sun, 19 Oct 2025 11:28:25 -0700
Message-ID: <20251019182834.481541-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

The following changes since commit 18f6f30b0089b470f3e737637a86dfb81ebd6eae:

  Merge tag 'pull-request-2025-10-16' of https://gitlab.com/thuth/qemu into staging (2025-10-16 12:27:12 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20251019

for you to fetch changes up to 5c1ec5a1ee0958068a532ac1e06cc6cee0c75ba3:

  tcg/ppc: Remove support for 32-bit hosts (2025-10-19 11:24:34 -0700)

----------------------------------------------------------------
tcg: Remove support for 32-bit mips/ppc hosts

----------------------------------------------------------------
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
 .gitlab-ci.d/crossbuilds.yml             |  14 --
 common-user/host/mips/safe-syscall.inc.S |  35 ---
 configure                                |  26 +-
 docs/about/deprecated.rst                |  13 +-
 docs/about/removed-features.rst          |   6 +
 meson.build                              |   2 -
 tcg/mips/tcg-target.c.inc                | 331 ++++----------------------
 tcg/ppc/tcg-target.c.inc                 | 391 ++++++-------------------------
 16 files changed, 154 insertions(+), 714 deletions(-)

