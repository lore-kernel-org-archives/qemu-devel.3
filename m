Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733FDC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 17:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4NU2-0003sV-Nd; Mon, 14 Apr 2025 13:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4NTy-0003rb-Uw
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4NTu-0005e0-Mx
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744651223;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Co5VK7MUg4VE9f5x1YwI4ikKJo7vyYaY24Kbe+QuACQ=;
 b=awibRmqaAubqznSOJ1P1O9bIr1pAk0lXj+leptTxqi0g2w5V8ohbEr9T7xAWCeX47q98bi
 kgjeDnXzbAR8TFwQLB6sBlwVoFP13f69Ubaf+2KjSb/ntYM1xE1FDorW3pccFKa/8TB5IS
 X7olFtEjyVhSVhpiev0qprsp3TJtye8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-vf8JrqFhNViyKq4FpHacnA-1; Mon,
 14 Apr 2025 13:20:19 -0400
X-MC-Unique: vf8JrqFhNViyKq4FpHacnA-1
X-Mimecast-MFC-AGG-ID: vf8JrqFhNViyKq4FpHacnA_1744651218
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63A45180025A; Mon, 14 Apr 2025 17:20:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D02BF3001D0F; Mon, 14 Apr 2025 17:20:15 +0000 (UTC)
Date: Mon, 14 Apr 2025 18:20:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 00/13] migration: Unify capabilities and parameters
Message-ID: <Z_1DzDB8v6FOT9TG@redhat.com>
References: <20250411191443.22565-1-farosas@suse.de>
 <Z_07dfI4rFRpvZA1@redhat.com> <87v7r6fz0c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7r6fz0c.fsf@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 14, 2025 at 02:12:35PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Apr 11, 2025 at 04:14:30PM -0300, Fabiano Rosas wrote:
> >> Open questions:
> >> ---------------
> >> 
> >> - Deprecations/compat?
> >> 
> >> I think we should deprecate migrate-set/query-capabilities and everything to do
> >> with capabilities (specifically the validation in the JSON at the end of the
> >> stream).
> >> 
> >> For migrate-set/query-parameters, we could probably keep it around indefinitely,
> >> but it'd be convenient to introduce new commands so we can give them new
> >> semantics.
> >> 
> >> - How to restrict the options that should not be set when the migration is in
> >> progress?
> >> 
> >> i.e.:
> >>   all options can be set before migration (initial config)
> >>   some options can be set during migration (runtime)
> >> 
> >> I thought of adding another type at the top of the hierarchy, with
> >> just the options allowed to change at runtime, but that doesn't really
> >> stop the others being also set at runtime. I'd need a way to have a
> >> set of options that are rejected 'if migration_is_running()', without
> >> adding more duplication all around.
> >> 
> >> - What about savevm?
> >> 
> >> None of this solves the issue of random caps/params being set before
> >> calling savevm. We still need to special-case savevm and reject
> >> everything. Unless we entirely deprecate setting initial options via
> >> set-parameters (or set-config) and require all options to be set as
> >> savevm (and migrate) arguments.
> >
> > I'd suggest we aim for a world where the commands take all options
> > as direct args and try to remove the global state eventually.
> >
> 
> Well, except the options that are adjusted during migration. But yes, I
> agree. It all depends on how we proceed with keeping the old commands
> around and for how long. If they're still around we can't stop people
> from using them and later invoking "savevm" for instance.
> 
> > For savevm/loadvm in particular it is very much a foot-gun that
> > 'migrate-set-*' will affect them, because savevm/loadvm aren't
> > obviously connected to 'migrate-*' commands unless you're aware
> > of how QEMU implements savevm internally.
> >
> 
> Yes, I could perhaps reset all options once savevm is called, maybe that
> would be acceptable, then we don't need to check and block every single
> one. Once we add support to migration options to savevm, then they'd be
> set in the savevm command-line from day 1 and those wouldn't be
> reset. We could also keep HMP restricted to savevm without any migration
> options. That's be easy to enforce. If the user wants fancy savevm, they
> can invoke via QMP.

Can we make the two approaches mutually exclusive ? Taking your
'migrate' command example addition:

  { 'command': 'migrate',
    'data': {'*uri': 'str',
             '*channels': [ 'MigrationChannel' ],
  +          '*config': 'MigrationConfig',
             '*detach': 'bool', '*resume': 'bool' } }

if 'migrate' is invoked with the '*config' data being non-nil,
then we should ignore *all* global state previously set with
migrate-set-XXXX, and exclusively use '*config'.

That gives a clean semantic break between old and new approaches,
without us having to worry about removing the existing commands
quickly.


> >> - incoming defer?
> >> 
> >> It seems we cannot do the final step of removing
> >> migrate-set-capabilites before we have a form of handshake
> >> implemented. That would take the config from qmp_migrate on source and
> >> send it to the destination for negotiation.
> >
> > I'm not sure I understand why the QAPI design changes are tied
> > to the new protocol handshake ? I guess you're wanting to avoid
> > updating 'migrate_incoming' to accept the new parameters directly ?
> >
> 
> Yes, without migrate-set-capabilities, we'd need to pass an enormous
> command line to -incoming defer to be able to enable capabilities on the
> destination. With the handshake, we could transfer them over the wire
> somehow. Does that make sense?

'-incoming defer' still gets paired with 'migrate-incoming' on the
target, so no matter what, there's no reason to ever pass parameters
on the CLI with '-incoming defer'.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


