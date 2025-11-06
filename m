Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F0ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 08:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGvEM-0004Uh-VC; Thu, 06 Nov 2025 03:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGvEJ-0004U6-Kl; Thu, 06 Nov 2025 03:20:27 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGvEH-0004YE-C9; Thu, 06 Nov 2025 03:20:27 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B1206C014D;
 Thu, 06 Nov 2025 11:20:18 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:95c::1:2] (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HKh3xE0FxW20-vfPQtEwv; Thu, 06 Nov 2025 11:20:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762417218;
 bh=22mRa6KLsurl0fy5cWOg8q8GkeL6H1IslXNhz1/kdTQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=iR7hQ22iSYy9BbdhykjW9zQGDRKz8zv7of4SksnzvHuXGOYz1yBy72zbavVCdAfQ9
 v4VzC1c9mwkFlNHbNStX7DgnsATDG6nyiRK89pSMDwmP7X53KoDS5kTSxGrJ3DBqBd
 5J2Gipj1y2XZPwX2cBT8IB3fy/VdKjG4Xh4+cH3c=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f9174f18-7d9b-451a-b5a5-b430df87b005@yandex-team.ru>
Date: Thu, 6 Nov 2025 11:20:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] iotests: Add coverage of recent NBD qio deadlock fix
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com,
 kwolf@redhat.com, Hanna Reitz <hreitz@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-18-eblake@redhat.com>
 <98abcae5-9768-4a7b-af5a-1cdaa84020af@yandex-team.ru>
 <2cdptk665ijo3ioo7qdjf54qtnmgq5xvib4whtueqosrqzax4j@nhf2ayky7fvr>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <2cdptk665ijo3ioo7qdjf54qtnmgq5xvib4whtueqosrqzax4j@nhf2ayky7fvr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 06.11.25 01:10, Eric Blake wrote:
> On Tue, Nov 04, 2025 at 02:38:22PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 03.11.25 23:10, Eric Blake wrote:
>>> Test that all images in a qcow2 chain using an NBD backing file can be
>>> served by the same process.  Prior to the recent QIONetListener fixes,
>>> this test would demonstrate deadlock.
>>>
>>> The test borrows heavily from the original formula by "John Doe" in
>>> the gitlab bug, but uses a Unix socket rather than TCP to avoid port
>>> contention, and uses a full-blown QEMU rather than qemu-storage-daemon
>>> since both programs were impacted.
>>>
>>> [While preparing this patch by making the new test executable, I
>>> noticed vvfat.out does not need execute permissions]
>>>
>>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3169
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>    tests/qemu-iotests/tests/nbd-in-qcow2-chain   | 84 +++++++++++++++++++
>>>    .../qemu-iotests/tests/nbd-in-qcow2-chain.out | 56 +++++++++++++
>>>    tests/qemu-iotests/tests/vvfat.out            |  0
>>>    3 files changed, 140 insertions(+)
>>>    create mode 100755 tests/qemu-iotests/tests/nbd-in-qcow2-chain
>>>    create mode 100644 tests/qemu-iotests/tests/nbd-in-qcow2-chain.out
>>>    mode change 100755 => 100644 tests/qemu-iotests/tests/vvfat.out
> 
> Should I split out that file mode change to a separate cleanup patch?

Probably. Personally, I don't care.

> 
>>>
>>> diff --git a/tests/qemu-iotests/tests/nbd-in-qcow2-chain b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
>>> new file mode 100755
>>> index 00000000000..b89f74d4552
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
> 
>>> +echo
>>> +echo "=== Creating wrapper image ==="
>>> +
>>> +_make_test_img -F raw -b "nbd+unix:///base?socket=$SOCK_DIR/nbd" $size
>>> +
>>> +echo
>>> +echo "=== Adding wrapper image ==="
>>> +
>>> +_send_qemu_cmd $QEMU_HANDLE '{"execute": "blockdev-add",
>>> +  "arguments": {"node-name":"wrap", "driver":"qcow2",
>>> +     "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' 'return'
>>
>> Hmm. Why don't you specify "backing": "base" here?
> 
> Because the original bug report didn't either.

Ah, I missed the idea: we setup our qcow2 image, so that backing is a
nbd protocol uri. So "backing": "base" would be wrong

>  However, I can see the
> wisdom in enhancing the test to cover multiple scenarios: both a
> backing chain learned only by what is in the qcow2 file, and an
> explicit backing chain where the NBD client is spelled out in the QMP
> code.  I'll see if I can enhance that for v2.
> 
> 

Not sure, that it will add real value to the test.. It should be the same
block-graph finally. If you decide keep it as is (or with vvfat fix dropped):

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir

