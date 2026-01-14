Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481FBD39014
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 19:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg6zr-0001O6-GC; Wed, 14 Jan 2026 14:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg6zT-0001KY-Fx
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:57:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg6zQ-00022R-UJ
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768420630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2fGD+v7b4x44Mef4lKFM3+AQpeSnK+AM/zc3iPZ5z+Y=;
 b=Fxq0DoIMOoRJbOz2L0HxN4JdjSwl0UNClBLelSA+vDaR/tSLtEfk77yuMEzquspHg8yeE/
 0avjIEcUc2IkFQOpAAlBRKoaSly31b9WY3iXWQKeWfqctyzwRa4X1qWm7AVhunYAoLJX3N
 NHiNMTqdsh0h+gG9LhGu9SLDs9720aM=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-hgXpE58YO-SHxtqNKnxkCg-1; Wed, 14 Jan 2026 14:57:09 -0500
X-MC-Unique: hgXpE58YO-SHxtqNKnxkCg-1
X-Mimecast-MFC-AGG-ID: hgXpE58YO-SHxtqNKnxkCg_1768420629
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9433e125af6so594767241.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 11:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768420628; x=1769025428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2fGD+v7b4x44Mef4lKFM3+AQpeSnK+AM/zc3iPZ5z+Y=;
 b=tB8T1GQHBGxDWuX1gM+948hAsAMXgoyU252se8TF+g7DCzxkN4QLCvLLN7AWRnCVsQ
 k8sE4cJZSH+ismMHW9bzoRTPsiAeRpqliW4GucxuNvmMY2ukiQBp3S1sJw7ddawJqVgR
 HMVnYlmOe/iCUrJ+XGFTjuVIRXfXvRIdoyPyS9E35HSm4l2S3wSbXPUT479qceZ2CJM4
 Ie+Wid76nO/eEf1a316fBV+d5p6u8i5I73YQV6FCMkv7QMfp/JLqnX6+jt1WdZohhCND
 xw9Xif00zC1BX9fPXtIYDFnfNNSj9oHg42jN4FELggj+9AbihlLv8jP0UbMlJeBWRQZq
 Tweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768420628; x=1769025428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fGD+v7b4x44Mef4lKFM3+AQpeSnK+AM/zc3iPZ5z+Y=;
 b=HOT2g9mDiIfyzAynrSDJtkyEelDmzdg7uD7v/LX87hqajwMN4F2z+1pqzLBVQMF1ih
 yJmcGu0bx6pRoe4jNBHqYxFkhs9qkdi8Rcea5QNmAgajitPDUBBYVFq705rv+APJ9VPw
 Sepw8hZITQIXW+xXHsbw4FCrn84yN90mEuNi5FWySyaknzgET1IZYcSTLEI0nQdbcHX7
 khmRVP9gjrMsiKmnDFPeyphUKdjDk8UnlhzLDFs0HEMRvHcXaSYzk/SScBI+ac2JPkKw
 YF//UKQf6ruRhhemQSNEO46MRQIi/GCU1MW+0DiDg82mmDH2DgFjzXqfHYGCM3dvtXmb
 DIYg==
X-Gm-Message-State: AOJu0YwGaFJeUtscFXAHPpvTSJqPqlE8Tk92dm/Rrxqsej5irPQXEFii
 xVuKppkgSDc2NOkDn79XmNXdP64phpsyaeVDYiha2NzvLg6C/wi8wEIzlythu/bS0ioa0SAEXx1
 tyEu09WcokVAlCoLq/Z5UhMNUP7fw99DZhERrhsxGfc2c5KNzvoWB/npkoy0wbZx8RrWWeji+/Q
 Sb7ctGabRb/MzSBaF7GuL7cyen2qtSe9ZOtF24Ew==
X-Gm-Gg: AY/fxX6m1F/lz/s/tNlWHOH7xKeVYLeFTYTpm36nkEZUn53N4zSyG5tbY/TZIejrnk6
 8sHnaXYwv5tB2whADt/00jbyCuMxGIoSvMryg4d3jbvS5jXU+U2SvfHWnj8xX5YRtUQtcT+ILjI
 T6I0b7COEnrm0BNr4gpn/Lcc9URPfiPWkhc/tokGhNBsAEsuIHLs/IUh6ToTVIhhYeeXrkb+WGD
 o9NWcnWYDBmGkQE4kEWzrwFI+W+8XIbukMoo1qKBZpX+BiVZPfRizNxZNFt7LL1gU/ZKEKECisF
 hSdfS7VqeQ+nlY/NM2Jr170frAa0VgTQwOVrOcUwarKxT0I+YhN10KSxt45ymIrS+fMzMdSCg52
 X
X-Received: by 2002:a05:6102:370d:b0:5ef:a416:be61 with SMTP id
 ada2fe7eead31-5f17f440894mr1748257137.10.1768420628214; 
 Wed, 14 Jan 2026 11:57:08 -0800 (PST)
X-Received: by 2002:a05:6102:370d:b0:5ef:a416:be61 with SMTP id
 ada2fe7eead31-5f17f440894mr1748243137.10.1768420627790; 
 Wed, 14 Jan 2026 11:57:07 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-944122d3040sm23024832241.4.2026.01.14.11.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 11:57:07 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 0/3] migration: deprecations and removals for 11.0
Date: Wed, 14 Jan 2026 14:56:56 -0500
Message-ID: <20260114195659.2543649-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series removes two deprecated features and formally propose
deprecation of COLO framework for 11.0.

Please review, thanks.

Peter Xu (3):
  migration/colo: Deprecate COLO migration framework
  migration: Remove zero-blocks capability
  migration: Remove fd: support on files

 docs/about/deprecated.rst       | 19 ++++---------------
 docs/about/removed-features.rst | 15 +++++++++++++++
 qapi/migration.json             | 14 ++------------
 migration/fd.c                  | 11 +++++++----
 migration/options.c             |  5 ++---
 5 files changed, 30 insertions(+), 34 deletions(-)

-- 
2.50.1


