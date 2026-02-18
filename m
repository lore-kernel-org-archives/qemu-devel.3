Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC35E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfk-0004Kr-3t; Wed, 18 Feb 2026 08:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfY-00045f-EE
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfF-0005UZ-5K
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ua8eW642KP2nisR1pAUnxlQGxBu2aVkwwsqHEm2Vzkk=;
 b=JWUSo/tPlZyt2a1HiBdDvOqHndnxXiNlg/cl5uCiGSaPbeG5zeoS9jZItbwcxnyPftTzrD
 nx/6OtSirYH1rTdCFDvpL9ljlFCljvl1cJqRSpkvd4Jzl/QIrqz36VCTGV9gvz11ZvJKY9
 m/HYlREgjQYnhtCkiA0xD46lcpDhov4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-9IfrJ_4SN8ejQo2y3m62dw-1; Wed, 18 Feb 2026 08:27:17 -0500
X-MC-Unique: 9IfrJ_4SN8ejQo2y3m62dw-1
X-Mimecast-MFC-AGG-ID: 9IfrJ_4SN8ejQo2y3m62dw_1771421236
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso63611365e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421236; x=1772026036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ua8eW642KP2nisR1pAUnxlQGxBu2aVkwwsqHEm2Vzkk=;
 b=jrki9SCTDRswe6WyJoFsVqp7DLjH8WqBb32aA2a/oeXBUbnNwucFSz6iDe0chwHHyR
 FVR35eTtgLH9avMu7sfOwbqN7SEoG6FNKs7jSg1hJhJmJfFdBX1wxQWHHN/AE6jR/JL0
 IEgnbHiMPcd6bklKrX0oKyGf1mkAyQM2ad1/qf2nkBGwPuEZnuvhK2AntlcxcVNBQhO8
 jmmKo2MhOQ1Q7g2eMcg6SYhA8EGF6A9Xj774grDQ0vaP3JQLTfCNFa+/w6Jw2NratTEt
 PRXfU2Qay4EhMfjHXn9jKc5YrO+B1XYuljmScC2vFGjiVmyvm5DXysTgBwvNZQ7IMPVR
 iEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421236; x=1772026036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ua8eW642KP2nisR1pAUnxlQGxBu2aVkwwsqHEm2Vzkk=;
 b=K4XXo2NqBOplWLeY4iBgNvXlI4CuSY5gHs7hu7nG4lqwoWpJHb5fT8CfZVqmGdL5cq
 wmTkQZjmUOcExXrEv3GEFIC3zCq+plZ8tqqn84CvG5teFm7sH7CbODplvnSbqqSGtx8m
 Hex+dCTg1zAFU71U793gt3DoJbLI2OXgGX4tavKagfKTZwIZNaNvrnVTJ4lRcT+qP/81
 iBGUqzoGrCyFD7/Eg28GsI5MWDIsAP1KnsKMH15AbUzq6hz3aFbczVcdrNxfVBGbOsdY
 jU7Vn1Cv5elAToGNGjA9sExo33/4uOM6rfbuxakQQ8qqc0uFnxwQ8jnGsMHsvV+OT6JI
 gEBQ==
X-Gm-Message-State: AOJu0YzeeGoOex5dKX0mKLeRZfrJsACbOAvo7Vc2K0LNSGTYGOARKI9x
 mglqXceJMO9opjQ4b4yrEb8cRk5VHJTUcPDiQ7lfJKxPBMsV1Q9SzPuRa1g2+it4zdOCPEm+WvA
 E4Stj6Y2fCn6D/QVx1b0yFhB5KXwyrDYEvUzKk6B1iqOHRxUBIj5Sdscy
X-Gm-Gg: AZuq6aLnEiU/4b6jzosQT8lQagvTnTXXOi9j9rfdDk8TcQtATkaZ3J2kGWEm6AbhuxP
 aYOUDSksq1JFSYXFb4qydo7bRcAcu4ULG6T0v11hMFifhfnpq7kqeofKXpL2uQtYC9g0f6ztHpS
 ntOzuL1vv1uMdv/BxFE9eRFqDBYhHAE6mNc+b/bSVRCCDADRIjMMWvTzVCCizcioJ/cIoXurXQg
 hMGaoV533gYKqpejiGP1JrJruNUo2NeMfKYycOUEcYYwCp49cm7khqWF4EKOrYF9zOOkhx/zFT9
 ix748d4UILilhFowSgDaVRWRpPXgRh0dB1fyAfcS9iol19qF0yj3ZtfKWZsgK5ZuykZnQrOQvq5
 ZhRdlzJjNMjjZwrQT0D3zdjKGNxJE6q0L/YI/c2CUqIqcpxhdvCJnA6lpwp7c+tN1mTwds9X9wY
 DiPSot
X-Received: by 2002:a05:600c:3f1b:b0:480:68ed:1e70 with SMTP id
 5b1f17b1804b1-48371096d3amr298392045e9.35.1771421236143; 
 Wed, 18 Feb 2026 05:27:16 -0800 (PST)
X-Received: by 2002:a05:600c:3f1b:b0:480:68ed:1e70 with SMTP id
 5b1f17b1804b1-48371096d3amr298391535e9.35.1771421235710; 
 Wed, 18 Feb 2026 05:27:15 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483983b7149sm39307845e9.4.2026.02.18.05.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:14 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 13/24] iotests/308: Use conv=notrunc to test growability
Date: Wed, 18 Feb 2026 14:26:22 +0100
Message-ID: <20260218132633.29748-14-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Without conv=notrunc, dd will automatically truncate the output file to
the @seek value at least.  We want to test post-EOF I/O, not truncate,
so pass conv=notrunc.

(It does not make a difference in practice because we only seek to the
EOF, so the truncate effectively does nothing, but this is still
cleaner.)

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/308 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index 033d5cbe22..6ecb275555 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -296,7 +296,8 @@ orig_disk_usage=$(disk_usage "$TEST_IMG")
 # Should fail (exports are non-growable by default)
 # (Note that qemu-io can never write beyond the EOF, so we have to use
 # dd here)
-dd if=/dev/zero of="$EXT_MP" bs=1 count=64k seek=$orig_len 2>&1 \
+dd if=/dev/zero of="$EXT_MP" bs=1 count=64k seek=$orig_len \
+    conv=notrunc 2>&1 \
     | _filter_testdir | _filter_imgfmt
 
 echo
@@ -333,7 +334,7 @@ fuse_export_add \
     'node-protocol'
 
 # Now we should be able to write beyond the EOF
-dd if=/dev/zero of="$EXT_MP" bs=1 count=64k seek=$new_len 2>&1 \
+dd if=/dev/zero of="$EXT_MP" bs=1 count=64k seek=$new_len conv=notrunc 2>&1 \
     | _filter_testdir | _filter_imgfmt
 
 new_len=$(get_proto_len "$EXT_MP" "$TEST_IMG")
-- 
2.53.0


