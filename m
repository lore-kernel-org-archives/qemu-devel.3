Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E40D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC0U7-0001EE-Vy; Fri, 15 Nov 2024 12:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC0U6-0001Dm-5g
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:51:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC0U4-0004sP-9T
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731693110;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4jhQ6O+o41XPwOme3pTXfLpNB+afbauh+i7kVd7SWBE=;
 b=Gi83AIy9BPSH9/epC4wIaFxT6ab1KMapPNDGqpQMcMsNMNgJByIGKXeDZh4CWESJTXX3d3
 FXNwpGmqqlNa1xidlXUeKRN9dOd2v1waoslfAqN8r5bs+lgOWriyPdTQgJHZqByeZwyd3Y
 tntJheUCLBrASl8cxzyKlqZrt/NI8Hs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-8cwfiOHIM-u9yEGchZjrlQ-1; Fri,
 15 Nov 2024 12:51:49 -0500
X-MC-Unique: 8cwfiOHIM-u9yEGchZjrlQ-1
X-Mimecast-MFC-AGG-ID: 8cwfiOHIM-u9yEGchZjrlQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 698E51955EE8
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 17:51:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89B8A3003B71; Fri, 15 Nov 2024 17:51:47 +0000 (UTC)
Date: Fri, 15 Nov 2024 17:51:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 01/31] include: move include/qapi/qmp/ to
 include/qobject/
Message-ID: <ZzeKMC9v5AwFmeYM@redhat.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-2-berrange@redhat.com>
 <87bjyhdh0o.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjyhdh0o.fsf@pond.sub.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
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

On Thu, Nov 14, 2024 at 03:30:47PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The general expectation is that header files should follow the same
> > file/path naming scheme as the corresponding source file. There are
> > various historical exceptions to this practice in QEMU, with one of
> > the most notable being the include/qapi/qmp/ directory. Most of the
> > headers there correspond to source files in qobject/.
> >
> > This patch corrects that inconsistency by creating include/qobject/.
> > The only outlier is include/qapi/qmp/dispatch.h which gets renamed
> > to include/qapi/qmp-registry.h.
> >
> > To allow the code to continue to build, symlinks are temporarily
> > added in $QEMU/qapi/qmp/ to point to the new location. They will
> > be removed in a later commit.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> [...]
> 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c21d6a2f9e..656482b2a4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3153,8 +3153,6 @@ S: Supported
> >  F: qapi/
> >  X: qapi/*.json
> >  F: include/qapi/
> > -X: include/qapi/qmp/
> > -F: include/qapi/qmp/dispatch.h
> 
> This tried to have add just include/qapi/qmp/dispatch.h from this
> subdirectory.  It didn't work:
> 
>     $ scripts/get_maintainer.pl -f include/qapi/qmp/dispatch.h 
>     get_maintainer.pl: No maintainers found, printing recent contributors.
>     get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
> 
>     qemu-devel@nongnu.org (open list:All patches CC here)
> 
> The patch moved and renames the header to include/qapi/qmp-registry.h,
> which also fixes attribution:
> 
>     $ scripts/get_maintainer.pl -f include/qapi/qmp-registry.h 
>     Markus Armbruster <armbru@redhat.com> (supporter:QAPI)
>     Michael Roth <michael.roth@amd.com> (supporter:QAPI)
>     qemu-devel@nongnu.org (open list:All patches CC here)
> 
> Mentioning this in the commit message wouldn't hurt.  Not worth a
> respin.

I didn't even realize I had fixed such a bug :-) Feel free to add
to the commit message if you choose to queue this series.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


