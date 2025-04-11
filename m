Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA09C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 11:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Cng-0006KC-3e; Fri, 11 Apr 2025 07:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u3CnX-0006JU-Hd
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u3CnU-0000yO-Td
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744371827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIPJ988moGNhtzk2RTCssFrBjRWK+YD8LnZ8UpVzBeU=;
 b=bTBYyZ7iZ9sHV90OEjIMbtzELzlrBQL5rroSSi1UeoCuDa6wxbDxrZxTtuax+QUhJ6BLL9
 JmXVO7Oo9E2mYXeSRzBqTdZbNrFCNusiFK3IQztAwHPWgdvy++OIT3fJXTU+MpxVx0D9z2
 S0RCgNTX/ZZZVb6pm/t8P678D6BCGUY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-6g_xspm2MSKyAP7ko2yfew-1; Fri,
 11 Apr 2025 07:43:43 -0400
X-MC-Unique: 6g_xspm2MSKyAP7ko2yfew-1
X-Mimecast-MFC-AGG-ID: 6g_xspm2MSKyAP7ko2yfew_1744371822
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B8B919560B3; Fri, 11 Apr 2025 11:43:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A564619560AD; Fri, 11 Apr 2025 11:43:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1801421E6773; Fri, 11 Apr 2025 13:43:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>,  Steve Sistare
 <steven.sistare@oracle.com>,  qemu-devel@nongnu.org,  John Snow
 <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,  Laurent
 Vivier <lvivier@redhat.com>,  devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>
Subject: Re: Management applications and CPU feature flags
In-Reply-To: <Z_jyVQMfRbWaM66y@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 11 Apr 2025 11:43:33 +0100")
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org> <Z_YolW1Nw6Q_tsz6@angien.pipo.sk>
 <Z_jq5drO_25w0bC6@redhat.com> <87lds77zgx.fsf_-_@pond.sub.org>
 <Z_jyVQMfRbWaM66y@redhat.com>
Date: Fri, 11 Apr 2025 13:43:39 +0200
Message-ID: <8734ee9b4k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Apr 11, 2025 at 12:40:46PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Wed, Apr 09, 2025 at 09:58:13AM +0200, Peter Krempa via Devel wrote:
>> >> On Wed, Apr 09, 2025 at 09:39:02 +0200, Markus Armbruster via Devel w=
rote:
>> >> > Hi Steve, I apologize for the slow response.
>> >> >=20
>> >> > Steve Sistare <steven.sistare@oracle.com> writes:
>> >> >=20
>> >> > > Using qom-list and qom-get to get all the nodes and property valu=
es in a
>> >> > > QOM tree can take multiple seconds because it requires 1000's of =
individual
>> >> > > QOM requests.  Some managers fetch the entire tree or a large sub=
set
>> >> > > of it when starting a new VM, and this cost is a substantial frac=
tion of
>> >> > > start up time.
>> >> >=20
>> >> > "Some managers"... could you name one?
>> >>=20
>> >> libvirt is at ~500 qom-get calls during an average startup ...
>> >>=20
>> >> > > To reduce this cost, consider QAPI calls that fetch more informat=
ion in
>> >> > > each call:
>> >> > >   * qom-list-get: given a path, return a list of properties and v=
alues.
>> >> > >   * qom-list-getv: given a list of paths, return a list of proper=
ties and
>> >> > >     values for each path.
>> >> > >   * qom-tree-get: given a path, return all descendant nodes roote=
d at that
>> >> > >     path, with properties and values for each.
>> >> >=20
>> >> > Libvirt developers, would you be interested in any of these?
>> >>=20
>> >> YES!!!
>> >
>> > Not neccessarily, see below... !!!!=20
>> >
>> >>=20
>> >> The getter with value could SO MUCH optimize the startup sequence of a
>> >> VM where libvirt needs to probe CPU flags:
>> >>=20
>> >> (note the 'id' field in libvirt's monitor is sequential)
>> >>=20
>> >> buf=3D{"execute":"qom-get","arguments":{"path":"/machine/unattached/d=
evice[0]","property":"realized"},"id":"libvirt-8"}
>> >> buf=3D{"execute":"qom-get","arguments":{"path":"/machine/unattached/d=
evice[0]","property":"hotplugged"},"id":"libvirt-9"}
>> >> buf=3D{"execute":"qom-get","arguments":{"path":"/machine/unattached/d=
evice[0]","property":"hotpluggable"},"id":"libvirt-10"}
>> >>=20
>> >> [...]
>> >>=20
>> >> buf=3D{"execute":"qom-get","arguments":{"path":"/machine/unattached/d=
evice[0]","property":"hv-apicv"},"id":"libvirt-470"}
>> >> buf=3D{"execute":"qom-get","arguments":{"path":"/machine/unattached/d=
evice[0]","property":"xd"},"id":"libvirt-471"}
>> >> buf=3D{"execute":"qom-get","arguments":{"path":"/machine/unattached/d=
evice[0]","property":"sse4_1"},"id":"libvirt-472"}
>> >> buf=3D{"execute":"qom-get","arguments":{"path":"/machine/unattached/d=
evice[0]","property":"unavailable-features"},"id":"libvirt-473"}
>> >>=20
>> >> First and last line's timestamps:
>> >>=20
>> >> 2025-04-08 14:44:28.882+0000: 1481190: info : qemuMonitorIOWrite:340 =
: QEMU_MONITOR_IO_WRITE: mon=3D0x7f4678048360 buf=3D{"execute":"qom-get","a=
rguments":{"path":"/machine/unattached/device[0]","property":"realized"},"i=
d":"libvirt-8"}
>> >>=20
>> >> 2025-04-08 14:44:29.149+0000: 1481190: info : qemuMonitorIOWrite:340 =
: QEMU_MONITOR_IO_WRITE: mon=3D0x7f4678048360 buf=3D{"execute":"qom-get","a=
rguments":{"path":"/machine/unattached/device[0]","property":"unavailable-f=
eatures"},"id":"libvirt-473"}
>> >>=20
>> >> Libvirt spent ~170 ms probing cpu flags.
>> >
>> > One thing I would point out is that qom-get can be considered an
>> > "escape hatch" to get information when no better QMP command exists.
>> > In this case, libvirt has made the assumption that every CPU feature
>> > is a QOM property.
>> >
>> > Adding qom-list-get doesn't appreciably change that, just makes the
>> > usage more efficient.
>> >
>> > Considering the bigger picture QMP design, when libvirt is trying to
>> > understand QEMU's CPU feature flag expansion, I would ask why we don't
>> > have something like a "query-cpu" command to tell us the current CPU
>> > expansion, avoiding the need for poking at QOM properties directly.
>>=20
>> How do the existing query-cpu-FOO fall short of what management
>> applications such as libvirt needs?
>
> It has been along while since I looked at them, but IIRC they were
> returning static info about CPU models, whereas libvirt wanted info
> on the currently requested '-cpu ARGS'

Libvirt developers, please work with us on design of new commands or
improvements to existing ones to better meet libvirt's needs in this
area.


