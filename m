Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7BCC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wooyW-0004T1-NQ; Tue, 28 Jul 2026 17:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooyU-0004SP-Fi
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooyQ-0003h0-RG
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785272665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3h1Sa5TfcBS+pC68pQ1cpVltoKAGBD/f3Gyj7atkP2Q=;
 b=ewHrIwSlz4nnBtqf8hwqyoznpHsL7H3fJyUZUA0F2ZZjyFsC0tbnjpardulivVlm9YvOf6
 I1/MP1gZwTGRzeIh139KHRzg37VP2sDiAwznQpgMze8SWzr797Yzn+f5rCzWpiEyKzS6Bx
 0MHr9Ir50YD4p2Ya1ZuvCY4cYekIH5s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-rc0HO3BbMuChvcuSTQchkA-1; Tue, 28 Jul 2026 17:04:24 -0400
X-MC-Unique: rc0HO3BbMuChvcuSTQchkA-1
X-Mimecast-MFC-AGG-ID: rc0HO3BbMuChvcuSTQchkA_1785272663
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8e9489f62bfso3205016d6.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785272663; x=1785877463; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3h1Sa5TfcBS+pC68pQ1cpVltoKAGBD/f3Gyj7atkP2Q=;
 b=MxetULf3gJlkrlciXMeiTQmT84FQF6ihRWnMZAMly7cjH0MSZqoceYI2saXzWMqzIB
 1zBxH15e56U8psA4+FGtfQTkw8Zw/o0s8NXqiWec/lintFwpbAydQbIsFeykCvI8NGg/
 0pAgWwgeLl4jcHrNF2vbIjxWZ8p7V73cSjqU86Yi0rjaIL233+05ckPIS+2MVzOXJAdA
 0IbGPN1Fc/9F+7xXkhy+n/2jmt92XFF0VUQ6Cr5V3po8ZUxYyb+2+2bId5j+SmpGYG2M
 kYGsLLjP4Z7VVBDlygAyH1D5qg+Pl5GyWJEySJuaCTlCnNXE06Ej4/yGYZ3jBHr6Pc6T
 0KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785272663; x=1785877463;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3h1Sa5TfcBS+pC68pQ1cpVltoKAGBD/f3Gyj7atkP2Q=;
 b=pzjDXTlaqrGyOQbCTD+6cU8iP2RLjYyOQtvSiqxgsl1WXr43/h1QwZSx6IXT73+qgG
 W8mZobE5GP5ntZK8c/3tUJLg8sYPKjXFvpvTDpZk/yOdVwQSgjLVXWN5Hwjc1fwINbTs
 d6H3f5Zt4PKZyF+PBhWpLTEvtKoAtS363ELZ/sP1UuG4wh13dYQjcxLc+/lxp2Gk5aGe
 XJPI18Xl8bGlfhDH0TPD1NNLnlOTr1dje1bjogTQGA48fPvToiz1MxchjkeWsgm9cRNq
 M2n3LA1x96M61chTCwbHyNKrEQ9A8+yBHu9s1k0iv0vjrQphu1Rlf5MdlPXAuuO1X823
 DngA==
X-Gm-Message-State: AOJu0YxTdiCscNCOm4NkbThC8WCbP+83EA0E77OxGE4QRH/CaMJQZ+nl
 duVecjcx8a/qIVORAW/pI/v5NfT5F2Cs56qPE1gqyy/qRTWrXvMfvlFYgNDDGvdzNNu5t2vv5yk
 r0LUHT4DPp6QW/CXOtnwPzSA1yf3Dqggbc/o/bswep2bxOG7h0i9Lz+uHQKdCO3sfL/VYOEBnFI
 O+FQ3lxceyEFXzSvhfVxPH6XevNgZ3tBS3GKGXNA==
X-Gm-Gg: AR+sD10xyTnqg+ClnJrVVzKtlhb7fnbaxKoGw9Ok90IE6ZveaIxUauCQ0agZ52UOn7w
 RSgWef4SSbJj8ln32atyrPm5lr5Ah1baBxZFR1SSQaVhec1oDXogRQ3UtYdSsHU4N/GnhRpPeiy
 +DEssEz+HDYyd0REc1319aEN4tfyE4EbSyoJb4zQjUT+3Nav7dggPBBIdGtXqK9uog+pPMRDFXM
 ucFkrcujcor2PNf9uQgbiUD4mz41OISqmynOkn+G2I0JD3HQkEEdZK+NgTK3GffIBgGHxl75Wdj
 1a0v38u9jmPTGi091v2BbrQpqKt2rz2zBu5nzQiT0/40RYwvlbgTKnR8LJpqVVfOJXSwsvzPYzX
 kzfTMJyCLQ+lzf/Cl0Eu4jrc4QKfjuz2lFVQ5rv90nGk9O2kcREzKGTzI
X-Received: by 2002:a05:620a:470d:b0:92e:c116:bf15 with SMTP id
 af79cd13be357-933027d0b32mr447763885a.94.1785272663356; 
 Tue, 28 Jul 2026 14:04:23 -0700 (PDT)
X-Received: by 2002:a05:620a:470d:b0:92e:c116:bf15 with SMTP id
 af79cd13be357-933027d0b32mr447758085a.94.1785272662681; 
 Tue, 28 Jul 2026 14:04:22 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933d3227707sm21277985a.6.2026.07.28.14.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:04:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH v2 0/5] migration: Hardening fixes for 11.2
Date: Tue, 28 Jul 2026 17:04:12 -0400
Message-ID: <20260728210417.1925078-1-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

v2:
- Added R-bs
- Patch 2/3, update commit message on wrong use of term "release buillds"
- Patch 4, fix bug Dan pointed out, use assert() for !coroutine, update
  commit log

This is a small batch of fixes from recent reports on migration, the plan
is this is only for 11.2; we don't need to rush on any of them.

RDMA migration has its own small batch.. It'll take slightly longer so I'll
send them separately.

Reviews welcomed.

Peter Xu (5):
  migration: Fix possible overflow in vmstate_handle_alloc()
  migration/multifd: Validate next_packet_size in zlib/zstd recv
  migration/multifd: Replace assert() with error_setg() in recv paths
  migration: Fix rare hang of migration_channel_read_peek()
  migration/ram: Check for RAMBlock size mismatch when parsing

 migration/channel.c        | 11 ++++-
 migration/multifd-qatzip.c |  5 ++-
 migration/multifd-qpl.c    | 24 ++++++++--
 migration/multifd-uadk.c   | 24 ++++++++--
 migration/multifd-zlib.c   | 11 ++++-
 migration/multifd-zstd.c   | 11 ++++-
 migration/ram.c            | 11 ++++-
 migration/vmstate.c        | 91 ++++++++++++++++++++++++++++++++------
 8 files changed, 159 insertions(+), 29 deletions(-)

-- 
2.54.0


