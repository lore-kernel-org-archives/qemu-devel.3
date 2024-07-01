Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B780C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 09:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOD4u-00052P-7G; Mon, 01 Jul 2024 05:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sOD4p-0004uN-2Q
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sOD4m-00082M-Vu
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719825115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7hT4n6ISKxZUyUm4JpCd0/MZTDDpRW1JeMoxr8sEd0=;
 b=IBR5X79jYr8lt2DQAlhxp1uOnK/264/o1cdsSAzxh61h6t7BF0HUH4BwyLrlk+3D4UBAtV
 +WXnj2uEQeL6UBBfTrFadthFFM8JXd0yXuj/AbQxFCY7XRIukiyLUxxHG7OPn3SqdXxTiG
 koIAukM3xy7CChVXV5eXEYDcLP38fPM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-CBMwClAlMR2rnxNujOo_Cg-1; Mon,
 01 Jul 2024 05:11:50 -0400
X-MC-Unique: CBMwClAlMR2rnxNujOo_Cg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 966A91955F36; Mon,  1 Jul 2024 09:11:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 370BD19560A3; Mon,  1 Jul 2024 09:11:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E2C7C21E668B; Mon,  1 Jul 2024 11:11:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  Mads Ynddal <mads@ynddal.dk>,  Jiri Pirko
 <jiri@resnulli.us>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Michael
 Roth <michael.roth@amd.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Victor Toso de Carvalho
 <victortoso@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Qemu-block
 <qemu-block@nongnu.org>,  Ani
 Sinha <anisinha@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Lukas Straub
 <lukasstraub2@web.de>,
 Igor Mammedov <imammedo@redhat.com>,  Jason Wang <jasowang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Hanna Reitz <hreitz@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH v2 07/21] docs/qapidoc: fix nested parsing under
 untagged sections
In-Reply-To: <CAFn=p-aPJact6oMq_yMqDwUhY2vmsAtPe4jt5U1FW300MrMEuQ@mail.gmail.com>
 (John Snow's message of "Fri, 28 Jun 2024 11:10:11 -0400")
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-8-jsnow@redhat.com>
 <87r0chzelz.fsf@pond.sub.org>
 <CAFn=p-aPJact6oMq_yMqDwUhY2vmsAtPe4jt5U1FW300MrMEuQ@mail.gmail.com>
Date: Mon, 01 Jul 2024 11:11:32 +0200
Message-ID: <87bk3htr23.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

> On Fri, Jun 28, 2024, 3:55=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Sphinx does not like sections without titles, because it wants to
>> > convert every section into a reference. When there is no title, it
>> > struggles to do this and transforms the tree inproperly.
>> >
>> > Depending on the rST used, this may result in an assertion error deep =
in
>> > the docutils HTMLWriter.
>> >
>> > (Observed when using ".. admonition:: Notes" under such a section - Wh=
en
>> > this is transformed with its own <title> element, Sphinx is fooled into
>> > believing this title belongs to the section and incorrect mutates the
>> > docutils tree, leading to errors during rendering time.)
>> >
>> > When parsing an untagged section (free paragraphs), skip making a holl=
ow
>> > section and instead append the parse results to the prior section.
>> >
>> > Many Bothans died to bring us this information.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > Acked-by: Markus Armbruster <armbru@redhat.com>
>>
>> Generated HTML changes, but the diff is hard to review due to id
>> attribute changes all over the place.
>>
>> Generated qemu-ga-ref.7 also changes:
>>
>>     diff -rup old/qemu-ga-ref.7 new/qemu-ga-ref.7
>>     --- old/qemu-ga-ref.7       2024-06-27 10:42:21.466096276 +0200
>>     +++ new/qemu-ga-ref.7       2024-06-27 10:45:36.502414099 +0200
>>     @@ -397,6 +397,7 @@ shutdown request, with no guarantee of s
>>      .B \fBmode\fP: \fBstring\fP (optional)
>>      \(dqhalt\(dq, \(dqpowerdown\(dq (default), or \(dqreboot\(dq
>>      .UNINDENT
>>     +.sp
>>      This command does NOT return a response on success.  Success
>>      condition is indicated by the VM exiting with a zero exit status or,
>>      when running with \-\-no\-shutdown, by issuing the query\-status QMP
>>     @@ -1348,6 +1349,7 @@ the new password entry string, base64 en
>>      .B \fBcrypted\fP: \fBboolean\fP
>>      true if password is already crypt()d, false if raw
>>      .UNINDENT
>>     +.sp
>>      If the \fBcrypted\fP flag is true, it is the caller\(aqs
>> responsibility to
>>      ensure the correct crypt() encryption scheme is used.  This command
>>      does not attempt to interpret or report on the encryption scheme.
>>
>> We add vertical space.  Visible when viewed with man.  Looks like an
>> improvement to me.
>>
>> Here's the first of these two spots in HTML:

[...]

>> The id changes muddy the waters.  With them manually removed:

[...]

>> Makes no visual difference in my browser.
>>
>> Do these differences match your expectations?
>>
>
> Yep!
>
> It does change the output just a little, but Sphinx really doesn't like
> title-less sections.
>
> I thought the change looked fine, and I'm still planning on removing this
> old generator anyway, so...

I'll add to the commit message

    The resulting output changes are basically invisible.

Thanks!


