Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C91C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 16:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sizI9-000238-LY; Tue, 27 Aug 2024 12:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sizI7-0001zX-PB
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:43:35 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sizI4-0002at-OC
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:43:34 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6b44dd520ceso55375377b3.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724777010; x=1725381810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kxqi/l8fPRJoKAG073gIxokKIwiWiOGzRM8T33WeNR0=;
 b=lqD2AhWiWO7665QPfVWWiM69kME6omQsuGF52TT6alK1ryRVFoBrq1FRXEvRcr/qLB
 p0arg9q4W4YQqg9LvD4twpVmE1yEDTxUHJNaaXOiOK5a4f+UbosK/563IP0eSiLN6Zsh
 lFuVBvZsEpV8o2Y86vEtDXca6jCvO8Ito7m9gz8GYjgYruiMSBpuMvwY6fbTsBAxTM80
 TkyccrO+9ARH6MDGdqJLWZ7tNZTw3Irv/EWSUJCPIsYckFXNLbEwBWxGz0AVpIoZVvJg
 OEmwwORaGbZGzxHYl8MQcSQkawSMFaWFL9oIzwMTL77gDO8NSoRUW6oBGsfYCSiVKKxN
 H37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724777010; x=1725381810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kxqi/l8fPRJoKAG073gIxokKIwiWiOGzRM8T33WeNR0=;
 b=GQMVzs+PCZmEUbIEKL9GUlM1jQpj3wEbtiE6v9qh5d0kUrAzZdOBV2INrveiJS83Jt
 AROA59SdC43jXwW5ECH1SO2gsB7RxenmkMQOyeLMozD9BBslr/n/MD/qEmcC+IYjRdAe
 MCZs+EK7TauVUL9l2VI7AunJXRrnkRGXTULurKBqVLumVH1oo7ZujjxyETZALGcecKOk
 VFWuR+3bpeMSIDpldJGFrA1B1Ns59B81MDOorfuTYO6TD9wA0oZ6uyLAoV6H/Bj5r2Ei
 k/vcrZIPdNK7Nj19wJZkseMO86yjAL7yXy5rqvPbJiiBg55fmJAdSe784HmA/esBY1xl
 WRkA==
X-Gm-Message-State: AOJu0YyVe8mqov8qcQzp4LavttOPbnjl6ahDQYsu9HtZiG4bfj00P59V
 bg4ErIPMYcTTk0c7jPWCQmpuIDkjWFel/aHEnLm03EEdUwuxthoQqZr8wg==
X-Google-Smtp-Source: AGHT+IFrBZvOTLy+1smD6rrcRDOnoxH91v5RK+fw5BtrUMc4IcPi7J75Z8NviyEaiWMDP6tH7FwXow==
X-Received: by 2002:a05:690c:6603:b0:6ac:f8ac:7296 with SMTP id
 00721157ae682-6c6242297f7mr166529817b3.1.1724777010433; 
 Tue, 27 Aug 2024 09:43:30 -0700 (PDT)
Received: from fan.. ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6c39a753427sm19658677b3.53.2024.08.27.09.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 09:43:30 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan.cxl@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 0/2] QEMU DCD emulation support fix
Date: Tue, 27 Aug 2024 09:40:03 -0700
Message-ID: <20240827164304.88876-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fan Ni <fan.ni@samsung.com>

In Ira's latest DCD kernel patchset[1], the More flag support has been
added. While testing it with mainstream Qemu, I identified two issues
with Qemu.

1. For a DC extent add request with more than one extents, the More flag
for the last one is not correctly set.
2. The function cxl_event_insert should only return true for the last event
record in a sequence grouped via More flag so interrupt will only be
triggered once for the sequence not every record.

After the fix of the first issue, the More flag works as expected.
While the test can pass without the second patch which fixes the second issue,
but I think we make sense to notify the OS only when all the records
are put in the event log.

[1] Last DCD kernel patchset: https://lore.kernel.org/linux-cxl/20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com/T/#t

Fan Ni (2):
  hw/mem/cxl_type3: Fix More flag setting for dynamic capacity event
    records
  hw/cxl/cxl_event: Fix interrupt triggering for dynamic capacity events
    grouped via More flag

 hw/cxl/cxl-events.c         | 8 ++++++++
 hw/mem/cxl_type3.c          | 2 +-
 include/hw/cxl/cxl_events.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.43.0


