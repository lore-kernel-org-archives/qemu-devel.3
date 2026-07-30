Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B26BC55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpQMG-0006wU-Iz; Thu, 30 Jul 2026 08:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wpQME-0006vb-EU
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wpQMC-0007hN-6Q
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785416366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDS4TkMha0gHH0wVcrCrut/csLSeIVhxyOKouJJJjDU=;
 b=Yj9rImAf4GI4vRNF/8hj5d1eKk0CyREhpacJFnIj5E/YaV9yPRZEpXBQLbfLOUFCsCRiDS
 CXV/D/Z5dyVMko035jlVZsdN3K27BU4scNhPPv4lDT9uVwuypnCBgHhaY5DzhIKfw105q0
 A85bKjpVrZTvkJJKiQmU4MbBAyOSgVY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-4tyhKubONrCWr4rAUTIOHA-1; Thu,
 30 Jul 2026 08:59:22 -0400
X-MC-Unique: 4tyhKubONrCWr4rAUTIOHA-1
X-Mimecast-MFC-AGG-ID: 4tyhKubONrCWr4rAUTIOHA_1785416359
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D31C31800358; Thu, 30 Jul 2026 12:59:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D00CD180034E; Thu, 30 Jul 2026 12:59:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74A8021E6920; Thu, 30 Jul 2026 14:59:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Lukas
 Straub <lukasstraub2@web.de>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Zhao Liu <zhao1.liu@intel.com>,  Laurent
 Vivier <laurent@vivier.eu>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Alex
 Williamson
 <alex@shazbot.org>,  zhenwei pi <zhenwei.pi@linux.dev>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org,  Jiri Pirko <jiri@resnulli.us>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,  Igor
 Mammedov <imammedo@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  linux-edac@vger.kernel.org,  =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
 qemu-trivial@nongnu.org,  Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 44/44] qapi: convert trivial intro sections for
 block-core.json
In-Reply-To: <87qzkntdpy.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 28 Jul 2026 16:01:45 +0200")
References: <20260723044805.527643-1-jsnow@redhat.com>
 <20260723044805.527643-45-jsnow@redhat.com>
 <87y0f0aikr.fsf@pond.sub.org>
 <CAFn=p-axhB-ezhfD2F8EoFhWT0h92d6oWP6Li1-JdhiXUGbsdA@mail.gmail.com>
 <87qzkntdpy.fsf@pond.sub.org>
Date: Thu, 30 Jul 2026 14:59:12 +0200
Message-ID: <878q6socpr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:
>
>> On Fri, Jul 24, 2026 at 4:38=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>
> [...]
>
>>> I believe all the problematic first paragraphs consist of more than one
>>> sentence.  What about splitting "trivial" into "very trivial" (just one
>>> paragraph, no sentence-ending punctuation in the middle) and "hopefully
>>> trivial" (just one paragraph, remainder)?
>>
>> That's tricky to automate, and doing it by hand doesn't sound much fun
>> either... can we just power through one-by-one?
>>
>> Unless you have a script or a trick you believe will help, and then I
>> am happy to oblige.
>
> By hand would clearly be a bad use of your time.
>
> I'll look into automating it.

Lightly tested throwaway script:

#!/usr/bin/env python3

import os
import re
import subprocess
import sys

proc =3D subprocess.Popen(['/usr/bin/git', 'add', '-p'],
                        bufsize=3D1,
                        stdin=3Dsubprocess.PIPE,
                        stdout=3Dsubprocess.PIPE,
                        text=3DTrue)

n =3D 0
while True:
    n +=3D 1
    chunk =3D os.read(proc.stdout.fileno(), 1024*1024).decode('utf-8')
    if not chunk:
        break
    lines =3D chunk.splitlines()
    prompt =3D lines[-1]
    if prompt.find('Stage this hunk') =3D=3D -1:
        print(f"{sys.argv[0]}: no recognizable prompt after chunk #{n}",
              file=3Dsys.stderr)
        break
    #old =3D '\n'.join(filter(lambda l: re.match(r'^[- ]', l), lines))
    #print(old)
    deleted =3D '\n'.join(filter(lambda l: re.match(r'^-#', l), lines))
    if re.search(r'[!.?].*[!.?]', deleted, flags=3Dre.DOTALL):
        proc.stdin.write('n\n')
    else:
        proc.stdin.write('y\n')
    ch =3D os.read(proc.stdout.fileno(), 1).decode('utf-8')

try:
    proc.wait(1)
except:
    print(f"{sys.argv[0]}: git-add appears to hang, sending SIGTERM",
          file=3Dsys.stderr)
    proc.terminate()
proc.wait()

if proc.returncode !=3D 0:
    print(f"{sys.argv[0]}: git-add terminated abnormally (code=3D{proc.retu=
rncode})",
          file=3Dsys.stderr)


