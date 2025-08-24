Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA3ECA0EFC
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 20:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqHAn-0006uZ-1O; Sun, 24 Aug 2025 16:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqHAk-0006uC-Q5
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 16:18:38 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqHAj-0003P0-AW
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 16:18:38 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-55f3edab4c7so900296e87.3
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756066714; x=1756671514; darn=nongnu.org;
 h=user-agent:content-transfer-encoding:content-disposition
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nE/G1UwnDof+/6DkHCCbZG4s0ledIKupaR6wMag/0bs=;
 b=JCAZd0S36sCO1dDIVHLEDHs0NzYoAnqM/+0fSsgnX8cmRxSxe3AVyuEJUl0vpsCFx0
 HxoO1iYB/CHTrF9tf4WRdGgvmHIC51D9xWtlJ3ahrzc84IJQ8T+BvOejnQbHvQNRmItP
 NPdOPMQNofGG/KDPiQCdNXV6dQdUQHs/97+vnOLXLNt0h0vuRPm9n5nj7s2FDvhZ6H3g
 iMrcAponMJCCMAEr39YXhqZ/inSJiolOYgPkItsSTj3U6erZRvWRa+6hGE2RT/PgZnQa
 fZuUbFwUJ+pIhhsHwUZUCZFmlGs7MSeWJM8ZKXn3ZASLUF7+MqlmhDoHr6Xo8l2yMF7X
 Lcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756066714; x=1756671514;
 h=user-agent:content-transfer-encoding:content-disposition
 :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nE/G1UwnDof+/6DkHCCbZG4s0ledIKupaR6wMag/0bs=;
 b=Mg4Xeb3++2czma6BSceT6UhuZbigueA1WydjTU7CRxHD+xd4q0lSm9DBGy6jarCWRD
 CiVNnpJ/kjPYKi3kyq8bW6Dfj0fzwgwJmj2PRsF677idaKbuuTFfK9nlhuZr0wWvhcgc
 DbK5Dh2gD2oegl+9E91Yvd3cg/G5mI71PEcF4H9syG/GVsTXXH8YtjPDLH0y08c7lh/P
 krNV511avz6jdBOQiShBPwRY5qxyPSZBmUA/5GzxfnGAWQeyVGN3IsxFJMe03iydPPe1
 fx3COF/u6UtYr9reCoxM7/UuMVk6p4aPazNn8BHv8wTJo+75/vECa2G/TdWST5iDYHW9
 WLdA==
X-Gm-Message-State: AOJu0YyI/v6ZB3bLMfavgqjEwZRQyYHjCYlrbC8KveYqW56NEzvIaCcw
 1ILYW/9EJivKBW5BhMRXFPV8XjJ09sAa4v3lF+QIfTG2N2ubXWjMbS43
X-Gm-Gg: ASbGncu5+6R1w03CynnMryptYvxqEIRL5dI4cyN43dyTep23ycw5yTEZuNO1TdElPtB
 W7Kgs5mGLV2GtP2N3VHe+mX0xTkPGLrrh8nJLv8gxiZUYLT4FVAC04wKff0qUlNncTIRtSX0Tal
 uy3iBcU1slXg59y+CFxon3MrcFeX+c8lC/Ofd5SjfgECk2sBqf8ZqvQfeazfHVZKrQM66LbJvtI
 ouUR9VhhdBa4Wy/8vqU8F0EX5mv7YcBXeaERHPhT59nU7ghE9XMlrB/zQl50wy6h/gy55kULcUB
 5nb4fqA4xyn4fu6vPLVptIO/nL8n+ETQnyIJqXG28iZHGGCHvL6fVveRIwa3AmcKldIX2Sq2ntz
 PZ1UT7JUWiNTpBSXLp98JY9hMAz4wS6lfUEuCTRbRTg/vKTIxBzbXEREzTxdnXtLdMo5dctPefH
 3EEyr1
X-Google-Smtp-Source: AGHT+IHoRKgmp0jxHwUxJA9isBoCNuiybhFC0wY0pcHko44hnLiwkfJd6odHUdes6vLA8gFiSk2a1Q==
X-Received: by 2002:a05:6512:1405:b0:55f:44b8:1eea with SMTP id
 2adb3069b0e04-55f44b8245amr338475e87.18.1756066713885; 
 Sun, 24 Aug 2025 13:18:33 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35bfcb09sm1228719e87.23.2025.08.24.13.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 13:18:33 -0700 (PDT)
Date: Sun, 24 Aug 2025 22:18:32 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: philmd@linaro.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Subject: microblazeel-linux-user regression
Message-ID: <aKtzmNHYSFwf2TQI@zapote>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x136.google.com
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

Hi Phil,

While trying microblazeel-linux-user on the master branch I hit this:

$ qemu-microblazeel ctest
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault (core dumped)

Bisect found this commit:
415aae543edad19eda8f66955dde386c7fd7c680 is the first bad commit
commit 415aae543edad19eda8f66955dde386c7fd7c680
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Tue Sep 24 23:45:54 2024 +0200

    target/microblaze: Consider endianness while translating code
    
    Consider the CPU ENDI bit, swap instructions when the CPU
    endianness doesn't match the binary one.
    
    Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
    Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
    Message-Id: <20241105130431.22564-17-philmd@linaro.org>

 target/microblaze/cpu.h       | 7 +++++++
 target/microblaze/translate.c | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)
bisect found first bad commit


It looks like we're getting the endianness wrong in this case.

This works:
qemu-microblazeel -cpu microblaze,little-endian=on ctest

Was this intended while moving towards single binary?

If yes, I wonder if we also should change the default to little-endian.
Big-endian MB is discontinued from newer Microblaze versions.
I'd rather have to type -cpu microblaze,little-endian=off for big-endian.

Cheers,
Edgar

