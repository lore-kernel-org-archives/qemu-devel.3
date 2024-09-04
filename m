Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711C0CD4F3E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 21:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sly1N-0007Cn-Hk; Wed, 04 Sep 2024 17:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sly1L-0007Bl-Nw
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sly1K-0007bh-2x
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725487112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NaweopxDiscDlgMKbt6vmgvFjH7BExLXk5oihYDF840=;
 b=h4UeiHht9LIrUaHMpqqmCOSIhGPG6ZEI/eAeVKeyFOGmNizulypCscwg8Dmx7SKXRAX8vS
 4pVQqFCLblKo/mWNpQGo3Dx/5I3U0jIRdjHHvG93K43yUAZoavef6461fACIv5830SYbLW
 5T76dl14ZtHlIbxiGL4BuQysXD2vur8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-uzoanoFFPSCy7nhxTpVOrA-1; Wed, 04 Sep 2024 17:58:31 -0400
X-MC-Unique: uzoanoFFPSCy7nhxTpVOrA-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6d6bb05f2e9so949857b3.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 14:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725487110; x=1726091910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NaweopxDiscDlgMKbt6vmgvFjH7BExLXk5oihYDF840=;
 b=OZgpFgEtnVw9+RtFHXBgrRkap7nWvQKidz0C3sPK6A++/TTM7YUm9iiKUWjOSTrV+A
 8mvSlBi9sKjj50o4DNQ+uTgzuBN/YH2xg87tPRpcCDUk+XIQ1ZnJk56hmdOS1qSj0rkQ
 6Wu4/SqSpfQyp01msckHME+bwWH5arIAYNT8qlVOZV73aTasjvuZ/7Ju/w/xoA/uBwMO
 bE6lq60lB0A/HFJtKASAXPPFpB6QooPq2rD7pX2lZLR5Rcpaf3lRiKICRvCkLBKpI65t
 Vbj25xsr/xGc9MBIz7xSoWIYtvJKmCeud0uPNCmbxVKT1OvUUcQHUl4TGKog4e0qApga
 0TAA==
X-Gm-Message-State: AOJu0YyXNe1yz4Y0CWRsiDlWWsrAoTHazLjDTMMB1u9ElYfXb+DXTIUs
 nINpTwyzYADHp7yg+URGOp2vqWQpWBMeadfNg5LfGi8rfP+f89hW6rDzPPYjy05WFjoZQ+Ag8Rt
 m2xVB3BM8x+Ac/dDvmge+9iOOLKT87g/VUhY4djK7K7kWFQy/J6lr
X-Received: by 2002:a05:690c:f8f:b0:62f:a250:632b with SMTP id
 00721157ae682-6daf484a81emr79801267b3.8.1725487110562; 
 Wed, 04 Sep 2024 14:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZHg+EtOJglIKK/PZ+j2SBsDGHOOdmjEtx7M4b7LuAyxEQabsx9NoOLcn/VoSOUEfjcUI3KA==
X-Received: by 2002:a05:690c:f8f:b0:62f:a250:632b with SMTP id
 00721157ae682-6daf484a81emr79801037b3.8.1725487110202; 
 Wed, 04 Sep 2024 14:58:30 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98f025425sm22609685a.126.2024.09.04.14.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 14:58:29 -0700 (PDT)
Date: Wed, 4 Sep 2024 17:58:27 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH 3/4] KVM: Dynamic sized kvm memslots array
Message-ID: <ZtjYA0loqvXqHE3r@x1n>
References: <20240904191635.3045606-1-peterx@redhat.com>
 <20240904191635.3045606-4-peterx@redhat.com>
 <b2cf2a87-848f-4c07-9d05-39b53c638950@redhat.com>
 <ZtjPA9eCN1Ro9HFp@x1n>
 <ff6430ac-f7f4-49f3-a63b-76eae5b2f791@redhat.com>
 <ZtjSbnb-yFOEsq0R@x1n>
 <62e22812-845c-4986-bb3a-fbf833185581@redhat.com>
 <ZtjVTz5MDHyEHl9j@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtjVTz5MDHyEHl9j@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 04, 2024 at 05:46:55PM -0400, Peter Xu wrote:
> On Wed, Sep 04, 2024 at 11:38:28PM +0200, David Hildenbrand wrote:
> > On 04.09.24 23:34, Peter Xu wrote:
> > > On Wed, Sep 04, 2024 at 11:23:33PM +0200, David Hildenbrand wrote:
> > > > 
> > > > > > 
> > > > > > Then, you can remove the parameter from kvm_slots_grow() completely and just call it
> > > > > > kvm_slots_double() and simplify a bit:
> > > > > > 
> > > > > > static bool kvm_slots_double(KVMMemoryListener *kml)
> > > > > > {
> > > > > >       unsigned int i, nr_slots_new, cur = kml->nr_slots_allocated;
> > > > > >       KVMSlot *slots;
> > > > > > 
> > > > > >       nr_slots_new = MIN(cur * 2, kvm_state->nr_slots_max);
> > > > > >       if (nr_slots_new == kvm_state->nr_slots_max) {
> > > > > >           /* We reached the maximum */
> > > > > > 	return false;
> > > > > >       }
> > > > > > 
> > > > > >       assert(kml->slots);
> > > > > >       slots = g_renew(KVMSlot, kml->slots, nr_slots_new);
> > > > > >       /*
> > > > > >        * g_renew() doesn't initialize extended buffers, however kvm
> > > > > >        * memslots require fields to be zero-initialized. E.g. pointers,
> > > > > >        * memory_size field, etc.
> > > > > >        */
> > > > > >       memset(&slots[cur], 0x0, sizeof(slots[0]) * (nr_slots_new - cur));
> > > > > > 
> > > > > >       for (i = cur; i < nr_slots_new; i++) {
> > > > > >           slots[i].slot = i;
> > > > > >       }
> > > > > > 
> > > > > >       kml->slots = slots;
> > > > > >       kml->nr_slots_allocated = nr_slots_new;
> > > > > >       trace_kvm_slots_grow(cur, nr_slots_new);
> > > > > > 
> > > > > >       return true;
> > > > > > }
> > > > > 
> > > > > Personally I still think it cleaner to allow setting whatever size.
> > > > 
> > > > Why would one need that? If any, at some point we would want to shrink or
> > > > rather "compact".
> > > > 
> > > > > 
> > > > > We only have one place growing so far, which is pretty trivial to double
> > > > > there, IMO.  I'll wait for a second opinion, or let me know if you have
> > > > > strong feelings..
> > > > 
> > > > I think the simplicity of kvm_slots_double() speaks for itself, but I won't
> > > > fight for it.
> > > 
> > > Using kvm_slots_double() won't be able to share the same code when
> > > initialize (to e.g. avoid hard-coded initialize of "slots[i].slot").
> > 
> > I don't see that as any problem and if you really care you could factor
> > exactly that part out in a helper. Anyhow, I learned that I am not good at
> > convincing you, so do what you think is best. The code itself should get the
> > job done.
> 
> It's only about that's the simplest for all of us, and I noticed it only
> because I already planned to switch to kvm_slots_double(); that's normally
> what I do when I don't strongly insist something. So you succeeded already
> making me go there. :)
> 
> It's just that as you said it either requires more changes, or I'll need to
> duplicate some code which I want to avoid.
> 
> > 
> > Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks a lot for the late night reviews, David.  I'll attach all your tags
> when repost, though just to mention there'll be slight touch ups here and
> there due to reordering.  Feel free to double check when it's there.

So I plan to squash this in, assuming this looks better to you:

===8<===
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 78f2d8b80f..020fd16ab8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -216,6 +216,11 @@ static bool kvm_slots_grow(KVMMemoryListener *kml, unsigned int nr_slots_new)
     return true;
 }
 
+static bool kvm_slots_double(KVMMemoryListener *kml)
+{
+    return kvm_slots_grow(kml, kml->nr_slots_allocated * 2);
+}
+
 unsigned int kvm_get_max_memslots(void)
 {
     KVMState *s = KVM_STATE(current_accel());
@@ -254,7 +259,7 @@ retry:
     }
 
     /* If no free slots, try to grow first by doubling */
-    if (kvm_slots_grow(kml, kml->nr_slots_allocated * 2)) {
+    if (kvm_slots_double(kml)) {
         goto retry;
     }
===8<===

Please let me know if otherwise.

-- 
Peter Xu


