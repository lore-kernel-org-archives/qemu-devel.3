Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4A606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=k5WeCOdS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUGLp-0006oj-JS; Thu, 19 Nov 2026 23:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xUGLn-0006oW-9X
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 23:35:51 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xUGLk-0002mk-Vt
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 23:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795149335; bh=oHc7dAEBdvO8LshOxjM6DIcpj+sQCcTeouArgBzcsQo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=k5WeCOdSQdi/qMJBrJ9PRc3LPICCJyIMht/MJsft0XApSIZflVb6SkOFUgUoqVnTt
 iH9bevA+89eFZPB1cQe3frAam2O1C26IGfbKy00vMex57iNN3FTKSkd0BtHdXK3q2P
 ZQNKG1IxYJUbVxaqrEb9g/lCHo9hw6kqA8vOI5Fs=
Received: from blackfin.pond.sub.org
 (p200300d36f05b900e5f885c0cd39d8e9.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:b900:e5f8:85c0:cd39:d8e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 123B520479
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 05:35:34 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7464E21E6A04; Fri, 20 Nov 2026 05:35:41 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  crosa@redhat.com,  marcandre.lureau@redhat.com
Subject: Re: [PATCH] python/qemu: Don't choke on unknown members in QMP replies
In-Reply-To: <CAFn=p-bz6_SW7OR-wxTcLPQfq5D2G5YRXLuH9wc+cORh8E8=1A@mail.gmail.com>
 (John Snow's message of "Thu, 19 Nov 2026 13:11:02 -0500")
References: <20261118182005.1066151-1-armbru@redhat.com>
 <CAFn=p-bz6_SW7OR-wxTcLPQfq5D2G5YRXLuH9wc+cORh8E8=1A@mail.gmail.com>
Date: Fri, 20 Nov 2026 05:35:41 +0100
Message-ID: <87qzgg86hu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

John Snow <jsnow@redhat.com> writes:

> On Wed, Nov 18, 2026 at 1:20=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> The recent addition of @qapi-type to ObjectPropertyInfo and
>> ObjectPropertyValue broke the corresponding classes in
>> qemu/utils/qom_common.  Reproducer:
>
> Do we need that qapi-type for anything in the client?

Not yet, but I'm working on a followup series that uses it.

>>
>>     $ bld/run qom-list -s qmp-socket /chardevs
>>     Traceback (most recent call last):
>>       File "/work/armbru/qemu/bld/pyvenv/bin/qom-list", line 8, in <modu=
le>
>>         sys.exit(QOMList.entry_point())
>>                  ~~~~~~~~~~~~~~~~~~~^^
>>       File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 230=
, in entry_point
>>         return cls.command_runner(args)
>>                ~~~~~~~~~~~~~~~~~~^^^^^^
>>       File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 215=
, in command_runner
>>         return cmd.run()
>>                ~~~~~~~^^
>>       File "/work/armbru/qemu/python/qemu/utils/qom.py", line 179, in run
>>         rsp =3D self.qom_list(self.path)
>>       File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 192=
, in qom_list
>>         return [ObjectPropertyInfo.make(x) for x in rsp]
>>                 ~~~~~~~~~~~~~~~~~~~~~~~^^^
>>       File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 52,=
 in make
>>         assert value.keys() <=3D {'name', 'type', 'description', 'defaul=
t-value'}
>>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^
>>     AssertionError
>>
>> This asserts "no members we don't know".  There are two more like it.
>>
>> Adding @qapi-type broke them.
>>
>> docs/devel/qapi-code-gen.rst section "Compatibility considerations"
>> stipulates that "clients are expected to ignore [members] they don't
>> know."
>>
>> Delete / relax these assertions.
>>
>> Fixes: 0eee31cf1085 ("qapi/qom: add qapi-type to qom-list, qom-list-prop=
erties, qom-list-get")
>> Fixes: c750c02891a8 ("python/qmp: Add qom script rewrites")
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks!

