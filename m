Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56D2CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU8p-0005o9-0k; Mon, 10 Nov 2025 10:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8n-0005iR-82
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8k-0000qT-Ey
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mSB5ZMPnp7WzEsw8ZNn41dAZGkkyxuiFTS9pFBJYVgM=;
 b=LQZeRmTUAR/Zrd/shC2gYR7xrJ0Rsc+oUtHWTTPq7A5Srxx3B+m8g9/JuDzLyoRhv0TDiD
 tqXQUym8fkbIY8YZ9E1y/yH9YIqhzsff34RLLYMUAT1ifKFBFq5X9ATMj37Ac7/zxY0nPt
 MdG45A5FbebeDGKpP3xqF9G7h614y9s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-G7aJ60W7MuyXjg2bOADD5Q-1; Mon, 10 Nov 2025 10:49:07 -0500
X-MC-Unique: G7aJ60W7MuyXjg2bOADD5Q-1
X-Mimecast-MFC-AGG-ID: G7aJ60W7MuyXjg2bOADD5Q_1762789746
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso24377905e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789746; x=1763394546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mSB5ZMPnp7WzEsw8ZNn41dAZGkkyxuiFTS9pFBJYVgM=;
 b=N335EFqES9iWptG8EG3eJTdJ2nuzbYGqXDQjh5MMWz9jkgN8Dprud3e260zAc1Rxvb
 fdMU8+x+3LO6IEZ6pF8Mxh1RYsDbP85F8996Mr5WXr7Fr6cNIZMDC/Y2nIiW6IeMCvtS
 jEhcdgvpdqoPvd1FiSnaGBZA5THzGA26ddzVHYyGS14n+h83FGX+zefLhbm2FrBrpkse
 tzDCY2qIZPB/y1EQCHUHkWgE5GOorDXcAed4ZmAoNKo5NpQa9l+KYzVtIQh9TVQ3dx7g
 0fkMKa7rfvA8vEwCD4gPxQMoMWtWTGC/Seaj6mFghpDvZ1+kRvzE4S1WsjeO9NvVn+xj
 BWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789746; x=1763394546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSB5ZMPnp7WzEsw8ZNn41dAZGkkyxuiFTS9pFBJYVgM=;
 b=AOuyz6QOpjPFNqUmiftpv7DaWNSqxQDS4uXfmASwaO0OBsCKTtq+Z3vq3ZFSBCrF5c
 gR18QVF2fCPjj1HBbR5b3P8xxCz8AwbisXzp2EIxMGTVhDGzIKrjT7sncTyJ5powV8Ug
 fEiYP2rsnyaFoG1PEQsBNgPMZv4Aj0umgS+fFZTPNZV7DTJpOf0mfo3zvUND4FZBB7ae
 qqFXwGnW+W4iL+JO1doLMKXM9h8L65jGhpOM24OyvDqL/XG8peCD2TsKBfSARzes4PnW
 X0D+QdDtOiIgWuLrmZIh7E4lJwsGWaxz1xCBGuCdx8lc1IWdQIs+lXkDe+OMLpclxGeh
 ivTQ==
X-Gm-Message-State: AOJu0Yz0iwtrdrD6pJwGrvTz3wgHZmjQYBTkOghfW1sIiY5ciPjBOxKx
 VJ73VlYuRFglDb4PAhOYviOYWiAG+Drj6kE1lsWs09IG52OJ5V7ze/hhwxunSFLIPvrTFM4wR6s
 W5raTfJOlpyBaJt6u6f2n06PxL4TTN6OMn1fHl9+U7SJnlRk8GvUvbzsh
X-Gm-Gg: ASbGncvGC1Hj4mfKzC1c/cuydgWdBbT3Xv8X7tZFcmr4ssyFaDw00ExwGJd4RFEJZ9y
 iyGWum9azHaJ7OhYao96RJ9FFYz9THChy4sax7qS+dsoEMcHrFu52Nu8ewlVwodMpSd66gKBPFG
 FyEiMOIsz8PZLv/nkGYCUHMrjk/tB+fIXSyDsLqArd3VqEDhzSiwDW/K5OCFfW2UcT4TVUDzUFB
 zrbwD2vepn/dJyZbTwHXMkm9GGpOByDZppnrfoCei4avkT81CPYEpr6/uMgLkPz1eYR8jDSsUFw
 txgHqiut6z372Ixa+lirtnapvSe2+n5KVgRG0jwPgiQw8NvBfnEx4XpDMIyI0ipcQCJEUD8cYhy
 bDLJbGVWMmPQZnLu0zL9pFtx0bnKqTqBM3ll3SpHBs52ob2NijaccHXp+HA==
X-Received: by 2002:a05:600c:4594:b0:477:942:7521 with SMTP id
 5b1f17b1804b1-4777323eeb7mr64342605e9.14.1762789745727; 
 Mon, 10 Nov 2025 07:49:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEO3yhoV6JcF36AAyer2XV8za2M/6mmJ34oHAKdxhOsGBuxW21t7aCZXBo8Nc+gNkiPtivNbg==
X-Received: by 2002:a05:600c:4594:b0:477:942:7521 with SMTP id
 5b1f17b1804b1-4777323eeb7mr64342355e9.14.1762789745320; 
 Mon, 10 Nov 2025 07:49:05 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776c2aff72sm215597605e9.4.2025.11.10.07.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:04 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH v2 00/19] block: Some multi-threading fixes
Date: Mon, 10 Nov 2025 16:48:35 +0100
Message-ID: <20251110154854.151484-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

See the v1 cover letter for a general overview:

https://lists.nongnu.org/archive/html/qemu-block/2025-10/msg00501.html

Changes in v2:
- Kept `.ret = EINPGORESS`-style initializations where they already had
  been (curl, nvme)
- Dropped trivial BH waking code (i.e. which can be directly replaced by
  aio_co_wake()) in iscsi, nfs, nvme
- curl: Yield in curl_do_preadv() (former curl_setup_preadv()) and
  curl_find_buf() instead of returning whether curl_co_preadv() has to
  yield or not
- nvme: Added a patch that annotates some functions (primarily BHs and
  CBs) with which AioContext they (must) run in
- qcow2 cache-cleaning timer: Run the timer as a coroutine instead of in
  a timer CB; use a CoQueue to await it exiting instead of polling
  (well, we still need to poll in case we don’t run in a coroutine, but
  that’s standard procedure, I believe)
  - The need to initialize the CoQueue showed that there is a code path
    in qcow2 that doesn’t initialize its CoMutex.  Added a patch to do
    that.
  - Also added a patch to have the timer use realtime instead of virtual
    time.


git backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/19:[----] [--] 'block: Note on aio_co_wake use if not yet yielding'
002/19:[----] [--] 'rbd: Run co BH CB in the coroutine’s AioContext'
003/19:[0019] [FC] 'iscsi: Run co BH CB in the coroutine’s AioContext'
004/19:[0022] [FC] 'nfs: Run co BH CB in the coroutine’s AioContext'
005/19:[0060] [FC] 'curl: Fix coroutine waking'
006/19:[----] [--] 'gluster: Do not move coroutine into BDS context'
007/19:[----] [--] 'nvme: Kick and check completions in BDS context'
008/19:[0038] [FC] 'nvme: Fix coroutine waking'
009/19:[down] 'nvme: Note in which AioContext some functions run'
010/19:[----] [--] 'block/io: Take reqs_lock for tracked_requests'
011/19:[down] 'qcow2: Re-initialize lock in invalidate_cache'
012/19:[0145] [FC] 'qcow2: Fix cache_clean_timer'
013/19:[down] 'qcow2: Schedule cache-clean-timer in realtime'
014/19:[----] [--] 'ssh: Run restart_coroutine in current AioContext'
015/19:[----] [--] 'blkreplay: Run BH in coroutine’s AioContext'
016/19:[----] [--] 'block: Note in which AioContext AIO CBs are called'
017/19:[----] [--] 'iscsi: Create AIO BH in original AioContext'
018/19:[----] [--] 'null-aio: Run CB in original AioContext'
019/19:[----] [--] 'win32-aio: Run CB in original context'


Hanna Czenczek (19):
  block: Note on aio_co_wake use if not yet yielding
  rbd: Run co BH CB in the coroutine’s AioContext
  iscsi: Run co BH CB in the coroutine’s AioContext
  nfs: Run co BH CB in the coroutine’s AioContext
  curl: Fix coroutine waking
  gluster: Do not move coroutine into BDS context
  nvme: Kick and check completions in BDS context
  nvme: Fix coroutine waking
  nvme: Note in which AioContext some functions run
  block/io: Take reqs_lock for tracked_requests
  qcow2: Re-initialize lock in invalidate_cache
  qcow2: Fix cache_clean_timer
  qcow2: Schedule cache-clean-timer in realtime
  ssh: Run restart_coroutine in current AioContext
  blkreplay: Run BH in coroutine’s AioContext
  block: Note in which AioContext AIO CBs are called
  iscsi: Create AIO BH in original AioContext
  null-aio: Run CB in original AioContext
  win32-aio: Run CB in original context

 block/qcow2.h                    |   5 +-
 include/block/aio.h              |  15 ++++
 include/block/block_int-common.h |   7 +-
 block/blkreplay.c                |   3 +-
 block/curl.c                     |  45 +++++++---
 block/gluster.c                  |  17 ++--
 block/io.c                       |   3 +
 block/iscsi.c                    |  63 ++++++--------
 block/nfs.c                      |  41 ++++-----
 block/null.c                     |   7 +-
 block/nvme.c                     | 113 ++++++++++++++++--------
 block/qcow2.c                    | 145 ++++++++++++++++++++++++-------
 block/rbd.c                      |  12 +--
 block/ssh.c                      |  22 ++---
 block/win32-aio.c                |  31 +++++--
 15 files changed, 347 insertions(+), 182 deletions(-)

-- 
2.51.1


