Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2BFCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lfr-0004ge-F5; Wed, 24 Sep 2025 05:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1Lfp-0004dx-N7
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1Lfg-0003Lk-QT
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758705616;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXqRkMd4xDfhXtdLj0Rx4KcHT2eOjEfALw+uMe/pPgA=;
 b=MDxuwnccwNEeAVSXqALY7xyp1XBnkO5os6baHsFu9kk8acs0DZFup+0jAva+t6tyQoDm6h
 qescSZidRc9efzG2PWDclr/ZmU+uTotxUI6BfIXvSKmde972kq1uylQZQlTNIcK3wsnqp3
 SE2ezhD+6bqWQoexeiVhfha4epcCQHk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-sBWwBMFsMz-NpEy_bcn0Kg-1; Wed,
 24 Sep 2025 05:20:13 -0400
X-MC-Unique: sBWwBMFsMz-NpEy_bcn0Kg-1
X-Mimecast-MFC-AGG-ID: sBWwBMFsMz-NpEy_bcn0Kg_1758705611
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 699991800366; Wed, 24 Sep 2025 09:20:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.136])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 998F119560B1; Wed, 24 Sep 2025 09:20:05 +0000 (UTC)
Date: Wed, 24 Sep 2025 10:20:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 08/20] log: avoid repeated prefix on incremental
 qemu_log calls
Message-ID: <aNO3wXaT5ggs2kI2@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-9-berrange@redhat.com>
 <87plbh8cpx.fsf@pond.sub.org> <aNK0-q58zw_KygMU@redhat.com>
 <87h5ws5nxs.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5ws5nxs.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 24, 2025 at 09:06:55AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Sep 23, 2025 at 04:28:42PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > Some code makes multiple qemu_log calls to incrementally emit
> >> > a single message. Currently timestamps get prepended to all
> >> > qemu_log calls, even those continuing a previous incomplete
> >> > message.
> >> >
> >> > This changes the qemu_log so it skips adding a new line prefix,
> >> > if the previous qemu_log call did NOT end with a newline.
> >> >
> >> > Reported-by: Richard Henderson <richard.henderson@linaro.org>
> >> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

snip

> > What I didn't realize was that the expectation is to call
> > qemu_log_trylock() (which returns the "FILE *" target) and
> > then you can ignore the "FILE *" and just call qemu_log()
> > repeatedly, and finally call qemu_log_unlock(FILE *) when
> > done.
> >
> > https://gitlab.com/qemu-project/qemu/-/blob/master/linux-user/strace.c?ref_type=heads#L4396
> 
> I can see the qemu_log_trylock() / qemu_log_unlock() bracket.  But the
> code within doesn't work the way you describe: it uses fprintf(f, ...).
> 
> If it did ignore @f and call qemu_log(), qemu_log() would
> qemu_log_trylock() again, taking the RCU read lock and the flockfile()
> lock on @f recursively.  Should work.
> 
> > This is a slightly wierd API design,
> 
> More seriously: entirely undocumented.  The only hint is the presence of
> qemu_log_trylock() and qemu_log_unlock().

I'm including a new patch that starts some API docs for the
log APIs.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


