Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E516FC54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 23:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rheNu-0006pT-DS; Tue, 05 Mar 2024 18:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rheNt-0006oB-5s
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 18:39:45 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rheNl-0001Vy-Cj
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 18:39:44 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so46622325ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 15:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709681974; x=1710286774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mLs4te7irjcY4udiruyyxPN3DWLsDKJ1swXlOZl0I5M=;
 b=BRmK/fEyBz3euu+OLvfRXVOUNJSCz6LHGrY51A1zg0xZBaQ2AXSdKL+QH0B5Q0zk8t
 AtT5Cok/TFzQbfP04DrSdSiFSNbdtDthviOZbnC8M7PnfXE2FCD32C68sW59w8sZZUe9
 JuAyGCyLMmJ8cV8M8in1Z9NUpm8XZs6JQZqxy8IeB4urgCS73pom3VmMnV8iCdctJvtw
 x4mum+ddXcwn5U0RiUzearb2lYRoUnOS17wkJYSqO4OKbNa50FTRyrLXkmq4AGoqM2VL
 7LOqXUsQmToVfDdmYg8zMlwxI2ew4lXLEK46UlQ/H5YbA5/jZi5QcKssntpztbQxsEL3
 Fv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709681974; x=1710286774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mLs4te7irjcY4udiruyyxPN3DWLsDKJ1swXlOZl0I5M=;
 b=DMU1i+LAG7XOpo+Wsy3MCWrDGYH+ZqF+kC5wnu9dgyNU6lrqQTTDrGs+TdaNJgUpTy
 0OJKxUJhk+UdTAbiT8Uk2u+DONtT4l4Dl4ftK+9ZZbQJgW8N/nICRpiKABen6DaJyow7
 sqV3D8yyKuzljaHPsojzTuHEdvfEqJU1Tj5QkMBu7/88xGY85z+YTerEFUsPcsIfpVDD
 MxBh6YoSTEhGOyiwJ/9Z10O68hyU3drWf+TF7TekMNtpz6qRYLNtNN1lhIyrfrV99uCl
 HY/SJEIf4dexixLk5s0k3MIG3LXwT8ET9wfAaIhdQrEO28QiiCbNdhSRYkBUvR76qTGA
 ucGA==
X-Gm-Message-State: AOJu0YxtW75vJRyh4hhUWUe/apdndJWkR060hY8/QVLOzWRMZqCYOM+P
 LDpJo4oupxXX9o8TOzSnv9WCGADiJOoLAknOeaEibsJhspIS/poPrfNlLb/0kCsezEtjOtHAG3M
 Z
X-Google-Smtp-Source: AGHT+IEwY4fi3iwwyE6b2bDOr/vw5Covktkmk83ymqi1kIy1YNWGNsI6DZa/nK29BC3w5S52jpk5hg==
X-Received: by 2002:a17:902:e8d5:b0:1db:b5c3:d2b2 with SMTP id
 v21-20020a170902e8d500b001dbb5c3d2b2mr2719613plg.57.1709681974107; 
 Tue, 05 Mar 2024 15:39:34 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a17090ad48c00b0029aac9c523fsm10047291pju.47.2024.03.05.15.39.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 15:39:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] linux-user/elfload: Two Coverity fixes
Date: Tue,  5 Mar 2024 13:39:29 -1000
Message-Id: <20240305233931.283629-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Only the second one is serious, but let's fix both.

r~

Richard Henderson (2):
  linux-user/elfload: Don't close an unopened file descriptor
  linux-user/elfload: Fully initialize struct target_elf_prpsinfo

 linux-user/elfload.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

-- 
2.34.1


