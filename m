Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09141D232C3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 23:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdz31-0006kF-6r; Thu, 08 Jan 2026 18:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vdz30-0006jR-1X
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 18:04:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vdz2x-0003R1-HI
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 18:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767913440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/zcqXucc6Don4IISiv2uBZHLXP2Ihi5zkNIIUJbbjT4=;
 b=AC0bieaW0KaooaQbPD/mW202oexeBP+mOv+K9TsWS4s0k+DCXQCvWlwNCFrMdjY2QbAJyv
 d3KmksanTdY2fxqBQ3abwoZBTXbWpQ8mmQuOCfrJ5lzBoDDF7j2PV/T/U2Hl7XAiyk0KcY
 49YEd/r9u4pRycM6eF7RvknX7fmqyqk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-m6-B8D3bPFSzjvWYUxzEgg-1; Thu, 08 Jan 2026 18:03:58 -0500
X-MC-Unique: m6-B8D3bPFSzjvWYUxzEgg-1
X-Mimecast-MFC-AGG-ID: m6-B8D3bPFSzjvWYUxzEgg_1767913438
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b2217a9c60so751668585a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 15:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767913438; x=1768518238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/zcqXucc6Don4IISiv2uBZHLXP2Ihi5zkNIIUJbbjT4=;
 b=nARCwYHZ38O0Xry+YBG/t6C3RrpQBYxtNCwPEdFVCBHf5S9bAttU5fKvp8IH3e41vA
 CJa/rK2vSSQxwk6ZUBbjNiKUUj5xbNsqk6ZdlX4uhETq4pD5AR6/Toeos2MDIGfH0jtQ
 r7soQAUMbHy29yBDA6Ntobb4ObYHyeSp1qqWQv+DzvQd9yZAqrOH0LvKevRyyG6WKN1N
 Arvokpr6VTrLQNlI2jwgWAbRc8L+F83mS+pYNWSkKV0OOIz4koBggpqhsHepepDdtHFi
 CS8QST1zTLrVHIdlYJhkGC/vmfx8trlmuNTBJE8gG2lOHcd147PcIKeEBTWa5UXIyPs2
 yAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767913438; x=1768518238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zcqXucc6Don4IISiv2uBZHLXP2Ihi5zkNIIUJbbjT4=;
 b=W+dvqLfoqSZHwZPSZ/RQBWlUatWZDhfHJJfDU9XFHCdCAa+9sSlURl3Vz38j8bslaf
 92G62es27WRDj1/+6d6ij0pfBxONvPXM7Azl2ypGxoV/ZN7MCdrFgb7GoPTa48wV61/7
 Y69E1Lu7A7FJOCf1J42PbRDCA2q9YQGzSyeP+fx6sfk3vBdCh0vAuApvfeLKXVp2SElT
 152i/BJmnmHW1XvLwapt2j/Yj43lva2uFrmRv/kUd/nYH6lmYh7gIza83qSgaXzIePJW
 rs6b3srgnc1ucW3QxGdg9tRcrMvU0/6RqJahqxa0csl2h2SCS8BUVHKHp4rsuu+H6zy4
 JnHg==
X-Gm-Message-State: AOJu0YyPACKxH7U7vPcFmJzE2UCbGzMwplKNJm12V73ImVM94HJe4hZf
 lwMIcdd3jNToakzXJTKCG0BUhdgX+2VXEO9CxkBPbi4mIklYS8tpqVnz31UJEHLTUcxDt6BGWyP
 XeZCGNlAv2sS0e8n8T66anx1JwWO3IIkg9dlSDiBVwcxZ7w81Dq3TLbh2g+6Xc2pr1LivcU62YA
 MC4t+qRxkiHBcMpuFBMgLbrqQSWFX5EtyQlnfpJWw=
X-Gm-Gg: AY/fxX5AzREXj2/7wa5fDPHVrE23fvSrq5zaCpENpQykEuUfiDHV92fFgodCa2T+xeB
 2ygz63nmPCroz5frlKAEnKolgkfYc+uOHb5QtJMQYxJ8xifzQ89tiMfa/V/hHZUkL6n+NAWaZkr
 E0Ofay/CYNEe27JJK+DKZQ8R9GUMnEKtsMDEAbdqYApXyVKDoKnxph2pNSXuSBn/HASb5f+U9Kn
 lRFJWICMSbnwFPp08G0/xbcx4Bq2LZkrgV6HeBaS0gHN0OJJSegnOQpLLEkNjo+M0sWGxkdsGTz
 ospZdaHzXpPg6HbPpPT2zsVU/2DLiJE3kF/Z/bM0bTihEujZbgquFrQrDu7a53wYyB/7NxVTgqi
 il157XbgkW9GwgUySR9cO+uQdZgNWtKsydQ1uPwA=
X-Received: by 2002:a05:620a:25d4:b0:8b2:e666:713 with SMTP id
 af79cd13be357-8c3893efb98mr1060384885a.42.1767913438022; 
 Thu, 08 Jan 2026 15:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQMFDhiTa8wzJkoWYmh7/egH71B+AcGN2okblVgRzviitgvSu37umTxvA5SbcVGYTHKbngTQ==
X-Received: by 2002:a05:620a:25d4:b0:8b2:e666:713 with SMTP id
 af79cd13be357-8c3893efb98mr1060380585a.42.1767913437534; 
 Thu, 08 Jan 2026 15:03:57 -0800 (PST)
Received: from csomani-thinkpadp1gen7.rmtusca.csb ([47.153.136.179])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f51b787sm680000685a.29.2026.01.08.15.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 15:03:57 -0800 (PST)
From: Chandan Somani <csomani@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com,
 Chandan Somani <csomani@redhat.com>
Subject: [PATCH v2 0/5] qdev release function cleanups + unit test
Date: Thu,  8 Jan 2026 15:03:06 -0800
Message-ID: <20260108230311.584141-1-csomani@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=csomani@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello,
  This was originally a single patch to make the property array release
function free the property array instead of having the users free it
in their exit functions. This fixes leaks and reduces code overhead.
After review, Marc-André asked to include some work he did on
this earlier
(https://patchew.org/QEMU/20250429140306.190384-1-marcandre.lureau@redhat.com/).
I have included his patches that added unit testing and made some
release functions idempotent.

Chandan Somani (1):
  qdev: Free property array on release

Marc-André Lureau (4):
  qdev: make release_string() idempotent
  qdev: make release_drive() idempotent
  qdev: make release_tpm() idempotent
  tests: add /qdev/free-properties test

 backends/tpm/tpm_util.c           |  1 +
 block/accounting.c                |  1 -
 hw/core/qdev-properties-system.c  |  1 +
 hw/core/qdev-properties.c         | 24 ++++----
 hw/input/stellaris_gamepad.c      |  8 ---
 hw/intc/arm_gicv3_common.c        |  8 ---
 hw/intc/rx_icu.c                  |  8 ---
 hw/misc/arm_sysctl.c              |  2 -
 hw/misc/mps2-scc.c                |  8 ---
 hw/net/rocker/rocker.c            |  1 -
 hw/nvram/xlnx-efuse.c             |  8 ---
 hw/nvram/xlnx-versal-efuse-ctrl.c |  8 ---
 hw/virtio/virtio-iommu-pci.c      |  8 ---
 tests/unit/meson.build            |  1 +
 tests/unit/test-qdev.c            | 96 +++++++++++++++++++++++++++++++
 15 files changed, 111 insertions(+), 72 deletions(-)
 create mode 100644 tests/unit/test-qdev.c

-- 
2.51.1


