Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23908C54E58
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 17:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro5By-0002io-Ls; Sat, 23 Mar 2024 13:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5Bx-0002ie-KV
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5Bv-0005sj-W4
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e0ae065d24so2010805ad.1
 for <qemu-devel@nongnu.org>; Sat, 23 Mar 2024 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711214998; x=1711819798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Us6mdyiayZovM9/2dfCRkonLF5Lvb01pKhh21DPA6XE=;
 b=WWeP771HmtPBOZfrw+3K8OeHUgGQK52J5SUqHMELaLtuHu0xeXlOs6KaYqpMb3eD/H
 aJ+0qpS0ZhIs4kFtFwEv89/R7t071L8X4+pX8IsLvDKSw17XighCP4dCQjqVBCxoxAoe
 yb5FBxXl+Vt/qKOXvzwx5LwoWIPwhO8ygZ3+PGxoym2VbsrRdHKtSMKzrI6obRwdyISc
 upO//yZZ7mitLYfY+KLk2SrVfPjdGS8jQ538Xtjp1uXC/dm8v8RMuFQChqAAWbJOWu6b
 Iz3vSwp0syt9oP25sPGfN+x2xoAhQYjiiYSZS+8dhVpGhO89zgfdLvp8EhuaSTrBhQLk
 6aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711214998; x=1711819798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Us6mdyiayZovM9/2dfCRkonLF5Lvb01pKhh21DPA6XE=;
 b=gfizM0QqjbzZGv1fNItgXbYbZRp09+si7G40AoaQUrLLwUtG+O192rSaVdZcsuVFkq
 p1YZrcoSwhTw4nM50p80FgjgLv16TpllYTdfPwQw+hLg4F3ZOjLB9STsOj2dEl/xd8/Y
 cRZVv6UnCv9DKedCla8fXkhcLMfHSxNsW0NtDpsw1hIt5DpGwV5/6WGg9dqa7jp4o9cG
 vrHkz6d0gsVeEexSEgZxhrUr9nbaVIit2Ec0lTqwApS2xFlPjBtKoPtfzOildOKQjq8T
 iiPHJzqQz0iJpi6oeYzdRmFeKnXCm4twCG26pAGGNBWzpgVQ4/d33Lh9zj5N9v1AFRSx
 y3qQ==
X-Gm-Message-State: AOJu0YxyOP/Qa6kPAmxq0FXOsUuAfCCQTrDdrmiOe3hjT/PYNTluNtlh
 5ZUTw00bNGYueJjzgI0qx03rhtnVaZFvAWvvj03GVtxygg9428Is7osPRaDbDbo2rsWbkarReuK
 h
X-Google-Smtp-Source: AGHT+IEnY9LaWv/q4yGCFFMiZ5IyCYN3K3BS/HOTLz7cXXHT44rHOFLxXHM/mAH1gVdcWsMfzNoD4g==
X-Received: by 2002:a17:902:e945:b0:1dd:e114:1216 with SMTP id
 b5-20020a170902e94500b001dde1141216mr3627939pll.30.1711214998312; 
 Sat, 23 Mar 2024 10:29:58 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm1811758plc.104.2024.03.23.10.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Mar 2024 10:29:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org,
	deller@gmx.de
Subject: [PATCH for-9.0 v2 0/7] target/hppa: more small fixes
Date: Sat, 23 Mar 2024 07:29:47 -1000
Message-Id: <20240323172954.1041480-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Two new fixes for -icount assertion failures wrt
not setting can_do_io properly.  With these I can
boot Linux with -icount shift=auto enabled.


r~


Richard Henderson (5):
  target/hppa: Fix BE,L set of sr0
  target/hppa: Fix B,GATE for wide mode
  target/hppa: Mark interval timer write as io
  target/hppa: Tidy read of interval timer
  target/hppa: Fix EIRR, EIEM versus icount

Sven Schnelle (2):
  target/hppa: Handle unit conditions for wide mode
  target/hppa: Fix ADD/SUB trap on overflow for narrow mode

 target/hppa/helper.h     |  1 -
 target/hppa/int_helper.c | 14 ++++-------
 target/hppa/translate.c  | 52 ++++++++++++++++++++++++++++++++--------
 3 files changed, 46 insertions(+), 21 deletions(-)

-- 
2.34.1


