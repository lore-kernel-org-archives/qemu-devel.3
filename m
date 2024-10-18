Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF15D30019
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 16:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1pUD-0000b0-Ct; Fri, 18 Oct 2024 12:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1pU1-0000Xn-Ki
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1pTy-0003Uu-12
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729267539;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cH43Oww8azURXE9Jn2vC14F2s2Q4yZGFD/adILRxZ6g=;
 b=cZaw/h5ZwNaK/1KZEbB+lYv5HC4x6X6XijoRAm6XP5HEVfbrsOu/6HxY0xhaplIgzy10ty
 /TSS2ygFL/QPYrfyM4nj24xnYWTvd3F1FGjCfo6Xd0v7GQgUzbgjb24Z2k9SpNURt9K7qT
 TF6t5nPAM4dacjinuTQEJ+Ol3Q3s0IU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-rTqoxu-vN2GWDta8eEyfbQ-1; Fri,
 18 Oct 2024 12:05:36 -0400
X-MC-Unique: rTqoxu-vN2GWDta8eEyfbQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83FDC1956058; Fri, 18 Oct 2024 16:05:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA0EB19560A2; Fri, 18 Oct 2024 16:05:31 +0000 (UTC)
Date: Fri, 18 Oct 2024 17:05:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Octavian Purdila <tavip@google.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, eduardo@habkost.net, armbru@redhat.com,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] cli: add connect-gpios option
Message-ID: <ZxKHSB8l1HmtxrZ6@redhat.com>
References: <20241010173929.3910466-1-tavip@google.com>
 <CAFEAcA9X1bdtxRL9fm_rnw9ezMZSW6HaURfMsA4aLMSHM4fzdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9X1bdtxRL9fm_rnw9ezMZSW6HaURfMsA4aLMSHM4fzdw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 18, 2024 at 04:38:24PM +0100, Peter Maydell wrote:
> On Thu, 10 Oct 2024 at 18:39, Octavian Purdila <tavip@google.com> wrote:
> >
> > From: Valentin Ghita <valentinghita@google.com>
> >
> > Add option to allow for connecting device GPIOs. This is useful when
> > adding a peripheral device from the command line which uses an
> > interrupt.
> >
> > It takes the following options:
> >
> > * in-dev-path, out-dev-path - required, the device canonical object
> >   path (e.g. /machine/peripheral-anon/device[0],
> >   /machine/iotkit/cluster0/armv7m0) for the devices that should have
> >   their in <-> out GPIOs connected
> >
> > * in-gpio-name, out-gpio-name - optional, the name of the GPIO list;
> >   if not specified, the unnamed GPIO list is used
> >
> > * in-gpio-index, out-gpio-index - optional, the index in the GPIO list
> >   that identifies the GPIO to be used; if not specified 0 (the first
> >   GPIO in the list) is used
> >
> > Usage example:
> >
> >  # add the tmp105 sensor and connects its irq line to the CPU
> >  qemu-system-arm \
> >   --machine mps2-an505 \
> >   --device tmp105,bus=/versatile_i2c/i2c,address=0x50 \
> >   --connect-gpios out-dev-path=/machine/peripheral-anon/device[0],\
> >     in-dev-path=/machine/iotkit/cluster0/armv7m0,in-gpio-index=100
> 
> 
> This seems to be moving down the path towards "create and
> wire up machines on the command line". We shouldn't
> be doing that ad-hoc with one small commandline option
> at a time, we should be doing it with a coherent plan.

Yeah, as a general rule, adding new CLI args is pretty undesirable.
To avoid that we could utilize QOM for representing data:
eg a "gpio-connection" object:

  --object gpio-connection,out-dev-path=/machine/peripheral-anon/device[0],\
           in-dev-path=/machine/iotkit/cluster0/armv7m0,in-gpio-index=100

this would be OK if we're fine with some code somewhere that iterates
over the 'gpio-connection' object instances performing the wiring.

If we want this wiring done in the machine realization path though,
we would want to properties directly assocaited with the devices,
rather than via a side-loaded object.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


