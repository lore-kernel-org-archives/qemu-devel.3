Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315BEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 11:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbePH-0005TW-4r; Wed, 07 Aug 2024 07:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbePD-0005IK-Im
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbePA-000548-4M
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723028431;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkSK1QiEX+8br5U6+Y7pIxkdsGt74W3VPCm8TpeHVFU=;
 b=JUCF50RT/BUA5lGisc/dAZQa6Yij6nv6DqTxOpYAL5n5CyVyGt6zo6te3XXQEbTsLJ5JVh
 FsgZOOyDcwO/iASTM7uPVwie+kaa879nlmvkxTf+hKQw/CKeUIskIrcoY35vbXOq1ulSoa
 VCggCeHA/UtmxX/tPJPvxHyO2hTNtRk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-o7C8p8ynOuKIqvCFdaetkA-1; Wed,
 07 Aug 2024 07:00:27 -0400
X-MC-Unique: o7C8p8ynOuKIqvCFdaetkA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7040919373D8; Wed,  7 Aug 2024 11:00:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5B9419560A3; Wed,  7 Aug 2024 11:00:24 +0000 (UTC)
Date: Wed, 7 Aug 2024 12:00:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] qapi: Generate QAPI files using qapi/ for generated
 header paths
Message-ID: <ZrNTxb8go0xqfE3R@redhat.com>
References: <20240807093406.40360-1-philmd@linaro.org>
 <ZrNB5C7Ta-Qg-9HT@redhat.com> <87ttfwwqrx.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttfwwqrx.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, Aug 07, 2024 at 12:50:26PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Aug 07, 2024 at 11:34:06AM +0200, Philippe Mathieu-Daudé wrote:
> >> QAPI script generates headers under the qapi/ directory,
> >> so use this prefix in generated header paths, keeping
> >> all QAPI under the qapi/ namespace.
> >
> > Err that's not always the case is it ?
> 
> Yup.  We generate into the current directory by default, but you can set
> another one with --output-dir.
> 
> > For the main QMP schema, it generates under $BUILDDIR/qapi/,
> > but there are other schemas such as QGA, which is generated
> > under $BUILDDIR/qga/
> 
> I think we could prepend the argument of --output-dir instead.
> 
> > It is confusing that we have both shared stuff and QMP schema
> > only stuff under the same location.
> 
> Which stuff in which location?

There are multiple directories with 'qapi' in their name

 - $SRC/include/qapi - all generic stuff for any consumer of QAPI
 - $SRC/qapi - impl of generic stuff from $SRC/include/qapi, but
               also the QMP schema for machine emulator
 - $BUILD/qapi - generated code for QMP schema for machine emulator

I find it confusing that we have both generic QAPI code and the main
machine emulator QMP schema in directories sharing the same 'qapi'
name.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


