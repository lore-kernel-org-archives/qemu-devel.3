Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A579DC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHTN-0003Bl-Kg; Tue, 06 May 2025 08:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uCHTM-0003AY-IJ
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uCHTF-0001GW-2R
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746534740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yAnD4p24MmaHE0LGS3PEGFO6d+NqhxceLEvFgHkZbgo=;
 b=PfeT3apgq8jLpvnoJEsRaWjIfXhBvZXFuptTA1CAxxDnRARtttl7A+GN+KLX1wC3kxmM2U
 bRm9+JM5iCWVRUgNiX2GejxPagNiCROgxfpv77ibuOQybSE0y5mAPKxtUEvmUvUINIcRY4
 KXxdxGxey+hms+UxsGET8qFqc6wUzBw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-n1LnOCQsNvabO5XEOWzh1g-1; Tue, 06 May 2025 08:32:19 -0400
X-MC-Unique: n1LnOCQsNvabO5XEOWzh1g-1
X-Mimecast-MFC-AGG-ID: n1LnOCQsNvabO5XEOWzh1g_1746534738
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so34202415e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746534738; x=1747139538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yAnD4p24MmaHE0LGS3PEGFO6d+NqhxceLEvFgHkZbgo=;
 b=pC9Qq4Fgis4+KTcA+IdnbmbWE+PJjxbav7qevhghaFuKOrA/hSoL31/kMDzDU1jzO0
 pbKTl4xAS1jMhqURMzg4AtyhSaNq5jCR2BFkUj9sYI2RNro8l5aMeny0/ZIj8BcV3IWs
 +zutlvAf5Ip23rb2PYTC6PIRfvoWxUfit1HMZv6IQOJCLoScjWwiswuQL63rKUSGeC9d
 xnUykGpnbzK+Kx482Z+dbfcuEjWTGQpByi29eTDey8hvz+hUhtmj5Z3F5ILvwQjuIz0z
 kj+gorN9Ewd6Xr+SJHKG6HM5206RgGxwyRkY304dwV0abMj+EqXC9mrYWToJsvPzulSp
 YAkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZC0SOD+5uWmH345jQ7q9uydkiUxbJBhV2E2PPFERR97HICrnPELCSc1q8D1sokYcVH+EwA1eMqK3+@nongnu.org
X-Gm-Message-State: AOJu0YwUoRViXfBgWO1Eoear8DvYDxhmJYC/wvrs3P0kxRFQhJU3RGP7
 O89xqssKIETbEpP9AGsv3TeC1IgAuCiE/A4mYzDKgBZKB7pCvW5xnZ8oIuWO4+x8eglSepIv8Vk
 KveoUuvRQczj+ZRKPW51p4Fx4HVpPbviBCmsIOV772QUB/W9An7Xhjc171FTdfEPKLNcA5/JUXg
 geW8jp1iigT6+ooo1S0pwtUSPVfu4=
X-Gm-Gg: ASbGnctQaVXHOsVlDa5+MRiMzGh5tCFoosq2nhG84BfA/y3YnE6JBmys0RCQncVtm/6
 RrwIkf6Op32DqfHYRDVpRdLIf0J3C4sfAI/LM/eeronYe0xaT277BMwgTFEEO7cgIil99Fg==
X-Received: by 2002:a05:600c:3b19:b0:43d:fa:1f9a with SMTP id
 5b1f17b1804b1-441d1015582mr20959075e9.30.1746534738226; 
 Tue, 06 May 2025 05:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYSasRMaitBx/NdfxeDcONWnQ/xk8NdUOaPJTGgbqKeuCRHcQf/lfvVrGdZRfYJ+NxP/k0ABVIsOVTj50Vd0c=
X-Received: by 2002:a05:600c:3b19:b0:43d:fa:1f9a with SMTP id
 5b1f17b1804b1-441d1015582mr20958495e9.30.1746534736980; Tue, 06 May 2025
 05:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
 <87y0vyepta.fsf@suse.de> <aAlu0hcUCdzmIN4p@x1.local>
 <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
 <aBDObgL7hDQMy63F@x1.local>
 <CAE8KmOx9yuZWWHnaA6gkC2VpeimY1=Pw+AU9iDvQ+vVpUp_vKg@mail.gmail.com>
 <87y0vag9ux.fsf@suse.de>
In-Reply-To: <87y0vag9ux.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 6 May 2025 18:02:00 +0530
X-Gm-Features: ATxdqUGgxSgVeTGkgX9NweIpMm9z8R1f3HVEny-tkULDh2wdvbYSRYnvHBYZX_g
Message-ID: <CAE8KmOw+bVP5re_OPbrqU31kss2io2m3UrnJnt89TXmvEy1ggg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hello Fabiano,

On Tue, 6 May 2025 at 00:31, Fabiano Rosas <farosas@suse.de> wrote:
> > +++ b/migration/multifd-zero-page.c
> > @@ -85,9 +85,11 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
> >  {
> >      for (int i = 0; i < p->zero_num; i++) {
> >          void *page = p->host + p->zero[i];
> > -        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
> > +        if (migrate_postcopy_ram() ||
> > +            ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
> >              memset(page, 0, multifd_ram_page_size());
> > -        } else {
> > +        }
> > +        if (!ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
> >              ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
> >          }
> >      }
> > ===
>
> I applied this diff and I'm not seeing the hang anymore.

* Great, thank you for the confirmation. I'll prepare a formal patch.

Thank you.
---
  - Prasad


