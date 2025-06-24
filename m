Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DB8C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 10:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU14N-0002WZ-Nf; Tue, 24 Jun 2025 06:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uU14L-0002WB-Qq
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uU14F-0001hH-6F
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750761593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5riU88WLaMxnnM9z+cqEQ+gYeQyGZUmiSHwEFT7QdU=;
 b=NRri9lsIJpJUKR+224NCbYMl/afiFG2uCLQJuvUf3TnJspmUMHYKzlX+aJslSP+sbpbtWZ
 zZDgIovOJwGjh7HtvzMVE1naiQqffiMzQGB/W4b6lIUja71i6Q7Sq5YFnhNNvDN5mR4vob
 0zBpaB92Qs4ZR2P80E+Rpo8Vsxg/t8U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-BZ9frBC-M-KIGztuJjq09g-1; Tue, 24 Jun 2025 06:39:52 -0400
X-MC-Unique: BZ9frBC-M-KIGztuJjq09g-1
X-Mimecast-MFC-AGG-ID: BZ9frBC-M-KIGztuJjq09g_1750761591
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a3696a0d3aso2329590f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 03:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750761591; x=1751366391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5riU88WLaMxnnM9z+cqEQ+gYeQyGZUmiSHwEFT7QdU=;
 b=cMNGQ8bvZq/rMD4Y5WSaCZUtLzMK+bVydXEtFt5a2SHAk0zxkuN5LHinuCNWBWRU5/
 J4S2ylY1BaGKTzf5mYhrFgLlKdPs6tIu0KQWo5/2tKiMPU7NIrIIIZ/QmCF+RODoMDcN
 RfuTfD7o3GvBILh9O9j87VnOVI1wvsSrZYWgi1kL1NOidPHTH5a+zu5YpSKWDnAWW97D
 Edf9/zr5TrkChShauajwhyJeBEqLVkL8NPultg7jTmiH39FCa8m5OMsx24NPZXFzhftk
 eOah+qprHcGkssNiuoW2eg7aj6hp/EIfc2lA1r3vsj8Wr+NlnSmK/LmVfdOr9L9SvPuR
 2hAg==
X-Gm-Message-State: AOJu0YxM0ibM3b0lckgQ27St53lExeUdMuPH5AwZnAs0ewTxArbXX9sM
 rUe3yGOyS1KQtj1j2LQj8wbdzC0wKsgspVkryg4WXT9CaQgIjyPai3qzaU3/AjOpK0hQ9PUUoV3
 g/rR1fkCAsv+0Bbnz2nLcs4EfqBkT15lIvYtT9qGVxqmHLyvUSdcXRxnA
X-Gm-Gg: ASbGncu+g8nh29bI0cZcBQfyzuinON3OyYAAkD3NQDPp7A2Lkd9R0MMSu38bApIda5g
 S70hEbvIDifHE/TeylrCaeP+yzvH4S7YiJ6n9O/ebOsW3gj8BUTidGY4QtXXJpdYO+EGVKFRqtp
 ib/IH0083HZXjqIo+Bywtw5iW4RoNUhx+jzGlP/TpsE9fx6semKyOsFWh3lYYmzu7+AsfkiBlF4
 ZHuzwuB1fe/At0PBNLYXdU4CcrvOM65QutTivaaALi+GdJpz+oyev6XktrCrxS5ig2GghkhOo4Q
 L+RS6Pu7Tv4V
X-Received: by 2002:a05:6000:178f:b0:3a3:7987:945f with SMTP id
 ffacd0b85a97d-3a6d12eb327mr12938125f8f.57.1750761590697; 
 Tue, 24 Jun 2025 03:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq9uJE9ZDtN/TOJ5g51Gu433KyrKkFwE27pRI1Dwtga9CAxZnlGZN9b7KQN+/l//dycACwRA==
X-Received: by 2002:a05:6000:178f:b0:3a3:7987:945f with SMTP id
 ffacd0b85a97d-3a6d12eb327mr12938095f8f.57.1750761590257; 
 Tue, 24 Jun 2025 03:39:50 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811568dsm1624124f8f.99.2025.06.24.03.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 03:39:49 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:39:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, mst@redhat.com,
 anisinha@redhat.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH 3/3] mark HPET as unlocked
Message-ID: <20250624123948.3f194f92@fedora>
In-Reply-To: <CAFEAcA-=oPi3PGzES3f5xAtFmTrwFhRCrHLPkJ6Q_tFBkcFcZw@mail.gmail.com>
References: <20250620151418.1166195-1-imammedo@redhat.com>
 <20250620151418.1166195-4-imammedo@redhat.com>
 <CAFEAcA-=oPi3PGzES3f5xAtFmTrwFhRCrHLPkJ6Q_tFBkcFcZw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 20 Jun 2025 18:01:08 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 20 Jun 2025 at 16:15, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > Reading QEMU_CLOCK_VIRTUAL is thread-safe.
> >
> > with CLI
> >  -M q35,hpet=on -cpu host -enable-kvm -smp 240,sockets=4
> > patch makes WS2025 guest, that was able to boot in 4/2min, to boot in 2/1min.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/timer/hpet.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> > index 0fd1337a15..1ebd715529 100644
> > --- a/hw/timer/hpet.c
> > +++ b/hw/timer/hpet.c
> > @@ -681,6 +681,8 @@ static void hpet_init(Object *obj)
> >
> >      /* HPET Area */
> >      memory_region_init_io(&s->iomem, obj, &hpet_ram_ops, s, "hpet", HPET_LEN);
> > +    memory_region_enable_lockless_ro_io(&s->iomem);
> > +    s->iomem.disable_reentrancy_guard = true;
> >      sysbus_init_mmio(sbd, &s->iomem);  
> 
> Is this sequence possible?
While unlikely (what I observe from Linux/Windows guest,
they enable timer 1st and only then start readers),
but yes it still possible.

The more convoluted is the switch into disabled state, where
1:
  reader is already in enabled branch and preempted before
  reading clock:  
          case HPET_COUNTER:
            if (hpet_enabled(s)) {
               <yield>
               cur_tick = hpet_get_ticks(s);
2:
  writer saves s->hpet_counter = <now>

3:
  reader resumes and reads newer 'now'

4:
  on next counter read, reader switches to disabled branch
  and sees timer jump back to older s->hpet_counter value.
  and that shouldn't happen.

for this to work s->hpet_counter needs to catch up
the latest read timer value.

Let me try and see what could be done with it.

> 
> thread A
>    takes the BQL
>    enters hpet_ram_write() for HPET_CFG to set ENABLE
>    executes s->config = new_val (setting the ENABLE bit in it)
>    context switch before it gets to the point of setting
>      s->hpet_offset
> 
> thread B
>    enters hpet_ram_read() for HPET_COUNTER (which it can now
>     do because it doesn't need the BQL)
>    hpet_enabled() returns true (it tests s->config)
>    calls hpet_get_ticks which adds hpet_offset to the clock,
>      but hpet_offset has not been correctly set by A yet
> 
> thanks
> -- PMM
> 


