Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CB9FA3733
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 08:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp27j-0000QS-1T; Fri, 13 Sep 2024 04:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp27h-0000NT-Bh
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 04:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp27f-0001NS-8t
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 04:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726217865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qEWPfxyl/Wg368+O8j5AuGhKD3BGPp0deHiiUgX3kUU=;
 b=ejrbCD9Bqm2tCDGjZ8SD9S8erHLVeobK+Lwmu1LwJGUQFbA9/og6tz3i6duZZwao74opDu
 vsV5bofQj7aXAL9VGVzANCo9/MCrhvBzNiZvc6SVc6Ep5GenyTDh+j3FKRNtVgqiI1eX/W
 uJ+Yh9tuMjqHr6YUhp8EV4ptFFfupoM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-kzhX7OY_PIiidF9ees1Qug-1; Fri,
 13 Sep 2024 04:57:44 -0400
X-MC-Unique: kzhX7OY_PIiidF9ees1Qug-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D99D01955DC4; Fri, 13 Sep 2024 08:57:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E609019560A3; Fri, 13 Sep 2024 08:57:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B124721E6A28; Fri, 13 Sep 2024 10:57:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org,  devel@lists.libvirt.org,  Peter Krempa
 <pkrempa@redhat.com>,  Michal Privoznik <mprivozn@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v1] chardev: introduce 'reconnect-ms' and deprecate
 'reconnect'
In-Reply-To: <20240905085703.106156-1-d-tatianin@yandex-team.ru> (Daniil
 Tatianin's message of "Thu, 5 Sep 2024 11:57:03 +0300")
References: <20240905085703.106156-1-d-tatianin@yandex-team.ru>
Date: Fri, 13 Sep 2024 10:57:39 +0200
Message-ID: <87plp80w3g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

Daniil Tatianin <d-tatianin@yandex-team.ru> writes:

> The 'reconnect' option only allows to specify the time in seconds,
> which is way too long for certain workflows.
>
> We have a lightweight disk backend server, which takes about 20ms to
> live update, but due to this limitation in QEMU, previously the guest
> disk controller would hang for one second because it would take this
> long for QEMU to reinitialize the socket connection.
>
> Introduce a new option called 'reconnect-ms', which is the same as
> 'reconnect', except the value is treated as milliseconds. These are
> mutually exclusive and specifying both results in an error.

Good:

    $ upstream-qemu -nodefaults -chardev socket,id=chr0,path=test-hmp,server=off,reconnect=1,reconnect-ms=2
    upstream-qemu: -chardev socket,id=chr0,path=test-hmp,server=off,reconnect=1,reconnect-ms=2: 'reconnect' and 'reconnect-ms' are mutually exclusive

Bad:

    $ upstream-qemu -nodefaults -S -display none -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 9}, "package": "v9.1.0-211-ga0866249bd"}, "capabilities": ["oob"]}}
    {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
    {"return": {}}
    {"execute":"chardev-add", "arguments": {"id":"chr0", "backend": {"type": "socket", "data": {"server": false, "addr": {"type": "unix", "data": {"path": "xyz"}}, "reconnect": 1, "reconnect-ms": 2}}}}
    {"return": {}}
    upstream-qemu: Unable to connect character device chr0: Failed to connect to 'xyz': No such file or directory

We're not rejecting simultaneous use of @reconnect and @reconnect-ms
here.

Moreover, you somehow regressed the handling of the "unable to connect"
error.  Before the patch, behavior is correct:

    $ upstream-qemu -nodefaults -S -display none -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 9}, "package": "v9.1.0-210-g4b7ea33074"}, "capabilities": ["oob"]}}
    {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
    {"return": {}}
    {"execute":"chardev-add", "arguments": {"id":"chr0", "backend": {"type": "socket", "data": {"server": false, "addr": {"type": "unix", "data": {"path": "xyz"}}}}}}
    {"error": {"class": "GenericError", "desc": "Failed to add chardev 'chr0': Failed to connect to 'xyz': No such file or directory"}}

> 'reconnect' is also deprecated by this commit to make it possible to
> remove it in the future as to not keep two options that control the
> same thing.
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Acked-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>


