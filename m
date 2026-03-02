Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68632E9B377
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 12:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx2on-0004M5-Gw; Mon, 02 Mar 2026 07:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vx2og-0004Et-7z; Mon, 02 Mar 2026 07:56:07 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vx2ob-0001HE-Gf; Mon, 02 Mar 2026 07:56:05 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 622CsO49056029
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 2 Mar 2026 21:55:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=RH7EBLe7OKFQlzXgGZFErxswz3ztfgkFQZaYOtT/07M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772456145; v=1;
 b=eZ6xHciTtUxifVADGeyUD9gMxAjYCAHYqCS8MpL+y+sb6YVzG8++Zm3nCcIJwfRV
 Mb9Z7blvtoltxP0qvYIj+ydADH4rv8vSv9t4NJ3VbWq52knd0w99yUuPz/V1sBa6
 EQGxICnp6FJNxn8f1wQAVmjKPLww3SGlijCjMVRXTHeRSaCRMAuZiUKl/Q1NwFvk
 dn3l5xYSlIUMGjxeby5hmG+oS+3IDd6abMu4d2nRXAXDhBocXrGAx/Q5VLV1E00g
 scVRSYiaZwbWC2wOxROPEfmn+qJeHdADq+2eQlmst9I5e//5Nh8PvUYeObs86o2G
 +y2F0Cs1w3zE+1NO8PDTWQ==
Message-ID: <a24798b9-1b0d-4801-abdf-7d0c3a2f5a18@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 2 Mar 2026 21:54:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] tests: Grow buffers for double string
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
References: <20260302-nvme-v2-0-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp>
 <20260302-nvme-v2-3-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp>
 <87pl5m1mad.fsf@pond.sub.org> <aaV7R4NFhHvEShti@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aaV7R4NFhHvEShti@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
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

On 2026/03/02 20:57, Daniel P. Berrangé wrote:
> On Mon, Mar 02, 2026 at 12:52:10PM +0100, Markus Armbruster wrote:
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
>>
>>> A string that represents a double can be long if it is an exponentially
>>> large number.
>>>
>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> ---
>>>   tests/unit/test-qobject-input-visitor.c  | 2 +-
>>>   tests/unit/test-qobject-output-visitor.c | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
>>> index 84bdcdf702e0..baff9243313c 100644
>>> --- a/tests/unit/test-qobject-input-visitor.c
>>> +++ b/tests/unit/test-qobject-input-visitor.c
>>> @@ -583,7 +583,7 @@ static void test_visitor_in_list_struct(TestInputVisitorData *data,
>>>   
>>>       i = 0;
>>>       for (num_list = arrs->number; num_list; num_list = num_list->next) {
>>> -        char expected[32], actual[32];
>>> +        char expected[318], actual[318];
>>
>> Where does 318 come from?

The compiler told me the number.

> 
> If we're concerned about buffer sizes being too short, then that
> is a strong sign we should be using g_strdup_printf instead of
> sprintf with a bigger magic size.
> 
> As you say below though, it is better if we eliminate the string
> formatting entirely here since it is irrelevant for the goals of
> this test.
> 
>>
>>>   
>>>           sprintf(expected, "%.6f", (double)i / 3);
>>>           sprintf(actual, "%.6f", num_list->value);
>>             g_assert_cmpstr(expected, ==, actual);
>>             i++;
>>         }
>>
>> Existing code is safe, because the numbers run from 0, 1.0/3, ...,
>> 31.0/3.
>>
>> Its purpose is to check the input visitor parses number arrays
>> correctly.  Doing it this way is questionable.  Elsewhere in this file,
>> we get away with the equivalent of
>>
>>             g_assert_cmpfloat(num_list->value, ==, (double)i / 3);
>>
>> Yes, double can't represent the fractions exactly, but if we're
>> concerned about that, we should test the difference is less than
>> epsilon, or simply use representable values.

I will replace them with representable values.

Regards,
Akihiko Odaki

>>
>>> diff --git a/tests/unit/test-qobject-output-visitor.c b/tests/unit/test-qobject-output-visitor.c
>>> index 407ab9ed505a..ae05a726f775 100644
>>> --- a/tests/unit/test-qobject-output-visitor.c
>>> +++ b/tests/unit/test-qobject-output-visitor.c
>>> @@ -571,7 +571,7 @@ static void test_visitor_out_list_struct(TestOutputVisitorData *data,
>>>       i = 0;
>>>       QLIST_FOREACH_ENTRY(qlist, e) {
>>>           QNum *qvalue = qobject_to(QNum, qlist_entry_obj(e));
>>> -        char expected[32], actual[32];
>>> +        char expected[318], actual[318];
>>>   
>>>           g_assert(qvalue);
>>>           sprintf(expected, "%.6f", (double)i / 3);
>>
>> Likewise.
>>
> 
> With regards,
> Daniel


