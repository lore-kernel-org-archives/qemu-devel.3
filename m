Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90317EE01FD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 02:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDEn-0005iU-0p; Tue, 10 Sep 2024 22:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soDEk-0005hx-QT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:37:42 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soDEj-0003gF-4s
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:37:42 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-718d985b6bbso4431626b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 19:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726022259; x=1726627059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v0lHuTuXwZIHbHuqMPjyLpdx6980iIh0/JN59RnYo+E=;
 b=T1x3xVwKR0VdvfXX1RLWom/aQ3CQOz96l9fCd3PmDGDKQEfVyroeeETfuotZ2Kd6FE
 rqBUGIEN1oxWt91IuQtCGmLv5Is4sQyfSeZZ5WESzx2KxflVM7IWvJGabB0zFGICN/ZZ
 mqj3KheMyyYwRJl/ovMs1gCYPHO6V5uruAodOh0Icm0ulWDcQ0sVknod+nSccDki/ZoH
 6tvG7QuTgyblTWfWrWsc5XGUVVAlfae4L4teEv+kx/PxUtXt5iDm3dcG9YwSDwXXAKNA
 vQH624H7XAtXII3Yi+WIcZcZl66+D1DqpFTi67UhcPraMU4cVwOSAlxAlxpe/SDbqfrs
 smRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726022259; x=1726627059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v0lHuTuXwZIHbHuqMPjyLpdx6980iIh0/JN59RnYo+E=;
 b=HgWa9Cr1dbR4YNhqPGAw6mTCFEl9YIxBRXlpfMT16KMfGCGAQK0mSquabaB3uL/LB+
 loUwdG+T9yrmOUf/86YqQHeIWEflJt8I+Ubwhlfspx6gp2z/t8LA+nspDhZwrj/Oxudb
 BZyh1DKubHpte4IUUDF8BulwnP1UcdN13MjaQuh9xwkgyTziOxgrcYvOkS78xGBxa+kf
 0WQiq327aJiIL/vQOATtf+t/oGd0o9klHTPO11R4P6VUPc6mPrj5TgmVla1e/B64p6Gk
 QfY7o3xyXt8gupJL9ZtAr/VEDS+yrnH2Wu9PwVQS9dp+L4b4CQgz/IaKbFhJuIBwPnMW
 Ctlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxXnnmz/5maochIOU5++W9HJ41wtwljzFNcqZD57MQDfpgOEDcY018trug21CjOERirB/lGItqoVCc@nongnu.org
X-Gm-Message-State: AOJu0YzFJrx1TPI1mPJiLaY0gF9T3YQ1zdYYr0ChFNxTWf6rjQUt8PsG
 VNYKP85SaDbXT/bE2VjCdyKXcgb3d6TCSbVdPxV5MKk1+2+3ijBylvTmtN7d7PM=
X-Google-Smtp-Source: AGHT+IGrCkI2pGYQM4axDrIpH7FmHfm5CCFID/47fO/AvClkmm9e0vtE3BtiUUxOctk9tkFCH5jMiw==
X-Received: by 2002:a05:6a00:b87:b0:70d:21d9:e2ae with SMTP id
 d2e1a72fcca58-718d5deec8fmr24107593b3a.6.1726022258657; 
 Tue, 10 Sep 2024 19:37:38 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4de9sm2017184b3a.77.2024.09.10.19.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 19:37:38 -0700 (PDT)
Message-ID: <1f845da7-be4b-4559-b455-4f570451ebb6@linaro.org>
Date: Tue, 10 Sep 2024 19:37:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/39] migration: replace assert(0) with
 g_assert_not_reached()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-9-pierrick.bouvier@linaro.org>
 <5495c5f4-b5f7-48e8-87e4-2fde2c9eec1a@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5495c5f4-b5f7-48e8-87e4-2fde2c9eec1a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/10/24 19:17, Richard Henderson wrote:
> On 9/10/24 15:15, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    migration/migration-hmp-cmds.c |  2 +-
>>    migration/postcopy-ram.c       | 14 +++++++-------
>>    migration/ram.c                |  6 +++---
>>    3 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index 7d608d26e19..e6e96aa6288 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -636,7 +636,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>            visit_type_bool(v, param, &p->direct_io, &err);
>>            break;
>>        default:
>> -        assert(0);
>> +        g_assert_not_reached();
>>        }
>>    
>>        if (err) {
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index 1c374b7ea1e..f431bbc0d4f 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -1411,40 +1411,40 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis)
>>    
>>    int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>>    {
>> -    assert(0);
>> +    g_assert_not_reached();
>>        return -1;
>>    }
> 
> 
> You've got patches removing extra breaks, but these returns are dead too.
> 

I'll take a look to cleanup this in v2 as well.

> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~

