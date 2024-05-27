Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B770C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 11:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBYzr-0004ft-PZ; Mon, 27 May 2024 07:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYzo-0004fB-LO
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYzZ-0006dL-RB
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716811095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rw48Zu3zaZ8J5FSSO587eaRFLGioJH0nJNpiD5d9ip8=;
 b=SINzZ6YAAfv60vAz4QRtRwvu6HJ0nObYp8hwIjoJunH4vR6WeyeRSz5EP473eSbiJgNHzM
 J1PiPnxDVmRPIixbWnHyTFqFV+c+Z2VxOgpl5bAUrcyYtwZoSv210mo1QovWomxmpSjF0d
 Vog8YKpD3gyAV1S3n6Uz24qDUo+pHgA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-9zweu99VOMCmSeWc52iEsQ-1; Mon,
 27 May 2024 07:58:12 -0400
X-MC-Unique: 9zweu99VOMCmSeWc52iEsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A64929AA39D;
 Mon, 27 May 2024 11:58:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1739B40C6DAF;
 Mon, 27 May 2024 11:58:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CFF221E681D; Mon, 27 May 2024 13:58:09 +0200 (CEST)
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
Subject: Re: [PATCH 05/20] qapi/parser: adjust info location for doc body
 section
In-Reply-To: <CAFn=p-abjRbSvcHPSUorp80SZaf5Xwi89WtvhebXK_SRw3Cg4w@mail.gmail.com>
 (John Snow's message of "Thu, 16 May 2024 10:30:32 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-6-jsnow@redhat.com>
 <87a5kqpaaw.fsf@pond.sub.org>
 <CAFn=p-abjRbSvcHPSUorp80SZaf5Xwi89WtvhebXK_SRw3Cg4w@mail.gmail.com>
Date: Mon, 27 May 2024 13:58:09 +0200
Message-ID: <87a5kbcvqm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Thu, May 16, 2024, 1:58=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Instead of using the info object for the doc block as a whole, update
>> > the info pointer for each call to ensure_untagged_section when the
>> > existing section is otherwise empty. This way, Sphinx error information
>> > will match precisely to where the text actually starts.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/parser.py | 9 +++++++--
>> >  1 file changed, 7 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index 8cdd5334ec6..41b9319e5cb 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -662,8 +662,13 @@ def end(self) -> None:
>> >
>> >      def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
>> >          if self.all_sections and not self.all_sections[-1].tag:
>> > -            # extend current section
>> > -            self.all_sections[-1].text +=3D '\n'
>>
>> Before, we always append a newline.
>>
>> > +            section =3D self.all_sections[-1]
>> > +            # Section is empty so far; update info to start *here*.
>> > +            if not section.text:
>> > +                section.info =3D info
>> > +            else:
>> > +                # extend current section
>> > +                self.all_sections[-1].text +=3D '\n'
>>
>> Afterwards, we append it only when the section already has some text.
>>
>> The commit message claims the patch only adjusts section.info.  That's a
>> lie :)
>>
>
> Well. It wasn't intentional, so it wasn't a lie... it was just wrong :)
>
>
>> I believe the change makes no difference because .end() strips leading
>> and trailing newline.
>>
>> >              return
>> >          # start new section
>> >          section =3D self.Section(info)
>>
>> You could fix the commit message, but I think backing out the
>> no-difference change is easier.  The appended patch works in my testing.
>>
>> Next one.  Your patch changes the meaning of section.info.  Here's its
>> initialization:
>>
>>     class Section:
>>         # pylint: disable=3Dtoo-few-public-methods
>>         def __init__(self, info: QAPISourceInfo,
>>                      tag: Optional[str] =3D None):
>> --->        # section source info, i.e. where it begins
>>             self.info =3D info
>>             # section tag, if any ('Returns', '@name', ...)
>>             self.tag =3D tag
>>             # section text without tag
>>             self.text =3D ''
>>
>> The comment is now wrong.  Calls for a thorough review of .info's uses.
>>
>
> Hmm... Did I really change its meaning? I guess it's debatable what "where
> it begins" means. Does the tagless section start...
>
> ## <-- Here?
> # Hello! <-- Or here?
> ##
>
> I assert the *section* starts wherever the first line of text it contains
> starts. Nothing else makes any sense.
>
> There is value in recording where the doc block starts, but that's not a
> task for the *section* info.
>
> I don't think I understand your feedback.

This was before my vacation, and my memory is foggy, ...  I may have
gotten confused back then.  Let me have a fresh look now.

self.info gets initialized in Section.__init__() to whatever info it
gets passed.

Your patch makes .ensure_untagged_section() overwrite this Section.info
when it extends an untagged section that is still empty.  Hmmm.  I'd
prefer .info to remain constant after initialization.

I figure this overwrite can happen only when extenting the body section
QAPIDoc.__init__() creates.  In that case, it adjusts .info from
beginning of doc comment to first non-blank line.

Thoughts?

>> The alternative to changing .info's meaning is to add another member
>> with the meaning you need.  Then we have to review .info's uses to find
>> out which ones to switch to the new one.
>
>
>> Left for later.
>>
>>
>> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> index 8cdd5334ec..abeae1ca77 100644
>> --- a/scripts/qapi/parser.py
>> +++ b/scripts/qapi/parser.py
>> @@ -663,7 +663,10 @@ def end(self) -> None:
>>      def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
>>          if self.all_sections and not self.all_sections[-1].tag:
>>              # extend current section
>> -            self.all_sections[-1].text +=3D '\n'
>> +            section =3D self.all_sections[-1]
>> +            if not section.text:
>> +                section.info =3D info
>> +            section.text +=3D '\n'
>>              return
>>          # start new section
>>          section =3D self.Section(info)
>>
>>


