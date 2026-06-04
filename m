Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6C7CD6E77
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHDs-0007Fy-PU; Thu, 04 Jun 2026 19:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVHDr-0007FR-9z
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVHDp-0006L4-P5
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780614688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s2/VGKHPP3HSs/v0+qkNWMdOThMHywTNd2aJhud9Pic=;
 b=L5QFzlIakaOU72G+VPgv2500WRD4QiPlavIdNUUbm9A2o+bDjoR2YpWNouPwvRAOrl2K9+
 qqKShixFXeUrUQpPdSoDcAx2VIl5ZaHxOKUA44WluAJOw/EkqNRthxhUPKT0BxctoUVewM
 eGG7iexd1z+/zYzVEa6V6St7GLqE9rM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-p2KPdfpmOjCf41QZx5NBwg-1; Thu, 04 Jun 2026 19:11:27 -0400
X-MC-Unique: p2KPdfpmOjCf41QZx5NBwg-1
X-Mimecast-MFC-AGG-ID: p2KPdfpmOjCf41QZx5NBwg_1780614687
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9157b94a014so111055585a.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780614687; x=1781219487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s2/VGKHPP3HSs/v0+qkNWMdOThMHywTNd2aJhud9Pic=;
 b=tcdbO7fa/9pfBbIM1Rwu2frb9XLj+gzCTT2rkan/2yviJszDbyISFrBMc3SgKni3Uz
 JE0x05jb2dUcjJAQCjzARgY78VPAQlm9pOP7v79I6dNo0TpvJJoixr4cGSOIWvdeh7T/
 impcFZ/3K5dqiWHQdzMa+e4R/HtR5VFPCGKm7PEgEK1VsMe6v+0yBhCpfFDewTn//NYh
 nTtDEBQMuxuiQshZgGK/YCDJDJ37hO4TfFiCD2/fsj0Yy2PBhpiefRXMcI//UroWdLCO
 NVs27g3Nju/P1xfExjR8Zot1XUEbN5xH8AcXG/rsaEk5j8y6OM2E89ZTFkzZEIR7XNrv
 kE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780614687; x=1781219487;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2/VGKHPP3HSs/v0+qkNWMdOThMHywTNd2aJhud9Pic=;
 b=UVI7ZRhp2jxL73XxAx0uXejZqTwrReaIj37/lN+j0nAyZQ2n2wAdlrPWe5fvC1dPno
 jSrFDLHwrviA4qSppwagOCbACjpriJv//mo4Y79DlHLRuu+i3HuL1bBGATOxtVSKCU7e
 cVKhUDwvv83/L8hgi0kBYbhZ1Uey4RQFj2XJnuLOyHw0mZ7kH/A32SPIrd26yk9ru3h0
 fNT64vvwcwGbTaeVlX1U7pL8u6LjeoI23fPULFF7e48C44WXs6bwFPdcfWm//hOP9FXY
 azt5ACYw4E2IWAv8MLJjmaXOeLECIPCbjU3G5g8HQ0jFCKnXeMcM82zD0HrE+4n881QP
 AXZA==
X-Gm-Message-State: AOJu0YyiY0HqUAfr7ASy9PNgVNFQ77m6gh0jbRLlhbLn9feDFYBQStSK
 CT10qYpck0HcDedyOTqCobV0nOiBZf0aFIVZn+94aKamuXhl3wOIOrZN5iR9RikXY8QH10U92PK
 jv/nARwAymeBMlt8+OVW187Yk4YJ4EsVCLU5EaWNUpd8IpPAxeMEEYi3Y/6vW1kfCZkK2lmGQ+K
 QFoxt6nBaVkZ1KkrpK2s/OrF6etOAbfN6KH8YwoQ==
X-Gm-Gg: Acq92OH9SRyGu/o+72G4Wre8rFlRTOTkPSulRtDSmeiCsFUo+dcMSxZa9JmfFG4ayv6
 Le78ZwG+0Dkl7SPDY5gNR8ggFPsJYDhv1kHf5M7+e9z/Icf2mKmogLZ5f490OG9doNi+6Z0ObSK
 w7qBBTWys5FQUPDFZCbMWSzpA2LOXuUyRK4qw9QW/zts33xTdh2jJRxK4KdGBJcG9i6k1T5krbL
 LSnkVsdZeRKGDLzOZVf4TKjprb30+3SgXbbnzBBQ6Tg7vCRDeqHcdb6FVPWQL2+EskEXyWwi45u
 rGdDZOZckpt6EylNCNTes+8eUKGJBcefM7+awTdZH2iCzMfzA6TiW3m8hN16Rzz8Tws7ioBaCum
 7tjT2bo9KW+9Nf7Rxlu1t/Ak=
X-Received: by 2002:a05:620a:4802:b0:90c:e5b5:65f4 with SMTP id
 af79cd13be357-915a9c35164mr240376485a.2.1780614686547; 
 Thu, 04 Jun 2026 16:11:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4802:b0:90c:e5b5:65f4 with SMTP id
 af79cd13be357-915a9c35164mr240371285a.2.1780614686001; 
 Thu, 04 Jun 2026 16:11:26 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a37cab6sm707617285a.22.2026.06.04.16.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:11:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Sana Sharma <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 0/4] migration/qdev: Remove TYPE_DEVICE dependency on
 migration object
Date: Thu,  4 Jun 2026 19:11:14 -0400
Message-ID: <20260604231118.1584889-1-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/2577688365

This is v1 of the series, rfc can be found here:

  https://lore.kernel.org/r/20251209162857.857593-1-peterx@redhat.com

I got no positive feedback on OBJECT_COMPAT in rfc, so I dropped it.

This v1 removed all OBJECT_COMPAT patches, instead migration object will
stick with custom instance_post_init() to apply compat / global properties.

The goal of this series is to remove TYPE_DEVICE dependency for migration
object.  As a side effect, making qdev-properties available to all objects
not only qdev.

After this series, other TYPE_OBJECT can also leverage qdev properties.
Quite a few features I liked:

- simple declaration on setter/getter/defaults, objects can define, e.g.,

  Property prop = DEFINE_PROP_UINT32(...);

  Then in its class_init(), do:

  object_class_add_property(klass, &prop);

- support compat properties, and one more line to support -globals

Two things I intentionally didn't do:

- Go further to remove qdev properties dependency for migration object.  In
  that case I will need to implement most of the qdev property logic
  separately, duplicating code.

- Go further to make qdev-properties to be some generic object-properties
  concept.  Logically we can do that but the rename all over the places
  will be a huge diffstat.  I don't want this simple and straightforward
  change to be buried inside.  So I hope (1) either it's not urgently
  needed, then we can so far stick with calling it qdev-properties (say, if
  we try grep qdev under qom/ we still get something.. so it's not like
  we're 100% cleared out on that..), or (2) at least it can be done
  separately as a separate goal.

Comments welcomed, thanks.

Peter Xu (4):
  qdev: Pave way for exporting Property to be used in non-qdev
  qdev: Introduce helper object_apply_globals()
  qdev: Refactor and rename of qdev_class_add_property()
  migration: Remove dependency to TYPE_DEVICE

 include/hw/core/qdev-properties.h   | 11 +++++++++
 migration/migration.h               |  2 +-
 hw/core/qdev-properties.c           | 36 ++++++++++++++++++++++-------
 migration/migration.c               | 33 +++++++++++++++-----------
 tests/unit/test-qdev-global-props.c |  6 ++++-
 5 files changed, 64 insertions(+), 24 deletions(-)

-- 
2.53.0


