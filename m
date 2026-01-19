Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A992D29C4D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhujC-0004ke-So; Mon, 19 Jan 2026 14:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhujB-0004hT-CD
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:15:53 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuj5-00020T-S4
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:15:52 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5a81:0:640:624e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C3E8C8043E;
 Mon, 19 Jan 2026 22:15:43 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:934::1:38] (unknown
 [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gFf52a0CDqM0-ONYOOurE; Mon, 19 Jan 2026 22:15:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768850143;
 bh=BdJKTvUi2zzwuV7dsD+VNzoolGRQCNzwW1giSzrTq5g=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=K7NUFVKJILgP5wWifE4jfihn8FwMnoMcxVKZEhnweZPELnY9UymBywYdtrHqQcjSh
 BfFh4TM281r88TK44+sOXRuSm2gWhJlJrM57591M+yABq0XPlmgVunl9sk1cFPxzcP
 eoQYLGPODCl225lqdM60DSCWi+4PKQMRZKHIdCXY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <036f1f3c-6848-4ce2-af77-5c50616d41c9@yandex-team.ru>
Date: Mon, 19 Jan 2026 22:15:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/unit: add unit test for qemu_hexdump()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
References: <20251113064935.342018-1-vsementsov@yandex-team.ru>
 <a40731d0-7add-4d09-9a89-902f75e2eede@linaro.org>
 <8259d920-32bc-41a7-94b9-cd1af9783b6e@yandex-team.ru>
 <05340117-a75b-4d64-98fe-8868b7bfb5c5@linaro.org>
 <1192488b-51d9-4024-8f76-3b2dd85b3d3c@yandex-team.ru>
 <0a7dfd69-26df-407e-a8cb-543dcefab685@linaro.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <0a7dfd69-26df-407e-a8cb-543dcefab685@linaro.org>
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

On 19.01.26 21:38, Philippe Mathieu-Daudé wrote:
> On 19/1/26 18:26, Vladimir Sementsov-Ogievskiy wrote:
>> On 19.01.26 19:31, Philippe Mathieu-Daudé wrote:
>>> On 19/1/26 16:42, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi! Isn't this patch lost?
>>>>
>>>> On 14.11.25 00:01, Philippe Mathieu-Daudé wrote:
>>>>> On 13/11/25 07:49, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Test, that fix in previous commit make sense.
>>>>>>
>>>>>> To not break compilation when we build without
>>>>>> 'block', move hexdump.c out of "if have_block"
>>>>>> in meson.build.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex- team.ru>
>>>>>> ---
>>>>>>
>>>>>> v3: change meson.build to compile hexdump.c always
>>>>>>
>>>>>>   tests/unit/test-cutils.c | 43 +++++++++++++++++++++++++++++++++++ +++++
>>>>>>   util/meson.build         |  2 +-
>>>>>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
>>>>>> index 227acc5995..24fef16a7f 100644
>>>>>> --- a/tests/unit/test-cutils.c
>>>>>> +++ b/tests/unit/test-cutils.c
>>>>>> @@ -3626,6 +3626,44 @@ static void test_si_prefix(void)
>>>>>>       g_assert_cmpstr(si_prefix(18), ==, "E");
>>>>>>   }
>>>>>> +static void test_qemu_hexdump_alignment(void)
>>>>>> +{
>>>>>> +    /*
>>>>>> +     * Test that ASCII part is properly aligned for incomplete lines.
>>>>>> +     * This test catches the bug that was fixed in previous commit
>>>>>> +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
>>>>>> +     *
>>>>>> +     * We use data that is not aligned to 16 bytes, so last line
>>>>>> +     * is incomplete.
>>>>>> +     */
>>>>>> +    const uint8_t data[] = {
>>>>>> +        /* First line: 16 bytes */
>>>>>> +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello Wo" */
>>>>>> +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! Thi" */
>>>>>> +        /* Second line: 5 bytes (incomplete) */
>>>>>> +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
>>>>>> +    };
>>>>>> +    char *output = NULL;
>>>>>> +    size_t size;
>>>>>> +    FILE *stream = open_memstream(&output, &size);
>>>>>> +
>>>>>> +    g_assert_nonnull(stream);
>>>>>> +
>>>>>> +    qemu_hexdump(stream, "test", data, sizeof(data));
>>>>>> +    fclose(stream);
>>>>>> +
>>>>>> +    g_assert_nonnull(output);
>>>>>> +
>>>>>> +    /* We expect proper alignment of "s is" part on the second line */
>>>>>> +    const char *expected =
>>>>>> +        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 68 69   Hello World! Thi\n"
>>>>>> +        "test: 0010: 73 20 69 73 20                                      s is \n";
>>>>>
>>>>> Thanks, queued wrapping the long lines to pass checkpatch.pl,
>>>>> as in:
>>>>> https://lore.kernel.org/qemu-devel/20251031211518.38503-9- philmd@linaro.org/
>>>
>>> I have it tagged but there is still a meson issue. I should revisit
>>> but it is low in my priority queue.
> 
> Found it, see that pipeline:
> https://gitlab.com/philmd/qemu/-/pipelines/2238533614
> 
> configuring with:  '../configure' ... '--disable-system'
> ...
> FAILED: tests/unit/test-cutils
> /usr/bin/ld: tests/unit/test-cutils.p/test-cutils.c.o: in function `test_qemu_hexdump_alignment':
> test-cutils.c:(.text+0x71): undefined reference to `qemu_hexdump'
> collect2: error: ld returned 1 exit status
> 

Hmm. Interesting, locally it builds for me with same configure line..

-- 
Best regards,
Vladimir

