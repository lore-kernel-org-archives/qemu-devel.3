Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD7FC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 13:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGfFR-0000S0-5e; Mon, 10 Jun 2024 09:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sGfFJ-0000Mv-GE
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 09:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sGfFH-0004Tj-7W
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 09:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718026772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Go28+kUQFS49dz/gLvHSNbkE7+S0iWgEq3ObQoXELfY=;
 b=KZX5CMuuYwTIqyeCkDwJstj96psdYsmtGO2LXcH1AYfe0FKlxVVEySQNls3WaVv0RpOZOz
 6WyQjadOz9ti5JUR3QVSuHlitvszdoURrwJe9Gi3M8t9mV24V8ir2djLjly+7eIoRlY1zS
 0PUt4NHNtXCNaXJcnPDjZFKpXgkzKNY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-lH3Aa9MQN4SZNIbVguicUw-1; Mon,
 10 Jun 2024 09:39:30 -0400
X-MC-Unique: lH3Aa9MQN4SZNIbVguicUw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F54B1956086
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 13:39:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F03DD1956089
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 13:39:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 827C121E66E5; Mon, 10 Jun 2024 15:39:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>,  Victor Toso <victortoso@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Andrea
 Bolognani <abologna@redhat.com>,  qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Historical QMP schema
In-Reply-To: <ZmblKThDo7PJG5Fh@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 10 Jun 2024 12:36:09 +0100")
References: <CAFn=p-bdoi1yDQTNhpzM=MP5s8Zm9zxuxbD-zPs_h_iA8C=mGg@mail.gmail.com>
 <ipebw5yv4l5joa54vk42rb2fmuykzvmjar7blcwiwstj5fwyuq@ycl4du6sb724>
 <CAFn=p-b9gLmAwLAjzf2RWA4JZuxVM-nnwETwQ44c8F0kOkReVg@mail.gmail.com>
 <ZmblKThDo7PJG5Fh@redhat.com>
Date: Mon, 10 Jun 2024 15:39:26 +0200
Message-ID: <87frtknchd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jun 06, 2024 at 01:22:14PM -0400, John Snow wrote:
>> On Thu, Jun 6, 2024 at 6:25=E2=80=AFAM Victor Toso <victortoso@redhat.co=
m> wrote:
>> > On Wed, Jun 05, 2024 at 11:47:53AM GMT, John Snow wrote:
>> Importantly, old versions of the schema aren't contained *entirely* with=
in
>> the schema. Here's a timeline:
>>=20
>> v0.12.0: QMP first introduced. Events are hardcoded, commands are defined
>> in qemu-monitor.hx. query commands are hard-coded in monitor.c.
>> v0.14.0: qemu-monitor.hx is forked into qmp-commands.hx and hmp-commands=
.hx
>> v1.0: First version which features qapi-schema.json; all query commands =
are
>> qapified but most other commands are not.
>> v1.1.0: A very large chunk of commands are QAPIfied.
>> v1.3.0: Most commands are now QAPIfied, but there are 2-3 remaining.
>> v2.1.0: events are now fully qapified; most are now defined in
>> qapi/events.json
>> v2.8.0: The remaining commands are fully qapified; qmp-commands.hx is
>> removed.
>
> v2.8.0 was in Dec 2016 - 7+1/2 years ago.
>
> libvirt's min QEMU version is 4.2.0 - Dec 2019
>
> Ther are non-libvirt consumers of QEMU, but for them, do we think it is
> reasonable for a consumer of QAPI *today*, to care about a QEMU version
> from almost 8 years ago ?
>
> IOW, I wonder if the most pragammatic answer to this problem is to simply
> entirely ignore the problems prior to 2.8.0 - accept that the versioning
> is inaccurate/incomplete for versions before 2.8.0

I'm in favour.  However, I'd prefer honest "Since: at least 2.8.0" to
"Since: <untrustworthy but irrelevant version <=3D 2.8.0>".


