Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F88FCD11BF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 10:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roKjC-0003VR-BQ; Sun, 24 Mar 2024 06:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1roKj9-0003Uk-32
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 06:05:19 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1roKj7-0002lW-Io
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 06:05:18 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-568c714a9c7so3977385a12.2
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711274715; x=1711879515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CgL3dvbqfXtunyQIdDYczEnBfF91tJ9I5F7zxRRiOys=;
 b=BuUc+eIkFkrtmwPQIqnyEoo8K1e9CjV1/KD/jFiUQ+vhKUaoFjhDRqYZ7wMIdOWklD
 xbGsnZA2v0gmBOZT00cbES2R3NkrrQuAlEl7AmVM8c69c7TLJCwheyyOdVhJRlscGvlE
 /rIAGldTUJitSISqlc76SZdwXZ/+fM8GbJcJHJuYHLjqtnGuDzEenMRb9x0BARSNGE9l
 hA02lypKivzGSycH3enKMpCCmNXpP4KntJYTS9ZzZFeo8Go3gRCeStdL2c3DKayBr/tU
 CZG4QS3MQ67ZrHfDKIUh4+Tv3JliMAeHaf/N8NTexDG7nsfLYfTdRtG55kDXKIQKGNSR
 gYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711274715; x=1711879515;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CgL3dvbqfXtunyQIdDYczEnBfF91tJ9I5F7zxRRiOys=;
 b=d1XEzSXA6fLp5hvRVlJE9Bv8bSwxifC3uo54m9Tr1pzFQuRl/AxloBoQny+SgRh2Dg
 aCCG0AoURFa8MhCOwl/dVnQaJEkDINwC57zVzAO276IHFmuPIEjpBRtOXnYFTculs38K
 JMFxi9wb29PCWzDcgnfdrH6ZJk1o30wCFp62zIDCYWeYyda2kzwLLWPkFs7oHsm9ngx0
 s0+dezLTUgOmslkhaUtcgw4Z9rTnXgXjfzXnTb3W/YrrW5i+OV7KRiuVCQw2taa+ndv/
 UDcoNlihrWRnLv8qIn2Fwg8iObu0od7DmlROPbPI9f9vbo6Xe9kjccY+d+amOzOE2wCv
 EvMw==
X-Gm-Message-State: AOJu0Yzu1v+02P1LuId2subbTLMc0/Yp7MpdxYd/Ge+68h5Fbg/Vk2Pg
 aWP+rt2gyddDgNIGnExV0IET/7S4eik6rBrEBDB8xDpvxUURETjGPPVDcUlQ2I/S70uKju27NsO
 Qx0Q=
X-Google-Smtp-Source: AGHT+IF5BoSHvQYqAzetuohDwUZ2D5hmP19aelohfmgKhrFe9nubNu2hGSWkUvhUhMjyJS011emM4g==
X-Received: by 2002:a17:906:487:b0:a47:3428:2b2f with SMTP id
 f7-20020a170906048700b00a4734282b2fmr2634946eja.64.1711274715124; 
 Sun, 24 Mar 2024 03:05:15 -0700 (PDT)
Received: from localhost.localdomain (adsl-53.37.6.2.tellas.gr. [37.6.2.53])
 by smtp.gmail.com with ESMTPSA id
 lb25-20020a170907785900b00a3d11feb32esm1812537ejc.186.2024.03.24.03.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Mar 2024 03:05:14 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: Zheyu Ma <zheyuma97@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 0/1] virtio-snd: fix invalid tx/rx message handling logic
Date: Sun, 24 Mar 2024 12:04:58 +0200
Message-Id: <cover.virtio-snd-rewrite-invalid-tx-rx-message-handling-v1.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

This is a logic fix for the error handling in the TX/RX virt queue 
handlers. A potential invalid address dereference was reported and fixed 
by Zheyu Ma in <20240322110827.568412-1-zheyuma97@gmail.com>. This patch 
moves the invalid message storage from the stream structs to the virtio 
device struct to

1. make such bug impossible
2. reply to invalid messages again with VIRTIO_SND_S_BAD_MSG, which was 
not possible before.

Patch based on master base-commit: 853546f8128476eefb701d4a55b2781bb3a46faa
with the following patch applied:

  Subject: [PATCH v2] virtio-snd: Enhance error handling for invalid
   transfers
  From: Zheyu Ma <zheyuma97@gmail.com>
  Date: Fri, 22 Mar 2024 12:08:27 +0100
  Message-Id: <20240322110827.568412-1-zheyuma97@gmail.com>


Manos Pitsidianakis (1):
  virtio-snd: rewrite invalid tx/rx message handling

 include/hw/audio/virtio-snd.h |  16 +++-
 hw/audio/virtio-snd.c         | 137 +++++++++++++++-------------------
 2 files changed, 77 insertions(+), 76 deletions(-)


base-commit: 853546f8128476eefb701d4a55b2781bb3a46faa
prerequisite-patch-id: 8209301569bd30ba806d06b3452a2f3156503a7a
-- 
γαῖα πυρί μιχθήτω


