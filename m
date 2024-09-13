Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AA5FA374A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 12:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp5PK-0007LP-9I; Fri, 13 Sep 2024 08:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sp5PI-0007KQ-9G
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 08:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sp5PG-000494-BF
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 08:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726230487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOsEOZ442fZTnpwmIAalviKZpEy09FAoSuiqvRfcTP8=;
 b=RxqHzYTwx+q+NvSjTPCbK5tUJH5MV865oH1OoGpgmqaI9CzZTtEMueChrWVgwN+T+YDvTc
 lU4loqohcZ0yCjYCsK/NFDQqqEUAP6VfTs9rf65syeediged4O8Sa7y/QKNyCkvvm88XYd
 3L/r6UdD8kK5/0Z7uJmdAek+jGDHvJU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391--sFnD1ZeOsGKfjeDp36syg-1; Fri, 13 Sep 2024 08:28:06 -0400
X-MC-Unique: -sFnD1ZeOsGKfjeDp36syg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42caca7215dso13442615e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 05:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726230485; x=1726835285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOsEOZ442fZTnpwmIAalviKZpEy09FAoSuiqvRfcTP8=;
 b=CWTqM9b7TTu/tQ0XzeBpVQq1GiJbi5ndu/scVCw0a+8oAp4Y2Z3OYCjGn4gFPNKJk6
 XikrILP4laT+B4xtVEm/J8ijnVzRZH/Qq6yfg5hrJrD3HLAZPWYRopQ+wMg0iY4hxEyR
 cXus9xtAk+ffiu1lETSwOe6NFZaPSwrf3Fl6X+m7e6sN3/q6HJ4XSwPFK715++VKpV+v
 ZrmujSJPjmZY7staiZf62baAIydRRhsNm3fOq9XaW7perYb8z/UlSw3W+iS+V7VAktpz
 0nyEkrbSdbXvntv5SBJ/AYXDKnpJYZO7ErsLTQ1ZSFiEKBHXopXYrdwv1/X+MYMe3lSk
 8bUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW55Un53Il/sXnu1FhJT0IWLqpqL76T0kAR2PcLy1plmpuH+Qwc25pQ+ZhT2kK0h3sa2nC/DZ23JBSb@nongnu.org
X-Gm-Message-State: AOJu0Yxm9qCBpQ0FbUV+YAF+wTf//ryX+jYfYKyYK5zIpXEh90rqKqx7
 On9Kp9ISI0KBzwQwcKieEjwSMDN7JpBm09ABogUjgqY8KNudwCCwp4AGatEVpPOQ0F77aH+nsdK
 QxzWV2pA1pMjbi3rNYwayiGscQlA+oF9n5DEoD9fTnPRwemPcOAif
X-Received: by 2002:a05:600c:198b:b0:426:593c:9361 with SMTP id
 5b1f17b1804b1-42cdb5684damr49732075e9.26.1726230485131; 
 Fri, 13 Sep 2024 05:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc4izhNNN/2PpM5puG50s26suMsJhcsCLKLFAgHCzd5V21SwKxQbv6VrgnOTQt5V2FINMK/A==
X-Received: by 2002:a05:600c:198b:b0:426:593c:9361 with SMTP id
 5b1f17b1804b1-42cdb5684damr49731645e9.26.1726230484047; 
 Fri, 13 Sep 2024 05:28:04 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b05d6fcsm23251065e9.15.2024.09.13.05.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 05:28:03 -0700 (PDT)
Date: Fri, 13 Sep 2024 14:28:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240913142802.08571a15@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240913111300.00007a3c@Huawei.com>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
 <20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
 <20240825052923.715f88bc@sal.lan>
 <20240911152132.65a7a219@imammedo.users.ipa.redhat.com>
 <20240911163436.00004738@Huawei.com>
 <20240912144233.675d6b63@imammedo.users.ipa.redhat.com>
 <20240913072025.76a329b0@foz.lan>
 <20240913111300.00007a3c@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 13 Sep 2024 11:13:00 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 13 Sep 2024 07:20:25 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Thu, 12 Sep 2024 14:42:33 +0200
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Wed, 11 Sep 2024 16:34:36 +0100
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > >     
> > > > On Wed, 11 Sep 2024 15:21:32 +0200
> > > > Igor Mammedov <imammedo@redhat.com> wrote:
> > > >     
> > > > > On Sun, 25 Aug 2024 05:29:23 +0200
> > > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > > >       
> > > > > > Em Mon, 19 Aug 2024 14:51:36 +0200
> > > > > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > > > > >         
> > > > > > > > +        read_ack = 1;
> > > > > > > > +        cpu_physical_memory_write(read_ack_start_addr,
> > > > > > > > +                                  &read_ack, (uint64_t));            
> > > > > > > we don't do this for SEV so, why are you setting it to 1 here?        
> > 
> > The diffstat doesn't really help here. The full code is:
> > 
> >     /* zero means OSPM does not acknowledge the error */
> >     if (!read_ack) {
> >         error_setg(errp,
> >                    "Last CPER record was not acknowledged yet");
> >         read_ack = 1;
> >         cpu_physical_memory_write(read_ack_start_addr,
> >                                   &read_ack, sizeof(read_ack));
> >         return;
> >     }
> >   
> > > > > what you are doing here by setting read_ack = 1,
> > > > > is making ack on behalf of OSPM when OSPM haven't handled existing error yet.
> > > > > 
> > > > > Essentially making HW/FW do the job of OSPM. That looks wrong to me.
> > > > > From HW/FW side read_ack register should be thought as read-only.      
> > > > 
> > > > It's not read-only because HW/FW has to clear it so that HW/FW can detect
> > > > when the OSPM next writes it.    
> > > 
> > > By readonly, I've meant that hw shall not do above mentioned write
> > > (bad phrasing on my side).    
> > 
> > The above code is actually an error handling condition: if for some
> > reason errors are triggered too fast, there's a bug on QEMU or there is
> > a bug at the OSPM, an error message is raised and the logic resets the 
> > record to a sane state. So, on a next error, OSPM will get it.
> > 
> > As described at https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html?highlight=asynchronous#generic-hardware-error-source:
> > 
> >    "Some platforms may describe multiple Generic Hardware Error Source
> >     structures with different notification types, as defined in 
> >     Table 18.10. For example, a platform may describe one error source
> >     for the handling of synchronous errors (e.g. MCE or SEA), and a 
> >     second source for handling asynchronous errors (e.g. SCI or
> >     External Interrupt)."
> > 
> > Basically, the error logic there seems to fit for the asynchronous
> > case, detecting if another error happened before OSPM handles the
> > first one.  
> 
> Agreed - the error logic to act as backpressure for the tool injecting
> the error makes sense - it's just hardware acknowledging to paper
> over slow software that is an issue.

on top of that, read_ack is serving as sync primitive
If one disregards it and starts overwriting error block regardless of
ack value, One will be inducing race condition, where OSPM might be
accessing error_block while HW is in process of overwriting it.

> 
> > 
> > IMO, there are a couple of alternatives to handle such case:
> > 
> > 1. Keep the code as-is: if this ever happens, an error message will
> >    be issued. If SEA/MCE gets implemented synchronously on HW/FW/OSPM,
> >    the above code will never be called;
> > 2. Change the logic to do that only for asynchronous sources
> >    (currently, only if source ID is QMP);
> > 3. Add a special QMP message to reset the notification ack. Probably
> >    would use Notification type as an input parameter;
> > 4. Have a much more complex code to implement asynchronous notifications,
> >    with a queue to receive HEST errors and a separate thread to deliver
> >    errors to OSPM asynchronously. If we go this way, QMP would be
> >    returning the number of error messages queued, allowing error injection
> >    code to know if OSPM has troubles delivering errors;  
> 
> Is this not better done in the injection code outside of qemu?
> So detect the error in that and if it happens back off and try again
> later?  Basically EBUSY done in an inelegant way.
> 
> > 5. Just return an error code without doing any resets. To me, this is 
> >    the worse scenario.
> > 
> > I don't like (5), as if something bad happens, there's nothing to be
> > done.  
> 
> If it happens on a real system nothing is done either. So I'm not sure
> we need to handle that.  Or maybe real hardware reinjects the interrupt
> if the OSPM hasn't done anything about it for a while.
> 
> > 
> > For QMP error injection (4) seems is overkill. It may be needed in the
> > future if we end implementing a logic where host OS informs guest about
> > hardware problems, and such errors use asynchronous notifications.
> > 
> > I would also avoid implementing (3) at least for now, as reporting
> > such error via QMP seems enough for the QMP usecase.
> > 
> > So, if ok for you, I'll change the code to (2).  
> 
> Whilst I don't feel strongly about it, I think 5 is unfortunately the
> correct option if we aren't going to queue errors in qemu (so make it
> an injection tool problem).

+1 to option (5)

> > 
> >   
> > > > Agreed this write to 1 looks wrong, but the one a few lines further down (to zero
> > > > it) is correct.    
> > > 
> > > yep, hw should clear register.
> > > It would be better to so on OSPM ACK, but alas we can't intercept that,
> > > so the next option would be to do that at the time when we add a new error block
> > >     
> > > > 
> > > > My bug a long time back I think.
> > > > 
> > > > Jonathan
> > > >     
> > > > >       
> > > > > > 
> > > > > > IMO, this is needed, independently of the notification mechanism.
> > > > > > 
> > > > > > Regards,
> > > > > > Mauro
> > > > > >         
> > > > > 
> > > > >       
> > > >     
> > >     
> > 
> > 
> > 
> > Thanks,
> > Mauro  
> 


