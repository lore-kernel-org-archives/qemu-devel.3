Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0803D0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNu5F-0006n2-Cv; Tue, 25 Nov 2025 09:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNu55-0006ih-Np
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:31:51 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNu53-0004ep-Ql
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:31:47 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b3377aaf2so3254857f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 06:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764081104; x=1764685904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xmXtLRIJY79eAlv8awNA0XP2w7Ef3VsFWAE0E9MyIFk=;
 b=wdtEts0/VQd+lFEGHTGz8SnbttxzZ/YlvzqWYObzb5M9QCqo2mY01iWpwI55ApfKGI
 aMVp9S9ojQV6lVh7W53Q9uV1RJVIg/c/aSlMjzkJs1i0WYUzwC/iUJQIkMmr8berjgGQ
 0lddCc8oPjXBofEZ/PzygNr8c6NGFNQKBKMYH1dUVOhsL30/db37AcINKD4joXr8/sIU
 57UpAghuL8sgbQ00I22pwPNkadySVvOoha6VKg5sH+2VYZsRqixXe/e3/O/fc8KoKo8R
 SQdWQpfCXU14CZOJT621NSZcp/iDnqjH2Bdtze3SsEDihQl9J1JOjIMEnwZCFKUG5/6P
 U56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764081104; x=1764685904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmXtLRIJY79eAlv8awNA0XP2w7Ef3VsFWAE0E9MyIFk=;
 b=J1uyd7xybamLrgwbhJaN6GGG8YbcsOEzHJFTK1HlJwXrXXOXLPxVk5YBgP3uEi8tYF
 gbdfmIRJT8ADBM9Lf0aTsxKct5uXC1De9j9hFfpZLM9gXxpg2pCb+k6s1wmsVR+k0TIf
 fLT621HQjQWCSHUwCH6xrRBIjYuu9SAdmJ85tDvyQ7c5TNKApFtbjNWQVbIvsFKZzLl+
 4hAwrrOJJvWwl/0ZUfV+JFIZhtNoQZn+r19IWA2ESp1ekM5gpCSXhEiIHBXAfy+vuVoK
 ElgzWjV2wlCimG71kWy+az5BhBFDO4N826DBKgJqz382/f06sko7Rx4sZgig+vbwRLfz
 o3Ww==
X-Gm-Message-State: AOJu0YwFh7W+bE8UadCvGvQERMvef1O5f9E6jHX5RIGdIFFwU99J7QL3
 Dw8Dtv5v7xXWUDqlqPIvIqTcv74yEi0NF8qZ6/HTFULXfIq1quIDjL/l2pDipdvSqPOrN7tUZTK
 wwFfz
X-Gm-Gg: ASbGncu3WWKyDNMEQ4Y02sQOkjazK3jXZremCD/pu3cebagYOwblcjL0IQDS4uxKXMZ
 R/koHtJt59/UODwBbprK1I3iU3+zuGxqpgcLuXzNm0aFvE5EUA8newUNOwPdkbqrHxSW4KdbrTo
 iL+dHdJx/ElPWF0FALNi+Nkj0p7PuDeG7XFLlE2WVq2FhMsaal+5BtumbiiObhk9/XI/RFQu9ib
 iHp4uIB6FQSC1KXHxE4pIrABHGttHnBpMr6cDvnAOHJIw1AVpw6cEh6ziThbEHhR4okFk3+498z
 jk3KoAUzTpIVqI1ozX04TUzo8RNHUzpkZbcKdo/UoANPkQmidAUzDJOcC2G+OLXycN/XXXdp5yc
 xYSyXupaxgMMpmGKeToOjODbbx7/Vvwmxw1R7YnpSNghp4b46yBdc8jxFOP+1dS4U6cSpty2QM1
 XsG0kLuArooOXO
X-Google-Smtp-Source: AGHT+IGystc2Xg0y3ubEengyAO4xssyx8qHkG6HNykmC5JcpLpux0OT2hletuk6BVM7dUvhs+jz4uA==
X-Received: by 2002:a05:6000:228a:b0:42b:2eb3:c90f with SMTP id
 ffacd0b85a97d-42cc1ac98b4mr16817394f8f.10.1764081103786; 
 Tue, 25 Nov 2025 06:31:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb919bsm34485434f8f.34.2025.11.25.06.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:31:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 0/3] generic-loader: improve docs
Date: Tue, 25 Nov 2025 14:31:38 +0000
Message-ID: <20251125143141.216056-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

This patchset makes some minor improvements to the generic-loader
docs. The main thing I wanted to do is the first patch, which
makes it clearer that if you don't specify cpu-num when loading
a file then the PC won't be set to the entry point.

The second patch is because I noticed a typo ("QemuOps") and then
realised that rather than fixing the typo we should instead
rephrase to not mention that implementation detail.

The third patch moves a TODO out of the user-facing docs.

thanks
-- PMM

Peter Maydell (3):
  docs/system/generic-loader: Clarify behaviour of cpu-num
  docs/system/generic-loader: Don't mention QemuOpts implementation
    detail
  docs/system/generic-loader: move TODO to source code

 docs/system/generic-loader.rst | 56 ++++++++++++++++------------------
 hw/core/generic-loader.c       | 18 +++++++++++
 2 files changed, 44 insertions(+), 30 deletions(-)

-- 
2.43.0


