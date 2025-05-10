Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35100C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDdWH-0002Qd-F2; Sat, 10 May 2025 02:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDdWD-0002MD-B9
 for qemu-devel@nongnu.org; Sat, 10 May 2025 02:17:05 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDdWB-0007oh-37
 for qemu-devel@nongnu.org; Sat, 10 May 2025 02:17:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso2946031b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 23:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746857821; x=1747462621;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N4FShxfcJM9DtMoDONTqc75Lc831Q8bi5xNbRuMVJHk=;
 b=lkVzI7zwIH33OHkR/lpOpVL1MRSmzdD2jRuePeFkZNSGTax1yBr5EohplACrthZ79R
 aXVSEJDdmpe6muJ9/7JrRVODhJ7sci7e+Zr5TB7jvWLdHS2kDuQFbBAMKBUkB0/tqQ9O
 tJMqe0ENRmcOl4MtDjaYg2hmescRhftdr40+A/TZnCt4ZukWiDk07dEWM6NusaHwwYqR
 N46+8zbWP+Uaex05KngV7ny1sblIop7PIpR3kx5M9OYkLw6tCGAADlm7pYZrpjNMxLfh
 n2kHLB7f67QPUimKQL6Kt23O7eEb3XcAcHouaRqcj9ivmYVlb12KFtUdYFsNGh7KhEiN
 /wrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746857821; x=1747462621;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N4FShxfcJM9DtMoDONTqc75Lc831Q8bi5xNbRuMVJHk=;
 b=HT6ltx6JO+55R1AddmbFPNS/GafTn9bmeKf13ZcDhoGH2YuSyc10Rhf5rX4ToMRV2r
 LaVgKHorz9nFu+JM+fNVX/fwTYnSUziF7vXIHqnQMXjPjuZEA3agmwGmULIbd6sYycpy
 NPm6Z7j+6ve8VrxLWh2EDUd4GvyVjFuIg5LN44MtoNr0OV0AsyF5fwt40ywBWnrrGnVh
 mEDtxRTg8vAskFZLHJy61UKKvOuoCr5HivV88MO+M2iXhYSBU0xl6tjf5WAEuVDGKC86
 gnrP64Dx4Tda8h/mTI7c8M1IeFtHQUOFJ33TYRwutDwYqfqoUTsaBw029So8/OltAdGG
 DSeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJWOSfIxHsw6aIfWhOLiSWBMpFsddbbsp8TlKTVw/lRPvBMBQUIqvKoFZr2+GrNL1FgXJExN8HVpWU@nongnu.org
X-Gm-Message-State: AOJu0YxO+TJ/9bT6Wm6wIEnE3O64jVOR3cbH/NABda/wFB3mng/mnCl2
 34+JmOPtIENPUUX7nSRmEqAt2/TK5q4S6aXlolkGIC0xbAWB/MjMZLz7l4USLjk5Iu86gvjl7Kb
 S
X-Gm-Gg: ASbGncuX5Z/IhX3e2v8tcpi22sFNnLHAn/nll1wkAVS/zgsO7glUxQsYltNo1qOpDxH
 A8chDPxsw2ROH8R5Oqr+jO9Vi0qrJctgx1W8g3PaUHoHydKwCVbZVjHHxuDw31BN+wtXLVwal6D
 Ih3FBciniUDAbzhpixidx4CFbXYMwXCS9GAUe1bKhdDOeRdLXoCB2XBf/uxKitN9G3Utbgddcn9
 dqKx0P1tS2N/OmfHSXp78LdZaQcDIbSfqnUmCAA6KNFWHGxZ20z8a13hAPQ5JR/j623teooflCy
 E2K1tN+0SaQYGE2qyKkXHDU+A3JSKfnJagiAZjqCwgxN/6sLIPwTl9DD4GLnLJQ=
X-Google-Smtp-Source: AGHT+IFK6dAwqvWr8sl3mDXUIGJMdg711XaiqHwNZJ37ZCyZUNUBRlVmWDxftW3CSVk2XQHu4IotIg==
X-Received: by 2002:a05:6a21:3483:b0:1f5:839e:ece8 with SMTP id
 adf61e73a8af0-215abab9c4emr10227898637.2.1746857821147; 
 Fri, 09 May 2025 23:17:01 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74237704dc0sm2667706b3a.7.2025.05.09.23.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 23:17:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/3] docs: Bump sphinx to 6.2.1
Date: Sat, 10 May 2025 15:16:53 +0900
Message-Id: <20250510-sphinx72-v1-0-2358e0c68bbe@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFXvHmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUwML3eKCjMy8CnMjXRMDg2RTI8PENHNDAyWg8oKi1LTMCrBR0bG1tQA
 gid3oWgAAAA==
X-Change-ID: 20250508-sphinx72-400c521af710
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: devel@daynix.com, John Snow <jsnow@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Supersedes: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
("[PATCH 0/2] docs: Bump sphinx to 8.2.3")

sphinx 5.3.0 fails with Python 3.13.1:

../docs/meson.build:37: WARNING: /home/me/qemu/build/pyvenv/bin/sphinx-build:
Extension error:
Could not import extension sphinx.builders.epub3 (exception: No module named 'imghdr')

../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3 version of python-sphinx and the readthedoc theme

Bump sphinx to 6.2.1 and also sphinx_rtd_theme as required for the new
sphinx version.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (3):
      docs: Bump sphinx to 6.2.1
      docs: Require sphinx>=6.2
      MAINTAINERS: Add docs/requirements.txt

 MAINTAINERS                |   1 +
 docs/requirements.txt      |   4 +-
 docs/sphinx/compat.py      | 230 ---------------------------------------------
 docs/sphinx/qapi_domain.py |  33 +++----
 pythondeps.toml            |   4 +-
 5 files changed, 20 insertions(+), 252 deletions(-)
---
base-commit: 1da8f3a3c53b604edfe0d55e475102640490549e
change-id: 20250508-sphinx72-400c521af710

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


