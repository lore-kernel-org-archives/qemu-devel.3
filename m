Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C89D3A670
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 17:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5pr5-0005iV-0z; Tue, 29 Oct 2024 13:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5pr3-0005iF-NE
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5pr1-0005rY-DX
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730222281;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tCcjchzf9OKzkyqRhhA0g+uNjrR4Xxe1vbwj9HrUfKs=;
 b=RefJj1zoHZDAc2E+plVjpDRyt5XaUdDNm9HXmPaf6NC9zNtqEeIL/HCucJ3LLjTagYetAJ
 kWM81qse1X5/6AjLhGxQVOua9O+Ngh5mTe3X2U/4GqCvrBsOO4M+FBdcsBDv73+OyvXi7C
 KUxzZM23FyWFqwTZMkVdJDXHPlFL9iE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-qn_xi9gBM8iurkKSHUywaQ-1; Tue,
 29 Oct 2024 13:17:58 -0400
X-MC-Unique: qn_xi9gBM8iurkKSHUywaQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EDBC19560A3; Tue, 29 Oct 2024 17:17:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D2BA1956056; Tue, 29 Oct 2024 17:17:50 +0000 (UTC)
Date: Tue, 29 Oct 2024 17:17:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/4] QOM: Singleton interface
Message-ID: <ZyEYu1ZG5Uk0RnaE@redhat.com>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <87h690my2w.fsf@pond.sub.org> <Zxuy5CjKNlK49TUL@x1n>
 <ZyC8MmM7k6df2Awi@redhat.com> <ZyD1BarDJUSA7Nen@x1n>
 <ZyEHoj3Mrm3OGtnX@redhat.com> <ZyEVwFaTbqtw2Vx6@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyEVwFaTbqtw2Vx6@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 29, 2024 at 01:05:04PM -0400, Peter Xu wrote:
> But I'm not sure whether that's a concern at all for Libvirt, if what
> Libvirt currently does is having separate "migrate-set-*" commands prior to
> the "migrate".  I may have overlooked the real issue behind on how that
> could complicate Libvirt.
> 
> > 
> > Rather than MigrationState become a singleton, I'd really encourage
> > trying to see if we can fix the lifecycle design problems, so that
> > we have a clear beginning & end of the migration operation, with the
> > state discarded at the end, such that every future migrate starts
> > from a clean base.
> 
> I assume it implies the join() path as a start.  As long as we're ok we
> risk slow quits of QEMU, as I would expect bug reports coming afterwards,
> we could try.  I believe there's no way we can resolve all such issues in
> one shot.  I doubt whether some of those can be too tricky so we may wish
> to go back at some point, spending too much effort but without a direct
> benefit yet so far.
> 
> Meanwhile we still have the immediate concern that current_migration can
> points to freed memory right now with QEMU master branch.  That's simply
> wrong.

Yeah, if we're accessing freed memory, that's a segv/abrt danger, and
needs fixing quickly.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


