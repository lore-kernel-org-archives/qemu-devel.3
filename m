Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB79CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE36e-0006ER-A5; Wed, 29 Oct 2025 06:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vE36S-000698-8N
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vE36G-0004ba-PU
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761732490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6AlAHYI3Q37iozbNQgfd3TyCrOZzmJ2h6bRZWdszOXs=;
 b=gg66so0z/h1BUCSonWtTyA+/G1tnTIpte9TZvnRJlCczz07PfUv7ShDmj5U6MuhUBht40M
 4aso+XIKvmFcdwaq2M9duyKEWBwmeSdukSxvbzt6AfYZiY62QJVuNce9mKz1SYa5E2gjG6
 8uC2uPhR4wcrYSoAT5r+J8HEP2CAg7M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-KVcQe9QbMkK5V3KiWrLyvA-1; Wed, 29 Oct 2025 06:08:08 -0400
X-MC-Unique: KVcQe9QbMkK5V3KiWrLyvA-1
X-Mimecast-MFC-AGG-ID: KVcQe9QbMkK5V3KiWrLyvA_1761732487
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4710d174c31so63320385e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 03:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761732487; x=1762337287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6AlAHYI3Q37iozbNQgfd3TyCrOZzmJ2h6bRZWdszOXs=;
 b=TM3QITvi5HeqeLrmmmbjrGH89RetQ4zVHbsfAHKEYt1Jp3EF33SuFccN+lhfKju2wf
 wfQ3Xk9jY3eKz9AAQbzZfn6hNyM9F9rovTVniC1zYdVhlFnYgItBG3rXcOT8paqZKQR2
 pQssbWeJ0HRnYRCvKu4jI4DWg/g+qc7OjELLIVOybZVMP3vRG9+WHTzikwDtN5YfVTGt
 m5tRjxLdeuY3Sg1axxI9UsGdoT0QAmjR9RjzGm1lZjzJq+dJZwN50JkkfqIrgdVhLcdI
 dkxFq/wQSpZSNuQDGMMoGEJMIfLdZhb3i/YQABfs/NlNZCgeY9Dbq8iDVBPdignicZM1
 lxjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBcaH0sP7dd48a1Q4CZlQFRR6YJ4P580LdLCkILeGJqYd3LvtPFAon5ytJP/w0AZEL6pNxSLTDJ+g8@nongnu.org
X-Gm-Message-State: AOJu0Yw8wMPSkZqrE4OQwlFfdLHTSH4MmldG9xuqBCfCT4gGFHYwKt3z
 cmcEuoUFTwkLGNpWYL0jxzV0KRteJr73OaVJKYTv1aSaXu9zgv++1NDxG74TmtOoQgSRGfA5UwU
 Jg/qLixEf2lgFqS4F5lqmWHFxcfXQhweCHk4PXar6U5DOQIjpiQHKRG8J
X-Gm-Gg: ASbGnctj2T0hfAUQLzHBioqyueltZCR3iS+Ik4buBVuyvSnN5OPlMnr5mroQpcfN36+
 2F2xi3WDIUyiut3iKkjldzsVfnEbGrBvhggs698TdQ/2O6PtcC8SuAgInRpO76UiNYLEK0b1BCx
 8Vd1p/tKFGgB37DmuOZ7goa0hJVrm9pmqGU2db6NyC6Fs3Umt0BIDVWXELIIj3eSwsNUXJ5Mv9K
 W7sePl4KE5995+v7wGlAGGAhU8Czh/hh1LfnxUS7daeuiyVjuhbOzON58tTofvaLLSlkrcoUn0l
 efNPuuqFiINrmmoZTsbYkDf/ptE3nthzLXIpBwcS0LTIInrxyvEHjmwh72bxJ4yVbg==
X-Received: by 2002:a05:600c:4e90:b0:46f:b42e:ed87 with SMTP id
 5b1f17b1804b1-4771e20e3f5mr20263065e9.40.1761732487182; 
 Wed, 29 Oct 2025 03:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgrnupOSXqOCR3NSmEuuaYcK5eHUvG3WM+ycFSheDoi3gOzbJuD1arFHEXB6b1218sc/o1Ww==
X-Received: by 2002:a05:600c:4e90:b0:46f:b42e:ed87 with SMTP id
 5b1f17b1804b1-4771e20e3f5mr20262585e9.40.1761732486598; 
 Wed, 29 Oct 2025 03:08:06 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771902981esm39177935e9.9.2025.10.29.03.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 03:08:05 -0700 (PDT)
Date: Wed, 29 Oct 2025 11:08:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: salil.mehta@opnsrc.net, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, salil.mehta@huawei.com, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, devel@lists.libvirt.org
Subject: Re: [PATCH RFC V6 22/24] monitor,qdev: Introduce 'device_set' to
 change admin state of existing devices
Message-ID: <20251029110802.2ffa51e4@fedora>
In-Reply-To: <87v7k96cnz.fsf@pond.sub.org>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-23-salil.mehta@opnsrc.net>
 <87plawh2sz.fsf@pond.sub.org> <20251009145125.6583a24a@fedora>
 <87wm54nmyt.fsf@pond.sub.org> <20251017165044.76b39f5c@fedora>
 <87v7k96cnz.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, 20 Oct 2025 13:22:08 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > On Thu, 09 Oct 2025 16:55:54 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >  
> >> Igor Mammedov <imammedo@redhat.com> writes:  
> 
> [...]
> 
> >> > It's likely /me who to blame for asking to invent generic
> >> > device-set QMP command.
> >> > I see another application (beside ARM CPU power-on/off) for it,
> >> > PCI devices to simulate powering on/off them at runtime without
> >> > actually removing device.    
> >> 
> >> I prefer generic commands over collecting ad hoc single-purpose
> >> commands, too.  Getting the design right can be difficult.
> >>   
> >> > wrt command,
> >> > I'd use only 'id' with it to identify target device
> >> > (i.e. no template matching nor QMP path either).
> >> > To enforce rule, what user hasn't named explicitly by providing 'id'
> >> > isn't meant to be accessed/manged by user later on.     
> >> 
> >> Works well, except when we need to access / manage onboard devices.
> >> That's still an unsolved problem.
> >>   
> >> > potentially we can invent specialized power_set/get command as
> >> > an alternative if it makes design easier.
> >> > But then we would be spawning similar commands for other things,
> >> > where as device-set would cover it all. But then I might be
> >> > over-complicating things by suggesting a generic approach.     
> >> 
> >> Unclear.
> >> 
> >> I feel it's best to start the design process with ensvisaged uses.  Can
> >> you tell me a bit more about the uses you have in mind?  
> >
> > We have nic failover 'feature'
> >    https://www.qemu.org/docs/master/system/virtio-net-failover.html
> > to make it work we do abuse hotplug and that poses problem
> > during migration, since:
> >   - unplugging primary device releases resources (which might not be
> >     possible to claim back in case migration failure)  
> 
> Serious reliability issue with no work-around.
> 
> >   - it's similar on destination side, where attempt to hotplug
> >     primary might fail die to insufficient resources leaving guest
> >     on 'degraded' virtio-net link.  
> 
> Obvious work-around is failing the migration.  Same as we do when we
> can't create devices.
> 
> > Idea was that instead of hotplug we can power off primary device,
> > (it will still exist and keep resources), initiate migration,
> > and then on target do the same starting with primary fully realized
> > but powered of (and failing migration early if it can't claim resources,
> > safely resuming QEMU on source incl. primary link), and then guest
> > failover driver on destination would power primary on as part of
> > switching to primary link.  
> 
> I can see how power on / off makes more sense than hot plug / unplug.
> 
> > Above would require -device/device_add support for specifying device's
> > power state as minimum.  
> 
> The obvious way to control a device's power state with -device /
> device_add is a qdev property.  Easy enough.
> 
> Do we need to control a device's power state after it's created?  If I
> understand your use case correctly, the answer is yes.  -device /
> device_add can't do that.

Could you elaborate why why -device/device_add can't do that?


> 
> qom-set could, but friends don't let friends use it in production.
> 
> Any other prior art for controlling device state at run time via QMP?
> 
> [...]
> 


