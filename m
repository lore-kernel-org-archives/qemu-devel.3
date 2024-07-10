Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F5EC38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 04:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRP5R-0003Vv-J7; Wed, 10 Jul 2024 00:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sRP5Q-000372-6w
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 00:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sRP5I-000783-3y
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 00:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720586257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQwezOgR9jG5ll6Bczwz71a68RWi/irZdAxH7NI/Fkk=;
 b=ZvI2JXevn7K2GVIs6adHExvtSK1790qGHZI0jdoI0WL7q9eTnwoG+FUMk+XKvQiSHcReku
 mJLgQNjbCERoxwf+EfD6493YkeIxDtwmus10r27KdVHjw9HtB61hFCxWq4MHjCZTeF5dTT
 asEF1F1G5HF3WNu+tygY9IPSO9ZTcIw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-gcSH_zPGNWWXNsO3l777PA-1; Wed,
 10 Jul 2024 00:37:32 -0400
X-MC-Unique: gcSH_zPGNWWXNsO3l777PA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AA121956080; Wed, 10 Jul 2024 04:37:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E693B3000181; Wed, 10 Jul 2024 04:37:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F2E6021E6757; Wed, 10 Jul 2024 06:37:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  qemu-block@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Ani Sinha <anisinha@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Alex Williamson
 <alex.williamson@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Jiri Pirko <jiri@resnulli.us>,  Harmonie Snow
 <harmonie@gmail.com>
Subject: Re: [PATCH 4/8] docs/sphinx: add CSS styling for qmp-example directive
In-Reply-To: <CAFn=p-bryJu2jNmg4t=j+n7NeN7D+3b27kJAS7LZnT0UEE2kQg@mail.gmail.com>
 (John Snow's message of "Tue, 9 Jul 2024 18:55:55 -0400")
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-5-jsnow@redhat.com>
 <874j8yj1m7.fsf@pond.sub.org>
 <CAFn=p-bryJu2jNmg4t=j+n7NeN7D+3b27kJAS7LZnT0UEE2kQg@mail.gmail.com>
Date: Wed, 10 Jul 2024 06:37:25 +0200
Message-ID: <874j8xc16i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

John Snow <jsnow@redhat.com> writes:

> On Tue, Jul 9, 2024 at 6:34=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > From: Harmonie Snow <harmonie@gmail.com>
>> >
>> > Add CSS styling for qmp-example directives to increase readability and
>> > consistently style all example blocks.
>> >
>> > Signed-off-by: Harmonie Snow <harmonie@gmail.com>
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> Same sadness as for the previous patch.
>>
>
> Should we do anything about that? In the long run, I don't expect anyone
> will actually need to care about what this directive looked like in some
> intermediate state before we ever used it. If you want to evaluate the
> directive in the in-between states, I recommend modifying a document and
> seeing what it does; but I didn't really intend for anyone to really see =
it
> that way.
>
> (Isn't it a bit overboard to write unit tests for intermediate tree
> states...?)

I'm not asking for temporary tests, I just wonder why you delay
permanent ones until "[PATCH 8/8] qapi: remove "Example" doc section".

No big deal, thus:

>> Acked-by: Markus Armbruster <armbru@redhat.com>


