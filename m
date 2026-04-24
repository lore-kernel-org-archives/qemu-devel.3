Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C436FED3C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGGia-0007vU-D2; Fri, 24 Apr 2026 09:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGGiY-0007v1-Mf
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGGiX-0004kR-7B
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777037830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/rxdQEsVEYOTcyQDB2reasoRaxL5y2hz9Y61d7i+zA=;
 b=JHX7QzHazA5HVscWZfzZVD2gIjavpeqG4AZvTqb2+67kf8pMpoNnmYlgfuOAA01/Wb6Dvf
 YwBgv+5pV5DhKxKYHv1yVQVJptndcGb5EtqYGXIgGffLn58mrGG7mlqC6KvqWUzWMQxQ9B
 WrD3U54EX4nV05xWCFI6RFJtk6VBFzk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-iWA4fUueN8qinANrDlvkKA-1; Fri,
 24 Apr 2026 09:37:09 -0400
X-MC-Unique: iWA4fUueN8qinANrDlvkKA-1
X-Mimecast-MFC-AGG-ID: iWA4fUueN8qinANrDlvkKA_1777037824
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B1D71800473; Fri, 24 Apr 2026 13:37:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 219031944CED; Fri, 24 Apr 2026 13:37:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B503521E6A28; Fri, 24 Apr 2026 15:37:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Igor Mammedov
 <imammedo@redhat.com>,  Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Ani Sinha <anisinha@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Eric Blake <eblake@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 00/12] qapi: add formal "intro" section
In-Reply-To: <CAFn=p-ZNOYwSybMQDHnw9FF88_RDaRNhJkFjCT3AHKu496Ggeg@mail.gmail.com>
 (John Snow's message of "Fri, 24 Apr 2026 08:52:21 -0400")
References: <20260423220022.2180059-1-jsnow@redhat.com>
 <87mrysr08h.fsf@pond.sub.org>
 <CAFn=p-ZNOYwSybMQDHnw9FF88_RDaRNhJkFjCT3AHKu496Ggeg@mail.gmail.com>
Date: Fri, 24 Apr 2026 15:37:01 +0200
Message-ID: <87v7dgpjia.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Fri, Apr 24, 2026, 8:50=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Hiya, this is a series that explores a potential syntax for a
>> > designated "Intro" section. Markus knows why I want this, but for
>> > everyone else: a designated "Introduction" section is useful for the
>> > desired "inliner" feature for the new QAPI doc system. Commits explain
>> > a bit more. This is prep work and doesn't really change anything
>> > tangibly except source code syntax for the QAPI docs.

[...]

>> Why not wholesale conversion?  As long as generated output stays the
>> same.  It does in this series, except for harmless line breaks.
>>
>
> When we last spoke, we weren't convinced this was the right approach and =
we
> both wanted to see it. So I did enough to get a taste.

Yes, and it makes sense.

>> > This series demonstrates conversion of just four modules; if I'm given
>> > a thumbs up, I will convert the rest of QAPI, one module (or
>> > maintainer stanza) per patch like how I handled adding
>> > cross-references.


