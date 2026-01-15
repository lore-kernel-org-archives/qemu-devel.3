Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8ABD46634
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 22:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgWFM-000646-Hd; Thu, 15 Jan 2026 17:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgWFF-0005yO-0g
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:55:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgWFC-0008Ju-9l
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768517708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DLlmWR7d7c9BVqaF22XPbpF59/5vhh4Tqa7Wj6vH6m8=;
 b=Eznp9hR6ddoM37UJNhu95Glc7RsIxidwJQFtr5PUwJEVB3t++lupodW1l29P9BJRzQYTok
 +uJh8n/+ZnrKKg/ywQINeF5zt0mUTsLlipzK3QteBVWuC2+BibnrwKiE4mSEJ7jNbeZHFA
 RRm6S3RQv+AtxVduK3ojoVH2dFlRSvQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-wBxScrRANCqBurwFxh3fpg-1; Thu, 15 Jan 2026 17:55:07 -0500
X-MC-Unique: wBxScrRANCqBurwFxh3fpg-1
X-Mimecast-MFC-AGG-ID: wBxScrRANCqBurwFxh3fpg_1768517707
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88a25a341ebso25672496d6.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 14:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768517706; x=1769122506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DLlmWR7d7c9BVqaF22XPbpF59/5vhh4Tqa7Wj6vH6m8=;
 b=cV5LYgxwy8jiQoyX3rFUOXiIIPljnzlqtX43YRDu4zITuNDm3KTdyKW9K8xulfeGmw
 FjAlxQdikts1/JnlbGS7x0kZmzFzs0kAHDXe96P7CKjeGKhtEghhAZVZc81fu7WmkSS5
 m7btUiGSktKupDDgoOF4Shz6OjvTwqAq6c8BgCct7b13NdItYMrvSjBKt2vovCZCoGlj
 O8Erew8NcBRwW3mvFCyFqpZM1o91qNsBOZGsnwfo197gHjmhK+3OpnKaZtPPQpacZ4wc
 MsZsQZGjmf+Mahk4JgTRYVs4m3l0ToO7Xoqffi6TlAB4lVgiEiI8JqdpspTxRzyZdl4+
 Ix2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768517706; x=1769122506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLlmWR7d7c9BVqaF22XPbpF59/5vhh4Tqa7Wj6vH6m8=;
 b=Qo6GmkAS7tRDE4hhzXWkUe5fndSjPTJZEVVEP8PsRlZP46eexUl8iaV9gYVebUrrVL
 0pihJxLn08FnrpNi8R29r0ph2dh9CVHIHL3rlkCOuIKJXb9Im++Yv7ZQxS6OQhGELrMI
 9VUczJxjaKGPKeGko5MJhhkwHSgbakDdWnlyZV1dY7R9mPWVaZF4pHs+V8vlzpNG3eCC
 HSevSiQZxXq2BnW+j+G4l/1VcDvkfmJ1VIDVQKlXaQHnUPrihvVq1RUvJPa8GFDtk3w+
 gaDW2U9bZEbtbqtr+JAC+tKqdmPxpIOdBrO3rzDwMS6wE9r72u7OF8Bv0dpgFBTafD0E
 Wz3Q==
X-Gm-Message-State: AOJu0YzQMC34PYNXj0wlYdttfyQGm2G/j4JRNeSi0YgdxBTPp51QHiXC
 Yh4GKazvwwHFZOd25//N5/UW/TMW5qp4fZ0b1DrShXanwZknXX30+brtR4RDtyX1OFU3hzibXpq
 Pi82HRudBP5rap5ThIcTUyU1NJdvg/rKJXpE4KcIlp8bzjmiasLEVo1QzFbWnojLRhHqkCpckNv
 AfWJKgzhsq3Gqi4/1UAoKkYM5FCJVxn6k6cC7VBA==
X-Gm-Gg: AY/fxX58tl1P0KnTq7ebxfTQuL2QDht68CH8DxyRCfiQGaAnCkdM75bhcoFh0mA3mAn
 hMeqS1SxMU5m7TNOi9yxejTvepFapFPw7+1/3pCClRLnQQQJWH5p2PUuzR9i6vEScSDPua+dORa
 8/UDmTMeep0sls5ra0dWKjO17E60/2ZjGqYwMpG+tGH2YT09borCJRJisbAhtY1do56Ixpn9dl8
 2ej+Ce7ZLOHUCXd5URtRTKP84lSdgPg78tboDIuXMB0AJXtvwm4RMu50kOqXCeoGNhUVFrxuncF
 i1gxcMFHVAiSdur3may8u3ix6j/A3Qujt3rjoG77SdYtLb9ghzt1PWL7A0563bArDhjY39YyKZ5
 L
X-Received: by 2002:ad4:4ee6:0:b0:88a:4694:5922 with SMTP id
 6a1803df08f44-8942dd31ef3mr17131296d6.23.1768517706302; 
 Thu, 15 Jan 2026 14:55:06 -0800 (PST)
X-Received: by 2002:ad4:4ee6:0:b0:88a:4694:5922 with SMTP id
 6a1803df08f44-8942dd31ef3mr17130956d6.23.1768517705745; 
 Thu, 15 Jan 2026 14:55:05 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a71d8314sm70353185a.24.2026.01.15.14.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:55:05 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com
Subject: [PATCH v2 0/2] migration: feature removals for 11.0
Date: Thu, 15 Jan 2026 17:55:01 -0500
Message-ID: <20260115225503.3083355-1-peterx@redhat.com>
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

v2:
- Added R-bs
- Updated description for removing zero-blocks [Markus]
- Squashed the "fd: to file" test removal into the 2nd patch
- I dropped the COLO patch, I have a local patch to remove colo migration
  completely, but looks like we won't do it..  Let's leave it for later but
  do the rest first

This series removes two deprecated features for 11.0.

Please review, thanks.

Peter Xu (2):
  migration: Remove zero-blocks capability
  migration: Remove fd: support on files

 docs/about/deprecated.rst             | 20 -------------
 docs/about/removed-features.rst       | 16 +++++++++++
 qapi/migration.json                   | 12 --------
 migration/fd.c                        | 11 ++++---
 migration/options.c                   |  5 ----
 tests/qtest/migration/precopy-tests.c | 41 ---------------------------
 6 files changed, 23 insertions(+), 82 deletions(-)

-- 
2.50.1


