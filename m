Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EBCCCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHMEr-0006Zb-UF; Fri, 07 Nov 2025 08:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHMEq-0006ZD-Tn
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:10:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHMEn-00056f-Q6
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762521045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1CjtjykW6i1E2tjTK1+Mi7FDtf70ymrmqgxzMk74VEM=;
 b=XV0s6WxNSh42qPShMdnSgQo5IdqAKGSeKZ0z/LwMj7fLCs0DvKkqwOF1zBYQKn/526Jyfc
 a8VFTls00JvVzbIDQ5MyP8AUUXQYdk6e0UfTFFtPP3c0ggm//Bf/Ibbhn0HMT7DeK0a+j4
 Xp9aAlAKpPvcuFSd4JtiBlh+QJtDbBs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-a1ZjkBnVOFuT1Gn0aWqIng-1; Fri,
 07 Nov 2025 08:10:41 -0500
X-MC-Unique: a1ZjkBnVOFuT1Gn0aWqIng-1
X-Mimecast-MFC-AGG-ID: a1ZjkBnVOFuT1Gn0aWqIng_1762521036
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28AD5195605F; Fri,  7 Nov 2025 13:10:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CBF71800361; Fri,  7 Nov 2025 13:10:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6B91421E6A27; Fri, 07 Nov 2025 14:10:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: salil.mehta@opnsrc.net,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 mst@redhat.com,  salil.mehta@huawei.com,  maz@kernel.org,
 jean-philippe@linaro.org,  jonathan.cameron@huawei.com,
 lpieralisi@kernel.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org,  andrew.jones@linux.dev,  david@redhat.com,
 philmd@linaro.org,  eric.auger@redhat.com,  will@kernel.org,
 ardb@kernel.org,  oliver.upton@linux.dev,  pbonzini@redhat.com,
 gshan@redhat.com,  rafael@kernel.org,  borntraeger@linux.ibm.com,
 alex.bennee@linaro.org,  gustavo.romero@linaro.org,  npiggin@gmail.com,
 harshpb@linux.ibm.com,  linux@armlinux.org.uk,
 darren@os.amperecomputing.com,  ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com,  gankulkarni@os.amperecomputing.com,
 karl.heubaum@oracle.com,  miguel.luis@oracle.com,  zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com,  wangyanan55@huawei.com,
 wangzhou1@hisilicon.com,  linuxarm@huawei.com,  jiakernel2@gmail.com,
 maobibo@loongson.cn,  lixianglai@loongson.cn,  shahuang@redhat.com,
 zhao1.liu@intel.com,  devel@lists.libvirt.org
Subject: Re: [PATCH RFC V6 22/24] monitor,qdev: Introduce 'device_set' to
 change admin state of existing devices
In-Reply-To: <20251103092754.6dda4aa0@fedora> (Igor Mammedov's message of
 "Mon, 3 Nov 2025 09:27:54 +0100")
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-23-salil.mehta@opnsrc.net>
 <87plawh2sz.fsf@pond.sub.org> <20251009145125.6583a24a@fedora>
 <87wm54nmyt.fsf@pond.sub.org> <20251017165044.76b39f5c@fedora>
 <87v7k96cnz.fsf@pond.sub.org> <20251029110802.2ffa51e4@fedora>
 <878qguos4l.fsf@pond.sub.org> <20251103092754.6dda4aa0@fedora>
Date: Fri, 07 Nov 2025 14:10:27 +0100
Message-ID: <87a50y9ef0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Igor Mammedov <imammedo@redhat.com> writes:

> On Wed, 29 Oct 2025 12:38:02 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Igor Mammedov <imammedo@redhat.com> writes:
>> 
>> > On Mon, 20 Oct 2025 13:22:08 +0200
>> > Markus Armbruster <armbru@redhat.com> wrote:
>> >  
>> >> Igor Mammedov <imammedo@redhat.com> writes:
>> >>   
>> >> > On Thu, 09 Oct 2025 16:55:54 +0200
>> >> > Markus Armbruster <armbru@redhat.com> wrote:  
>> 
>> [...]
>> 
>> >> >> I feel it's best to start the design process with ensvisaged uses.  Can
>> >> >> you tell me a bit more about the uses you have in mind?    
>> >> >
>> >> > We have nic failover 'feature'
>> >> >    https://www.qemu.org/docs/master/system/virtio-net-failover.html
>> >> > to make it work we do abuse hotplug and that poses problem
>> >> > during migration, since:
>> >> >   - unplugging primary device releases resources (which might not be
>> >> >     possible to claim back in case migration failure)    
>> >> 
>> >> Serious reliability issue with no work-around.
>> >>   
>> >> >   - it's similar on destination side, where attempt to hotplug
>> >> >     primary might fail die to insufficient resources leaving guest
>> >> >     on 'degraded' virtio-net link.    
>> >> 
>> >> Obvious work-around is failing the migration.  Same as we do when we
>> >> can't create devices.
>> >>   
>> >> > Idea was that instead of hotplug we can power off primary device,
>> >> > (it will still exist and keep resources), initiate migration,
>> >> > and then on target do the same starting with primary fully realized
>> >> > but powered of (and failing migration early if it can't claim resources,
>> >> > safely resuming QEMU on source incl. primary link), and then guest
>> >> > failover driver on destination would power primary on as part of
>> >> > switching to primary link.    
>> >> 
>> >> I can see how power on / off makes more sense than hot plug / unplug.
>> >>   
>> >> > Above would require -device/device_add support for specifying device's
>> >> > power state as minimum.    
>> >> 
>> >> The obvious way to control a device's power state with -device /
>> >> device_add is a qdev property.  Easy enough.
>> >> 
>> >> Do we need to control a device's power state after it's created?  If I
>> >> understand your use case correctly, the answer is yes.  -device /
>> >> device_add can't do that.  
>> >
>> > Could you elaborate why why -device/device_add can't do that?  
>> 
>> -device / device_add create, configure, and realize a new device.
>> 
>> They can't reconfigure an existing device.  In particular, they can't be
>> used to control an existing device's power state.
>
> Sorry, I've misread as we can't use both for creating device in powered off state.
>
> Perhaps we should consider a new specialized QMP command to
> manipulate runtime power state. (Like it was suggested by Daniel) 

I prefer few generic commands to many specialized commands whenever
practical.  However, designing a generic interface can be harder,
sometimes much harder, than designing a specialized one.

The generic command Salil proposed has serious flaws, as discussed
upthread.  None of us has promising ideas on how to do a generic command
that isn't flawed by design.  A more specialized one seems to be the
only visible path forward.

>> >> qom-set could, but friends don't let friends use it in production.
>> >> 
>> >> Any other prior art for controlling device state at run time via QMP?
>> >> 
>> >> [...]  


