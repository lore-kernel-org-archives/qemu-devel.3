Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF0ECD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZMPn-0000x9-DH; Tue, 16 Jun 2026 01:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZMPg-0000w4-7o
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZMPe-00048I-Ej
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781587957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C4t95kqxTSnyqUQ+eitu6vWt2c24Klc9Ps680/Aq6pc=;
 b=HkeCeIsrUp+u5rsPSwTHS65HdyKcDBLXrMjNA9S4q2jXyrZ2818J4HmaO+4UuhQr13yPSu
 4cjbjcIoCN3I20N9j/FyrelHZ6bBqnL9CGv/hH7hyXYBtnD3LxbLtyfhCPm+CB4xy9ttxx
 71+8+75iqy6GQylq7xFT2YF6R+lm3LM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-LuaNZLm5PuuAQHv4C03Z8Q-1; Tue, 16 Jun 2026 01:32:35 -0400
X-MC-Unique: LuaNZLm5PuuAQHv4C03Z8Q-1
X-Mimecast-MFC-AGG-ID: LuaNZLm5PuuAQHv4C03Z8Q_1781587955
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490d3f03883so34532345e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 22:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781587954; x=1782192754; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C4t95kqxTSnyqUQ+eitu6vWt2c24Klc9Ps680/Aq6pc=;
 b=n3bYFNbDi3xn9w4iHfGUnRRPUMElUQj8gIGixTKon5jUk+2gRMqFUTQz6qghFWr7//
 guAuuqLrg9YpnOgWtSow+DTXLNQSRBZWoRHdpB/HXDJph5VsUNVCVKmU3JftveunSbUv
 50HCALJKCJx24d2/Tanqi9J3dlPpPGjP6MJvM3HTHf3oqXht56G3nqqM1fn/Di84xaF4
 O2nHRezfktCcKdpcxre0lh2aOdKCyycivgITZGaVTExmTrVHi990ebnsNfVA+UUSoHq2
 SxAKX8NuLJRDmt+V9LxhIzodGIhmo9/Wjnu9vGZLrI118Abc+X89S86LnTs670nca63M
 Sv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781587954; x=1782192754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4t95kqxTSnyqUQ+eitu6vWt2c24Klc9Ps680/Aq6pc=;
 b=Rwbqh8uPgMfhjUSeLay1+LA+L9TA8y8Hc4dhEQhMgm9SS0y8EtikG/rUl6+FUXs0dE
 x2wNnLG/AE5pD/mUcv2zXs+mrUhxAMT3tWd6GEtQe7INNLm4mrBAxJL088eZFPxXlW2p
 jMq81ea/vQl0dskmJ/xe/gvJEjwLMPgUSExVy5YUo4eGCSjrXk4AcbohDIIm9EDh48P8
 OuUjufRFxBnXCaSR/UoKC8lOYb2J+jfM9k+/sWLtVan46U5IBnvMfSRqEccOhvk4Ptxv
 +PVMEz64pWk3IemBWzUvtyzC85DVAh0WFgIW+McZrttwK9huuvIb6dX583h1AQRJh6Zx
 rvdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UWxosQDsJ2v9VTbfYALFur27enYDQCRFoVHepb8HKUxfmX4qvdYBU522vDc7cw8eNRYiKsGlWUawe@nongnu.org
X-Gm-Message-State: AOJu0YwBkG7PGAlFEvgbbNtlxpYb2iHTNp2mMQ3ae0V8kFQ6nfOBc6BT
 q+A5x8c27+DZZnVmFa4E1cC8vdnGJfdDcZXpiPjpLH3O191rzFL2G+QpGH9GL7dcFsBUl5iysre
 ESNAMVTNJPUgKTNOQa7JYS+rKUgjVfJLUAnOG6BFJ1u1cAJQnExe7bdIX
X-Gm-Gg: Acq92OHznXQ1lR5CoYg24wzXJR0zMBojl2jUupUZAbgZCiVqqkGGsri3NEBxVAWfqNG
 cakSn5Nxirw2/It5GX1eLxf7GslhVxyPrHma4H5ZPOhYYlufIoR2oOPu2/3OJ+1e1KPNgW/RVh/
 5QOSEAXIwoBsr3E8kWYfl7cgAFdjYl5jYFLTbDSBZvXmQg9kQV6hzWG6brjNYHYkEAxDxU6UZyD
 yhKdD7UAkV8OtD2NGKO8+ZhkabtPn5ZDTkMSIgb4WVwaKiUsBfJP90yhFz6hn2x4uqc8spCriSP
 yiJxvLvv0fAO4iKDHuHho78eBck9Pm3NoONsOwMuzNLESW+SIi4AmHx6FiXEABiDALt1kLTb7jZ
 oSmo0Gb+LbYBTxSTlJELvvWnZju4OYsLMDA/11epfDJQ=
X-Received: by 2002:a05:600c:c04b:20b0:490:e1a6:25d with SMTP id
 5b1f17b1804b1-4922ff9b097mr23849735e9.26.1781587954432; 
 Mon, 15 Jun 2026 22:32:34 -0700 (PDT)
X-Received: by 2002:a05:600c:c04b:20b0:490:e1a6:25d with SMTP id
 5b1f17b1804b1-4922ff9b097mr23849125e9.26.1781587953919; 
 Mon, 15 Jun 2026 22:32:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a58fddsm29006145e9.8.2026.06.15.22.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 22:32:33 -0700 (PDT)
Date: Tue, 16 Jun 2026 01:32:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260616012616-mutt-send-email-mst@kernel.org>
References: <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
 <e399ceb9-bc4a-4ba6-8efd-ed2742d0853b@redhat.com>
 <20260615154054-mutt-send-email-mst@kernel.org>
 <22d55870-b521-4002-add7-791bce8ea96a@redhat.com>
 <20260615224658-mutt-send-email-mst@kernel.org>
 <0038f601-7647-4547-a67a-c6a17fae26ca@linaro.org>
 <20260616004924-mutt-send-email-mst@kernel.org>
 <3880910f-4465-46c5-a5e5-daa2f70821d1@redhat.com>
 <20260616010544-mutt-send-email-mst@kernel.org>
 <07119a34-d8d2-4e52-b566-267830b51a09@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07119a34-d8d2-4e52-b566-267830b51a09@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 16, 2026 at 03:21:58PM +1000, Gavin Shan wrote:
> On 6/16/26 3:17 PM, Michael S. Tsirkin wrote:
> > On Tue, Jun 16, 2026 at 02:55:52PM +1000, Gavin Shan wrote:
> > > On 6/16/26 2:49 PM, Michael S. Tsirkin wrote:
> > > > On Mon, Jun 15, 2026 at 09:48:00PM -0700, Richard Henderson wrote:
> > > > > On 6/15/26 21:23, Michael S. Tsirkin wrote:
> > > > > > B. Also on x86, I do not see why we should not use memcpy for large
> > > > > > accesses if we can. Better perf.
> > > > > 
> > > > > We have an example where memcpy writes to the same location 3 times.
> > > > > This is not appropriate for any host.
> > > > > 
> > > > > 
> > > > > r~
> > > > 
> > > > as in, same byte?  could you share the details pls?
> > > > 
> > > 
> > > This issue happened on aarch64 only.
> > > 
> > > https://lore.kernel.org/qemu-devel/CAFEAcA8dwHV8F48kb-013rxkG9kKcZhym9_qarKmoeUfeh0YWw@mail.gmail.com/
> > > 
> > > Thanks,
> > > Gavin
> > 
> > oh wow. thanks for sharing!
> > 
> > Still I think for sizes outside of 2,4,8 it's fine?
> > That is where the perf is.
> > 
> 
> For that point, I agree with you that it's fine to use memcpy/memmove
> when the length is 16-bytes or more,
> unless Richard is concerned by
> this.

yea size cutoff is a heuristic but i guess it's the best we can do.  or
disable memcpy completely if Richard feels strongly about it. But it
seems like a waste.


> I'm posting (v3) and lets continue the discussion on (v3) series. Sorry
> for taking your guys so many time to review and discuss ;-)
> 
> Thanks,
> Gavin
> 


pls do include the list of issues and high level solution in the cover
letter though.


