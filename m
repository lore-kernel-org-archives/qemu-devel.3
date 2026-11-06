Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C772E606A339
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DpRS3S1F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIWO-0008IS-At; Fri, 06 Nov 2026 06:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPIWD-00089r-WE
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:54:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPIWC-0003tz-6E
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793966043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtcnqn5Vp4SI2TKCVXbBACsHaWe15AWoldwSHbLQpXI=;
 b=DpRS3S1FfxK2HxWWkukDBpv0srlxmVyAks5LFKvhDKJYa1za6yL2/I6Altl/U34TL/eZJ3
 Z0d0DOE9hcvqjynRX2QzA2HB/Mhm/Hp0M84Dl4rQrEXYXnDy0LNps7kckWhuk+fiGhiNL5
 imrSRCVAFC99R6qfVKuISN/86JoW2b4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-YFptxQWZPqOcoLwxFxBMyQ-1; Fri,
 06 Nov 2026 06:54:00 -0500
X-MC-Unique: YFptxQWZPqOcoLwxFxBMyQ-1
X-Mimecast-MFC-AGG-ID: YFptxQWZPqOcoLwxFxBMyQ_1793966038
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3D66180057A; Fri,  6 Nov 2026 11:53:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEEF139200; Fri,  6 Nov 2026 11:53:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9841921E6A04; Fri, 06 Nov 2026 12:53:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 xen-devel@lists.xenproject.org,  qemu-ppc@nongnu.org,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Anthony PERARD <anthony@xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Stefano Stabellini
 <sstabellini@kernel.org>,  Alexey Kardashevskiy <aik@ozlabs.ru>,  Richard
 Henderson <richard.henderson@linaro.org>,  Helge Deller <deller@gmx.de>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL v2 23/25] trace: stop tracking static disabled state
In-Reply-To: <20261104201802.11556-24-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Wed, 4 Nov 2026 15:17:59 -0500")
References: <20261104201802.11556-1-stefanha@redhat.com>
 <20261104201802.11556-24-stefanha@redhat.com>
Date: Fri, 06 Nov 2026 12:53:54 +0100
Message-ID: <87se1efa5p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I missed this, because I wasn't cc'ed.

Stefan Hajnoczi <stefanha@redhat.com> writes:

> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> The TraceEvent struct contains a "bool sstate" field which track whether
> a trace event was disabled statically. i.e. at build time via the
> "disable" property annotation in trace-events.
>
> The only runtime use of this field is to let "trace-event-get-state"
> report that an event is "unavailable" instead of reporting an error for
> an unknown trace event.
>
> Trace events are not ABI so their names can change and the event can
> come and go at any time. Thus there is little utility in reporting the
> existence of a disabled event that cannot ever be used at runtime.
>
> Removing the "bool sstate" field from TraceEvent saves 8 bytes of
> space in the struct, adding up to approx 64 KB across all current
> events.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Message-id: 20261102142844.3464712-24-berrange@redhat.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

[...]

> diff --git a/qapi/trace.json b/qapi/trace.json
> index 29c76256055..8533e378977 100644
> --- a/qapi/trace.json
> +++ b/qapi/trace.json
> @@ -16,8 +16,6 @@
>  # @TraceEventState:
>  #     State of a tracing event.
>  #
> -# @unavailable: The event is statically disabled.
> -#
>  # @disabled: The event is dynamically disabled.
>  #
>  # @enabled: The event is dynamically enabled.
> @@ -25,7 +23,7 @@
>  # Since: 2.2
>  ##
>  { 'enum': 'TraceEventState',
> -  'data': ['unavailable', 'disabled', 'enabled'] }
> +  'data': ['disabled', 'enabled'] }

No note in docs/about/removed-features.rst needed?

>=20=20
>  ##
>  # @TraceEventInfo:
> @@ -69,6 +67,7 @@
   ##
   # @trace-event-set-state:
   #     Set the dynamic tracing state of events.
   #
   # @name: Event name pattern (case-sensitive glob).
   #
>  # @enable: Whether to enable tracing.
>  #
>  # @ignore-unavailable: Do not match unavailable events with @name.
> +#      Deprecated: since 11.2
>  #
>  # Since: 2.2
>  #

Are you trying to deprecate use of argument @ignore-unavailable?

If no, what are you trying to do?

If yes, this isn't how we do that.  Instead:

   ##
   # @trace-event-set-state:
   #     Set the dynamic tracing state of events.
   #
   # @name: Event name pattern (case-sensitive glob).
   #
   # @enable: Whether to enable tracing.
   #
   # @ignore-unavailable: Do not match unavailable events with @name.
   #
   # Features:
   #
   # @deprecated: Argument @ignore-unavailable is deperecated and does
   #     nothing.
   #
   # Since: 2.2
   #
   # .. qmp-example::
   #
   #     -> { "execute": "trace-event-set-state",
   #          "arguments": { "name": "qemu_memalign", "enable": true } }
   #     <- { "return": {} }
   ##
   { 'command': 'trace-event-set-state',
     'data': {'name': 'str', 'enable': 'bool',
              '*ignore-unavailable': { 'type': 'bool',
                                       'features': [ 'deprecated' ] } } }

with a matching update to docs/about/deprecated.rst.

[...]


