Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E70CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8exG-00034E-1U; Tue, 14 Oct 2025 09:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8ex6-00031S-Ld
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:20:35 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8ewz-0007DQ-SN
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:20:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B4E1C8083A;
 Tue, 14 Oct 2025 16:20:17 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8a::1:35] (unknown
 [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GKPudV1FjGk0-L6rVyz7T; Tue, 14 Oct 2025 16:20:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760448017;
 bh=lodDHWMjqZAXpPJKMgmVWwdu72oQ6pugAKgT81HDYIU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=IkQISwWf/UhjLucThPjtJWkftg7veZSk3uduE8xwx3+q40nWNNUfy6MCKa3cCilnD
 +ns51/iquA5sdcqFvdK1VGzk3QOTVRRXUMQ2iXyftiVdtIiYnp9p1RdDhY6Xa6/l1O
 HC8opwMbmWfDNgYuCHjrxyASsPNKTmoS0Mhx1m4Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <21c725a8-4398-468d-8341-0b0c0ddc8fb2@yandex-team.ru>
Date: Tue, 14 Oct 2025 16:20:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 14/16] chardev: qemu_chr_open_fd(): add errp
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
 <20250919115017.1536203-15-berrange@redhat.com>
 <CAFEAcA8AE4AcF6VOAPmtNeJi1XRBXityX1mLPw6K9+++VW6EEw@mail.gmail.com>
 <f5e98585-6ad2-4e54-97db-0c4019380ee7@yandex-team.ru>
 <CAFEAcA-z8F2aVx7cCqCoWCXJkD+onzGAvd1DiO=dVGKZoO7N8A@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFEAcA-z8F2aVx7cCqCoWCXJkD+onzGAvd1DiO=dVGKZoO7N8A@mail.gmail.com>
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

On 14.10.25 15:52, Peter Maydell wrote:
> On Mon, 22 Sept 2025 at 15:27, Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> On 22.09.25 16:45, Peter Maydell wrote:
>>> On Fri, 19 Sept 2025 at 12:55, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>
>>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>>
>>>> Every caller already support errp, let's go further.
>>>>
>>>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>
>>> Coverity reports a bug in this change (CID 1630444):
>>>
>>>
>>>> diff --git a/chardev/char-file.c b/chardev/char-file.c
>>>> index a9e8c5e0d7..89e9cb849c 100644
>>>> --- a/chardev/char-file.c
>>>> +++ b/chardev/char-file.c
>>>> @@ -92,7 +92,11 @@ static void qmp_chardev_open_file(Chardev *chr,
>>>>            }
>>>>        }
>>>>
>>>> -    qemu_chr_open_fd(chr, in, out);
>>>> +    if (!qemu_chr_open_fd(chr, in, out, errp)) {
>>>> +        qemu_close(out);
>>>> +        qemu_close(in);
>>>
>>> Here 'in' can be -1 (if there is only an output file
>>> and no separate input file specified), so we can
>>> try to close(-1). Suggested fix:
>>>
>>>            if (in >= 0) {
>>>                qemu_close(in);
>>>            }
>>
>> Agree. I'll send a patch.
> 
> Hi -- did you ever send a patch for this? (I was just looking
> through our still-outstanding coverity issues and noticed this
> one still there.)
> 

Oops, seems not :/ At least, I can't find it. Will send inside
[PATCH v3 0/7] chardev: postpone connect

-- 
Best regards,
Vladimir

