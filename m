Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09B2C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQs0-0000BU-FP; Mon, 27 Jul 2026 15:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQry-0000Ad-Hu
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrw-0000PS-KW
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2640OUuG2O/plt3Fy2X0eZtR4sI9P21G6Nt5bpP3cNo=;
 b=LkILwRjIliqJ6ldphcd4JlmZjYOi/ljnTtjaDt8mgY7Ql8boUGhv3UPJOnBkQBjtbetz2S
 Xf0JZiNOYQcr1EE183/IU7M9E/QfmOYRIJxICuSvOvvkDCAR2KWFB7KhRNH8P88rpubqUM
 u89LPnHaSDSBkkJSBrXQMsXtgtOfq6A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-Q3ys8yobO6e4WiUg-g9OTg-1; Mon, 27 Jul 2026 15:20:06 -0400
X-MC-Unique: Q3ys8yobO6e4WiUg-g9OTg-1
X-Mimecast-MFC-AGG-ID: Q3ys8yobO6e4WiUg-g9OTg_1785180005
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955843c6cdso34159605e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180005; x=1785784805; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2640OUuG2O/plt3Fy2X0eZtR4sI9P21G6Nt5bpP3cNo=;
 b=E5SsLQdY27U4R6KD6T1c0tAym4v+dHRD4Lns+hcVWNK3nAgndNJMKZMttQvJ8d1Ysp
 B/OwZ/I5Z4tbKqerLCMpcGWtVUIGsbb0ZCu6wJJAt8CqOW89sGTRxnlDXmcD6tvRemQU
 M433PBFLDqLdut780+eZOJEEiKeCtYUbSXlWJHTKz22pTIcQGmn2IOQ4BqnO+AEwehjc
 qCzO5uFTZ9GT7S3OxZDOVhRNKOLF3gPfDWqCvD1r37f57kIs+iXjnsImyYvxyaPfBqE/
 y7rvMVAVD5Ka38onjcqSU2/RT9woonN3wHpqaJYURG7avXKVCr+9wFvUm/ziNETy0nbH
 m/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180005; x=1785784805;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2640OUuG2O/plt3Fy2X0eZtR4sI9P21G6Nt5bpP3cNo=;
 b=CE6qHwj+KrHhTV5EJiLPcLps0bGsZO3MDk5ND9ASy2CVnyByZ7KH09yhRyfb5u0i6t
 X3UHTQaT1Nmujha0qQjI5VLttX9ZpJITgvmVdNuknmseyaq9kcOwn3uD3/s8QbDywVAF
 fZMv0ChpCTaIshBofSkPjVYvu1mQ7rYf1evzXfjtf3iCMxUfswP/FOWEHkvbxiUvazAG
 Pa4k3uTyZGtwQRqCYpwXQ0kPNcxAgB5CkQ9KxWq0tf7JwJKfgEgqlDI9G4qTBlBvtk5V
 AS1lNDJM/cm8EtyxB3qfmZBOSMOwhP7J0CsrGWeGjm/UGpuaryl1BWuuPLDTS3BHwu0T
 /hJA==
X-Gm-Message-State: AOJu0YwpFg/hT5iqqydwNsx6gmL7UDeKNcUdKIycJgp2nBq25EqRSpTz
 UDJHtvVy+JgJ6KwniI2qUaDz/S4AVwkNygX1+4fbwYS5bbqDuVsw05isB0DasKFbtfnq2PFZSLm
 gi9xVUDWDm3IYhcy5onbDx4mtBiC1L2MzawAOMOjCVhV1DGPb55jUAjNQ9DXTTpK4MJTIdRCpIE
 8XGtn+MTsoIVRxZg+EWZ9EBba3nsq+iYuQEQ==
X-Gm-Gg: AR+sD10B+RXLkrUY5QWACH7GQh6FYdiHPBE1/RhFYqKoOkTXk+yfTX4PE9y8O4eUXpX
 w+nqVW7jU1UXoUs84kVy4FpYxfCNZV92NNcHGGv6DYMttMuEFB15+WopX+Wfsj9oCmQ2XWStYHe
 1K9jRRPrh6xr/fQju39nJRI0VtIT84Gl7fjuy0XSfkvkCeHRHcVnUuexzQeVgU2/DZ70okd47m9
 E+l/9kB0GbHsU6hx2yQ3ULwTuhJ6v4RMcqE7MNP26ecGKouRc9LSYKXSKdTnEvUptwAUVV0cxo6
 WM0/goFgczFpEHIBnhkUsn+0futfhf4Nc1PfEqJDEyVVPK7nVtl3xrijccsU3cY5xPKiJRnYnsz
 XsnDY/53+ecsoHaOenKvofA==
X-Received: by 2002:a05:600c:8b47:b0:493:f176:dc69 with SMTP id
 5b1f17b1804b1-496b572e886mr136574295e9.37.1785180005029; 
 Mon, 27 Jul 2026 12:20:05 -0700 (PDT)
X-Received: by 2002:a05:600c:8b47:b0:493:f176:dc69 with SMTP id
 5b1f17b1804b1-496b572e886mr136573935e9.37.1785180004354; 
 Mon, 27 Jul 2026 12:20:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44af19bsm15066965e9.3.2026.07.27.12.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:03 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Feifan Qian <bea1e@proton.me>
Subject: [PULL v2 12/30] virtio: fail early on bad config_len in migration
Message-ID: <665c854390e0db15ed55b985ca850c36b28b0e57.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

virtio_load() attempts to load config_len bytes from the migration
stream. If that's huge (e.g. 4g) this will uselessly spin
beyond the end of the stream for seconds. Not nice.
Check qemu_file_get_error() and bail out early, instead.

Also note that config_len is int32_t but is coerced to unsigned when
used. Switch it to uint32_t to make this clearer.

Fixes: 2f5732e964 ("Allow mismatched virtio config-len")
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3891
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <cfbefa358af5885eb386637216552bfeba5e7bbc.1784898922.git.mst@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hw/virtio/virtio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2766217ddd..979c4065b7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3505,7 +3505,7 @@ int coroutine_mixed_fn
 virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 {
     int i, ret;
-    int32_t config_len;
+    uint32_t config_len;
     uint32_t num;
     uint32_t features;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
@@ -3553,6 +3553,9 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     qemu_get_buffer(f, vdev->config, MIN(config_len, vdev->config_len));
 
     while (config_len > vdev->config_len) {
+        if (qemu_file_get_error(f)) {
+            return -1;
+        }
         qemu_get_byte(f);
         config_len--;
     }
-- 
MST


