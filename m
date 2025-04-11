Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82852C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3ELs-0004pB-4W; Fri, 11 Apr 2025 09:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1u3ELp-0004ox-3E
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1u3ELn-0008GA-Fd
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744377796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MrCa2LeTe9hzYmu4f0pzNNgcUisvjfpAw/BhiCX6aBc=;
 b=VqfC0omOM5VJ9nS7/4Re3SgVEQGLzCHDOrOfgfnh+JgjDrGl84UrWNow94zZ9+DcfybA7C
 tOM97eTtPcXaYaHoNVgcdZDmP3KWdt4YKc4XWYcG+Db6bCU3XhBP0CKK3sJVsWrFxtsUfH
 flmoNxD9kOsUlv8oMPKjrisBdKeSdH8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-8pM1N4i8Na6Kh2uPlRBhuA-1; Fri,
 11 Apr 2025 09:23:11 -0400
X-MC-Unique: 8pM1N4i8Na6Kh2uPlRBhuA-1
X-Mimecast-MFC-AGG-ID: 8pM1N4i8Na6Kh2uPlRBhuA_1744377789
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7D211955DCE; Fri, 11 Apr 2025 13:23:09 +0000 (UTC)
Received: from orkuz (unknown [10.44.32.99])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D249E19560AD; Fri, 11 Apr 2025 13:23:08 +0000 (UTC)
Date: Fri, 11 Apr 2025 15:23:07 +0200
From: Jiri Denemark <jdenemar@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>
Subject: Re: Management applications and CPU feature flags
Message-ID: <Z_kXuy9N4wiHU-qE@orkuz.int.mamuti.net>
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org> <Z_YolW1Nw6Q_tsz6@angien.pipo.sk>
 <Z_jq5drO_25w0bC6@redhat.com> <87lds77zgx.fsf_-_@pond.sub.org>
 <Z_jyVQMfRbWaM66y@redhat.com> <8734ee9b4k.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734ee9b4k.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Apr 11, 2025 at 13:43:39 +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> > On Fri, Apr 11, 2025 at 12:40:46PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> > Considering the bigger picture QMP design, when libvirt is trying to
> >> > understand QEMU's CPU feature flag expansion, I would ask why we don't
> >> > have something like a "query-cpu" command to tell us the current CPU
> >> > expansion, avoiding the need for poking at QOM properties directly.
> >> 
> >> How do the existing query-cpu-FOO fall short of what management
> >> applications such as libvirt needs?
> >
> > It has been along while since I looked at them, but IIRC they were
> > returning static info about CPU models, whereas libvirt wanted info
> > on the currently requested '-cpu ARGS'
> 
> Libvirt developers, please work with us on design of new commands or
> improvements to existing ones to better meet libvirt's needs in this
> area.

The existing commands (query-cpu-definitions, query-cpu-model-expansion)
are useful for probing before starting a domain. But what we use qom-get
for is to get a view of the currently instantiated virtual CPU created
by QEMU according to -cpu when we're starting a domain. In other words,
we start QEMU with -S and before starting vCPUs we need to know exactly
what features were enabled and if any feature we requested was disabled
by QEMU. Currently we query QOM for CPU properties as that's what we
were advised to use ages ago.

The reason behind querying such info is ensuring stable guest ABI during
migration. Asking QEMU for a specific CPU model and features does not
mean we'll get exactly what we asked for (this is not a bug) so we need
to record the differences so that we can start QEMU for incoming
migration with a CPU matching exactly the one provided on the source.

As Peter said, the current way is terribly inefficient as it requires
several hundreds of QMP commands so the goal is to have a single QMP
command that would tell us all we need to know about the virtual CPU.
That is all enabled features and all features that could not be enabled
even though we asked for them.

Jirka


