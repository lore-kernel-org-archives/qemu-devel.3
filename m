Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C36BFF6E9D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dlH-0003vI-Tg; Tue, 17 Mar 2026 19:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlG-0003ux-5R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlD-0006RL-Nx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773789817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xdWsext4LCRW5NXIAdXAn2Gohys6W7IVbOEiphyHcAI=;
 b=FxSKblhHvUj50ENcWUmaQFX4HKPHi1DVsF4Zs2AZKTHyiHpDOI6BFz1s2Zeo+BUELG6yTg
 Bt/m/x92Po3aR/q7PTnZEbGYiTE4krIyP5jgmEBdvgk6GqyJDyvjk2sJyS9cs+pP8wQJZQ
 D+lDOFTQhg9LSsNE9Szl01KZ2kElbZU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-QcGyFIUBNl-i0KQHQiT3Zw-1; Tue, 17 Mar 2026 19:23:36 -0400
X-MC-Unique: QcGyFIUBNl-i0KQHQiT3Zw-1
X-Mimecast-MFC-AGG-ID: QcGyFIUBNl-i0KQHQiT3Zw_1773789815
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c4e730c2bso13873046d6.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 16:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773789815; x=1774394615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xdWsext4LCRW5NXIAdXAn2Gohys6W7IVbOEiphyHcAI=;
 b=gwSzttcqZwSho9JUB+267Mtvjm0FZVVKRhJO10TE53w2RWbsD6hGpx9Gg0x8LqpvpZ
 mV15XaOe43+l339RtUlJBPBN5nVenszdh7G+Unps3fKM7xa1dBBix8PDM5cKmc3RdpPw
 mczpj3FmDpAO0LFKcLXLjkHTfLE0Nr/SrzLt3+hqtrgZBRSZqSfaCiViSL2k/vxPWd4q
 FtlOkmg2ZWH0UqXWPA8Je9hgElEDhGwKHnR+Yj3eV9o8Ka0AR/WjFzCE2VMDRqCplT5a
 7Kkq8Gb8ZveFcXBLq4O+MyJGh8EfehqUijAlwxe1mjlwFQf0LWau7XcM99v26E+Itk5K
 OEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789815; x=1774394615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdWsext4LCRW5NXIAdXAn2Gohys6W7IVbOEiphyHcAI=;
 b=ei6JLHfHmk9uzbEpjdb1UFXss1Gf8Fni/a4aEtvlgU7Tbd+t+NBNX0X26l98DfTV7D
 C4q0mxHAMQU8wodmCYMhFXu+nAHFA+fv5z64wkLOiZuFuPgOLAfmsxmoiGY02Ahc0Vn1
 qvi4lTk5wm+czhqsOIvkBsminZfGq4lKtxOwSLA2f1MHEJ3P95DSr0KADRVWci8eArKn
 ZbO9MaFbfabBC3Ve0P30GblrYXUyXxhmcnChSIRIQFhAEAoRRYIsXsuEHCFjtGHAglA1
 4H9rrmRPslxLqMc4WwFJSsypzWGkcdZKujkg+pPFkevggBy8UU4I2OsSnsdd94iMokDt
 raEQ==
X-Gm-Message-State: AOJu0YzUGOg7QX4eUziaEjRmqDzR/eEqSVevmQ7h4Abfaf8qghQW7kpB
 ZD2R6J9rkl0VOWQsZA5o/gzY/WkjuNSU6DeaHGh5SDVJg5AqKeWr5FHdgR+gZMo30JvchaQbcQD
 ZIJ7ZCit8rt07g0pOcPykZAT8SqzMVPSNdDzm281vJDg5lKHKgdTTQhiTdvgosoLheQkUdMn9nh
 +mq2xZGjkjNutVDcVLekRXs5cxvdo2x4QGQAQPUQ==
X-Gm-Gg: ATEYQzy//sNi2bhcGvuSykwuAVEyvZI6kjmbYX0LBio6oEwe7uQW4srRXUHgW6QMOct
 N7RdCkWNo6LlQiNuUQ2NVXlpSwRgJMXukmVieFmeDJiAPU0zphl9zv3G1xAdyJqrs5j7bB+xmAD
 DCRX6DdgzZIjbF7zrJgskMnRXtE9vI8B3s7LyCMz0nxvpqbxlaNLNzR9LA28zq68/FxD+k6bW1V
 9axvwhWw+YNjLXDu9fvZ1/lm9WiVN/0ID1kB9ksGWATHCGumaD0XWg9SONxqsD/pjNrk0sPfeJ5
 9+qEvys/QmOBxlYHiRymLkW9Pv5NDvJckobbbDjBIl47pCp/oyCOeGGqVGiQFpnQOltwp2S/6Y9
 2UAQLLnHSOHMsYA==
X-Received: by 2002:a05:6214:2a8f:b0:899:f4bd:66e9 with SMTP id
 6a1803df08f44-89c6b5f2defmr21991736d6.63.1773789815199; 
 Tue, 17 Mar 2026 16:23:35 -0700 (PDT)
X-Received: by 2002:a05:6214:2a8f:b0:899:f4bd:66e9 with SMTP id
 6a1803df08f44-89c6b5f2defmr21991386d6.63.1773789814555; 
 Tue, 17 Mar 2026 16:23:34 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ea39asm8203806d6.37.2026.03.17.16.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:23:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH RFC 00/10] vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Date: Tue, 17 Mar 2026 19:23:22 -0400
Message-ID: <20260317232332.15209-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is an RFC series.  It is based on Fabiano's migration-staging branch.
I've pushed this tree here for easier reference:

https://gitlab.com/peterx/qemu/-/tree/vmstate-array-null

This series implements a new vmstate flag that allows real dynamic array of
pointers to be migrated, so that QEMU vmstate core will be able to identify
NULL and non-NULL pointers pointing to any kind of VMSD (or base types),
then properly allocate memory for them on dest QEMU.

The first planned user of such is Alexander's NVMe migration series here:

https://lore.kernel.org/r/20260317102708.126725-1-alexander@mihalicyn.com

This is another alternative to solve this problem.

Note that I haven't had time to test anything more than the qtests/unit
tests provided.  Neither did I tested analyze-migration script, likely
that'll need some touch up when we plan to do this.  However I'm sending
this out first so to collect some early comments.

Alexander: sorry I renamed the flag once more because I just found it not
proper to call it _ALLOW_NULL if we already have that existing NULL use
case.. So I changed it to _AUTO_ALLOC.  I hope this series will also work
for your NVMe series, note that I removed two macros you introduced there
since you didn't use them (and we'd better not introduce unsed macros).  I
kept the two that your series used.

Thanks,

Alexander Mikhalitsyn (1):
  tests/unit/test-vmstate: add tests for VMS_ARRAY_OF_POINTER_ALLOW_NULL

Peter Xu (9):
  vmstate: Pass in struct itself for VMSTATE_ARRAY_OF_POINTER
  vmstate: Pass in struct itself for VMSTATE_VARRAY_OF_POINTER_UINT32
  vmstate: Do not set size for VMS_ARRAY_OF_POINTER
  vmstate: Limit the vmdesc_loop dedup trick to compressable field
  vmstate: Rename VMS_NULLPTR_MARKER to VMS_MARKER_PTR_NULL
  vmstate: Introduce vmstate_save_field_with_vmdesc()
  vmstate: Allow vmstate_info_nullptr to emit non-NULL markers
  vmstate: Implement load of ptr marker in vmstate core
  vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC

 include/hw/intc/riscv_aclint.h |   6 +-
 include/migration/vmstate.h    |  86 +++++++++++--
 migration/savevm.c             |  32 +++++
 migration/vmstate-types.c      |  36 +++---
 migration/vmstate.c            | 218 +++++++++++++++++++++++++--------
 tests/unit/test-vmstate.c      |  90 +++++++++++++-
 6 files changed, 380 insertions(+), 88 deletions(-)

-- 
2.50.1


