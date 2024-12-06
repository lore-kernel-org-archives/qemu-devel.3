Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CC0E77171
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 01:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJMgE-0003Zl-0u; Thu, 05 Dec 2024 19:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgD-0003Z9-4O
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMg7-0005dB-EW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733446720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g71KzLQSwtxNTL0YJi3tcazNTXO1d6801jgz+4WkHrA=;
 b=DUjBDdFJAy1XKah1EM9h76flX719PEdwKvjGF5BWIIRjaH9s8NaukZ+rtD/AG3NdJHq/Ae
 14B6zgFDhr1zrooRgXGhgUzlFKX8Z0iTE66z9QAmUS2tH7sjJQMohy8KuQ4R/bNboNKYLK
 r6TVaCD5zF21Un9kCtyWo0301Nupwdg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231--J82g-1_POWgB_qcfzek0A-1; Thu, 05 Dec 2024 19:58:38 -0500
X-MC-Unique: -J82g-1_POWgB_qcfzek0A-1
X-Mimecast-MFC-AGG-ID: -J82g-1_POWgB_qcfzek0A
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d895f91a7dso28675316d6.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 16:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733446718; x=1734051518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g71KzLQSwtxNTL0YJi3tcazNTXO1d6801jgz+4WkHrA=;
 b=l/Rirb9VL6GWclvjBY3cTYONC65SEgikX9o6zkL1HsQx7hdNT6VMa1m70C45EdZtKA
 br8NlHxpQfENwDv6xwIagi4wKQQQUh7gF+NfRzWb7KRO30O7UB3bL4m+LJsKEUVpw+ca
 ljLnWoOnf+IGSnjdjlmg+tMqclzzEAWQ+N7upu5SAvrt33NDQdu0FpbyfmggDiCG/+Za
 Cpa/xad4X0EfzPhUQ0BfwEFlu0pnL2vTWAwBPbi0Af2NvBcWZvoBtp3HLkBBYLBWHPPZ
 QygSGbwO0F11sr75NPZARcos8rRwkrcgWqN/xXPu1ikORQOF26/tSaXK1CplJg3VtTON
 30Ew==
X-Gm-Message-State: AOJu0YzFjIN2eoIr4rZ9518CnCAa3CirjUhCOZydAXErPC1rfoRSEQeB
 Ztdp1phbiW5qYTYmYAKSpWSSiFuHNla/rBlQ9H6+jblT0Xdoo5rFqhq9IgDXZhaQuXA8pltompg
 WjIsrp9EQWyc4HTjNSFOGM1GVFeYgSjpnPLBDPbQFlwQFdjSLO6/T5u93zaJAYH9p+PqE64etOR
 alMbaATZ/OF9VyOYZk0txyLDF7MQsUuZwEvA==
X-Gm-Gg: ASbGncvWJEGG9lMXOsuGZcHUJwrthsGvSn337h2YVR3lcwrjKUvLcLGOovk1b7C/quz
 3NE+O7TGyfL7U86KbhreL4Wqeqd6pz/oAZf7T9ZGomTOCSC0P6nxGfCDUjOigevZqpd4otYITcW
 f29clsxTYD/FVpbaiel/pxtmdyTixZYM0Rir/68xcRnCxmQ90sNMVJO1Mu+CGUVQk98HSbma9DI
 afjz7Rug4QV4w7l2fDUWIr2MhwqAUpiqFPYhJmUZFCGx6Oqd8DlqVjSuX1Y6UXAevFEYjRhUG3p
 OnLlgo2sRHQcAa2enA8pw5qXxw==
X-Received: by 2002:a05:6214:b6a:b0:6d8:aa52:74a3 with SMTP id
 6a1803df08f44-6d8e71ad674mr15929826d6.28.1733446717903; 
 Thu, 05 Dec 2024 16:58:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvJsN36AyXu1adTHI0NtEyJKXo1FvAQyhSb/Cz5OYkaCibC712AeFb/v0xtqyP6x2mSflYGw==
X-Received: by 2002:a05:6214:b6a:b0:6d8:aa52:74a3 with SMTP id
 6a1803df08f44-6d8e71ad674mr15929526d6.28.1733446717536; 
 Thu, 05 Dec 2024 16:58:37 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dac016cbsm12635226d6.117.2024.12.05.16.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 16:58:36 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 0/7] migration/multifd: Some VFIO / postcopy preparations
 on flush
Date: Thu,  5 Dec 2024 19:58:27 -0500
Message-ID: <20241206005834.1050905-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/1575970314

Comparing to v1, this series v2 now contains some patches that may be
helpful for either VFIO or postcopy integration on top of multifd.

For VFIO, only patch 1 & 2 are relevant.  This is the only part that can be
compared to v1, where I renamed the sync flag to LOCAL and ALL according to
Fabiano's comment.

For postcopy, it's about patches 3-7, but it needs to be based on 1+2.

I put them together because the two changes are relevant on the multifd
sync operation, one must depend on another in some form. So I decided to
send them together here.  All these patches can be seen as cleanups /
slight optimizations on top of master branch.

This time I did more test.  Besides CI, qtests, and some real-world multifd
tests just to monitor the sync events happen all correct, I made sure to
cover 7.2 machine type (which uses the legacy sync) so it still works as
before - basically sync will be more frequent, but all thing keeps working
smoothly so far.

Fabiano, let me know what do you think comparing to the other patch [1] on
simplifying the flush checks.  I'm open to any comments.

Thanks,

[1] https://lore.kernel.org/r/875xo8n4ue.fsf@suse.de

Thanks,

Peter Xu (7):
  migration/multifd: Further remove the SYNC on complete
  migration/multifd: Allow to sync with sender threads only
  migration/ram: Move RAM_SAVE_FLAG* into ram.h
  migration/multifd: Unify RAM_SAVE_FLAG_MULTIFD_FLUSH messages
  migration/multifd: Remove sync processing on postcopy
  migration/multifd: Cleanup src flushes on condition check
  migration/multifd: Document the reason to sync for save_setup()

 migration/multifd.h        | 23 ++++++++--
 migration/ram.h            | 25 +++++++++++
 migration/rdma.h           |  7 ---
 migration/multifd-nocomp.c | 74 ++++++++++++++++++++++++++++++-
 migration/multifd.c        | 15 ++++---
 migration/ram.c            | 91 +++++++++++++++++---------------------
 6 files changed, 166 insertions(+), 69 deletions(-)

-- 
2.47.0


