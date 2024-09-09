Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AEBECE587
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 19:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkFh-0005mc-OT; Mon, 09 Sep 2024 15:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkFg-0005lZ-Ba
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 15:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkFe-0002Nc-SD
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 15:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725910841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zDqMnkKHebw8PXTELmFNGxNcEBnXHbaf56eOXLwVQcc=;
 b=GjW8MWak/wKf8OPehMsCxl4NdyVVqvXSZOHLHJ6EgcIFbWVBHGw8NFltWH1WagFIlgCiTg
 YTKl9tOE2h+XOuwI8obTcIdYtISyAbq8Ft25F4cSRmKkbpopTlCemIRa4VLPngkocSub+u
 kVwvEfbH5UOsMqSarqA22/GuCEbBJz8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-B2StdRp9P6i7y4iu2klrQw-1; Mon, 09 Sep 2024 15:40:38 -0400
X-MC-Unique: B2StdRp9P6i7y4iu2klrQw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c3643faf9dso81789426d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 12:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725910838; x=1726515638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDqMnkKHebw8PXTELmFNGxNcEBnXHbaf56eOXLwVQcc=;
 b=V3ahI9xOBTFNF+lx0DLtpQXbIyDDJcarvwZUnA410qnZiaILALOmBZCBHYupB+Fzc+
 eoskR90wV2mYx+ssglUOB8TAfCPaMszQ0lb6Lj2agvyQp/zhE0uibJGEI0Xf8Q3pIh60
 vd2g4OUjllIehD97D4KUxntt83kexWO8mtHZxIabNs4Kb5+HVi+He8I5JmoKUl96E1jM
 x1KDXBZPZ8+ghoy+F3sEKpoteJI2F6/40lRZRHicOTiEwpd0eGa0TMBjF2N7nRCn8zT2
 BJ8utgTLbciOtExCJmjBLgCKrQ7InXdCSqDTj8Ohw/spDHL7x5lYlH8rVjMWtZAOEObh
 5Ctw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVXEW+x010oVAHsCAiYiyQNXhphs7/IrVj3Oc5y6Ph68gK7PCA7TwR/5jQI4ceNPvaFaMzm0CL1MxV@nongnu.org
X-Gm-Message-State: AOJu0Yx/wlQRpBtKQrRd/WAo/1dmQLEJveTnL30ux5r1ppJNPzxfWoVL
 aTyXsRs/gxidybpGGbxZ5x5NF7kqQhb08kiGD2Rt8ngq+5laxIm6jZCsQ+Y13RdEyYg3UDCE98F
 A2CQhq1G67E/mtzkTagZfxYGfw9MAP35CG8tLGDk86cRtWUr6iqKp
X-Received: by 2002:a05:6214:5403:b0:6c5:1614:9c59 with SMTP id
 6a1803df08f44-6c52850056emr156976586d6.31.1725910837964; 
 Mon, 09 Sep 2024 12:40:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMBJgtrRSwWRWm7O95VKNK49noc1c+Y+ukriRnDFboVb3R7xJo5oq3dKm5GSVeHm5RYrVK7Q==
X-Received: by 2002:a05:6214:5403:b0:6c5:1614:9c59 with SMTP id
 6a1803df08f44-6c52850056emr156976396d6.31.1725910837604; 
 Mon, 09 Sep 2024 12:40:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5343471b8sm23494916d6.66.2024.09.09.12.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 12:40:37 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:40:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/17] migration/multifd: Device state transfer
 support - send side
Message-ID: <Zt9PMrRXZN_qkSQ6@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
 <87h6b4nosy.fsf@suse.de>
 <bbdac26f-4a38-4cee-a9aa-cfae61b16dea@maciej.szmigiero.name>
 <87bk1anoy7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bk1anoy7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 30, 2024 at 10:02:40AM -0300, Fabiano Rosas wrote:
> >>> @@ -397,20 +404,16 @@ bool multifd_send(MultiFDSendData **send_data)
> >>>   
> >>>           p = &multifd_send_state->params[i];
> >>>           /*
> >>> -         * Lockless read to p->pending_job is safe, because only multifd
> >>> -         * sender thread can clear it.
> >>> +         * Lockless RMW on p->pending_job_preparing is safe, because only multifd
> >>> +         * sender thread can clear it after it had seen p->pending_job being set.
> >>> +         *
> >>> +         * Pairs with qatomic_store_release() in multifd_send_thread().
> >>>            */
> >>> -        if (qatomic_read(&p->pending_job) == false) {
> >>> +        if (qatomic_cmpxchg(&p->pending_job_preparing, false, true) == false) {
> >> 
> >> What's the motivation for this change? It would be better to have it in
> >> a separate patch with a proper justification.
> >
> > The original RFC patch set used dedicated device state multifd channels.
> >
> > Peter and other people wanted this functionality removed, however this caused
> > a performance (downtime) regression.
> >
> > One of the things that seemed to help mitigate this regression was making
> > the multifd channel selection more fair via this change.
> >
> > But I can split out it to a separate commit in the next patch set version and
> > then see what performance improvement it currently brings.
> 
> Yes, better to have it separate if anything for documentation of the
> rationale.

And when drafting that patch, please add a comment explaining the field.
Currently it's missing:

    /*
     * The sender thread has work to do if either of below boolean is set.
     *
     * @pending_job:  a job is pending
     * @pending_sync: a sync request is pending
     *
     * For both of these fields, they're only set by the requesters, and
     * cleared by the multifd sender threads.
     */
    bool pending_job;
    bool pending_job_preparing;
    bool pending_sync;

-- 
Peter Xu


