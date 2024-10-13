Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC5BCF2591
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 18:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t03cz-0001ID-Ds; Sun, 13 Oct 2024 14:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t03cx-0001Hb-2b
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 14:47:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t03cv-0002Sm-Ik
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 14:47:38 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c693b68f5so36113385ad.1
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728845255; x=1729450055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FT2FD47rkaLyAzs8B0mZU/dWJ/XoGwgqpz4vaRTUS3U=;
 b=RCQeDDtfFiBDIuL/Y+za3DFjLJlzWyIQRZLFEeEHQD9tffy3AIUAK3/s4QbRgtHYNh
 xXS62unE83iN2VA6iTbhLJAWHjG8AUwqUYYb9yZGjXTeA69ATPH0rrW7EeFdNxwH5c44
 4PQ6o1HK96pQKhe+gcQXRYl8b1OpOLg/3H5rIqtoS5IdFSzHM8YGKY+l2nTaMMKrUBgw
 3XFnwBUgv60tKNrxOIyu2h0VBXcngDCuU2lCPA73nNZOToP9sUtSyfW1LxhC74Ykb2r/
 K4UK5v9Es9ov25Fp/CstzO4pGmOS3aDKwdSK1C7lZgvofy3TuaBg3zMuntP4HPSD5I8M
 hRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728845255; x=1729450055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FT2FD47rkaLyAzs8B0mZU/dWJ/XoGwgqpz4vaRTUS3U=;
 b=TeN0YENDpC3thOim8hCjOJ/HtErNOLqUhCLqiOe9qcoLuyoKNB8tv9WNMLBqVkP8K8
 BtRcfG3VMhQ3BPgqACD5dxbNgLwpB3VNWwQsOTABG6DUDGQaFUJh2sXvr+bW6tWovtek
 yVuEsTXsfG1Ou6UAu6na+/VKQe11I3sOUTwrUOqgD6zCzkgFelH4ZPec4Ap3S4EEPxPL
 ZmHsui/gGf4GFXtFW/A9i2yclD7MhHs/sFOIZrcGfwLFE40iOGSpN5292aq+Ne2VTC52
 4ynKH99wxErgURPQCc4Jdtd2d1oCbwLp7WUhD/MSdnmSo1z9iLu13FKFEqyLYo8BnKpa
 Ho9w==
X-Gm-Message-State: AOJu0YwCo/GZOIIVknit2plnPkfbJ5sJXXuN514cuh0/08wIK0aFI/g4
 O1S7itiJnDOBAMlKnL/zFPqkjW1WRFv8nsUtUhcv7LtqvX8g7OaDojXXyAQ+nrvM3FMce1nKHkW
 X
X-Google-Smtp-Source: AGHT+IENN8o15LRfzGB0JvrDa7L7k/juH9E6rTukzX5Mx0zhBxnkjnQtcIdRPjNi6nGxppcVgaUsuQ==
X-Received: by 2002:a17:903:1c7:b0:20c:c62f:d0e1 with SMTP id
 d9443c01a7336-20cc62fd5d5mr57584265ad.55.1728845255366; 
 Sun, 13 Oct 2024 11:47:35 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c35522fsm52811805ad.296.2024.10.13.11.47.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 11:47:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] target/i386: Use probe_access_full_mmu in ptw_translate
Date: Sun, 13 Oct 2024 11:47:30 -0700
Message-ID: <20241013184733.1423747-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Changes for v2:
  - Improve probe_access_full{,_mmu} documentation
  - Remove ra parameter from ptw_translate


r~


Richard Henderson (3):
  include/exec: Improve probe_access_full{,_mmu} documentation
  target/i386: Use probe_access_full_mmu in ptw_translate
  target/i386: Remove ra parameter from ptw_translate

 include/exec/exec-all.h              | 29 ++++++++++++++--------------
 target/i386/tcg/sysemu/excp_helper.c | 28 +++++++++++++--------------
 2 files changed, 27 insertions(+), 30 deletions(-)

-- 
2.43.0


