Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C068AC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgM3-0003YB-Tz; Thu, 29 Feb 2024 08:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfgM2-0003XV-D2
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:21:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfgM0-0005b0-MT
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709212899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gedKdLjhxVvE3xMS/sfaGT2d4T1f6XjrrzUE4XtN2nU=;
 b=eKDA18H5OGgvGNVGbatq8ddDV6TdMVeAcxAGbOpKykLkRjadiMuDT7sbDLfW1WuW15TuOJ
 Zf1BvSDUURAdBJJBH7Z5zwr59KOVzS3nFIW/T2rxtqwnbWHd02XR/L7+uU4fopPlDf4ljC
 4foy9xtH3v6i3LPDczofaKlYat14DDY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-MGKYKFexMMi3yf9M3RGZXA-1; Thu, 29 Feb 2024 08:21:32 -0500
X-MC-Unique: MGKYKFexMMi3yf9M3RGZXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4DFB800074;
 Thu, 29 Feb 2024 13:21:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70F652015B7C;
 Thu, 29 Feb 2024 13:21:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4264221E6740; Thu, 29 Feb 2024 14:21:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le
 Goater <clg@redhat.com>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Alex Williamson
 <alex.williamson@redhat.com>,  Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Nicholas
 Piggin
 <npiggin@gmail.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,  Halil
 Pasic <pasic@linux.ibm.com>,  Eric Blake <eblake@redhat.com>,  John Snow
 <jsnow@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 06/21] migration: Add Error** argument to
 .save_setup() handler
In-Reply-To: <bea4ca16-a2ea-4a06-bb8d-27b485d63cc1@redhat.com> (Thomas Huth's
 message of "Thu, 29 Feb 2024 11:35:44 +0100")
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-7-clg@redhat.com> <87zfvj3hnd.fsf@pond.sub.org>
 <86d70a2e-7250-440b-bcd6-7877fe3b3dba@yandex-team.ru>
 <bea4ca16-a2ea-4a06-bb8d-27b485d63cc1@redhat.com>
Date: Thu, 29 Feb 2024 14:21:30 +0100
Message-ID: <875xy7xv6t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 29/02/2024 08.20, Vladimir Sementsov-Ogievskiy wrote:
>> On 29.02.24 09:32, Markus Armbruster wrote:

[...]

>>> Anti-pattern: fail without setting an error.=C2=A0 There might be more
>>> elsewhere in the series.
>>>
>>> qapi/error.h's big comment:
>>>
>>> =C2=A0 * - On success, the function should not touch *errp.=C2=A0 On fa=
ilure, it
>>> =C2=A0 *=C2=A0=C2=A0 should set a new error, e.g. with error_setg(errp,=
 ...), or
>>> =C2=A0 *=C2=A0=C2=A0 propagate an existing one, e.g. with error_propaga=
te(errp, ...).
>>> =C2=A0 *
>>> =C2=A0 * - Whenever practical, also return a value that indicates succe=
ss /
>>> =C2=A0 *=C2=A0=C2=A0 failure.=C2=A0 This can make the error checking mo=
re concise, and can
>>> =C2=A0 *=C2=A0=C2=A0 avoid useless error object creation and destructio=
n.=C2=A0 Note that
>>> =C2=A0 *=C2=A0=C2=A0 we still have many functions returning void.=C2=A0=
 We recommend
>>> =C2=A0 *=C2=A0=C2=A0 =E2=80=A2 bool-valued functions return true on suc=
cess / false on failure,
>>> =C2=A0 *=C2=A0=C2=A0 =E2=80=A2 pointer-valued functions return non-null=
 / null pointer, and
>>> =C2=A0 *=C2=A0=C2=A0 =E2=80=A2 integer-valued functions return non-nega=
tive / negative.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_be64(f, STATTR_FLAG=
_EOS);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0=C2=A0=C2=A0 }
>>>
>>> When adding Error **errp to a function, you must also add code to set an
>>> error on failure to every failure path.=C2=A0 Adding it in a later patc=
h in
>>> the same series can be okay,
>>
>> Personally, I'd prefer not doing so. Creating wrong commits and fixing t=
hem in same series - better to merge all fixes into bad commit:)
>
> I agree - that might create issues with bisecting later. Please fix it in=
 this patch here already!

Depends on the wrongness, really.

We don't want broken intermediate states, no argument.

But intermediate states that are merely unclean can be acceptable.

For instance, my commit a30ecde6e79 (net: Permit incremental conversion
of init functions to Error) added such Error ** parameters to a somewhat
tangled nest of functions, along with FIXME comments where errors
weren't set.  The next few commits fixed most, but not all of them.
Later commits fixed some more.  The one in tap-win32.c is still there
today.

This was acceptable, because it improved things from "bad error
reporting" to "okay error reporting in most cases, unclean and bad error
reporting in a few cases marked FIXME", with "a few" over time going
down to the one I can't test, and nobody else seems to care about.


