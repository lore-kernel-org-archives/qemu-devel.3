Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C20C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weTGu-0001cU-Hl; Tue, 30 Jun 2026 03:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1weTGq-0001c2-DQ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 03:52:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1weTGm-0000aA-Ey
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 03:52:40 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65U7q9J0092839
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 30 Jun 2026 16:52:09 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=OeqjAs7c8KOPo4XIP1Ri3UwTBEqyE7yB1iTCKCHX5js=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782805929; v=1;
 b=jzXrToZWc9iLf9oCc/HpeYQTgg75BWQ4GsZGqMUKwTCFA70GnDe00LnKmW6YyFci
 CSfjfYbohwk3boO3BBoMegxXs+ZWGlI+NCkrsTsF2K+MzEUZTlU7tATLZFrjk4zA
 93jv6/7sjzn7TohRhU5rSMp4V69yQtUFyknhj6pM7z9HUagoaBgRbiPOl/TN18dR
 hmO1btCiK8hDFfQ51psCq12qMIZW9K2aeMaXITNYfOdb6JSqG0zGgKQT9RHGq+j9
 /fnrFb6fGN4OhEVFo2vvqtdYiFr9aNMlNFrrPyvvAUmjp8dt3EGpbCfnREVzZemK
 D+3WGzpZi7c1+gAPlT9W0g==
Message-ID: <f2c35b50-264d-4268-bd0e-dd52fe6269bf@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 30 Jun 2026 16:52:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] igb: Implement Transmit Rate Limiting (TRL)
To: Josh Hilke <jrhilke@google.com>
Cc: qemu-devel@nongnu.org, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
 <ff0bcd39-afd6-4842-9cd5-3e39e56ec901@rsg.ci.i.u-tokyo.ac.jp>
 <CAAdrzjtjVyG-yV+MnZ5wtgef3UQ-MLCWZtHh9feeBK4ek4YXJg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAAdrzjtjVyG-yV+MnZ5wtgef3UQ-MLCWZtHh9feeBK4ek4YXJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/06/30 3:11, Josh Hilke wrote:
> Do I need to push a v9 to include your "Reviewed-by" tag?

No. I think this series is ready to pull along with other network patches.

Regards,
Akihiko Odaki

> 
> Thanks,
> Josh
> 
> On Wed, Jun 24, 2026 at 1:18 AM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/06/24 0:05, Josh Hilke wrote:
>>> This is v8 of a patch series implementing the Transmit Rate Limiter (TRL) feature for
>>> the Intel 82576 (igb) network device emulation in QEMU.
>>>
>>> v7: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg05440.html
>>>
>>> Changelog:
>>>
>>> v8:
>>>     - Fix extraneous whitespace modifications.
>>>     - Use muldiv64() in igb_trl_calculate_delay().
>>>     - Fix comment for rate factor in igb_trl_calculate_delay().>
>>> Signed-off-by: Josh Hilke <jrhilke@google.com>
>>
>> For the whole series:
>>
>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
>> Regards,
>> Akihiko Odaki
>>
>>> ---
>>> Josh Hilke (7):
>>>         igb: Define TRL registers and core state
>>>         igb: Add VMState support for TRL state
>>>         igb: Implement TRL register write and configuration
>>>         igb: Refactor TX path to return processed byte count
>>>         igb: Implement TRL throttling and timer resumption
>>>         igb: Add QTest for Transmit Rate Limiter register multiplexing
>>>         igb: Add QTest for Transmit Rate Limiter traffic throttling
>>>
>>>    hw/net/igb.c           |  43 +++++++++++
>>>    hw/net/igb_common.h    |   1 +
>>>    hw/net/igb_core.c      | 142 ++++++++++++++++++++++++++++++++--
>>>    hw/net/igb_core.h      |  12 +++
>>>    hw/net/igb_regs.h      |   5 ++
>>>    tests/qtest/igb-test.c | 206 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>    6 files changed, 404 insertions(+), 5 deletions(-)
>>> ---
>>> base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
>>> change-id: 20260608-igb-trl-19be198da6f2
>>>
>>> Best regards,
>>


