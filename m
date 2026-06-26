Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A98CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3RV-0001Ne-SE; Fri, 26 Jun 2026 06:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wd3RB-0001Lp-Af
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wd3R9-0002Cc-OE
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782468311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfgp9oF8S6taRG4f0QnXsq+g8DDTcG+ZqKS7UcXhPUs=;
 b=ITeRYWlkHHZmhKDoR2s8rKmxgOTaG4pNroUEPSCP2hoJ2GY6+h6n/bhdIeZSAD2Yb+4PIC
 LNhX1kGZgd9aJF3D3b2WOfRiwWWqwMLVGI6TW5AyYeDrzvSQ7gsMtCPCZaHxvoXB1KiVnZ
 G2I4dchq7V5Iu+Hsf8TDqQFZSGBfPYU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-pEm2kGStMAGheo8Htv_eFQ-1; Fri, 26 Jun 2026 06:05:10 -0400
X-MC-Unique: pEm2kGStMAGheo8Htv_eFQ-1
X-Mimecast-MFC-AGG-ID: pEm2kGStMAGheo8Htv_eFQ_1782468310
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92158791d14so107574285a.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782468310; x=1783073110; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dfgp9oF8S6taRG4f0QnXsq+g8DDTcG+ZqKS7UcXhPUs=;
 b=jD9M7+AJVnzghZxcyEGkxQeTsxdD7MlWJyrDw3BYe6P6uD0aPXq1pDUDmB9EaBAOFK
 ZISVw4dC0lhB8Kq0XUlabxy1W0eq4KkVp71EI1c3HBGe+mGFGV65DKJbeHanvAj56EoO
 IZX5ETNXn5zwiECrXVnXuFqfGpSazfKm6PBBeck6Se4d/tbnic4qt6P0/20n4MdiPppp
 zSafl8VsiJ9rJ48+uFlNx1dhyExA9YOUorvRkNXl46tJLY6Fy/R3UplUgkbyWUICAeNr
 +sklpDQaJlMw0w4bwh5hcd8pOTKIxevgi716gnLWksnFxxDKDd5K9FGLK8M3S9TBZmdv
 bRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782468310; x=1783073110;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dfgp9oF8S6taRG4f0QnXsq+g8DDTcG+ZqKS7UcXhPUs=;
 b=jZZkOxMMyx+wcwG89WUNxGse3GYxGspBJYA6TZom/Esd+H+thM7iKCcKVxqUhsmiwP
 RlBJ0WUCz11zc7hLekMv/6TzLfDyGr7LHvfxe+ILIZ0I6pXmeT1r96fO7O41rdrlOAJe
 2mpBh8iLanKrI71xKGA6hcjMw78w/kSRvBKXipGEJ4Cyi66LtSoBFqGvDbuaKcpNQr/J
 d+ayzKz70d5ltzMLsTk4J+x/W+2B08/NM+dfbj4rDQhOfeE1f4h677hnW00S3CW4dLpE
 jchCddsEyKnwJ7ZDZD2jrI/O7fKgMojYUxMiu89siHsFOSl1azcljQnuyHwtqZaGwDg5
 AiXw==
X-Gm-Message-State: AOJu0YyXtjR0+3dLVKT/qASM87WqNnnJSKHYl9BKvWrM1girmyNAhqVM
 ohQsUl/RN3PBva0d1EttasXW/h38W69lDg546FEnIbDCVqqXl0RxYFX0YYOstdP/zJXSmw7RLxe
 O9nXOtwZJ3xewnCKN3HaVSwogL2MhjalaxApXe5APPjIRJ7mDOZN4Dleuo3VEIZGR
X-Gm-Gg: AfdE7ckDY3OkMWYIyYo/IvsZFzuy/uMY0KMWhYz4AjMBtslBKdty+dJNMVpwZxWbQs2
 h/3DKVR6ajlfrsa4UDn6cY6OMm4X+r5ZGwP5z9jNWaoZuWGD5XLl5jxBWGbvmf+irfP4BD5Ugq7
 gF/0wV+Whitzw21bcWs+L73EICBdubJcEbQdLWUxHGodB4RN0WBu7VTLvTafOoeClL09hzDJmIa
 4C+0jEDU3HdX7dXgXb9UFr6XQiKtz0raWvjKiaexNvZgzuXMgqEP1HVhEHNYj9cvVBLlXn3l276
 xEG36dbtk5PutXpSLvfbrxJ6Ne1i2qqcWWZr7BfkUvhfI4aloDvTlPlASSACNPIHJngT5ixzqPU
 LdgfOoyQXuvT97Tin6s+jZBd5EP+LspKVG1/JWTyxfG1wrpGVZPjILOuIsigL5Nd8r9A22bcSwu
 aXbEoC
X-Received: by 2002:a05:620a:1b8b:b0:922:9cd7:897f with SMTP id
 af79cd13be357-9293b477292mr941065785a.4.1782468309804; 
 Fri, 26 Jun 2026 03:05:09 -0700 (PDT)
X-Received: by 2002:a05:620a:1b8b:b0:922:9cd7:897f with SMTP id
 af79cd13be357-9293b477292mr941061985a.4.1782468309345; 
 Fri, 26 Jun 2026 03:05:09 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fd390e76sm1122716485a.3.2026.06.26.03.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:05:08 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Fri, 26 Jun 2026 12:04:02 +0200
Subject: [PATCH v6 2/3] igvm: use idiomatic meson conditional for IGVM
 build files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-microvm_device_tree-v6-2-9cd13cf057e2@redhat.com>
References: <20260626-microvm_device_tree-v6-0-9cd13cf057e2@redhat.com>
In-Reply-To: <20260626-microvm_device_tree-v6-0-9cd13cf057e2@redhat.com>
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


