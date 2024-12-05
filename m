Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F976E77178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFD5-0000iR-JM; Thu, 05 Dec 2024 12:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJFD0-0000gZ-9C
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:00:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJFCw-0005f3-CI
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733418003;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTd6+57AMejhmKvvR7t55BcOCchCn6u7T83zktedzuA=;
 b=bA8yIjhCQ/jGAN0qzj0NvtTipz2oFHv1dEMiAOvnPaxetzvTkD7mOaW2QkW4tIhq5dy0IQ
 QUs99n9XaPxsgZCF4GfpZws4KiX0oN98iloXhNBo2pzOuaqYIyDo+zM7eBnqv5Uh9Jjr/r
 BMKxWrXtTybx4Twpd+4FrKHcgsjV8d4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-giUozIO8NCK5rJ_ROfOmCA-1; Thu,
 05 Dec 2024 12:00:00 -0500
X-MC-Unique: giUozIO8NCK5rJ_ROfOmCA-1
X-Mimecast-MFC-AGG-ID: giUozIO8NCK5rJ_ROfOmCA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E66C1954213; Thu,  5 Dec 2024 16:59:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB63E1956095; Thu,  5 Dec 2024 16:59:55 +0000 (UTC)
Date: Thu, 5 Dec 2024 16:59:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Keesler <ankeesler@google.com>
Cc: Roque Arcudia Hernandez <roqueh@google.com>, mst@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 venture@google.com, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/2] hw/display: Allow injection of virtio-gpu EDID name
Message-ID: <Z1HcCOG6cqDWNNW5@redhat.com>
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-3-roqueh@google.com>
 <Z0RnuVKPHO1T2BfV@redhat.com>
 <CAGZECHOTT1bs0frj-QDyRtudFNb+VzD4tZsnk4Fj=Q0OH+1v3Q@mail.gmail.com>
 <Z0XxYpvj49colIIy@redhat.com>
 <CAGZECHMEYjL56AZebqOK4dTgQbLtwA=9=yZ0qi0ymSpMS2x7Gw@mail.gmail.com>
 <CAGZECHO0HmkM+zPudFKU-dYZi9LqhfgVqaONn09DRW07sNkLVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZECHO0HmkM+zPudFKU-dYZi9LqhfgVqaONn09DRW07sNkLVg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

CC Markus to keep me honest in my comments below

On Mon, Dec 02, 2024 at 03:31:53PM -0500, Andrew Keesler wrote:
> Hi again Daniel. I have a follow up question. Can you help me
> understand how I can declare this "outputs" property?
> 
>    -device '{"driver":"virtio-vga",
>              "max_outputs":2,
>              "id":"vga",
>              "outputs":[
>                {
>                   "name":"AAA",
>                },
>                {
>                   "name":"BBB",
>                },
>              ]}'
> 
> I thought DEFINE_PROP_ARRAY would do it, but I can't tell what PropertyInfo
> implementation I should pass. All of the PropertyInfo implementations I can
> find use scalar types, or simple text decoding. I am wondering if I am
> missing
> some sort of "JSON" encoding capabilities that can happen behind the scenes.

I could have sworn we had an example of how to handle this already,
but I'm not finding any Device class with a non-scalar property
that isn't merely an array of scalars.

We definitely have some examples elsewhere for exmaple "Machine" class
has an SmpCacheProperties array property, and the QAuthZList class
has an array of "QAuthZListRule" property.

In both cases the struct is defined in th qapi/<blah>.json, which
auto-generates code eg visit_type_QAuthZListRuleList, which can
then get called from qauthz_list_prop_get_rules and
qauthz_list_prop_set_rules, for the property.

Devices use a slightly higher level wrapper so instead of calling
object_class_property_add directly, then define the PropertyInfo
and object_class_property_add gets called indirectly for them.
I'm thinking it should still be possible to use the QAPI code
generator to help though. You could either just define the struct,
and thn use that to create  PropertyInfo to be used in combination
with DEFINE_PROP_ARRAY, of you could define a list of structs at
the QAPI level and use plain DEFINE_PROP. I guess the former is
probably better aligned with other Device code.

> 
> On Tue, Nov 26, 2024 at 4:07 PM Andrew Keesler <ankeesler@google.com> wrote:
> 
> > Thanks, Daniel. We'll get this patch updated and send it out again.
> >
> > > it makes sense to allow for a data structure
> >
> > Whoops, I misread your original message - data structure SGTM.
> >
> > On Tue, Nov 26, 2024 at 11:04 AM Daniel P. Berrangé <berrange@redhat.com>
> > wrote:
> >
> >> On Mon, Nov 25, 2024 at 03:54:40PM -0500, Andrew Keesler wrote:
> >> > I follow what you are saying. I misunderstood what a "display" was in
> >> the
> >> > domain of QEMU. Yes, this makes more sense now.
> >> >
> >> > > the user should give names for every output at startup
> >> >
> >> > I see DEFINE_PROP_ARRAY exists. I can use that to define the new
> >> "outputs"
> >> > property. Any reason that each "output" would ever need to be an object
> >> > (rather than just a string)? Nothing comes to mind, I'm just taking a
> >> second
> >> > to think about API forwards compatibility.
> >>
> >> Currently we have 'xres' and 'yres' properties set against the device
> >> for virtio-gpu.
> >>
> >> If we're going to extend  it to allow the name of each "output" head
> >> to be configured, it makes sense to allow for a data structure that
> >> will let us also cnofigure xres & yres per output.
> >>
> >> Hence, I thought it would make more sense to have an array of structs,
> >> rather than the simpler array of strings, which will let us set any
> >> amount of per-output config data we might want in future.
> >>
> >> NB, I'm not asking you to wire up support for xres/yres per output,
> >> just that we anticipate it as a possibility.
> >>
> >> > > upto whatever they said for "max_outputs"
> >> >
> >> > Where is the best place to perform this validation? I would imagine we
> >> would
> >> > want to fast-fail if the user provided more "outputs" than
> >> "max_outputs". I
> >> > can
> >> > perform the validation in virtio_gpu_base_get_features but that seems
> >> late.
> >>
> >> I'd suggest putting it in virtio_gpu_base_device_realize, as we already
> >> have code there to validate 'max_outputs" is within limits.
> >>
> >>
> >> With regards,
> >> Daniel
> >> --
> >> |: https://berrange.com      -o-
> >> https://www.flickr.com/photos/dberrange :|
> >> |: https://libvirt.org         -o-
> >> https://fstop138.berrange.com :|
> >> |: https://entangle-photo.org    -o-
> >> https://www.instagram.com/dberrange :|
> >>
> >>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


