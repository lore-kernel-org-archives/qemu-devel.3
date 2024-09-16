Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8690C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 06:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq5Bp-0002y2-Lm; Mon, 16 Sep 2024 02:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1sq5Bm-0002wl-5j
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 02:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1sq5Bk-0005Ye-8z
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 02:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726467977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WFRjqcL98o20Xh/F1275EMSEz8bJSA9nNQzbnly9H6A=;
 b=VIH1s920sGOlKIGrq8UhoegvZ81C0jLnd32eAE0DVcR2yXyHqjbXwBZ6Ept5tF7tA8Gk16
 P1qFvbZ0duNLJ7FzYO72+XbyV5BC5QogNgBODqNNJpaZ8RhxTUqnkPsogYL0gA1b9EBucI
 ML9pqj3cszSu976SZR4Ws6YsQuAxO6I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-Kbm0d7F0NCm2vHiJDVI6xg-1; Mon,
 16 Sep 2024 02:26:15 -0400
X-MC-Unique: Kbm0d7F0NCm2vHiJDVI6xg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C97241944ABF; Mon, 16 Sep 2024 06:26:14 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.5])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76D1D1955D44; Mon, 16 Sep 2024 06:26:11 +0000 (UTC)
Date: Mon, 16 Sep 2024 08:26:07 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Michal Privoznik <mprivozn@redhat.com>
Subject: Re: -chardev with a JSON argument (was: [PATCH] chardev: introduce
 'reconnect-ms' and deprecate 'reconnect')
Message-ID: <ZufPf1el2lCnI6UG@angien.pipo.sk>
References: <20240904051913.53148-1-d-tatianin@yandex-team.ru>
 <ZthCn1ze3oUXbR3K@angien.pipo.sk> <87a5gavd6r.fsf_-_@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5gavd6r.fsf_-_@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Sep 14, 2024 at 10:42:36 +0200, Markus Armbruster wrote:
> Peter Krempa <pkrempa@redhat.com> writes:
> 
> > This is a little off-topic:
> >
> > So I wanted to make libvirt use the new parameter to stay ahead
> > deprecation. I've applied this patch to qemu, dumped capabilities and
> > pretty much expected a bunch of test cases in libvirt fail as they'd be
> > using a deprecated field as libvirt is supposed to validate everything.
> >
> > And the test suite passed unexpectedly. I've dug further and noticed
> > that for some reason libvirt doesn't still use JSON parameters for
> > -chardev (which is the pre-requisite for validation).
> >
> > I've also noticed that at some point I attempted to convert it over
> > witnessed by having an (unused) capability named QEMU_CAPS_CHARDEV_JSON
> > that I've introduced.
> >
> > My questions are:
> > 1) Does '-chardev' accept JSON identical to 'chardev-add' QMP command?
> 
> Sadly, no.

Yeah, in the meanwhile I had a look and also remembered that we spoke
about why this was the case. (All the 'wrapper' objects making the
schema of 'chardev-add' extremely unpleasant)

> How badly do you want it?

So the main motivation is to have just one instance of the code
generating the config for qemu. As JSON has type information inside
libvirt always generates JSON internally first. This is the case for
-object, -device, -netdev, -blockdev, ...

For '-chardev' we currently (in tree) have two separate formatters for
'-chardev' and QMP 'chardev-add'. I do have a reasonalby looking rework
in the works which unifies them (with a few quirky  "if (commandline)"
blocks).

In cases when we need to support the old syntax for any reason we do
have a converter that takes JSON and outputs the qemuopts syntax. This
is possible for now as we have mostly flat structures and the only
difference for now is how the arrays are processed in -device vs -netdev
(by callbacks to the converter).

For -chardev this will require a bit more logic as we need to avoid the
extra wrappers for commandline output and few fields have different
names in QMP than on the commandline.

My main goal here is to achieve validation against the QMP schema, and
it's much easier for us to add test cases via XML than hardcoding them
in C.

So honestly I don't think we want it too badly. Definitely not so bad
that having it with bad design. I reckon that doing the refactor will
also simplify things for the future if the QMP design will be changed to
e.g. drop the wrappers.

> > If yes:
> 
> If we implemented it:
> 
> > 2) Since when can that be used? (What can I use as a witness)
> 
> I figure we'd provide a witness the same way we did when we added JSON
> support to -device: add a feature @json-cli to chardev-add.

Yup, that'll always work :)


> > 3) Are there any gotchas?
> 
> Not aware of any.  Can't be 100% sure until we try.
> 
> > I wonder this as I'd love to finish that out, but I really don't fancy
> > digging into qemu to find a gotcha 3/4 of the way there.
> 
> Understandable :)
> 
> > Anyways, as I've already stated, this patch is okay for libvirt, but I
> > didn't review the implementation, thus, on behalf of libvirt:
> >
> > ACKed-by: Peter Krempa <pkrempa@redhat.com>
> 
> Thanks!
> 


