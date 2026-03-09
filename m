Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A03F4180C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEp-0000wW-CD; Mon, 09 Mar 2026 11:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEn-0000vO-Vm
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEm-0008OD-Gh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ua8eW642KP2nisR1pAUnxlQGxBu2aVkwwsqHEm2Vzkk=;
 b=Gw1piys7nKQbgZojoiEtsFXHBm50b82yBv0QDLccOp+npE2h6qSnuOUNrVj6eCgrQsfka1
 8Q27cUh4wwBOrwTtJbRxiY91/6DD7dRUgbpTn08/z3uqWbld9hZmbz+SjRZrQl6TiAfr9+
 IsfZgsgtP84sCpB3GrvR/oNKW84rZHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-hJOrwry0OPe7IlbuoYOlyA-1; Mon, 09 Mar 2026 11:09:38 -0400
X-MC-Unique: hJOrwry0OPe7IlbuoYOlyA-1
X-Mimecast-MFC-AGG-ID: hJOrwry0OPe7IlbuoYOlyA_1773068977
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-485345e2fdfso8767275e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068977; x=1773673777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ua8eW642KP2nisR1pAUnxlQGxBu2aVkwwsqHEm2Vzkk=;
 b=MAfixMQHIXD7OxjRSifk9/VQUvq5/Kt4yfewoHdAQqu28fRzDIoK3+jRpqpkQ24Qiv
 rB/4zV3lOv5+1FGX/zMkypVZkMlkx5oAnmxnSytWMkeUnU7kAin9klmm83PwUF1alJKY
 TidKoTMgH7Pm4sQDug1NohMi8Izk5M725G02Ew49UozTjPLx0RdRgdEMGkMzeFn2Qpy4
 aOQu+EvP8Ip1h8K13opmDFLx0klS6JzwKpn9ex/dQYb76aO+PAENgKhJsg5WFXF/eEtc
 5+xlKpqKO7FKgn3HBNg//xdehskJdnBcRXMcKVY94Prz+0Soir2fONu5lW3GP53OtAip
 IIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068977; x=1773673777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ua8eW642KP2nisR1pAUnxlQGxBu2aVkwwsqHEm2Vzkk=;
 b=GeBYKLLHghYuklij4NXQVCO6zF5obXwvhDOL1iT7wHBffEMuhxGCd5cDFYTkTLypKi
 DtK988Q2wjfRdbUsAUj+GV35JrvHIuxQ0F94XUUNZhqasOfPixoYP0xXhrikOpWJ8Omu
 zNLffu/dvA3L1zGHiqRyMtkOqMloCPurUPSlVmmEd9SROcpU+n79zDTSK5FeC26a7IYx
 3vMm9BfqA0ZqJVgYQAMpkTdYkvnfFMZ/mNzz7fC4hQwHXc+jLIJaYhM07aOLeKUwayht
 pgjxlSUDEL0/XsYApKC9SJV34qrglVcO5E4p7jgjl6acnw4OYv5N6CQJQF/3I0MfFN+w
 Nv2Q==
X-Gm-Message-State: AOJu0Yy9OVS7pN18JVcNjemYHA0UDkip5oIIG6aLaHuogEQC7uMNJUnQ
 xUOA+qtXabFFoxAuW6w0GYrUYxWwRHnmiwKmtVEVe+gc3A0At3V9tSlVP8k27YYYYVs1NaFRm9P
 Pgnk6sgU/Iz8Ln/GypUIXFN0jBM7LwYF1Ar82hmsQ5kmnFdS0bNhUGv0o
X-Gm-Gg: ATEYQzwU65Cx7OOhgjporCVCWVfAOQZpZhRmghpBnIwngPGwQx/pIbQcv3vJhN5lrmY
 dZV17F/mPi+1qyk86Ss9bAxfpzRCOlIu2zFcgCO9nsOSL6hHlJh6QU2waep5iRr7Nbn8bwcw3PI
 7P385m91TMZLrPZk7eR6A5f/im0ckcY2eWG+Z+i3HNZ1z7KQUtA3ooPBd9cR6Ut+FPuV5YmJX2s
 UwRApS0vxyvpY2UpiX58jyeqheXUdmdaP7ijWNbNyDX2Ub/cvi+MFOrm6elSagaOkRTXyEuKWak
 ILYjNBem63Izmwsn30eH5PjEqhR+Ss/le23GITOVPYU3YUfHdP0tU/Y3PVFfU3f4ngskY1PWlau
 5ZewGA6GaOeYAtqOLsonW9INRmb4L9LSYBDC6XjyNps0Y4HRsclWL1I+n4Ut83m1ppYtlUQCEUj
 gygIGu
X-Received: by 2002:a05:600c:46cb:b0:485:3dfc:57c with SMTP id
 5b1f17b1804b1-4853dfc073cmr38304605e9.21.1773068977288; 
 Mon, 09 Mar 2026 08:09:37 -0700 (PDT)
X-Received: by 2002:a05:600c:46cb:b0:485:3dfc:57c with SMTP id
 5b1f17b1804b1-4853dfc073cmr38304045e9.21.1773068976807; 
 Mon, 09 Mar 2026 08:09:36 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237dcf04sm136917715e9.1.2026.03.09.08.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:36 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 13/25] iotests/308: Use conv=notrunc to test growability
Date: Mon,  9 Mar 2026 16:08:44 +0100
Message-ID: <20260309150856.26800-14-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


