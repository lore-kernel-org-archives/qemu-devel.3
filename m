Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1654EC36008
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 06:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzUpm-0007Op-Tf; Tue, 01 Apr 2025 02:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tzUpV-0007Np-JE
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 02:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tzUpT-000855-Hr
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 02:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743487829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsRsWsNPPFlaXPAYaiRLjO/HkbHKsh6JYkJ5jIsP8T0=;
 b=cYTGRNh0p7jFQk1I2At0p8pitf9NSfzrQkkDdzc23uw8E/j2BLWbIg6t52MinDm+unSnmD
 RFKzR48vFytRT70opiet505IH5g1K8G1tWT2UT485zDiEbIYto6T+Gh+Uuw3WvnCdLW9yS
 7Ye23jS4y9z6zKp3AKKuZRHwhsQzobg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-uoyURwvyM1yf2mPk8IRmuQ-1; Tue,
 01 Apr 2025 02:10:24 -0400
X-MC-Unique: uoyURwvyM1yf2mPk8IRmuQ-1
X-Mimecast-MFC-AGG-ID: uoyURwvyM1yf2mPk8IRmuQ_1743487822
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27891180AF6C; Tue,  1 Apr 2025 06:10:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A392180B488; Tue,  1 Apr 2025 06:10:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 807B721E66C7; Tue, 01 Apr 2025 08:10:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowang@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Fabiano Rosas <farosas@suse.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Hanna Reitz
 <hreitz@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  qemu-trivial@nongnu.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 qemu-block@nongnu.org,  Lukas Straub <lukasstraub2@web.de>,  Jiri Pirko
 <jiri@resnulli.us>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Michael
 Tokarev <mjt@tls.msk.ru>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Laurent
 Vivier <laurent@vivier.eu>,  Zhenwei Pi <pizhenwei@bytedance.com>,  Eric
 Blake <eblake@redhat.com>,  Peter Xu <peterx@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Kevin Wolf
 <kwolf@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH v2 4/4] qapi: rephrase return docs to avoid type name
In-Reply-To: <CAFn=p-aUUHE+d1s2KjV6WF1FNwHAjrJEEG3LqB8F+5d3d4p5Gg@mail.gmail.com>
 (John Snow's message of "Mon, 31 Mar 2025 14:34:38 -0400")
References: <20250326195756.330817-1-jsnow@redhat.com>
 <20250326195756.330817-5-jsnow@redhat.com>
 <87jz89mu0m.fsf@pond.sub.org>
 <CAFn=p-aUUHE+d1s2KjV6WF1FNwHAjrJEEG3LqB8F+5d3d4p5Gg@mail.gmail.com>
Date: Tue, 01 Apr 2025 08:10:15 +0200
Message-ID: <8734es5s54.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Fri, Mar 28, 2025 at 4:36=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Well, I tried. Maybe not very hard. Sorry!
>>
>> No need to be sorry!  Kick-starting discussion with limited effort is
>> better than a big effort going into a direction that turns out to be
>> unwanted once we discuss it.
>>
>> Instead of just rephrasing Returns descriptions, I'd like us to consider
>> both Returns and intro.  See below for why.

[...]

> I think for cases where the doc block is short and we have a desire to
> merge "returns" and "intro", the intro makes the most sense if there isn't
> anything of particular value assigned to the return value to begin with.
>
> So, more or less, yeah: if semantics are partially duplicated between
> intro/returns, I'm in favor of putting it all in the intro and allowing
> transmogrifier generate the return type info.
>
> I don't think there's a good case to make for a doc block with no intro b=
ut
> a healthy paragraph in the returns section, that looks goofy.
>
> Of course: I think there are still circumstances where we'll want both the
> intro and the returns info explicitly labeled, when we have some
> information to document about the semantics of that return value.

Agreed.

[...]


