Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4DDC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 09:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCaeR-000087-Gp; Wed, 07 May 2025 05:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCaeN-00007K-96
 for qemu-devel@nongnu.org; Wed, 07 May 2025 05:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCaeH-0001tq-Dd
 for qemu-devel@nongnu.org; Wed, 07 May 2025 05:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746608461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=p6tYD6xGL9Axx9GVmx7aL5T0P4jnGOklRgP3kavWOK4=;
 b=YWm0toX8kG0Curmq5H3yJ8ii1Gw+JKztaDKqyZe8XNDRwYEOJUtmFzehdMACx1N/cngk6s
 jP+LPESEQiTNhfoIKUDMRlpuoQFs0tLCNCxEppvZhsAWeu2wkWjGsubaXmVaBvAeJWDQ6c
 08qrAa9/CvqXw1TtnDk2BtxOYtUOuW4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-SXahxTTbPIWvVPZtxyjP3A-1; Wed, 07 May 2025 05:01:00 -0400
X-MC-Unique: SXahxTTbPIWvVPZtxyjP3A-1
X-Mimecast-MFC-AGG-ID: SXahxTTbPIWvVPZtxyjP3A_1746608459
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39d917b105bso3363900f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 02:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746608459; x=1747213259;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p6tYD6xGL9Axx9GVmx7aL5T0P4jnGOklRgP3kavWOK4=;
 b=CgWgf+O94I6oT+WJddwMsVSLAvLZ2wpnM2jAPB84E2CVSwpDQvOEn8oCIFt840Jmtc
 LyoaVN9F/l5Q3PbWhfe8pptYYwV1S7hjZw14Zy72vSb/Hcq+aDtlH0JemQ3V8JmydiPA
 ZSLybmKPjkNl/ELrVGhxUx6rkdRbhgaPKOLnLr/J+LBOil1LuMSLXG3xNQOYJ3vZhIbR
 Ty8tcKJrTh1jT59YiMaRH1HGey2qmgpvlg6rfCgnVXXXx4jJ7nTDdeQ6whJSYMyjwAm6
 /S2ZifUqoOL7lF0OTAp5wF9aNjQaB0ME0m4Sf/APrBtCtk643BgLmM0wCAYCUlhwKT2h
 llBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjuoTDKlcfdBF2ysBZRoVcytkO7ph8eYTcJ6+CFN6Ldm9k75My/8nW/2J1XG8Wj7fk5lNQbu1J37Hi@nongnu.org
X-Gm-Message-State: AOJu0YwwGyH5YqHhcG/U17dhtn3B4PvlRd35TpjqEkjtl1YSwctffux9
 d/MN804RUuI3G/jZBcNXYHktTIfVQb+WFgA+QavMxCqvvPq2GmMyXF7W7j9soOWYdgAvgDB210B
 8G+qHCJtreQ3Xw4Ng3OpnnIeR2cN06xd6J6SPdtdWORdOxo2NTR0K
X-Gm-Gg: ASbGncsggv/Cy2X+sfarpmNsp9MkV2m0Zf5YNjxYE8ySmeoFyzOIuy6bnM9mcoglAQs
 OTMgQbSagR5u3vrZ6oaMokKkpnstGdzfNaGqBR+Jdby8FgL8WluqKq5oPZ8q+VMeFXVmvebLN8+
 kjQhmKuZ6kXBIbQy1RA73EQjRCALD5pX/QGi4g9grIbV1oW/XsvW3BRxjrQftThXL74k/WjXWLM
 LFlJknWK8ufZZUe00DUp6C7q9ISBROdwE+OAl9cd+sYpPCYDLOkrtZ+mcAMuxq6N/87rncLuNfO
 QWijUK+QCiEJ4HGBiRcwZv4eyfpi9hbnnlgaAZlWYdygETF3KVHG
X-Received: by 2002:a05:6000:40de:b0:3a0:aeba:23b1 with SMTP id
 ffacd0b85a97d-3a0b4a6f746mr1931808f8f.49.1746608458918; 
 Wed, 07 May 2025 02:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGex45O9TWhaPohn44Nqcbhpc2w3Czo2bE3sc6gTbpHyMmTJP0vTQGFG5Rkw/cwSA6ztTez6Q==
X-Received: by 2002:a05:6000:40de:b0:3a0:aeba:23b1 with SMTP id
 ffacd0b85a97d-3a0b4a6f746mr1931783f8f.49.1746608458572; 
 Wed, 07 May 2025 02:00:58 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b170d0sm16409310f8f.99.2025.05.07.02.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 02:00:58 -0700 (PDT)
Message-ID: <96a274f6-6efe-4602-a7ab-3488a43365fa@redhat.com>
Date: Wed, 7 May 2025 11:00:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/qtest/cpu-plug-test: Add cpu hotplug support for
 LoongArch
To: bibo mao <maobibo@loongson.cn>, Fabiano Rosas <farosas@suse.de>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20250314085130.4184272-1-maobibo@loongson.cn>
 <c66ea257-0449-cccb-ac13-518e42c9081f@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <c66ea257-0449-cccb-ac13-518e42c9081f@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 07/05/2025 10.55, bibo mao wrote:
> Hi Thomas,
> 
> Can this patch be merged since qemu 10.0 is released already?

  Hi,

Fabiano took over the maintainership of the qtests, so I'm forwarding the 
question to him.

  Regards,
   Thomas

> 
> On 2025/3/14 下午4:51, Bibo Mao wrote:
>> Add cpu hotplug testcase support for LoongArch system, it passes to
>> run with command "make check-qtest-loongarch64" as following:
>>    qemu:qtest+qtest-loongarch64 / qtest-loongarch64/cpu-plug-test OK 0.38s 
>> 1 subtests passed
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>> v2 ... v3:
>>    1. Remove redundant check with machine type since it is constant
>>       string.
>>
>> v1 ... v2:
>>    1. Call test function add_loongarch_test_case() directly rather than
>>       qtest_cb_for_every_machine() since compatible machine is not
>>       supported on LoongArch system.
>>    2. Add architecture specified test case in separate line.
>> ---
>>   tests/qtest/cpu-plug-test.c | 24 ++++++++++++++++++++++++
>>   tests/qtest/meson.build     |  3 ++-
>>   2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
>> index 6633abfc10..44d704680b 100644
>> --- a/tests/qtest/cpu-plug-test.c
>> +++ b/tests/qtest/cpu-plug-test.c
>> @@ -156,6 +156,28 @@ static void add_s390x_test_case(const char *mname)
>>       g_free(path);
>>   }
>> +static void add_loongarch_test_case(const char *mname)
>> +{
>> +    char *path;
>> +    PlugTestData *data;
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
>> @@ -168,6 +190,8 @@ int main(int argc, char **argv)
>>           qtest_cb_for_every_machine(add_pseries_test_case, g_test_quick());
>>       } else if (g_str_equal(arch, "s390x")) {
>>           qtest_cb_for_every_machine(add_s390x_test_case, g_test_quick());
>> +    } else if (g_str_equal(arch, "loongarch64")) {
>> +        add_loongarch_test_case("virt");
>>       }
>>       return g_test_run();
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 5a8c1f102c..788093f744 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -149,7 +149,8 @@ qtests_hppa = \
>>   qtests_loongarch64 = qtests_filter + \
>>     (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : 
>> []) + \
>> -  ['boot-serial-test']
>> +  ['boot-serial-test',
>> +   'cpu-plug-test']
>>   qtests_m68k = ['boot-serial-test'] + \
>>     qtests_filter
>>
>> base-commit: 4c33c097f3a8a8093bcbaf097c3a178051e51b3e
>>
> 


