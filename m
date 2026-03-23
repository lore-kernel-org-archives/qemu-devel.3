Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B2DEC01A4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4bFg-0001Zr-G6; Mon, 23 Mar 2026 05:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4bFe-0001ZZ-SY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4bFd-00052Q-3F
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774256827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwlSV7ID5ZDJW1lFZtg7iwvAPJu0eckexZBdCy+xKGY=;
 b=SqN9UhXZC1uhI4mWhsp50rg8KGeqEJe0ppUEb2oF4mT3lZ+ZFf3dnDHFHFf1o70rhehh+F
 7IExBUQH/T8vnR4dtszKDDzCz8MdM80nGb7kYbhIxUPt6uK0+UpJekeaQewjr91VegrsVO
 GHibcFEem5CIrrZ9bH2LYqGqdyCyMs4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-aYYeZ7eYOxGzZcvGwLyK2w-1; Mon,
 23 Mar 2026 05:07:04 -0400
X-MC-Unique: aYYeZ7eYOxGzZcvGwLyK2w-1
X-Mimecast-MFC-AGG-ID: aYYeZ7eYOxGzZcvGwLyK2w_1774256822
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60C5218E5D20; Mon, 23 Mar 2026 08:56:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FF221955D71; Mon, 23 Mar 2026 08:56:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 188E121E6937; Mon, 23 Mar 2026 09:56:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Jason Wang <jasowang@redhat.com>,  Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Qemu-block <qemu-block@nongnu.org>,  =?utf-8?Q?Marc-An?=
 =?utf-8?Q?dr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Alex Williamson <alex@shazbot.org>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Yanan
 Wang <wangyanan55@huawei.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 6/8] qapi: enforce doc block section ordering
In-Reply-To: <CAFn=p-Zp47T=iWRAT=zRD1ZOqGBP8fpYi0D1awbQ7qU=Oz7VLA@mail.gmail.com>
 (John Snow's message of "Fri, 20 Mar 2026 14:28:51 -0400")
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-7-jsnow@redhat.com>
 <874ima613c.fsf@pond.sub.org>
 <CAFn=p-Zp47T=iWRAT=zRD1ZOqGBP8fpYi0D1awbQ7qU=Oz7VLA@mail.gmail.com>
Date: Mon, 23 Mar 2026 09:56:20 +0100
Message-ID: <87ikamzzyj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On Fri, Mar 20, 2026, 10:13=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Ugly hack, gets the job done. Likely many simplifications can be made =
as
>> > a result, but I didn't make any of them. There are some inconsistencies
>> > with human-readable vs ENUM_NAMES in error messages in this patch, but
>> > it appears to work anyway.
>> >
>> > Consider this patch more of a rough idea and not anything approximating
>> > the kind of code you'd want to see from an Enterprise Linux Senior
>> > Software Engineer.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/parser.py | 39 +++++++++++++++++++++++----------------
>> >  1 file changed, 23 insertions(+), 16 deletions(-)
>>
>> Missing: update to docs/devel/qapi-code-gen.rst.  Suggest to put in a
>> FIXME, so we don't forget.
>>
>
> ACK
>
>
>> Missing: test coverage.
>>
>
> Do we need to test every possible sequence, or just some characteristic
> examples...?

Let's start with characteristic examples.


