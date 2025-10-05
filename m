Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899FBCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UGR-00064X-Jz; Sun, 05 Oct 2025 15:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFr-0004pT-7P
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFo-0006fv-K9
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7wcSMblAe0qmcWCzx3l/Hyp9U03Fel/2vgGIAfTWdPY=;
 b=XD7s6vrGNz0LtZP1r6R5EEI38NnCo1rfafiAPeFWnqtGniorL5SpmtaBzER/gIwD++XA2N
 VGBjHfHAkl6Fl7FUHfQ4ZC2QUyK0thSHVCzpNbO3809mtXRyk9rvzLSm0uFQseeHKh/9Id
 sxYUKODAWtmk682QzyTKeBpNZbgxXkw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-6iy2ltsuMpy46sDuA0B0lA-1; Sun, 05 Oct 2025 15:18:41 -0400
X-MC-Unique: 6iy2ltsuMpy46sDuA0B0lA-1
X-Mimecast-MFC-AGG-ID: 6iy2ltsuMpy46sDuA0B0lA_1759691920
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42557bdbe50so2379229f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691919; x=1760296719;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wcSMblAe0qmcWCzx3l/Hyp9U03Fel/2vgGIAfTWdPY=;
 b=D2qcGmU1w8j6U97+n44eXYs1pvCKHJikzYo9mJL8WUVUy+1XI65RW6suG/LeudoOb2
 VUs4gO7UgP02KyaWWfdN9LaWOQIqPLcfAZ9CjjDglLFDEEPo0I0+fGBzhiLOz+YkTyse
 c/h8tg3wMrWSwTYipgnxNsTvWOIW19hhm2UEAL+ike1vgW1mXq2aHEWi7kfgrWVQrumS
 shaXQ84I6xNhqoBOzNlQ1lEKYygLT3v5f8m9ICjz4ni+4XpcIkIvVq333QSPXNCofPYN
 sfmIb50Wo+CA/n3pdhb75IETgMxdu0deLi6Ee95TmqqxzUlkgCF5mlIUEiCKzwAp7YXV
 DOqQ==
X-Gm-Message-State: AOJu0Ywio7jt2zIxbnBgK/18wbEZCvo3YXzi2jAu7X63CHMl0y5DH/Zs
 rTbCqLkblfBVgORjit/xVuIOHzBeN0L792NVffhJh/mBVfry4PydP6RaUTcJF3atdhd7Gmu+/2w
 cDevXDusUQltECIRf91rm+UCtDn/W13M9VsmmBMkDV6VuJeA8SPh7aBSyGTPTVEYoVQGfhYRSI0
 DjHuCAJNv3WIw18VJJw7f1UkjkYPHZXJBK9w==
X-Gm-Gg: ASbGncub81sgCxh6IocRlnkTOVHa0AKaatsPVIoIv+UGG0HApPbA/ECPCQUpUdm8MFW
 4OvuKB3ZtJiZ7ybodBmFRzIDL7ip1eOYngkxcQinxCIJobpwnYlAFMD9AFOxV8lLo6uCU+eqkl8
 wRxtFK3a5GXTH69+cpy5kPMucTpEWjsUEemI0DzYknIgvrn/tQ4hD0ephNYz2Q50RrvCs10pv1p
 HBn2ISTv+kSq9YaOnI1h69NudDX4kws3Fqcue+xL5j/vrRZE8otyyywMA9xnzcCJF9yei6kuIQV
 GqcRbYQch67TN8SFpD0JvRPcMZ2eOkSDxjI1EYs=
X-Received: by 2002:a05:6000:1447:b0:3ee:1494:27f5 with SMTP id
 ffacd0b85a97d-42566c15e15mr6548180f8f.13.1759691919477; 
 Sun, 05 Oct 2025 12:18:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4uNtgg2AwLFdm3cJ6XB1v5j+gYjK1t8WZjtoQY9LBGhEia7czDX3JWPNW8v6pW3q7K3uXsQ==
X-Received: by 2002:a05:6000:1447:b0:3ee:1494:27f5 with SMTP id
 ffacd0b85a97d-42566c15e15mr6548155f8f.13.1759691918854; 
 Sun, 05 Oct 2025 12:18:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f02a8sm17684257f8f.39.2025.10.05.12.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:38 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 70/75] intel-iommu: Move dma_translation to x86-iommu
Message-ID: <5ad0a139c307e0ac5c9c961fd7d810d7cf78e7b5.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joao Martins <joao.m.martins@oracle.com>

To be later reused by AMD, now that it shares similar property.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-22-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/x86-iommu.h | 1 +
 hw/i386/intel_iommu.c       | 5 ++---
 hw/i386/x86-iommu.c         | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index bfd21649d0..e89f55a5c2 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -64,6 +64,7 @@ struct X86IOMMUState {
     OnOffAuto intr_supported;   /* Whether vIOMMU supports IR */
     bool dt_supported;          /* Whether vIOMMU supports DT */
     bool pt_supported;          /* Whether vIOMMU supports pass-through */
+    bool dma_translation;       /* Whether vIOMMU supports DMA translation */
     QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */
 };
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2cc9bd5e45..fa2ad9c2eb 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2704,7 +2704,7 @@ static void vtd_handle_gcmd_write(IntelIOMMUState *s)
     uint32_t changed = status ^ val;
 
     trace_vtd_reg_write_gcmd(status, val);
-    if ((changed & VTD_GCMD_TE) && s->dma_translation) {
+    if ((changed & VTD_GCMD_TE) && x86_iommu->dma_translation) {
         /* Translation enable/disable */
         vtd_handle_gcmd_te(s, val & VTD_GCMD_TE);
     }
@@ -3947,7 +3947,6 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
-    DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
     DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
 };
@@ -4665,7 +4664,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
     if (s->dma_drain) {
         s->cap |= VTD_CAP_DRAIN;
     }
-    if (s->dma_translation) {
+    if (x86_iommu->dma_translation) {
             if (s->aw_bits >= VTD_HOST_AW_39BIT) {
                     s->cap |= VTD_CAP_SAGAW_39bit;
             }
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index d34a6849f4..c127a44bb4 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -130,6 +130,7 @@ static const Property x86_iommu_properties[] = {
                             intr_supported, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
     DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
+    DEFINE_PROP_BOOL("dma-translation", X86IOMMUState, dma_translation, true),
 };
 
 static void x86_iommu_class_init(ObjectClass *klass, const void *data)
-- 
MST


