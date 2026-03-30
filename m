Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6256C1061B1D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7HvV-0003oj-FI; Mon, 30 Mar 2026 15:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w7HvT-0003oM-7l
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:27 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w7HvQ-0005D7-PW
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:26 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82bae83318bso2229450b3a.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 12:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774897523; x=1775502323; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NLMeB1T35Du6zyw6/fw6tijVm1QevyhJIHM/mSx3rws=;
 b=VwXVQodRa04vSfG+y5zzG+0+XTcXmFo3mnvFvUc8qHdR63Y1opHXZAS84MC8WZOT06
 4urh6Y+Exz6ISPs1Jl+ZMs7PcA1oer5AQHXfDSfUx0rNZaxjF5jegcaLHTVyTDBEZp63
 vP0Cw8u6H6YnmOQTiatNSx+vIc+ly/0BS0iJZWLCYYKD4+QfHhx1hECnZcg6Yu48o99N
 IoepHFwDmxOhFV56pQAUn5rs4t/U8lp3rvU95VD/tjIHJIcJ11wCU6XFqX70CK56U2vz
 KXzkcBKUgyMu4pDr3aG9eSCRnSVOGbCsletmpni7AejGUyvlR23hJlWohMfyW56R+F4o
 h0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774897523; x=1775502323;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLMeB1T35Du6zyw6/fw6tijVm1QevyhJIHM/mSx3rws=;
 b=N3sw5T6bT00OAYjQaA5i0L8BgtaMjmnWY2Wcou88y9nao0gRigJH/pZr8QSzW89tkG
 koqQwdDfO/tCFEeQsLliUSpfzMAuJu2CeDCCOoPdDN+gpEPmYAIUdm/2AuYLvUacRjD/
 m/3SjC0G8oJsfQywhzZI7dEArctcyXUfhcrUIBVgbl2p/qYihfdefwJILZnbSXmDGemU
 G6NHmP6+BNftg0UL9uXgxbXBqYR0hhTomYu9bwrs+TvJ6yxmG5q4X733OqGb3cDqj0tY
 4Qibv2lS5gKPc8fNFe0WRE2HwNUBdFHZQCMFqQvhaQkXMI7XrJub+pLkqy0LUSnEa9KF
 Kk8Q==
X-Gm-Message-State: AOJu0Yx/Q9su3MAr2K922eBbcTU3MWyWiZTZt/SEng/i2v4aMWVlADha
 y9AyqrNamJpz3TL7CCTLL/QYmdC+71W3CF7fSQCg9kevhssSTQ9nf8O6+ArmyQ==
X-Gm-Gg: ATEYQzzHgXEK0GGhgFBfxxSzmxg4Zlu66PFAynwxzDH2k0YDbmG/aJBUtZgItGW76Tx
 77bm3+yTF9ELzaqeuVBJWThmc7m58W8RZ/uBliBL+qwLirubPlGdt6Gw3RYXpo3tKJ/HRA5wS2i
 bGvi2BvrHVnN6oBNkC8cixWQwFm928sEUIvQSZdFmf+7c+5SqWSJ1LGJPm7qHX7HyvPVYis8RLy
 CREfF2Rl/OEVcFEUesPsIlmbZTRMDbUKnNtLsyKC5QXu4bfChkjOSaXvOsePIrgN3WLhET6FfFa
 od8SwL+VKv3gA1IXfHuOjP+NYoxcqIoYcNesP7Jf9y8mLcUpa326Kwmtc6meeOt0tDaieig3nKy
 FXRjRHPFcDLv2lOSKkGFxnQGw0fcPqnrafHOL5Q8YMcRlK8ti/g3s6qR6w0RIJ51GeGSXp1UfmY
 guep/Y29rvSUfTMPnlXR99gjkPDJPXqFpg/moO7YhkYFIsKCGB1EbDDZ0i3hEn/U07n55WClR8H
 wsmEP/FRDf1GonBaA==
X-Received: by 2002:a05:6a00:9510:b0:81c:c98c:aeb7 with SMTP id
 d2e1a72fcca58-82c95d341c7mr13229839b3a.7.1774897522723; 
 Mon, 30 Mar 2026 12:05:22 -0700 (PDT)
Received: from [127.0.1.1] (191.68.231.218.rev.ocx2915.net. [218.231.68.191])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca84644d9sm8496989b3a.13.2026.03.30.12.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 12:05:22 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
Subject: [PATCH 0/3] migration/postcopy: Preparatory refactoring for fast
 snapshot load
Date: Mon, 30 Mar 2026 19:04:40 +0000
Message-Id: <20260330-fast-snapshot-refactor-v1-0-22143e70c467@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEjJymkC/yXMQQqDMBCF4avIrB3QWBzoVYqLJI46LhLJxFIQ7
 26sy4/H+w9QTsIK7+qAxF9RiaGgrSvwiw0zo4zFYBrTN50hnKxm1GA3XWLGxJP1OSbsfO/ci4w
 jIijnrSzy+4c/w2Pd3co+3zU4zwsmJ3pyegAAAA==
X-Change-ID: 20260327-fast-snapshot-refactor-3c6bb472b777
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Takeru Hayasaka <hayatake396@gmail.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=hayatake396@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series refactors postcopy and mapped-ram code to make the
userfaultfd infrastructure reusable beyond postcopy live migration.
The goal is to prepare for fast snapshot load, which will use
userfaultfd to load guest RAM pages on demand from a snapshot file
instead of reading all pages before starting the VM.

All three patches are pure refactoring with no functional change.

Patch 1 introduces a callback for the fault thread's page request
handler, so the page supply mechanism can be swapped (network for
postcopy, local file for snapshot load).

Patch 2 extracts generic uffd setup (open, register, fault thread,
temp pages) from postcopy_ram_incoming_setup() into a shared
uffd_setup_incoming() function.

Patch 3 splits parse_ramblock_mapped_ram() so that the header and
bitmap can be read without immediately loading all page data. This
allows a future caller to read only the metadata and defer page
loading to a fault handler.

Tested with mapped-ram precopy file migration tests. Postcopy tests
require userfaultfd, which was not available in my test environment,
but no postcopy logic was changed.

This work is part of my preparation for the GSoC 2026 "Fast Snapshot
Load" project.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
Takeru Hayasaka (3):
      migration/postcopy: Extract page fault handler callback
      migration/postcopy: Factor out uffd_setup_incoming() from postcopy setup
      migration/ram: Split mapped-ram header and page loading

 migration/migration.h    |  5 +++
 migration/postcopy-ram.c | 86 +++++++++++++++++++++++++++++++++++-------------
 migration/postcopy-ram.h | 27 +++++++++++++++
 migration/ram.c          | 52 +++++++++++++++++++++++++----
 4 files changed, 142 insertions(+), 28 deletions(-)
---
base-commit: 8e711856d7639cbffa51405f2cc2366e3d9e3a23
change-id: 20260327-fast-snapshot-refactor-3c6bb472b777

Best regards,
--  
Takeru Hayasaka <hayatake396@gmail.com>


