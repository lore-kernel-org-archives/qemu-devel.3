Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA19E9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 10:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsf3f-0000Pv-ES; Wed, 18 Feb 2026 05:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vsf3d-0000PQ-J2
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 05:45:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vsf3b-0002nF-CV
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 05:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771411520;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1daQWUYdxPH0U39GJiqxU0N0Xk6rs2qulmWoOgh/mOo=;
 b=K32nqNEB9odnFaPz6vmR6A8xQZ+bxB6cXb20WNpdtl+NngfawVMgG1ZSuRGMYCntFS2cOV
 07pRv8/Ms9UTxewesmtnF/DhgTdCQa0rgkPrEMJpQnwGPuIiB2l2+UO5XjVeLbOV6H6KkC
 oplaNWv8nH3Wkg4RMHsd+oRSHzlcZ1c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-laaogyxCOISg7a4gQKmong-1; Wed,
 18 Feb 2026 05:45:17 -0500
X-MC-Unique: laaogyxCOISg7a4gQKmong-1
X-Mimecast-MFC-AGG-ID: laaogyxCOISg7a4gQKmong_1771411516
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CCCA1800282; Wed, 18 Feb 2026 10:45:15 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.150])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E7BA19560B5; Wed, 18 Feb 2026 10:45:09 +0000 (UTC)
Date: Wed, 18 Feb 2026 10:45:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 12/27] util: avoid repeated prefix on incremental
 qemu_log calls
Message-ID: <aZWYMQHK1w3UpX4K@redhat.com>
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-13-berrange@redhat.com>
 <87ms16e5vc.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ms16e5vc.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Wed, Feb 18, 2026 at 10:52:07AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > There are three general patterns to QEMU log output
> >
> >  1. Single complete message calls
> >
> >       qemu_log("Some message\n");
> >
> >  2. Direct use of fprintf
> >
> >       FILE *f = qemu_log_trylock()
> >       fprintf(f, "...");
> >       fprintf(f, "...");
> >       fprintf(f, "...\n");
> >       qemu_log_unlock(f)
> 
> Real code needs to check @f or risk crashing.  Shouldn't we show that
> here?

Yes, we should really.

> >  3. Mixed use of qemu_log_trylock/qemu_log()
> >
> >       FILE *f = qemu_log_trylock()
> >       qemu_log("....");
> >       qemu_log("....");
> >       qemu_log("....\n");
> >       qemu_log_unlock(f)
> >
> > When message prefixes are enabled, the timestamp will be
> > unconditionally emitted for all qemu_log() calls. This
> > works fine in the 1st case, and has no effect in the 2nd
> > case. In the 3rd case, however, we get the timestamp
> > printed over & over in each fragment.
> >
> > One can suggest that pattern (3) is pointless as it is
> > functionally identical to (2) but with extra indirection
> > and overhead. None the less we have a fair bit of code
> > that does this.
> >
> > The qemu_log() call itself is nothing more than a wrapper
> > which does pattern (2) with a single fprintf() call.
> 
> qemu_log_trylock()'s lock is recursive.  Worth a comment?  Not sure.

Sure.

> > Fixes: 012842c07552 (log: make '-msg timestamp=on' apply to all qemu_log usage)
> > Reported-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


