Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB6AD39432
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 14:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8JCv-0001n4-U6; Thu, 02 Apr 2026 10:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w8JCs-0001ma-10
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w8JCq-0007Cz-Gi
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775140774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ermLvKdvcTFiggE+IO/Dxqxk02Wv7hmwDWZisdIBNRc=;
 b=GhGUmBsYE5Kq8e5zqVtkis6SHPMG4GD+gLMDNZBv2W+jtpipfVzxurmF5ZZbM5J9LZe2Se
 2qux2kfB8uxpoXdricC1r5BU6ZTO5o/jxELtnU666TWEavxgZUNKfiRApM9GiB9us4mU65
 SOaj6GXMvwzIBgrz2i9yrfKv0b+kfyI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-uzvQDWCNNty7gy9MLul86Q-1; Thu,
 02 Apr 2026 10:39:33 -0400
X-MC-Unique: uzvQDWCNNty7gy9MLul86Q-1
X-Mimecast-MFC-AGG-ID: uzvQDWCNNty7gy9MLul86Q_1775140771
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B96E31953993
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2026 14:39:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7746D1800361
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2026 14:39:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D515321E6A28; Thu, 02 Apr 2026 16:39:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 11/60] ui/console-vc: add UTF-8 input decoding with
 CP437 rendering
In-Reply-To: <CAMxuvazy-_DjAVJN2=ie___VxFMKGyLkEiEP0OBNbipN1nxoSA@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 2 Apr 2026
 15:44:35 +0400")
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-11-48eb1dcf7b76@redhat.com>
 <878qbgpj31.fsf@pond.sub.org>
 <CAMxuvayGCvJwyUgrHSGwfLhqAbVC61dEbgbL4Ji_0YQHyv4LJA@mail.gmail.com>
 <CAMxuvazy-_DjAVJN2=ie___VxFMKGyLkEiEP0OBNbipN1nxoSA@mail.gmail.com>
Date: Thu, 02 Apr 2026 16:39:22 +0200
Message-ID: <87se9dtoit.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi Markus
>
> On Wed, Mar 25, 2026 at 10:48=E2=80=AFAM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>>
>> HI
>>
>> On Wed, Mar 25, 2026 at 9:35=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>> >
>> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>> >
>> > > The text console receives bytes that may be UTF-8 encoded (e.g. from
>> > > a guest running a modern distro), but currently treats each byte as a
>> > > raw character index into the VGA/CP437 font, producing garbled output
>> > > for any multi-byte sequence.
>> > >
>> > > Add a proper UTF-8 decoder using Bjoern Hoehrmann's DFA.
>> > > The DFA inherently rejects overlong encodings, surrogates, and
>> > > codepoints above U+10FFFF.  Completed codepoints are then mapped to
>> > > CP437, unmappable characters are displayed as '?'.
>> > >
>> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> > Have you considered the decoder in util/unicode.c?  Do we need two
>> > decoders, or could we replace one by the other?
>> >
>>
>> Oh! I missed it, I should definitely try to use it.
>
> The vt100 receives characters one at a time. The DFA is suited for
> this. mod_utf8_codepoint() works with whole buffers. It's possible to
> write one with the other, but we lose in performance, and we need
> extra quirks. I don't think it's worth it.

Implementing a buffer interface on top of a character at a time
interface should be easier than the other way round.

I doubt rewriting mod_utf8_codepoint() to wrap around the DFA would slow
things down materially.

I'm not demanding you try that!

If we decide to go with two decoders, do we want a unit test to ensure
they behave the same?

[...]


