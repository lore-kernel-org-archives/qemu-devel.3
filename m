Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB214CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 21:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSiI9-00059J-2W; Thu, 28 May 2026 17:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSiI7-00059B-Ur
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSiI5-00033O-L4
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780003759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H1cJCUPurLRutGt+6PlEeJ9dQOEP0gyWc4quU28TE+c=;
 b=dz+8mCvxsoWRESxxgMGMzesbdtOH5jrmZ1iRewRzbp7fRIxYUaUyJVUaY6CSMQZEsaMloR
 dejaLqwrvxCuYLJn171U9I5lZFwwennxeXVpQRLRserqxoSzQEO5s8shZBNVjUdMmemHGJ
 13w9KZmKdYIZNOujpo3NK0wDjMf1lwQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-dYYormrfMjumYJuETPlYEw-1; Thu, 28 May 2026 17:29:18 -0400
X-MC-Unique: dYYormrfMjumYJuETPlYEw-1
X-Mimecast-MFC-AGG-ID: dYYormrfMjumYJuETPlYEw_1780003757
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-914c5911be1so1030267785a.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780003757; x=1780608557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H1cJCUPurLRutGt+6PlEeJ9dQOEP0gyWc4quU28TE+c=;
 b=Fffgu2kbmZep3/JADB0wGsMhCB97UnQNqGnxQkMbDjsc7uXlx0oXxKvNDElr4sNVFU
 hekIdASMTV+WMRBLLh+z/8HBL5poOW4q6lrAilYjQ6uwTsEOSR82LNgoRMg4tl1YgFZd
 pszJIHY0Lsu3IBjb5SYINXZV+aa2u92ewl3HVTyrKo0YSGYyUpq5r7fGu4Xw4w3rTtny
 xhevIqLOLHMY9aZWoeZFwS0AnXbroErJXOqM2yAcqOXv4pzSZA08wqLDpngIsUTCfiz+
 mYSLCspwlXDYYiwnAN+pKAHwHTTLt1sLIJ4IabWfk1D5obHVH3iz9onAmwrgYiu2iikK
 IMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780003757; x=1780608557;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1cJCUPurLRutGt+6PlEeJ9dQOEP0gyWc4quU28TE+c=;
 b=CfOAQgAmE48q7OeZdxdr24kWXW3CZvLL8EnaHCmYKpWbHOJTJ5XC6LEUZSHMukts8G
 qXUP907ld52/BgP5h//FCCwLYdOb4hz+wZiN7YXbX4HJIcnXKTYPebKwABtC5jGaGXe9
 f3bYWfyl9VnbcYVZ8jV2p9x5998KxkfCI60EpKcaXsjM1l4WJP1FwL9tv6K6T+ovCCve
 3B/02MlcyxyB+M08vE1zrZhuEqx4bR1rvCLn4oD4N33yXmhupEfjA1ys5yrMzSUs/Ujk
 y0z3gzOk/kmdNEQYhePciBAuiEfv7c+bf5hbB2S+F1Irr52y+RiWcaJb7PLUqCmQcVVD
 Lm3g==
X-Gm-Message-State: AOJu0YxqmxO40tGcCMWcZNxCtLC46sylIz0VVFEOSwnLSAOf5rZFHgZo
 Cx2wBtlCeRZGIBcuNDd2mOlsPulNrY/oNhVigvPKxN8JD4MPhMz+MaHrUTr7I6hz82kOcpwKOGt
 jySYYCRn7bFNXRAr2gYJZWystsj6evIYlyqS1+YMghrw7ITqB0gtBupsz5hFmFyAq8zbPWYfgcB
 cVZcopxDijMkJdPusHBi+IRlgA2tX6JGpzb0Vf6Q==
X-Gm-Gg: Acq92OGYev5eXIMqhGyIZhbpu01vtoKaS64bdl2+4dJXakz5RDZ1FBy5msTr7gGxQTZ
 KOF6npf1V0x7bb/x7oAk5+nQtDE+E2nZwQPg/S+MwGKDz1MpKwTTbV69IaYc98/ZFZLPFwj8CYe
 1KAi2bmiiM2hT71/bN0W3zczcLjrMQfGh8qwqyoaTEwevcjSaF5M4t65zTQa+p3HhiylaOuSQGx
 +tXMQCf7V0WY1JScYcisJuBCwR5wg3rBQYnr9Y3C5RIe0mszmhSpz+gF/c8cWKWnoOI/GzBwqI2
 /3oAiKDLCbSRtty6MNyVJPXgNsYbQGQ7X51ngiZ7xxqkd1kxVTuGdBt3nIy4IbOf8N0qCyx2hLg
 pNpVL0ndJQt7V40qPLyCZ250OWhYQtp9IMq4NqZQEnc4Pho1ljSveyVU=
X-Received: by 2002:a05:620a:410d:b0:914:cc9d:e25 with SMTP id
 af79cd13be357-9152fcb7692mr14020685a.7.1780003757328; 
 Thu, 28 May 2026 14:29:17 -0700 (PDT)
X-Received: by 2002:a05:620a:410d:b0:914:cc9d:e25 with SMTP id
 af79cd13be357-9152fcb7692mr14012285a.7.1780003756495; 
 Thu, 28 May 2026 14:29:16 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9152fd10282sm5770085a.7.2026.05.28.14.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:29:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>, peterx@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Ben Chaney <bchaney@akamai.com>
Subject: [PATCH v2 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Date: Thu, 28 May 2026 17:29:10 -0400
Message-ID: <20260528212912.367967-1-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/2560168907

This series introduces a generic way to specify migration parameters that
can be used even during the early boot phase of QEMU.

One example use case that already existed is CPR-transfer / CPR-exec.
currently QEMU has a temporary global variable (incoming_mode) to achieve
this, but it's hard to understand and this hack bleeded into quite a few
places that we could have avoided.  The lines in patch 2 touched may
provide some idea.

With a generic approach of setting migration parameters with cmdlines, we
can remove this hack meanwhile QEMU should be able to keep the CPR behavior
as before.  To CPR maintainers and reviewers: please have a closer look,
even better if it can be smoke tested, to see if this works for Oracle's
environment, TIA.

The 1st patch implemented that new semantics.  It is straightforward: now
we can setup any migration parameter using an extra line of:

  -incoming config:key1=value1,key2=value2,...

So far only one such instance is allowed for simplicity, but it should be
enough.  We still allow multiple -incoming for specifying channels, used
together with one "-incoming config:*".

Then parameters set this way will be visible almost anytime for QEMU, for
example, during initialization of device backends (which is before
migration object created).

I posted this series majorly because I want to see if this will make a
possible new user for the new "local" migration parameter proposed in
Vladimir's series:

  https://lore.kernel.org/r/20260522120534.77653-1-vsementsov@yandex-team.ru

Especially, there're some context on this idea too in this email:

  https://lore.kernel.org/all/ahdI7Vl5KraK566D@x1.local/

With this series, we should be able to drop "incoming-fds" TAP property
from the other series, instead relying on the existing "local" parameters
both in migration core and in TAP's property should suffice.

One thing to mention is I didn't further make only-migratable into a
migration parameter.  Logically it will also work now with only-migratable,
but it then also means I'll need to convert it to a parameter, which will
be mutable even after VM started.  It will change how only-migratable used
to work, hence I skipped.

After this, we also almost have no reason to use -global for migration
parameters.  Capabilities are still not supported in -incoming cmdline,
though.

Thanks,

Peter Xu (2):
  migration/vl: Allow set parameters with -incoming config:*
  migration/cpr: Opt-in "mode" parameter for early boot access

 include/migration/cpr.h  |  3 --
 include/migration/misc.h |  5 +++
 migration/migration.h    |  3 ++
 migration/cpr.c          | 18 ++++----
 migration/migration.c    | 91 +++++++++++++++++++++++++++++++++++++++-
 migration/options.c      | 10 ++---
 system/vl.c              |  7 ++++
 qemu-options.hx          | 18 +++++++-
 8 files changed, 133 insertions(+), 22 deletions(-)

-- 
2.53.0


