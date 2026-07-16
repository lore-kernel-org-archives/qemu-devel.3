Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B1BC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkM5D-0004eD-Pi; Thu, 16 Jul 2026 09:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkM5B-0004aX-IL
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkM59-0004yF-Ci
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784208293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OjlpnQMrIPAI3CcuCIhsQYoYgGq0WnEbgfZHxsyuurM=;
 b=iumrOXXgALFrbBput4Gyr9Z783jRFNb9XEINr3SW2COi3VYQopBNEzaLc5a4HIrRdcNg2R
 sAG28Yn5aJfAkVkfhfeBoLxTMSNoEyInObh9xPw09YQmQfUmLWDlKkkt3Wy41CVyAsMvau
 6ZmHWzw0skG4nOKqLvcX5z0kHhjZYd8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-pGlJLCfnO1uvIF6UuYT-Kg-1; Thu, 16 Jul 2026 09:24:52 -0400
X-MC-Unique: pGlJLCfnO1uvIF6UuYT-Kg-1
X-Mimecast-MFC-AGG-ID: pGlJLCfnO1uvIF6UuYT-Kg_1784208291
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493c47a09b5so35074555e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 06:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784208291; x=1784813091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OjlpnQMrIPAI3CcuCIhsQYoYgGq0WnEbgfZHxsyuurM=;
 b=Cn2r5L+o9nAJ3KsJXu14DhDSRDdJazUQQZatBVvs1dw9YnsfBVU1fwYDX7xIUls2K0
 d2AR/dVs53MravuwLIDVVNcg6SIA0OpRWt+Ni2N90zHAGNMg1A14z2FQ5nlBu9NX5WxL
 JhM7rDj20dQKC+O0sEaxZepxy6ttgkDbMn8wIe0TARzc/D1aHD3KwwzTfi2l36RJNcbs
 Qm9qChX2PAIPCzig+45JV4X+JuQc5AZZDvgKQAxyDic8ghH7o0sAdBlKe6XTYoc3wl9T
 ojhKb5P98M/W053chxRUxv0eMmnWObhSs4HUwdg/1QLjumno3fCKg0/6LHcdK0ULc3G4
 VHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208291; x=1784813091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OjlpnQMrIPAI3CcuCIhsQYoYgGq0WnEbgfZHxsyuurM=;
 b=FZi5ukSXQjxICwytZ/j3SmZfWa3gaoEznI95dMrzTsWls2VC5OK0V+qHgI+gNW227F
 J3BvmxxaT0ax8IOl/7HsdrKfmx8ADztrTm/ao6yXLIsyqtV7SOfdhS7biMbzia15zgTw
 Gzdc1Cjg9O4L3NYSoi4kZPpeYRkSJunSyMAsUwXZJjsrOwqFXcICJuDWFitTSn0AlMcC
 H0ssD57B07EWw4O05aClekZmDI6vpRnQoNYTpVA79Ie+CTmFWUJ9MvA33nXPBA99elOy
 9DaGOEvXW65L4PmQijb3Zbzdo/siocXGlkqHcHAx3lNU9XM8+8i4rz6GRAKDOwgd2kDp
 IvNw==
X-Gm-Message-State: AOJu0YwL6JcfvhcH+6xT8n/1FmcBFL/leuf/khUsbZKcalyLco9GnX19
 EAhFs8uIGIN3bwMeNiv7LB7wnAnkkvAPOMQ3ns8OU+Ck4TN2Ws4oaHfr/R7OdJwMHs4K3Icg9Ty
 K6jzVcQvT6hWjyEZuQWZqRlcqeKY/CfEvRU1Dt0DCZlpmXwe5xCmGa/iZtM3eTnCrj013LyUTid
 /xAOMK00IOT7mA+pHi9GWZ5Oj6cZZEG89crojCKXNocSBN
X-Gm-Gg: AfdE7clFx/0oJrWgRY4ts86FC9082LesSvJf+X761qRELQBasfvzGQ86/jGke+EKahT
 LLKyA862s8CroPZYrUoF0ZiVbpEmD8wvkQoLk0ahDKlIzdXTCVfF74bhxDP/JXRUP3vNWqtQgFv
 iYvOeic0DXvasw4TR7gUaewTKQwQEQgVHMBrLWeQqKSJnLF0QPpHRrLchILOcCywAw98Jmf3ezD
 a5ZGMaMyabKnx9h3d81pyYyGoBWIyYMldujFlgkvmLqTxF2ck17OHAiOm/NYcRjw5Gt6aoMJi/q
 bDbeOcmE5KsUpU9UyHFKz5XirOcnDm9Uo9OXNzuCXuSbwsQgTiAkXIzR0wFx4eb3yq+3obCx1bx
 +vAUf/c5MIWJk23w+Q2TIyw==
X-Received: by 2002:a05:600d:2389:b0:493:72d3:4a81 with SMTP id
 5b1f17b1804b1-4953899c3a8mr84048955e9.16.1784208290989; 
 Thu, 16 Jul 2026 06:24:50 -0700 (PDT)
X-Received: by 2002:a05:600d:2389:b0:493:72d3:4a81 with SMTP id
 5b1f17b1804b1-4953899c3a8mr84048575e9.16.1784208290475; 
 Thu, 16 Jul 2026 06:24:50 -0700 (PDT)
Received: from fedora (cst-prg-95-48.cust.vodafone.cz. [46.135.95.48])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49543e3afc2sm30347885e9.0.2026.07.16.06.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:24:49 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: qemu-devel@nongnu.org
Cc: mhrica@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, aesteve@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH 0/3] vhost-user-gpu: Add blob resource and shared memory
 support
Date: Thu, 16 Jul 2026 15:23:56 +0200
Message-ID: <20260716132359.96785-1-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Add blob resource support to the vhost-user-gpu device, enabling
Vulkan pass-through via Venus with a vhost-user backend such as
vhost-device-gpu.

Patches 1-2 forward the RESOURCE_BLOB and CONTEXT_INIT feature
flags from the backend to the guest and register a shared memory
region for SHMEM_MAP/UNMAP operations.

Patch 3 fixes a deadlock that occurs when the memory region
transaction commit (needed so the KVM slot exists before the
guest accesses the mapped region) triggers ADD_MEM_REG back to
the backend while it is still blocked waiting for the SHMEM_MAP
reply.

Dorinda Bassey (1):
  vhost: Fix SHMEM_MAP transaction ordering and resulting deadlock

Matej Hrica (2):
  vhost-user-gpu: Forward RESOURCE_BLOB and CONTEXT_INIT flags
  vhost-user-gpu: Add shared memory region support

 hw/display/vhost-user-gpu.c | 22 ++++++++++++++++++++++
 hw/virtio/vhost-user.c      |  6 +++---
 hw/virtio/vhost.c           | 10 ++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.52.0


