Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4AAC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 12:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdIw-00019k-EQ; Fri, 21 Jun 2024 08:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sKdIg-0000gL-4G
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sKdId-0000Qp-Tv
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718972605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=90sKewTtPVHZxTATszNeNwdY7MR/Uv1GvewCMTsDv+I=;
 b=AzxdFgu3QHeNKgLfJH+p3aNaTWrkYkaDsUPVBB3xy4JtzZGfST8Gkq1gB0gppYvNaV5Qg4
 SLsNQtXXJPxGXdIlI/2/BIa/eA6/7NV4VYIj/1Jz42ZQtIgv0zI8qf5Ek7u+LKd0V6jThf
 5iIMR5s5/bsB8FxyXJKb7ZA2aNft73c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-VgF78OlpOo-VjbRGwmp4Ng-1; Fri,
 21 Jun 2024 08:23:21 -0400
X-MC-Unique: VgF78OlpOo-VjbRGwmp4Ng-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84DEC1956094; Fri, 21 Jun 2024 12:23:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D12541955E80; Fri, 21 Jun 2024 12:23:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCE0321E6621; Fri, 21 Jun 2024 14:23:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Victor Toso de Carvalho <victortoso@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Marcel
 Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Fabiano Rosas <farosas@suse.de>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Peter Xu <peterx@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>,  Jiri Pirko <jiri@resnulli.us>,  Alex
 Williamson <alex.williamson@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 09/13] qapi: convert "Note" sections to plain rST
In-Reply-To: <CAFn=p-abtycUzRefg8hdAENtdKMeeyEe0sMCEXee2Grn9i8PDw@mail.gmail.com>
 (John Snow's message of "Thu, 20 Jun 2024 14:44:58 -0400")
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-10-jsnow@redhat.com>
 <87wmmlyu64.fsf@pond.sub.org> <87iky3u47v.fsf@pond.sub.org>
 <CAFn=p-ZDQog-gS=oXPm2E+uQwa=AFodxP-TTCtLrXiOou3-McQ@mail.gmail.com>
 <CAFn=p-abtycUzRefg8hdAENtdKMeeyEe0sMCEXee2Grn9i8PDw@mail.gmail.com>
Date: Fri, 21 Jun 2024 14:23:14 +0200
Message-ID: <87v8221o3x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Thu, Jun 20, 2024 at 11:46=E2=80=AFAM John Snow <jsnow@redhat.com> wro=
te:
>
>>
>>
>> On Thu, Jun 20, 2024, 9:35=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>> > John Snow <jsnow@redhat.com> writes:
>>>
>>> [...]
>>>
>>> >> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>>> >> index b3de1fb6b3a..57598331c5c 100644
>>> >> --- a/qga/qapi-schema.json
>>> >> +++ b/qga/qapi-schema.json
>>>
>>> [...]
>>>
>>> >> @@ -631,8 +632,8 @@
>>> >>  # Errors:
>>> >>  #     - If hybrid suspend is not supported, Unsupported
>>> >>  #
>>> >> -# Notes: It's strongly recommended to issue the guest-sync command
>>> >> -#     before sending commands when the guest resumes
>>> >> +# .. note:: It's strongly recommended to issue the guest-sync comma=
nd
>>> >> +#    before sending commands when the guest resumes.
>>> >>  #
>>> >>  # Since: 1.1
>>> >>  ##
>>> >> @@ -1461,16 +1462,15 @@
>>> >>  #     * POSIX: as defined by os-release(5)
>>> >>  #     * Windows: contains string "server" or "client"
>>> >>  #
>>> >> -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
>>> >> -#     @version, @version-id, @variant and @variant-id follow the
>>> >> -#     definition specified in os-release(5). Refer to the manual pa=
ge
>>> >> -#     for exact description of the fields.  Their values are taken
>>> >> -#     from the os-release file.  If the file is not present in the
>>> >> -#     system, or the values are not present in the file, the fields
>>> >> -#     are not included.
>>> >> +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
>>> >> +#    @version, @version-id, @variant and @variant-id follow the
>>> >> +#    definition specified in os-release(5). Refer to the manual page
>>> for
>>> >> +#    exact description of the fields.  Their values are taken from =
the
>>> >> +#    os-release file.  If the file is not present in the system, or
>>> the
>>> >> +#    values are not present in the file, the fields are not include=
d.
>>> >>  #
>>> >> -#     On Windows the values are filled from information gathered fr=
om
>>> >> -#     the system.
>>> >> +#    On Windows the values are filled from information gathered from
>>> >> +#    the system.
>>> >
>>> > Please don't change the indentation here.  I get the same output with
>>> >
>>> >   @@ -1461,7 +1462,7 @@
>>> >    #     * POSIX: as defined by os-release(5)
>>> >    #     * Windows: contains string "server" or "client"
>>> >    #
>>> >   -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
>>> >   +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
>>> >    #     @version, @version-id, @variant and @variant-id follow the
>>> >    #     definition specified in os-release(5). Refer to the manual p=
age
>>> >    #     for exact description of the fields.  Their values are taken
>>>
>>> I'm blind.  Actually, you change indentation of subsequent lines from 4
>>> to 3 *everywhere*.  I guess you do that to make subsequent lines line up
>>> with the directive, here "note".
>>>
>>> Everywhere else, we indent such lines by 4.  Hmm.  How terrible would it
>>> be not to mess with the alignment?
>>>
>>> If we want to use 3 for directives, is it worth pointing out in the
>>> commit message?
>>>
>>> [...]
>>>
>>
>> Let me look up some conventions and see what's the most prominent... as
>> well as testing what emacs does by default (or if emacs can be configured
>> to do what we want with in-tree style config. Warning: I am functionally
>> inept at emacs lisp. Warning 2x: [neo]vi[m] users, you're entirely on yo=
ur
>> own. I'm sorry.)
>>
>> I use three myself by force of habit and have some mild reluctance to
>> respin for that reason, but ... guess we ought to be consistent if we ca=
n.
>>
>> (No idea where my habit came from. Maybe it is just because it looks nice
>> to me and no other reason.)
>>
>> ((I have no plans, nor desire, to write any kind of checker to enforce
>> this, though - sorry.))
>>
>
> Sphinx doc uses three spaces:
> https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#d=
irectives
>
> ... but it warns that it's arbitrary; but it seems common to align with t=
he
> directive.
>
> *
> https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#footno=
tes
>    footnotes require "at least 3" spaces
>
> *
> https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#direct=
ives
>   directives are only required to be "indented" but the amount isn't
> specified. rst docs use three.
>
> I'm happy with three; I don't believe we need to make it consistent with
> e.g. our home-spun field list syntax (arguments, features) or with code
> blocks. I think whatever looks good in the source is fine, and I think
> three looks good for directives. I don't think we need to require this, b=
ut
> I can mention in the commit message that I chose it for the sake of
> aesthetics and for parity with what most rST docs appear to use.

My reason for four spaces is reducing churn.  To see by how much, I
redid your change.  I found a few more notes that don't start with a
capital letter, or don't end with a period.

Anyway, your diffstat:

 30 files changed, 266 insertions(+), 255 deletions(-)

Mine:

 30 files changed, 134 insertions(+), 119 deletions(-)

A fair bit easier to review.

> Note: emacs behavior for wrapping paragraphs in our QAPI files does not
> create an indent if there isn't already one. I think convincing emacs to
> apply rST rules inside of a JSON file we lie and call a Python file might
> be beyond my ability to do quickly.

Permit me a digression...

We have rST in comments.

Python has rST in doc strings.

JSON has neither comments nor doc strings, but since we use it just for
the file name extension, that's irrelevant.

Could Emacs help us more if we used Pythony doc strings instead of
comments?

End of digression.

> The default behavior for my emacs (which I haven't customized very much, =
if
> at all) in our source tree for *.rst files is to wrap directive lines with
> a three space indent.

Valid point.

> So, I'm happy saying this is a good way to do it.

If we decide to tweak indentation, we should do so in a separate patch
that does absolutely nothing but tweak indentation.


