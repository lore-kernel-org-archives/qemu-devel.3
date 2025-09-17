Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CA8CAC599
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 14:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uysoc-000328-10; Wed, 17 Sep 2025 10:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uysob-00031i-0f
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 10:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uysoX-0007QS-U2
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 10:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758118036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrUeRa6/z4W9yEZEGZU7IYcGdBpM/80QyEhrv+IDJbs=;
 b=OMtYJriwQoaXnB30QAy4J7k+xt+uVzJ5LOtIZ0Epj76gZ57TG7/MHudH4iMEuux1ZG0Jze
 Z4qRwkRwh/PaCe69xrDm52MqietukTRz0ccGEAv/OZt//UmJFez04dtBHvZ3oUUaX30fXz
 a6fnWXVZNmXjGSSJKki6cAiWvXHSG4g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-kqgyzXcaMTO1ab_XVSWNJw-1; Wed,
 17 Sep 2025 10:07:11 -0400
X-MC-Unique: kqgyzXcaMTO1ab_XVSWNJw-1
X-Mimecast-MFC-AGG-ID: kqgyzXcaMTO1ab_XVSWNJw_1758118030
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9333818002CC; Wed, 17 Sep 2025 14:07:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFF98195608E; Wed, 17 Sep 2025 14:07:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2287F21E6A27; Wed, 17 Sep 2025 16:07:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Hanna Reitz
 <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Christian Schoenebeck
 <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v3 02/20] monitor: initialize global data from a
 constructor
In-Reply-To: <20250910180357.320297-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 10 Sep 2025 19:03:39
 +0100")
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-3-berrange@redhat.com>
Date: Wed, 17 Sep 2025 16:07:06 +0200
Message-ID: <871po541h1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Some monitor functions, most notably, monitor_cur() rely on global
> data being initialized by 'monitor_init_globals()'. The latter is
> called relatively late in startup. If code triggers error_report()
> before monitor_init_globals() is called, QEMU will abort when
> accessing the uninitialized monitor mutex.
>
> The critical monitor global data must be initialized from a
> constructor function, to improve the guarantee that it is done
> before any possible calls to monitor_cur(). Not only that, but
> the constructor must be marked to run before the default
> constructor in case any of them trigger error reporting.

Is error reporting from constructors a good idea?  I feel they're best
used for simple initializations only.

Do we actually do it?

> Note in particular that the RCU constructor will spawn a background
> thread so we might even have non-constructor QEMU code running
> concurrently with other constructors.

Ugh!

Arguably

  Fixes: e69ee454b5f9 (monitor: Make current monitor a per-coroutine proper=
ty)

I never liked the @coroutine_mon hash table (which is what broke early
monitor_cur()), but accepted it for want of better ideas.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


