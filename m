Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DD3CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOHu-00073d-MJ; Tue, 02 Sep 2025 06:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utOHJ-0006hU-Qm
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:30:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utOHH-00011k-Nl
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:30:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b8b25296fso14891865e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756809013; x=1757413813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LYXlKG5Wq4COqV6ma/J8dvmYDrSqMFpcmQ0ZICqQhdM=;
 b=icfJvHmfCIYONzqJtaOHLfS7PlonqmZbUZqr5+FMVMMy4nCzT6PEs2LpnUbjzqSBTr
 jbwj3zDf4FOdKxmtiC39QfV4jiBclNd65is8ZFtdWqMSqNHHeFaWZV7+FC0oLeHU3JXh
 l/CbWnhluiCK5KE0O7HG7yUW3c7aSdZkJ+MC3HEDfA//gQ68sHC/3Aj1RJHwLNk7TS5G
 I62W3HdNQ/3rDc0baEi8FRemu7TwqntZlE/GyoV52YyvxFKDpXNDUnUET2+/zLnPpi8N
 io8VUykxR1+bm5LIzoMQrPFH9cj91CE5BzdMq8PtMaQ+raZ0coLw70wlpxQG6Z9qkZrm
 65Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809013; x=1757413813;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LYXlKG5Wq4COqV6ma/J8dvmYDrSqMFpcmQ0ZICqQhdM=;
 b=VmHNMKBwrSLETNM15rsYbfeB/AsQJQaL2T2xXca2g8BORcWcP1LuFGiJQV4MQdFcgk
 vBbo+vdtMXaH8+yVnebvgIrsy5ga7VDEEmkuk5opp/8GKJWSES6Nuw2dLtqFn1x+Aibd
 Tbyo57zYwGvT4v9xOtVa/R9bi+eumvxGgWPdC0QL+XBLHcNV1P7bBJLAkcP7IiKXdRKT
 BwhXRIv0ZWKT5uHoc56rUffKoh+ZMoqKJzvMiCtRJrGxZEwaZZO2vw2hNefLihTixOGf
 MK4lIB/f3emqqFgdrFoMAivmp7lK7B7ksxs9I7CniopTwukv49exaC029x/Ox26m0ujl
 Vv5w==
X-Gm-Message-State: AOJu0YylO62z384k57XmFkTxl/dwBMwsr5CDKD+E1AZFv7bjEkyFnK4O
 AZ42CdTK76U5Kc6JhijsNJ8b1bI5TwjyRbkcPxTZoQEXPzRfFkZ8xTT2vE6FPr8/RkoHAV0wIDd
 WNUUOapk=
X-Gm-Gg: ASbGncsv4wTl6K1qWCdiPA6s45jr0kPIXISllxRhQe8SqzoWRdAV8hX/m1r9QkW2QEZ
 Seth3y3Sw784owIN/NUh3MYGEQ/eKPhd4vzTKSPyLmS4Fml6nI8x+9oJ2DtGEmm6MSggftj3Sqc
 F1AdYBFKJGSsRe6OdJ52nEMMEffn9hiTEXreGMalxqLzV91WTnYTq1B2wVsv14/vNoLaPuvYAhC
 zDJhrlUCZN8wIrlhy2VwgrDwqSX2CrhIKX+UCMF61OZ98Ugbxnrsi1yl6W8iwNlGBcXrrlZ/N0I
 Z9WYwxeIT193DKiJqhs/vp/ao7WtWqBf6VQS1KX+1xuBBpxUHVKNBC5OnydmqrBLJ8gCQJx+b1G
 cbmFoPzmyOqCfi6kxmvhxkEXRfDGsOp15o7I8Ql84iRD2nY0vJSLHSPRF2JZZkAY=
X-Google-Smtp-Source: AGHT+IFK2dyls2du81b/RybcaDViXOqmKWJuVkJSQXdY3A7jJFN80Dg94/BYND6DTYyKXvslg5GhMg==
X-Received: by 2002:a05:600c:1ca4:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-45b8554e2ffmr102509455e9.10.1756809012763; 
 Tue, 02 Sep 2025 03:30:12 -0700 (PDT)
Received: from stoup.. (151-0-205-164.ip282.fastwebnet.it. [151.0.205.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d32a2sm296470665e9.9.2025.09.02.03.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 03:30:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Subject: [RFC 0/4] util: qmessage_context followup
Date: Tue,  2 Sep 2025 12:30:06 +0200
Message-ID: <20250902103010.309094-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Daniel,

I'm still not keen on qmessage_context allocating a string.

If we *did* allocate a string, it should be a GString so that we can
easily append to that.  The only benefit I see from this is that we
would collect all of the output and it would reach stderr atomically.

However, I think it's better to not collect the message and just
output the pieces.  Something like the following.  The names are
horrible and I didn't document the patches well.


r~


Richard Henderson (4):
  util: Introduce LogOutput
  util: Drop QMESSAGE_CONTEXT_SKIP_MONITOR
  util/message: Use LogOutput
  util/error-report: Use LogOutput in vreport

 include/monitor/monitor.h |  4 +++
 include/qemu/log-output.h | 14 ++++++++
 include/qemu/message.h    | 21 +++--------
 monitor/monitor.c         | 54 +++++++++++++++++++++++------
 stubs/error-printf.c      | 11 ++++++
 util/error-report.c       | 73 +++++++++++++++++++--------------------
 util/log.c                | 23 +++++-------
 util/message.c            | 45 ++++++++++--------------
 8 files changed, 139 insertions(+), 106 deletions(-)
 create mode 100644 include/qemu/log-output.h

-- 
2.43.0


