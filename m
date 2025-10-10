Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93103CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78nI-0005mW-PC; Fri, 10 Oct 2025 04:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v78nE-0005mK-Ah; Fri, 10 Oct 2025 04:48:04 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v78n7-0002kN-2A; Fri, 10 Oct 2025 04:48:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 94DE388478;
 Fri, 10 Oct 2025 11:47:46 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a89::1:23] (unknown
 [2a02:6bf:8080:a89::1:23])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jlGTSL1FBSw0-arMD9kjX; Fri, 10 Oct 2025 11:47:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760086065;
 bh=x82JJF8LKyDkyEtNoJdfZVOJTzEzDOWxmc/sK9w7GuQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=vlKRdeoRDzJ9+hhMaSPxVGmATLdOknB3ZiiV+0kq7KLsIX0gUmbrWl2Jg+6wnfK/1
 WqWBv00ilB8vrMTLeHV2qwUr5+Ck0irBavT8IKmLIE0SEAt/A+tlwwKXom6/cOg6W2
 cc6NKGaTi3hAAbfPSxLB1dwGf5bXJjAr36U1VS4Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e660bb4d-b682-4378-ad42-78046bf42b41@yandex-team.ru>
Date: Fri, 10 Oct 2025 11:47:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] vhost-user-blk: live-backend local migration
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael@enfabrica.net, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <CAFubqFv8F8swA3EwZfgnVYpHNgs0yZSFgf6wm2DwXgPxSTjs5A@mail.gmail.com>
 <aabfa3db-e434-4dde-b01e-b0195eb4adee@yandex-team.ru>
 <CAFubqFsANpc_v8Dvd4P=Swmei2P_Nt33+0eXn4UdC8-dcJCPfA@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFsANpc_v8Dvd4P=Swmei2P_Nt33+0eXn4UdC8-dcJCPfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10.10.25 02:28, Raphael Norwitz wrote:
> Thanks for the detailed response here, it does clear up the intent.
> 
> I agree it's much better to keep the management layer from having to
> make API calls back and forth to the backend so that the migration
> looks like a reconnect from the backend's perspective. I'm not totally
> clear on the fundamental reason why the management layer would have to
> call out to the backend, as opposed to having the vhost-user code in
> the backend figure out that it's a local migration when the new
> destination QEMU tries to connect and respond accordingly.
> 

Handling this in vhost-user-server without the management layer would
actually mean handling two connections in parallel. This doesn't seem
to fit well into the vhost-user protocol.

However, we already have this support (as we have live update for VMs
with vhost-user-blk) in the disk service by accepting a new connection
on an additional Unix socket servicing the same disk but in readonly
mode until the initial connection terminates. The problem isn't with
the separate socket itself, but with safely switching the disk backend
from one connection to another. We would have to perform this switch
regardless, even if we managed both connections within the context of a
single server or a single Unix socket. The only difference is that this
way, we might avoid communication from the management layer to the disk
service. Instead of saying, "Hey, disk service, we're going to migrate
this QEMU - prepare for an endpoint switch," we'd just proceed with the
migration, and the disk service would detect it when it sees a second
connection to the Unix socket.

But this extra communication isn't the real issue. The real challenge
is that we still have to switch between connections on the backend
side. And we have to account for the possible temporary unavailability
of the disk service (the migration freeze time would just include this
period of unavailability).

With this series, we're saying: "Hold on. We already have everything
working and set up—the backend is ready, the dataplane is out of QEMU,
and the control plane isn't doing anything. And we're migrating to the
same host. Why not just keep everything as is? Just pass the file
descriptors to the new QEMU process and continue execution."

This way, we make the QEMU live-update operation independent of the
disk service's lifecycle, which improves reliability. And we maintain
only one connection instead of two, making the model simpler.

This doesn't even account for the extra time spent reconfiguring the
connection. Setting up mappings isn't free and becomes more costly for
large VMs (with significant RAM), when using hugetlbfs, or when the
system is under memory pressure.


> That said, I haven't followed the work here all that closely. If MST
> or other maintainers have blessed this as the right way I'm ok with
> it.
> 



-- 
Best regards,
Vladimir

