Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD089C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsqQ-0008OU-6T; Tue, 13 Feb 2024 08:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZsqG-0008L1-Qq
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZsqE-0002NU-BV
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707830932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpD4NmkaxIvnMBOhpKqvjRHoo7XqxLo/PNzsAVnM7rY=;
 b=bSsjaSPPT4Pae3shwFleBTo8ptax6NDIdGVs4ntqBFHCoRci4177ugmo6aW1G+OW5T6/pA
 gZ9GZvm1wy4vU12mkwhh8vV6haJbemiASP9gspurpdA5g6IGkmGSQvKyIwT06cP0iQBKeF
 Jk3NR87ToZd+UwIDNoTjQfwukBSgkLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-LyWGnwWHMI2fw55gRj04Ow-1; Tue, 13 Feb 2024 08:28:50 -0500
X-MC-Unique: LyWGnwWHMI2fw55gRj04Ow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6EDD1097B00;
 Tue, 13 Feb 2024 13:28:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C421CC185C0;
 Tue, 13 Feb 2024 13:28:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C22621E66D5; Tue, 13 Feb 2024 14:28:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/4] Character device backend patches for 2024-02-12
In-Reply-To: <CAFEAcA9zTjesN+6CxcG1EGmVzwmrt7kdZMCPY7K1ibwO02MbMQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 13 Feb 2024 10:54:32 +0000")
References: <20240212085142.523317-1-armbru@redhat.com>
 <CAFEAcA9zTjesN+6CxcG1EGmVzwmrt7kdZMCPY7K1ibwO02MbMQ@mail.gmail.com>
Date: Tue, 13 Feb 2024 14:28:48 +0100
Message-ID: <87zfw47asv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 12 Feb 2024 at 08:51, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> I offered Marc-Andr=C3=A9 to do this pull request, and he accepted.
>>
>> The following changes since commit 5d1fc614413b10dd94858b07a1b2e26b1aa02=
96c:
>>
>>   Merge tag 'migration-staging-pull-request' of https://gitlab.com/peter=
x/qemu into staging (2024-02-09 11:22:20 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://repo.or.cz/qemu/armbru.git tags/pull-char-2024-02-12
>>
>> for you to fetch changes up to 684d03acff6096b8ae79da0fcd6194238827c67e:
>>
>>   qapi/char: Deprecate backend type "memory" (2024-02-12 09:39:38 +0100)
>>
>> ----------------------------------------------------------------
>> Character device backend patches for 2024-02-12
>>
>> ----------------------------------------------------------------
>> Markus Armbruster (4):
>>       chardev/parallel: Don't close stdin on inappropriate device
>>       tests/unit/test-char: Fix qemu_socket(), make_udp_socket() check
>>       qapi/char: Make backend types properly conditional
>>       qapi/char: Deprecate backend type "memory"
>
> The new test-char test fails on the x64-freebsd-13-build job:
> https://gitlab.com/qemu-project/qemu/-/jobs/6155393879
> https://gitlab.com/qemu-project/qemu/-/jobs/6158373424
>
> 652/850 qemu:unit / test-char ERROR 0.14s killed by signal 6 SIGABRT
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
> stderr:
> ** ERROR:../tests/unit/test-char.c:1218:char_parallel_test: 'chr' should =
be NULL
> (test program exited with status code -6)

Hmm, I think I see where I screwed up.  Thanks!


