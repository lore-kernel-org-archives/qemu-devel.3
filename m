Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73C6CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 08:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFpvD-0005Ja-52; Mon, 03 Nov 2025 03:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vFpv8-0004zm-TP
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:28:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vFpv1-00075g-HD
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762158481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0TvA/uPk3vEFJyp4WZkt2yirW+qM5sCLKrp5p0enga4=;
 b=Poaz8svPEnYph6ORwsZ2BNQm+VJrmsgki52sKc9zOmq1CClqrgUM28NgKaM8LaMudlzn+T
 dVwlLbr2e/zxZjToQEfbASxvjZQMcaMDeQHp8h+2YNrEqFR/vWMiZtKn6fY1rWWKsqKS23
 At6Msurd+mcEjaRrBbhG8U2Jws67vCM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-KcKH607OMguG93QKpQxYzg-1; Mon, 03 Nov 2025 03:27:59 -0500
X-MC-Unique: KcKH607OMguG93QKpQxYzg-1
X-Mimecast-MFC-AGG-ID: KcKH607OMguG93QKpQxYzg_1762158478
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-475ddd57999so40669285e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 00:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762158478; x=1762763278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TvA/uPk3vEFJyp4WZkt2yirW+qM5sCLKrp5p0enga4=;
 b=tfgf6oP3cgxnh2PXQbLMnTiAABZ1Tvb7jNAW9gGUl4knq/CW3kCpJNRIVETgbSaKsy
 ARRanSNtfnuPEZCjq4YPzJ0f7bfCt0WnB+JOAw1LwhRE+HhGWKh/Gl8Y3NhoQJjt+vT3
 RA7fH1cMoisDgBxvuqwpU7O0lCpAAUrLz6hHkCoNqG7HRnuOZZc4XNR1pMDbf/mELp+g
 FgKrvTxYLn5K5d9ajCnGUHg9gci3dk1gS0wYboPOxVK9DwxEAbf8RUrzf80Ma+Qe1Lql
 a+tvVduTrklYMIE7AMW5ZatGToNMW8zBU0mDNFbWAcdFrmgNbsbgI7twvKUt3yFH5y3f
 OCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762158478; x=1762763278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TvA/uPk3vEFJyp4WZkt2yirW+qM5sCLKrp5p0enga4=;
 b=ldmp01AyDwUeJQgBCQxXlDol2HD6kwjebwnNkfXXb4lFt6o9WEg2DE7u8+Qpj/vJOa
 ljPVLgQSqgeoY/BAmVSr1IMs5UwSbGk5VpFgu+z5glywN9HcLQEjzwvLhx3bG2ijobl4
 UBIj2i0Zp11V+qj4Of880yf0bZsrnLnHgGdmSQs/7v3HGiQXzcewoATJvM0dxVSdWrF0
 knvrto/TgAXx69Gp2MNvKLfgkILqU8D4LTIl0Zmzep6MXmxFZWJiOG8b5IdL4h4Ja8O6
 oNLzXKM1L4C6FkaGXLs/fMtSI7HrpKnK6QTDKgfcOUMKhlbzs6k9sfQSHpL300dMFE6H
 rX2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuXCGUmU7XUZ7e72s0IfSTls4tTG5LkJUlkeNRRPI6tK4S5kyqZTsfrolpCiQfZH5tuQDou/0KBxR2@nongnu.org
X-Gm-Message-State: AOJu0YxPIxWnugPKKr6wNTf9HoINWMF6WoD8rrnGq86tOOlOOSZVawKp
 7QNei4Li0p5/NyUoyBi9VeFWCDtCO0g+jhyc4Rjq07kXUBzT+XmORlGw+rfHWr7STipGFMR+T5P
 7c4inIixwonWk/0PviLhclUFocunRhJ8C6s4Dj/FB/TNKj8MR85f0NclW
X-Gm-Gg: ASbGncvxPmqh/s5hC2IHLkkA4ZjlAi7KSk2UwNP6QeSWnGc8Xd9CP/Uw30o0Hpk8c0H
 Nf38RMd0Wr+0jc4FsplYTR87oUyyIoMIY11QVxeukvkJB7CzeZMDRczvlBtcRsNfkMiPPzGvQox
 bfrLoMWABzU+kTVKFgJq4e0eXKCdrjt5K5YAo3ajjcswfBweVMYCD/GA8pAAYsO6IKMCFj74cd6
 UvIIicuBDKN6oPU4Aj+L84AT975X2xhx9MZC60UAHa38mMKw/ECZO9T40TAnVtBTz4F+UpoNLbQ
 NfbvbAzxLipEBcTE3UfVoR7CrfEr0Q4kksN7xtLiJdutD6OURfozNz07kBvr3OzfuA==
X-Received: by 2002:a05:600c:609b:b0:475:d8ef:64e4 with SMTP id
 5b1f17b1804b1-477308b60f5mr103336675e9.39.1762158478055; 
 Mon, 03 Nov 2025 00:27:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHThjylrSLgTOmkW+tT9OADvb4u9QJUwZYoVCpQN0I6fdBmwFK65t6uNFzNVphVFi9wri5Ohg==
X-Received: by 2002:a05:600c:609b:b0:475:d8ef:64e4 with SMTP id
 5b1f17b1804b1-477308b60f5mr103336315e9.39.1762158477569; 
 Mon, 03 Nov 2025 00:27:57 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47751794620sm9264565e9.6.2025.11.03.00.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 00:27:56 -0800 (PST)
Date: Mon, 3 Nov 2025 09:27:54 +0100
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
Message-ID: <20251103092754.6dda4aa0@fedora>
In-Reply-To: <878qguos4l.fsf@pond.sub.org>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-23-salil.mehta@opnsrc.net>
 <87plawh2sz.fsf@pond.sub.org> <20251009145125.6583a24a@fedora>
 <87wm54nmyt.fsf@pond.sub.org> <20251017165044.76b39f5c@fedora>
 <87v7k96cnz.fsf@pond.sub.org> <20251029110802.2ffa51e4@fedora>
 <878qguos4l.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 29 Oct 2025 12:38:02 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > On Mon, 20 Oct 2025 13:22:08 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >  
> >> Igor Mammedov <imammedo@redhat.com> writes:
> >>   
> >> > On Thu, 09 Oct 2025 16:55:54 +0200
> >> > Markus Armbruster <armbru@redhat.com> wrote:  
> 
> [...]
> 
> >> >> I feel it's best to start the design process with ensvisaged uses.  Can
> >> >> you tell me a bit more about the uses you have in mind?    
> >> >
> >> > We have nic failover 'feature'
> >> >    https://www.qemu.org/docs/master/system/virtio-net-failover.html
> >> > to make it work we do abuse hotplug and that poses problem
> >> > during migration, since:
> >> >   - unplugging primary device releases resources (which might not be
> >> >     possible to claim back in case migration failure)    
> >> 
> >> Serious reliability issue with no work-around.
> >>   
> >> >   - it's similar on destination side, where attempt to hotplug
> >> >     primary might fail die to insufficient resources leaving guest
> >> >     on 'degraded' virtio-net link.    
> >> 
> >> Obvious work-around is failing the migration.  Same as we do when we
> >> can't create devices.
> >>   
> >> > Idea was that instead of hotplug we can power off primary device,
> >> > (it will still exist and keep resources), initiate migration,
> >> > and then on target do the same starting with primary fully realized
> >> > but powered of (and failing migration early if it can't claim resources,
> >> > safely resuming QEMU on source incl. primary link), and then guest
> >> > failover driver on destination would power primary on as part of
> >> > switching to primary link.    
> >> 
> >> I can see how power on / off makes more sense than hot plug / unplug.
> >>   
> >> > Above would require -device/device_add support for specifying device's
> >> > power state as minimum.    
> >> 
> >> The obvious way to control a device's power state with -device /
> >> device_add is a qdev property.  Easy enough.
> >> 
> >> Do we need to control a device's power state after it's created?  If I
> >> understand your use case correctly, the answer is yes.  -device /
> >> device_add can't do that.  
> >
> > Could you elaborate why why -device/device_add can't do that?  
> 
> -device / device_add create, configure, and realize a new device.
> 
> They can't reconfigure an existing device.  In particular, they can't be
> used to control an existing device's power state.

Sorry, I've misread as we can't use both for creating device in powered off state.

Perhaps we should consider a new specialized QMP command to
manipulate runtime power state. (Like it was suggested by Daniel) 

> 
> >> qom-set could, but friends don't let friends use it in production.
> >> 
> >> Any other prior art for controlling device state at run time via QMP?
> >> 
> >> [...]  
> 


