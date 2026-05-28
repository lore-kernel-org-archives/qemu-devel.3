Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A608CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 21:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSiIi-0005E3-UM; Thu, 28 May 2026 17:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSiIf-0005Dc-UU
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSiIe-0003Ai-2Z
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780003795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H1cJCUPurLRutGt+6PlEeJ9dQOEP0gyWc4quU28TE+c=;
 b=K4E0oCMoDIUe2qYy+enc9Fi/g0AC6onfaoIc0cdQIIIcSrYR4+h0iuxeerUPnr5XNXR6Mg
 /WZTHs70p8WZ8pZtF4Dwm1s9ifmI+Hbc5b+N5mn22d2KKggyKAWZqOEd+bY4iLHu/TGjAg
 OTUeVIFap0CRHK2LolprrI2ftdlmjAI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-atdKLbGcMOe47lYVQKut_w-1; Thu, 28 May 2026 17:29:53 -0400
X-MC-Unique: atdKLbGcMOe47lYVQKut_w-1
X-Mimecast-MFC-AGG-ID: atdKLbGcMOe47lYVQKut_w_1780003793
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-914b5249bc1so1097787085a.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780003793; x=1780608593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H1cJCUPurLRutGt+6PlEeJ9dQOEP0gyWc4quU28TE+c=;
 b=LJZm1qAZUTSPyN125azH8vwXpH7QqcTEtvpzfEag7hwH9JoVSlf+tXBOS+kq8hE8Xw
 ymCHBwNtOxmpwoKCoFp1aKECJw0yTl8wwVwy1LhZiiCZRHm2f7edmoF4uWRCDZ43FOae
 Y9INQZfizDPPS2AJPvkV1UUZT6KJXqDJoDirv6WKBWDnPcJlQIAkf/Uct2ikpRoVEklY
 GU+rVD+YLKTy170eV2HWhQSpACOsEhWkUzF+zmfRAOSV5yjaRSq8zTuklPrGCYeB4Gwa
 Eu3Txk6rTD96yV0rnAS/dkbLBTMEhOxXD05S8cwQZi8LHO1iaO/6eHF9Ff25VFD2QPr2
 p5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780003793; x=1780608593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1cJCUPurLRutGt+6PlEeJ9dQOEP0gyWc4quU28TE+c=;
 b=LoJwywBWxf9B9Y4fKmR0kxTpvIxMX7gC3kugP/zUZIQj3ET4vgJY+uwFl1/cQ8a7aI
 ApeTEK8V5Os9P6KHaM0VQkhl4FZfRBXxEVLteWg90NC9T+fm4zfgleYY/cfDKSC/cu0n
 NjnrLVw0GkJfZkCenIbnI9XOP92GaW9CHtbLwZoKyFG54o6n+jkmLNO9Xi+L1w/yFpTW
 VeXNduySOU5jJpzr6bZHkJ7EFVl/c4cI1MybsBqhbxCLBbGbHETWea6TQmyrsfUN11UC
 gwy/UX30orAEkLWVT79OLCAogmK1bvPl2fXcOUKVOKGCgLupQp20QeVn2Q9L0CsrV1kY
 hmgA==
X-Gm-Message-State: AOJu0YzW4mzx4XzyKGCZBOtRADV8CV11Aaasn4QgYMCcrng8eNU0hhsy
 8JZ7fsfMb3jyErObPaA4atpefbiPjmz8RG2ZxKc2h4I6cH+sqJIdPpfoUMATgmTEnCVhDOubtvS
 U6X7SWz5GJzmpNYXW7LBA+qxQpmjklyc48laudIu8KyR2di5imHKSuKWO5p01p7URjdvghjyukn
 LAR3sqnFlYCvIUNVYqsWdtcG92UCcvGJnsxqLBqg==
X-Gm-Gg: Acq92OGBtdbvrwAHnSaEVDH3J+FQ4atf5bM42ibF0sbuCPK8wTsfIiKwTah+2v5pPlP
 xAeWtEucLNwVTzlOUbrXWXX2Yed1VRT1NuQsaGYxUpFV5DlR7K/i8vlxWhkRZtEA40zQYNc6GU9
 Gx2A6SZCArWNPyZfhfZR5hN3pIN+ZT1Et9VjdX52xW2kyjBe4TTDHmsvnivCWIP1krS4FEqUKvn
 93yFDv0Lv4awu/T8uZZiyKLdQy3wSSqsB/d+Ya5AOOeEMzWInvd3ZJ+/7boDnvFsPtVyDTGEBLV
 b2m8bUuzT7F+F8jMMvoEr+SJoSakd0ltX8ZLQitAnLHT0mS7ABGA9a0MSNo7LQtdlXVyPpROyhg
 EGUM9pslT+p96ng6fy73QrNkoBRjTUu4NoBhjstkdVDLVEUD03Tezjhs=
X-Received: by 2002:a05:620a:f15:b0:90c:fe9:84ef with SMTP id
 af79cd13be357-915300d021dmr4183185a.61.1780003792915; 
 Thu, 28 May 2026 14:29:52 -0700 (PDT)
X-Received: by 2002:a05:620a:f15:b0:90c:fe9:84ef with SMTP id
 af79cd13be357-915300d021dmr4176885a.61.1780003792337; 
 Thu, 28 May 2026 14:29:52 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9153012a673sm1259385a.46.2026.05.28.14.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:29:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Date: Thu, 28 May 2026 17:29:45 -0400
Message-ID: <20260528212947.368132-1-peterx@redhat.com>
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


