Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43837E937EA
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxIH-0006XV-2M; Sun, 12 Apr 2026 12:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHz-0006Rr-SQ
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:04:03 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHx-0004XQ-Hr
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:59 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4232323a7daso1944765fac.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009831; x=1776614631;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Io57xFIzSdjFwvyqCc7fTyL68avblP79bNQWneISrX4=;
 b=HO9PNJVXnPUzckYCX9g/rEKFB3zmWKYvgkV+/wfvd51vFSPQvNaippBQZmgivlPjLK
 WAeEEGWdgf8E9zy6PVN4h2wvFkEuI2qIVZrGWYHNyfdeUzOD9RHp3U/HLH78H44exXXo
 uJb5mw0E1RsDPlv6Am5bs597My9QXIccugcld2zOL260Z88LNU/DRdcncFPUweoCBfmn
 vK09ecd77eGQpYGck65iqLFBycbFSQnts4P+NfvB8yxgkz5EExlKzLv3tt1ePfcMq60K
 F/rATNfzCYcasiZtrIlnz24p1L+9KPwNcRHEfbFeibSA0GE1MbKOU6BPjlCbGvCa2ieg
 lwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009831; x=1776614631;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Io57xFIzSdjFwvyqCc7fTyL68avblP79bNQWneISrX4=;
 b=DP1PO+FqKnwXL0bb9bGmdvbAYavfyERN3HoDxYTlyQu7e4XK9Cj9/HEiNpkQkIPDCV
 Ra6mWW7NUnciAOHHtVv19oKnqeq+zcH9GUwbYV6VgETNt+f8s7/h4td13O7G5VFMxHdI
 hoVYMmQU95lhYOSwrIY/5mDvyrzEJMiOHi2hf8VLrBo5zU+fbDheGtsE0aO74+AlxpHL
 ZwQdM53uwB5WUzv3hSmQhIdkSruZpw0W4qdb+/NpzpIchw3o6Ipp8qRNFEUZA1RSatOB
 l6jY06BZTZpjiCAZksKwSbDjdjvmf/xrgT2+wltpgDdYZFe2J5u4Uxy8/2RJMIYkKl8T
 mw9A==
X-Gm-Message-State: AOJu0YyLfeRfcGdvJBMR9vL3KWSxIExOc65ZLM7ZtAh/rmDHLSk/rLfF
 05YLZFeUvUn4osdXE8ZrCpOM3TQzikdwOLkwFE4QmSsi0B9CpePyJHKi6DDfKKb/kT4fbuHloUM
 /c4iwNA4=
X-Gm-Gg: AeBDietKBSOyDgdcXUGRVhDH24ODtwlgPGD6ExIqBntaOmAdSDWlgEp8PeNR2Uz7A86
 p/snbnTAkdtPgj/OSCJN8snSQPhYRxAQpu10D4WegTkvciAX3fMKUtlqtb0gYsSvWRJryltEy9X
 sYnqTNg1fuNeI7wbI71iX7Y40zSryC0se+OnEdq5umjRuEG48Fx68naJ6wjQsAbFdzc0rbKGZea
 hC24qtqjmHYWhbFlrskK9f0kdGzKIc5eBCWh6COudrMSt9bJppJBHt5VplXmJoBTRoz38gbXKkr
 ds0HMwCC1SY8vgACM/wWdBrAxcHWHY/qtc34d5ZEyT3Vljyu8BWtdcAv9w9zsom7Br8D1RDNXT1
 h8MAQhe6Pf9H/RiGTpK16GJXX7rxl3/OZxbyECztt3pAj94z/CRsVL6UHJeGZdSegfZgl5r1lvH
 p5akKYDJ7IwA==
X-Received: by 2002:a05:6871:3407:b0:417:1c55:151a with SMTP id
 586e51a60fabf-423e112f407mr5428879fac.41.1776009831558; 
 Sun, 12 Apr 2026 09:03:51 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:50 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:37 -0600
Subject: [PATCH 14/17] bsd-user: Add target_to_host_sockaddr_in6 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-14-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=gptYB3Ta+ssbSfFtE/iXz28A9edNGVvJaAH+IXwJ/LE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IgnE8U07juUgtWJ3fcT7HqqL+8eYYRs0U/E
 cTtNkEBEwCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCIAAKCRBsHNEofbAR
 AGB+D/0fbcovsVhyrYefs4XTgEGYmqCV6Z0NBfKypwUy6apZArAxFjP2KUXgIxeG56+/xWGS7Zl
 t5m9HKHvnjTovLgW4Nq+GIO7fycxhArL//xx2aiQOYEooXSH6jEs3hNYmULCblXW7NFbYgXgh0z
 rX8QnH/WZUnL+LMW9cVurQ4wBPoXaGUM401qFw/xoGER287D75jQK+OdeX25GZFDKVevs8AnW6m
 p08u8Et15r26LaBd76npGs3WV8opH5kMIk+yuiwhr+LrGNOU4hiNmZWTW886qLMFqe3zvwlnOuN
 1LBmGZddP7ATXayWdTcDdX+Z5p4cFl5KhLFKBLBniTaL6MMhhnMYf637H7g0c728XRsRPYyGm4L
 7lUZfBKpiEmWQgPay1qJkZGPJSa8tEi/41TqwoAD0PJMItvfRIIZrKzSLB7rwdj2Ne+p3l2FOz+
 LFks144ja6ZouZJ1GeonybzirtMMHeWxPtXTGxIeKwW3c5AMn00gdXR6CAJ1hITXtAWhXJbcrT1
 5P0FXnrIXE80jlZUhEq1/khnwOWARpdJNurtSWhKoz/akFbFdoZroeEvrJm5is0rj6R25Z4X94p
 3ZQY2qKo/UqAiXWaNIrb1NdSWQYLxi8riEQO4r7kH05QujH4UBkJyVKKkrpog1Vh0Fyqyg6M27D
 dSswtaD4dMYymwg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2e;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add helper function to convert target IPv6 socket address structure
to host format, handling all sockaddr_in6 fields including address,
port, flow info, and scope ID.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 41f310c734..2ff37a0817 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -251,3 +251,14 @@ static abi_long do_ioctl_unsupported(__unused const IOCTLEntry *ie,
 {
     return -TARGET_ENXIO;
 }
+
+static void target_to_host_sockaddr_in6(struct sockaddr_in6 *hsa_in6,
+        struct target_sockaddr_in6 *tsa_in6)
+{
+    __get_user(hsa_in6->sin6_len, &tsa_in6->sin6_len);
+    __get_user(hsa_in6->sin6_family, &tsa_in6->sin6_family);
+    __get_user(hsa_in6->sin6_port, &tsa_in6->sin6_port);
+    __get_user(hsa_in6->sin6_flowinfo, &tsa_in6->sin6_flowinfo);
+    memcpy(&hsa_in6->sin6_addr, &tsa_in6->sin6_addr, 16);
+    __get_user(hsa_in6->sin6_scope_id, &tsa_in6->sin6_scope_id);
+}

-- 
2.52.0


