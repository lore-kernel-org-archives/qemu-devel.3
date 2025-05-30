Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF6DC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrRf-0001hL-83; Fri, 30 May 2025 00:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrRM-0001NA-A5
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:59 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrR6-0005NV-I1
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:55 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-23228b9d684so18509865ad.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579619; x=1749184419;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AZ7GhEwjBgkQdcPHsHCxJ1Vfs4exel6ROH4bH1WKn9M=;
 b=IOk9nMN/tyCo6EdzPkjWL/OsSJWzf6i1lBsbBEzeSM3C8t7UhiOCdyS3Ha84VeV2TD
 Tj5DUMIl4QMCd7n/Lj5EHHbqkK2eEgEoRI+Qo6gmkOinvXsYh2X9O8j0zsdxD5QRUJej
 JrJ67FBoz2n0VUEgDiVIA/sC4vZs91R2aUdrEZrB1iis5KKfgHjRvbP/Z7pRm9RWGcI1
 gKs1KPyocw9T+eEXR0JXqwF/c6M63w6mZcp7hymTAScb8D0JYDcPbmyk0kjOhKcznrPX
 Yh3aD5n4i7XI4QdqY7YAEWCaDb5IuBSd9ZU85YWNTJ+qSdYmL/kgkpUr2lKWEnTc36W1
 watQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579619; x=1749184419;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZ7GhEwjBgkQdcPHsHCxJ1Vfs4exel6ROH4bH1WKn9M=;
 b=GGfzagkGp+D2A1gX5sP0hKoWFxOoVkckRAGCnjOE/21QPsNNDvWROTDzx9QlTnx7zk
 CJRTD2onctN6+/ff1arUwdzyvpr13p3/4BVNN6zqGiGz2zqi9gRmzDuafc8MaLn+y7ly
 BvvcLTd+6FuTUclhGAxqlwaEYJcd7W1c8P78i186ZVm+K+iEajKqf1fAOaRlTlomC93w
 W56VJwGGVC+J5T6PdpBa8odP0W4zVABvzq3weJOXo28y3BDCvtROmhJgK2B1q3eCzVgX
 tizrXRBHU2pn8kETymPHAbzSmQHsEmxpVA+GYUx4EMXMgt1RF0cGjRamYbILk7/SCNf9
 S93w==
X-Gm-Message-State: AOJu0YwCt+imf35XbU2vML/QbTEGT0ucA94gFi6uwXe1M7Rk+pnkPVrb
 ouaqOeCR475/Q2xJlh7/v44AcG1L1x+Z8G+QVRF6TMXAU04r3HyhsdPnAAwHxME7FxGxuMyBWDM
 ZxLYj
X-Gm-Gg: ASbGncvwd2XGR5vrD0iXT+OvXCoPOzHT5LWbRWJm05ISHHpSXiz+mvA8WGv6CnWDLMw
 gc0qdbqx9TbZ/wQpavo0akuDmYUH6qNBBKG/KPMHHEHPy1j2zhJ5h5rfRrwrxf6QuqsXv3WRiTR
 +hepb5bSNCrLkh458AazkW9IsfUseb9Me7uKMzem+89+eoCmyAyMim04j21JRd0qMtPx9/T/teG
 EsKPUBbVanCHuiUQctvwWbHPhWgE8Aefx/cYGTY5aVIKJRZSo5TEUD7dEYmWddM5DUqcDiC+LOC
 zYCjj4ENoOTSSpJweaHPpdEhNIL9MLBO7oXvIyzDkUWV2htweS/iXv8XBNz9FZk=
X-Google-Smtp-Source: AGHT+IH9RBdYB7c8M93CuIwdStKvJKfkFSqu05PwiIw/KD8onNVHw0gHlgy4IR/W3oexgq7yle2YhA==
X-Received: by 2002:a17:903:2381:b0:235:a9b:21e0 with SMTP id
 d9443c01a7336-2353855c95emr13673435ad.0.1748579618903; 
 Thu, 29 May 2025 21:33:38 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3124e3c13ffsm342528a91.41.2025.05.29.21.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:33:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:33:20 +0900
Subject: [PATCH 5/6] net/vhost-vdpa: Remove dummy SetSteeringEBPF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-vdpa-v1-5-5af4109b1c19@daynix.com>
References: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
In-Reply-To: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

It is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/vhost-vdpa.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 4f63ded40d47..149c0f7f1766 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -238,12 +238,6 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
     g_free(s->vhost_vdpa.shared);
 }
 
-/** Dummy SetSteeringEBPF to support RSS for vhost-vdpa backend  */
-static bool vhost_vdpa_set_steering_ebpf(NetClientState *nc, int prog_fd)
-{
-    return true;
-}
-
 static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
@@ -470,7 +464,6 @@ static NetClientInfo net_vhost_vdpa_info = {
         .has_ufo = vhost_vdpa_has_ufo,
         .set_vnet_le = vhost_vdpa_set_vnet_le,
         .check_peer_type = vhost_vdpa_check_peer_type,
-        .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1344,7 +1337,6 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
-    .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 /*

-- 
2.49.0


