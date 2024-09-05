Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960F2CD5BCC
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smEu1-00012E-QF; Thu, 05 Sep 2024 12:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smEu0-0000yC-7i
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smEtx-0004KH-Eq
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725552004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wiCB9zTDurBGHCoTmvMGSheHiBLo40nBAUfmse8EmNk=;
 b=KNIobUBYnPUh7I+RLIAVe0bRx1pgHoKa7NR8dTfV6cQ526ufDwH2aKI0ps1ZSNdaMvUvyG
 Au3M3KLZC0hUX5dODvKciv2jOLYdWJo9RCCk5mPrY8e11EqNlm3ENyoJnUpyMeoVpKkLiS
 3gfqFaTeVmXwZEbe/nu+gNbTqdWjHUQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-5PtpHodiNWOkbiIHKLeSVg-1; Thu, 05 Sep 2024 12:00:00 -0400
X-MC-Unique: 5PtpHodiNWOkbiIHKLeSVg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a8084eb116so211970485a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 09:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725552000; x=1726156800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiCB9zTDurBGHCoTmvMGSheHiBLo40nBAUfmse8EmNk=;
 b=ONAhtEMWYEoU53nnYxcPgb1S7x3tvsxxtn4/DQspcbnx+UJftaluBeiqYAMynBQwzr
 AMSPknjQC5eGr61NgNn9Q1vRlZ8Nos8NtsGM4Fk9lt9/A76WCT9jYH0v9t2zNk0WgnmC
 qRN9Js1C5sf53Ke4EEGulZ/X4lUFThEf/JVhj1ih0c39w1UBSZE2nPKVDawn1k0rP275
 qr5hsUfSUWAxE3b/bLBLR6CcOORMXdXW0RyXPueBziQMMwJgBN48cgkT8Ce+PMqYed8/
 slLpgVL+G4cXwpeHCA3jpGsHOjAHPTOFvTLm4e2Q5phTQ121KFu7GnlCod0xdlycAFLO
 r5iA==
X-Gm-Message-State: AOJu0YyXFc8gJBNmoMQZJZ8E5Wri/V+9UHzY1R4rXLvWhpsA+Xf595IB
 4HcwfAkqgnz1P3rulxTDDckxvuHGwZWWPPWJN82pIZLsDqilF70MaT83MgS9HokEy0HJVemCstP
 lJbv9OLf0lQ5tvFg6Tqh+NmAaakVoTMoCXs/roD9w6Rlkgk8PO/FP
X-Received: by 2002:a05:620a:2809:b0:79f:148d:f615 with SMTP id
 af79cd13be357-7a902f6a619mr2016162385a.60.1725551999829; 
 Thu, 05 Sep 2024 08:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzqGsDtxFcli82GDiss+8gGSkq3xRqokX6Bi7u6DYvgT+xz2HPyIVUg4Bxnwl7CyS58hq6Pg==
X-Received: by 2002:a05:620a:2809:b0:79f:148d:f615 with SMTP id
 af79cd13be357-7a902f6a619mr2016158885a.60.1725551999370; 
 Thu, 05 Sep 2024 08:59:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98ef1cb64sm86306385a.25.2024.09.05.08.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 08:59:58 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:59:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH v2 1/4] KVM: Dynamic sized kvm memslots array
Message-ID: <ZtnVfXataavOoQp0@x1n>
References: <20240904223510.3519358-1-peterx@redhat.com>
 <20240904223510.3519358-2-peterx@redhat.com>
 <CAC2qdxCW=ddmK1TLC4Agh4cGnMV60BKNpN_Nrrz-KuPbDfh-ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC2qdxCW=ddmK1TLC4Agh4cGnMV60BKNpN_Nrrz-KuPbDfh-ew@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 05, 2024 at 05:32:46PM +0200, Juraj Marcin wrote:
> Hi Peter,

Hi, Juraj,

[...]

> >  unsigned int kvm_get_max_memslots(void)
> >  {
> >      KVMState *s = KVM_STATE(current_accel());
> > @@ -193,15 +247,20 @@ unsigned int kvm_get_free_memslots(void)
> >  /* Called with KVMMemoryListener.slots_lock held */
> >  static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
> >  {
> > -    KVMState *s = kvm_state;
> >      int i;
> >
> > -    for (i = 0; i < s->nr_slots; i++) {
> > +retry:
> > +    for (i = 0; i < kml->nr_slots_allocated; i++) {
> >          if (kml->slots[i].memory_size == 0) {
> >              return &kml->slots[i];
> >          }
> >      }
> >
> > +    /* If no free slots, try to grow first by doubling */
> > +    if (kvm_slots_double(kml)) {
> > +        goto retry;
> 
> At this point we know all previously allocated slots were used and
> there should be a free slot just after the last used slot (at the
> start of the region zeroed in the grow function). Wouldn't it be
> faster to return it here right away, instead of iterating through
> slots that should still be used again?

Good question.

One trivial concern is we'll then have assumption on how kvm_slots_double()
behaves, e.g., it must not move anything around inside, and we need to know
that it touches nr_slots_allocated so we need to cache it.  The outcome
looks like this:

===8<===
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 020fd16ab8..7429fe87a8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -249,9 +249,9 @@ unsigned int kvm_get_free_memslots(void)
 /* Called with KVMMemoryListener.slots_lock held */
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
+    unsigned int n;
     int i;
 
-retry:
     for (i = 0; i < kml->nr_slots_allocated; i++) {
         if (kml->slots[i].memory_size == 0) {
             return &kml->slots[i];
@@ -259,8 +259,13 @@ retry:
     }
 
     /* If no free slots, try to grow first by doubling */
+    n = kml->nr_slots_allocated;
     if (kvm_slots_double(kml)) {
-        goto retry;
+        /*
+         * If succeed, we must have n used slots, then followed by n free
+         * slots.
+         */
+        return &kml->slots[n];
     }
 
     return NULL;
===8<===

It's still good to get rid of "goto", and faster indeed.  Though I wished
we don't need those assumptions, as cons.

One thing to mention that I expect this is extremely slow path, where I
don't expect to even be reached in major uses of QEMU, and when reached
should be only once or limited few times per VM life cycle.  The re-walks
here shouldn't be a perf concern IMHO, because when it's a concern we'll
hit it much more frequently elsewhere... many other hotter paths around.

So far it looks slightly more readable to me to keep the old way, but I'm
ok either way.  What do you think?

Thanks,

-- 
Peter Xu


