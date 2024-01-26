Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6088C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNPG-0002dG-SF; Fri, 26 Jan 2024 09:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rTNPF-0002cC-Bg
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:42:09 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rTNPD-0001Q8-Rw
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:42:09 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40ee705e9bfso4746335e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706280125; x=1706884925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/GZnIc19yyP6aOZLjgxNv40MqHv0l7KgZDCJcfWR3fo=;
 b=XMIs2zCj+f4ltVpJ565o8q/4wIDwU/tlfrgIvstWdf8X9KVsE+4A9cCQNvGRrfL+tU
 B594gFQALQJS6cn9+gM/nIY9BA20tC8dzAIbY+racyjOr8iBUn8JXZ7IARJ79FS8PcnK
 XKDnnWiFMajGfcXep+N3fzG8oBKGcjmQ4CJrqE/4AVWFwkXS3QOL9xp/v7hyucYcaWO3
 OEPxkdPCIYZxRZEfUWNf8afqs0twBlTEPkATaa9nGalm67/HUtdhnBq40WbYa9fZKW3X
 k7L41DfsiQbnhvJsBH2b8OBiAdczKwiSdrV78JKoXBSWdOHodBLv4QOqN4gySC4VtCs+
 +DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706280125; x=1706884925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/GZnIc19yyP6aOZLjgxNv40MqHv0l7KgZDCJcfWR3fo=;
 b=ktOZGkhu6nYGPW6MEnmYYxXc4VPWNubkQohNCebCnoIbPvHZEaQvxGvHYYSh0qvLZL
 a/s9U1rgTKbAmN4g8dyob4Y+M4jYolkUOFcpQNA5U8H9Zlkx3eAE3JfN9IhnH5mr7g6D
 oLRkR3Baks0tQKckvVK8N6Q3GwZFDu8Ac4lGSMsU+9xwyqdsGoOQTlhzGgSNCi6nW0b7
 BlU6PdD0YT4WSPt7DNp45s/1fwXcX7wmemIFxDRYpahM5WLUmqNQzgvMy4ZS5qLhj51G
 +CBseiGCewaXtgFPjo0K56Ezf3vakNNt+8INS/yil6TTOPsawBGP6D7D7l403OJnqoec
 JbJQ==
X-Gm-Message-State: AOJu0YwIgs87zMFpDUDKA3ekRvurIYTPj5YZy/C+GgYbLIr5sleimCqd
 cjn7OvhGYfWTm8gWK8Mh8UD2PnUFMW4jXHo7Qtkakn04ct52iNrwB/YRPFO3Y9IDymsRoR5ySz4
 JqLs=
X-Google-Smtp-Source: AGHT+IECCQbHs192oVPCw0UFEdjVNIG7BxqjTabwXT1vVecSm1EmfuepmJkoC122Jjr8Ln0La1Vxqg==
X-Received: by 2002:a05:600c:4286:b0:40e:608a:365d with SMTP id
 v6-20020a05600c428600b0040e608a365dmr914033wmc.168.1706280124989; 
 Fri, 26 Jan 2024 06:42:04 -0800 (PST)
Received: from localhost.localdomain (adsl-114.109.242.225.tellas.gr.
 [109.242.225.114]) by smtp.gmail.com with ESMTPSA id
 ox27-20020a170907101b00b00a3221b95ce8sm699168ejb.77.2024.01.26.06.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:42:04 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Subject: [PATCH v1 0/3] Fix resource freeing bugs in virtio-gpu-rutabaga
Date: Fri, 26 Jan 2024 16:41:47 +0200
Message-Id: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

While testing the rutabaga gpu device, we noticed that if the device is 
reset, it stops working and complains about missing resource ids. A 
quick investigation discovered that the generic VirtIOGPU implementation 
frees all resources, but for Rutabaga, they are tied with rutabaga 
objects that need to be destroyed as well.

This series adds a resource_destroy class method that the Rutabaga 
device can override and do its own bookkeeping. 

Manos Pitsidianakis (3):
  hw/display/virtio-gpu.c: use reset_bh class method
  virtio-gpu.c: add resource_destroy class method
  virtio-gpu-rutabaga.c: override resource_destroy method

 hw/display/virtio-gpu-rutabaga.c | 31 ++++++++++++++++++++-----------
 hw/display/virtio-gpu.c          | 21 +++++++++++++++++----
 include/hw/virtio/virtio-gpu.h   |  2 ++
 3 files changed, 39 insertions(+), 15 deletions(-)


base-commit: e029fe22caad9b75c7ab69bd4e84853c11fb71e0
-- 
γαῖα πυρί μιχθήτω


