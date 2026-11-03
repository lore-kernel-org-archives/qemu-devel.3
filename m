Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D747606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=CKe5KkX8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFtX-0006W3-O4; Tue, 03 Nov 2026 09:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xOFtU-0006Va-Az
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:53:48 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xOFtR-0007Vv-GI
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:53:47 -0500
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A3ErbrG037568
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Nov 2026 23:53:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=pRNSOHDtdn0inWxvT4HrWlDLQnVBnHumStCZMA+Q3xQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1793717617; v=1;
 b=CKe5KkX8HOTKzhP+t04DsHNgoIjM8EXULbz/TuKvRgFznyjuSCcB+bUK0vmd7Lir
 FWO8ZMQ1hci63ve+6h49FKskR1/ENkbSIydQbW4yDGIC+hw8GPgLkdcELcED/Epq
 eEgIlXLHJEjOYgRMQe9Aub7SJPLvRtMql+o8Iv94IrKv0Me1FV9KZraS53NPzVD1
 5peFCvhVDfnbm+cyimMGJFzAlneNUo/dIQ6AYGyTNKYryD6lHUR+ieoybYfENkhR
 I5ufM0HVwgV5eQM8pxtxhrlZGhclVFeJfArMaPTgced1Y9pTR9bCtNJ3gT9P52w2
 Ynq8xfS8fH0PaAnZfPUSUA==
Message-ID: <28ef8bbc-f75d-45a6-86b8-7bc3af553c9f@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 3 Nov 2026 23:53:37 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] net/eth.c: In eth_get_protocols(), don't report
 SCTP header off end of packet
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
 <20261102201828.1879576-4-peter.maydell@linaro.org>
 <865c4fd3-ea62-474c-97fb-7940068553eb@oss.qualcomm.com>
 <CAFEAcA9uA6isj0Q5aLtD=LcFrMaAYfP9cq4hdxwU2Eik-zuRzA@mail.gmail.com>
 <c173e981-3589-4731-9220-d9d1b75878e9@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c173e981-3589-4731-9220-d9d1b75878e9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/03 22:57, Philippe Mathieu-Daudé wrote:
> On 2026-11-03 14:24, Peter Maydell wrote:
>> On Tue, 3 Nov 2026 at 11:51, Philippe Mathieu-Daudé
>> <philmd@oss.qualcomm.com> wrote:
>>>
>>> On 2026-11-02 21:18, Peter Maydell wrote:
>>>> eth_get_protocols() parses an ethernet packet and tells the caller
>>>> about various offsets into it and other properties of the packet.
>>>> For the L4 protocol, in both the IP_PROTO_TCP and IP_PROTO_UDP
>>>> branches we implicitly check that the packet does contain a whole TCP
>>>> or UDP header at the l4hdr_off offset, because _eth_copy_chunk() will
>>>> fail if the input packet size isn't big enough for the whole header
>>>> we are copying out of it.  But for IP_PROTO_SCTP we don't copy the
>>>> SCTP common header.  In this case we should still do the length
>>>> check, so we don't set l4hdr_info->proto to say there's an SCTP
>>>> header present when there isn't.
>>>>
>>>> This shouldn't have any visible effects if the downstream consumers
>>>> of the l4hdr_info are conservative about checking before they access
>>>> into the packet, but checking here too adds defence in depth, hence
>>>> the cc to stable.
>>>>
>>>> Cc: qemu-stable@nongnu.org
>>>> Fixes: 907209e311 ("igb: Implement Rx SCTP CSO")
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>>    include/net/eth.h | 2 ++
>>>>    net/eth.c         | 9 ++++++++-
>>>>    2 files changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/net/eth.h b/include/net/eth.h
>>>> index 46dc9ed5acd..e10684ed923 100644
>>>> --- a/include/net/eth.h
>>>> +++ b/include/net/eth.h
>>>> @@ -394,6 +394,8 @@ typedef struct eth_l4_hdr_info_st {
>>>>        bool has_tcp_data;
>>>>    } eth_l4_hdr_info;
>>>>
>>>> +#define SCTP_COMMON_HEADER_LEN 12
>>>> +
>>>>    void eth_get_protocols(const struct iovec *iov, size_t iovcnt, 
>>>> size_t iovoff,
>>>>                           bool *hasip4, bool *hasip6,
>>>>                           size_t *l3hdr_off,
>>>> diff --git a/net/eth.c b/net/eth.c
>>>> index bc26d38dc21..341d3bdf02b 100644
>>>> --- a/net/eth.c
>>>> +++ b/net/eth.c
>>>> @@ -213,7 +213,14 @@ void eth_get_protocols(const struct iovec *iov, 
>>>> size_t iovcnt, size_t iovoff,
>>>>            break;
>>>>
>>>>        case IP_PROTO_SCTP:
>>>> -        l4hdr_info->proto = ETH_L4_HDR_PROTO_SCTP;
>>>> +        /*
>>>> +         * We don't copy the SCTP common header into l4hdr_info, but
>>>> +         * don't report SCTP as present if the packet isn't big enough
>>>> +         * to actually have an SCTP header.
>>>> +         */
>>>> +        if (*l4hdr_off > input_size - SCTP_COMMON_HEADER_LEN) {
>>>
>>> Hmm don't we want the opposite "is SCTP common header complete" check?
>>>
>>>              if (input_size >= *l4hdr_off
>>>                  && input_size - *l4hdr_off >= SCTP_COMMON_HEADER_LEN) {
>>
>> Whoops, yes, I have the sense of the test the wrong way around,
>> should be
>>     (*l4hdr_off <= input_size - SCTP_COMMON_HEADER_LEN)
>>
>> Doing it this way we know we aren't going to underflow on
>> the subtraction (input_size must be bigger than 12 if we got here)
>> so we don't need to explictly also check for
>> input_size >= *l4hdr_off, but maybe that's being too
>> clever and your way of writing it is better?
> 
> Ah indeed I didn't read the full function body, we already have
> a complete IP header so we are sure input_size >= 12. Let's go with
> your way otherwise static analyzers might complain later about
> impossible check.>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

With [1], I think the following would be better:
     input_size - *l4hdr_off <= SCTP_COMMON_HEADER_LEN

input_size >= l4hdr_off is already enforced for IPv6, but not for IPv4. 
[1] enforces that for IPv4 since failing to do so is inconsistent and 
led to an out-of-bounds access [2].

SCTP header length and IP header lengths are independent values, and we 
can avoid making assumptions between them this way.

Regards,
Akihiko Odaki

[1] 
https://lore.kernel.org/qemu-devel/20260920-eth-v1-1-ddd05ce24843@rsg.ci.i.u-tokyo.ac.jp/
[2] https://gitlab.com/qemu-project/qemu/-/work_items/4155

