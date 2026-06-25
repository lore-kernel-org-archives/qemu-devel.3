Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7C3CDB47F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcewr-0005dt-8x; Thu, 25 Jun 2026 03:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wcewp-0005dW-Aw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 03:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wcewn-0003pZ-O6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 03:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782374188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfgp9oF8S6taRG4f0QnXsq+g8DDTcG+ZqKS7UcXhPUs=;
 b=RdhFtikNi0qDVpBFpSIMkOq0Bx/WvvEwHSPtBu4+YlFmGrzEsOudYTE7ZjbimA/q47qn6m
 9UK2RloH9v/eth8fKcZJEcnXljyRO9wp6tjYAP5zRfUXZIfYXiP/66PnxwWnrw58MCJq6Z
 V5egXdCvwM54aokV3FJD3VoU8Yrj8gI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-kDDog2ujO12AVRrSH8IDdg-1; Thu, 25 Jun 2026 03:56:27 -0400
X-MC-Unique: kDDog2ujO12AVRrSH8IDdg-1
X-Mimecast-MFC-AGG-ID: kDDog2ujO12AVRrSH8IDdg_1782374186
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4924725bec9so11847235e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782374186; x=1782978986; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dfgp9oF8S6taRG4f0QnXsq+g8DDTcG+ZqKS7UcXhPUs=;
 b=Y/yV5NMIjyscitnK7LtOpOKGPO1URuDhOjgGnDhHT8vc+CAt7taElP0+JXtYABA8id
 rCJs9h4UgigeoAuv63Ps5lLFLYXeE/CyE9FlZ3u7w8/5SRy3aNTvFYFjjznvFf8gZyx5
 p2lYsJbx3sv1wMiK8fY7SGmntcwqD1DhNPMtYCd6V8hXSRTXrIdl1eCM6IbLN5ioLi0E
 lWjaLStQW3JEJegSLpxKA1tpggrXLIO64Oy9wUk+xDj0a2RKKsVVc4rgZJWY3kcGJ2FY
 /jXT8yAHRW62drdOWinHxqznSrANgcO8vHQWCQoMJzis+w2aGtgIp5Mbcw9UMrJsZTOo
 6I5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374186; x=1782978986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dfgp9oF8S6taRG4f0QnXsq+g8DDTcG+ZqKS7UcXhPUs=;
 b=CJvdmexC7CODNFdHYXVj6EUjWECylk8ncSz64810bISt5g55lqKHuMhmPlQ20+gyTQ
 QGz8JuOTkphmlmwTneOSnrvMZChbRdyx9JcGGrO5HFgowylycpCBNKzCK+TujEanYVBV
 ps+NlfPcRgULH2pD9e6fgw+aFs3G5M5dFbouQ/1EwMGdUPNC5rgcQhS4hDkHhyyRgcuA
 sOVbB6z2wNldkHSFJ1Sdjt762NPoQfRgCVkWyA2KZq7Pj26QEhLjWviyMxYGMPP7b0Hf
 RtWXEkZMNIwLzhDob1f7NzgEg+EpFbRO5+zVSN+qgOcK+p2dZUb1ZRC0deL2tfdBJoOe
 OMCw==
X-Gm-Message-State: AOJu0YxD9iddBnncY+udzb9QsptbuifkAxPd2NlWGFlh9bCa14RSo0YG
 t/5XjmErx9ySTWN4koz9pqFyexY/75KL2CBX20lc9gOZ+wbp0y9LoNr3YXiE28drsyiAAaJLPBI
 JhKHnQiMj6AEZ2zhgrTOnMU0L7bYa/kPJX6ZHVCg0lxedbpGmZNC1yYaL/vIc8Bt28QOCT8fV9k
 brBMAg8lQRjdr4EelmFqvKZ13ZxKkAXLwCx4s1bL/W
X-Gm-Gg: AfdE7clSG7tZg5Z08HjwLtJ6NG7l8Pj5JTP8CXm8RMqOo7hP2D0xKbgrPc3LTrU37vA
 854F2Ww1/7MNTGOZl0Zn3wWVx90ssAFbh95oY/v9vpNNyHrNV1nWrnYV1rdjFk1H8f2pIE2crZf
 phVku3udtbIG3hjIxbSNOg79WQ8X8jR5U/RWJ/0Ti9SFio/9LoMXuRhdl8ueLC6vMQeEXRyHnYS
 AqJmUAPALynyH6fErVruOSRbcHCjdsJzE661hEMWl0a2zBMku9jre9fE0zYxp4BTLBLVvVpARPI
 0NJ/LVM5fGWzKRfCoqXCNBZu3ZNc9ZUb1oi+S05XbOtEuuzBm6bH4ae2yZfvVmSFDHv0P3WTkak
 Jmpic6fG9ZOtUwm5M6bfawCsz4rLrzF3fdE9J2KzkD/DZilydIdXIbQKEUFhWVY6hiu4AR158fh
 lnZgDK
X-Received: by 2002:a05:600d:6454:20b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-49266896338mr11829595e9.22.1782374185759; 
 Thu, 25 Jun 2026 00:56:25 -0700 (PDT)
X-Received: by 2002:a05:600d:6454:20b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-49266896338mr11829285e9.22.1782374185347; 
 Thu, 25 Jun 2026 00:56:25 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46de7effe5bsm1899390f8f.5.2026.06.25.00.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 00:56:24 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 25 Jun 2026 09:56:19 +0200
Subject: [PATCH v5 1/2] igvm: use idiomatic meson conditional for IGVM
 build files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-microvm_device_tree-v5-1-bcff11fd6d1c@redhat.com>
References: <20260625-microvm_device_tree-v5-0-bcff11fd6d1c@redhat.com>
In-Reply-To: <20260625-microvm_device_tree-v5-0-bcff11fd6d1c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace the explicit igvm.found() check with system_ss.add(when:,
if_true:), matching the pattern used by all other optional backends.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/meson.build | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/backends/meson.build b/backends/meson.build
index 60021f45d1..aabfaea5fd 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -34,11 +34,8 @@ if have_vhost_user_crypto
 endif
 system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
 system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
-if igvm.found()
-  system_ss.add(igvm)
-  system_ss.add(files('igvm-cfg.c'), igvm)
-  system_ss.add(files('igvm.c'), igvm)
-endif
+
+system_ss.add(when: igvm, if_true: [files('igvm-cfg.c', 'igvm.c')])
 
 system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
 

-- 
2.54.0


