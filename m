Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804F7C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCPI-0007St-3X; Fri, 12 Jul 2024 05:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSCP8-0007S0-94
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:17:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSCP6-0003d7-A5
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720775836;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gaYMYsOXm4oS0x20XsYcVGVcUFh4eZwjQzYuvW30sUY=;
 b=YPM4vL8p5ug0K8VyQZWX/Uu0KY2/lPSRZ2zFGWCX5nSI+EMQWxrdkr6jA35Lxa+oceAmvL
 jQ8mYKpZ5BGNMEjVRxaloRSmt3b955GTjjOb48p4/GZWhfSU3oplcq/lgmt/bCdUJr+hak
 BuajCxnv2EbJfvKmkm2PpvwitQkT1Q0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-WfufIGuuOImlwlgX4H5qcA-1; Fri,
 12 Jul 2024 05:17:13 -0400
X-MC-Unique: WfufIGuuOImlwlgX4H5qcA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBF44195609E; Fri, 12 Jul 2024 09:17:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA02419560AE; Fri, 12 Jul 2024 09:17:10 +0000 (UTC)
Date: Fri, 12 Jul 2024 10:17:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 04/14] qapi: add a 'command-features' pragma
Message-ID: <ZpD0k8taHT00jZpX@redhat.com>
References: <20240604153242.251334-1-berrange@redhat.com>
 <20240604153242.251334-5-berrange@redhat.com>
 <87r0bzuj7d.fsf@pond.sub.org> <ZpDlizzbaXk4pa0U@redhat.com>
 <87a5inuh75.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5inuh75.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 12, 2024 at 10:50:54AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Jul 12, 2024 at 10:07:34AM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > The 'command-features' pragma allows for defining additional
> >> > special features that are unique to a particular QAPI schema
> >> > instance and its implementation.
> >> 
> >> So far, we have special features (predefined, known to the generator and
> >> treated specially), and normal features (user-defined, not known to the
> >> generator).  You create a new kind in between: user-defined, not known
> >> to the generator, yet treated specially (I guess?).  Hmm.
> >> 
> >> Could you at least hint at indented use here?  What special treatment do
> >> you have in mind?
> >
> > Essentially, these features are a way to attach metadata to commands that
> > the server side impl can later query. This eliminates the need to hardcode
> > lists of commands, such as in QGA which hardcodes a list of commands which
> > are safe to use when filesystems are frozen. This is illustrated later in
> > this series.
> 
> Please update docs/devel/qapi-code-gen.rst section "Pragma directives",
> and maybe section "Features".
> 
> I'm not sure conflating the new kind of feature with existing special
> features is a good idea.  I need to review more of the series before I
> can make up my mind.

I originally implemented a completely separate 'tags' concept in the
QAPI parser, before deciding I was just re-inventing 'features' for
no obvious benefit.

The other nice thing about using features is that these are exposed
in the schema and docs. With the 'fsfreeze' restriction in code,
there's no formal docs of what commands are allowed when frozen, and
this is also not exposed in QAPI schema to apps. Using 'features'
we get all that as standard.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


