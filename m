Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D53D39013
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 19:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg701-0001UW-CV; Wed, 14 Jan 2026 14:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg6zY-0001LM-DY
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:57:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg6zW-00022f-Mk
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768420637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ookbNDOLagx2JfHgzSX/g339CgGoZ3zgHlF0JmqVAA8=;
 b=Fp9YyoEIvQFiq9NOzRtwO/CONnIW2t2yVePhsMWqVthsJSPeO8BCeL2fVD0BY85Vzs4+eX
 +zygKGDsD5Jhp/K0XOdsRReTWRevMUH5EXax4JaJonvZA3vLS3ROVWn7ZEb8ePzU08fYOc
 8IKGYuLTwNnVwsfz8xxFhMfFfDJTLVg=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-1IFgXt6DNryR4Hou7DujXQ-1; Wed, 14 Jan 2026 14:57:16 -0500
X-MC-Unique: 1IFgXt6DNryR4Hou7DujXQ-1
X-Mimecast-MFC-AGG-ID: 1IFgXt6DNryR4Hou7DujXQ_1768420636
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-5ec87b2b4ddso165948137.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 11:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768420636; x=1769025436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ookbNDOLagx2JfHgzSX/g339CgGoZ3zgHlF0JmqVAA8=;
 b=YQymFiU0epO2zOadjjKXAXirOvPWQuKM2x1awLY61DxVq1kEAXEGDCHIsh6pLGeuDW
 zUjedKtrj+0qHN+C7aT8Dfsq59UMpdv9+RxPeaG+5rD6aH2UTrSDYfxWYEVOssm1d9CQ
 DRj5H5Gd3IsyOKLA6KTkXcm57KRuAT42+8m/sgHydbTs7JLczqvxluAc9YPJ9hlcnnoR
 oYYyHEosmHmyqWyWPcgKCv299ffDRgAqa5NpcpkojU9LkvmeT8xZ3qu+rOhhVFe7GB2O
 qCtx+BvdZALYpxhzEPGvaet7h9v1hwpGP8wEhGfc98X1XqXgncsWJr122FxgVaYKO9qw
 MNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768420636; x=1769025436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ookbNDOLagx2JfHgzSX/g339CgGoZ3zgHlF0JmqVAA8=;
 b=shs69OAuC0zpW3rlOmI6ViOnWrmR/vBo6luZo/ic0dm7+wxIuk4Ba2wltU+qSmQyNq
 twJaSSRoS1YUOjJLsd5bMqMPaLJaON4oe+XMKCLPwmoc722KstKID/1Ah63j0Y3Qj/dW
 5TsWYPlfyF/LEfDVcDe0ZsqW39sKS7WyK9YXOMn39x31WLsqWuXNyoKWmwqy8e1NnFDP
 dl7qgLnX3vCw1L8iNmu/dslDBn42hdrVaoGr/19W0Jr0+pLHGJtq5NUrhdFNarOLfe00
 jyhA8Q/JZUQBMCRwYF88KSotdbBlvecs5FTW8BXYXsoir39u6/VKdXBkhDZ1GlSGGZP8
 xWpA==
X-Gm-Message-State: AOJu0YxI4vJt8QMKQPQiZleJwxkagRM1F2+dLgBvSGQIBsAGn0cJhvy8
 lDzzFExuynZSbM0728mhB/f5l37PSf0nHPHo33CLP/5O07j8UQnz0zJOoRQY5B8cvW1xNbveUrn
 UG1J0Q0Hg1iUfjLtzfdbeVIQU+cV7G9cwI/v1VYM9pmcEmCEv0fU8WHfcz1qioO3mHq9JXA+9xd
 apRgjhNEizbEkfaamlG9P63IC9lT54SvjebUyF/A==
X-Gm-Gg: AY/fxX6Qa3ktHIKnnYO5kNw/3BYSyLl+Qx9UnxOg4qJWkl4etQyYUV6+knEZZfIu3Ct
 qcqVIvtXX3ZfOKbq+AIom2rZ0CqqvmRNtLE7IcDdwAMyPl47XkoFCppkPX1/M9p5U59GzuDog4J
 rMFbJAJmxSkOxMqVcnBVxRBKsC0ktazTFtsoXPkvHx4XCnFAQ/UR92ZKuBhTuO3+K3jkBdPQPiM
 k28gsgfPgLoRbqyMc/HFQldI+TEcn6PUoRPKbMlHVllHtMYCilx+ngbVIDy6GsRC1d52SFQ3GTg
 nvDl03lih1KB5VSMRa6Ctqh6zZHk8ts45jsOX04zaP4hWcUpN0t3PQtL50ZOEtgHj32ysjwWVOU
 9
X-Received: by 2002:a05:6102:94e:b0:5ef:24aa:986f with SMTP id
 ada2fe7eead31-5f1838967f1mr1527227137.2.1768420635725; 
 Wed, 14 Jan 2026 11:57:15 -0800 (PST)
X-Received: by 2002:a05:6102:94e:b0:5ef:24aa:986f with SMTP id
 ada2fe7eead31-5f1838967f1mr1527201137.2.1768420635106; 
 Wed, 14 Jan 2026 11:57:15 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-944122d3040sm23024832241.4.2026.01.14.11.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 11:57:14 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com,
 =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Date: Wed, 14 Jan 2026 14:56:57 -0500
Message-ID: <20260114195659.2543649-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114195659.2543649-1-peterx@redhat.com>
References: <20260114195659.2543649-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

COLO was broken for QEMU release 10.0/10.1 without anyone noticed.  One
reason might be that we don't have an unit test for COLO (which we
explicitly require now for any new migration feature).  The other reason
should be that there are just no more active COLO users, at least based on
the latest development of QEMU.

I don't remember seeing anything really active in the past few years in
COLO development.

Meanwhile, COLO migration framework maintainer (Hailiang Zhang)'s last
email to qemu-devel is in Dec 2021 where the patch proposed an email
change (<20211214075424.6920-1-zhanghailiang@xfusion.com>).

We've discussed this for a while, see latest discussions here (our thoughts
of deprecating COLO framework might be earlier than that, but still):

https://lore.kernel.org/r/aQu6bDAA7hnIPg-y@x1.local/
https://lore.kernel.org/r/20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de

Let's make it partly official and put COLO into deprecation list.  If
anyone cares about COLO and is deploying it, please send an email to
qemu-devel to discuss.

Otherwise, let's try to save some energy for either maintainers or
developers who is looking after QEMU. Let's save the work if we don't even
know what the work is for.

Cc: Lukáš Doktor <ldoktor@redhat.com>
Cc: Juan Quintela <quintela@trasno.org>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Zhang Chen <zhangckid@gmail.com>
Cc: zhanghailiang@xfusion.com
Cc: Li Zhijian <lizhijian@fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/about/deprecated.rst | 6 ++++++
 qapi/migration.json       | 5 ++---
 migration/options.c       | 4 ++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7abb3dab59..b499b2acb0 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -580,3 +580,9 @@ command documentation for details on the ``fdset`` usage.
 
 The ``zero-blocks`` capability was part of the block migration which
 doesn't exist anymore since it was removed in QEMU v9.1.
+
+COLO migration framework (since 11.0)
+'''''''''''''''''''''''''''''''''''''
+
+To be removed with no replacement, as the COLO migration framework doesn't
+seem to have any active user for a while.
diff --git a/qapi/migration.json b/qapi/migration.json
index 201dedd982..3c868efe38 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -531,8 +531,7 @@
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
 #
-# @deprecated: Member @zero-blocks is deprecated as being part of
-#     block migration which was already removed.
+# @deprecated: Member @zero-blocks and @x-colo are deprecated.
 #
 # Since: 1.2
 ##
@@ -540,7 +539,7 @@
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
            { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
            'events', 'postcopy-ram',
-           { 'name': 'x-colo', 'features': [ 'unstable' ] },
+           { 'name': 'x-colo', 'features': [ 'unstable', 'deprecated' ] },
            'release-ram',
            'return-path', 'pause-before-switchover', 'multifd',
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
diff --git a/migration/options.c b/migration/options.c
index 9a5a39c886..318850ba94 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -580,6 +580,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         warn_report("zero-blocks capability is deprecated");
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
+        warn_report("COLO migration framework is deprecated");
+    }
+
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         error_setg(errp, "QEMU compiled without replication module"
-- 
2.50.1


