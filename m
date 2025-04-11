Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CB0C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3EuQ-0004Xe-Ul; Fri, 11 Apr 2025 09:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u3EuP-0004XU-Cj
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u3EuN-0004Jl-Hx
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744379941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPjkwsv6mYTuttHcl/A2a+DZ5QGfarUi2mOJjE4NdMc=;
 b=Jl30c6lESlL8PVq4WZB5jPphxlQnofX/eo0JuTwhT9ti6a98pfvNl7x70+k6tWSUTgH/mx
 TMMmBMkUzu0QJiqLX9krKSzJRzVq59rgdh7jIqd5yKyV08KyqDdtzYxbJLXOLnzlm/FVrk
 rN8ULGFX9EyGZHPqPatVx+tU1QcdfTU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-E1z4HPZZN3iADha79C_Nfg-1; Fri,
 11 Apr 2025 09:58:59 -0400
X-MC-Unique: E1z4HPZZN3iADha79C_Nfg-1
X-Mimecast-MFC-AGG-ID: E1z4HPZZN3iADha79C_Nfg_1744379938
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA756180025F; Fri, 11 Apr 2025 13:58:58 +0000 (UTC)
Received: from localhost (unknown [10.44.34.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98FEC1828A9F; Fri, 11 Apr 2025 13:58:57 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jiri Denemark <jdenemar@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Krempa
 <pkrempa@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Fabiano
 Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 devel@lists.libvirt.org, David Hildenbrand <david@redhat.com>
Subject: Re: Management applications and CPU feature flags
In-Reply-To: <Z_kXuy9N4wiHU-qE@orkuz.int.mamuti.net>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org> <Z_YolW1Nw6Q_tsz6@angien.pipo.sk>
 <Z_jq5drO_25w0bC6@redhat.com> <87lds77zgx.fsf_-_@pond.sub.org>
 <Z_jyVQMfRbWaM66y@redhat.com> <8734ee9b4k.fsf@pond.sub.org>
 <Z_kXuy9N4wiHU-qE@orkuz.int.mamuti.net>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Fri, 11 Apr 2025 15:58:54 +0200
Message-ID: <875xjakdep.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
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

On Fri, Apr 11 2025, Jiri Denemark <jdenemar@redhat.com> wrote:

> On Fri, Apr 11, 2025 at 13:43:39 +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> > On Fri, Apr 11, 2025 at 12:40:46PM +0200, Markus Armbruster wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >> > Considering the bigger picture QMP design, when libvirt is trying to
>> >> > understand QEMU's CPU feature flag expansion, I would ask why we do=
n't
>> >> > have something like a "query-cpu" command to tell us the current CPU
>> >> > expansion, avoiding the need for poking at QOM properties directly.
>> >>=20
>> >> How do the existing query-cpu-FOO fall short of what management
>> >> applications such as libvirt needs?
>> >
>> > It has been along while since I looked at them, but IIRC they were
>> > returning static info about CPU models, whereas libvirt wanted info
>> > on the currently requested '-cpu ARGS'
>>=20
>> Libvirt developers, please work with us on design of new commands or
>> improvements to existing ones to better meet libvirt's needs in this
>> area.
>
> The existing commands (query-cpu-definitions, query-cpu-model-expansion)
> are useful for probing before starting a domain. But what we use qom-get
> for is to get a view of the currently instantiated virtual CPU created
> by QEMU according to -cpu when we're starting a domain. In other words,
> we start QEMU with -S and before starting vCPUs we need to know exactly
> what features were enabled and if any feature we requested was disabled
> by QEMU. Currently we query QOM for CPU properties as that's what we
> were advised to use ages ago.
>
> The reason behind querying such info is ensuring stable guest ABI during
> migration. Asking QEMU for a specific CPU model and features does not
> mean we'll get exactly what we asked for (this is not a bug) so we need
> to record the differences so that we can start QEMU for incoming
> migration with a CPU matching exactly the one provided on the source.
>
> As Peter said, the current way is terribly inefficient as it requires
> several hundreds of QMP commands so the goal is to have a single QMP
> command that would tell us all we need to know about the virtual CPU.
> That is all enabled features and all features that could not be enabled
> even though we asked for them.

Wandering in here from the still-very-much-in-progress Arm perspective
(current but not yet posted QEMU code at
https://gitlab.com/cohuck/qemu/-/tree/arm-cpu-model-rfcv3?ref_type=3Dheads):

We're currently operating at the "writable ID register fields" level
with the idea of providing features (FEAT_xxx) as an extra layer on top
(as they model a subset of what we actually need) and have yet to come
up with a good way to do named models for KVM. The
query-cpu-model-expansion command will yield a list of all writable ID
register fields and their values (as for now, for the 'host' model.) IIUC
you want to query (a) what is actually available for configuration
(before starting a domain) and (b) what you actually got (when starting
a domain). Would a dump of the current state of the ID register fields
before starting the vcpus work for (b)? Or is that too different from
what other archs need/want? How much wriggle room do we have for special
handling (different commands, different output, ...?)


