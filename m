Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E0DC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 16:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Mvb-0004yR-3R; Mon, 14 Apr 2025 12:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4MvX-0004x6-O5
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4MvR-00076O-OK
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744649088;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OcN5k9QmrnlyPBXU5Pv3tSyq5MUTn3VgFqSkZxEy3tU=;
 b=cNx1DAShgv8ELWUTe7tCBJuv8rCvIMtdA4CykmenyxgnonWKdn0XdNhTj+SA4T3x6gxr4K
 Q9hegI+dCQRUeaRGErhJGdXiLET8PaEyAkYR/+K579qik0zkMooV+Cv+dbFdkD+sA2SWUr
 fAVPFWUl65ESggy2HeKZ4th9Z4+k68o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-dXf9Qus6MxyqlgBAgmLmgA-1; Mon,
 14 Apr 2025 12:44:44 -0400
X-MC-Unique: dXf9Qus6MxyqlgBAgmLmgA-1
X-Mimecast-MFC-AGG-ID: dXf9Qus6MxyqlgBAgmLmgA_1744649083
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E408195609F; Mon, 14 Apr 2025 16:44:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9317A19560AD; Mon, 14 Apr 2025 16:44:40 +0000 (UTC)
Date: Mon, 14 Apr 2025 17:44:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 00/13] migration: Unify capabilities and parameters
Message-ID: <Z_07dfI4rFRpvZA1@redhat.com>
References: <20250411191443.22565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250411191443.22565-1-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Fri, Apr 11, 2025 at 04:14:30PM -0300, Fabiano Rosas wrote:
> Open questions:
> ---------------
> 
> - Deprecations/compat?
> 
> I think we should deprecate migrate-set/query-capabilities and everything to do
> with capabilities (specifically the validation in the JSON at the end of the
> stream).
> 
> For migrate-set/query-parameters, we could probably keep it around indefinitely,
> but it'd be convenient to introduce new commands so we can give them new
> semantics.
> 
> - How to restrict the options that should not be set when the migration is in
> progress?
> 
> i.e.:
>   all options can be set before migration (initial config)
>   some options can be set during migration (runtime)
> 
> I thought of adding another type at the top of the hierarchy, with
> just the options allowed to change at runtime, but that doesn't really
> stop the others being also set at runtime. I'd need a way to have a
> set of options that are rejected 'if migration_is_running()', without
> adding more duplication all around.
> 
> - What about savevm?
> 
> None of this solves the issue of random caps/params being set before
> calling savevm. We still need to special-case savevm and reject
> everything. Unless we entirely deprecate setting initial options via
> set-parameters (or set-config) and require all options to be set as
> savevm (and migrate) arguments.

I'd suggest we aim for a world where the commands take all options
as direct args and try to remove the global state eventually.

For savevm/loadvm in particular it is very much a foot-gun that
'migrate-set-*' will affect them, because savevm/loadvm aren't
obviously connected to 'migrate-*' commands unless you're aware
of how QEMU implements savevm internally.

> - HMP?
> 
> Can we convert the strings passed via hmp_set_parameters without
> having an enum of parameters? Duplication problem again.

> 
> - incoming defer?
> 
> It seems we cannot do the final step of removing
> migrate-set-capabilites before we have a form of handshake
> implemented. That would take the config from qmp_migrate on source and
> send it to the destination for negotiation.

I'm not sure I understand why the QAPI design changes are tied
to the new protocol handshake ? I guess you're wanting to avoid
updating 'migrate_incoming' to accept the new parameters directly ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


