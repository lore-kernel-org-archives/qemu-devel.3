Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D187C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYHL-0005Ft-GX; Mon, 10 Mar 2025 04:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1trYHH-0005Fe-CX
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:14:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1trYHB-0002j7-O7
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:14:22 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxG6xOn85n4HuQAA--.17410S3;
 Mon, 10 Mar 2025 16:14:07 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxj8VKn85nFk9BAA--.47175S3;
 Mon, 10 Mar 2025 16:14:05 +0800 (CST)
Subject: Re: [PATCH] tests/qtest/cpu-plug-test: Add cpu hotplug support for
 LoongArch
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20250310062456.2453189-1-maobibo@loongson.cn>
 <ce0f0c13-0e04-444f-b5db-8fdb7af6f945@redhat.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <ffad81a0-cbc7-9596-77b7-e1a9c38eccf7@loongson.cn>
Date: Mon, 10 Mar 2025 16:13:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ce0f0c13-0e04-444f-b5db-8fdb7af6f945@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8VKn85nFk9BAA--.47175S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw17uFW3ZF1UKryfCw4kGrX_yoWrWr47pr
 WkArW5KrW8Arn5J3WxGF1UWFyFvr17G3Z8Jr4IqF1UCrZxGr10gr4jga1qgFnrAw48Zr48
 Aw1kJrnxu3ZrJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.702,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/3/10 下午3:04, Thomas Huth wrote:
> On 10/03/2025 07.24, Bibo Mao wrote:
>> Add cpu hotplug testcase support for LoongArch system, it passes to
>> run with command "make check-qtest-loongarch64" as following:
>>    qemu:qtest+qtest-loongarch64 / qtest-loongarch64/cpu-plug-test OK 
>> 0.64s 1 subtests passed
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   tests/qtest/cpu-plug-test.c | 28 ++++++++++++++++++++++++++++
>>   tests/qtest/meson.build     |  2 +-
>>   2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
>> index 6633abfc10..790b9693b3 100644
>> --- a/tests/qtest/cpu-plug-test.c
>> +++ b/tests/qtest/cpu-plug-test.c
>> @@ -156,6 +156,32 @@ static void add_s390x_test_case(const char *mname)
>>       g_free(path);
>>   }
>> +static void add_loongarch_test_case(const char *mname)
>> +{
>> +    char *path;
>> +    PlugTestData *data;
>> +
>> +    if (!g_str_has_prefix(mname, "virt")) {
>> +        return;
>> +    }
>> +
>> +    data = g_new(PlugTestData, 1);
>> +    data->machine = g_strdup(mname);
>> +    data->cpu_model = "la464";
>> +    data->device_model = g_strdup("la464-loongarch-cpu");
>> +    data->sockets = 1;
>> +    data->cores = 3;
>> +    data->threads = 1;
>> +    data->maxcpus = data->sockets * data->cores * data->threads;
>> +
>> +    path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
>> +                           mname, data->sockets, data->cores,
>> +                           data->threads, data->maxcpus);
>> +    qtest_add_data_func_full(path, data, test_plug_with_device_add,
>> +                             test_data_free);
>> +    g_free(path);
>> +}
>> +
>>   int main(int argc, char **argv)
>>   {
>>       const char *arch = qtest_get_arch();
>> @@ -168,6 +194,8 @@ int main(int argc, char **argv)
>>           qtest_cb_for_every_machine(add_pseries_test_case, 
>> g_test_quick());
>>       } else if (g_str_equal(arch, "s390x")) {
>>           qtest_cb_for_every_machine(add_s390x_test_case, 
>> g_test_quick());
>> +    } else if (g_str_equal(arch, "loongarch64")) {
>> +        qtest_cb_for_every_machine(add_loongarch_test_case, 
>> g_test_quick());
> 
> There seems to be only one unversioned "virt" machine for loongarch, so 
> using qtest_cb_for_every_machine() and g_str_has_prefix(mname, "virt") 
> in above function seems unnecessary? I'd suggest to call 
> add_loongarch_test_case() here directly instead and only add the single 
> test case for the virt machine there. Or do you plan to introduce other 
> machines any time soon?
There is no plan to introduce other machines from my side now, only new 
cpu type will be added.

Yeap, calling add_loongarch_test_case() here directly is better, will 
modify it in next patch.
> 
>>       }
>>       return g_test_run();
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 8a6243382a..60e16614b2 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -149,7 +149,7 @@ qtests_hppa = \
>>   qtests_loongarch64 = qtests_filter + \
>>     (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? 
>> ['numa-test'] : []) + \
>> -  ['boot-serial-test']
>> +  ['boot-serial-test', 'cpu-plug-test']
> 
> I'd like to suggest to put tests on separate lines here (we do it for 
> most of the other targets already), that will make "git blame" more 
> useful in the future when the list changed a couple of times.
Sure, will put tests on separate lines. And thanks for reviewing and the 
good suggestions.

Regards
Bibo Mao
> 
>   Thomas
> 


