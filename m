Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066FFC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 08:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJUZm-0001xx-Rx; Tue, 18 Jun 2024 04:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJUZk-0001ws-Th
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 04:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sJUZh-0005yq-8c
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 04:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718700740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X/wmm3mTVVIuP2VQMN2ZLr2pno8AYLh61gUw7Wn1BBY=;
 b=URV6fylMhBf4QbZPaBHP5wHtJS8R6ng3i33lMJmdoplba/tulSuDJyHmCc3ZxH0yGLbPh1
 dH+5lyJaYL+cdemqujcq32OVWMTCdvV291rOlD5OY6pEIUxfT6gOG72IeJ+mHfBf329gmO
 INQDj7il6Ey0QJFYX0dxDfC5ZqGYoFM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-thoBp1K3N12KqmEB7u0H8g-1; Tue,
 18 Jun 2024 04:52:13 -0400
X-MC-Unique: thoBp1K3N12KqmEB7u0H8g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E7D419560BC; Tue, 18 Jun 2024 08:52:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68A8A19560AE; Tue, 18 Jun 2024 08:52:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3892D21E66E5; Tue, 18 Jun 2024 10:52:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Ani Sinha <anisinha@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  Kevin Wolf <kwolf@redhat.com>,  Jiri Pirko
 <jiri@resnulli.us>,  Mads Ynddal <mads@ynddal.dk>,  Jason Wang
 <jasowang@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Qemu-block <qemu-block@nongnu.org>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Victor Toso de Carvalho
 <victortoso@redhat.com>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Konstantin Kostiuk
 <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,  Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 18/20] qapi: ensure all errors sections are uniformly
 typset
In-Reply-To: <CAFn=p-Y2BgKLx5gN2++DQ_dj_hQzfYLw=MGKwNEHB6vFWeh7GQ@mail.gmail.com>
 (John Snow's message of "Mon, 17 Jun 2024 13:56:36 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-19-jsnow@redhat.com>
 <87a5jn3gyd.fsf@pond.sub.org>
 <CAFn=p-Y2BgKLx5gN2++DQ_dj_hQzfYLw=MGKwNEHB6vFWeh7GQ@mail.gmail.com>
Date: Tue, 18 Jun 2024 10:52:06 +0200
Message-ID: <87bk3yab0p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> On Fri, Jun 14, 2024, 7:24=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Transactions have the only instance of an Errors section that isn't a
>> > rST list; turn it into one.
>>
>> Just for consistency?  Or do you have other shenanigans up your sleeve?
>
> Just consistency at this precise moment in time, but it's *possible* I may
> introduce shenanigans for visual consistency in the rendered output, for
> which having a uniform format would make mechanical conversions in the
> generator easier/possible.
>
> It's an idea I had but didn't implement yet. I figured I'd write this pat=
ch
> anyway because it isn't wrong, and you yourself seemed to believe it would
> *always* be a RST list, when that isn't strictly true.
>
>
>> If we want the Errors sections to remain all rST lists, we should update
>> docs/devel/qapi-code-gen.rst to say so.
>>
>
> OK, will do.

With such an update, we could perhaps sell the patch like

    qapi: Nail down convention that Errors sections are lists

    By unstated convention, Errors sections are rST lists.  Document the
    convention, and make the one exception conform.

>
>
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>>


