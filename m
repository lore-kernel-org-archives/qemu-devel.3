Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E895C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmfs-0007A5-Ew; Tue, 16 Jul 2024 14:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sTmfp-0006qD-9g
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sTmfn-0001fo-D4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721153589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYiQRBc7O37vqrM8D39P0F9ukT6g2EfxYrogFll9Iws=;
 b=HpNaKe9SB/+J21p1qWsbujZcRbmEjpD43M36go9j8yWgDKq6pQDPu8SbRsKA466UO3j9ZI
 hG5k9BTA8IJi8MJEV1ycKKbmjHQ9IF8WTy3hlf4BGj9nctRXlaXVnKe34pqIKbioVBPgGq
 HbcPKv6nah9BwYhqQ2jMhbCmvmbKs1s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-H350j06KPGGqSxJ2Vqn3lQ-1; Tue,
 16 Jul 2024 14:13:06 -0400
X-MC-Unique: H350j06KPGGqSxJ2Vqn3lQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06AE91956080; Tue, 16 Jul 2024 18:13:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 858F31955F3B; Tue, 16 Jul 2024 18:13:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C971321E668E; Tue, 16 Jul 2024 20:12:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Eric Blake <eblake@redhat.com>,  Michael
 Tsirkin <mst@redhat.com>,  Daniel Berrange <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 3/5] qapi/machine: Clarify query-uuid value when none
 has been specified
In-Reply-To: <CAFn=p-Zv9e7MFhpGK=PssPYGbe7Q3R-A0CAdYEMbtaY60ATWrw@mail.gmail.com>
 (John Snow's message of "Tue, 16 Jul 2024 12:14:52 -0400")
References: <20240711112228.2140606-1-armbru@redhat.com>
 <20240711112228.2140606-4-armbru@redhat.com>
 <CAFn=p-Zv9e7MFhpGK=PssPYGbe7Q3R-A0CAdYEMbtaY60ATWrw@mail.gmail.com>
Date: Tue, 16 Jul 2024 20:12:54 +0200
Message-ID: <87v815i4t5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> On Thu, Jul 11, 2024, 7:22=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> When no UUID has been specified, query-uuid returns
>>
>>     {"UUID": "00000000-0000-0000-0000-000000000000"}
>>
>> The doc comment calls this "a null UUID", which I find less than
>> clear.  Change it to "an all-zero UUID".
>>
>
> Technically it's a "nil UUID";
> https://datatracker.ietf.org/doc/html/rfc9562#name-nil-uuid
>
> If you wanted to be pedantic, you could say "the nil UUID (all zeroes) is
> returned"

Sold!

> but your rephrasing is clear even w/o using the standard name, so I'm fine
> either way.
>
>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>
> Reviewed-by: John Snow <jsnow@redhat.com>

Thank you!


