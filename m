Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E18CD4F38
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 21:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slxqC-0007OX-PY; Wed, 04 Sep 2024 17:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slxqB-0007Ni-2Y
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:47:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slxq9-0004ZN-D3
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725486420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zdxFPtfkXdTT+5jB4bt9J6WhxhFnZ/CAEY24HgVcO8g=;
 b=d1LoGKwQgKZUJZU+HZ0kEB6p4ibC/zwmyE02IpwrqCgHDGcN5XziGlL5FiE9usdedERk1S
 gbtb0GlBsrHNxSTOIIV24q/q3Lz7wDwpUw0gRIynMsP0nZFjgnQhlqhSLGIUhIUaOidnvh
 3DhJHNCWOOXua5fWynVyH366BJGRj8A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221--r9At1_dNsOEGLEaxJAIrg-1; Wed, 04 Sep 2024 17:46:58 -0400
X-MC-Unique: -r9At1_dNsOEGLEaxJAIrg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a96136f8c0so10409585a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 14:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725486418; x=1726091218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdxFPtfkXdTT+5jB4bt9J6WhxhFnZ/CAEY24HgVcO8g=;
 b=szICDXtYucUvB1ivJQRlsaFTllwoGq9rtBoTXqdj1suddtuBzKqGkxWVsMFaljcj1O
 TmM9psaC/pRKcCVw9UK+494R6eomNpy3TmR5TydJpc1gBg58XP2P+klogIg3ieuTeF6f
 uesbEa5qNMppTdbM6+UEN9mKzg8+wQZrU1Kri0uKW9V0cKgwMBOpduo5fS8tC35iO3Vv
 XMWfPHXpqQ4yze7gkAx3ixJwMGRzXS0dm100fn9zr50MWssdkv4YIQWOvUxNkSd366SX
 2l5+RImuftOmyslD7XFcq2GbrPHqJR+wrZEmKTo0LVM7bE4BF2Ikc+0yfxkoXvrYNCKM
 rvNg==
X-Gm-Message-State: AOJu0Yz7F/jHSqfBbkSXMomxV1QReMGypEdvi8GZ/eIK+hXMzfsvpiZl
 O4wiJBivZ2F+5tW29yGLD+L5/6YzICSaQ81xv4j2fVuErGEG7Ss5+6fU5Ej+c++AIX7qIIZZO5o
 J5VQJqyGLy7U5XcbPIGU4K1B25qVJ0XPEYuARWQH9NT2TJyJINtAq
X-Received: by 2002:a05:620a:2a04:b0:79f:515:e211 with SMTP id
 af79cd13be357-7a81d720ddamr2086283385a.46.1725486418340; 
 Wed, 04 Sep 2024 14:46:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9sH1g+qrx1ZZBSvaxYvsPbFc/vhrejUT9RDrT4bsCBT8Azcgd/T5K6VTdAApbLBBnCguCAw==
X-Received: by 2002:a05:620a:2a04:b0:79f:515:e211 with SMTP id
 af79cd13be357-7a81d720ddamr2086281085a.46.1725486418031; 
 Wed, 04 Sep 2024 14:46:58 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98f00fe8csm21762985a.125.2024.09.04.14.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 14:46:57 -0700 (PDT)
Date: Wed, 4 Sep 2024 17:46:55 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH 3/4] KVM: Dynamic sized kvm memslots array
Message-ID: <ZtjVTz5MDHyEHl9j@x1n>
References: <20240904191635.3045606-1-peterx@redhat.com>
 <20240904191635.3045606-4-peterx@redhat.com>
 <b2cf2a87-848f-4c07-9d05-39b53c638950@redhat.com>
 <ZtjPA9eCN1Ro9HFp@x1n>
 <ff6430ac-f7f4-49f3-a63b-76eae5b2f791@redhat.com>
 <ZtjSbnb-yFOEsq0R@x1n>
 <62e22812-845c-4986-bb3a-fbf833185581@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62e22812-845c-4986-bb3a-fbf833185581@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Sep 04, 2024 at 11:38:28PM +0200, David Hildenbrand wrote:
> On 04.09.24 23:34, Peter Xu wrote:
> > On Wed, Sep 04, 2024 at 11:23:33PM +0200, David Hildenbrand wrote:
> > > 
> > > > > 
> > > > > Then, you can remove the parameter from kvm_slots_grow() completely and just call it
> > > > > kvm_slots_double() and simplify a bit:
> > > > > 
> > > > > static bool kvm_slots_double(KVMMemoryListener *kml)
> > > > > {
> > > > >       unsigned int i, nr_slots_new, cur = kml->nr_slots_allocated;
> > > > >       KVMSlot *slots;
> > > > > 
> > > > >       nr_slots_new = MIN(cur * 2, kvm_state->nr_slots_max);
> > > > >       if (nr_slots_new == kvm_state->nr_slots_max) {
> > > > >           /* We reached the maximum */
> > > > > 	return false;
> > > > >       }
> > > > > 
> > > > >       assert(kml->slots);
> > > > >       slots = g_renew(KVMSlot, kml->slots, nr_slots_new);
> > > > >       /*
> > > > >        * g_renew() doesn't initialize extended buffers, however kvm
> > > > >        * memslots require fields to be zero-initialized. E.g. pointers,
> > > > >        * memory_size field, etc.
> > > > >        */
> > > > >       memset(&slots[cur], 0x0, sizeof(slots[0]) * (nr_slots_new - cur));
> > > > > 
> > > > >       for (i = cur; i < nr_slots_new; i++) {
> > > > >           slots[i].slot = i;
> > > > >       }
> > > > > 
> > > > >       kml->slots = slots;
> > > > >       kml->nr_slots_allocated = nr_slots_new;
> > > > >       trace_kvm_slots_grow(cur, nr_slots_new);
> > > > > 
> > > > >       return true;
> > > > > }
> > > > 
> > > > Personally I still think it cleaner to allow setting whatever size.
> > > 
> > > Why would one need that? If any, at some point we would want to shrink or
> > > rather "compact".
> > > 
> > > > 
> > > > We only have one place growing so far, which is pretty trivial to double
> > > > there, IMO.  I'll wait for a second opinion, or let me know if you have
> > > > strong feelings..
> > > 
> > > I think the simplicity of kvm_slots_double() speaks for itself, but I won't
> > > fight for it.
> > 
> > Using kvm_slots_double() won't be able to share the same code when
> > initialize (to e.g. avoid hard-coded initialize of "slots[i].slot").
> 
> I don't see that as any problem and if you really care you could factor
> exactly that part out in a helper. Anyhow, I learned that I am not good at
> convincing you, so do what you think is best. The code itself should get the
> job done.

It's only about that's the simplest for all of us, and I noticed it only
because I already planned to switch to kvm_slots_double(); that's normally
what I do when I don't strongly insist something. So you succeeded already
making me go there. :)

It's just that as you said it either requires more changes, or I'll need to
duplicate some code which I want to avoid.

> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks a lot for the late night reviews, David.  I'll attach all your tags
when repost, though just to mention there'll be slight touch ups here and
there due to reordering.  Feel free to double check when it's there.

-- 
Peter Xu


