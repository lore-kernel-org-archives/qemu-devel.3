Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876FAC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 04:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucct4-0001DH-M8; Fri, 18 Jul 2025 00:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uccsd-0000gD-JH
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 00:39:31 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uccsZ-0008OG-I6
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 00:39:31 -0400
Received: from [10.105.8.218] ([192.51.222.130]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56I4cuIs010090
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 18 Jul 2025 13:38:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=DRFKth82aOWZ+jWv0DgMGzCOWSv+/8AQ4+9M9pIi908=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752813536; v=1;
 b=W+/ntnUaXq0BQ1rfuLfPXcBOyiSUgiJxvGMuqhAblJidtrAU6BJsUbqc44PGN0MD
 70G4P5o0ZZucFWihcpTn815bTZtQEf9PT8bOUwPuOucNjPQ5dY29ftO3Is8gFr1+
 CN8RhxHAdq9SE8CEd8AGn1picqqjY5eROXUCMsnUObMhV4WwPzQZCoirUXm8Sfad
 5hUKaWCe+FjPJSMugArHE4EMeuYeAF21gBSIdeSgDXPjMIdXFGofoS24Ms2JFq3E
 C5kExLP/uZ+V54UYnt+2Ltvi6/erstdQifFWeSARGYxoICxTAqYABSpL86kyLhfJ
 6Gdumz0HWHFSBTa+Rxgfew==
Message-ID: <d0c816b5-682f-4c06-b7da-1754fc94507d@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 18 Jul 2025 13:38:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 12/13] net: implement tunnel probing
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <94ffdec876d61f22a90e63d6a79ff5517d1c727c.1752229731.git.pabeni@redhat.com>
 <93de161a-3867-46aa-bfc0-2da951981bcf@rsg.ci.i.u-tokyo.ac.jp>
 <e6626fe6-c66c-4b16-93e4-447e43379424@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <e6626fe6-c66c-4b16-93e4-447e43379424@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/07/16 0:49, Paolo Abeni wrote:
> On 7/15/25 10:05 AM, Akihiko Odaki wrote:
>> On 2025/07/11 22:02, Paolo Abeni wrote:
>>> diff --git a/net/tap-bsd.c b/net/tap-bsd.c
>>> index 86b6edee94..e7de0672f4 100644
>>> --- a/net/tap-bsd.c
>>> +++ b/net/tap-bsd.c
>>> @@ -217,6 +217,11 @@ int tap_probe_has_uso(int fd)
>>>        return 0;
>>>    }
>>>    
>>> +int tap_probe_has_tunnel(int fd)
>>
>> This should return bool for consistency.
> 
> Some inconsistency will persist, as others bsd helpers supposed to
> return a bool currently return an int. I tried to be consistent with the
> surrounding code, but no strong objections.

That's true, but when considering the entire codebase, it is so common 
to return bool instead of int. So I regard the existing tap-local 
functions as exceptional, and making a new function return bool results 
in a better global consistency.

Regards,
Akihiko Odaki

