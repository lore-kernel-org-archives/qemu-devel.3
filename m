Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E688C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 12:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wurH2-0002Xt-Jt; Fri, 14 Aug 2026 08:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wurH1-0002Xi-Gj
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 08:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wurGz-0002P0-6F
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 08:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786711470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tIYjRs7E32ypbJb9uV2XnoOdHfy9d9fgCX8Y89QnFbo=;
 b=MD3lqvqzL2KwbjArwRZHbXG2nRKsJXZzM8VZWEE5o5IhNP/Ha6faCxE9AmDMQj0HQD+/z5
 LoAshLZ2NBd3kMOZrqIDicOvtQEsd62muQpZKpz9G+OYSVXrsjCM3MKUhvHYfCGmdTLn6W
 JIWEY8i7uXUpJYJtHTKoaq+lZB8u6bk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-2AYVKfU-MxOhGQIUFbVgig-1; Fri, 14 Aug 2026 08:44:28 -0400
X-MC-Unique: 2AYVKfU-MxOhGQIUFbVgig-1
X-Mimecast-MFC-AGG-ID: 2AYVKfU-MxOhGQIUFbVgig_1786711468
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0e702df8so13232421cf.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786711468; x=1787316268; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tIYjRs7E32ypbJb9uV2XnoOdHfy9d9fgCX8Y89QnFbo=;
 b=PywPVVdpeeWYLTTU2b7Y+u/jdKJvCnPsBRqg0V5aotuHYjOSMh2IF7Bwrfbr8mNGxy
 xHECQ/1j6sHspPdjAwnF21MXFXPV0Hg1otsoOJE8dUd4n1SVDS8Y7zCF5JNDQy7bGZ2J
 mDexCbo0DKWQXWeO2fMrGcCV+3czD0zduRh2TK7pbw+lDSD6e6GMMA2d9Dlm5vXNHlul
 K+8AFLdVqe3Wp82mzrcHrEfR7prUZeVUY++qCSeBiuykVKnCXLQv9gtKSOG34FdsJGrZ
 lNrzBnNam37sihvh2jXQmCZhTarEJGU8Ds8MqIdDKfMZCuCyDG2RH4sZyVZTPngJKDus
 jkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786711468; x=1787316268;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tIYjRs7E32ypbJb9uV2XnoOdHfy9d9fgCX8Y89QnFbo=;
 b=hgXdhWHKPV+Q8pv9xOIKeMz6YviNf9cPMcwFPpav8Huflj4picVuo4pp2W00GlI2FI
 m/3oOoTr2q3LnlQuNR109W6VfG6r3tz9Jva7Y6er4bgbUaqar5uesXFob7U3UgvlDm/K
 S5NcA3CJwflHxtztaTMeqfYVoEKLNbnXat2M1bzy/IDw8xF3SSpkNEUqmHewk5MOCUVJ
 Wgr0lUP1B9iaTWC+JIX2p9Yn1kQbco1PTRZ+EcfGiRcKPwO38qEc3OVbyCbmwijIXJnS
 7zm0JmC66xDlHHDja61/KKj6Jz+huiXt8Sr0HMxyniJFT3a7uJM+y/xQt3YmjYdYQnZJ
 TnzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2YfV4QvU7kdTamuUaVy82KS9nL8tHxX51yfbZknZig1YCVyTntCxNeTZbfuzDwJRYoBBFuq11k2M4@nongnu.org
X-Gm-Message-State: AOJu0YxrWMIR9Yex0OxbJg1MLdwssQui7At7HbocAT5OHYpWcflFLU15
 z+Ge7n65eXrNAnwMUJBLJMKpCQ1pz/li+A8hbx4F/9jEYpH97Qd0ut8qlGiIyQ9PKpWGE2r17E8
 uDSKNYdngFxzAwRaVRFi1OvNbVBA5BJpy1PYJTFqhZ0v9ok5XkRSHT2MI
X-Gm-Gg: AR+sD12hRE++mydAxjWcGc9OtNRcUbylqpHR9cqMQL+fnBP5YGv7iFOGKRf2lneWI5y
 runJL7Lyd0XDAJap3VGJSBq/CEsVqK+8UKxvslkhf1V3YidKzHhOq1M7N4Zip/mrYYZcJJ7Xdw7
 2Ce5nrMZb9G5zxRXDOnLc/ttRp0lZEnLKtQjW+cAJEU1FoQWtxBQuk9kSm2PUrnwZaMS16VSTo0
 K3fPdRQvwy+MKxgg0qQsCNPb0H1OgNnbTo66wqu/mTBBx1fn6zi0xLClGnuo0Tl8gU0JNg6yHrn
 PETT5X8stBpt8+j20GuVCng3c1cT0lKUdwMAnmVu4xwpHbRPO6Zq/5IWuyFGLHgiBr1d
X-Received: by 2002:a05:620a:2613:b0:930:f7bc:4868 with SMTP id
 af79cd13be357-936d2341ff1mr578036685a.30.1786711468114; 
 Fri, 14 Aug 2026 05:44:28 -0700 (PDT)
X-Received: by 2002:a05:620a:2613:b0:930:f7bc:4868 with SMTP id
 af79cd13be357-936d2341ff1mr578029385a.30.1786711467567; 
 Fri, 14 Aug 2026 05:44:27 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce24564asm265534485a.40.2026.08.14.05.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 05:44:26 -0700 (PDT)
Date: Fri, 14 Aug 2026 08:44:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 jmarcin@redhat.com, david@kernel.org, pbonzini@redhat.com,
 chenyi.qiang@intel.com, farosas@suse.de, aik@amd.com, xiaoyao.li@intel.com
Subject: Re: [PATCH v4 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
Message-ID: <an8Nn5cb52ev4MF2@x1.local>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-4-michael.roth@amd.com>
 <cc83a207-c89f-4ec7-864a-db0115c4f641@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc83a207-c89f-4ec7-864a-db0115c4f641@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 14, 2026 at 07:56:42AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Peter, Michael,
> 
> On 12/8/26 22:16, Michael Roth wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > So that there will be a verbal string returned when kvm not enabled, or
> > kvm not compiled.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Reviewed-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >   accel/kvm/kvm-all.c    | 5 +++++
> >   accel/stubs/kvm-stub.c | 1 +
> >   2 files changed, 6 insertions(+)
> > 
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 120cab1e22..bda2e25a66 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -4758,6 +4758,11 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
> >           .flags = flags,
> >       };
> > +    if (!kvm_enabled()) {
> > +        error_setg(errp, "guest-memfd requires KVM accelerator");
> > +        return -1;
> 
> This doesn't sound right withing a KVM-specific method. We want to
> assert() here.
> 
> The call in ram_block_add() is already protected:
> 
> 2147 static void ram_block_add(RAMBlock *new_block, Error **errp)
> 2148 {
> ...
> 2185     if (new_block->flags & RAM_GUEST_MEMFD) {
> 2188         if (!kvm_enabled()) {
> 2189             error_setg(errp, "cannot set up private guest memory for
> %s: KVM required",
> 2190 object_get_typename(OBJECT(current_machine->cgs)));
> 2191             goto out_free;
> 2192         }
> ...
> 2203         new_block->guest_memfd =
> kvm_create_guest_memfd(new_block->max_length,
> 2204                                                         0, errp);
> 
> The other one is:
> 
> 2823 int ram_block_rebind(Error **errp)
> 2824 {
> ...
> 2829     RAMBLOCK_FOREACH(block) {
> ...
> 2834             block->guest_memfd =
> kvm_create_guest_memfd(block->max_length,
> 2835                                                         0, errp);
> 
> which is only called from KVM:
> 
> 2776 static int kvm_reset_vmfd(MachineState *ms)
> 2777 {
> ...
> 2827     /* rebind memory to new vm fd */
> 2828     ret = ram_block_rebind(&err);
> 
> So maybe what we want is:
> 
> -- >8 --
> diff --git a/system/physmem.c b/system/physmem.c
> index b97016b1303..66ff74541aa 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2824,6 +2824,8 @@ int ram_block_rebind(Error **errp)
>  {
>      RAMBlock *block;
> 
> +    assert(kvm_enabled()); /* Only supported by KVM so far */
> +
>      qemu_mutex_lock_ramlist();
> 
>      RAMBLOCK_FOREACH(block) {
> ---
> 
> Or less aggressive:
> 
> -- >8 --
> diff --git a/system/physmem.c b/system/physmem.c
> index b97016b1303..2988d1dd6c9 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2824,6 +2824,11 @@ int ram_block_rebind(Error **errp)
>  {
>      RAMBlock *block;
> 
> +    if (!kvm_enabled()) {
> +        error_setg(errp, "guest-memfd requires KVM accelerator");
> +        return -1;
> +    }
> +
>      qemu_mutex_lock_ramlist();
> 
>      RAMBLOCK_FOREACH(block) {
> ---
> 
> WDYT?

Fine by me.

IMHO it's normally more of an issue the other way round, if we used an
assert() where we should use error_setg() (hence, user triggerable
assert()s).  Here we expect it to never happen, so either way should not
happen..

If so, we could also assert() in ram_block_rebind(), as it's only used in
kvm_reset_vmfd() only, so I don't see how it can be reached if KVM is not
enabled first..

Thanks,

-- 
Peter Xu


