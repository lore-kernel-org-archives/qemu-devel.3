Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD91C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnDlX-00061x-DQ; Fri, 24 Jul 2026 07:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnDlV-000618-Tr
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnDlU-0000nl-Fk
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784891307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TTgP9rKVSe4blaJwFPTFFV8VUNgSKpPkqTYQ4PakAq8=;
 b=i8RTccA2aLzcbciLDaTKwsKmaViojr02074/ugGeotyezDy0bPzboYgu5kwQIIsBV1J4eg
 PyiCAsWSNqvJAOpcDj+RJoKkpd60HvSa3kI0+Z1V7s9muyQw2BVehzeJidemVklJQcY6Nl
 wSr9RJrNyDuBPWH6JJmFRX30QsjGmE0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-CpkRlAQiPfy_BGxweYrwfQ-1; Fri, 24 Jul 2026 07:08:26 -0400
X-MC-Unique: CpkRlAQiPfy_BGxweYrwfQ-1
X-Mimecast-MFC-AGG-ID: CpkRlAQiPfy_BGxweYrwfQ_1784891305
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-473ac08a6a4so287779f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 04:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784891305; x=1785496105; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TTgP9rKVSe4blaJwFPTFFV8VUNgSKpPkqTYQ4PakAq8=;
 b=sVqWVD3tzy8amxHNuQD1lpuZ1X+IWvSuiR/dEpyyK/IXvbxmG3nMSxJLv3I0bdBv2Q
 twpt1HjSfpKaA1gvlHqmPFwFS4V6IFerRO8RM0czs1BMXLWRwgPJKJoy7Poi/6SoytIa
 d1Db1TZKDeW9W/x/yPSM3zCCdiTVhMLD7oAy8muN9HxMQi/yrCgolyRg2LzIqNZHc6lY
 5bgfp8ZMAodCZpXuvdT3+nI+vtVa9O/vCIIHw+d6+sXVM0vS3TeZQEEzQQFjOsnG+e0K
 4JjVVNVaNg/qel5k8vCt/A/SfoRojL5NHUevBHTOBNhIwfV3Lb2nl8cseOC9kO3nrtAE
 T6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784891305; x=1785496105;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TTgP9rKVSe4blaJwFPTFFV8VUNgSKpPkqTYQ4PakAq8=;
 b=D/B9apGS7LoODIlz15cd5vRRCzsR4sDtRFlmz547LorBuPZfMKSmr/ljNyv0ldKAii
 13l3ch2m1gFleKNujVtuTgWq/RGyJPyuT1tSucO4Tx83yzfTWVBNWCcYua87hSRANhii
 EPHARKsrUcdqG+TNi3AjO9PhdmkTIRAmJFrbAGZX/5R5FcmHoKiSJ0mlL7if05e7Zp0V
 s4vAaDpn2s8rHOPqrfBs6eAf+cy4/6xPN9FmCQDYgNafeFb0sHskOPYEbddrZ2US7s0f
 ddq4bmDgKHp3xLlRuTsXfnpTPoKq30N0U89N1JRS3//OHPjvuvZCMiEWtQw1uhR5wZmH
 oP5g==
X-Gm-Message-State: AOJu0YyO3VuEQZqxLSLT05JXppje80PZWAmNAjzchVn6Cu5yTUyBBOZv
 4cpda/5VZLpJiCVhTeiSA/QAT+pC4pM9fdWiy+jkEywe7PBr57hOsK+lrtyr3fNkO9v6Go89pnV
 PJi05fxaOluoRmK4SOUxPkTbtLwyGKghJufkIqd+ivFtHSzvOku9+TB/OITIi6TaLbjvGMp2ERF
 Tx8ECh4VSK4ix9npoZXUDWcNxCmWzd9hUycQ==
X-Gm-Gg: AR+sD12i02O9ZvFR/n3wPIN6b1rna3U0p5bPNZJrVGvZYcC4Brnwiozt+0x1FKBcyOC
 G8QASSyjdTcflfNwtpGTbt/NzDx3uJYxUggU7J2qa+AYYGLmj18kARF8ruhQExaDomhKoUHwQYo
 mNgIqPyK8gzPhroSa08vxwQw3sdZHz0aMEPgS7krb2pLCmbmUsdTxolX84I4sqsGrshYaVHBK1n
 KePiHEDLgI5Y0c2yk8Uy5lerniPDlLgO4JUffiX62ZBqvrhUO+6oM72TU7ZRft0YK20TIQMIc+P
 R1knB5ghukVcVJy1w1/eZ3sHPk1hElOZ/Uo/cCa9g5fv5IOQW90sZmVDmgrMa17Q6R5RJnpQUHd
 5MCa663H4OG317tEhqmcHtQ==
X-Received: by 2002:a05:6000:18a2:b0:47f:6d4e:4cdf with SMTP id
 ffacd0b85a97d-47f8dcb00e3mr8479005f8f.58.1784891305097; 
 Fri, 24 Jul 2026 04:08:25 -0700 (PDT)
X-Received: by 2002:a05:6000:18a2:b0:47f:6d4e:4cdf with SMTP id
 ffacd0b85a97d-47f8dcb00e3mr8478925f8f.58.1784891304415; 
 Fri, 24 Jul 2026 04:08:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f864305f5sm22620436f8f.17.2026.07.24.04.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:08:24 -0700 (PDT)
Date: Fri, 24 Jul 2026 07:08:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Yuri Benditovich <ybendito@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Wei Xu <wexu@redhat.com>
Subject: [PATCH 2/2] virtio-net: fix OOB read in RSC receive path
Message-ID: <f261dcd535edc890f8636d8ae5ac1007bc32b8b4.1784891251.git.mst@redhat.com>
References: <dfd27c9b26e442a2076f6ddc9bb3d38363d9b2da.1784891251.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfd27c9b26e442a2076f6ddc9bb3d38363d9b2da.1784891251.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The RSC receive path parses incoming frames at guest_hdr_len byte
offsets, but the backend buffer contains only host_hdr_len bytes of vnet
header. If the lengths differ, RSC would read at the wrong offset and
cause an OOB read.

This is no longer possible after the previous patch, but the assumption
seem fragile. Along the defense in depth lines, let's validate.  To
ensure we are not breaking any valid setups by mistake, warn and fall
back to the normal receive path when host_hdr_len != guest_hdr_len.

Fixes: CVE-2026-63321
Fixes: 2974e916df ("virtio-net: support RSC v4/v6 tcp traffic for Windows HCK")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Yuri Benditovich <ybendito@redhat.com>
Cc: Wei Xu <wexu@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3623
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f0e3beb290..2761644dfd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2674,6 +2674,13 @@ static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf,
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
     if ((n->rsc4_enabled || n->rsc6_enabled)) {
+        /* this never happens with existing backends, but just in case. */
+        if (n->host_hdr_len != n->guest_hdr_len) {
+            warn_report_once("virtio-net: host_hdr_len %zu != guest_hdr_len %zu, "
+                             "skipping RSC",
+                             n->host_hdr_len, n->guest_hdr_len);
+            return virtio_net_do_receive(nc, buf, size);
+        }
         return virtio_net_rsc_receive(nc, buf, size);
     } else {
         return virtio_net_do_receive(nc, buf, size);
-- 
MST


