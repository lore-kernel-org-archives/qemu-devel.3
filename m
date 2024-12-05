Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1249E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 18:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJGyQ-0003Ez-Ad; Thu, 05 Dec 2024 13:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJGyO-0003Eh-9l
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:53:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJGyM-00017p-E1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733424788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q/tciySgp+HIAH5wVFIoZ2rBf1B6LaDPvp5LxtlzPBY=;
 b=C71eYyZFY2+QP5uDiBWAumiPKZt87cMnUS6TjmeKKM3xKcb3/dM+bLlr4SeqFXB2NP7BJR
 ZZyoycXA2Ka+M3FlrOWESnqecfVmSQMy1DwOMySow2dPpwM4+zelBhvH0rBmA6mR09AMOO
 /0iRkl0mWJC7DbC+IGNU0GwQDZXexVI=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-wc1D4b9ePA-wNChMBB5YoQ-1; Thu, 05 Dec 2024 13:53:06 -0500
X-MC-Unique: wc1D4b9ePA-wNChMBB5YoQ-1
X-Mimecast-MFC-AGG-ID: wc1D4b9ePA-wNChMBB5YoQ
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-4afaed89f59so397056137.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 10:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733424785; x=1734029585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q/tciySgp+HIAH5wVFIoZ2rBf1B6LaDPvp5LxtlzPBY=;
 b=NrDb3pboEuqsLIu4eO0lra3vPSF366/pHD08iMymNTBYIg2/Ba2qsXLWTgWsbzYqwA
 RS1M3bVBb1cHXA4K3J1PO5KmOqF/9UqgoFyQZiiokosskHCLSnCua61u5cOyviUN3b6H
 qZ3DDIA1t7uc3+NFIb5U7y5PkcVtIXu9JQMVblfzNMfq8OBP4J2xfH3j0sHV04XJTuY9
 7W6aYXKmx3SieAEv+Qcl0+/eXAs7kaoY9I3Fz3qDHaGbq2kI285F+LE1N7y9iawZVEba
 ts4RRZjMyBTel55g63QLNbo+Hqwbj+tDDEjDub60uVu8osImVhNGnR9tZ3xPB3XCm4iS
 yGoA==
X-Gm-Message-State: AOJu0Yyh9mb9df9pHt+PtvnPEzeP1eoIUvlYkhR5/Q9b96i0FhNdS/H7
 LifuOljWxy7zH5prXRDugG3CXEdZjMoNCuX8UT4W1fE4zo2r7xRbGbEfcUWghMPdlK0nJQO0IpC
 COUPVEjzUj+NDOA4sooLxJCmUECyM2Vng6EMP1mIg8JT3Wqrl7SQUNnl47NOeEkuDXpatBlZFSl
 B6FeKdvTAIz1yRT7AfPj37AmyQ+954QCRCkg==
X-Gm-Gg: ASbGncuK9Kz476YGZoR3AWM+86XTqf6g9jsH+CwN0MpUw0q7f4dXO+cfjNpe/l8Puup
 SOu1YHKkrPbgzrglr23JvtPvyhP00BJfXePUhE5CdaMQbocZEVvUu55rQwCv9X5IcwnfsfLT1/R
 8WXtTIUXS0JTboi1a7h+QQsifVntm1mKT1vhSYmwP4Q4Aa0pXisAoYN8zFJynw9yjk5P4Eg3vLd
 rLvWMEzBN+5rwGtmmX57uLdSrMKqE8e3tWht8c3yt+kdCD23srrjcTeK3E8CmxNLfczEjspACyp
 aHbEp227JltiK35b2fUsv+Amrg==
X-Received: by 2002:a05:6102:dcd:b0:4af:cba5:e496 with SMTP id
 ada2fe7eead31-4afcba5e701mr123162137.5.1733424785655; 
 Thu, 05 Dec 2024 10:53:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe3RCzotgFPLuJxa7NfHyXari1NXKFKP0NYO+dHFfHmv8jKEc7wG1vY3lLT58JAWl37k9Fmg==
X-Received: by 2002:a05:6102:dcd:b0:4af:cba5:e496 with SMTP id
 ada2fe7eead31-4afcba5e701mr123142137.5.1733424785322; 
 Thu, 05 Dec 2024 10:53:05 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a841b8sm86150485a.87.2024.12.05.10.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 10:53:04 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/2] migration/multifd: Some VFIO preparations
Date: Thu,  5 Dec 2024 13:53:01 -0500
Message-ID: <20241205185303.897010-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When reviewing the VFIO series I noticed something was off in multifd.
Meanwhile I just noticed we can also provide some more options to sync the
sender threads.  In general, I assume these two small patches should help
the VFIO series moving forward easier.

More info in each of the patch.

Thanks,

Peter Xu (2):
  migration/multifd: Further remove the SYNC on complete
  migration/multifd: Allow to sync with sender threads only

 migration/multifd.h        | 16 +++++++++++++---
 migration/multifd-nocomp.c |  8 +++++++-
 migration/multifd.c        | 14 ++++++++------
 migration/ram.c            | 13 ++++++++++---
 4 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.47.0


