Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30754C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSFo-0001UJ-Nu; Mon, 14 Jul 2025 19:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFm-0001Q8-HO
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFl-0005Lx-2d
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DG1PqByL3IC/PiBLU/+s4IYueIo3mUvgkes7wFVRFTI=;
 b=U0b/6FbJSlhtKHaEl6Jz6g0QxWmbrtHxBfvkIbZanb8mrjeomFEmhs/rX5pJ5ghHP086ZL
 ryOUNm0v/VN6MpeVKLcAO6Mp5TSPbOwiPABDCVuHZAY11Elx4/zRP2Dyi9BvCCU6o29VTB
 EUDj6MsrH0KFH2+slO5SDw1Jd/ZTVKs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-yQk-9NumMM2u_eWFw6temQ-1; Mon, 14 Jul 2025 19:06:31 -0400
X-MC-Unique: yQk-9NumMM2u_eWFw6temQ-1
X-Mimecast-MFC-AGG-ID: yQk-9NumMM2u_eWFw6temQ_1752534390
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f6ff23ccso2493750f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534390; x=1753139190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DG1PqByL3IC/PiBLU/+s4IYueIo3mUvgkes7wFVRFTI=;
 b=XRM7AGNb90x0G5Z2snplX8r7Iu/u5AQM3Wev9DyGf/202lcFoz4mjBkcgrsfhOrE8u
 ue3rowMzTlUKrIOTIhwyxI8gWqO/sG/QscAe/+swHpMinAIvj0ni5sEk8F7tPw2aI4UY
 BxVHnywobv3qLhrvFHvTBZNQqNMDKyYo0d//A6LWOtQpy38q+syiRwxxukbbckpxUcq1
 G5iIeYA9N3fyBxtZ40bfurSmOwqgPgZVy0Ph7dg1I4alka++ncFL8xkJAl5PgIzAKhSi
 /Xs3zPfncwhOqUMDDbP1zGZJ0Kb2ANvFkoldxeqgNwO51EH25M4iEcUj4mYdcYznv2GK
 OmJA==
X-Gm-Message-State: AOJu0YzZMNJosb6xr41Y1nuEcsNVYba7sY0/svr2HfhDV5C7X1AjwnJP
 nKr1Vaku87Bjhras1eCYsrAI9imlnsMW3BwfxOPr4TcyFGZXZHFOSTt+/o5GnJTnmb5E87ZKf6G
 Iwwi7hogENn9wuasziKa9G6UP18nSkkUmRGpM84PG49ZQyfa7oreb02hjhAz49TjvnvZfyHaYGS
 iRnM4uk6OctyF0Qj7aso2/C3f5X4YazyP0sg==
X-Gm-Gg: ASbGnctutMKHrUw5EtHoe1xv8/E3ZD15wcF33J9FKtKvDGVGnhED3D3gARtDOCVZ2qj
 zctdCzBTCF9KqauIN/MMXU0RqIj0YZsU4HhLmoWEj5Oswbe2DyPVNyjzhSbk3sh3RRpksJK+20i
 CAJNqXGo4r16VnvnM745R8CM7GbimE0vpIrgnK9w3E5ZsvtFU9YaLS9yH4mNrwTqpEikWVWAFPM
 Q5RDp/Laq8Ofteso9bRxPGkXz8IFLPGlGyk16HF3hXl9GN37e4Dksfv/5fEuFUI26uPOh2UyVhU
 zTfqjeUmY66oiyI9nK+RyOwhCN0zixsq
X-Received: by 2002:a5d:4291:0:b0:3a5:8d0b:600c with SMTP id
 ffacd0b85a97d-3b60a145bc0mr193293f8f.3.1752534389619; 
 Mon, 14 Jul 2025 16:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR3Dj+4b4wA9vF6wyhMFuSIyxf8/5JVmz4dGLSFkKezXvZGvDRH8XKRKIzvqA2m0zyJXC0uA==
X-Received: by 2002:a5d:4291:0:b0:3a5:8d0b:600c with SMTP id
 ffacd0b85a97d-3b60a145bc0mr193282f8f.3.1752534389203; 
 Mon, 14 Jul 2025 16:06:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e285sm13352373f8f.76.2025.07.14.16.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:28 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 05/97] net/vhost-vdpa: Remove dummy SetSteeringEBPF
Message-ID: <abef963a12e2bc266884b27677ff3cf94c09e512.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

It is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250530-vdpa-v1-5-5af4109b1c19@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3452835ca9..0f782ed444 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -239,12 +239,6 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
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
@@ -458,7 +452,6 @@ static NetClientInfo net_vhost_vdpa_info = {
         .has_ufo = vhost_vdpa_has_ufo,
         .set_vnet_le = vhost_vdpa_set_vnet_le,
         .check_peer_type = vhost_vdpa_check_peer_type,
-        .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1314,7 +1307,6 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
-    .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 /*
-- 
MST


