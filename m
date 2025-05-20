Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83513C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNm0-0004k9-R9; Tue, 20 May 2025 10:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uHNlt-0004b3-C5
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:16:47 -0400
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uHNlp-00019v-St
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:16:45 -0400
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id 42E3CD1B809F;
 Tue, 20 May 2025 16:16:31 +0200 (CEST)
Message-ID: <2d702238-1eed-4b7b-9226-ac56e88f6bb4@lauterbach.com>
Date: Tue, 20 May 2025 16:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] Add Multi-Core Debug (MCD) API support
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 christian.boenig@lauterbach.com
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <87iklvd99z.fsf@pond.sub.org>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <87iklvd99z.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1747750591279
Received-SPF: pass client-ip=62.154.241.218;
 envelope-from=mario.fleischmann@lauterbach.com; helo=bm.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 20.05.2025 09:36, Markus Armbruster wrote:

> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
> 
>> This patch series introduces support for the Multi-Core Debug (MCD) API, a
>> commonly used debug interface by emulators. The MCD API, defined through a
>> header file, consists of 54 functions for implementing debug and trace.
>> However, since it is a header-file-only interface, MCD does not specify a
>> communication protocol.
>>
>> To keep the overhead of a communication protocol on top of MCD minimal,
>> we follow a remote procedure call approach by using QAPI as an interface
>> definition and transport infrastructure. This way, we can use qapi-gen to
>> take care of generating the infrastructure to dispatch MCD functions and
>> to (un)marshal their arguments and results. Furthermore, qapi-doc and qtest
>> provide good integration into QEMU's documentation and test frameworks.
>>
>> In v1 of this patch series, the MCD protocol was directly integrated in QMP
>> and the QMP monitor was responsible for dispatching MCD's server stub. This
>> introduced a dependency between QEMU's machine protocol and the MCD debug
>> protocol which is not to be expected. For this reason, v2 introduces a MCD
>> monitor which uses as much of the QMP monitor's framework as possible but
>> keeps the two protocols separate from each other.
>> Similarly, MCD's test suite uses as much of the qtest framework as is useful
>> for sending JSON commands to the QEMU under test but adds new code where
>> required to prevent dependencies to QMP.
>>
>> To enable MCD, configure QEMU with `--enable-mcd`.
>>
>> To start the MCD monitor, run QEMU with the `-mcd` option:
>> qemu-system-<arch> [options] -qmp tcp::1235,server=on,wait=off
>>
>> To run the MCD test suite independently, start `mcd-test`:
>> V=1 QTEST_QEMU_BINARY="./qemu-system-<arch> [options]" tests/qtest/mcd-test
>>
>> To connect from a MCD client, a client stub corresponding to this
>> patch series can be found at https://gitlab.com/lauterbach/mcdrefsrv
> 
> I'm okay with the general approach.
> 
> [...]
> 
>>  MAINTAINERS                   |    9 +
>>  docs/interop/index.rst        |    1 +
>>  docs/interop/mcd.rst          |   65 +
>>  gdbstub/gdbstub.c             |   15 +-
>>  include/exec/gdbstub.h        |   18 +-
>>  include/exec/mcdstub.h        |   18 +
>>  mcd/mcd_api.h                 | 3963 +++++++++++++++++++++++++++++++++
>>  mcd/mcd_monitor.c             |   90 +
>>  mcd/mcd_qapi.c                |  505 +++++
>>  mcd/mcd_qapi.h                |   81 +
>>  mcd/mcd_server.c              | 2274 +++++++++++++++++++
>>  mcd/mcd_stub.c                |  988 ++++++++
>>  mcd/meson.build               |   60 +
>>  meson.build                   |    5 +
>>  meson_options.txt             |    3 +
>>  qapi/mcd.json                 | 2366 ++++++++++++++++++++
> 
> The schema is too big for me to review in detail.  I understand it's
> designed to mirror mcd/mcd_api.h closely, so review would be limited to
> checking the way you mirror is sane.  I doubt that would be a good use
> of my time, but if you'd like advice on any non-trivial parts, just ask.

Let's do it this way: As explained in

"Re: [PATCH v2 07/20] mcd: Implement target initialization API"
<a71a747f-d8c3-40ac-ab61-0628dffbb2f6@lauterbach.com>

there are reasons to deviate from mcd/mcd_api.h in mcd/qapi-schema.json.
In v3, I can highlight those changes briefly in the relevant commit
messages. That way, you have the option to focus on the non-trivial parts.

> Some formatting nits caught my eye.  docs/devel/qapi-code-gen.rst
> section "Documentation markup":
> 
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.
> 
>     Separate sentences with two spaces.
> 
> I recommend to read the entire section.

Will do!

