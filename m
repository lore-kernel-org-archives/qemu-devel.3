Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976BBC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 08:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u241o-0008Tj-SJ; Tue, 08 Apr 2025 04:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u241m-0008TG-LC
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 04:09:50 -0400
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u241k-0006zk-0j
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 04:09:50 -0400
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id AC7F65F19C464;
 Tue,  8 Apr 2025 10:09:43 +0200 (CEST)
Message-ID: <0736943f-443b-4bfc-8d69-f30f42029d07@lauterbach.com>
Date: Tue, 8 Apr 2025 10:09:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Add Multi-Core Debug (MCD) API support
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 christian.boenig@lauterbach.com
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
 <87semkw3qx.fsf@pond.sub.org>
 <ea767dfa-d52b-44fc-baec-deea0223094f@lauterbach.com>
 <87semjp286.fsf@pond.sub.org>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <87semjp286.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1744099783713
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

Apologies for the line wrapping in yesterday's answer. Should be fixed now.

On 08.04.2025 09:00, Markus Armbruster wrote:
> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
> 
>> Thanks a lot for the response, I really appreciate your time.
>>
>> On 07.04.2025 14:33, Markus Armbruster wrote:
>>
>>> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>>>
>>>> This patch series introduces support for the Multi-Core Debug (MCD) API, a
>>>> commonly used debug interface by emulators. The MCD API, defined through a
>>>> header file, consists of 54 functions for implementing debug and trace.
>>>> However, since it is a header-file-only interface, MCD does not specify a
>>>> communication protocol. We get around this limitation by following a remote
>>>> procedure call approach using QMP. The client stub corresponding to this
>>>> implementation can be found at https://gitlab.com/lauterbach/mcdrefsrv
>>>>
>>>> This series is the successor to:
>>>> "[PATCH v5 00/18] first version of mcdstub"
>>>> (https://patchew.org/QEMU/20231220162555.19545-1-nicolas.eder@lauterbach.com/)
>>>>
>>>> * Architecture-independent MCD implementation
>>>> * QMP instead of custom TCP protocol
>>>
>>> Rationale?  There must be pros and cons.
>>
>> Assuming you're referring to the protocol of the previous patch series:
>> The previous TCP protocol only supported a subset of MCD. As the 
>> implementation progresses, the protocol eventually needs to be extended, 
>> possibly resulting in backwards compatibility problems.
>> Following an RPC approach and keeping the communication layer as close 
>> to the MCD API as possible results in a larger protocol at first, but 
>> does not need to be changed afterwards.
>> By directly mapping MCD functions onto QMP commands, the complexity in 
>> the server and client stubs can be minimized.
>>
>> Assuming you're referring to the QMP choice:
>> QMP is being described as the "protocol which allows applications to 
>> control a QEMU instance".
>> It provides a RPC framework which automatically (de)serializes methods 
>> and their parameters, even inside QTests.
>> The whole interface is automatically documented.
> 
> Let's see whether I understand.
> 
> MCD is an established C interface.
> 
> Your goal is to provide remote MCD for QEMU, i.e. the client uses the
> MCD C interface, and the interface's implementation talks to an MCD
> server integrated into QEMU via some remote transport.
> 
> The previous version connects the two with a bespoke protocol via TCP.
> The client software translates between the C interface and this
> protocol.  QEMU implements the protocol's server side.  Designing and
> maintaining a protocol is expensive.
> 
> This versions makes two changes:
> 
> 1. Instead of layering a protocol on top of MCD, you use MCD directly.
> This eliminates protocol design and maintenance.  Moreover, translation
> becomes straightforward marshaling / unmarshaling for the transport.
> 
> 2. You use QMP as a transport.  This gets you marshaling / unmarshaling
> for free.  It also provides some useful infrastructure for tests,
> documentation and such.
> 
> Fair?

Couldn't have put it better myself.

>>> How much data would you expect to flow in practical usage?  QMP isn't
>>> designed for bulk transfer...
>>
>> According to ifstat, the expected data rate in practical usage is around
>>
>> KB/s in  KB/s out
>>     100      100
>>
>> I fully understand your concern and agree that a JSON-based
>> protocol does not result in the lowest data rate.
>>
>> If the data rate is the highest priority: *Before* the QMP supported was 
>> implemented, the MCD interface was built on a custom RPC framework, 
>> generated with the code generator at:
>>
>> https://gitlab.com/lauterbach/mcdrefsrv/-/tree/main/codegen
>>
>> The resulting header file was basically a set of functions capable of 
>> serializing MCD's function arguments into a byte stream and vice-versa:
>>
>> https://gitlab.com/lauterbach/mcdrefsrv/-/blob/df754cef7f19ece2d00b6ce4e307ba37e91e5dcb/include/mcd_rpc.h
>>
>> The QMP support was added because of the advantages listed above and in 
>> order to evade yet another custom communication protocol.
>> As a user of the MCD interface, I haven't noticed any negative impact of 
>> the increased data rate in realistic debugging scenarios, even when 
>> trying to drive the data rate up. If that would have been the case, I 
>> would have sent this patch request with our custom RPC protocol.
> 
> I see.
> 
>>>> qemu-system-<arch> [options] -qmp tcp::1235,server=on,wait=off
>>>>
>>>> * Architecture-independent QTest test suite
>>>>
>>>> V=1 QTEST_QEMU_BINARY="./qemu-system-<arch> [options]" tests/qtest/mcd-test
>>>>
>>>> * Architecture-specific tests can be found at the client stub
>>>
>>> [...]
>>>
>>>>   qapi/mcd.json             | 2366 ++++++++++++++++++++++
>>>
>>> This is *massive*.  By non-blank, non-comment lines, it's the second
>>> largest module in qapi/, almost 9% of the entire schema.  It's larger
>>> than the entire QEMU guest agent QAPI schema.  The QAPI generator
>>> generates some 280KiB of C code for it.
>>
>> I understand your point and I think it touches on the point made above 
>> regarding MCD's complexity:
>>
>>> mcd/mcd_api.h             | 3963 +++++++++++++++++++++++++++++++++++++
> 
> Uh, that's a big one.
> 
> Out of curiosity, what's the size of the previous version's code to
> translate between the C interface and TCP?

The previous version's protocol was very similar to GDB's remote serial
protocol which is why the size of its implementation is comparable to
that of gdbstub.c

> debug/mcdstub/mcdstub.c                  | 2481 ++++++++++++++++++++++

Note that this file contains both the transport layer as well as the
implementation and does not implement mcd_api.h which makes the two
patch sets difficult to compare.

>> I hope that we agree that RPC is generally the right approach to 
>> implement MCD. As far as the implementation is concerned, I'm open to 
>> any suggestion you have. I've always avoided to introduce any 
>> unnecessary external dependencies.
> 
> I think you're much better qualified to judge the merits of RPC here
> than I am.  That leaves the question of the RPC transport.  You want to
> use QMP.

I think that QMP is the more mature protocol than my RPC
proof-of-concept and would improve interoperability. However, our
open-source client stub supports both transport layers, so we're fine
with both.

> On the one hand, I'm tickled to see QAPI/QMP used for things it wasn't
> designed for.

Might be a language issue but I can't tell whether that's meant
positively or negatively.

> On the other hand, QMP has grown so big.  Keeping it cohesive has become
> a near-impossible mission.
> 
> Hmm.
> 
> We already provide another remote debugger interface: the GDB stub.
> It's optional, i.e. the user has to create it, either with command line
> option -gdb, or monitor command gdbserver.

We had that option in our previous patch set:

> $ qemu-system-arm -M virt -cpu cortex-a15 -mcd tcp::1235

If you'd like, we can of course add such an option again. The QMP choice
made that redundant for me because I wasn't aware of a way to only
provide a subset of QMP.

> We already have two-and-a-half QMPs: qemu-system-FOO's QMP,
> qemu-storage-daemon's QMP (subset of the previous, so it counts only
> half), and qemu-ga's QMP-like protocol.
> 
> What about providing the MCD interface as a separate QMP-like protocol?
> It gets its own QAPI schema, just like for qemu-ga.  Simplifies
> compiling it out when not needed.
> It gets its own socket, just like the GDB stub.  Might reduce
> interference between debugging and QMP.
> 
> Thoughts?  Alex, Philippe, care to chime in?

Sound reasonable to me. Keeping in mind the size of generated QAPI code,
an option to `./configure [...] --enable-mcd` is definitely advisable.


