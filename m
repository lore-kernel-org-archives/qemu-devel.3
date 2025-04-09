Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECC8C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 05:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2OKn-0005hd-L3; Wed, 09 Apr 2025 01:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2OKb-0005ep-8O
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 01:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2OKY-0002Ov-Hq
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 01:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744177831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTvY/qMEt3Iv53KOdOEtaUfevWFoTT8x5hlsT2NIHhc=;
 b=NWBAm8R67bWTfL/Ln7+iDrwmfGSi2peAXEKbeSbtZbklsjUqpVFji3QcGVEx2yz/SENSjq
 +iqcyk5FnWICha0FmIYoJWTgwO+aLiwZ9dH2zejG2gdYJnaFaNf7X4zC6MLH3+EQV+XHl/
 BkuDDuuexZjRwedJAgofAFPQYHgoMKU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-HCbxlNVNP4yw3ZG4gsV9sw-1; Wed,
 09 Apr 2025 01:50:28 -0400
X-MC-Unique: HCbxlNVNP4yw3ZG4gsV9sw-1
X-Mimecast-MFC-AGG-ID: HCbxlNVNP4yw3ZG4gsV9sw_1744177826
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 697D91955BC9; Wed,  9 Apr 2025 05:50:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BA711801A69; Wed,  9 Apr 2025 05:50:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 32BDC21E6773; Wed, 09 Apr 2025 07:50:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  kkostiuk@redhat.com,
 kwolf@redhat.com,  peter.maydell@linaro.org,  eblake@redhat.com,
 jiri@resnulli.us,  qemu-block@nongnu.org
Subject: Re: [PATCH 06/11] docs/sphinx/qmp_lexer: Generalize elision syntax
In-Reply-To: <CAFn=p-bFk=+fuVaDY=oVs4TJ3YCfo97xE=s=865bnrPh1cyGyw@mail.gmail.com>
 (John Snow's message of "Tue, 8 Apr 2025 16:46:53 -0400")
References: <20250404121413.1743790-1-armbru@redhat.com>
 <20250404121413.1743790-7-armbru@redhat.com>
 <CAFn=p-bFk=+fuVaDY=oVs4TJ3YCfo97xE=s=865bnrPh1cyGyw@mail.gmail.com>
Date: Wed, 09 Apr 2025 07:50:23 +0200
Message-ID: <875xjdhoio.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On Fri, Apr 4, 2025 at 8:14=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> Accept "... lorem ipsum ..."  in addition to "...".
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>

[...]

> Cool, sure!
>
> ACK (Who is responsible for this now? Me?)

Yup.

I posted the PR without waiting for your approval only because I really,
really want to get the introductions right for 10.0, and the
docs/sphinx/ is just a one-liner.  Hope you don't mind!


