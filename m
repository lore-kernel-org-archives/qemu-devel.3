Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0594FEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniB1-0002sA-2x; Wed, 04 Feb 2026 14:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAy-0002dO-KS
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAw-00089j-Ks
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fi6E2clXTxrQ+L0LRK6W+AcUGXgcfu3jZgG8jffOEZY=;
 b=YJVkczwyMMEAukjcshesnJKG349LyuHNjS1CuPo/nsfayqNlXMtUlrAkvFDWcPMaYk+mDh
 HeSgRyCpJUP/17cD+W9rp8nOD0z1WfJ9D6jLPPuhMrIU4knhkiAs6cDAuJXLY9aIs7Lm1C
 HTski5imqusr2iyOtQaw2O4IugXwxtY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-BDPJjpFcNHG8pinlBXastw-1; Wed, 04 Feb 2026 14:04:27 -0500
X-MC-Unique: BDPJjpFcNHG8pinlBXastw-1
X-Mimecast-MFC-AGG-ID: BDPJjpFcNHG8pinlBXastw_1770231866
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-480717a8ef9so1645165e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231865; x=1770836665; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fi6E2clXTxrQ+L0LRK6W+AcUGXgcfu3jZgG8jffOEZY=;
 b=bPR8TTOojnZkHRu7nzGm7dBRys5WD6jH6JtaHMtlfsm7uPfYIHTu26Yahc6PDoOTTi
 165sqIDTiBkxRfmoFZ58XidPtpwZF+QJP+zRG09rOlaiszNPYEzFOiON4IpW9ygZEg1U
 svSyjZoBKd2XyHtm18CF6PhicWDCnBHnQgLK3zBKjRrY700iyURGhEMv05aWY5sGsXjQ
 Al1QO209fwRB2iG6s1oIHxB75ieglDXsjZnOwOVCYyjETfauAo2pAmaQn07jSIxxUvHE
 sbIt3U0sW3y9By2yhYpmkcZSgHLkcneixTlhPx0dsKuu268vVhPXiCUJXq/jG77I4DhQ
 +mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231865; x=1770836665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fi6E2clXTxrQ+L0LRK6W+AcUGXgcfu3jZgG8jffOEZY=;
 b=o0TC0Fr1RFBABeiYuOGMYcb8p+uPbI0XASWEcbtk41LbtQuEvoqbm9wM3Pr/HZUYyr
 uXH7zaf2BfVhxKrXY/FFe/lONX2xKuNKGiXlWlMo4S38xtFLDktxsAuikWV77rZylfqF
 /6Xm4XxIFBoxwetlcwpEdc0Ei1K7iFYZA4VvjZEYH5Ex8WZLdHEYA45gqxOnRR1f7lAL
 2BwMyLMFnSUAXrDlpTjzBF6q/XUR6+yj1G96UWHl7I0iMu02xGu/phTyKJhahbYyT7To
 T/3qzSv77j5imyTJpUR8U2v4Ccahi9eA0X0CY7p/4YQXhltwvIdsc6+B3hP/j9CQaJnb
 hpNA==
X-Gm-Message-State: AOJu0YxQ280OHXDjWEfhkDqJhp73R3zmaDSHUhzZuxjPq6XnAgtfhTxn
 vcShTzIbkDmY0yZ/Dck6/te5cACH8I8TRNXBUK2lQZHt5sMQ3kcH31xCaXUvi3i0oobvBgcnVmV
 uvGdaXW7ml+BIQIoj28FFCYryaQkroB9CcMiD/Ans2JidoLW4XtjKbKbAUWpMnXFblYdPKfESp9
 0VDjrr1KU/dyRqCLdz8cnrMCB0NlrjdfRToA==
X-Gm-Gg: AZuq6aIyBauRAESfnlxaBo5rplyikW0gDeZuYd41R4uyNX2obR0F/UeN/MQ4FcRJvTj
 dS3fjErOgzI3ISoMMfqlbJuxelCEOWZ9mW/DQquYIPLCYjEUpSeFgJnqsNVs+ZXt9Vt32Qejc/1
 rTXpcHMBpaSpT1lIg+zoT6yrHeuMmvnZFMrSMTt0DgC91sIbMFidoDnIRpQgvIshWX7DVqrRgig
 577EvZYd4GZ8zQLa2nnGeOJGL7XCIDhxZLhoAOglaMEkdDspM0Rp/jPDd9c/b4O6vdn0cWNj+LJ
 ZuSAaxNNzsuAlJVEhoVwzA6DIATafpQIVmhJp0gUzSu0d9fu5jLzlCh8/GzDyUq27uHvEL4lGIH
 MajTw+jinbrDc8B8J9+6a/xQ+jv0xVv1ElA==
X-Received: by 2002:a05:600c:4e94:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-483179c893bmr4272465e9.14.1770231865551; 
 Wed, 04 Feb 2026 11:04:25 -0800 (PST)
X-Received: by 2002:a05:600c:4e94:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-483179c893bmr4271935e9.14.1770231865132; 
 Wed, 04 Feb 2026 11:04:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d2c88dsm5759365e9.5.2026.02.04.11.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:24 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Joelle van Dyne <j@getutm.app>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory region
Message-ID: <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Joelle van Dyne <j@getutm.app>

When `owner` == `mr`, `object_unparent` will crash:

object_unparent(mr) ->
object_property_del_child(mr, mr) ->
object_finalize_child_property(mr, name, mr) ->
object_unref(mr) ->
object_finalize(mr) ->
object_property_del_all(mr) ->
object_finalize_child_property(mr, name, mr) ->
object_unref(mr) ->
fail on g_assert(obj->ref > 0)

However, passing a different `owner` to `memory_region_init` does not
work. `memory_region_ref` has an optimization where it takes a ref
only on the owner. That means when flatviews are created, it does not
take a ref on the region and you can get a UAF from `flatview_destroy`
called from RCU.

The correct fix therefore is to use `NULL` as the name which will set
the `owner` but not the `parent` (which is still NULL). This allows us
to use `memory_region_ref` on itself while not having to rely on unparent
for cleanup.

Signed-off-by: Joelle van Dyne <j@getutm.app>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260103214400.71694-1-j@getutm.app>
---
 hw/display/virtio-gpu-virgl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 07f6355ad6..6a83fb63c8 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -120,7 +120,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     vmr->g = g;
 
     mr = &vmr->mr;
-    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
+    memory_region_init_ram_ptr(mr, OBJECT(mr), NULL, size, data);
     memory_region_add_subregion(&b->hostmem, offset, mr);
     memory_region_set_enabled(mr, true);
 
@@ -186,7 +186,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
         /* memory region owns self res->mr object and frees it by itself */
         memory_region_set_enabled(mr, false);
         memory_region_del_subregion(&b->hostmem, mr);
-        object_unparent(OBJECT(mr));
+        object_unref(OBJECT(mr));
     }
 
     return 0;
-- 
MST


