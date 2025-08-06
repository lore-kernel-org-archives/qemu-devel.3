Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394DEC87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 11:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujcUM-0000JQ-6D; Wed, 06 Aug 2025 07:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujcUI-0000Fx-V3
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujcUG-0001SY-Vx
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754480354;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYDYfK5lukr+c06bKSFiiy8pHUyLTCFwdhB9NPIl1ek=;
 b=dLyB8cUewvO4ZuyaLVfLqDwCsL7KWlJwcpGqh3/eDgiU1jcpCHYb6Vz6Dy/36OecLmyyxO
 5qceSqUOkekPXvurDr7d7wRd0pQmnFwwtKx/tVoUT0riHlveoRB9U9WHHKw0TqQZv7BUYf
 GgI3XB1pyskobxOB8CE37HIGvUdFQuA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-axXa68KeMNKt94pzPwPsnQ-1; Wed,
 06 Aug 2025 07:39:10 -0400
X-MC-Unique: axXa68KeMNKt94pzPwPsnQ-1
X-Mimecast-MFC-AGG-ID: axXa68KeMNKt94pzPwPsnQ_1754480349
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF3E8195608A; Wed,  6 Aug 2025 11:39:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.223])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6F493000199; Wed,  6 Aug 2025 11:39:05 +0000 (UTC)
Date: Wed, 6 Aug 2025 12:39:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 5/6] tracetool: add test suite for tracetool with
 reference output
Message-ID: <aJM-1ck-yb6F2lAu@redhat.com>
References: <20250806102440.702545-1-berrange@redhat.com>
 <20250806102440.702545-6-berrange@redhat.com>
 <87y0rwlmsa.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0rwlmsa.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Aug 06, 2025 at 01:20:05PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > When reviewing tracetool patches it is often very unclear what the
> > expected output will be for the generated backends. Compounding
> > this is that a default build will only enable the 'log' trace
> > backend, so developers won't see generated code for other backends
> > without making a special effort. Some backends are also platform
> > specific, so can't be enabled in QEMU builds, even though tracetool
> > could generate the code.
> >
> > To address this, introduce a test suite for tracetool which is
> > conceptually similar to the qapi-schema test. It is a simple
> > python program that runs tracetool and compares the actual output
> > to historical reference output kept in git. The test directly
> > emits TAP format logs for ease of integration with meson.
> >
> > This can be run with
> >
> >   make check-tracetool
> >
> > to make it easier for developers changing generated output, the
> > sample expected content can be auto-recreated
> >
> >   QEMU_TEST_REGENERATE=1 make check-tracetool
> 
> make check-qapi-schema uses QAPI_TEST_UPDATE for this.  Should we use a
> single environment variable for this purpose?  I'd be fine with changing
> QAPI_TEST_UPDATE.

Oh yes, that env was my doing too.  Using a common env name for any
test suite makes sense.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


