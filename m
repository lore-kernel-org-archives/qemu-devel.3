Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5B3C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 08:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDJXo-0001nP-9c; Fri, 09 May 2025 04:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uDJXn-0001jX-4I
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uDJXk-0007dz-Qf
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746781039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DFccFotjZvoovq6O2ud6WMUIsIoX0HGYwyovQBan+k=;
 b=GulsrjEdxjvLiW9SfT1VyYYdEm+CmtIj4ieQ0awj+RuSnTe4XRUxwZ5uQlCn6cE4wjAt3x
 XOXyliUcl9Gz1flr1LMI+nrxaZAR3dEVVYlhSBU4NkvsZvSXs4SscOZB8Bxskh34ANqk4X
 k5b9N+GJTyhF0p0mOEIcDHPCVSEcyq4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-dIcxlrAbM-W33GATAWWOJw-1; Fri,
 09 May 2025 04:57:16 -0400
X-MC-Unique: dIcxlrAbM-W33GATAWWOJw-1
X-Mimecast-MFC-AGG-ID: dIcxlrAbM-W33GATAWWOJw_1746781035
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC71F1800875; Fri,  9 May 2025 08:57:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 462961955F24; Fri,  9 May 2025 08:57:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A6A6821E66C2; Fri, 09 May 2025 10:57:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Nabih Estefan <nabihestefan@google.com>,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  pbonzini@redhat.com,  Peter Foley
 <pefoley@google.com>
Subject: Re: [PATCH 1/2] util: fix msan findings in keyval
In-Reply-To: <aB207Rl-vZxfuJBM@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 9 May 2025 08:58:07 +0100")
References: <20250508222132.748479-1-nabihestefan@google.com>
 <20250508222132.748479-2-nabihestefan@google.com>
 <87cycibagm.fsf@pond.sub.org> <aB207Rl-vZxfuJBM@redhat.com>
Date: Fri, 09 May 2025 10:57:11 +0200
Message-ID: <87zffm6u1k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, May 09, 2025 at 07:48:57AM +0200, Markus Armbruster wrote:
>> Nabih Estefan <nabihestefan@google.com> writes:
>>=20
>> > From: Peter Foley <pefoley@google.com>
>> >
>> > e.g.
>> > I	2025-02-28 09:51:05.240071-0800		624	stream.go:47	qemu: Uninitialize=
d value was created by an allocation of 'key_in_cur.i' in the stack frame
>> > I	2025-02-28 09:51:05.240187-0800		624	stream.go:47	qemu: #0 0xaaaac49=
f489c in keyval_parse_one third_party/qemu/util/keyval.c:190:5
>> >
>> > Signed-off-by: Peter Foley <pefoley@google.com>
>> > Signed-off-by: Nabih Estefan <nabihestefan@google.com>
>> > ---
>> >  util/keyval.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/util/keyval.c b/util/keyval.c
>> > index a70629a481..f33c64079d 100644
>> > --- a/util/keyval.c
>> > +++ b/util/keyval.c
>> > @@ -187,7 +187,7 @@ static const char *keyval_parse_one(QDict *qdict, =
const char *params,
>> >  {
>> >      const char *key, *key_end, *val_end, *s, *end;
>> >      size_t len;
>> > -    char key_in_cur[128];
>> > +    char key_in_cur[128] =3D {};
>> >      QDict *cur;
>> >      int ret;
>> >      QObject *next;
>>=20
>> Prior review of Peter's patch concluded this must be false positive:
>> https://lore.kernel.org/qemu-devel/14168384-ecdb-4c05-8267-ac5ef1c46fe9@=
redhat.com/
>
> While I agree with Paolo's reasoning, I think it is still worth adding an
> explicit initializer, because it makes it easier for both humans and mach=
ines
> to reason about correctless.

I think the code is just fine as is.  But if we decide we want an
initializer to make things easier for casual readers / imperfect tools,
then let's use "", not {}, as I suggested in my review.

> To reinforce that we don't have an actual bug though, also note that qemu
> unconditionally builds with -ftrivial-auto-var-init=3Dzero. So if we happ=
en
> to forget any, it won't cause a bug in the common case of a zero-initiali=
zer.
>
> With regards,
> Daniel


