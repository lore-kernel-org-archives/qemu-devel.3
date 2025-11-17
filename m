Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971DDCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 22:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL7so-00054y-V6; Mon, 17 Nov 2025 17:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL7sg-00053U-IA
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 17:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL7sc-0003Vb-QN
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 17:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763419156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9XijziNlOnKQZVQqlX3I8vq+83B68kRlfGkDl8KnMyU=;
 b=TW509FFu1kv3VxdWDDZ7CA4vUe1j29PRg19mMVPU7h1uRGillo2WXyvDabqek7rrLZcI51
 WWejKQxX2xll8T1YvFgGJhkL85+GwFfmKb9edA58INS1Ncol8ocE29yMrUS5jxl/N50tXm
 cJuYfZoHpK0eWQc2rhhrFRQR8Ftnf+U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-46kKDZlxM1yAh5TZtb-ssw-1; Mon, 17 Nov 2025 17:39:15 -0500
X-MC-Unique: 46kKDZlxM1yAh5TZtb-ssw-1
X-Mimecast-MFC-AGG-ID: 46kKDZlxM1yAh5TZtb-ssw_1763419154
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee1b7293e7so82795071cf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 14:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763419154; x=1764023954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9XijziNlOnKQZVQqlX3I8vq+83B68kRlfGkDl8KnMyU=;
 b=CMjQuOoNUn4nmj1wV58CDEmDIY1FQCc980YmwVQAR95IsDWzJByOm6JesUvF3W8zOV
 vC5fWLIF8uXWMJQ/Tv7WL6pf16wapknczemTzbVkMwXEpuCPxWoNS7hDF+6/RCCIWyyt
 KXLa729qr9Cm0O7gZDUQI6r7X64seskLWuJVUigq3K5x/EjU04oYKMC89RjedJvwUVV4
 I9v1CfhSH0XdetOU369z3v+1h6XxNWEhDIY5kEoL+pSz0IO7EyUNMula7/8Y21Fxqa3M
 dfWFhvCQQiIhptp+oI685cAoUSIoLReTczAuZ2xnSnRBQXGAK1gBcjuU5Fxdcv2tnJcC
 6pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763419154; x=1764023954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9XijziNlOnKQZVQqlX3I8vq+83B68kRlfGkDl8KnMyU=;
 b=GIXNRT0sfedYmnGYRUJZo4+oU72TqfwlMikytWxlcF7/v7k84KyoJ8+IiHdQNrxgzT
 nc2RgKtvhdiclOAVxX5ZjR0HVuUiJpr5LN1WCLMv9deSYPUNwwfpskCoFo7fkheFqmzb
 LhFUXP41KEEw32o9RuCHremXrtcHcCkzV5CFDbAov5QWf7Z5TzCuIaI0qTRDoCiakPhL
 lO0dmxjSoDPUwwRzNsPnAVWUh7P//0fuWGq7YvactBSfv8KZCHKe3/YeSBJjMjuelw3l
 uHLgkrhYsu4BhvZEmxUdB0uSdwsF+Bp16CzP5qtxGU4fkYcN6uacvFczRtPXf73DeHVw
 gDIQ==
X-Gm-Message-State: AOJu0YxkNh6Dj/IY9nP3KVnEdM6f0zow4RLre73twUfiq/Fc/WLoojbV
 6lCp9XjAYgDKlxRfMc2iy0uuTI5LsEbGOOgbwp3w62oNrryWPgBjLURurRnaGPzm0YU//KwPKsb
 R6ncMgg9Xai04L2EPToraTR+dvcPKDLHbY8jc/yA7lXV0pjLzDAG5pUwTB1EaPuYYkaKdvLDTbk
 a6jDC60SfiiR/wm/NdfoCQ2Tb6DO6GZLhLAFXWTg==
X-Gm-Gg: ASbGncuHlbn7edaI8rpICypDyIPenGFSocx1fgdV7WqR4l3KFsQI46yqRv7W2CmSSAx
 ie8N/4KAJDpvYF88ATgfh+T7wuJ47OHudY1TW09QRdBz0s7mSicdhEvJk4ri5h6re7BjrMe4l41
 zTxd2/9TZWUUnWoiuBoIubeybOuTUSWNw8ZtqpjebRAJ+gJ+bvVS2tq9c01H+7Q/BJ3J8c4W5WJ
 6YgaVQASeFDyEMBBmDHyu0nszbFFJH0Ci8iKnUDJ/FSApTveM0lmApTNxMBVMxJ/tGky0ulp4wf
 Q+u3pJG6wUPIlfz9DJbhU2xX6OK59LhCRF5epM6cK28TBb5FeN6YxnNgRepocsvYVFV9D103Vng
 =
X-Received: by 2002:a05:622a:190c:b0:4ed:aa7b:e1b6 with SMTP id
 d75a77b69052e-4edf2044e57mr198996861cf.12.1763419154245; 
 Mon, 17 Nov 2025 14:39:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG7wxJw20nKjWhdEzODr68WvE82TcZbVOWiCa7V+An6/3028DCKtK36HZCMGJJA51eH/LGAw==
X-Received: by 2002:a05:622a:190c:b0:4ed:aa7b:e1b6 with SMTP id
 d75a77b69052e-4edf2044e57mr198996571cf.12.1763419153821; 
 Mon, 17 Nov 2025 14:39:13 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee1c21ea34sm37693521cf.30.2025.11.17.14.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 14:39:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 0/4] tests/migration-test: Introduce mem_type
Date: Mon, 17 Nov 2025 17:39:04 -0500
Message-ID: <20251117223908.415965-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a small refactor series to merge memory_backend and use_shmem
parameters that migration-test uses to specify memory types.  No rush for
having it for 10.2, but since this is test code, we can also consider it as
the current two parameters are definitely confusing..

This series will also make guest-memfd support extremely easy to add too.

Comments welcomed, thanks.

Peter Xu (4):
  tests/migration-test: Introduce MemType
  tests/migration-test: Merge shmem_opts into memory_backend
  tests/migration-test: Add MEM_TYPE_SHMEM
  tests/migration-test: Use MEM_TYPE_MEMFD for memory_backend

 tests/qtest/migration/framework.h  |  26 +++++--
 tests/qtest/migration/cpr-tests.c  |   8 +-
 tests/qtest/migration/framework.c  | 113 ++++++++++++++++++++---------
 tests/qtest/migration/misc-tests.c |   2 +-
 4 files changed, 104 insertions(+), 45 deletions(-)

-- 
2.50.1


