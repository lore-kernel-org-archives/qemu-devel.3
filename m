Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77200D4335C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91l1-0006Ax-4W; Thu, 07 Nov 2024 07:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t91kx-00061r-6G
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t91ku-0001kS-Lg
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730983015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMxqqp7EnppVyfiBTucn0ySbvrcSYkJ5TO0+EMwOTIY=;
 b=HXTk4i3kCdRSxFxDtFt6MqpBcINy/QIfF9hRI/dDzbFPk8yMGsUVFffgbQnAvjNQ8Z3q6B
 699sfk2jRpgDJEks5JK9XP2nKvHPHYwkW8lOGCV3WLoK5YJZ6ksdkGd4Zcl+CwgTorYCFi
 kgdckQ4Taa6y5fWlRyRX6BNVVH0pDlI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-p-kK28SzPT2po74POn_M3Q-1; Thu,
 07 Nov 2024 07:36:53 -0500
X-MC-Unique: p-kK28SzPT2po74POn_M3Q-1
X-Mimecast-MFC-AGG-ID: p-kK28SzPT2po74POn_M3Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFEFA19560B0
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2024 12:36:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EF681956054
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2024 12:36:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C80B321E6A28; Thu,  7 Nov 2024 13:36:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Victor Toso <victortoso@redhat.com>,  qemu-devel@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  John Snow <jsnow@redhat.com>,  Andrea Bolognani
 <abologna@redhat.com>
Subject: Re: [RFC PATCH v2 0/8] qapi: add generator for Golang interface
In-Reply-To: <ZyyZugciNAYmVjeP@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 7 Nov 2024 10:43:06 +0000")
References: <20220617121932.249381-1-victortoso@redhat.com>
 <ZyyZugciNAYmVjeP@redhat.com>
Date: Thu, 07 Nov 2024 13:36:49 +0100
Message-ID: <87r07njk4e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

> Bringing this thread back from the dead, since I had an in-person
> discussion on a key question below at KVM Forum this year and want
> to record it here.

[...]

> To recap the situation
>
>  * The license of the code generator itself does not determine the
>    license of the output generated code

For instance, GNU Bison is GPLv3+, but the parts the generator emits
(the parser skeleton) come with a special exception.

Such exceptions need to be granted by the copyright holder.  As long as
the code generating Go is not a derived work, the copyright holder
situation should be simple enough to make this practical.

>  * The license of the inputs to the code generator, may or may
>    not, determine the license of the output generated code depending
>    on use context
>
> The primary input to the code generator is the QAPI schema, which is part
> of QEMU and thus licensed GPL-2.0-or-later.
>
> The QAPI schema includes both the API definitions AND the API documentati=
on
> text.
>
> We can make the case that as the QEMU public interface, consuming the
> API definitions in the QAPI schema for the purpose of generating code
> is "fair use", and thus the output generated code does NOT need to
> match the GPL-2.0-or-later license of the QAPI schema. We can choose
> the code license, and a maximally permissive license looks appropriate.

Having this argument confirmed by an actual expert seems advisable.

> We want to have API documentation for the Golang bindings and the obvious
> way to achieve this is to copy the API docs from the QAPI schema into the
> Golang code. It is NOT reasonable to class such *direct copying* of docs
> "fair use".  IOW, copied docs will be under GPL-2.0-or-later.
>
> Thus if we pick MIT-0 for the Golang code, and copy across the QAPI docs,
> the resulting  Golang QAPI project code would be under a compound license
> term "MIT-0 AND GPL-2.0-or-later".
>
> The concern was that this will limit the ability of downstream
> applications to consume the Golang bindings, if they don't want their
> combined work to contain GPL-2.0-or-later.
>
> Ignoring whether this fear of GPL-2.0-or-later is sane or not,
> in retrospect I believe that this concern in fact has no legal
> basis.
>
> The license of a compiled application binary is the union of all
> the object files linked into it.
>
> Notice I said "Object file" there, **NOT** "Source file".
>
> This is the crucial distinction that makes the presense of
> GPL-2.0-or-later docs a non-issue from a licensing POV.
>
>
> When the compiler takes the "MIT-0 and GPL-2.0-or-later" license
> .go source file, and builds an object file, it will be discarding
> all the API documentation comments. IOW, all the parts that were
> under GPL-2.0-or-later are discarded. The only parts of the source
> file that get "compiled" are the Go language constructs which were
> MIT-0 licensed [1].
>
> IOW, we have a "MIT-0 and GPL-2.0-or-later" .go source file,
> and an "MIT-0" object file.
>
> Thus while there may be a human perception problem with the Golang
> bindings being "MIT-0 and GPL-2.0-or-later", there are no legal
> licensing limitations, as the combined work for a library or
> application linking the bindings will only contain the MIT-0 part.
>
> The GPL-2.0-or-later docs won't influence the license of the
> combined work.
>
> Note, this interpretation applies only to languages which are
> compiled, not interpreted.
>
> If we are generating python code for example, the there is
> no "source file" vs "object file" distinction for licensing.
> The combined work in a python app is under the union of all
> the source file licenses.
>
>
> TL;DR: I think you can re-add the documentation comments to
> the Golang code generator, declare the resulting code as being
> "MIT-0 AND GPL-2.0-or-later".
>
> In the README.md file we need todo two important things:
>
>  * Document our interpretation of the "combined work" license
>    situation for applications consuming the project.
>  * Declare that *ALL* manually written code contributions
>    are exclusively MIT-0.

What code do you have in mind?  Can you provide an example?

> With regards,
> Daniel
>
> [1] NB, there are languages where some code comments can have semantic
>     impacts on the compiled out. I don't believe that to be the case for
>     any human targetted API docs that we would be copying over from the
>     QAPI schema though in the Golang case.


