Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35CBCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 15:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utpM8-0005WI-99; Wed, 03 Sep 2025 11:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utpM4-0005Vc-UF
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 11:25:01 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utpM1-0003yL-BA
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 11:25:00 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 165728062D;
 Wed, 03 Sep 2025 18:24:51 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nOidmi3GliE0-AGUC7p66; Wed, 03 Sep 2025 18:24:50 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756913090;
 bh=NJ5qyrlRYbPZYO2nv63QQNrSfoQ6gE/9tHCfeJEzX30=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=LqfTY+T5m21piMlf6zAurI00tdnorcKyVNYmb3IVcyz1T3CFpTPvX1P+KPYA0fHcP
 KhOegqD75aNmNGxJ8uylL4aFLmPxgFWw/SFGuBOP5Fb7xdEx6lqDME3VdMfbxFGlkb
 gVXJujVkqzK1wb5dZTDnF4254A2gxUZracH7BG4I=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c0d8c104-aa72-4d11-8ccc-243b519f805e@yandex-team.ru>
Date: Wed, 3 Sep 2025 18:24:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] tests/functional: add test_x86_64_tap_fd_migration
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
 <20250903133706.1177633-9-vsementsov@yandex-team.ru>
 <aLhVF3_OFMzKpuUW@redhat.com>
 <2221a821-3650-435b-95d6-26c29c494c31@yandex-team.ru>
 <aLhci8UK4pAnAvjJ@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aLhci8UK4pAnAvjJ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 03.09.25 18:19, Daniel P. Berrangé wrote:
> On Wed, Sep 03, 2025 at 06:14:36PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 03.09.25 17:47, Daniel P. Berrangé wrote:
>>> On Wed, Sep 03, 2025 at 04:37:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Add test for a new feature of local TAP migration with fd passing
>>>> through unix socket.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>    .../test_x86_64_tap_fd_migration.py           | 347 ++++++++++++++++++
>>>>    1 file changed, 347 insertions(+)
>>>>    create mode 100644 tests/functional/test_x86_64_tap_fd_migration.py
>>>>
>>>> diff --git a/tests/functional/test_x86_64_tap_fd_migration.py b/tests/functional/test_x86_64_tap_fd_migration.py
>>>> new file mode 100644
>>>> index 0000000000..f6d18fe39f
>>>> --- /dev/null
>>>> +++ b/tests/functional/test_x86_64_tap_fd_migration.py
> 
> 
>>>> +def init_tap() -> None:
>>>> +    run(f"ip tuntap add dev {TAP_ID} mode tap multi_queue")
>>>> +    run(f"ip link set dev {TAP_ID} address {TAP_MAC}")
>>>> +    run(f"ip addr add {HOST_IP_MASK} dev {TAP_ID}")
>>>> +    run(f"ip link set {TAP_ID} up")
>>>
>>> $ ip tuntap add dev foo mode tap multi_queue
>>> ioctl(TUNSETIFF): Operation not permitted
>>>
>>>
>>> The functional tests run as the developer's normal unprivileged user
>>> account, so it doesn't look like this can work ?
>>>
>>> Were you testing this as root ?
>>
>> Yes I run the test with sudo..
>>
>> Do we have any tests in QEMU that requires root? Or anyway to do this for functional tests? I'm afraid there is no way to setup TAP interface in unprivileged user account :(
> 
> There are a variety of iotests that include calls to sudo.
> 
> These automatically mark themselves as skipped if
> password-less sudo fails to work. So in practice the tests
> will rarely get run, but its better than nothing I guess.
> 
> We should add a skipUnlesPasswordlessSudo() method to the
> tests/functional/qemu_test/decorators.py class, and you
> then then annotate this test with that. Then just add sudo
> to the "ip" calls.
> 

Good, that works for me.

Thanks!

-- 
Best regards,
Vladimir

