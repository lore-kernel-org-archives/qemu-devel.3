Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC71C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 11:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4eYS-0004mY-DX; Tue, 15 Apr 2025 07:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1u4eYI-0004m7-Of
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1u4eYG-0000NZ-JT
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744716841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3s3eXsYR5oJDQYDO+0VyKF4fyILD/scwmC0ehY1fck=;
 b=hOTyyDfu5C9vC6Yj0WQz7PxVpO9sE6NrkLEq4NUoO7HlV4vMEHX8S64D0lz78pNubb16L4
 7rw2V1s6UmndWK8nrQNrW8gHe6+va1R0XZ07veTLtY6CRT9R0G1XvwOjdgImyFy9sQo+Cp
 cMI4Yfyn4gdxZgzWS35K5ThlJX1RGuY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-C_2NzCRAO_GxdegTY_I85g-1; Tue,
 15 Apr 2025 07:33:57 -0400
X-MC-Unique: C_2NzCRAO_GxdegTY_I85g-1
X-Mimecast-MFC-AGG-ID: C_2NzCRAO_GxdegTY_I85g_1744716836
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B6C81956048; Tue, 15 Apr 2025 11:33:56 +0000 (UTC)
Received: from orkuz (unknown [10.43.3.115])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5993B1955BC0; Tue, 15 Apr 2025 11:33:55 +0000 (UTC)
Date: Tue, 15 Apr 2025 13:33:54 +0200
From: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>
Subject: Re: Management applications and CPU feature flags
Message-ID: <Z_5EItOvC7auIXIm@orkuz.int.mamuti.net>
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org> <Z_YolW1Nw6Q_tsz6@angien.pipo.sk>
 <Z_jq5drO_25w0bC6@redhat.com> <87lds77zgx.fsf_-_@pond.sub.org>
 <Z_jyVQMfRbWaM66y@redhat.com> <8734ee9b4k.fsf@pond.sub.org>
 <Z_kXuy9N4wiHU-qE@orkuz.int.mamuti.net> <875xjakdep.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <875xjakdep.fsf@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jdenemar@redhat.com;
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

On Fri, Apr 11, 2025 at 15:58:54 +0200, Cornelia Huck wrote:
> On Fri, Apr 11 2025, Jiri Denemark <jdenemar@redhat.com> wrote:
>=20
> > On Fri, Apr 11, 2025 at 13:43:39 +0200, Markus Armbruster wrote:
> >> Daniel P. Berrang=E9 <berrange@redhat.com> writes:
> >> > On Fri, Apr 11, 2025 at 12:40:46PM +0200, Markus Armbruster wrote:
> >> >> Daniel P. Berrang=E9 <berrange@redhat.com> writes:
> >> >> > Considering the bigger picture QMP design, when libvirt is trying=
 to
> >> >> > understand QEMU's CPU feature flag expansion, I would ask why we =
don't
> >> >> > have something like a "query-cpu" command to tell us the current =
CPU
> >> >> > expansion, avoiding the need for poking at QOM properties directl=
y.
> >> >>=20
> >> >> How do the existing query-cpu-FOO fall short of what management
> >> >> applications such as libvirt needs?
> >> >
> >> > It has been along while since I looked at them, but IIRC they were
> >> > returning static info about CPU models, whereas libvirt wanted info
> >> > on the currently requested '-cpu ARGS'
> >>=20
> >> Libvirt developers, please work with us on design of new commands or
> >> improvements to existing ones to better meet libvirt's needs in this
> >> area.
> >
> > The existing commands (query-cpu-definitions, query-cpu-model-expansion)
> > are useful for probing before starting a domain. But what we use qom-get
> > for is to get a view of the currently instantiated virtual CPU created
> > by QEMU according to -cpu when we're starting a domain. In other words,
> > we start QEMU with -S and before starting vCPUs we need to know exactly
> > what features were enabled and if any feature we requested was disabled
> > by QEMU. Currently we query QOM for CPU properties as that's what we
> > were advised to use ages ago.
> >
> > The reason behind querying such info is ensuring stable guest ABI during
> > migration. Asking QEMU for a specific CPU model and features does not
> > mean we'll get exactly what we asked for (this is not a bug) so we need
> > to record the differences so that we can start QEMU for incoming
> > migration with a CPU matching exactly the one provided on the source.
> >
> > As Peter said, the current way is terribly inefficient as it requires
> > several hundreds of QMP commands so the goal is to have a single QMP
> > command that would tell us all we need to know about the virtual CPU.
> > That is all enabled features and all features that could not be enabled
> > even though we asked for them.
>=20
> Wandering in here from the still-very-much-in-progress Arm perspective
> (current but not yet posted QEMU code at
> https://gitlab.com/cohuck/qemu/-/tree/arm-cpu-model-rfcv3?ref_type=3Dhead=
s):
>=20
> We're currently operating at the "writable ID register fields" level
> with the idea of providing features (FEAT_xxx) as an extra layer on top
> (as they model a subset of what we actually need) and have yet to come
> up with a good way to do named models for KVM. The
> query-cpu-model-expansion command will yield a list of all writable ID
> register fields and their values (as for now, for the 'host' model.) IIUC
> you want to query (a) what is actually available for configuration
> (before starting a domain) and (b) what you actually got (when starting
> a domain).

I guess it will be possible for QEMU to actually set something different
=66rom what we tell it to do (for example dependency of a specific
settings on something else which was not set, etc)? If so, we indeed
need both (a) and (b).

> Would a dump of the current state of the ID register fields before
> starting the vcpus work for (b)?

I guess so. Originally for x86_64 we got a dump of CPUID data, but that
changed when some features started to be described by MSRs.

> Or is that too different from what other archs need/want?

Each arch has some specifics in CPU configuration and the way we talk
with QEMU about it. So having the same QMP interface is not a
requirement. It depends how well the existing interface maps to details
that need to be expressed. That said a common interface is better if it
makes sense.

Jirka


