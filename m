Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94614D0EE1C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 20:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNzxG-0007qI-Er; Tue, 25 Nov 2025 15:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzwA-0007Bs-EY
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzw6-000306-Gg
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764103612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cZM94hKcTmB2bsWAHmr3zVjiqyDyzbn9JViQoq02uG4=;
 b=LLyw3BPhqKmB7beCe+u2Yrn/C9QWmwfLaSTuUQ6sha60Vm8MA77iutBEMWFjQr4PWbD9dT
 3Me3jgZUXReRjTttArq2mSeY7V+LRiITXLVhd5JMACaPcn7dYnvyldWEQzEsexmhjRNyXp
 QmSzJcSP8dRg/4i7EAHYRDfUxCatOic=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-AZHV32PeMhGaWT6_0rt4Aw-1; Tue, 25 Nov 2025 15:46:51 -0500
X-MC-Unique: AZHV32PeMhGaWT6_0rt4Aw-1
X-Mimecast-MFC-AGG-ID: AZHV32PeMhGaWT6_0rt4Aw_1764103611
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b30b6abb7bso1485961485a.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 12:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764103611; x=1764708411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cZM94hKcTmB2bsWAHmr3zVjiqyDyzbn9JViQoq02uG4=;
 b=GrRkAAdF7c6VqvTtWRGuLdmK9v7U6GhOnpxWWEmxWApf8roy1wDZ0txQHDKQLqjrMU
 k37TcBapwk5WiSN3wyeUecvjd+MAII7aNU1ToB+Si5dd+JSynbmsG8rgEJNaa1jle2et
 9bjpBA9sN4fqLw7ihPH/eMn7BdVwlQdbr5af0tp6Jq5JxjI2Nt8Wp7i70SOMPqj0KU03
 IwbxdsYFF/AQpo6gXpBkGA3NmxJC+E6RHklCpQBcRmX1veX3dWO63fe1OySeB38sjhiq
 8dceGkEy5VeGtdZbC/UEIjvmxTZqb6PNqQpEOvyOSqtFwiz3QZ7Q05/palJvmvdcDEeW
 qGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764103611; x=1764708411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZM94hKcTmB2bsWAHmr3zVjiqyDyzbn9JViQoq02uG4=;
 b=ums5FWZsM/A4kTyvJ4it6GmWM6psxmknWKh81lw2dLD8sG4IbcLxN/Pic7TGdlToAd
 RRakq5FPzf4Zx8y7ohKLVGB+d2sTOXccj7hmlLW/6cQLan+pHS/W3yrcXq87OSCcMZM4
 O5U/yWe5BN9XMJ14dXpN+eVCNWyQ3YZRLPl54Ow/nd6ogmiDtqmU2gsotgbwsLBxGtBI
 PoQqN928VqEALovErylvrkJhJw+Q4B3vrkodJ+iAIcXDjbIkzVUQWxzG0a/7lavu+Sqn
 bSpg0TGBya9WPvZq64C76C8whC/qH4VFCqQWGkDEjwWJesqOaz7tQdtBu1YnSR4Xnr0E
 POAw==
X-Gm-Message-State: AOJu0YztNIJ3un61b7DcG41IxcjR6Nlz9kwjfVOhrT+NoI6SrpdCbSEM
 wDVmKYKhtC03qQIESKCkkZUYBgk4izjGmscuIZNPDkfQcGc8mCDBhE3KeUT2aXFDyYHSUzt/BaX
 +mp0U2+nxsBbQAurv8RrlZoyNpyfEOvKO4UdB//V5EfmLyQ44Enzn7sqpORMpY8Hln23TcubjWX
 U335uGZUe6a9a9s8EigrxQT2HcaKdEIUbq0C3lvw==
X-Gm-Gg: ASbGncsH+vq65U5XQWMHhsmIR4eZHdKpU0de7Be68lpdU22InBQ7nIokbYnL+6yO+8q
 Sj5R1hyefGrAPOfmiKLRibfhEucsEaxrDFaln8oThVuxF1hd8ZNP6MIu1v8aCOQoi+WaKIfhhBp
 u9nWoSSI9QZEN/NkV2CcveyP9B5LZ9Ohsy3DD7p//KfxLnMwxTEHcl2aFJLOhqoGmVE1j1k241p
 pk02ne1aJckntWyCjb1QQSZjix0+22JUurD037AfT8JWY17PgR1Op2fzYZPqnfx7ii01LGxLkcX
 KCa4QBe+PJfONBnmO0QV/uq5qzA4F2lsDG3+GnLzb6AhcysJnvLCPTqke5Oe/iYpkYdPDDvuYMo
 oNWk=
X-Received: by 2002:a05:620a:172c:b0:89d:516c:7f7d with SMTP id
 af79cd13be357-8b33d4cfab7mr2000661085a.55.1764103610594; 
 Tue, 25 Nov 2025 12:46:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfxuk22SqVMdbMiqz3nXapjtAZdBOsvW0Tk/dOLVHO9q9oN5fTTRPJ+4F+ZWfkeM6vL5Vh7A==
X-Received: by 2002:a05:620a:172c:b0:89d:516c:7f7d with SMTP id
 af79cd13be357-8b33d4cfab7mr2000657585a.55.1764103610051; 
 Tue, 25 Nov 2025 12:46:50 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295c2276sm1250794085a.30.2025.11.25.12.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 12:46:49 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH for-11.0 0/6] migration: Error reporting cleanups
Date: Tue, 25 Nov 2025 15:46:42 -0500
Message-ID: <20251125204648.857018-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

[not -rc material; target QEMU 11.0 only]

Based-on: <20251125070554.2256181-1-armbru@redhat.com>

This series is based on Markus's recent fix:

[PATCH] migration: Fix double-free on error path
https://lore.kernel.org/r/20251125070554.2256181-1-armbru@redhat.com

This series should address the issues discussed in this thread here:

https://lore.kernel.org/r/871plmk1bc.fsf@pond.sub.org

The problem is Error is not a good candidate of g_autoptr, however the
cleanup function was accidentally merged.  Luckily, we only have two users
so far (after Markus's patch above).  This series removes the last two in
migration code and reverts the auto cleanup function for Error.

When at it, it'll also change migrate_set_error() to start taking ownership
of errors, just like what most error APIs do.  When at it, it is renamed to
migrate_error_propagate() to imply migration version of error_propagate().

Comments welcomed, thanks.

Peter Xu (6):
  migration: Use explicit error_free() instead of g_autoptr
  Revert "error: define g_autoptr() cleanup function for the Error type"
  migration: Make migration_connect_set_error() own the error
  migration: Make multifd_send_set_error() own the error
  migration: Make multifd_recv_terminate_threads() own the error
  migration: Replace migrate_set_error() with migrate_error_propagate()

 include/qapi/error.h             |  2 --
 migration/migration.h            |  2 +-
 migration/channel.c              |  1 -
 migration/cpr-exec.c             |  4 +--
 migration/migration.c            | 51 ++++++++++++++++----------------
 migration/multifd-device-state.c |  6 ++--
 migration/multifd.c              | 24 +++++++--------
 migration/postcopy-ram.c         |  5 ++--
 migration/ram.c                  |  4 +--
 migration/savevm.c               | 16 ++++------
 10 files changed, 49 insertions(+), 66 deletions(-)

-- 
2.50.1


