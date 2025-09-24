Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F066CCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 02:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ev7-0002zR-PO; Tue, 23 Sep 2025 22:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ev4-0002yg-M1
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:07:47 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Euy-0002bl-UU
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:07:46 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-33082c95fd0so5526639a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 19:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758679658; x=1759284458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7IKE+UgQbwjYQbDe2+KyzEk5pzBNRctV0JxsiSB+t8k=;
 b=oTXtpkF1E02n8JUChjAt5yvnrzvFeGnk6n47K9Gtq48CZx94BumTa7c2XhYtp5bWt8
 BWcPEhXIupCNUQELSg5wTBkA5KIaP8E5XgRj3V+ejoo/LChYNwwAGC3T0A9vUI0Y06t+
 8CWy6IacNaeNlJqWm2PoyoTMWlsn8tDC9CaY22JwVxxpKhxHcUcahB8OPQs7M1ziLB4n
 H+j31hLxjU8Uz1HMd3P/ZUMaGUjK2RV/fmNblvmCm3x9l+X0WDsf+NssMP0x0xUWWdZd
 UHgsqLivz3tSm0Yn62/Rk5Ik2QLa2FiGrXivDK5eSUR1l7zyj9xi3l0Sz5IcuIYx61v3
 oMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758679658; x=1759284458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7IKE+UgQbwjYQbDe2+KyzEk5pzBNRctV0JxsiSB+t8k=;
 b=SxDaqeZYODv/I+IHCyOQ0f1OFRSyMJnxlWNHRlm2mC9h9nT+r1F+QM3zeF87R1DdoG
 wy/P33SEnanaaqErgET+pYYbq/IpyITXEdmYSrRRdngq+gZkXfdu6VwJU/4ZJR4cXTJy
 3banSz5JgOdKvpaFqF6Q2hglYS+h1xKUNbnUFM5PU6gHH/kOBr/ctQktUedF3p8pa/oY
 RNcRJgHuNX7eYA4+Bcb0ptvrnQ5GtGELEHSMpYpDBwlDANcpm2EDI/RBeURgXD5mU0BU
 ZnJ/gif6hTeUoxDPPQ4W0ZhtIoCfN3jL0VMGsonounk7ljHo7K5HxzIyuvh47l+Qx0D6
 eIrw==
X-Gm-Message-State: AOJu0Yz7xBgyvE6rKw+LKA1BMyFByxmv2wSX3dWhrcLJJg/LRX3Aj2ck
 TK0L6veo+yj8eTK44QiPK9WYZgRBujMZPu8YA1191zVTXXrBz2kiczQEhjOvEp9C+8daoWxkgdS
 e0SGH
X-Gm-Gg: ASbGnctnWUXazzuzyskYaextNuvkKCipEGkuIvF6ZWJQA5JRijDn+4/m0fDYzIF+bcx
 kSvliiFMJXCw5oatMyCOb3jHXpsq3J47xYm/s4uMXvvcvAxJopO9RkguHq/iY1HUV7n+0xMybCg
 vKVMKE5PbxitHMM4MYKkeBSan8cMo8/CL90qah9bHG8YjrHrFrdmP78Dc6+gvgUBx4Q08TGoFPv
 VsimVtF5nF327MEjAMf9ppfD3Qt4Q3R0z3SEwu+c3VO/Zi4iW1RGhOTz54BgzNbPUOl2mg4QrQE
 2O5etIxVSilX3dq6o0E5ConB/xwPLgT3ynwmXE+X18fRRyCP3UjZxJcxi9T5cp3PUKAz6Jp6uqu
 pNSXhru3CdAegU5o5spXiuPwuKfMM
X-Google-Smtp-Source: AGHT+IETp7MYBMMtep3JPMkKQGqbDDd3nbla7SPamxZJp4xjxc5r/649ECZZMqyVdtfx7Ua9mwSE+g==
X-Received: by 2002:a17:90b:54cb:b0:32e:9f1e:4ee4 with SMTP id
 98e67ed59e1d1-332a95bbde0mr5494377a91.17.1758679658083; 
 Tue, 23 Sep 2025 19:07:38 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341bcd9afbsm565664a91.0.2025.09.23.19.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 19:07:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jonwilson030981@googlemail.com
Subject: [PATCH 0/2] linux-user: Support MADV_DONTDUMP, MADV_DODUMP
Date: Tue, 23 Sep 2025 19:07:32 -0700
Message-ID: <20250924020735.3909216-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

This is a refresh of

  20250506173423.1312788-1-jonwilson030981@gmail.com
  [PATCH v4] Support madvise(MADV_DONTDUMP) when creating core \
  dumps for qemu-user

using my suggestion of expanding the interface of page_set_flags.


r~


Jon Wilson (1):
  linux-user: Support MADV_DONTDUMP, MADV_DODUMP

Richard Henderson (1):
  accel/tcg: Add clear_flags argument to page_set_flags

 bsd-user/bsd-mem.h             |   7 +-
 include/exec/page-protection.h |  21 +++---
 include/user/page-protection.h |   9 ++-
 target/arm/cpu.h               |   1 -
 accel/tcg/user-exec.c          | 114 +++++++++------------------------
 bsd-user/mmap.c                |   6 +-
 linux-user/arm/elfload.c       |   2 +-
 linux-user/elfload.c           |   4 +-
 linux-user/hppa/elfload.c      |   2 +-
 linux-user/mmap.c              |  38 +++++++----
 linux-user/x86_64/elfload.c    |   2 +-
 11 files changed, 85 insertions(+), 121 deletions(-)

-- 
2.43.0


