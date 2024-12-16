Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5822EE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDji-0007QC-Ry; Mon, 16 Dec 2024 11:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNDjh-0007Q1-6g
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:14:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNDje-00075I-OX
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734365657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=65WmvjxxT0bl00rWNMB1Gzo/IZ5+O93mNP1PqVOv+vc=;
 b=QSU+4TeE7DV1YTMMNjleJI3xjPmvxVo0Yca1my6JlYnXBE5aSc66G44S//eCYF4iVHSLu5
 U93yn28Zp0fZgVZJAj1TQ63m6mzhOXan3nNnLVzvH8Ob1owvXl1sdlpUt3s5WKjIoVTH4+
 kDLDwnarBLPeTlbaGI2nAckgsqPmWW8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-l0k3MkQEPb--VxNbfDUgKA-1; Mon, 16 Dec 2024 11:14:16 -0500
X-MC-Unique: l0k3MkQEPb--VxNbfDUgKA-1
X-Mimecast-MFC-AGG-ID: l0k3MkQEPb--VxNbfDUgKA
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a9cefa1969so44526105ab.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 08:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734365655; x=1734970455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=65WmvjxxT0bl00rWNMB1Gzo/IZ5+O93mNP1PqVOv+vc=;
 b=aQIqFjVJbkqdFOBO1nHVdo/VvsoJ+/Xj6aWrDE8oM3+md69DfdzGupvhha4K+7Tnb6
 xf8QRXLWlBm2JUoyIOWMYQHb23MCcx9/RjNK/x/2nSlEKS2CvCW285LTXSrcAi4galaP
 KLUVmv01LCdo74lKoRMhHeZzl38HWcT1oV/R+gbqE4i0cXAOl4ZpJ6DLKGWyPJQQjOsO
 yBZlowghvaLXMAmZKucq8dhAJ+gTnriaNoFxUssJjh5vtRtpvtvxpiyg437g3rKP1GnM
 rPk/szf+7ETMTl36KKdfn6zpKw+2NlaaoEOv+AlSo7pe7HVtEOd5YiT4sBe4NIoNwBwx
 D3rA==
X-Gm-Message-State: AOJu0YyaY3ogN+Xepe+PInxdw7GjbGqVPSMs9T4eIBDoxZtxXl9DOLz1
 Q7w4KgBrs/jsWRtQ7bEYvRALfuKJKXUdatkXE37sUMOhf461+FPf0NIB06Ff8LqzbpGWpmfz7z2
 5NyMrV+cyorZOV5CKxT9xRRj4nmtnIzYOzPfqlHG/KpfX1fKQ5RjqYWavprIl1zh70k7HrhPEut
 nok1lLcVAFHIblf2Stz254yNec12HX0bNvXQ==
X-Gm-Gg: ASbGncuSN0ZB4CSPfU7ZFlu3+Nb4gRkzLxYRbhq/fyETJu23J3lEVoYfI3lN/oBUbJK
 dAXx0DyC6VXWQICUQbvGzBzB6SMypw3+MZ8X8kAJxqcAzVTb0GSXd38eMzsaO+C+QzptAgYWZAI
 peMdOP7rsnQfgCm1ylPdIUtFFOQou+jtXD8agAfe3VfkwPGaqGHTO7FpaM3deqKeOewc8UvR+BZ
 3jMlT9LLuAXYvKiPGWxKVKbL9KXekc4gelQU0AmKi9MZaLAoBW2LlXxAKupoiTnP1v8M0cLseJQ
 08XBndjEGtAdwMPTOZA4
X-Received: by 2002:a05:6e02:156f:b0:3a7:e452:db5 with SMTP id
 e9e14a558f8ab-3aff800ffcfmr111147345ab.15.1734365655571; 
 Mon, 16 Dec 2024 08:14:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0h4TAv0ZPXcp4F1C64SDVsolqvBw0t5KGYfn0ZIXkReJn1BXeaaBZw3jj7xF1RbQdDDA7nw==
X-Received: by 2002:a05:6e02:156f:b0:3a7:e452:db5 with SMTP id
 e9e14a558f8ab-3aff800ffcfmr111147175ab.15.1734365655246; 
 Mon, 16 Dec 2024 08:14:15 -0800 (PST)
Received: from x1n.. (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3b248cb74fbsm15895765ab.34.2024.12.16.08.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 08:14:14 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 0/3] tests: Fix some new coverity issues reported
Date: Mon, 16 Dec 2024 11:14:10 -0500
Message-ID: <20241216161413.1644171-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

Fix four recent coverity reports on migration tests.  When at it, also
applied the same helper to some crypto/tls tests.

Thanks,

Peter Xu (3):
  osdep: Add qemu_mkdir_with_parents()
  tests: Use qemu_mkdir_with_parents() for all test code
  tests/migration: Drop arch_[source|target]

 include/qemu/osdep.h                  | 7 +++++++
 qga/commands-posix-ssh.c              | 8 ++------
 tests/qtest/migration/framework.c     | 8 ++------
 tests/qtest/migration/tls-tests.c     | 6 +++---
 tests/unit/test-crypto-tlscredsx509.c | 4 ++--
 tests/unit/test-crypto-tlssession.c   | 6 +++---
 tests/unit/test-io-channel-tls.c      | 6 +++---
 util/osdep.c                          | 6 ++++++
 8 files changed, 28 insertions(+), 23 deletions(-)

-- 
2.47.0


