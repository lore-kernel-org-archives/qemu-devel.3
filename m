Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA29112584E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M5Q-0004E6-N9; Wed, 11 Mar 2026 12:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M5B-00041r-Uu
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M57-0005iz-28
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5uP8yNg3MR1s+nE88noOcGAEydZulKVvT5/M1mC125s=;
 b=OXPTDiOs7WLn6RnlvJy1+HabatKeXGzxa7fSv4Jz6ZuxH/YrIKf0NFjSQlscrSBsl69xn+
 cBfuKP7iMjIOck+ctraN49ArjfS7RsPgV66HMJeBbqmYtzxQ7MdReob+1l/qpYft1aywcz
 2ntHYCafQMnlFDf2qYM5Uj8aO+gxRxA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-o-e7RTDpOKWUpwsj150ZUQ-1; Wed, 11 Mar 2026 12:06:38 -0400
X-MC-Unique: o-e7RTDpOKWUpwsj150ZUQ-1
X-Mimecast-MFC-AGG-ID: o-e7RTDpOKWUpwsj150ZUQ_1773245197
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439a85832c0so30042f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245197; x=1773849997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5uP8yNg3MR1s+nE88noOcGAEydZulKVvT5/M1mC125s=;
 b=g51owLjUJSQqCncZ7jVoDX+Or+n4FeworUh2drbuerVxNwdZEy6e2qUsGUbgZA3L8d
 ruh+oZrcUEkq1brn1/E2D3IQZgaCET55V8SsR1VrLzoD3Z1/HNYqQd8h8P0CeiRM12Ge
 5mbwJSjKL/l63OPfWFXazoZ9A0wkFLMi1F2CUD62AxuCKD6Mz24fkqcnm26nd+w13ySo
 aKl2AYr7qsfYJjwY6EVkYxN7uCukNR9LYtW/hH8aDQZ73Pq87lZp0SXyX2QPpJ2+JCcB
 UL+B9mImrfKYwasxa8gjmlxYUfbfSdDQNMh/IWky+sVsVyg8NV7n37xCJmZtL2ydF5mu
 KdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245197; x=1773849997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uP8yNg3MR1s+nE88noOcGAEydZulKVvT5/M1mC125s=;
 b=gSKelciva44BheiyjOFNz9a9j0NhDrgTJxSktzvjloGOIAABJG/CN3e25J3/akGyho
 5l+w83hBlltcnb5GzDMHvZiDnfwox22zCiwpdtAnzI2hxCSbsec/HThp+QBqWtbFK2KI
 gbAoIksftRV0eaFdUnrU4ecs4Es2133334/PR7dhsdjaTZ+quJ59WqFAVxeXoKMl85v7
 MqXfa93OQhhTz3t/oFpx8+yd1nVTsPt1rFLgcKXi4q4ja02EotwXO081nVRgd4Kgk2aw
 0WNgckBwNr/rkFlvU8RFZaG7yyhwN8qNRJKgI+s2sq9uTdkxgjQye7cRaf6SIrfbSA59
 2oPw==
X-Gm-Message-State: AOJu0YwEAnCPz+mkFc1PAlsxZmVSruVOWVD6ql5eYBykpM8gDQN9vI6y
 izYy06/mcim8dwaQiOgzfHOtIhLprrRiURVZQTd6QN7vx5ucTC3puD1K+I12ZKytGB1F5SYeIkz
 AhmcubKWiJP9rk4iIldN2f1WwyVB7dMLpxCQBYXSd6opoi5G1sVYWCEI6
X-Gm-Gg: ATEYQzwqwCO5M84Az0oWurWFgNCwVM1nUi2jzrYogrFq3cejNFWgAjx4ywHfnWJia7S
 ja9P35q+UfYJct/WmSyGzNOz7ONbLM6v/uS3UDIgnNJB+NVKFN1xx305Zy7mMl1h9QTANYPKiMN
 Vap6+aExVBtcaqCHY3qEXkIRxXGv11abi9Un28so0BA9PFSDwch6odxY/opcvBfwRiXcoQLUaA7
 asygUIOjvBLBDLiZQYZrTsIO+9Qtn0wPb07CfKwr3LD1M/yA0R8j+wviP2lBIsCQEOyYHEuuAk8
 ZfVX7IwLUS+wYVPEqNFASO1wqod4VJqD42x+XGOamA3FEG32qdyYwVq5ehqKqPGg6amnZglHa7P
 T+PDd309r7XeG31iXtcdI62JpslxvtnpF6fqs0UvkZXjuYTrVDyiiSnhzLtRHIgoOg1P7DtLnYo
 BAuNIf
X-Received: by 2002:a05:6000:2f86:b0:439:b6f1:cd8d with SMTP id
 ffacd0b85a97d-439f842c90cmr5771296f8f.28.1773245196788; 
 Wed, 11 Mar 2026 09:06:36 -0700 (PDT)
X-Received: by 2002:a05:6000:2f86:b0:439:b6f1:cd8d with SMTP id
 ffacd0b85a97d-439f842c90cmr5771169f8f.28.1773245195913; 
 Wed, 11 Mar 2026 09:06:35 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0216f12b1cbc4c9e6fd.dip0.t-ipconnect.de.
 [2003:cf:d737:d021:6f12:b1cb:c4c9:e6fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19abbasm254507f8f.6.2026.03.11.09.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:06:35 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 0/6] qcow2: Suppress data-file WRITE during creation
Date: Wed, 11 Mar 2026 17:06:22 +0100
Message-ID: <20260311160628.344838-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

Some people want to create a qcow2 image for an existing raw image while
that raw image is in use by a VM.  That is, the raw image is attached to
a guest device, and the new qcow2 image is supposed to use it as its raw
external data file.

This series makes that work by relaxing the permissions taken by the
qcow2 driver on the external data file during qcow2 image creation, i.e.
no longer taking the WRITE flag (unless preallocation was requested),
which allows simultaneous use of the file e.g. as a raw image attached
to the VM.

The v1 cover letter with some more info is here:

https://lists.nongnu.org/archive/html/qemu-block/2026-02/msg00090.html


v2:
- Drop the new flags, use BDRV_O_NO_IO and !BDRV_O_RESIZE instead
  - This necessitates making qcow2_do_open() attach the data-file child
    even with BDRV_O_NO_IO if the "data-file" option is a string (i.e. a
    node name), that's patch 2
  - It also requires bypassing the block layer for resizing the qcow2
    image, i.e. we need to call qcow2_co_truncate() directly instead of
    going through blk_co_truncate(), that's patch 4
- Fixed the typing in patch 3 for a subtraction (should have cast both
  new_length and m->offset to int64_t, not just the latter)
- Proper locking around bdrv_co_getlength()
- Check bdrv_co_getlength() against (int64_t)qcow2_opts->size to catch
  error cases (instead of not casting the latter and having the former
  underflow)
- Fixed f-string compatibility in the new test


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/6:[----] [--] 'qcow2: Skip data-file resize if possible'
002/6:[down] 'qcow2: Always attach data-file given by node name'
003/6:[0006] [FC] 'qcow2: Preallocation: Do not COW after disk end'
004/6:[down] 'qcow2: Call qcow2_co_truncate() directly'
005/6:[0058] [FC] 'qcow2: Suppress data-file WRITE/RESIZE if possible'
006/6:[0030] [FC] 'iotests: Add qcow2-live-data-file test'


Hanna Czenczek (6):
  qcow2: Skip data-file resize if possible
  qcow2: Always attach data-file given by node name
  qcow2: Preallocation: Do not COW after disk end
  qcow2: Call qcow2_co_truncate() directly
  qcow2: Suppress data-file WRITE/RESIZE if possible
  iotests: Add qcow2-live-data-file test

 block/qcow2.c                                 |  145 +-
 tests/qemu-iotests/125                        |   17 +-
 tests/qemu-iotests/206.out                    |    6 +-
 tests/qemu-iotests/tests/qcow2-live-data-file |  280 ++
 .../tests/qcow2-live-data-file.out            | 2904 +++++++++++++++++
 5 files changed, 3324 insertions(+), 28 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/qcow2-live-data-file
 create mode 100644 tests/qemu-iotests/tests/qcow2-live-data-file.out

-- 
2.53.0


