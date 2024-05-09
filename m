Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02008C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 14:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s54vw-0006kK-6o; Thu, 09 May 2024 10:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s54vu-0006jr-El
 for qemu-devel@nongnu.org; Thu, 09 May 2024 10:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s54vl-0007r6-OX
 for qemu-devel@nongnu.org; Thu, 09 May 2024 10:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715265572;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqBjtWmAXGIf1xZK1tR3gw9ucmdTyfAwlqRToX1QtVI=;
 b=RQfruDDXQdcLxDboHBpy+TLHnuQ/sU8sYdnZjhfh5oJD8khaXWEcHMeI21G2tRui3AH+bw
 XdGCszRmd4Fwl53wbpqR1KlYOAsHV5ONjBq9k0CGvnTsh5onpMS18MD/+xrbzeS2gjQGt/
 0pv96GS4I2gQZt4l42MnQBcb4ATn//Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-PV2F2NTUN46BT5MOYXS82A-1; Thu, 09 May 2024 10:39:28 -0400
X-MC-Unique: PV2F2NTUN46BT5MOYXS82A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88C54801211;
 Thu,  9 May 2024 14:39:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 631B91D43C12;
 Thu,  9 May 2024 14:39:23 +0000 (UTC)
Date: Thu, 9 May 2024 15:39:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clegoate@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH 01/14] include/hw: add helpers for defining versioned
 machine types
Message-ID: <ZjzgGZYnJbB0nO1A@redhat.com>
References: <20240501182759.2934195-1-berrange@redhat.com>
 <20240501182759.2934195-2-berrange@redhat.com>
 <07cdc5df-781d-4833-9092-af3ef520dbed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07cdc5df-781d-4833-9092-af3ef520dbed@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 02, 2024 at 12:34:49PM +0200, Thomas Huth wrote:
> On 01/05/2024 20.27, Daniel P. Berrangé wrote:
> > The various targets which define versioned machine types have
> > a bunch of obfuscated macro code for defining unique function
> > and variable names using string concatenation.
> > 
> > This addes a couple of helpers to improve the clarity of such
> > code macro.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   include/hw/boards.h | 166 ++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 166 insertions(+)
> > 
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 2fa800f11a..47ca450fca 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -414,6 +414,172 @@ struct MachineState {
> >       struct NumaState *numa_state;
> >   };
> > +/*
> > + * The macros which follow are intended to facilitate the
> > + * definition of versioned machine types, using a somewhat
> > + * similar pattern across targets:
> 
> I'd suggest to add a sentence at the end saying something like this: "For
> example, to create the macro for setting up a versioned "virt" machine could
> look like this:" (otherwise it's not immediately clear whether the example
> is about only the "macros which follow" or whether it's about how to set up
> a machine type)

Yes, will do

> 
> > + *  #define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
> > + *      static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
> > + *          ObjectClass *oc, \
> > + *          void *data) \

> > + *  #define DEFINE_VIRT_MACHINE_TAGGED(major, minor, micro, tag) \
> > + *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, micro, _, tag)
> > + */
> 
> I'd suggest to add a separate comment for the macro below, explaining that
> it is supposed to be used with __VA_ARGS__ to pick a certain other macro
> depending on the amount of entries in __VA_ARGS__.

Yep, Eric had the same suggestion

> 
> > +#define _MACHINE_VER_PICK(x1, x2, x3, x4, x5, x6, ...) x6
> > +
> > +/*
> > + * Construct a human targetted machine version string.
> 
> s/targetted/targeted/ according to my spell checker ?
> 
> Apart from the nits:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
>  Thomas
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


