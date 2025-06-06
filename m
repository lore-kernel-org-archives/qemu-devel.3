Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AE0C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 06:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNQXi-0005Er-Va; Fri, 06 Jun 2025 02:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uNQXf-0005Ei-DH
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uNQXc-0006aL-8K
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749191217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8ekoUVh48B72HWDXx44br8Zm2lb2dvBYRGkmjXnsig=;
 b=NPLm9uPVTYLFUHv7nz5zbcFNj7ieWjBxeQMKKcbak24pWIgXiyU4oC9zwIR5uzJ6woyGwe
 cEp97a9MIgJFOBJbRgyfJQaJynLxr9npUF+PfyhQY7/1BEHkVffztL/0UhzGoD1YXf/vkK
 J/mMrBn6J2mB77jsUSVsH35GAAatTpY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679--b9gZaEqO0mZ7l1D3qwY6w-1; Fri,
 06 Jun 2025 02:26:53 -0400
X-MC-Unique: -b9gZaEqO0mZ7l1D3qwY6w-1
X-Mimecast-MFC-AGG-ID: -b9gZaEqO0mZ7l1D3qwY6w_1749191212
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7D371801F0C; Fri,  6 Jun 2025 06:26:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 482091956053; Fri,  6 Jun 2025 06:26:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B42FA21E66C3; Fri, 06 Jun 2025 08:26:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Kevin Wolf
 <kwolf@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 2/3] docs: define policy limiting the inclusion of
 generated files
In-Reply-To: <aEGF1FVWyIWNVamw@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 5 Jun 2025 12:56:04 +0100")
References: <20250605105219.261925-1-armbru@redhat.com>
 <20250605105219.261925-3-armbru@redhat.com>
 <CAFEAcA-QPO4jPEs9ZbS3ed0LARe4caFnNC54zi=+XsFdS0Wz7g@mail.gmail.com>
 <aEGF1FVWyIWNVamw@redhat.com>
Date: Fri, 06 Jun 2025 08:26:37 +0200
Message-ID: <87qzzx9yhu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jun 05, 2025 at 12:38:09PM +0100, Peter Maydell wrote:
>> On Thu, 5 Jun 2025 at 11:52, Markus Armbruster <armbru@redhat.com> wrote:
>> > +At times contributors may use or create scripts/tools to generate an =
initial
>> > +boilerplate code template which is then filled in to produce the fina=
l patch.
>> > +The output of such a tool would still be considered the "preferred fo=
rmat",
>> > +since it is intended to be a foundation for further human authored ch=
anges.
>> > +Such tools are acceptable to use, provided they follow a deterministi=
c process
>> > +and there is clearly defined copyright and licensing for their output.
>>=20
>> For the case where there's a one-off generation step and then the
>> intent is purely human-authored changes from there onwards, why
>> do we care whether the tool followed a deterministic process or
>> not? As long as the copyright/licensing situation is clear and
>> the submitter has checked tha the generation is what they want,
>> what does determinism get us?
>
> The copyright/licensing is important, but it was trying to say
> more than that to limit the scenarios in which generated code
> would be contributed. I think determinism in the tool's operation
> is valuable, but probably not the key point to get across here.
>
> We don't want a free for all in hand editting and then contributnig
> any auto-generated content. We only want generated content included
> where it was explicitly intended that it serve as a "template" for
> human refinement.
>
> Determinisism in the sense that if a 2nd person used the same
> tool to auto-generate the base template for editting, they would
> be starting from the same place as the original contributior.
>
>> As a trivial example, this rules out a hacky one-off python
>> script that produces output by iterating through a hashtable
>> if you forgot to add a "sort" to that ordering to make it
>> deterministic.
>
> NB it is trying to say that the way the tool operates is determinstic,
> not that its output is neccessarily stable wrt things like sorting.
> ie you can rationalize about what the tool is going to emit, but.

I think the paragraph's purpose is to clarify "preferred format" is what
developers want to work with going forward even when the initial
contribution started with generated contents.

I think the "deterministic process" clause distracts from this.
Moreover, it feels largely redundant with the next patch's "Use of AI
content generators".  Scratch the clause?

  Such tools are acceptable to use, provided and there is clearly defined
  copyright and licensing for their output.


