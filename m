Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F824C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqRQ-0004Vc-Hd; Tue, 11 Aug 2026 13:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRN-0004Um-S9
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:05 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRM-0000RH-20
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:05 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so247359566b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786469942; x=1787074742; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XOZeN7jdSMGw2NEKYJ2a6smVAVdu9ZR3f5Jhjg3VtVQ=;
 b=XrD6JSNddRcXlrBii9WMmgV/zBMIYOmoRwRnP/MSwfLFMjQ3nnk0KxbpPCWTw3vxEX
 iWZTC8ShemlR+5MEBhMXByhpOehsU2uxcfbHstZD4P3dChqYI3TNpA17CccscdroH8Rg
 ZxmvEH3xuGsvRqYoN0uvPDhShre6EzpgvjbdycYWv+XtTHlEDOKgB9Tc+OrwFnCB+Bfr
 3Qrzq1Tl2zYWgtAeEkta9mTqfLVRMgxFpotq8PXnIcofQw1ePm4ae13TLKvhke5c68E8
 nwvUNRUeDwGAj7PgLJUOibR4z/R3Vt7qYaIpMqmtkEoB2ik+EkSVt/6hi87VA7zCg5O8
 GW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786469942; x=1787074742;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XOZeN7jdSMGw2NEKYJ2a6smVAVdu9ZR3f5Jhjg3VtVQ=;
 b=Qyn7x+MkIAEpSldlkvHrZzuhJdVFiup7PsvwFSFiI67OM6Z2So6ryiyekPvCbY+KoS
 cg1QSGa6RhU+zQBnwNN2p3RwRlJ7qZcu3omib1/USn2SClWjTuCaMiTH3VBlWvsYCKw+
 /dtrSFI2voMfkVrwQ0rvlqRiPGhraY4159gRxODcUFaVDqTnCW1RUWRchCh7hQzR5YUM
 yeG3yXFxhwBQLW3Pq4b0RJUmj6YduFAjLoVJun+6gaclERTCZh4t61GKtAZKZlFwRJGQ
 BtbiIol4oiOySTaF8T2rYb/sAZtVO70a+GtfsoLPfOFaxNSXVMLaIDKBHi1jHzczxpiJ
 gdJA==
X-Gm-Message-State: AOJu0YzNHBUS+iLS1DxAcnmvpPScdAzLGPVTDB1QxtkKdAfRscqXRpgb
 pJw4esFrhI1g3cxRYTzDLOopVWcrUTvOdIBggT14Y+yUZeXRdUTQP/REzrQc8+Wmx2pjRxGjtc5
 zgEmZ
X-Gm-Gg: AR+sD107EsjbJfoaY3bEcf73tBCYeb3u3HghwtqQa4jMHUAWKj2eWw17h/74B8wBR+a
 MDKKpbvMkQoKfAT1+9BqZOe+Zc/IJZN1/EeGQ+WVnyVHM0TguThVm+pm3J1cvHstYCyAYLRnYIB
 BqyAfieZ7/LtdnXAy1tQ0J6Y3gCG+C52YL302X9SfWEeB+1bR0thIVYriFzHZz3KRqBtuTh4zit
 bV1PvBEH8ahR6IAzYLHAH4LGQYhEfU7cjZkUU3l9wbrq8E0WG9VdrU+I5FpfFaxdUnmg9Z0OwF+
 WrpfVpoS26peB8ImLLiI8n1fpZmGah+HNHEFlNBs6S11TRtxpNFfuREjMXrlNmzgyPKAjqj4Rnp
 veGghtOiO9wKHxD+UvCKVU6b+/ugrvEu75TurO/cvc8kIN4ytzVbf2hRFfNnYj4BqiIMpg1Kuc4
 GMFP/r0JhQNmOsCxneJl//R5L/Ng1UKQup/QJuHwk9JM9D4HLQgU/zR7bU
X-Received: by 2002:a17:907:960f:b0:c1f:df40:1d83 with SMTP id
 a640c23a62f3a-c20ed08cb98mr78134266b.5.1786469941917; 
 Tue, 11 Aug 2026 10:39:01 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ef7525sm880945a12.29.2026.08.11.10.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:39:00 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/8] parallels: fix Format Extension parsing
Date: Tue, 11 Aug 2026 19:38:49 +0200
Message-ID: <20260811173857.396571-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=den@openvz.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Parallels Format Extension parser trusts the cluster it has just
read. A crafted image makes it read past the end of that cluster, and
with a large enough cluster size it makes the dirty bitmap code memset
memory which does not belong to it. All of it is reachable from

  qemu-img info -f parallels image

on an untrusted image, with no guest and no write involved.

The reported problem
--------------------

parallels_parse_format_extension() advances its cursor over a feature
payload but subtracts only the feature header size from the number of
bytes it believes are left. A feature whose payload ends exactly at the
end of the cluster leaves the cursor at the end of the allocation while
the count still permits one more header, and the next iteration reads
it:

  Invalid read of size 8
     at memcpy (string_fortified.h:29)
     by parallels_parse_format_extension (parallels-ext.c:250)
     by parallels_read_format_extension (parallels-ext.c:313)
     by parallels_open (parallels.c:1386)
   Address 0x87831e0 is 0 bytes after a block of size 512 alloc'd

That is patch 1, reported privately on
https://gitlab.com/qemu-project/qemu/-/issues/4156.

The worse one
-------------

bdrv_dirty_bitmap_serialization_coverage() takes the chunk size as an
int and shifts it left by 3 before the result is widened, so a cluster
of 1 << 28 or above overflows. parallels_open() allows clusters up to
about 2 GiB, and with a bitmap needing two L1 entries the bogus limit
makes "bm_size - offset" underflow in parallels_load_bitmap_data().
Both wrong values pass the assertions in serialization_chunk() and the
resulting index lands outside the hbitmap:

  #1  memset (__ch=255) at string_fortified.h:59
  #2  hbitmap_deserialize_ones (start=18446742974197923840,
                                count=3298534883328) at hbitmap.c:753
  #3  bdrv_dirty_bitmap_deserialize_ones (...) at dirty-bitmap.c:648
  #4  parallels_load_bitmap_data (...) at parallels-ext.c:88

A 128 KiB image file is enough to get there. The target lands far
outside any mapping in the case I built, so what I can demonstrate is a
wild write and a crash rather than a controlled one, but it is a write
and not a read. Patch 3 fixes the overflow. Patch 4 refuses such an
offset in the parallels loop as well, since both the cluster size and
the L1 contents come from the image.

The rest
--------

Patch 2 validates the bitmap granularity, which reaches
bdrv_create_dirty_bitmap() unchecked and trips its assertion for a
granularity of zero, one which is not a power of two, or one which
wraps when shifted by BDRV_SECTOR_BITS. Patch 5 refuses an extension
cluster which does not lie inside the image file, patch 6 stops
aborting when that cluster cannot be allocated, and patch 7 is a leak.

Patch 3 is the only one outside the parallels driver and can be taken
on its own. The parallels patches do not depend on it, although without
it patch 4 is what keeps the memset from happening.

Testing
-------

Patch 8 extends tests/qemu-iotests/tests/parallels-read-bitmap with
hand crafted extension clusters. With this series reverted, four of the
cases abort in bdrv_create_dirty_bitmap(), one segfaults in
hbitmap_deserialize_ones() and one reports a feature header made of
heap bytes read past the cluster. parallels-read-bitmap,
parallels-checks, 076 and 118 pass, and every patch builds on its own.

No CVE has been requested.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>

Denis V. Lunev (8):
  parallels: fix out-of-bounds read in format extension parsing
  parallels: validate dirty bitmap granularity
  dirty-bitmap: fix integer overflow in serialization coverage
  parallels: bound the bitmap L1 table against the bitmap size
  parallels: reject a Format Extension outside the image file
  parallels: allocate the Format Extension cluster gracefully
  parallels: fix GSList leak on the format extension success path
  iotests: cover the Parallels format extension parser

 block/dirty-bitmap.c                          |   2 +-
 block/parallels-ext.c                         |  46 ++++-
 block/parallels.c                             |   9 +-
 .../qemu-iotests/tests/parallels-read-bitmap  | 180 +++++++++++++++++-
 .../tests/parallels-read-bitmap.out           |  33 ++++
 5 files changed, 259 insertions(+), 11 deletions(-)


base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
-- 
2.53.0


