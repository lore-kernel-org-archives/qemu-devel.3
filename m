Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C8ACD6E56
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 13:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJX8d-0005NG-VK; Thu, 13 Nov 2025 08:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vJWzR-0000pV-Es
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 08:03:54 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vJWzO-0000mB-Q6
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 08:03:53 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 31DE4C2674;
 Thu, 13 Nov 2025 16:03:45 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:833::1:4] (unknown [2a02:6bf:8080:833::1:4])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id i3Q3lF0FCW20-Fgqc3lGD; Thu, 13 Nov 2025 16:03:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1763039024;
 bh=ciU3aXCWZGgHKH7O0PqFP+T3H7ffTp7RkFBd4c8qBBU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VQzCoDX7EmHTLpnUkvdocextIWmIUkAqxGbCaMxPOuOJbKeaRylSMfPdvtIcQhHn9
 9+e3TJmHcCJz2CNtD08K/+oxUT9UXEhD1Hqj5/xFJqXOq7qHHi0uaNLHNHqmzunnz/
 s6ABvbuUF68pOJP4q6Wuv1PPY/5AERzlqPH6GMR8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8cafef2c-24c1-43f1-aefb-3ad06199d159@yandex-team.ru>
Date: Thu, 13 Nov 2025 16:03:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/unit: add unit test for qemu_hexdump()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
References: <20251113064935.342018-1-vsementsov@yandex-team.ru>
 <aRWgdCWsEr3cCSNl@redhat.com>
 <84b8a084-d8f3-4515-a6f8-23aaca080b37@yandex-team.ru>
 <aRWz63pC5fsdYRsq@redhat.com>
 <CAFEAcA8433bHWqbb0cC2myY=7NKqPb1M3r+y3_mXH=QQuCoYJQ@mail.gmail.com>
 <aRXCes0Y2xMPYfS2@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aRXCes0Y2xMPYfS2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 13.11.25 14:35, Daniel P. Berrangé wrote:
> On Thu, Nov 13, 2025 at 10:46:42AM +0000, Peter Maydell wrote:
>> On Thu, 13 Nov 2025 at 10:33, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>
>>> On Thu, Nov 13, 2025 at 01:20:15PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> On 13.11.25 12:10, Daniel P. Berrangé wrote:
>>>>> On Thu, Nov 13, 2025 at 09:49:35AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Test, that fix in previous commit make sense.
>>>>>>
>>>>>> To not break compilation when we build without
>>>>>> 'block', move hexdump.c out of "if have_block"
>>>>>> in meson.build.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>>>> ---
>>>>>>
>>>>>> v3: change meson.build to compile hexdump.c always
>>>>>>
>>>>>>    tests/unit/test-cutils.c | 43 ++++++++++++++++++++++++++++++++++++++++
>>>>>>    util/meson.build         |  2 +-
>>>>>>    2 files changed, 44 insertions(+), 1 deletion(-)
>>>>>
>>>>>> +static void test_qemu_hexdump_alignment(void)
>>>>>> +{
>>>>>> +    /*
>>>>>> +     * Test that ASCII part is properly aligned for incomplete lines.
>>>>>> +     * This test catches the bug that was fixed in previous commit
>>>>>> +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
>>>>>> +     *
>>>>>> +     * We use data that is not aligned to 16 bytes, so last line
>>>>>> +     * is incomplete.
>>>>>> +     */
>>>>>> +    const uint8_t data[] = {
>>>>>> +        /* First line: 16 bytes */
>>>>>> +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello Wo" */
>>>>>> +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! Thi" */
>>>>>> +        /* Second line: 5 bytes (incomplete) */
>>>>>> +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
>>>>>> +    };
>>>>>> +    char *output = NULL;
>>>>>
>>>>> Could be  g_autofree, and avoid the later 'free()' call.
>>>>
>>>> I'm not sure that it's correct to replace free() by g_free()..
>>>>
>>>> Documentation says "bad things can happen" https://docs.gtk.org/glib/memory.html
>>>
>>> Note where it says:
>>>
>>>    "Since GLib 2.46, g_malloc() is hardcoded to always use the system
>>>     malloc implementation."
>>>
>>> I added that guarantee to glib docs specifically so apps no longer
>>> have to match free with g_free.  You should still not mix up the
>>> C free vs C++ delete, or  free vs g_slice_free, but that's not an
>>> issue for QEMU.
>>
>> I think for this specific case (the buffer allocated by
>> open_memstream()) it's probably better to use explicit
>> free(), because the criterion for "when is it OK to free
>> this?" is not "when the pointer goes out of scope" but
>> "when we have called fclose() on the stream". Auto-freeing
>> the buffer by returning without closing the file would
>> be a bug.
> 
> Oh good point, lets just leave this as-is.
> 
> 

Ok.



-- 
Best regards,
Vladimir

