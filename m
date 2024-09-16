Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBC2C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 10:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq90L-0003HY-SX; Mon, 16 Sep 2024 06:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sq90K-0003G5-Ck
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 06:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sq90I-0006IM-MY
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 06:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726482644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0AkE4/w6gKhvXVSui1WEwcbfu3Cq/oc/itmmIHFm8sA=;
 b=QPyfG5fvQzTi9WCKpfLxgB9XIffrVtRVUBC676rHws4AS6hpiw1inB+wMHejK+OFydYoTV
 0Nnug/k3MRM82Fys5D6FJOlaZXZk8q143JKUwSYD3Ocpn3CnP37IWkl27etbIgk+5MIlz2
 cS4ldWfOYHLHUgy2RLxdYX/qSfI/Rr4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-H5JUb8bROOyP4Go2Rr0Krg-1; Mon,
 16 Sep 2024 06:30:43 -0400
X-MC-Unique: H5JUb8bROOyP4Go2Rr0Krg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D82041956083; Mon, 16 Sep 2024 10:30:41 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.121])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98203195605A; Mon, 16 Sep 2024 10:30:38 +0000 (UTC)
Date: Mon, 16 Sep 2024 12:30:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Michal Privoznik <mprivozn@redhat.com>
Subject: Re: -chardev with a JSON argument (was: [PATCH] chardev: introduce
 'reconnect-ms' and deprecate 'reconnect')
Message-ID: <ZugIzLK6UKkRRw-1@redhat.com>
References: <20240904051913.53148-1-d-tatianin@yandex-team.ru>
 <ZthCn1ze3oUXbR3K@angien.pipo.sk> <87a5gavd6r.fsf_-_@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5gavd6r.fsf_-_@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 14.09.2024 um 10:42 hat Markus Armbruster geschrieben:
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
> 
> How badly do you want it?

I suppose even my old patches to fully QAPIfy -chardev could be revived,
which would not only add JSON support, but also make sure that
everything that works in JSON also works with keyval syntax, both ways
stay in sync in the future and that you can access non-scalar options
without JSON:

https://repo.or.cz/qemu/kevin.git/shortlog/refs/tags/qapi-alias-chardev-v4

Without QAPI aliases, they will have to contain some ugly code to do the
compatibility conversion, but whatever can be generated can also be
written manually...

Kevin


