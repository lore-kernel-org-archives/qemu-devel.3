Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D9910854D2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3CZI-0008FD-Sv; Thu, 19 Mar 2026 08:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3CZG-0008EX-Gb
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3CZE-0001m0-BD
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773923615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/yNIp548Llnl62sPTYtl03/gbLoOnbLZqtjletpNZEw=;
 b=e1jQxkzZFOL1PjTJW69nETQ6ImTpnGe4Rja06CRgMxWs1u3Hijz7WFqLMKaL60UYqIQOMd
 NRkpiYxOnFNDU0izA+X0iD9C5G9qXNaawQ6btHUlypRFW77DMw8sYA43zQHVP0bVgQk4RV
 Z9xLPDH+r/rGJQSxe1hy/3wYlvE7Xr0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-4nMTlIClOhOy2SVYni1NwQ-1; Thu,
 19 Mar 2026 08:33:32 -0400
X-MC-Unique: 4nMTlIClOhOy2SVYni1NwQ-1
X-Mimecast-MFC-AGG-ID: 4nMTlIClOhOy2SVYni1NwQ_1773923610
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 473F919560B4; Thu, 19 Mar 2026 12:33:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9AAF180035F; Thu, 19 Mar 2026 12:33:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60E2F21E6937; Thu, 19 Mar 2026 13:33:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tommaso Califano <califano.tommaso@gmail.com>
Cc: qemu-devel@nongnu.org,  kvm@vger.kernel.org,  Eduardo Habkost
 <eduardo@habkost.net>,  Markus Armbruster <armbru@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Eric Blake <eblake@redhat.com>,  Oliver
 Steffen <osteffen@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Luigi Leonardi <leonardi@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 4/5] i386/sev: Add launch measurement emulation and TIK
 property
In-Reply-To: <20260317113840.33017-5-califano.tommaso@gmail.com> (Tommaso
 Califano's message of "Tue, 17 Mar 2026 12:38:39 +0100")
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-5-califano.tommaso@gmail.com>
Date: Thu, 19 Mar 2026 13:33:27 +0100
Message-ID: <87pl50vw14.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tommaso Califano <califano.tommaso@gmail.com> writes:

> The next step for completing the SEV launch emulation is to implement the
> "query-sev-launch-measure" feature, responsible for returning the
> measurement. In this case the measurement will be computed in QEMU.
>
> Implement sev_emulated_launch_get_measure() to emulate the LAUNCH_MEASURE
> command per AMD SEV API spec section 6.5.1. It generates a random 16-byte
> mnonce, computes the launch digest as SHA-256 over ld_data, then derives
> the measurement via HMAC-SHA256
> (TIK;0x04|| API version || build ID || policy || launch digest || mnonce).
> The base64-encoded result (32-byte HMAC + 16-byte mnonce) populates
> "query-sev-launch-measure" data, advancing state to LAUNCH_SECRET for
> secret injection.
>
> The TIK is supplied via 16-byte binary file specified in new
> SevEmulatedProperty "tik" path; absent this, keys default to zeroed.
> Example QEMU arguments with the key passed:
>
> 	-cpu "EPYC-Milan" \
> 	-accel tcg \
> 	-object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1,\
> 					tik=/path/to/tik.bin \
> 	-machine memory-encryption=sev0
>
> Signed-off-by: Tommaso Califano <califano.tommaso@gmail.com>
> ---
>  qapi/qom.json     |   3 +-
>  target/i386/sev.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 157 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 35cda819ec..affb5024b5 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1064,11 +1064,12 @@
>  # This object functionally emulates AMD SEV hardware via TCG, so
>  # it does not require real hardware to run.
>  #
> +# @tik: binary file of the SEV TIK (default: all 0).

Is this a file name?

Blank line here, please.

>  # Since: 10.1.0
>  ##
>  { 'struct': 'SevEmulatedProperties',
>    'base': 'SevGuestProperties',
> -  'data': {}}
> +  'data': {'*tik': 'str'}}
>  
>  ##
>  # @SevSnpGuestProperties:

[...]


