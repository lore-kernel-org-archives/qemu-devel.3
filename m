Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C7CCA0FE9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 22:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqJBo-00062J-9h; Sun, 24 Aug 2025 18:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqJBl-00061t-1I
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 18:27:49 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqJBi-00069Q-Ue
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 18:27:48 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-55ce5243f6dso4107911e87.2
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 15:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756074463; x=1756679263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kFK+TRxREkxrkN6UGzxqMsdJ85fFDeTcg2ThhZ+G1gg=;
 b=ELxzQFM4cuRRu/nUu2V/U042MNrIMscx0gRaxm3zTRl6QBzPjQC4unt9xUqWWVvqpa
 RrFigHFrKZ+z1oQPEnoBYbfDedcFYXZ/DNsiRWcY1hBDq12IAaiQuwF37J5OmTyyFP2z
 JorkNgnOdQjGRZTz0gxH2yDBLyI/4wB9ylvWdlMz1CLeCmxRc6AV7IYI3TqNp5pr3zpL
 CA7+fCOhahzAZl9qbm5ipdJ/q/ix8CDV9K5axTYDm0mlyHut+esfTfyizSqfSRVdGtXF
 gP0VuEDJegfcZJYAi+rkpAclHOnwcHzwDhgLRFt+wjYmTMr1AF+/1SN9+O/N5dKfPMgz
 HJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756074463; x=1756679263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kFK+TRxREkxrkN6UGzxqMsdJ85fFDeTcg2ThhZ+G1gg=;
 b=ei3BdY4tdUpPs+k+fceJqwoyWmgchDuTwbjx+J00KcwOnp4Jl5m05PtLLNL0YNzJXe
 U4WBcSqUUQBboridYIG7x/pSTmowfZtGxTZSkWqaB7fYhuRj8eBHxqVppN5a1IPJINvM
 h7bQRbP7HK52SA7hSsJiq79dokFHVN1ooHmcPpeAuzbldzAfcxSCXpYsbs29tl7ywzDR
 NWD+gYdPf+p1QyHR1ShzT990HJJ7Y1r93zghxqjXaQdzCVCDhvOEAUgdQtf16y+Pm/jS
 C6Mi2UCn6xBges3aue8Q4HmPsPgPhQmEvfp9CfsAumG7MQpYXIZOa6dqvldQHTwdyqGl
 fKXw==
X-Gm-Message-State: AOJu0YwxlaK2AH45uxaTWlZcPgFxR3nhZRxFcT1E8a9sG+89xRnkVdXg
 aiQ+r+QrWzweiOSS7fVTyFerKSTYZhTsySqbCLwbmS6Pv2e16NgxdWDzwJd7Vi8J
X-Gm-Gg: ASbGncuhACJC7ua63CFRCp3sGDzDv11/KJMDtN73pU188YzMvh5aY52AUWLWMrKPg33
 F8W52n+6QriE18Za9KZiwnAvkVbBRkxNA+eCUI1TiOiZWK40jgcgm/ezTcLQXzA/F+MmzBVEltG
 FxmkwpZ1CukElCCKnmJXgQd2Y96XCJ/Li73c3aAYbl38A5PHekf4sU6fcVTFuI4J0iRdKDmA5mm
 4+6dKUbcFMochBZVZDTBoqFD4Z/pPtnKj9a1JbYbuEkDTRIegiesAdpx/+PcmoQdzTw+nANMmiz
 gM5AqCWcqnUR4b33VQfBLU4mBe+kw1viwJNp69NgALTV9aKT0hVDipRD6medk75qcbPbBMbBA62
 oGXdtUxbiflqcRXdrnjEQfmUWMNyvjFITB7+8SUuKVf9OAqX3mocWEmVZxTNhMVP0bRecLw==
X-Google-Smtp-Source: AGHT+IHAkoD4WH6IPBJfVZ+ar9pKddOjAjK4oj5jR1huzV0/IRbZ82dxTzeeEmsC3fKl5BNATAV6Ew==
X-Received: by 2002:a05:6512:104e:b0:55f:45bb:59a0 with SMTP id
 2adb3069b0e04-55f45bb5e23mr181014e87.24.1756074462542; 
 Sun, 24 Aug 2025 15:27:42 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35c9a1e1sm1249025e87.114.2025.08.24.15.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 15:27:42 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v1 0/4] targets/microblaze: Handle signed division overflows
Date: Mon, 25 Aug 2025 00:27:30 +0200
Message-ID: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12b.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

First a few preparatory clean-ups followed by the detection and
contional exception of signed division overflow.

Spec:
https://docs.amd.com/r/en-US/ug984-vivado-microblaze-ref/idiv

Cheers,
Edgar

Edgar E. Iglesias (4):
  target/microblaze: Remove unused arg from check_divz()
  target/microblaze: div: Rename and reorder function args
  target/microblaze: Break out raise_divzero()
  target/microblaze: Handle signed division overflows

 target/microblaze/cpu.h       |  1 +
 target/microblaze/op_helper.c | 53 ++++++++++++++++++++++-------------
 target/microblaze/translate.c | 12 ++------
 3 files changed, 36 insertions(+), 30 deletions(-)

-- 
2.43.0


