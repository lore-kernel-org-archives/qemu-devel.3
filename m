Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BD6C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85Vi-0003mv-Ll; Thu, 24 Apr 2025 18:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u85Vd-0003mO-B0
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u85VW-0004oL-HH
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745535440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P7NFp1tNnwYGc6TJnBF+d3M4ghn8ciyuQMQaR7zMmZw=;
 b=ZVTjlsVUte9fgCtNpRwJxoHkLgV21UXFtt05ZfypVHrvXlPa4uOQ2QLRi82pQLDjQzLmOv
 ZwndhBjFee39pVjplNr1f5zBxKMxJDj/aVMTKnAqcuAvW5wQx85cJOnSvyY1GmQxApv8Jt
 P1oYOBPWx5LI9qSCTiB3Lvbjv451b4s=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-E4sbZt0ENme94CZingm_dA-1; Thu, 24 Apr 2025 18:57:18 -0400
X-MC-Unique: E4sbZt0ENme94CZingm_dA-1
X-Mimecast-MFC-AGG-ID: E4sbZt0ENme94CZingm_dA_1745535438
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-85b48e71fffso28250039f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745535437; x=1746140237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7NFp1tNnwYGc6TJnBF+d3M4ghn8ciyuQMQaR7zMmZw=;
 b=h5JY+9bo/xJ3wf1WZnD53z4ZR9zZd1J24BQ6tFCcXrTzz9B15tDJ0U8UfpMx7eo3/b
 MrO3Jbjn+E0Qm1nC3WfZo4eywmUmLSAMoTBiTfavhFLMasBxXU5RK5kk7ptC8pdjDE2B
 GeHBl027CbXCaG7v6JhDCD91iEhU46u++ekoxuePwj2YxVHIc3RmR4JtgoFQj05KjJWt
 Ju2vzEhE7FMHvWRtsT/fUnBzWVjqQv17YEINz5VX7JPYzHSn1ZHBDIjK2UFmRw1UhS93
 dvQpDVHqQGDTOR4rYzG8OQ9+eotFur2a910H8tDiPzIfB/ZnNoIRSmVWivqgfjA6lPDK
 cyfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV75nFdC8saLDUNGarxcxG+icoblGpsF35HKTerlYWOmohvSLGJhuyK0cLRs+o+xHU/JpPlSfgKqXW@nongnu.org
X-Gm-Message-State: AOJu0Yy8dtF8YzHSut0MuOkyJ3LXP9i12ghuWkZSaJbg0hINEp+6eUSa
 RAiG1XuRWuIfsOIVALGYthN2F5r2+bKEjJPE8XnYUxOuvHE9PpsHKeR/cS6rgs2yrELqX7izqlo
 6jw7ACrZqS+a+2HID/CeJrWXO+ywm3dDXFhl2xpT0qnydZTaaeCh0
X-Gm-Gg: ASbGncs+DiWPuETkXETCMusibE+K+sU+LRaPPqJ8nlYD5yqncdcFQev//IetKu/nRk+
 lNhBd9WDukdEA0Sm0ZdJspIKkbm+dul1JmuxbIHn/X3uHgODKlRdwcwxgYataVsn1qjwGoXHKC1
 OFuXNZ6J4Cpj1GVNlC+ETCJ2weWb5tuVDJWP2XwBPXBxk21LBaDkv7JwZ3mVr+/B5ZYP5p5MkV2
 m7aDpwprzkaqsxnBGRUNAx1WqZg8oelhyIPwos5VPVoMw0FiOC2i4Gy70+LBPvftoFX2LNM4fuk
 L7j8Nf8eCORK68I=
X-Received: by 2002:a92:cd8c:0:b0:3d4:2db:326f with SMTP id
 e9e14a558f8ab-3d93b656629mr176095ab.6.1745535437730; 
 Thu, 24 Apr 2025 15:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKrQt0JsrnlAF7zNUZK0TdvHCzdLaOGQfjprzdjaPeSkpf/mv7B/okgNaDkUJaFJ+XOexTJQ==
X-Received: by 2002:a92:cd8c:0:b0:3d4:2db:326f with SMTP id
 e9e14a558f8ab-3d93b656629mr176065ab.6.1745535437426; 
 Thu, 24 Apr 2025 15:57:17 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f824a40b8fsm485300173.43.2025.04.24.15.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 15:57:16 -0700 (PDT)
Date: Thu, 24 Apr 2025 16:57:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH 07/11] vfio/igd: Allow hotplugging with OpRegion enabled
Message-ID: <20250424165713.683ff583.alex.williamson@redhat.com>
In-Reply-To: <20250421163112.21316-8-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
 <20250421163112.21316-8-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On Tue, 22 Apr 2025 00:31:07 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> OpRegion is exposed to guest as a read-only fw_cfg item, so hotplugging
> with it wouldn't cause issues. Since OpRegion needs to be set up by
> guest firmware, a guest reboot is typically required. For linux guests,
> i915 driver is able to mock VBT [1] when OpRegion is not present, the
> reboot may not required.
> 
> Still, hotplugging IGD devices is highly discouraged.

So why exactly are we doing this... ?

Thanks,
Alex
 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bb1d132935c2f87cd261eb559759fe49d5e5dc43
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e94ed7029a..e3ff86d0e6 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -549,10 +549,6 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>  
>      /* Setup OpRegion access */
>      if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION)) {
> -        if (vdev->pdev.qdev.hotplugged) {
> -            error_setg(errp, "OpRegion is not supported on hotplugged device");
> -            goto error;
> -        }
>          if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
>              goto error;
>          }


