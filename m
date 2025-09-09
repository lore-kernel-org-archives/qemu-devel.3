Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB523CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvznd-0004e0-EP; Tue, 09 Sep 2025 10:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvznb-0004de-0H
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvznN-0000V9-GD
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757429884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nDFRigSoSxQ/Pu13oozJk/hxcFT2UbcY5HoWXLUFms4=;
 b=MK5DvAXx7gGi6cyWNcTthnsV1bvkCKRuWFjSf7knOVUKwLewl+n/Xjc55nDsTg41gWMB44
 +nL86AltfayhuaHvJyCNVFKwqqBJtcvTOIhmMEog1PHpEQPqYyFWhZhrfvRymRx4E6SPsE
 Ad0fj63Bt+r+Mty0q6QDBeDMgXbXYCQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-2YWTQGgENmauIFpWjRf7WQ-1; Tue, 09 Sep 2025 10:56:57 -0400
X-MC-Unique: 2YWTQGgENmauIFpWjRf7WQ-1
X-Mimecast-MFC-AGG-ID: 2YWTQGgENmauIFpWjRf7WQ_1757429817
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-71fe8dd89c6so133607066d6.2
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 07:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757429817; x=1758034617;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDFRigSoSxQ/Pu13oozJk/hxcFT2UbcY5HoWXLUFms4=;
 b=XyubwvzIOlBxmINVIfrUZkB1vY4rXMEo9xJ8gybUqYtq9XGjXiZWqgEaLJ/PJNeTtI
 DztkoEb1tSUkt5McciUhc8djZSz5+q+Ni2vvXJx7KEznsLZClPwcKLWAvengiCAeQ0J/
 2iAsmvRUY5GuXBmm/+OsbqPBhAzjkAoQP1iTvn9kMEAKagQYXMM+gq1nMzIbyxOARbaM
 VuTKqCk2wRJUJUv5aviouEMQwsED+mwMKP5py1SYtqDMLEL5kUt2H1AEgE7fMpaF2NjA
 E6zQxJ42nWz8D5VacVMWh79lpTAgzjHsDCpOGamLopcpXsl/hmrG/UkoLTc2HToGY5/O
 FOXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3AApy+K1BkxGJT9rsmCD1lintupmUiTe3ul1sAlVmJBpXk+apcd8kp8pIW7aM0JReswlKPinG2uog@nongnu.org
X-Gm-Message-State: AOJu0YyS/iua1rKOV1FK9kabc6BIocCsx4fvbk/QxsV/d+zgZX3UkxVb
 qM7WGQuwT7wovQ7zYjTu0fJ46/QAjF1GKS3OwfU7wUAVyp9MO1T4YT50/VLxYrfzkEq3w6bVlRh
 uU4puZGAWqcLOY3ZisKvCRFo5/8AzpaGujGpmBEjmV+Ly09Ax9cXrOM9V
X-Gm-Gg: ASbGncvf//mkwQAcnL3NGojL79vQDDQnNL/lOOmcokYCXnlH61ziO8oxvpPUrLtj2nL
 Ru//863f5tl+yP5gIE+2NRX7MHNNEymDj3VJylkYr7fP3C+uej7evACpbY1ZU1jNs2VlpHp8k3d
 V0x4aFKYMKAZ6ITJ6XCuNBPKU7UF1T8iI6jvH4xibTmjixdpDCzk01WeTeJd7MOpBgyZ1BXbxTh
 4rd/ePWD43Iw53gcHuUSFe88/+Rr91Ue7XoN6d8pDoGdFdicZ4i5sYcJCu/asmOMRo4o5GxfrAi
 JMiR+CW2b2bMoEL+B0fN51nLCMVzcEah
X-Received: by 2002:a05:6214:258d:b0:72a:d613:317e with SMTP id
 6a1803df08f44-739435d4649mr126501586d6.53.1757429816950; 
 Tue, 09 Sep 2025 07:56:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM4hEmoiEkGA1Js9LWOyHOotgp+sJqninVioH25HZwBOtNjikmSaEhz1IjV/k1jrGFsaBStg==
X-Received: by 2002:a05:6214:258d:b0:72a:d613:317e with SMTP id
 6a1803df08f44-739435d4649mr126501206d6.53.1757429816211; 
 Tue, 09 Sep 2025 07:56:56 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-72bc240dc3esm94563596d6.24.2025.09.09.07.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:56:55 -0700 (PDT)
Date: Tue, 9 Sep 2025 10:56:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, mst@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: Re: [PATCH v3 5/9] net/tap: implement interfaces for local migration
Message-ID: <aMBAK58JuodeezLb@x1.local>
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
 <20250905135039.2202924-6-vsementsov@yandex-team.ru>
 <aL75XyzSI6lEOKF3@x1.local>
 <0bdf838f-8fa8-488a-b2b8-fd6d385d05ff@yandex-team.ru>
 <aL82Jqzt5iJNNjnZ@x1.local>
 <fa01e354-289b-4dc7-bfc2-02913c3e488d@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa01e354-289b-4dc7-bfc2-02913c3e488d@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 09, 2025 at 10:44:22AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 08.09.25 23:01, Peter Xu wrote:
> > On Mon, Sep 08, 2025 at 07:48:09PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 08.09.25 18:42, Peter Xu wrote:
> > > > On Fri, Sep 05, 2025 at 04:50:35PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > +static const VMStateDescription vmstate_tap = {
> > > > > +    .name = "virtio-net-device",
> > > > > +    .post_load = tap_post_load,
> > > > > +    .fields = (const VMStateField[]) {
> > > > > +        VMSTATE_FD(fd, TAPState),
> > > > > +        VMSTATE_BOOL(using_vnet_hdr, TAPState),
> > > > > +        VMSTATE_BOOL(has_ufo, TAPState),
> > > > > +        VMSTATE_BOOL(has_uso, TAPState),
> > > > > +        VMSTATE_BOOL(enabled, TAPState),
> > > > > +        VMSTATE_UINT32(host_vnet_hdr_len, TAPState),
> > > > > +        VMSTATE_END_OF_LIST()
> > > > > +    }
> > > > > +};
> > > > > +
> > > > > +int tap_save(NetClientState *nc, QEMUFile *f)
> > > > > +{
> > > > > +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> > > > > +
> > > > > +    return vmstate_save_state(f, &vmstate_tap, s, 0);
> > > > > +}
> > > > > +
> > > > > +int tap_load(NetClientState *nc, QEMUFile *f)
> > > > > +{
> > > > > +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> > > > > +
> > > > > +    return vmstate_load_state(f, &vmstate_tap, s, 0);
> > > > > +}
> > > > 
> > > > Instead of hard-coding vmstate_save_state() / vmstate_load_state(), could
> > > > we make tap's VMSD to be a subsection of virtio-net's?
> > > > 
> > > > Multifd already doesn't support qemufile, but only iochannels (which is the
> > > > internal impl of qemufiles).  We might at some point start to concurrently
> > > > load devices with multifd, then anything with qemufile will be a no-go and
> > > > need to be serialized as legacy code in the main channel, or rewritten.
> > > > 
> > > > IMHO it'll be great if we can avoid adding new codes operating on
> > > > qemufiles, and also avoid adding any new custom VMSD fields' put()/get() if
> > > > ever possible.
> > > > 
> > > 
> > > Subsections are loaded after fields.
> > > 
> > > And virtio-net already has fields
> > > 
> > >          VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
> > >                           vmstate_virtio_net_has_vnet),
> > > 
> > > and
> > > 
> > >          VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
> > >                           vmstate_virtio_net_has_ufo),
> > 
> > Side note: I'm actually a bit confused on why it needs to use
> > VMSTATE_WITH_TMP(), or say, the get()/put() directly.
> > 
> > Taking example of vmstate_virtio_net_has_ufo, afaiu, the only point here is
> > that virtio_net_ufo_post_load() would check peer UFO support.  I wonder if
> > that should work too to check that in virtio_net_post_load_device(), and
> > fail there if anything is wrong..  then would has_ufo be able to be
> > migrated as a VMSTATE_U8 field?

[1]

> > 
> > > 
> > > Which do check on virtio-net level some parameters, which should come from local migration of TAP.
> > > 
> > > That's why I made TAP a field, and put it before these two ones. This way these two checks works.
> > > 
> > > 
> > > Still, from your comment I understand that hard-coding save/load is worse problem. So I can just
> > > skip checking in vmstate_virtio_net_has_vnet / vmstate_virtio_net_has_ufo with enabled "local-tap"
> > > (or "fd-passing") capability (or better migration parameter). This way TAP may be a subsection.
> > 
> > That'll be nice, thanks.  Or would a VMSTATE_STRUCT() for TAP to work (so
> > that it can also be put before the two _TMPs, but avoid raw get()/put())?
> > 
> 
> I considered using VMSTATE_STRUCT, but it would mean, I should access TAPState directly from virtio-net
> code. That's not possible now, as TAPState is a static type in tap.c, and think it's better to keep
> it static. So, in this case, subsection should be better, if I understand correctly.

Ah OK.  Then I wonder if this is a good chance too to move the peer feature
checks above [1] directly over to virtio-net's post_load as a pre-requisite
change, which should also be after the subsections.  Then the hope is it'll
also help removing some _TMP users.

-- 
Peter Xu


