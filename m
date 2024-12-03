Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFA6E69EAF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIQj2-0001gZ-Gi; Tue, 03 Dec 2024 06:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tIQj0-0001gP-OK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:05:50 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tIQiz-0005yN-3Y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:05:50 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385e075255fso2534883f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733223946; x=1733828746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PUdiko2I8J6xrlSMSAA1aTL8jewTc3HgG5WTz9aLd/M=;
 b=eCwr2+kL9NjrYs3RNO4Uzg7Q1KFm0fuJggryu47lGdPhX8ry7PjVE5zQ0+3sFN6h/R
 q1CZuZojdh2ku4sZqkZkEIQ3g3RKhzFw3YFQbdC8Ts0nRyWIU21Qij+iiGCCCr9w/hZM
 anIX5dENp4kDMIf3ZkMldWLDN2Ll3eraxOPGgppNyO17pYmNmZnwkNmCJSqDeDCjtbn4
 nLWq4vh9RUfmzxU6iSpnMigIVtG9zemBLcZwBmHRH/9DuDnMTGLmS9GQlW4D+xnIJ29C
 wXiBGRgF1EIpyoHX0XlTknla17PsgJGNu2rr9f36nOVLHyjSF0S14shSbkmIEDhA9/uj
 BGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733223946; x=1733828746;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PUdiko2I8J6xrlSMSAA1aTL8jewTc3HgG5WTz9aLd/M=;
 b=gFY3wLxAzn6HmRLf7lO6uCpGYcBp4qCy4cH2wbM+NjTWBsT1tckN45KoFXIsLtJ6W6
 3GF/gnzWbeNyijKFfJpfjVLvQVQQD7mtqTm1OpAGBHV2l7PZtmZbn+B0xuNWEUW9BBFj
 fU/fvbeM9dKCrAXWc21PclgbJyhzAq82eosanRvcI+rRfI98KTJIDNYEsoiYIkFKA/nz
 M8Yr4dNY+1X6+8XGdNF3NiTAQlwarSaElxXFsCGKvb1pNujshtXukCbdROMxPvCaLF4X
 s8QiQMKD/n4QHTW/pJS8OTaTb5wFq/pZL3x8ZvOrnj5sD/2hPn1bObI/h3kzedzi41Dg
 n/pA==
X-Gm-Message-State: AOJu0Yw595hMF2TP9NqlrMsKUb9uDbAztTfFXwoGiIG5ZqX16yy/soAt
 M4+SctGmPHTRShZCJM81EEJ5QFNGWDaxKT0MvrSe6edG/f+3HHihFUBcmQ==
X-Gm-Gg: ASbGncvf0OsZdx9qfwzUFA8AHWd5YkkD/wjvDwfKhdc0dj+fNHn6dTg2LNhTx9TrlOe
 EcKdunG1MSvyvdSowx6gvQ12AZtyZVQQnywOp02qXRAP/wmgjtTogjuRWWMt43T0W0dTFHLHf0S
 ayTL4DUJrMcOB00G9oSE+JHzIZqrwddcXs9ObivUmonQ33dTLgrWZjJtU2ssAwDL+KbjDX9g88e
 IIVzjYPo49lcIu0/P8FQS9UyjeR/Gu5HNpvYjOoQvPSfQUpnRwRA3BRLk0EFr6ifnUd+fK7mJ35
 lUpqQ0lzI16zVA==
X-Google-Smtp-Source: AGHT+IFbbLoeVTjNWJ73pcGXeIrHHC+0nDE38UizNhc0T1dKiN5azIh0Qc+Du6mMx98OfLfiVcHUYA==
X-Received: by 2002:a5d:47c9:0:b0:385:e013:73f0 with SMTP id
 ffacd0b85a97d-385fd42df50mr1865800f8f.59.1733223946186; 
 Tue, 03 Dec 2024 03:05:46 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dece67dasm12756259f8f.8.2024.12.03.03.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 03:05:45 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stafford Horne <shorne@gmail.com>
Subject: [PATCH v3 0/2] OpenRISC fixes for 9.2.0
Date: Tue,  3 Dec 2024 11:05:34 +0000
Message-ID: <20241203110536.402131-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x435.google.com
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

This series has 2 fixes for OpenRISC that came in over that past few months.

Since v2:
 - Update the commit message of the serial@90000000 patch to indicate the
   changes from v2.
Since v1:
 - Use DIVIDE_ROUND_UP instead of open coding as pointed out by Richard
 - Fix off-by-1 bug in TTCR patch pointed out by Richard
 - Fix commit message and reverse registration order as pointed out by Peter.


Ahmad Fatoum (1):
  hw/openrisc/openrisc_sim: keep serial@90000000 as default

Joel Holdsworth (1):
  hw/openrisc: Fixed undercounting of TTCR in continuous mode

 hw/openrisc/cputimer.c     | 26 +++++++++++++++-----------
 hw/openrisc/openrisc_sim.c | 26 ++++++++++++++++++++------
 2 files changed, 35 insertions(+), 17 deletions(-)

-- 
2.47.0


