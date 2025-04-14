Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEA2C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 03:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4AmR-0001uV-79; Sun, 13 Apr 2025 23:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4AmL-0001tm-U6; Sun, 13 Apr 2025 23:46:38 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4AmJ-0004Ra-MC; Sun, 13 Apr 2025 23:46:37 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22622ddcc35so50324995ad.2; 
 Sun, 13 Apr 2025 20:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744602394; x=1745207194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R2NNkazoZ8sIpa7fdSqzFb4HIvDGaKDFC6Kwdbr649w=;
 b=PBJA2b8TAdafJXig42wamvDXPEaEBPt30b8Eu1AGKK85LTfY2qGCtRa1yw3PeVL5LG
 EUkQO6VAh5Kf7ffLzPBlZS8ethmAGTLh7GduV0ZeMeLVAXXYZ7IHcLs/35yfX++I1Mk8
 fplSxf6PuQi4NjBrOC9BCAImSrKKnc7ehOhap5Q+sAdk/bVoLSwkB8UPdfW9tXarGvpa
 /UV+g0DuGQnngnvpGNN3VGaUlJkdP97PovWAY+QOzAn3pkcm6mrM2rLvvSH4fLrWxZl5
 +KiRDJzMDTRlgFZT+G39uTYz3jpeUFvDcKPlc+C3j6Arf/3VAYynBNg0T2/ZWBeLRmdG
 Vu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744602394; x=1745207194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R2NNkazoZ8sIpa7fdSqzFb4HIvDGaKDFC6Kwdbr649w=;
 b=rFUnBFRpG8/y8kG9TMp5IpfgzSILR+FqTPw6cXg7LYRboKqKYIiMEHCvBGMLBLgISk
 NPZ70bcoqN17y6IrYvbRrg7OaBYwv32DbVyFtnyWdpR9o8dXlJM4hKVhy+wUUTrs/MXV
 HPJcTTIQDt6psd/zRWwUoG1jMMqNLGgJ0N22th0A790/xELG1pBAF1QgEYx7vhMwm/PW
 EhygDwqtxpLlfbit4AdrcitVGzD+yv05r/O+AWTYcFj849EAFUy4tU/wfRCSPUbFR0jv
 zVtbQ+hzXCSP0ZRFDvHMenbPE0PnBbyEKnukK/nDgHvpj2sgdcnwkdgtlMvA1yTYa39d
 q1vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL24l70YpNJCENj7kgclYukRgIIRTO1vTqM76Am0mARRC+GDNRT4nuhmVcArbTXWgpZ86efdLNjUE+EEw=@nongnu.org
X-Gm-Message-State: AOJu0YwUT4PlN5ei+PN3Wp2fBxehynGMX0IOws9/kZ4WUZQt8kRTTMsi
 izsMz3BR7o6OjmrYmFwwgQoPx06Nj6TU18qxTmIu5SE1E61NAWilG+V8JA==
X-Gm-Gg: ASbGncsbFD1/nycknrUoT5PvCgvHYurcmC94GTerbt6etcXfnZV6Ybot4iPqyPLzmhf
 nNugevRgWK8w3o0M+Ban0Dfa6E/2YTdZu3RbhMNXMUCkE1zD4tbZckq04nnRCmlokxQasL7PQmB
 bIro5jL5M62FMHBW3irzkqqbocyae7YnpukFCXfKl3N0svH58hq78qR8rasMoOB/zf7T78I1AqO
 /Y29ZOva4/XE5hcJwWk7S6Sl/MgGYeYHftF0+oot9IuEurLoMrfpDwwSh8L8csaXcEV15AwAkG3
 YiwI4eCWXiN0TdH1h6IaJiOBUlOxdqT5D8taTMnB
X-Google-Smtp-Source: AGHT+IGGlBCQ2qR1QdTJReschbm+jt11XLgnEUSgN4jgn497fkwzgiEpTqrS1FzEnvEVOWF70Y3R3A==
X-Received: by 2002:a17:903:3ba5:b0:21f:52e:939e with SMTP id
 d9443c01a7336-22bea4bcef4mr144109925ad.28.1744602393605; 
 Sun, 13 Apr 2025 20:46:33 -0700 (PDT)
Received: from station.lan ([155.69.190.63]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm10276052a91.12.2025.04.13.20.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 20:46:33 -0700 (PDT)
From: Ziqiao Kong <ziqiaokong@gmail.com>
To: qemu-devel@nongnu.org
Cc: ziqiaokong@gmail.com, qemu-trivial@nongnu.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org
Subject: [PATCH v2 0/1] Fix endless translation loop of riscv
Date: Mon, 14 Apr 2025 11:46:25 +0800
Message-Id: <20250414034626.3491489-1-ziqiaokong@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=ziqiaokong@gmail.com; helo=mail-pl1-x629.google.com
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

Sorry for sending this again as I found previous patch series does not
work on riscv32 due to target_ulong is not le64. Please ignore my
previous v1 patch. Below is the original cover letter to illustrate the
purpose of the patch:

Hello! I'm Ziqiao Kong, the maintainer of Unicorn Engine, a fork of
QEMU. When I port Unicorn Engine to s390x, I notice there is a bug in
the implementation of RISCV MMU. It uses qemu_map_ram_ptr to get a
pointer and reads it directly, instead of bswap or address_space_ldl,
which causes an endless translation loop on big endian systems like
s390x I'm working on. Therefore, a quick fix to this is to call
cpu_to_le64 for cmpxchg as this patch shows.

This patch passes our unit tests and the error is somewhat obvious
(unhandled endianness discrepancy). Therefore, I'm rather confident
that QEMU aslo needs this patch. Given the changes are small and don't
impact most popular little endian platforms, I think this fits into
trivial patches.


Ziqiao Kong (1):
  target/riscv: fix endless translation loop on big endian systems

 target/riscv/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


