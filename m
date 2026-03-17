Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA073FD876A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Ujw-0007lz-Rv; Tue, 17 Mar 2026 09:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2Ujs-0007l9-VA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 09:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2Ujp-0002Af-9R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 09:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773755135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kh60y58qR6LPfRiaxV2jE7W8hWj+RaAOQfVKuB0Z59A=;
 b=ZQ8ga5uv92Z1ygkXBiRncAoLB2axRCgphZkQD3sQb8dbMaFJRWQ7E7NsvWcUegkeUqyeU0
 T2aTRmPg+yzf6xw+J/SmopI0xH8z6r7xSOBd7oCZkkJZxw+Z4AT0WxE8p5nyZqkjRxMGU4
 mhPP/MsDKbbMf4HMmZSVxJgsQ7x33UI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-aeeDnYTpNjKtPnxMfcTZlw-1; Tue, 17 Mar 2026 09:45:33 -0400
X-MC-Unique: aeeDnYTpNjKtPnxMfcTZlw-1
X-Mimecast-MFC-AGG-ID: aeeDnYTpNjKtPnxMfcTZlw_1773755132
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439c54e0f6aso676175f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773755132; x=1774359932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kh60y58qR6LPfRiaxV2jE7W8hWj+RaAOQfVKuB0Z59A=;
 b=Q/764CGY6ts+QwxEkhgPLz9l9QAgd4Un2tz5Qx3/Z22qHMX9dY4y85vkLLd6ImVz8k
 NGd7Ungw3/0D3rZNDrxf95x0anH19Oa8c3K9gJOLrKE0G7sTRIFvRFgQseJ0sqjBmA1c
 i0H1p/ptAgHCxstkP2PWAaRXGx9A4JR1G2EdpSA1dxvuNIIoVYd1HtaIQRnqzjywmwiv
 0JY6Ha2NduAOzjAHqmUqgKCM6OG0BWE7yQVqLtR0jVtXQT/96cJV7DfXFrkMjGogs6O+
 rk/6hl8/MudNM3FySPDm3MMWv45J48x5ehjbQgIZ+Pi/AWhII2IugIx0QkPnRFv0iaGG
 J7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773755132; x=1774359932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kh60y58qR6LPfRiaxV2jE7W8hWj+RaAOQfVKuB0Z59A=;
 b=WPRk+3jffE6luQOMGGpfzMUR/LuOifREWmo7xjpaojZrjGyYmPASzYNqFcm15ez9Ev
 BrUAT+gAxHAjKSIQGkyb9FaLosoFj1P9I28dguKutuM2Ez6IcbZkzUf+8Y0psFQpSF84
 ldbzdzAYhRyjXczvfs43I7vK5+vUEtU8BXlUkdwGjaApQZ31CNWx87134/iTtOObDzFD
 PLpONW/jHcgY+8t3/JOrbY789PHHjA+sB64+1LnzOw3uGAYAlD5pIWDfKMI+L33sfeNl
 wjiKx9AN/ZtrL5ZkF0Y/DO2PhuNV/wC3dOxTQDP3B6FZcnhzhnd+Jc2/8HyuJTGGxhjM
 PQPQ==
X-Gm-Message-State: AOJu0YxhVKwKhWWveaRamp4AZF2KEd/aCIOmx8+Jse4mzkPr0ZBB45LX
 IEOiugrJWGtjcnw9K2tmclVDUBZXqJ3eAVUB8SZ8l4NnIeRws0leuY38AK/Zg5iCQLREaDuDEOu
 5g2G7H+oUeRX3Wwbr/FqOkFqtqB9AzMnA9OrbgxkiCmLlqkzlOKqjG5aY
X-Gm-Gg: ATEYQzz4zO6pkXAIxFP/uQQEeA3dd+SG4lbP0LA8lE52dioC0nzKGMtfPE3YhZJL/oA
 v74bHt6IK477BCTssFMXxkw+uML7LoiKKCCHFnTzR4Ydn4BEH6HIBXrTPv3xbNL3Fq2WZQFYtsJ
 Z/UYAQ3Zjy86IpEEw3CfPytcyp795VnD66yJaFflHQr/F3Z7hkej776ILARoGvriPiQkZGtT+Jx
 HTYXwaqT62CbjYf4fbxY2Ot31gyY264Ik0P8ZLSkkorBlrWuMgP0It69zb0C8GRn1jJg733XuWs
 3RRCh+ei0FaGuSDUoiXkGjMhSlEs/SPjDLjnRTeVHfFlRUWXyDd11UNm8E7ZReIJq24jWwlb+ld
 pzijM6M/59nBRZ0QsmF7oBHyK41U9HHg7dc8GZo5A3kJfHrUGs9FWlfG0inkiTthKQIiGGdNFJp
 BOqxw=
X-Received: by 2002:a05:6000:144d:b0:439:adc3:f0e7 with SMTP id
 ffacd0b85a97d-43b4981a37emr6829783f8f.9.1773755132474; 
 Tue, 17 Mar 2026 06:45:32 -0700 (PDT)
X-Received: by 2002:a05:6000:144d:b0:439:adc3:f0e7 with SMTP id
 ffacd0b85a97d-43b4981a37emr6829722f8f.9.1773755131981; 
 Tue, 17 Mar 2026 06:45:31 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0a83481d97604204561.dip0.t-ipconnect.de.
 [2003:cf:d737:d0a8:3481:d976:420:4561])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19b936sm54168435f8f.5.2026.03.17.06.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:45:31 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 0/2] Block layer patches
Date: Tue, 17 Mar 2026 14:45:19 +0100
Message-ID: <20260317134521.112121-1-hreitz@redhat.com>
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

The following changes since commit 559919ce54927d59b215a4665eda7ab6118a48aa:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-03-16 13:07:33 +0000)

are available in the Git repository at:

  https://gitlab.com/hreitz/qemu.git tags/pull-block-2026-03-17

for you to fetch changes up to 9ac85f4cc7995217db8f736733b990d6addcb036:

  block/mirror: fix assertion failure upon duplicate complete for job using 'replaces' (2026-03-17 12:31:54 +0100)

----------------------------------------------------------------
Block layer patches for rc0

- Fix race condition in throttle-group code triggering an assertion
  failure
- Fix assertion failure in mirror job when issuing job-complete twice

----------------------------------------------------------------
Alberto Garcia (1):
  throttle-group: Fix race condition in throttle_group_restart_queue()

Fiona Ebner (1):
  block/mirror: fix assertion failure upon duplicate complete for job
    using 'replaces'

 block/mirror.c          | 28 ++++++++-------
 block/throttle-groups.c | 79 +++++++++++++++++++++++++++++++----------
 2 files changed, 75 insertions(+), 32 deletions(-)

-- 
2.53.0


