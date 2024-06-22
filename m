Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEEEC27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 08:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKwUR-0004Ou-Mk; Sat, 22 Jun 2024 04:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sKwUQ-0004OK-88
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 04:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sKwUO-00015m-Ms
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 04:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719046371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLD3XLy5OojFeqixFFEUzXEAhWbeaDSmpS5m4WB6c9w=;
 b=OV9B+EaFAqsqTeVPT3XmovSndwLAWCgWXuvmOfRM+UoFZ6ivA/6zXT7B4USrNgEz++lOqk
 v/mxonj5c19ax0SiEPjdUcoVQghP6UDmzd2/Kmza3FN1upImb8wIax858y0Rj2hpjbPmF8
 j91Le4Cfc/Zsc9kolsaCrjEgRZuxTRg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-YQCD5xCzMveE29bKvrK90Q-1; Sat,
 22 Jun 2024 04:52:47 -0400
X-MC-Unique: YQCD5xCzMveE29bKvrK90Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36DFB19560AE; Sat, 22 Jun 2024 08:52:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1261919560AA; Sat, 22 Jun 2024 08:52:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C47DB21E6687; Sat, 22 Jun 2024 10:52:41 +0200 (CEST)
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
In-Reply-To: <CAFn=p-bsEzEr6Ww11gtoBws1LqSHTPmch4O7osOqg45=CtejPw@mail.gmail.com>
 (John Snow's message of "Fri, 21 Jun 2024 13:41:43 -0400")
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-10-jsnow@redhat.com>
 <87wmmlyu64.fsf@pond.sub.org> <87iky3u47v.fsf@pond.sub.org>
 <CAFn=p-ZDQog-gS=oXPm2E+uQwa=AFodxP-TTCtLrXiOou3-McQ@mail.gmail.com>
 <CAFn=p-abtycUzRefg8hdAENtdKMeeyEe0sMCEXee2Grn9i8PDw@mail.gmail.com>
 <87v8221o3x.fsf@pond.sub.org>
 <CAFn=p-bsEzEr6Ww11gtoBws1LqSHTPmch4O7osOqg45=CtejPw@mail.gmail.com>
Date: Sat, 22 Jun 2024 10:52:41 +0200
Message-ID: <8734p5xsti.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

> On Fri, Jun 21, 2024 at 8:23=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:

[...]

>> My reason for four spaces is reducing churn.  To see by how much, I
>> redid your change.  I found a few more notes that don't start with a
>> capital letter, or don't end with a period.
>>
>
> ^ Guess I'll re-audit for v2. Hang on to the list of cases you found.

Happy to share my patch.

> (Sorry for the churn, though. I obviously don't mind it as much as you do,
> but I suspect I'm a lot less nimble with fiddling through git history than
> you are and find the value of avoiding churn to be ... lower than you do,
> in general. Respecting reviewer time is a strong argument, I apologize th=
at
> some non-mechanical changes snuck into the patch. The downside of hacking
> together a very large series.)

You did a good job splitting it up.  Minor mistakes are bound to happen.
Got to give the reviewer soemthing to find ;)

[...]


