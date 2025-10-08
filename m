Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD121CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 07:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ORN-00025O-Sp; Wed, 08 Oct 2025 03:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6ORF-00022D-2w
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6ORC-0000kq-LY
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759907892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aqV2OB91OUf1agETbDGxMFK1qWXZBK5bFwEVPg/7p28=;
 b=Xi2QkcqtbR0kvemjV90VW2hiBXTxByhPjcTIzyU3VC3C8xYtdm2ObglMr9qO+AfH/6s1HU
 gATpJtyyd4GolRCjdbXuj+DQSmHkttJKaiyluKvz+nnDdXOrk2EoaHYMSSV5uGvZAGIGeV
 356ZQEG1y42y8GYR0oreKDFp2fv6GKo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-7OrKoIzXOr6ByFQqoY1NQg-1; Wed,
 08 Oct 2025 03:18:08 -0400
X-MC-Unique: 7OrKoIzXOr6ByFQqoY1NQg-1
X-Mimecast-MFC-AGG-ID: 7OrKoIzXOr6ByFQqoY1NQg_1759907888
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C656C180047F; Wed,  8 Oct 2025 07:18:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 726711800446; Wed,  8 Oct 2025 07:18:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6DDE21E6A27; Wed, 08 Oct 2025 09:18:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Daniel P
 . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  John Snow
 <jsnow@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 0/6] tracetool: add mypy --strict checking [AI
 discussion ahead!]
In-Reply-To: <20251008063546.376603-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 8 Oct 2025 08:35:39 +0200")
References: <20251008063546.376603-1-pbonzini@redhat.com>
Date: Wed, 08 Oct 2025 09:18:04 +0200
Message-ID: <87ikgpn9oz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> [People in Cc are a mix of Python people, tracing people, and people
>  who followed the recent AI discussions. - Paolo]
>
> This series adds type annotations to tracetool. While useful on its own, 
> it also served as an experiment in whether AI tools could be useful and
> appropriate for mechanical code transformations that may not involve
> copyrightable expression.
>
> In this version, the types were added mostly with the RightTyper tool
> (https://github.com/RightTyper/RightTyper), which uses profiling to detect
> the types of arguments and return types at run time.  However, because
> adding type annotations is such a narrow and verifiable task, I also developed
> a parallel version using an LLM, to provide some data on topics such as:
>
> - how much choice/creativity is there in writing type annotations?
>   Is it closer to writing functional code or to refactoring?

Based on my work with John Snow on typing of the QAPI generator: there
is some choice.

Consider typing a function's argument.  Should we pick it based on what
the function requires from its argument?  Or should the type reflect how
the function is used?

Say the function iterates over the argument.  So we make the argument
Iterable[...], right?  But what if all callers pass a list?  Making it
List[...] could be clearer then.  It's a choice.

I think the choice depends on context and taste.  At some library's
external interface, picking a more general type can make the function
more generally useful.  But for some internal helper, I'd pick the
actual type.

My point isn't that an LLM could not possibly do the right thing based
on context, and maybe even "taste" distilled from its training data.  My
point is that this isn't entirely mechanical with basically one correct
output.

Once we have such judgement calls, there's the question how an LLM's
choice depends on its training data (first order approximation today:
nobody knows), and whether and when that makes the LLM's output a
derived work of its training data (to be settled in court).

[...]

> Based on this experience, my answer to the copyrightability question is
> that, for this kind of narrow request, the output of AI can be treated as
> the output of an imperfect tool, rather than as creative content potentially
> tainted by the training material.

Maybe.

>                                    Of course this is one data point and
> is intended as an experiment rather than a policy recommendation.

Understood.  We need to develop a better understanding of capabilities,
potential benefits and risks, and such experiments can only help with
that.


