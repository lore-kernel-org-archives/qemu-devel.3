Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C45CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 21:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxBIM-0005QR-PQ; Fri, 12 Sep 2025 17:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uxBIK-0005Px-St
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 17:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uxBII-0008N1-He
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 17:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757712415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OdcviHaxc0ZxN18Fc55Jn/oo/bxAS8OUZkEK0Pw4+U=;
 b=UPf8TvfAFD7PtbaO6vc7h2A16Ey/gRhe8qrIqBMwCsFkBZ9CZBSB6SWHMi3/kNp0UYSX4j
 UNTqaNoi6EqSk/PX4/+w+Wr3IYc/95zkHsMoGD0viabqWmyVVf/m2WDKIdHQgSxT3qqrUr
 LlPG9qgjypwSH4JlmLsHltFH0dbN0rY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-3zcDQTs0NYSEBovSnn_JAw-1; Fri, 12 Sep 2025 17:26:53 -0400
X-MC-Unique: 3zcDQTs0NYSEBovSnn_JAw-1
X-Mimecast-MFC-AGG-ID: 3zcDQTs0NYSEBovSnn_JAw_1757712413
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8217df6d44cso447543985a.2
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 14:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757712413; x=1758317213;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OdcviHaxc0ZxN18Fc55Jn/oo/bxAS8OUZkEK0Pw4+U=;
 b=fYatiih6lfa5wBEhvVgy2n16GmuNV+UdOuu7yZrCZrQGLL4D3jEPQKwBQ2BCGZlPLg
 EY86uYxnO3zKW/FCLCMWv7Z840dJ1svswpxGQSqiKa/92ztQN026nj4DzS2+ZByvZhSu
 ZDiRGa0XDdO+PK6qbyeN8JkmOwpXeFzd+5h63+8qlHADxr9wFEtX6p1fM38HgbAxD0Jh
 HMIy3+r1ohHCYcENa8TcHNZnYGrSsvNk0GlWB9VDMaj5cCjNB6LvA2501ixGrErgdZBr
 dzod7gCNJpNJajIqjn1Ty8jZYqZkPF79kinjxV+Ku6KCC1xEtOlzySFC5mYDqrUfi8ph
 IiUw==
X-Gm-Message-State: AOJu0YxU53vIAtOIVAz3P4ZrOsKTPA83FkuTy4X2ogsQLf6GMQTJytyE
 IdENwomrehrRGjUrNNIQ2pVa95HLWFrN9nVc4htPhsi4y7JWYMU3gfR9wTiaYDOkWvQoQgCfQ2E
 cAiMixOba3ZcjVwHg0ttJ+61uhF8LcXEXXCiRp1bYKhTwmAANL8X7CqBT
X-Gm-Gg: ASbGncvmZyNO/HFgnK8jOHxb4dq61++BhgKjUvULzOluRvBwSypzkksIYp2+FUSqjBD
 L0wC2qkzyTtCCx3TTzqQ9y+vnf1aqE1FB1mPCGaYZC0lL/KfQq56f/NfskPeHY+J5wrCng7fHwf
 rUs7JRE9Nfrds5HZ+spRoaV5MA/Nov/at1ctDYJO7fyFp+qFaRvtDKtUb6en5lZPpcPtKiJOGK1
 /Wg6sgZ/hLgfda/96Wz+hlFQE/eBn/IVvcvPzUdZXCLuLINYyYI0zlaVzOVAD6xGhRRb8KKR3Zv
 0gx3TPiw8asEopijhxI58ehuAWWCSM6o
X-Received: by 2002:a05:620a:4626:b0:823:e519:c80a with SMTP id
 af79cd13be357-823f6648c68mr625099985a.0.1757712413271; 
 Fri, 12 Sep 2025 14:26:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdGUUqRDP/AzFo4/FSHDTilOYPm/as5dpmTtEPnHJU0adDMEIIygitwQd5ipQ1CIYdSIJyXA==
X-Received: by 2002:a05:620a:4626:b0:823:e519:c80a with SMTP id
 af79cd13be357-823f6648c68mr625095585a.0.1757712412631; 
 Fri, 12 Sep 2025 14:26:52 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-825abc11db2sm100961985a.45.2025.09.12.14.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 14:26:51 -0700 (PDT)
Date: Fri, 12 Sep 2025 17:26:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH 02/22] vfio/pci: Do not unparent in instance_finalize()
Message-ID: <aMSQDuVacnSG3MTV@x1.local>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-use-v1-2-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <aMHidDl1tdx-2G4e@x1.local>
 <1a5b7471-1799-44bd-9c1c-c3c07e478bb8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNBJF9E4BYrWEHO@x1.local>
 <4d91c86f-4e3d-4850-8b8c-77ad3c9d5bce@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d91c86f-4e3d-4850-8b8c-77ad3c9d5bce@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 12, 2025 at 11:09:51AM +0900, Akihiko Odaki wrote:
> > > > I think it still makes some sense to theoretically allow object_unparent()
> > > > to happen, at least when it happens before owner's finalize().  IIUC that
> > > > was the intention of the doc, pairing the memory_region_init*() operation.
> > > 
> > > Perhaps so, but this patch is only about the case where object_unparent() is
> > > called in finalize().
> > 
> > You ignored my other comment.  That (using object_new() on MRs) was what I
> > was thinking might be better than a split model you discussed here, so
> > that's also a comment for patch 1 of your series.
> 
> I'm not sure what you mean by the "split model".

I meant after similar change as what this patch proposes, (a) "owner of the
MR lifecycle" (aka, who decides to finalize() the MR) is not the same as
(b) "owner of the memory" (aka, who decides to free() the memory backing
the MR struct), so the ownership model itself is more or less "split".

Now it's very hard to tell who owns the MR, because each owns only part of
it.

IMHO it'll be slightly better to have the instance lifecycle and the memory
allocation of the MR struct be managed by the same object, no matter
automatically by the memory core, or manually by the device (in the case of
the current doc, it went with the latter, even though I agree with you it
looks wrong).

> 
> This change removes object_unparent() in vfio_bars_finalize(). object_new()
> will allow removing even g_free(), but we can do these changes
> incrementally:
> 1. remove object_unparent() in finalize(),
>    which fixes a semantic problem (this patch)
> 2. allow object_new() for MRs and remove g_free() in finalize()
>    as a refactoring.
> 
> So I suggest focusing on object_unparent() in finalize() to keep this patch
> and review concise.

I agree that is the minimal change, but this is a common pattern.  It's not
high risk, so I think we could still discuss it thoroughly.

I further analyzed the risk here, it turns out object_unparent() in
finalize() is still very safe so the current code is actually bug-free if
it all works similarly like the vfio code: The object_property_del_all()
(on top of the owner device) would do prop->release(), and here MR will
kickoff object_finalize_child_property(), which resets mr->parent to NULL.

So the 2nd object_unparent() will already see obj->parent==NULL.

Directly dropping object_unparent() should work, but leads to confusion as
"split ownership model" as I discussed above.

Thanks to all recent discussions, IMHO we have much clearer picture of how
MRs can be used.  I discussed it almostly in the first reply:

https://lore.kernel.org/all/aMHidDl1tdx-2G4e@x1.local/

I suspect we don't really have 2nd user I mentioned, because if so it'll
likely require strict mr refcounting due to address_space_map(), in which
case we should go the "create a temp obj as the owner of MR" idea, that you
used to fix the virgl issue in patch 2 of your other series.

For the current issue, I'd suggest as simple as below (I observed at least
the current VFIO use case only uses MMIO memory regions, so we only need
one such helper):

/*
 * Unlike memory_region_init_io(), @memory_region_alloc_io allocates an IO
 * memory region object and returns.
 *
 * After the function returns, the MemoryRegion object will share the same
 * lifecycle of the owner object.  If owner is not specified, the MR will
 * never be released.
 *
 * The caller doesn't need to either detach or unref/free the MR object.
 * It will be automatically detached and returned when the owner finalize.
 * The caller can cache the MR object pointer, but it's only valid to
 * operate before the owner finalizes.
 */
MemoryRegion *
memory_region_alloc_io(MemoryRegion *mr,
                       Object *owner,
                       const MemoryRegionOps *ops,
                       void *opaque,
                       const char *name,
                       uint64_t size)
{
    MemoryRegion = object_new(TYPE_MEMORY_REGION);
    memory_region_do_init(mr, owner, name, size);
    mr->ops = ops ? ops : &unassigned_mem_ops;
    mr->opaque = opaque;
    mr->terminates = true;
}

Here, IIUC if we can allocate the MR using memory_region_alloc_io() here,
then the ownership of both (a)+(b) above will be done automatically by the
memory core / object core code.  The device impl doesn't need to care about
either removal of subregions, or free of MR struct, anymore.  Then we can
drop not only the object_unparent(), but also g_free(), altogether.

Would that sound like a better approach in general?

Again, I don't think this is anything urgent, so we can take time to think
it through.

Thanks,

-- 
Peter Xu


