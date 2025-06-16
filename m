Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC8BC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 09:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6Wv-0006UY-Qe; Mon, 16 Jun 2025 05:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uR6WT-0006CH-NS
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uR6WQ-0002St-JY
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750067577;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFZ3XfaJHHBYyrUjidgVSFS7BuCjSPvE2KeY0wm4Ah0=;
 b=bn1gGGSWeEW943ffa8DBgx25WL7qt84ug0oxy7jmqh5q1Q071uncsR/QF4tCOeIXgJzJQw
 JRKr/T5pdBDDNjhQ6ej35xhpfr1ZVl+LA7aa7HH7B71b0USZbP3yWJzeP63CnwRsL+65K/
 upOq/s+UmhBZiuDrzgkCBXAETxZrOH4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-S6WROfhNNYeSFMAsKBxOkw-1; Mon,
 16 Jun 2025 05:52:53 -0400
X-MC-Unique: S6WROfhNNYeSFMAsKBxOkw-1
X-Mimecast-MFC-AGG-ID: S6WROfhNNYeSFMAsKBxOkw_1750067573
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 822E919560B0; Mon, 16 Jun 2025 09:52:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2A10180045C; Mon, 16 Jun 2025 09:52:48 +0000 (UTC)
Date: Mon, 16 Jun 2025 10:52:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de
Subject: Re: [PATCH 1/2] block/rbd: support selected key-value-pairs via QAPI
Message-ID: <aE_pbAS_gS12Fp8f@redhat.com>
References: <20250515112908.383693-1-f.ebner@proxmox.com>
 <20250515112908.383693-2-f.ebner@proxmox.com>
 <CAOi1vP94WJ7r1vPXvcpGZTs2xf6TZ=p=EmVGQvwipftufaYAMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOi1vP94WJ7r1vPXvcpGZTs2xf6TZ=p=EmVGQvwipftufaYAMw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 16, 2025 at 11:25:54AM +0200, Ilya Dryomov wrote:
> On Thu, May 15, 2025 at 1:29 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
> >
> > Currently, most Ceph configuration options are not exposed via QAPI.
> > While it is possible to specify a dedicated Ceph configuration file,
> > specialized options are often only required for a selection of images
> > on the RBD storage, not all of them. To avoid the need to generate a
> > dedicated Ceph configuration file for each image (or for each required
> > combination of options), support a selection of key-value pairs via
> > QAPI.
> >
> > Initially, this is just 'rbd_cache_policy'. For example, this is
> > useful with small images used as a pflash for EFI variables. Setting
> > the 'rbd_cache_policy' to 'writeback' yields a substantial improvement
> > there [0].
> >
> > The function qemu_rbd_extract_key_value_pairs() was copied/adapted
> > from the existing qemu_rbd_extract_encryption_create_options().
> >
> > [0]: https://bugzilla.proxmox.com/show_bug.cgi?id=3329#c9
> >
> > Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

snip

> >  ##
> >  # @BlockdevOptionsRbd:
> >  #
> > @@ -4327,6 +4360,9 @@
> >  #     authentication.  This maps to Ceph configuration option "key".
> >  #     (Since 3.0)
> >  #
> > +# @key-value-pairs: Key-value pairs for additional Ceph configuraton.
> > +#     (Since 10.1)
> > +#
> >  # @server: Monitor host address and port.  This maps to the "mon_host"
> >  #     Ceph option.
> >  #
> > @@ -4342,6 +4378,7 @@
> >              '*user': 'str',
> >              '*auth-client-required': ['RbdAuthMode'],
> >              '*key-secret': 'str',
> > +            '*key-value-pairs' : 'RbdKeyValuePairs',
> 
> To side-step all of the above, have you considered implementing
> a straightforward passthrough to Ceph instead?  Something like
> 
>   '*key-value-pairs': ['RbdKeyValuePair']
> 
> where RbdKeyValuePair is just a pair arbitrary strings (and
> key-value-pairs is thus an optional list of those).  rados_conf_set()
> would be called just the same but the user would be able to override
> any Ceph option they wish, not just a few that we thought of here.

Passing through arbitrary key/value pairs as strings is essentially
abdicating our design responsibility in QAPI. enums would no longer
be introspectable. Integers / booleans would require abnormal formatting
by clients. API stability / deprecation promises can no longer be made.
and more besides.

Given that limitation, if we did go the string pairs route, I would
expect it to be marked as "unstable" in the QAPI schema, so apps have
a suitable warning NOT to rely on this.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


