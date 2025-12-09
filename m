Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB9AD3B981
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0ae-0006I8-6D; Tue, 09 Dec 2025 11:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aO-0006Bb-G6
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aM-0001wR-AV
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765297742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZIZVD+EjJyVwQDfKOliaUgK1JCG0KzBRk/iCy52TEgo=;
 b=fwfzpFmZxyVfrdEmhvec0oqrg/4YScMfxm3wSDHhLhBKE57LpnkK3O2USolBhzjZgCTyEL
 ekH2m9/Q7HxfwCN4f67k1j8/rlqkGLmlFOqULp0SwbzGPOwmtIofgVwE2HBQMMuxPLHI17
 S3aL3iyRJTjXPxOI/XlHH8iWDY2VJok=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-EeIWAQT8OKet-lbhcMM9Cw-1; Tue, 09 Dec 2025 11:29:01 -0500
X-MC-Unique: EeIWAQT8OKet-lbhcMM9Cw-1
X-Mimecast-MFC-AGG-ID: EeIWAQT8OKet-lbhcMM9Cw_1765297741
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88233d526baso171669766d6.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765297741; x=1765902541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIZVD+EjJyVwQDfKOliaUgK1JCG0KzBRk/iCy52TEgo=;
 b=Y0B7brGRC29Qsz3mDzG7tHvS48VBt0AoIHKUgzYgAPDwk0plroz+7ODLnTXepMFQR+
 UAM4NQH4K0/9h2PfPyLcaoorZ5DjdAnVK5DTwUodXZBT33Kr/Y1+Yt15waE2zYJJ1KIp
 sQEbs+u1kmloCJQz4hGbVD2ZzSDG87eSDMnrrXvwsivIOwrRDbMdcZPRpXjOusNU0KPu
 +tGqxx2yDBWv9MgS/TT3Q+zwASZv6lFzGRyqseGQbbUhl0q9Ov8QjkOOshrlIwJ+/r6m
 wLh2WCBVv8N8Z7y8Oc3EJmYx2cEHYLAmxfryeSnCzOFfXFLEl06a+8Sk1awjocY18jB3
 TGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297741; x=1765902541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIZVD+EjJyVwQDfKOliaUgK1JCG0KzBRk/iCy52TEgo=;
 b=fL/SNX92fkIcvREkOwJAsRbOQjaXR0jnAoerWXyZ5kY81r1XMeRjTfcUjy+I7rPclm
 bBQAIMIG3v6RJsZuMsShtzsJ8OePpsZCqSxSe2aCQ757kbjME4aSaVQinTu4G2pEucv+
 C3viT+viZ1yQ32NBy8tILSNmxTkyiOITQ7Sox9qQOX6aIcBr5/tKpL9wSn2XHEGpBjYD
 0zmuWmigprpnwWo4b1s0BFaBBs64CfTX412nKtdA/YGcbZrSeJbBEYn4VkSC4SMDsslb
 97Fbyn+WNGE/n6wHynXP7fUrEVr84YY6MjyUG2Qb6sI9nMAIby1oOFWnOiXMXzfnEbnd
 o6GA==
X-Gm-Message-State: AOJu0YxVO6PQKeEZOVO8eifRVm0uzLEvBxJEyM29YvZe2BRqAk2zzbCP
 sMQmBafTXhLcTFhDvsp0Cr4XXmTRSsedCyeNHbvycdBjLPR6PwK4rx+yqKZlB31RoXw7mCoMkrT
 wAycpDXILQSiyDvKQKu1Uc+NxCgXSLPfIG3iVO9lMyK54oZUK9jF6jOn62DK9LgHIKkNuY0+sGG
 00Uzae2tiXIcLuS2xb75ALMg5mfL3ttS9kg9imxw==
X-Gm-Gg: AY/fxX5gTdHi70OyW6hYwOeNWjPOhP/6AfU+w2VVnlszj43ohAsXb1o1SkbYxIYU78H
 NrXCZ2ZSlR6OLhDASIMnibwiWjzgsoaNZH+L8VlNuh3MHRSvsGh+2g8Z/crhp96U6KVDG+ktoOI
 z0pPTW3Uqyu26sve6GR8y1W+BlVDP3z/4/Ngg9yoq9zD5VBFfM9en0387v9O8N8o4RSyYGwONlL
 rWLrb4XBnsqOSDnziwgRFkl91LOogtcKoFVsqg+3013O7/uTm4ttXCCQOQL1deT/ISXqBMz+Wcf
 aQ2u0Zj9O8ISBHxQuHVWIc+O1/jrECRz/YIFRzy27lJFB4vJWgbA0dykE/9iua12+UbEfV7emfT
 w+9Y=
X-Received: by 2002:a05:6214:c4f:b0:880:4790:e61b with SMTP id
 6a1803df08f44-8883db618f9mr198962646d6.26.1765297740524; 
 Tue, 09 Dec 2025 08:29:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfS82XVLrH09a2OXfPJuL7K1lmO7BQ+WBF5FCc/9snispIqrY0KcGYdDbFDKIE5SkPaBw+qA==
X-Received: by 2002:a05:6214:c4f:b0:880:4790:e61b with SMTP id
 6a1803df08f44-8883db618f9mr198961716d6.26.1765297739811; 
 Tue, 09 Dec 2025 08:28:59 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f334d8sm131110256d6.10.2025.12.09.08.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:28:59 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
Date: Tue,  9 Dec 2025 11:28:47 -0500
Message-ID: <20251209162857.857593-1-peterx@redhat.com>
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

[This is an RFC series, as being marked out.  It is trying to collect
 opinions.  It's not for merging yet]

Background
==========

It all starts with machine compat properties..

Machine compat properties are the major weapon we use currently in QEMU to
define a proper guest ABI, so that whenever we migration a VM instance from
whatever QEMU version1 to another QEMU version2, as long as the machine
type is the same, logically the ABI is guaranteed, and migration should
succeed.  If it didn't, it's a bug.

These compat properties are only attached to qdev for now.  It almost
worked.

Said that, it's also not true - we already have non-qdev users of such, by
explicitly code it up to apply the compat fields.  Please refer to the
first patch commit message for details (meanwhile latter patches will
convert them into a generic model).

Obviously, we have demands to leverage machine compat properties even
outside of qdev.  It can be a network backend, it can be an object (for
example, memory backends), it can be a migration object, and more.

This series tries to introduce a common root class OBJECT_COMPAT for it.  I
didn't abuse OBJECT because I know there're too many OBJECTs that do not
need compat properties at all.  With this design, we can also opt-in piece
by piece on the new root class, only when needed.

Class OBJECT_COMPAT
===================

This is almost OBJECT class, except that it'll also apply machine compat
properties from anywhere.  One can refer to patch 1.

Note that currently I didn't further identify the three possible source of
object_compat_props[3] (accel, machine compat property, legacy globals).  I
don't think it's a huge issue so far because non-qdev objects will not
collapse with names in accel / legacy globals, due to the fact that object
names cannot dup acorss QEMU binary.  So I kept the changeset as minimum as
possible.  Feel free to shoot if there's concerns I overlooked.

This part is done in patch 1-6.  This is the part I felt slightly more
confident with.  Meanwhile, these will be the dependency if we want to
e.g. allow TAP network backends to take compat properties like a virtio-net
frontend (but likely we'll need to QOMify TAP first).  That's something for
the future even if applicable.

Export Property from QDEV
=========================

I also have patch 7-10 below for one step further beyond OBJECT_COMPAT.
Feel free to take it even as a seperate small series to review.

So far the first part will be the focus, but I still want to collect
opinions here on this second part.  This is about exporting Property for
non-qdev uses.  Currently, migration is the only user.

In short, Property is something qdev uses internally to ultimately
represents ObjectClass's properties hash table.  It's pretty handy to
e.g. avoid definining accessors for object properties, setting default
values, etc.  Then they'll be converted to Object properties at some point.

Migration object currently defines all the global fields in Property and
can use "-global migration.XXX" to allow global overrides, with almost one
line for each property, which is efficient.

This 2nd step will allow migration object to inherit from OBJECT_COMPAT too
with almost only a few lines of changes, and keep the functionality as-is.

Two other options we have:

  (1) Keep migration object to be a qdev, it's still fine, even if it
      sounds hackish.. if we want to keep "-global" working as before

  (2) Inherit OBJECT_COMPAT without supporting "-global" anymore.

Any comments welcomed, especially on the first half (1-6), thanks.

Peter Xu (10):
  qom: Introduce object-compat
  qdev: Inherit from TYPE_OBJECT_COMPAT
  hostmem: Inherit from TYPE_OBJECT_COMPAT
  accel: Inherit from TYPE_OBJECT_COMPAT
  confidential guest support: Inherit from TYPE_OBJECT_COMPAT
  qom: Unexport object_apply_compat_props()
  qdev: Pave way for exporting Property to be used in non-qdev
  qdev: Introduce helper object_apply_globals()
  qdev: Refactor and rename of qdev_class_add_property()
  migration: Inherit from TYPE_OBJECT_COMPAT

 include/hw/qdev-properties.h          | 11 ++++++++
 include/qom/object.h                  |  2 +-
 migration/migration.h                 |  2 +-
 accel/accel-common.c                  |  2 +-
 backends/confidential-guest-support.c |  2 +-
 backends/hostmem.c                    |  8 +-----
 hw/core/qdev-properties.c             | 37 +++++++++++++++++++++------
 hw/core/qdev.c                        |  6 ++---
 migration/migration.c                 | 31 +++++++++++-----------
 qom/object.c                          | 16 +++++++++++-
 system/vl.c                           |  1 -
 target/i386/sev.c                     |  1 -
 12 files changed, 79 insertions(+), 40 deletions(-)

-- 
2.50.1


