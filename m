Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DCFCF3199
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 07:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svtU1-0007Dc-G0; Wed, 02 Oct 2024 03:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svtTz-0007Cs-2l
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svtTw-0004qW-Qi
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727852947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hB9l9c6SCXWrXHsYfsw4wwepBmTjwMppQ4OHe5ue7k0=;
 b=fDJGEPq6i3eKPAb0dDcCOp5fGmkKyqqLR2FVVay/r6pS3OVoTYKwcHngDEHi/6wSRnzfke
 +gbdjVlyP2SGH0YzqPphRPyjbzh/Ay0Iu/ekscR64S4JU4DvdEVh1A81+e3OaYWy0CDgDM
 Mn/qudXAZOsaVBY7MD3eUttQ18yUyFU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-npchexhwNDi8FsYCAfI85A-1; Wed,
 02 Oct 2024 03:09:03 -0400
X-MC-Unique: npchexhwNDi8FsYCAfI85A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18C4D1955EE9; Wed,  2 Oct 2024 07:08:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8AA91956054; Wed,  2 Oct 2024 07:08:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F21421E6A28; Wed,  2 Oct 2024 09:08:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Hanna Reitz <hreitz@redhat.com>,  Christian
 Schoenebeck <qemu_oss@crudebyte.com>,  Fam Zheng <fam@euphon.net>,  Song
 Gao <gaosong@loongson.cn>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  qemu-block@nongnu.org,  Laurent Vivier
 <laurent@vivier.eu>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Greg Kurz
 <groug@kaod.org>,  Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>,
 Gerd Hoffmann
 <kraxel@redhat.com>,  Bin Meng <bmeng.cn@gmail.com>,  Fabiano Rosas
 <farosas@suse.de>,  Eric Blake <eblake@redhat.com>,  Hyman Huang
 <yong.huang@smartx.com>,  Kevin Wolf <kwolf@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  John Snow <jsnow@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Jesper Devantier <foss@defmacro.it>,
 Peter Xu <peterx@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>,  Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Yuval Shaia <yuval.shaia.ml@gmail.com>,  Bin Meng
 <bin.meng@windriver.com>
Subject: Re: [PATCH v3 21/22] qom/object: fix -Werror=maybe-uninitialized
In-Reply-To: <CAMxuvazAEQf5hCe5KcFuAU9y5MUrn0wY3sZwtcJxbQT0mvH=LA@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 2 Oct 2024
 11:00:13 +0400")
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-22-marcandre.lureau@redhat.com>
 <87wmir9g9p.fsf@pond.sub.org>
 <CAMxuvazAEQf5hCe5KcFuAU9y5MUrn0wY3sZwtcJxbQT0mvH=LA@mail.gmail.com>
Date: Wed, 02 Oct 2024 09:08:44 +0200
Message-ID: <87ploj7zib.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Wed, Oct 2, 2024 at 10:21=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:

[...]

>> Two ways to fix:
>>
>> 1. Find all callers that don't, and fix them.  Your first hunk is then
>>    superfluous.  Your second hunk fixes the one you already found.
>>
>
> Imho, that's not a good API, it's easy to get wrong.
>
>> 2. Change the contract so callers don't have to initialize.  Your second
>>    hunk is then superfluous.  The update to the contract is missing.
>>
>
> I prefer that it always set the variable. I also prefer that caller
> initializes variables. So all are good practices imho, even if it's a
> bit redundant.

Since you're doing the work to fix the bug, you get first dibs on how to
fix it :)

[...]


