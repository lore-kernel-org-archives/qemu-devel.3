Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B4AC52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbytr-0004Nm-8B; Thu, 08 Aug 2024 04:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbytq-0004NG-FO
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbyto-00082E-6I
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723107211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpcN7FVi/HmxLedEv4RDYFF+J8yYiv19qzazyte6R4M=;
 b=fe4D+KbRhoUMXp8cD1wMgn2eDJJxgNckvE9tAya8z+2uVGizmAPZtGZV20OHmYMoD/B1oL
 pvr2+3NpnyCUdGgWxJVPC+/uV8NKynZ/m/x61oDZww7e7WXJhbj0qze19Hr5NzcfUfLf23
 ErJDqzdY2syOwkHRt93c6jOoIqrRzVA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-AFJBzDPTNZCDA2OElSI6Fg-1; Thu,
 08 Aug 2024 04:53:29 -0400
X-MC-Unique: AFJBzDPTNZCDA2OElSI6Fg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89E2D1944CCC; Thu,  8 Aug 2024 08:53:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FB051955F2E; Thu,  8 Aug 2024 08:53:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB05821E6692; Thu,  8 Aug 2024 10:53:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] qapi: Generate QAPI files using qapi/ for generated
 header paths
In-Reply-To: <87ttfwwqrx.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 07 Aug 2024 12:50:26 +0200")
References: <20240807093406.40360-1-philmd@linaro.org>
 <ZrNB5C7Ta-Qg-9HT@redhat.com> <87ttfwwqrx.fsf@pond.sub.org>
Date: Thu, 08 Aug 2024 10:53:25 +0200
Message-ID: <87r0az1jlm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> On Wed, Aug 07, 2024 at 11:34:06AM +0200, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> QAPI script generates headers under the qapi/ directory,
>>> so use this prefix in generated header paths, keeping
>>> all QAPI under the qapi/ namespace.
>>
>> Err that's not always the case is it ?
>
> Yup.  We generate into the current directory by default, but you can set
> another one with --output-dir.
>
>> For the main QMP schema, it generates under $BUILDDIR/qapi/,
>> but there are other schemas such as QGA, which is generated
>> under $BUILDDIR/qga/
>
> I think we could prepend the argument of --output-dir instead.

I'm willing to give this a try after my vacation.  You may have to
remind me...

[...]


