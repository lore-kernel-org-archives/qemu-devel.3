Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB69CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHnz-0003Gl-0P; Wed, 10 Jun 2026 08:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXHnx-0003GT-1e
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXHnv-0000TB-Dp
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781093586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0lGZlvaarvbNZ2qqQ575O9WKAsKard5eOnvv0n8+sM=;
 b=X9oNXCpalIcoWYEKaoPHqRePncpD8+xnkES6UyNOME3CLbmGr8MmYhbWQuVbsT0JxIwcZI
 v4W+mXISHMyl150yczOjL7p7MRt8WmuVimDuZ9LLr9Ty9SXDxrbcUmuFwQo0IQP0sxCxad
 Laf/B4JwzUbKoFj6hVhN3NDAhH67bs8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-czZz2X1INhyNLO3A-lr8ng-1; Wed, 10 Jun 2026 08:13:04 -0400
X-MC-Unique: czZz2X1INhyNLO3A-lr8ng-1
X-Mimecast-MFC-AGG-ID: czZz2X1INhyNLO3A-lr8ng_1781093584
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef6417092so5642468f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 05:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781093583; x=1781698383; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W0lGZlvaarvbNZ2qqQ575O9WKAsKard5eOnvv0n8+sM=;
 b=JFKHt+TZCzjUx6YpZJRYs5UhuG++hQsAutStCyxw/p/Okf9HPxDwNh8Ldar6znuJrH
 PStaUzqgfijfN6Laz2i3gyXecpl5dlwhzSt+9Gcm2q4pKxdOSezhZXSXfJuu8t6rFR3m
 VrXoQg6X0xbKX923RDXd4WcolVkHTkQJlFsMiwDStsJAYWhRHglhKDuQnGphhJW8FdPq
 02WiSnr821vZyCrzN77r6KyFZO6tJF7k/euPu8xMsUEJjzcQI1nG9Ak+bHX00L+jHuXx
 BXxWmCj3lXiHArKXq7FdZ1DPjWZpSXslKXl0vXl/gq+s3j52rBHnYX4f/4dbsDQdtdTS
 R9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781093583; x=1781698383;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W0lGZlvaarvbNZ2qqQ575O9WKAsKard5eOnvv0n8+sM=;
 b=I0Lc5iUv4jtYTasfrqRQ7yV3eoIOftbdYbbA5rRSsm9ZoDclD9MJFo1Chr7Z+Lpdxh
 Bgy2DcYSk4fVHjtQr0IgJ52RVz+dOH9VvUn+7Si83YcMjWVXNQIo1+/loRp/alc/I7+U
 3NpHYeAFtoL+Gf6BQWnes351SYiSLY75Gg71y2vOHWG21pLn7gLJNCWGhd8H2Gk+6NT8
 TGdymegSE4cZN18UcipqS6hVL+L1OHKaZQqj62Wml06q5o4yZXp/QCbRe/am96WW2sdb
 vF8N1Qt1EbuOS/iZ8RYRw5tOZFnPEnL3cvKg0ImabZuPAyqdUdVo3D1FkLrmlBnna2j1
 yicA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WAECsyRBxpN93meCyseqsfErp6AemMPzZ9MdUu6EyBhSbO5O8Fe/erCtJZcJNQMZlGDdlQfvr5hzg@nongnu.org
X-Gm-Message-State: AOJu0YxUzhcsXmdxWmo4MkNvkWGi/+cpvjm6Z9PzC7N1ZSczRx2W79aD
 UOSV/7LO7PDbSeG3WycO+Y9GzUS/IP7RWQIL+NtyfC5curgmIX5/eKpyEjO1LIQ/bzQCc2Hut7p
 mWVEtP3/ioCcknNJZzlF7DYGY7Dwmhzm6N0pmKJbhmEgRwTWwjiyH+u3A
X-Gm-Gg: Acq92OFYqrFezR8MkxuZQ3L+nzQ1OM6yzBvcn9tNFMNFf0OBq2BpCjL6TZvf/YxMUSN
 pxCbdoGXtAL+3UjDt0tf2EIrNIYIU7EJQ5RqWnnMgs2eJM9vABqHcPUDSh9uom2fDEFoJoIq6rW
 jzCtCU6YF77xtyXpbR+N9TslG7JoDxQfIvNu96PwdPvqHK4OZt59Hyxs536adByCWzaZTy+97qC
 jouy2QQDt61SClGifU2RktCZ0Nmb66DJc23CmH+JPAVPC+SPYsbxfZxUv0CiBMXWkX3ue5jpXAl
 GqSohXom5/y3RE/JvGIFJUsJ85oXc+2mlAy7vbKwkEUJ9bdzOvu5Tyvpaly5rsDj0BsNFfAE1eu
 MrjACLt/4xtOW42/nMUXsJuQpcO/mQcHMxQwAls/yvfQhY0ug8hb9sg==
X-Received: by 2002:a5d:598b:0:b0:45e:73b3:8118 with SMTP id
 ffacd0b85a97d-46030512fa1mr38723272f8f.29.1781093583491; 
 Wed, 10 Jun 2026 05:13:03 -0700 (PDT)
X-Received: by 2002:a5d:598b:0:b0:45e:73b3:8118 with SMTP id
 ffacd0b85a97d-46030512fa1mr38723238f8f.29.1781093582997; 
 Wed, 10 Jun 2026 05:13:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm70931029f8f.0.2026.06.10.05.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 05:13:02 -0700 (PDT)
Date: Wed, 10 Jun 2026 08:12:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jugraham@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260610080947-mutt-send-email-mst@kernel.org>
References: <20260608001821.850921-1-gshan@redhat.com>
 <aiaDgG26a6TUrKuM@redhat.com>
 <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
 <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
 <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 10, 2026 at 08:55:10PM +1000, Gavin Shan wrote:
> Hi Pavel,
> 
> On 6/10/26 7:54 PM, Pavel Hrdina wrote:
> > On Mon, Jun 08, 2026 at 09:11:50PM +1000, Gavin Shan wrote:
> > > Hi Daniel,
> > > 
> > > On 6/8/26 6:55 PM, Daniel P. Berrangé wrote:
> > > > On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
> > > > > On the guest where a NVidia's GH100 card is passed from the host, the
> > > > > guest system hang can be observed on attempt to compile 'cuda-samples',
> > > > > as reported by Julia.
> > > > 
> > > > snip
> > > > 
> > > 
> > > Thanks for looking into this.
> > > 
> > > > > By default, the max bounce buffer size is only 4096 bytes, even less
> > > > > than one page when the guest page is 64KB. This tries to fix the issue
> > > > > by inheriting the customized max bounce buffer size of the virtio bus's
> > > > > parent through property 'x-max-bounce-buffer-size' when the customized
> > > > > size is a larger one. With this applied, no guest system hang is seen
> > > > > with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.
> > > > 
> > > > "x-max-bounce-buffer-size"  is an experimental / unsupported property.
> > > > 
> > > > We really shouldn't be expecting users to have to set this in a production
> > > > deployment in order to stop a guest from hanging.  Even if we dropped the
> > > > experimental marker from this property, users would still need to know to
> > > > provide this magic setting, so it would still be broken out of the box.
> > > > 
> > > > How can we  get a solution that "just works" out of the box, which is
> > > > fully supported, not relying on experimental properties ?
> > > > 
> > > 
> > > How do we know that "x-max-bounce-buffer-size" is an experimental or unsupported
> > > property? I guess the properties whose names start with "x-" are all treated as
> > > experimental and unsupported?
> > > 
> > > For this case, the bounce buffer is inevitable as the memory region can't be
> > > directly accessed. The memory region is initialized by memory_region_init_ram_device_ptr()
> > > in hw/vfio/region.c::vfio_region_mmap(). So the question is how the allowed
> > > bounce buffer size can be specified by users, and it's why the existing property
> > > "x-max-bounce-buffer-size" is reused.
> > > 
> > > I even thought of a new property for MachineState (e.g. "limited-bounce-buffer"),
> > > which is set to on by default, following the existing behavior. When it's set to
> > > off by users, the max (allowed) buffer size won't be checked at all. However, I'm
> > > not sure if this makes sense at all.
> > 
> > Hi Gavin,
> > 
> > You did not answer the question that Daniel was asking, how will user
> > know that max-bounce-buffer-size should be used if it's necessary to fix
> > guest system hangs and how will user know what magic value should be set?
> > 
> 
> Sorry that I missed to answer Daniel's questions. For this specific case,
> user need to enlarge the bounce buffer size when seeing the following error
> message. We can add an explicit one in address_space_map() if the existing
> error message isn't obvious.
> 
>   qemu-system-aarch64: virtio: bogus descriptor or out of resources
> 
>   void *address_space_map(AddressSpace *as,
>                         hwaddr addr,
>                         hwaddr *plen,
>                         bool is_write,
>                         MemTxAttrs attrs)
>   {
>       if (!memory_access_is_direct(mr, is_write, attrs)) {
>           if (l == 0) {
>               error_report("Running out of bounce buffer size , enlarge it with max-bounce-buffer-size");
>               *plen = 0;
>               return NULL;
>           }
>       }
> 
> As to the value user should take for max-bounce-buffer-size, it is really case by case
> and decided by user. User needs to try 4096, 8192, ..., 0xFFFFFFFF to figure out the
> smallest value works for them. The worst case is to set 0xFFFFFFFF.
> 
> > Pavel
> > 
> 
> Thanks,
> Gavin


This is not at all reasonable. All kind of fixes are possible but
fundamentally, bounce buffering data path is by itself already a
bad idea.

I have no idea what does bounce buffering device ram accomplish.

In the end, qemu still simply reads the memory from/to the buffer.

My suggestion is to first of all look for ways to mark the
memory as direct.

-- 
MST


