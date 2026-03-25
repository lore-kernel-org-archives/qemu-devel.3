Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E1AFEA80A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Gu5-00054h-8R; Wed, 25 Mar 2026 01:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5Gu3-00054Y-Qy
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5Gu2-0003LJ-6X
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774416936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCDDlLhwgQlISxeohBXpCBYNgkHUhfuywrcigt4uDzU=;
 b=GW0D6HyAMJK80taYcLW3+IPu4pr7bVFdqOZyAa8P3sc7wQX4ymFDGCgU9jbhwDoTjVBu0y
 kASUiAygbgaD9jljCpyFtsoyPDU2xUBgqb6lhPMkE4emxQWQZ0kmzONTZrcPdR2kAZ4kWv
 Fz90rzT5Jxr3sqw5Xb8A7oakC2UKKw4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-LcDKbjojN1qQ-qLEl4ldpg-1; Wed,
 25 Mar 2026 01:35:34 -0400
X-MC-Unique: LcDKbjojN1qQ-qLEl4ldpg-1
X-Mimecast-MFC-AGG-ID: LcDKbjojN1qQ-qLEl4ldpg_1774416933
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 976211944F0D
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 05:35:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 551A61955F2E
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 05:35:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EDB4A21E6937; Wed, 25 Mar 2026 06:35:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 11/60] ui/console-vc: add UTF-8 input decoding with
 CP437 rendering
In-Reply-To: <20260317-qemu-vnc-v1-11-48eb1dcf7b76@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Tue, 17 Mar 2026 12:50:25 +0400")
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-11-48eb1dcf7b76@redhat.com>
Date: Wed, 25 Mar 2026 06:35:30 +0100
Message-ID: <878qbgpj31.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> The text console receives bytes that may be UTF-8 encoded (e.g. from
> a guest running a modern distro), but currently treats each byte as a
> raw character index into the VGA/CP437 font, producing garbled output
> for any multi-byte sequence.
>
> Add a proper UTF-8 decoder using Bjoern Hoehrmann's DFA.
> The DFA inherently rejects overlong encodings, surrogates, and
> codepoints above U+10FFFF.  Completed codepoints are then mapped to
> CP437, unmappable characters are displayed as '?'.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Have you considered the decoder in util/unicode.c?  Do we need two
decoders, or could we replace one by the other?

There's a mad UTF-8 test suite buried in tests/unit/check-qjson.c
derived from Markus Kuhn's UTF-8 decoder capability and stress test at
<http://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-test.txt>.  How does
this decoder do on these tests?


