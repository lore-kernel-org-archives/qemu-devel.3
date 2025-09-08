Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AA3CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 20:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvi4J-0001zh-MI; Mon, 08 Sep 2025 16:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvi3s-0001vR-SQ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 16:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvi3j-0006yR-R0
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 16:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757361707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fz3xqU01kvmtYaiEpHfL3RwYEdsOgk1MOizgfVDpVa8=;
 b=Q3pvs1hZ1ZqPJPl9deW9cjwomxE4dmoNYF3/R3IoudqFseT98I56+Z49w0302W3tqGHCJk
 oM2mFPAP+UkfPuTUoFiRkS6/3YVWGY2NRjA6j0e4Hp6lYsutAbMg/orkD10DF1QT+iv69E
 a8nzrrZLoUYd7xt5CWLi+EKhQ9fVOpU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-zggTfgU0OQygAAq_IJdQEg-1; Mon, 08 Sep 2025 16:01:45 -0400
X-MC-Unique: zggTfgU0OQygAAq_IJdQEg-1
X-Mimecast-MFC-AGG-ID: zggTfgU0OQygAAq_IJdQEg_1757361705
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b5f31ef7dfso84994941cf.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 13:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757361705; x=1757966505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fz3xqU01kvmtYaiEpHfL3RwYEdsOgk1MOizgfVDpVa8=;
 b=vEo9g9T/oFwEvZpA4m4ucwfI03ggADvtWSlUCeBRivL6TN8K0w/MhUqteO2/LTYrd7
 KDntEvG/q+4qmBDR2+FvGaWsJvKzJ//sBdbgsXiC8Rrh0jAjmyBwCBsGcuTeinoJfBvN
 S4mQUXqRzLmVsPljCD9E/REVkVkFh7H2mydM41KkPFLUiPUyAWV+U+LCjhxQOEzq2SHm
 UPWqGyYGGfzm6mzi8bfXAZOi39vXJczZJ9RoWm9aX2BsHTq7FAbC8CKDbTy2XCBfk/1e
 9s8TUkYCSdjtWvs6o8n1iuLnTLT4A8phNqj87EzfUf4SJv2xet+iSj8tqgYemtYZhJQI
 sfJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCmJ7miDtp4fxspOcNVz9vIOqXhOpcg4kcFSpBUtlZU56hp9VAlQutw89PaHScRz8FeFj/m3KMfTjA@nongnu.org
X-Gm-Message-State: AOJu0Ywf/hdjAa26ZhjbDX8rp8HlU7Ru+AkMiRLQzjbAfIwJf1R0yzUt
 2zFPjtFgkOsGQZ/0Fa0gaup1tY/M0r/WS5XVqq9nQ/rdIXPavMrDrIRzgICC0BSxBkf3gRUjLop
 8r0t3U3N4tslTECPnMR4CP0sxHiB+4z52zbJF1Bml5jxmYYZgdjlb1q+w
X-Gm-Gg: ASbGncvB9/WkNYC76nVkhcdlJiQ8hRFUwAVQxbCtlAbcAEU399US2M9T97kyKQtWOtj
 wK1hwLVsvQteRZ8YwOkUmWmdpQ9x5ab16HKUXClJ9rq8ecUeEvtdWt02O3DYTJdXSZ+Bj3mEuao
 mon82EBPCTv8oVhY8ONwzNW0x8wx+SyWOMcGUkgwEwMf5B5c42wEyZsfHoYwyGWgv6a1LQTsrkc
 GUefrItMmmqClY3w3vuTRDLT0V9HBMubIAz5LCJNanLba4sRf4ivGY5YeGGI6wFvzHZg5xJNRJz
 I2UE7wHZ/OcRrjCPHChTZmU3xAd/EbzjZwORB3/wNv0KxZgSR/gjoRuxt97junjleqXCkAay8dX
 8/Kc/qtRJcwyQcNLPiMV+fg==
X-Received: by 2002:a05:6214:f22:b0:713:2552:7be0 with SMTP id
 6a1803df08f44-73a1fbaafbdmr81157126d6.9.1757361704745; 
 Mon, 08 Sep 2025 13:01:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw9vFHtnQVRe3RGczH5Fayq+gehj2nItK+tXmm/phKzWiE+RVgNbEp+P3Z1k21oYOHyVxb7Q==
X-Received: by 2002:a05:6214:f22:b0:713:2552:7be0 with SMTP id
 6a1803df08f44-73a1fbaafbdmr81156606d6.9.1757361704161; 
 Mon, 08 Sep 2025 13:01:44 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-72160017b64sm125391066d6.55.2025.09.08.13.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 13:01:43 -0700 (PDT)
Date: Mon, 8 Sep 2025 16:01:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, mst@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: Re: [PATCH v3 5/9] net/tap: implement interfaces for local migration
Message-ID: <aL82Jqzt5iJNNjnZ@x1.local>
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
 <20250905135039.2202924-6-vsementsov@yandex-team.ru>
 <aL75XyzSI6lEOKF3@x1.local>
 <0bdf838f-8fa8-488a-b2b8-fd6d385d05ff@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0bdf838f-8fa8-488a-b2b8-fd6d385d05ff@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 08, 2025 at 07:48:09PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 08.09.25 18:42, Peter Xu wrote:
> > On Fri, Sep 05, 2025 at 04:50:35PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > +static const VMStateDescription vmstate_tap = {
> > > +    .name = "virtio-net-device",
> > > +    .post_load = tap_post_load,
> > > +    .fields = (const VMStateField[]) {
> > > +        VMSTATE_FD(fd, TAPState),
> > > +        VMSTATE_BOOL(using_vnet_hdr, TAPState),
> > > +        VMSTATE_BOOL(has_ufo, TAPState),
> > > +        VMSTATE_BOOL(has_uso, TAPState),
> > > +        VMSTATE_BOOL(enabled, TAPState),
> > > +        VMSTATE_UINT32(host_vnet_hdr_len, TAPState),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > > +int tap_save(NetClientState *nc, QEMUFile *f)
> > > +{
> > > +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> > > +
> > > +    return vmstate_save_state(f, &vmstate_tap, s, 0);
> > > +}
> > > +
> > > +int tap_load(NetClientState *nc, QEMUFile *f)
> > > +{
> > > +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> > > +
> > > +    return vmstate_load_state(f, &vmstate_tap, s, 0);
> > > +}
> > 
> > Instead of hard-coding vmstate_save_state() / vmstate_load_state(), could
> > we make tap's VMSD to be a subsection of virtio-net's?
> > 
> > Multifd already doesn't support qemufile, but only iochannels (which is the
> > internal impl of qemufiles).  We might at some point start to concurrently
> > load devices with multifd, then anything with qemufile will be a no-go and
> > need to be serialized as legacy code in the main channel, or rewritten.
> > 
> > IMHO it'll be great if we can avoid adding new codes operating on
> > qemufiles, and also avoid adding any new custom VMSD fields' put()/get() if
> > ever possible.
> > 
> 
> Subsections are loaded after fields.
> 
> And virtio-net already has fields
> 
>         VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
>                          vmstate_virtio_net_has_vnet),
> 
> and
> 
>         VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
>                          vmstate_virtio_net_has_ufo),

Side note: I'm actually a bit confused on why it needs to use
VMSTATE_WITH_TMP(), or say, the get()/put() directly.

Taking example of vmstate_virtio_net_has_ufo, afaiu, the only point here is
that virtio_net_ufo_post_load() would check peer UFO support.  I wonder if
that should work too to check that in virtio_net_post_load_device(), and
fail there if anything is wrong..  then would has_ufo be able to be
migrated as a VMSTATE_U8 field?

> 
> Which do check on virtio-net level some parameters, which should come from local migration of TAP.
> 
> That's why I made TAP a field, and put it before these two ones. This way these two checks works.
> 
> 
> Still, from your comment I understand that hard-coding save/load is worse problem. So I can just
> skip checking in vmstate_virtio_net_has_vnet / vmstate_virtio_net_has_ufo with enabled "local-tap"
> (or "fd-passing") capability (or better migration parameter). This way TAP may be a subsection.

That'll be nice, thanks.  Or would a VMSTATE_STRUCT() for TAP to work (so
that it can also be put before the two _TMPs, but avoid raw get()/put())?

-- 
Peter Xu


