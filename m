Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E482C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u22wh-0005km-WF; Tue, 08 Apr 2025 03:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u22wd-0005k9-TY
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u22wb-0007Vl-C1
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744095622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EkBZOPg+hWg18y9sL80iAAS9WgVi1DmIpBKFjHjJxw0=;
 b=imZEmNtoEZtt25uQmIk0iskE9SE8V6XOGUYJiPHktH05Zmci7jpzu85J6m9mrDicD9bhhL
 50ttzL2z6tu645xlPtfNenYOhnAayuqi218pvnCBwR2T435rPOqVfWe3nojgt5nYryTO+A
 b00nTm19F0JJxZgMxG4P84Y+1OYiins=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-eDCiRRa8PY-PPXKn01lr8g-1; Tue,
 08 Apr 2025 03:00:16 -0400
X-MC-Unique: eDCiRRa8PY-PPXKn01lr8g-1
X-Mimecast-MFC-AGG-ID: eDCiRRa8PY-PPXKn01lr8g_1744095614
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 502D919560B0; Tue,  8 Apr 2025 07:00:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 390B63001D15; Tue,  8 Apr 2025 07:00:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E15F21E6757; Tue, 08 Apr 2025 09:00:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: qemu-devel@nongnu.org,  alex.bennee@linaro.org,  philmd@linaro.org,
 christian.boenig@lauterbach.com
Subject: Re: [PATCH 00/16] Add Multi-Core Debug (MCD) API support
In-Reply-To: <ea767dfa-d52b-44fc-baec-deea0223094f@lauterbach.com> (Mario
 Fleischmann's message of "Mon, 7 Apr 2025 19:26:09 +0200")
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
 <87semkw3qx.fsf@pond.sub.org>
 <ea767dfa-d52b-44fc-baec-deea0223094f@lauterbach.com>
Date: Tue, 08 Apr 2025 09:00:09 +0200
Message-ID: <87semjp286.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:

> Thanks a lot for the response, I really appreciate your time.
>
> On 07.04.2025 14:33, Markus Armbruster wrote:
>
>> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>> 
>>> This patch series introduces support for the Multi-Core Debug (MCD) API, a
>>> commonly used debug interface by emulators. The MCD API, defined through a
>>> header file, consists of 54 functions for implementing debug and trace.
>>> However, since it is a header-file-only interface, MCD does not specify a
>>> communication protocol. We get around this limitation by following a remote
>>> procedure call approach using QMP. The client stub corresponding to this
>>> implementation can be found at https://gitlab.com/lauterbach/mcdrefsrv
>>>
>>> This series is the successor to:
>>> "[PATCH v5 00/18] first version of mcdstub"
>>> (https://patchew.org/QEMU/20231220162555.19545-1-nicolas.eder@lauterbach.com/)
>>>
>>> * Architecture-independent MCD implementation
>>> * QMP instead of custom TCP protocol
>> 
>> Rationale?  There must be pros and cons.
>
> Assuming you're referring to the protocol of the previous patch series:
> The previous TCP protocol only supported a subset of MCD. As the 
> implementation progresses, the protocol eventually needs to be extended, 
> possibly resulting in backwards compatibility problems.
> Following an RPC approach and keeping the communication layer as close 
> to the MCD API as possible results in a larger protocol at first, but 
> does not need to be changed afterwards.
> By directly mapping MCD functions onto QMP commands, the complexity in 
> the server and client stubs can be minimized.
>
> Assuming you're referring to the QMP choice:
> QMP is being described as the "protocol which allows applications to 
> control a QEMU instance".
> It provides a RPC framework which automatically (de)serializes methods 
> and their parameters, even inside QTests.
> The whole interface is automatically documented.

Let's see whether I understand.

MCD is an established C interface.

Your goal is to provide remote MCD for QEMU, i.e. the client uses the
MCD C interface, and the interface's implementation talks to an MCD
server integrated into QEMU via some remote transport.

The previous version connects the two with a bespoke protocol via TCP.
The client software translates between the C interface and this
protocol.  QEMU implements the protocol's server side.  Designing and
maintaining a protocol is expensive.

This versions makes two changes:

1. Instead of layering a protocol on top of MCD, you use MCD directly.
This eliminates protocol design and maintenance.  Moreover, translation
becomes straightforward marshaling / unmarshaling for the transport.

2. You use QMP as a transport.  This gets you marshaling / unmarshaling
for free.  It also provides some useful infrastructure for tests,
documentation and such.

Fair?

>> How much data would you expect to flow in practical usage?  QMP isn't
>> designed for bulk transfer...
>
> According to ifstat, the expected data rate in practical usage is around
>
> KB/s in  KB/s out
>     100      100
>
> I fully understand your concern and agree that a JSON-based
> protocol does not result in the lowest data rate.
>
> If the data rate is the highest priority: *Before* the QMP supported was 
> implemented, the MCD interface was built on a custom RPC framework, 
> generated with the code generator at:
>
> https://gitlab.com/lauterbach/mcdrefsrv/-/tree/main/codegen
>
> The resulting header file was basically a set of functions capable of 
> serializing MCD's function arguments into a byte stream and vice-versa:
>
> https://gitlab.com/lauterbach/mcdrefsrv/-/blob/df754cef7f19ece2d00b6ce4e307ba37e91e5dcb/include/mcd_rpc.h
>
> The QMP support was added because of the advantages listed above and in 
> order to evade yet another custom communication protocol.
> As a user of the MCD interface, I haven't noticed any negative impact of 
> the increased data rate in realistic debugging scenarios, even when 
> trying to drive the data rate up. If that would have been the case, I 
> would have sent this patch request with our custom RPC protocol.

I see.

>>> qemu-system-<arch> [options] -qmp tcp::1235,server=on,wait=off
>>>
>>> * Architecture-independent QTest test suite
>>>
>>> V=1 QTEST_QEMU_BINARY="./qemu-system-<arch> [options]" tests/qtest/mcd-test
>>>
>>> * Architecture-specific tests can be found at the client stub
>> 
>> [...]
>> 
>>>   qapi/mcd.json             | 2366 ++++++++++++++++++++++
>> 
>> This is *massive*.  By non-blank, non-comment lines, it's the second
>> largest module in qapi/, almost 9% of the entire schema.  It's larger
>> than the entire QEMU guest agent QAPI schema.  The QAPI generator
>> generates some 280KiB of C code for it.
>
> I understand your point and I think it touches on the point made above 
> regarding MCD's complexity:
>
>> mcd/mcd_api.h             | 3963 +++++++++++++++++++++++++++++++++++++

Uh, that's a big one.

Out of curiosity, what's the size of the previous version's code to
translate between the C interface and TCP?

> I hope that we agree that RPC is generally the right approach to 
> implement MCD. As far as the implementation is concerned, I'm open to 
> any suggestion you have. I've always avoided to introduce any 
> unnecessary external dependencies.

I think you're much better qualified to judge the merits of RPC here
than I am.  That leaves the question of the RPC transport.  You want to
use QMP.

On the one hand, I'm tickled to see QAPI/QMP used for things it wasn't
designed for.

On the other hand, QMP has grown so big.  Keeping it cohesive has become
a near-impossible mission.

Hmm.

We already provide another remote debugger interface: the GDB stub.
It's optional, i.e. the user has to create it, either with command line
option -gdb, or monitor command gdbserver.

We already have two-and-a-half QMPs: qemu-system-FOO's QMP,
qemu-storage-daemon's QMP (subset of the previous, so it counts only
half), and qemu-ga's QMP-like protocol.

What about providing the MCD interface as a separate QMP-like protocol?

It gets its own QAPI schema, just like for qemu-ga.  Simplifies
compiling it out when not needed.

It gets its own socket, just like the GDB stub.  Might reduce
interference between debugging and QMP.

Thoughts?  Alex, Philippe, care to chime in?


