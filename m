Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E74CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 08:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqpLl-0001XO-Fi; Tue, 26 Aug 2025 04:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uqpLY-0001JR-La
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uqpLN-0001cx-9c
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756198058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EdNBK/G2CP/XYVHgsGugpIGSHBAagqVuwdkPmCuAfPQ=;
 b=XN032csJW+SC/4v2zCzwlIXRSurPWhQ/5WBRtY0cYXsYBCu1MfdvJmXajNIMJxb/Qk/i2D
 nJQojOMmWrPiaVCp2BOrgqtoxiufe20yOgL7CF9+zX1c1+mcIJSkUpPMfJi44mbJ074QKm
 KiuxN1AJkM8Wr7++xpwwY5e2rAHPSOo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-Y_6L6MX6ME-3kM5wMdwaiQ-1; Tue, 26 Aug 2025 04:47:37 -0400
X-MC-Unique: Y_6L6MX6ME-3kM5wMdwaiQ-1
X-Mimecast-MFC-AGG-ID: Y_6L6MX6ME-3kM5wMdwaiQ_1756198056
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45a1b0cc989so37328205e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 01:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756198056; x=1756802856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EdNBK/G2CP/XYVHgsGugpIGSHBAagqVuwdkPmCuAfPQ=;
 b=cQ1IbhqZfO5B95e+/gQKHDiCQUABFUi3RZRBbgf5ierYxfP+yabTYlsglJoIBmhF+s
 TTfaM+S8DrOaQ30rCebOywG3efYGPz2hMp/LO2ikT28vZIWSwHvOYUGXTnkGPcJG5s7Q
 iE7EQbdStCWx2KE1PrnHLiHkrOeVzIAPGaDC91XOh3SwZ0ZVXt7hmxJENahOoxw/UAuz
 IStIk5Ue/ZZAoZy1rT1469MbF8JOMJVKDFNNrEpiJm2pgzlbQq6/AK2pzNxJJNHM4+3d
 bVGoEh7a/IUG5EJFXW4kEk5vEv1XrGVbi5JbVixsqol+2uV5XbjPAdFPbTDlf8maPGlf
 7cEw==
X-Gm-Message-State: AOJu0YytiEhguLA3/KfvimZZK42L1WQDFJqy6SUxoyqjlTG7vdOnKPkc
 KebIBIyvvyZSV+CAe5qo2hFKK4euviUmS9Z6Bl11Vj0v8R/FKRnyDJ6J7MQ62kM1hEg2RKNzfOJ
 vLLjc2djm0XvZRP1Vf6q3Mt5rxpTbeJS5DqoWOM61MlYqHPKPD20jneq4
X-Gm-Gg: ASbGncuhExEvK/Q2euwlNrbYcCYQt7KuYVwMdWOEw7S70r+1QrAN7MI+zqHrNw8R6EC
 3GoY9xpoLic46Pq09a5A1noEEcbqqWjEf3Lq5V0MI4ztXRX3uaSqByjMzv1rpLVtK6enTsS8Slr
 E2DNUms9hkJsuRDGMcp5w+oVQLULWgWsRbOE49Iy6+mxup1Lg4SB8pU5/iNnakJuJwCzmT9zHi6
 LzVyty319g/R4NcKKD+yRA5nZ0zl/h2OijZf5PYkno//biTSFve5UJWn7ksdCP0860ogk0LRf0l
 I0Kasd89CEi44pNBOtvx/3wrypmcVQ==
X-Received: by 2002:a05:600c:458a:b0:459:da76:d7aa with SMTP id
 5b1f17b1804b1-45b517dc897mr142437895e9.25.1756198055872; 
 Tue, 26 Aug 2025 01:47:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVVmrnYcmC7VxaHNcL2r77LEs9HfW4js8Gz73X0F0e1YEXP0YHi7ixvt+oQRxtNLEoXqb7Fw==
X-Received: by 2002:a05:600c:458a:b0:459:da76:d7aa with SMTP id
 5b1f17b1804b1-45b517dc897mr142437595e9.25.1756198055386; 
 Tue, 26 Aug 2025 01:47:35 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c86a8ccd1bsm10740609f8f.27.2025.08.26.01.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 01:47:33 -0700 (PDT)
Date: Tue, 26 Aug 2025 10:47:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com,
 mst@redhat.com, mtosatti@redhat.com, richard.henderson@linaro.org,
 riku.voipio@iki.fi, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, david@redhat.com, jjherne@linux.ibm.com,
 shorne@gmail.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, peter.maydell@linaro.org,
 agraf@csgraf.de, mads@ynddal.dk, mrolnik@gmail.com, deller@gmx.de,
 dirty@apple.com, rbolshakov@ddn.com, phil@philjordan.eu,
 reinoud@netbsd.org, sunilmut@microsoft.com, gaosong@loongson.cn,
 laurent@vivier.eu, edgar.iglesias@gmail.com, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, chenhuacai@kernel.org,
 npiggin@gmail.com, rathc@linux.ibm.com, harshpb@linux.ibm.com,
 yoshinori.sato@nifty.com, iii@linux.ibm.com, mark.cave-ayland@ilande.co.uk,
 atar4qemu@gmail.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
Message-ID: <20250826104731.1440e3ed@fedora>
In-Reply-To: <aK1mHGan+n9NSAOk@intel.com>
References: <20250814160600.2327672-7-imammedo@redhat.com>
 <20250821155603.2422553-1-imammedo@redhat.com>
 <aKyBFlCtnxnP9kt/@intel.com> <20250825171912.1bc7b841@fedora>
 <aK1mHGan+n9NSAOk@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 26 Aug 2025 15:45:32 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> On Mon, Aug 25, 2025 at 05:19:12PM +0200, Igor Mammedov wrote:
> > Date: Mon, 25 Aug 2025 17:19:12 +0200
> > From: Igor Mammedov <imammedo@redhat.com>
> > Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
> >  helpers and use them tree wide
> > X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
> > 
> > On Mon, 25 Aug 2025 23:28:22 +0800
> > Zhao Liu <zhao1.liu@intel.com> wrote:
> >   
> > > Hi Igor,
> > >    
> > > > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > > > index 5eaf41a566..1dee9d4c76 100644
> > > > --- a/include/hw/core/cpu.h
> > > > +++ b/include/hw/core/cpu.h
> > > > @@ -942,6 +942,31 @@ CPUState *cpu_by_arch_id(int64_t id);
> > > >  
> > > >  void cpu_interrupt(CPUState *cpu, int mask);
> > > >  
> > > > +/**
> > > > + * cpu_test_interrupt:
> > > > + * @cpu: The CPU to check interrupt(s) on.
> > > > + * @mask: The interrupts to check.
> > > > + *
> > > > + * Checks if any of interrupts in @mask are pending on @cpu.
> > > > + */
> > > > +static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
> > > > +{
> > > > +    return qatomic_load_acquire(&cpu->interrupt_request) & mask;
> > > > +}
> > > > +
> > > > +/**
> > > > + * cpu_set_interrupt:
> > > > + * @cpu: The CPU to set pending interrupt(s) on.
> > > > + * @mask: The interrupts to set.
> > > > + *
> > > > + * Sets interrupts in @mask as pending on @cpu.
> > > > + */
> > > > +static inline void cpu_set_interrupt(CPUState *cpu, int mask)
> > > > +{
> > > > +    qatomic_store_release(&cpu->interrupt_request,
> > > > +        cpu->interrupt_request | mask);    
> > > 
> > > It seems the read access of cpu->interrupt_request is not atomic, should
> > > we also protect it by qatomic_read(cpu->interrupt_request)? like
> > > 
> > > qatomic_store_release(&cpu->interrupt_request,
> > >                       qatomic_read(cpu->interrupt_request) | mask)  
> > 
> > it's not necessary according to doc:
> > 
> >   - ``qatomic_store_release()``, which guarantees the STORE to appear to           
> >   happen, ...,                    
> >   after all the LOAD or STORE operations specified before.
> >   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
> > 
> > that includes 'cpu->interrupt_request | mask' part  
> 
> Yes, thanks for your explaination and patience.
> 
> > > 
> > > or futher,
> > > 
> > > qatomic_fetch_or(&cpu->interrupt_request, mask)  
> > that would work as well  but it also could be more expensive than
> > qatomic_store_release()  
> 
> Behind this helper, I mainly considerred the case of multiple writers:
> 
>    thread 0      .        thread 1
>                  .
> load:  x         .
> OR:    x | a     .
>                  .
>                  .      load:  x
>                  .      OR:    x | b
>                  .      store: x | b
>                  .
> store: x | a     .      (x | b is missed)
> 
> In the above case, "load" means the direct access:
> cpu->interrupt_request w/o protection, and "store" is done by
> qatomic_store_release.
> 
> The memory order is guaranteed, but the operation result of thread 1
> seems lost. Only BQL or other mutex could avoid such case.
> 
> qatomic_store_release is already a great step to avoid issues outside
> BQL, so I'm not sure if it's worth going further to ensure atomicity,
> especifically for multiple writers (my initial understanding is that
> iothread or callback may have multiple writers, but I'm also a bit
> unsure.). The overhead is also indeed an issue.

it looks like we are always holding BQL when setting interrupt.

However currently we also have places that check interrupts
without BQL but without using any atomics. This patch aims to ensure
that proper barriers are in place when checking for interrupts
and introduces release/acquire pair helpers for cpu->interrupt_request,
to ensure it's don consistently.

While overhead might be issue, it's better to have correcteness 1st.
(that's why blanket tree wide change to make sure we don't miss places that
set/test interrupts).

Then if performance issues were found somewhere, as was suggested
in previous reviews, we may opencode that place without barriers
with a mandatory comment/justification why it's okey doing so.
(well, at least that's the plan)

> 
> Thanks,
> Zhao
> 


