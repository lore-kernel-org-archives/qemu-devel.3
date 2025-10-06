Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74398CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 06:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5eW7-0005jp-WD; Mon, 06 Oct 2025 02:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5eW3-0005dj-Ku
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 02:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5eVz-0002jQ-OX
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 02:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759731365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+uapFG/f5rNzafYuKQGIC0MzlqTXoVoA3e6RjGcG1/M=;
 b=AcATKcxXgHbtL5OQMSPxa81JWjGC486GIwbjJ9G/wCDeRiBqPP6eYtM1HegssIzhqd6ma3
 ZMS9B8Z3zqY6julUlVGdctPvquR/k/5FDfCHGwrBeZc1QyAjvcfGlqZJTVSZoP/JjGiXnB
 DAmbV/qSTXtGNQxVM/b73nPg3r1G5G8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-c6idOQRSNjiupBUgMGQXLQ-1; Mon, 06 Oct 2025 02:16:04 -0400
X-MC-Unique: c6idOQRSNjiupBUgMGQXLQ-1
X-Mimecast-MFC-AGG-ID: c6idOQRSNjiupBUgMGQXLQ_1759731363
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e25f5ed85so28984305e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 23:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759731363; x=1760336163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uapFG/f5rNzafYuKQGIC0MzlqTXoVoA3e6RjGcG1/M=;
 b=WNr3bTR5GawrDLhKJRNZlo7iKP0bPKdqx3MYmH5lVAKxdLt5VGIypvfHYzt9cuY748
 JI+cj+tvajo4W1Q83i3MWt1dnHd7a/Lll0D6XecAs27edSC5YhGfDZShZGZ2WsBYRBnM
 H5X/DjXZ8p5cG3/JkMulanidGWVVEsaQEFi7wdoW3OoFiiWs4jqYHFshv3XMRe+IQ18o
 2NQ33JygwDjh80AMy67qmeKt3nPQk6p3zO53nCSd6BkuJib9fKunPrtfaYlShPe1oJ/w
 TdFkYyANoLgWBJjRkpBJDuFlyloboWfv98sI4yjM2I+yvakHRuW274a6O++7hugSrAMO
 KWgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyroRr6HQ+253u15AZP9PezTNR5qfmc5kn4z7RRaS4QBNKCDvZPCaRu2w8ynO8qfMLetTCwLz6/qBH@nongnu.org
X-Gm-Message-State: AOJu0YzkbnJbCAsm+e9HAkBwtZYtvd1PI8xpycWyRdsmNKpp0bmF9Ng+
 bpmx8ZklTx+3/pmk4aW8XDZZvkHd8pdyjONkdAQ/Z8zgXs9m6yvvZ3SYW6agjvLlIvlUveMcVo1
 cdwvIMRIwwpKFCsUkSPG+VGzuYYlE6TKrpewB0NiRgA2RURSyP6tdCEtf
X-Gm-Gg: ASbGnctgoymF4ROcKhtpqRwV0ZnWIc5gvxXfRP3L32fMI9dueKDkevVIZAyCligS6xX
 8amiPKq8v9Od13oo2JFkwD+bu0XcYnj55/EgA0ddrn74SJbDPui8BXSA5xl/eZv0HfOKRWXHsXl
 ITXMdWLNaHo0ASO6hVyavonqE7vQgiW2zL9iTOm7biKdN31ZXOc4WYoA1MYgFR6rFaX5qJmdC+U
 KdUtp20dhtbKrgWXx4kaKZ5fbSdEQ+gz+T69MtbzDiJxF4xMC41OI9M7j8c5XDFbbO+XAqqtoUV
 qWT46U01Yv+avveiNo/CB9RizwqkeSYxpOMEtiA=
X-Received: by 2002:a05:600c:5406:b0:46e:47cc:a17e with SMTP id
 5b1f17b1804b1-46e71101ae7mr64830475e9.1.1759731362988; 
 Sun, 05 Oct 2025 23:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEwZK3haLsZ+D4sTZJjVWzUheucPE8MJXQuFoQvAkRUOFzGvcDlx5FepERTh3SzIiPqFwQtw==
X-Received: by 2002:a05:600c:5406:b0:46e:47cc:a17e with SMTP id
 5b1f17b1804b1-46e71101ae7mr64830305e9.1.1759731362449; 
 Sun, 05 Oct 2025 23:16:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a0204fsm243475065e9.14.2025.10.05.23.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 23:16:01 -0700 (PDT)
Date: Mon, 6 Oct 2025 02:15:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-devel@nongnu.org, clement.mathieu--drif@eviden.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 Wei.Huang2@amd.com, Ankit.Soni@amd.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 18/22] amd_iommu: Toggle address translation mode on
 devtab entry invalidation
Message-ID: <20251006021525-mutt-send-email-mst@kernel.org>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
 <20250919213515.917111-19-alejandro.j.jimenez@oracle.com>
 <4856d645-ad17-4660-8012-3d315e56a463@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4856d645-ad17-4660-8012-3d315e56a463@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Oct 06, 2025 at 11:38:28AM +0530, Sairaj Kodilkar wrote:
> 
> 
> On 9/20/2025 3:05 AM, Alejandro Jimenez wrote:
> > A guest must issue an INVALIDATE_DEVTAB_ENTRY command after changing a
> > Device Table entry (DTE) e.g. after attaching a device and setting up its
> > DTE. When intercepting this event, determine if the DTE has been configured
> > for paging or not, and toggle the appropriate memory regions to allow DMA
> > address translation for the address space if needed. Requires dma-remap=on.
> > 
> > Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> > ---
> >   hw/i386/amd_iommu.c | 122 +++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 120 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> > index ce5d4c36624fd..e916dcb2be381 100644
> > --- a/hw/i386/amd_iommu.c
> > +++ b/hw/i386/amd_iommu.c
> > @@ -1032,18 +1032,136 @@ static void amdvi_reset_address_translation_all(AMDVIState *s)
> >       }
> >   }
> > +static void enable_dma_mode(AMDVIAddressSpace *as, bool inval_current)
> > +{
> > +    /*
> > +     * When enabling DMA mode for the purpose of isolating guest devices on
> > +     * a failure to retrieve or invalid DTE, all existing mappings must be
> > +     * dropped.
> > +     */
> > +    if (inval_current) {
> > +        IOMMUNotifier *n;
> > +        IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
> > +            amdvi_address_space_unmap(as, n);
> > +        }
> > +    }
> > +
> > +    if (as->addr_translation) {
> > +        return;
> > +    }
> > +
> > +    /* Installing DTE enabling translation, activate region */
> > +    as->addr_translation = true;
> > +    amdvi_switch_address_space(as);
> > +    /* Sync shadow page tables */
> > +    amdvi_address_space_sync(as);
> Hi Alejandro,
> I think we can skip amdvi_address_space_sync, because
> amdvi_switch_address_space will trigger
> amdvi_iommu_replay. this replay should unmap all the old mappings and sync
> shadow page table.
> 
> Thanks
> Sairaj

Well I queued this but this speedup can be done on top.

-- 
MST


