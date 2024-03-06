Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A08C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoLl-0001hW-FH; Wed, 06 Mar 2024 05:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rhoLe-0001fd-0b
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:18:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rhoLc-00025S-Ha
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709720283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRbDNupEnpDI+vl4TMyHAcrjnklkCZFvz+xJfz8mUkM=;
 b=D3tCYg32r5Jm4s1lOve+qOkCzwMFrX/GlS11F8uljtc+x3rRVWNGLGvP/aFDiPOHbLgPk/
 TvOzKd+uorTWJqcobpItu2qunU0HVpBQt6lrgOf4N90+e1NB2loXoUcOeBiUb5PbiAAI3L
 v0CUKvj39HfA41FVelYoUoPOEGCtGVY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-3eWmcahYMDCCXY0EXrAe5Q-1; Wed, 06 Mar 2024 05:17:59 -0500
X-MC-Unique: 3eWmcahYMDCCXY0EXrAe5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39E7685530D;
 Wed,  6 Mar 2024 10:17:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 178681C05E1C;
 Wed,  6 Mar 2024 10:17:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 05BD821E6A24; Wed,  6 Mar 2024 11:17:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] char: Slightly better error reporting when chardev is
 in use
In-Reply-To: <CAJ+F1CKR1zy0S7iM8S0S78GZYt90+six48kgs36z+vJVhxdvng@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 6 Mar 2024
 12:20:03 +0400")
References: <20240306081505.2258405-1-armbru@redhat.com>
 <CAJ+F1CKR1zy0S7iM8S0S78GZYt90+six48kgs36z+vJVhxdvng@mail.gmail.com>
Date: Wed, 06 Mar 2024 11:17:58 +0100
Message-ID: <87r0gnzmsp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, Mar 6, 2024 at 12:15=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Both
>>
>>     $ qemu-system-x86_64 -chardev null,id=3Dchr0,mux=3Don -mon chardev=
=3Dchr0 -mon chardev=3Dchr0 -mon chardev=3Dchr0 -mon chardev=3Dchr0 -mon ch=
ardev=3Dchr0
>>
>> and
>>
>>     $ qemu-system-x86_64 -chardev null,id=3Dchr0 -mon chardev=3Dchr0 -mo=
n chardev=3Dchr0
>> fail with
>>
>>     qemu-system-x86_64: -mon chardev=3Dchr0: Device 'chr0' is in use
>>
>> Improve to
>>
>>     qemu-system-x86_64: -mon chardev=3Dchr0: too many uses of multiplexe=
d chardev 'chr0' (maximum is 4)
>>
>> and
>>
>>     qemu-system-x86_64: -mon chardev=3Dchr0: chardev 'chr0' is already i=
n use
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> lgtm
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!

[...]

> QERR_DEVICE_IN_USE is now left with a single user in blockdev.c. Is it wo=
rth it?

Nope, that one needs to go, too.  How to reproduce it isn't obvious to
me.  I'll figure it out.


