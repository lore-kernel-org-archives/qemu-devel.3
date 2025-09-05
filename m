Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF80CA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 05:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuOrV-0002io-4b; Fri, 05 Sep 2025 01:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuOrS-0002hg-69
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 01:19:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuOrO-0006u6-FL
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 01:19:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b79ec2fbeso12142095e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 22:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757049579; x=1757654379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JItd8iztxtfQXBJBkUbBr4iyFDYLNaRm2z0QuyZyeLI=;
 b=J2EVKnItKm7yzM23JENEldd5fhNUlcdeEvAsTqJgogIpk7meG205CBGlaex8sBE4Rz
 doTYfN38rM2writeeX4cSrSDN2SCmp09QEBIgg6XYMLgKQPs7IawNS4zoZ0UloMETosO
 xehqKGmxqKiFqttjVj5FEYB5mElt01DKkIJO+RO3X6UMQOxj5bmeOawD67F6PWjREarY
 PuVemddGrvzfv17dKDS8tCmqyOddUtFzNPprpP2y4H83aWKSLFNtfJ/8b5XCJ440LjoW
 ug6EG+AONIeHigO4bs0tttcXK5YcV1L/bmnnL/85X2a5bFUpqt5yifwiOpJv/UxGBdml
 mkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757049579; x=1757654379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JItd8iztxtfQXBJBkUbBr4iyFDYLNaRm2z0QuyZyeLI=;
 b=xImlzCDpBIJyGjWw73LvXumYJAPXgGFCOJgZcKjKCbcB6ipzdzvHJdMNuPCEh7E9NR
 A6TNaiItu22XR/Wi56FkzmemdatEm+ifMGyxg5U/BT+egYyDVG2Xbvb7b3IYJHPUzlWC
 uh0CUmmhabdIsCJBWwSVlLlqx0s4Xgk7QRvqAEb0peINSSuY3/Gh/9klDyu+Wo9o6IuV
 K18WJNoIGeFxkDsiD1TFyO1SBYsav3ZFik76Q+MKpwYMWudlB13jjkh2FuHB/snewoqO
 12qlQT/BF+/arjXtaavWny3kBaZwGmZlOFa9BKce3vb6+yTV2YhEhvVA5J195FzJSR2U
 azrQ==
X-Gm-Message-State: AOJu0YwZ6qUIIfVXfLI8nMVQWbiHuk/hjrpBoganeKd4TcGsHklp2HWC
 ewTaFFXNQzSStatObBrt7CbU3R94pii/3msBA1b4W2sTyyqSK4fxWfkcDxFp7xT0wPQqkKk+gXD
 2NFuzgck=
X-Gm-Gg: ASbGncugHXVOEMDUqc0sGOfrqdc5fhhF1SCvbUM343Z54ac6eo3OfI8IFG2aS7Yl2zk
 PY4gOYL4OszxGNaxfr+nmqi7Shk/HyIeeKwlR4FW4/nrIYrMG4IvBQz65Pqrntyjui7dHc1li2b
 jLTD2HdsZ3ire8uvUr3ZSk6sZ1lpMWgdVyJUJpajGwxuBLpnDDywv/ZNhX5YcaWv2nbH+nrBTPv
 F8JbK5M0iJG6sHi3pIL9f8dR2v8bmMlmBaqzOZya8XAPpzSKw60xZb9ndxQBQaL7sRffH7TV+IN
 0gnKFFs3VSUBnH6Qpds1CSHyGW7mS4uUtgCjQoqDObpoabikxO/h3xh6Rwg7XNE+LaG6hrzixWm
 zaAjmyRk9ec6K3HQnKrid2SxroguUMxDz7zSjDXsoWOidUeXkSToZ+E4nevZ6mgGcVNoWhPBCQR
 qMiaw84x8=
X-Google-Smtp-Source: AGHT+IEFODuSzbKKoDFz69NNaN+qhL34hCHa0ay7VPCZKLfpXIXpkPvL5M7BpWawBQti+zytV5tahg==
X-Received: by 2002:a05:600c:c1c8:10b0:45b:8600:2bcb with SMTP id
 5b1f17b1804b1-45b86002ceemr130995015e9.7.1757049578611; 
 Thu, 04 Sep 2025 22:19:38 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dcfcba94esm34360325e9.2.2025.09.04.22.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 22:19:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 0/2] target/sparc: Loosen decode of STBAR/RDY for v7/v8
Date: Fri,  5 Sep 2025 07:19:34 +0200
Message-ID: <20250905051936.92815-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Mark,

Here's an alternative to your recent STBAR patch.  It goes further
and adjusts RDY as well for really old machines.


r~


Richard Henderson (2):
  target/sparc: Loosen decode of STBAR for v8
  target/sparc: Loosen decode of RDY for v7

 target/sparc/translate.c  | 36 ++++++++++++++++++++++++------------
 target/sparc/insns.decode | 25 ++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 15 deletions(-)

-- 
2.43.0


