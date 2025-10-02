Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60091CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 03:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v49zk-0004Si-9F; Wed, 01 Oct 2025 23:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v49zf-0004SU-N6
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:28:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v49zS-0004XZ-JY
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:28:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so4593815e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759375694; x=1759980494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UfjQR4Y9f8csqu3NmyR/zKukxoGk0bM2pEElqqrIVXw=;
 b=czTmb+JIkxXoA3YOcyWCdMb5m1mKMTeNUL2c2QYUYFCHziDb36mYH5KwD0VDZh6DBN
 KoTmDSVXMJN0TrPi61zl3dPdRfaDMRBWPtlsIIJmXCvcYh3vx4u+2+lsopjKIpyGWPGs
 jL5tP1ubLxj8/SHx1LAHLTnN2oIymyLCTrmDx6SqF2s0ItTuPca/1TjT9LYMyjJQ/Jsi
 T9Vn1f0g428dwW4tuWZ8tKnRCxP4RtnKCRc5sd/jAMaEAqDN1Riw06GjQFiOL8N5+ZYV
 4XaJh/Rvpr69pZvb4By5ZftNEU+cQz2Q83vp6lzU9YeRYHWOkyek1l+4gHTI0X24MrVL
 f5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759375694; x=1759980494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UfjQR4Y9f8csqu3NmyR/zKukxoGk0bM2pEElqqrIVXw=;
 b=imgDuH+5GLx3PZ2uVnqukJUempccffAq5rxeda6C4IlCl/aTFpuedowB+U7MX0b7Jm
 +ma1xPnsZ6ixfy+d/87s37czKNXWXPpKOZ/rDryFEQ7Hup5o2DUjdkSMOcVI8n/NF4jW
 oKwFwFu6nMBdcPSgap1P+fMGlRQNwNA0ytTmwZ7I8cVS2Y/TrJ8Rnf7Y5yQsJ5wHFft4
 ifjKiEeifAca9Tl94Dm1nUtLwawhcZ9hjThT0JHaUt80mEApuv0qaMbmjX7m9HBEdrX7
 GZidU8sLCiVWQaMhWMs4CtrkjypfPbxby2/mxrsGlDmxy9JrqJBAgwdG8Jg3/6YBk95+
 /OmA==
X-Gm-Message-State: AOJu0YxRVu76nRxNv63FR0MpcIG4YHV3V+5MNxBLIgvKzsJJlpTArDRZ
 Dq6lpfiVorZGsWgiZwempoVDBttDybzdajnxX0v7tFfmifSavg1lkg44rw0+g7tpBlfb9A7t6iI
 MspN4oa1LvQ==
X-Gm-Gg: ASbGnctekL0APCI7VDG1H6KjVOr+WtgrgZIJ9ARWl1xFVPnmU4WVxg7NWv3h6PHhErw
 wPbfm+POUc6c098IkzSB2lBKkP7Pg5g1bdQ4bavIAMpT+kY2+7ZSI8BGLmv7jsnkPOmMc7uRYyp
 JpjEfkE6JAQ1Z/fReNHgbxwcAs/d0jXPFivFMJ3tTXe+Rw8sXjeP9KzGZ/IRjZtWeP+pnIuOAqU
 s4xRJTYIaBrUNq2EC0J+I7w7X8MIgBbFboYQyvGlX5Pzz/8cZW0qvoswr9nUFXF6fZ3yBqkgn3R
 Pm/z/xE3o50oThle5eBnCdrD6ePiZH1KsRMgaCmBIzpchnBJRDwTp6/qRo5pop9OJa+4w3uf7Sz
 anCMjL2H652OdvRctJPfObkoAeiF/qSbZzpgIpFjmlt3b7uLLkIXwyXT/aYqYjiDiaVIpEdyWIB
 F/cCNZrVcVCGFqm0IuXM2pzVk6ogn6Mg==
X-Google-Smtp-Source: AGHT+IFaMeJH4C+jU1Rs3DrDDuKPH9/s2q9KQI8i51a4A4KvYP56ZA1zsf3emLdnKFGZoWVu/kjBxQ==
X-Received: by 2002:a05:600c:64c5:b0:46e:1d8d:cfb6 with SMTP id
 5b1f17b1804b1-46e612bc80dmr40792425e9.19.1759375694501; 
 Wed, 01 Oct 2025 20:28:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e693c9ca3sm14710065e9.22.2025.10.01.20.28.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 20:28:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 0/5] system/ramblock: Sanitize header
Date: Thu,  2 Oct 2025 05:28:07 +0200
Message-ID: <20251002032812.26069-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

(series fully reviewed, I plan to merge via my tree)

Usual API cleanups, here focusing on RAMBlock API:
move few prototypes out of "exec/cpu-common.h" and
"system/ram_addr.h" to "system/ramblock.h".

v2:
- Do not use ram_addr_t for offsets (rth)
v3:
- Updated subject & squashed (rth)

Philippe Mathieu-Daudé (5):
  system/ramblock: Remove obsolete comment
  system/ramblock: Move ram_block_is_pmem() declaration
  system/ramblock: Move ram_block_discard_*_range() declarations
  system/ramblock: Rename @start -> @offset in ram_block_discard_range()
  system/ramblock: Move RAMBlock helpers out of "system/ram_addr.h"

 include/exec/cpu-common.h                 |  3 ---
 include/system/ram_addr.h                 | 13 ---------
 include/system/ramblock.h                 | 27 +++++++++++++++----
 accel/kvm/kvm-all.c                       |  1 +
 hw/hyperv/hv-balloon-our_range_memslots.c |  1 +
 hw/virtio/virtio-balloon.c                |  1 +
 hw/virtio/virtio-mem.c                    |  1 +
 migration/ram.c                           |  3 ++-
 system/physmem.c                          | 33 ++++++++++++-----------
 9 files changed, 45 insertions(+), 38 deletions(-)

-- 
2.51.0


