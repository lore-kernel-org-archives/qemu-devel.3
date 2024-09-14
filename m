Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68065C02180
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 08:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spOMg-0008NU-9c; Sat, 14 Sep 2024 04:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1spOMe-0008Mj-Ut
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 04:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1spOMd-0008NT-Fm
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 04:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726303361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n6b8rmZh0qWb+kF5JhF18ad5k+0IAbpfyA4m5zpZ3+M=;
 b=Q2XdYVtO/EmlDF9GiLUFVE8c6OpiTaaE9iBrSy332cRoj/KQ4phwvh/RQwi/2e5LVbF9Gk
 6BuxEY08gOF+iV2MUpDc/k/RUNV/+dPuTOGydSAdJxsToKoa9JDeu8kBu/oQY43uhEsAbf
 QON2BRZiycJjuxQhtHjUhi3nkmp8x0Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-03fqg81WMQCgd4FifNFjPw-1; Sat,
 14 Sep 2024 04:42:40 -0400
X-MC-Unique: 03fqg81WMQCgd4FifNFjPw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E7BB1956048; Sat, 14 Sep 2024 08:42:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A74F1956053; Sat, 14 Sep 2024 08:42:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3FA9A21E6A28; Sat, 14 Sep 2024 10:42:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  qemu-devel@nongnu.org,
 devel@lists.libvirt.org,  Michal Privoznik <mprivozn@redhat.com>
Subject: -chardev with a JSON argument (was: [PATCH] chardev: introduce
 'reconnect-ms' and deprecate 'reconnect')
In-Reply-To: <ZthCn1ze3oUXbR3K@angien.pipo.sk> (Peter Krempa's message of
 "Wed, 4 Sep 2024 13:21:03 +0200")
References: <20240904051913.53148-1-d-tatianin@yandex-team.ru>
 <ZthCn1ze3oUXbR3K@angien.pipo.sk>
Date: Sat, 14 Sep 2024 10:42:36 +0200
Message-ID: <87a5gavd6r.fsf_-_@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Krempa <pkrempa@redhat.com> writes:

> This is a little off-topic:
>
> So I wanted to make libvirt use the new parameter to stay ahead
> deprecation. I've applied this patch to qemu, dumped capabilities and
> pretty much expected a bunch of test cases in libvirt fail as they'd be
> using a deprecated field as libvirt is supposed to validate everything.
>
> And the test suite passed unexpectedly. I've dug further and noticed
> that for some reason libvirt doesn't still use JSON parameters for
> -chardev (which is the pre-requisite for validation).
>
> I've also noticed that at some point I attempted to convert it over
> witnessed by having an (unused) capability named QEMU_CAPS_CHARDEV_JSON
> that I've introduced.
>
> My questions are:
> 1) Does '-chardev' accept JSON identical to 'chardev-add' QMP command?

Sadly, no.

How badly do you want it?

> If yes:

If we implemented it:

> 2) Since when can that be used? (What can I use as a witness)

I figure we'd provide a witness the same way we did when we added JSON
support to -device: add a feature @json-cli to chardev-add.

> 3) Are there any gotchas?

Not aware of any.  Can't be 100% sure until we try.

> I wonder this as I'd love to finish that out, but I really don't fancy
> digging into qemu to find a gotcha 3/4 of the way there.

Understandable :)

> Anyways, as I've already stated, this patch is okay for libvirt, but I
> didn't review the implementation, thus, on behalf of libvirt:
>
> ACKed-by: Peter Krempa <pkrempa@redhat.com>

Thanks!


