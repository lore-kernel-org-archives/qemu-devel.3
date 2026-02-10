Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419FCEA813A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpq3T-0001vA-AO; Tue, 10 Feb 2026 10:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpq30-0001dD-4C
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:53:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpq2b-00040Q-Ts
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770738738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CH2HZFbayJXJE4SzqKQQ8Vxlj2l5aENvQP2ME1lce9M=;
 b=VcmdKbZhAUHF/Ug6vHu5LItPQAzzxWPy+R9zf97Twolk2P1TTrIJE4RRHFYPlbhgNEsgNj
 cnfDRJNrquZb86Iv6m8V+gJINd56LHhqf4Gqaw49rxIewwUbCpRRuZhvFrM32fp9mtxndZ
 HbaRexyKg6ZzPyqliamxfKsDK/KXmiA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-lz9FdEoON_Gd7O6P7f0vOA-1; Tue,
 10 Feb 2026 10:52:16 -0500
X-MC-Unique: lz9FdEoON_Gd7O6P7f0vOA-1
X-Mimecast-MFC-AGG-ID: lz9FdEoON_Gd7O6P7f0vOA_1770738736
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B679D195608F
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 15:52:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74474180066D
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 15:52:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1EE0F21E692D; Tue, 10 Feb 2026 16:52:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/5] qobject: switch JSON parser to push
In-Reply-To: <CABgObfYrMS093t4GoxB8EgwYYT8wCb-MBozgC5ATq3BZdpheBA@mail.gmail.com>
 (Paolo Bonzini's message of "Tue, 10 Feb 2026 14:12:51 +0100")
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <87ldhffe79.fsf@pond.sub.org>
 <CABgObfYD6cLmN_qgmro-O2wUPqnqTn3ZUYntbPrFQkX0xE=8AQ@mail.gmail.com>
 <87o6lw7nor.fsf@pond.sub.org>
 <CABgObfYrMS093t4GoxB8EgwYYT8wCb-MBozgC5ATq3BZdpheBA@mail.gmail.com>
Date: Tue, 10 Feb 2026 16:52:13 +0100
Message-ID: <87343861g2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Tue, Feb 10, 2026 at 2:06=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> >                                                                     St=
ill
>> > the difference in error reporting matters, because it gives feedback t=
hat
>> > is immediately useful, rather than possibly delayed forever.
>>
>> Reporting parse errors immediately is such a lovely quality of life
>> improvement.  May I have that without regressing error recovery?
>
> If it is a regression, of course.
>
> Especially the one for ^L, which needs a testcase.

I totally should've added one when I documented the technique back in
2018.

>                                                    Something like this
> should do:
>
> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> index f6380684897..287a345b49a 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -35,17 +35,25 @@
>          parser->brace_count++;
>          break;
>      case JSON_RCURLY:
> -        if (parser->brace_count > 0) {
> -            parser->brace_count--;
> +        if (parser->brace_count <=3D 0) {
> +            goto end_error_recovery;
>          }
> +        parser->brace_count--;
>          break;
>      case JSON_LSQUARE:
>          parser->bracket_count++;
>          break;
>      case JSON_RSQUARE:
> -        if (parser->bracket_count > 0) {
> -            parser->bracket_count--;
> +        if (parser->bracket_count <=3D 0) {
> +            goto end_error_recovery;
>          }
> +        parser->bracket_count--;
> +        break;
> +    case JSON_ERROR:
> +    end_error_recovery:
> +        parser->brace_count =3D 0;
> +        parser->bracket_count =3D 0;
>          break;
>      default:
>          break;

Passes a quick smoke test!

Fine print: different errors can get reported, but that's probably a
slight improvement.


