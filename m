Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BC5C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 16:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMZ-0004xq-4f; Mon, 29 Apr 2024 11:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s1TMK-0004aI-02
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s1TMH-0005Ky-GE
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714406160;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4AAnRuWD8C2GDGP/Dxv3MHFn8zZkGRM+IwEpQYlOX34=;
 b=Ib794IX9wI3c6wR7bdG+1ffIta7hiUTJd2YJbHjpCTHLJ4pF5txPkPKohUnfPjMrPMra7x
 exMe+eN23rbPBTFtTSBJ2Lf6du3NVfW5zP6hSopZ4Sujw72lSwxbhKjm3CVcCDnDouWzs2
 rZ+gszVPO6HuCe5twl8X6/Apy+4WN4I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-JCuZKY-OPKOmICWwWkKEOQ-1; Mon,
 29 Apr 2024 11:55:55 -0400
X-MC-Unique: JCuZKY-OPKOmICWwWkKEOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E5C21C0C653;
 Mon, 29 Apr 2024 15:55:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83BD51C060D1;
 Mon, 29 Apr 2024 15:55:45 +0000 (UTC)
Date: Mon, 29 Apr 2024 16:55:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>, armbru@redhat.com,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 afaerber@suse.de, ale@rev.ng, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>, bbauman@redhat.com,
 bcain@quicinc.com, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, clg@kaod.org, cw@f00f.org,
 Damien Hedde <dhedde@kalrayinc.com>, eblake@redhat.com,
 edgar.iglesias@gmail.com, eduardo@habkost.net,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, eric.auger@redhat.com,
 felipe@nutanix.com, iggy@theiggy.com, imp@bsdimp.com,
 jan.kiszka@web.de, jgg@nvidia.com, jidong.xiao@gmail.com,
 jim.shu@sifive.com, jjherne@linux.vnet.ibm.com,
 Joao Martins <joao.m.martins@oracle.com>, konrad.wilk@oracle.com,
 Luc Michel <luc@lmichel.fr>, mburton@qti.qualcomm.com,
 mdean@redhat.com, mimu@linux.vnet.ibm.com, paul.walmsley@sifive.com,
 pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 shentey@gmail.com, stefanha@gmail.com, wei.w.wang@intel.com,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 zwu.kernel@gmail.com, eblot@rivosinc.com, max.chou@sifive.com
Subject: Re: QEMU Community Call Agenda Items (April 30th, 2024)
Message-ID: <Zi_C_xHx33Q7T_96@redhat.com>
References: <b534d873-9be3-4a24-800f-603ed25c0803@linaro.org>
 <ebdd9766-04d1-4908-996f-e93c0cd4e6d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebdd9766-04d1-4908-996f-e93c0cd4e6d5@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 29, 2024 at 05:06:36PM +0200, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 29/4/24 00:25, Philippe Mathieu-Daudé wrote:
> > Hi,
> > 
> > The KVM/QEMU community call is at:
> > 
> >    https://meet.jit.si/kvmcallmeeting
> >    @
> >    30/4/2024 14:00 UTC
> > 
> > Are there any agenda items for the sync-up?
> 
> I'd like to discuss two issues:
> 
> 1/ Stability of QOM path
>    ---------------------
> 
>   Currently we have 3 QOM containers:
>    - /machine
>      QOM objects properly parented go there
>    - /machine/unattached
>      Orphan QOM objects. Missing parent is usually easy
>      to figure out, but we need to post patches to fix them.
>    - /machine/peripheral[-anon]
>      Devices created at runtime with CLI -device or QAPI device_add.
>      (-anon is for devices with no explicit bus ID).
>    See "Problem 4: The /machine/unattached/ orphanage" in [1].
> 
>   The /machine and /machine/unattached trees are stable, although
>   by adding parent to orphan objects, their path will change.
> 
>   Objects in /machine/peripheral[-anon] depend on the order of
>   the device_add commands / arguments used.
> 
>   In a dynamically created machine, everything depend on how the
>   device_add commands are processed.
> 
>   How can be expect to easily reference a QOM object by its path?

FYI, for reference libvirt uses a couple of QOM paths

 * "/machine/unattached/device[0]" - path of first vCPU, but
   this is an historical artifact - nowdays we query the
   paths from query-cpus-fast

 * "/machine/peripheral/%s/virtio-backend" where '%s' is the
   ID we give the virtio device, for virtio-blk disks

 * /machine/peripheral/%s/%s.0/legacy[0] where both '%s'  are
   the ID we give the USB defvice, for USB disks

 * /machine/peripheral  when enumerating devices we've
   assigned ID aliases to.

 * /machine to get the rtc-time property value

> 2/ Is it safe to broadcast a QAPI event to all type of device/object?
>    ------------------------------------------------------------------
> 
>    We have QMP commands such @rtc-reset-reinjection or @inject-nmi
>    which expect a single RTC / NMI listener in the machine.
> 
>    When using heterogeneous machines, we might end with multiple RTC
>    or NMI-aware devices. Should these commands be broadcasted to all
>    devices, or should we explicitly pass a list of paths to devices
>    we want to notify. Maybe we want both options.
> 
>    See threads around NMI [2] and RTC [3].
> 
> [1] https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
> [2] https://lore.kernel.org/qemu-devel/f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com/
> [3] https://lore.kernel.org/qemu-devel/20240425133745.464091-1-d-tatianin@yandex-team.ru/
> 
> Regards,
> 
> Phil.
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


