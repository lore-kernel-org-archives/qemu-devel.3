Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16713C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 12:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8u3-0003B7-Ju; Wed, 31 Jul 2024 08:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZ8u1-0003Ab-3G
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZ8tz-000097-B9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722430678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QebjzdO8f4bUP+Vpw7xQadgcETS1HjeoyInTql6N8L8=;
 b=GqRBLPgWQC32dJQ9fABmwgCeiakz8ZFEEPrZRVt5Izj8Cs0Z4doROfGjEm4aB8cSXUtQZP
 dNsekzz+wM6z1Qw8pX8fih3IGjq5MyQjhxGd97/Xn01lenBNIRl6oaj+1MyCY2FE5j/9lK
 sYUlOZmyZpJP2+SvwhkoNw6Hi32fRNI=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-yIrOxx12Ph2gXowS9ALIXg-1; Wed, 31 Jul 2024 08:57:57 -0400
X-MC-Unique: yIrOxx12Ph2gXowS9ALIXg-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5d5c2ffda25so856861eaf.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 05:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722430676; x=1723035476;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QebjzdO8f4bUP+Vpw7xQadgcETS1HjeoyInTql6N8L8=;
 b=N6KriZPqUwro+f5Mk2daqwVI22aBJFuAOvXn+bGz4UUEB8Nv7oAMZOpUgdpGV3oMsU
 /Q13UIbpvInwedXFjkJg4EBGGT493cAuHdoBNQVUKkVdNlmJ+IAE8MyV9VzgA0e5+1Ec
 XaTiEqoYa6s+4l0N2YYPp3EOl4Ue030z5uTXh9+G3RjIolBvmRNv4GKc9ByADiEOn73M
 7LFibjKap8ZERhR38r01+C9oJVgrzKB1W5tzkclfrSRTRWGuGweiXEVweWV9U0XjU/4C
 y2Pcxict8DMzUe7AURpmT0TC27n/newKA5o6ruC1s3B2kYBreLU5Jd6mhqcD4QrRPmHF
 Igmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4JUrHJmlZX6E/Vo07yUUx3DChjXIarsnGHhu3UqKW0q21SYIyAoIjc6E9mcInlv1StoX5zAjVMArZ@nongnu.org
X-Gm-Message-State: AOJu0YyaDUYAPz1rmVToFDz3xsuj7czQL3nAFu/esCTk8B/Yr629lbbx
 uvBYnPV9sW6nfkGQ7ESp5NbfYNZytE3mz4D8lwzlqCgrxVjrNpXkzar/dsUBiNQErciCI2o+zib
 oC340hFTKlVVJX1p99eFx47HDUbzG24ebExhstB9CFRbnkgrImZxe6T9OLsMt
X-Received: by 2002:a05:6358:5911:b0:1ac:f6e3:dbd0 with SMTP id
 e5c5f4694b2df-1acfad3a66amr1454834055d.3.1722430675962; 
 Wed, 31 Jul 2024 05:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1TSJ1QPgdrRiFwVwRqCKp8rpzW7mD6/czISxs/8a/+0kstbJA+IpcHgIMB/XJBPVYe1qQOg==
X-Received: by 2002:a05:6358:5911:b0:1ac:f6e3:dbd0 with SMTP id
 e5c5f4694b2df-1acfad3a66amr1454832555d.3.1722430675575; 
 Wed, 31 Jul 2024 05:57:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb3f8d82acsm72861806d6.22.2024.07.31.05.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 05:57:55 -0700 (PDT)
Date: Wed, 31 Jul 2024 08:57:52 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <Zqo00Na1MZpksY9A@x1n>
References: <ZqfKrtQSSRVnEOGt@x1n> <ZqfQ0cGf8t2trEdl@redhat.com>
 <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com>
 <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org>
 <ZqlHKaQXzKGcnoBM@x1n>
 <20240730172148-mutt-send-email-mst@kernel.org>
 <Zqnh-AJC4JPl5EkS@redhat.com>
 <20240731033803-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731033803-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 31, 2024 at 03:41:00AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 31, 2024 at 08:04:24AM +0100, Daniel P. Berrangé wrote:
> > On Tue, Jul 30, 2024 at 05:32:48PM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Jul 30, 2024 at 04:03:53PM -0400, Peter Xu wrote:
> > > > On Tue, Jul 30, 2024 at 03:22:50PM -0400, Michael S. Tsirkin wrote:
> > > > > This is not what we did historically. Why should we start now?
> > > > 
> > > > It's a matter of whether we still want migration to randomly fail, like
> > > > what this patch does.
> > > > 
> > > > Or any better suggestions?  I'm definitely open to that.
> > > > 
> > > > Thanks,
> > > > 
> > > > -- 
> > > > Peter Xu
> > > 
> > > Randomly is an overstatement. You need to switch between kernels
> > > where this feature differs. We did it with a ton of features
> > > in the past, donnu why we single out USO now.
> > 
> > This has been a problem with a ton of features in the past. We've
> > ignored the problem, but that doesn't make it the right solution
> > 
> > With regards,
> > Daniel
> 
> Pushing it to domain xml does not really help,
> migration will still fail unexpectedly (after wasting
> a ton of resources copying memory, and getting
> a downtime bump, I might add).

Could you elaborate why it would fail if with what I proposed?

Note that if this is a generic comment about "any migration can fail if we
found a device mismatch", we have plan to fix that to some degree. It's
just that we don't have enough people working on these topics yet. See:

https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake

It includes:

 "Check device tree on both sides, etc., to make sure the migration is
  applicable. E.g., we should fail early and clearly on any device
  mismatch."

However I don't think it'll cover all checks, e.g. I _think_ even if we
verify VMSDs then post_load() hooks can still fail, and there can be some
corner cases to think.  And of course, this may not even apply to virtio
since virtio manages migration itself, without providing a top-level vmsd.

> 
> The right solution is to have a tool that can query
> backends, and that given the results from all of the cluster,
> generate a set of parameters that will ensure migration works.
> Kind of like qemu-img, but for migration.

This is adding extra work, IMHO.

If we stick with "qemu cmdline as guest ABI" concept, I think we're all
fine, as that work is done by QEMU booting up first on both sides,
including dest.  Basically Libvirt already plays this role of the new tool
without any new code to be added at all: what captured on the boot failure
log will be the output of that tool if we write it.

Thanks,

-- 
Peter Xu


