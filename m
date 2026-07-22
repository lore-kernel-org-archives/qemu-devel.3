Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301B1C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmY8W-00051b-TQ; Wed, 22 Jul 2026 10:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wmY8K-0004vk-GF
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 10:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wmY8H-0003z0-EJ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 10:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784731271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bs2AwdoT2OO0gF40NDT+mKXTX8z4Kj7Ar7Hnza+FFU0=;
 b=RqgY84+4QCDsObMEIJIF8rStznR9OvP3ms4hiqhgA720XNXMAQ/sYy1AXbQtLlGYYT/4eB
 70pwyiCRHG825QcQWjnNBR0ganFHx4ndx4hZGqRbBqR3crB+DXuNsObwvFpGfyNWxh6mOw
 tLFI+sCgd0hiok8cRgD3ZoAErOvV9kg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-VwcoZ16aNyiO9nZ1ge7Smw-1; Wed, 22 Jul 2026 10:41:10 -0400
X-MC-Unique: VwcoZ16aNyiO9nZ1ge7Smw-1
X-Mimecast-MFC-AGG-ID: VwcoZ16aNyiO9nZ1ge7Smw_1784731269
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c167e032f03so100924666b.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784731269; x=1785336069; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bs2AwdoT2OO0gF40NDT+mKXTX8z4Kj7Ar7Hnza+FFU0=;
 b=dvn6y4c265UaVf4rljSH6FG2NhBec7GCoBosSAyrZdWIvA3arcII8WAxhd3zmpI7cW
 svC9kduxLw6HOrMpVDCNRI+Y2yyz+2dNOnHzYsK0O1cNjRT0nWuFEvye1LB3Gvczpquq
 lJad1hTjjoG9eeuhiefOlVPL6rqkq/53izeZwLv0IB//6MFzA9V0OJj7hV/KzANnKiAr
 l5BklF9InEMIHHPmzqS1Q5vRqZsn9hK/MphqFcoysJsxOcOqmCTBV1JDsu7ewttYFsHL
 zOfd9H3IUHnLCgDY7g/tevGbGXC+PFeyPCBnQE2PeWPTqhhn21xPvI6flFh0TtJerElo
 1SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784731269; x=1785336069;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bs2AwdoT2OO0gF40NDT+mKXTX8z4Kj7Ar7Hnza+FFU0=;
 b=r5AoSB0w1KVy1zu2CdkHnlI6Iv5e0IvSeZp/8luX+WqlZiAiMwgSOtqMrO9w/a8Jlo
 +hhKTjjOpY03CZR7Mp2Y4cbDpiLOZIWbC00Vz7bL2IfnnlCEtFRSUB8rXZEoVw2FvNqH
 9C8eKSbn+Wth/odTFdtIkFxRBa2aloV1mA1cX4uyrEnCw4FZs359cGGN0zZGlEaAmv4M
 pGIpsnqm0H6rpymnPx+VIlRXgyiEUkmTFswrRKa0UIobLdIDig/BV4J9/ejkuRZq9KFV
 /yxLUzr4WuWI1AZFzF4FiymaV3IpU+0fVaQr9vxMKdh+4eIxjdTvVbZVoDRDp3wG1dJ+
 xw3w==
X-Gm-Message-State: AOJu0YztBsMsu/D5Jl0CgVs1t2SmKrU149XvWjRRmBpwsDCtfz9CVQHz
 xPckCT4nfyGS63JTVl4PhOelDiEXjVbP0nHjtvA7C6FKlhXgcfx9saY7RHMcObauZ974w6GjvMv
 +Y3isgM3ahim2kprMZaMl2yTBxWGErel2QzbK2COXMPdODndYq0Yeis9H
X-Gm-Gg: AR+sD11N3NpPOy1wpLIdY6iHYWAzrn4b91B7IfXWa1u85IfOxPoHdNCa9Ut4Hnm4qLl
 /aJyYFUzHWSIS1eUi5DnJmKjOcM+RJWSAgQQwTkQOGDsv9FPhvmF+kxw8cHgsDzTxxTmJU4QyS1
 5E91cLECl1t7pexiHEB29vVArQXlo18eeR4fE7CPxrtSN9heV6t02zRhm0M1ZWQUaxMbjkRS1Hd
 ObX15cp6LlCMG4vxk1HMmuBHmDNxvdRf20O+tY6SKi7pA0Ovm64/R1caRjNOv/jIEs3regX38r+
 qcd756CtVPwL0tKv+P2vmymxsSRjje/YbMO7mVTolT1zkFSLLKuEcrEOwyHz52qusQk8
X-Received: by 2002:a17:907:a4a:b0:c1c:2fd3:bbd0 with SMTP id
 a640c23a62f3a-c1c2fd3bd55mr181604166b.55.1784731268826; 
 Wed, 22 Jul 2026 07:41:08 -0700 (PDT)
X-Received: by 2002:a17:907:a4a:b0:c1c:2fd3:bbd0 with SMTP id
 a640c23a62f3a-c1c2fd3bd55mr181601966b.55.1784731268263; 
 Wed, 22 Jul 2026 07:41:08 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c902d2sm113575466b.34.2026.07.22.07.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:41:07 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:40:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 07/11] migration: add support for fault thread to load
 pages from disk
Message-ID: <amDWdgKRiSyhm-mf@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-8-aadeshveer07@gmail.com>
 <al5xOKr1-8e-6iML@x1.local>
 <CA++cPvLN_iuchGCD7K45zN3QcjzJ9Z+FktRBMv6ar=Ov271j6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA++cPvLN_iuchGCD7K45zN3QcjzJ9Z+FktRBMv6ar=Ov271j6g@mail.gmail.com>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 22, 2026 at 07:24:29PM +0530, Aadeshveer Singh wrote:
> > NOTE: I believe in all paths you touched, you assumed host psize is always
> > >= guest psize.  Just to mention it's actually possible to have host psize
> > < guest psize. One case is ARM64 using 4K host psize to emulate 64K guest
> > psize.  But that's less of a problem; normally production users rarely use
> > such setup, IIUC, so I think we can put it aside for now (however I believe
> > migration core should work with such setup right now in general). But if
> > you can take that into account it'll be even better.
> >
> 
> I agree with the looping over and loading pages into the buffer. That
> would be more efficient and would get rid of the assumption I had that
> zero ranges in hugepages should always be zero. I will look into how
> to generalize this for differences between host and guest page sizes.
> That depends on how mapped-ram handles those cases. I might have to
> look into that.

For host/guest psize, it's actually easier for vanilla mapped-ram, and your
feature is slightly more complex.

It used to be non-issue because mapped-ram only cares about guest psize.
It does not care about the size of host pages, being huge or not.

IOW, mapped-ram sync mode directly manipuates the HVA pointer, ignoring
what is underneath, when requesting IOs from qemu_get_buffer_at() from the
snapshot images.  Since VM isn't running, destination QEMU doesn't care
about e.g. prepopulation of a huge page with partially filled data when the
first HVA access happens.

Your work will need to consider this though, because in async faults your
feature will depend on userfaultfd, which is host-page aware, and the VM is
running, so we can't populate some host page partially, we can only
populate it always atomically.  This is the same to network-based postcopy.

When I said on normal migration code will work with various guest/host page
setups, I meant more on the iteration logic of when we iterate over RAMs.
For example, on the source / saving side (where your series didn't yet
touch, but you will need to start looking into if you want to enable
multifd + postcopy..), we have a loop structure like this:

  ram_save_iterate() (NOTE, for complete(), it's the same)
    ram_find_and_save_block()
      ram_save_host_page()               <--------------          [1]
        ram_save_target_page()           <--------------          [2]

So someone who read the code first may think that QEMU only supports host
psize >= guest psize, because loop [1] is higher in stack, looping over
smaller guest psizes when they don't match.  But in reality what happens
is, in loop [2] when guest psize is even larger than host psize, what will
happen is (take example of host psize 4K, guest psize 64K):

  - Loop [1], find a host page (e.g. start at address 1M, which is 4K on
    the host), try to migrate the "page" (pointed by pss->page)

  - At [2], migrate the whole guest "page" (pointed by pss->page), which is
    64K (> 4K) return to loop [1].

  - Loop [1], found that after sending the guest page, we've already
    covered the host psize range (4K), fallbck to ram_find_and_save_block()
    to find another dirty host page

  - In ram_find_and_save_block(), it'll find the next dirty (e.g. 1M+64K,
    rather than 1M+4K, because ramblock->bmap is guest psize based).

You can take time to reference to above (also comments in
pss_host_page_prepare()).

Thanks,

-- 
Peter Xu


