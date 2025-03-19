Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FC9C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 02:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuj48-0007JM-W3; Tue, 18 Mar 2025 22:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tuj3w-0007IK-5V
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:21:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tuj3t-0006Qq-Ra
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:21:43 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2239c066347so135333105ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 19:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1742350895; x=1742955695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EBnsRjLEQER9/4XOoqsMXlqWw5mvl428iC2o6xSXA8E=;
 b=Cu/aI8KVsm3H0M0mg1uiv/2D9B7080kHfjxVYx1NJsWARvKWvepx/jEWhg7pExDnkM
 5bqd2Plgn/v57KfVs9uZ16xjiDIKbyx1jpETCG/SlktyrgC5kGIYpakJxuE+tjhXzHgP
 K1eDAQ3A5cKRluf5etbC/kCIkPvnqvpjuVJNZXMwyH18xi8SWLaepVytEpD+myBUShFf
 JfcVa+vghHGXsZIbY4vbLPBsJ8YDLRUz47Y2Zp522DWjqvukc2UC9UHveR7KQG9orsqD
 9FoZRPiVs7HJL5I2/WL0GnpoSVQTPsb+dJMEZf1HHI91lvgLqNWs2gXEXDTlqV0XK05k
 1Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742350895; x=1742955695;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EBnsRjLEQER9/4XOoqsMXlqWw5mvl428iC2o6xSXA8E=;
 b=XQpJR589AJAhqgbLkl/D69BHgIhge8fFr65Q91aGfrqYKLm4aUhlh4ifXKkhNa/TAy
 phUqfF5GF9vOI9hx4RR8Ff+fI6HKOrCFxYibcKi1YcFPsw/gARfP3Ef2tyGRUrf/zGOt
 SdIsmu4AkATA0U060LyGiZmYUdnpCFG6kMC9swi/tkCHJ7s+FmRsNkig6RP6CCS03rOf
 OD0JuGdZMVkhCSgqP+ePnyOZZKArkIdnt5KZfi7GoPyW2//zQttDRCWr+5ZX9QyZZ1At
 Xn0NNZzd4h5tYZJbNeHgIBbeSLMAe1jKAKywdYav9TI1zRkwJvHdmNQuPIyAYmBAh0qu
 S55A==
X-Gm-Message-State: AOJu0YzMh6+2ZSTxEA3f5Nrlw/bO26nvykRI1cjVNznTpKKV+3xuHLzO
 hkZC4aBVgvebbLAKBDGOSupKOcnchJSNGEY4g7KgqjGu+hNVCFSID65n4ff4er0=
X-Gm-Gg: ASbGncuUXh2gKCe9ofaHRaNBFZ150q2w/XZDy6uewNqaufZ1qmJ7vjKJzsMYY5zfKa5
 fPOsuVJNkHGfK+t9xI0VyWGb79K1vOlu7L4Fs0mEAAwp/FDO5s3uYLZyUGArhxkWVDMLExIfz+G
 GGZJomCzASw9aXRvOS0VD8De2wLlD2l4nib7k8NOnOyus08+rWDK+C5jjN67T0qsIy7s6NO5IvM
 rBs+wTClb4QA9QWM09qil2BSDGjaxggPDbO5Hwk6/CygTK1F4hanL7X4DnfaZ3JSEyHXMQZz+1T
 5JquaWoBKSzagJv+bPspk7J2W+421QoRfQFTPKW9/iVJgKVcT3k=
X-Google-Smtp-Source: AGHT+IFJZissQPVpoL0IXZ9u9OMZ/GND3raWno9SSc0zvMTgQSh3hVx2PqsuABlySVsrDXV8FnzWsA==
X-Received: by 2002:a05:6a20:2d24:b0:1f5:85f9:4ce6 with SMTP id
 adf61e73a8af0-1fbeb7a156fmr1731373637.11.1742350895206; 
 Tue, 18 Mar 2025 19:21:35 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.10])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea7f6e2sm9848065a12.60.2025.03.18.19.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 19:21:34 -0700 (PDT)
Message-ID: <8b093cdc-f41e-48e7-8be6-b592f313e4f6@bytedance.com>
Date: Wed, 19 Mar 2025 10:21:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] cryptodev: Fix error handling in
 cryptodev_lkcf_execute_task()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com
References: <20250312101131.1615777-1-armbru@redhat.com>
 <df42e188-00b7-46cc-8853-163798c62ac2@bytedance.com>
 <87r032ihj2.fsf@pond.sub.org>
 <44db6eee-2cba-43f0-8977-382e44af3b6f@bytedance.com>
 <87zfhi5v9n.fsf@pond.sub.org>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <87zfhi5v9n.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62f.google.com
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



On 3/18/25 21:21, Markus Armbruster wrote:
> zhenwei pi <pizhenwei@bytedance.com> writes:
> 
>> Hi Markus,
>>
>> Current code style seems buggy, I think the main reason is that the Error *errp is not generated at right place. keyctl_pkey_XXX fails without new error, qcrypto_akcipher_XXX fails with new error, but they are in the same switch-case code block. If we can separate crypto operations into two functions - cryptodev_lkcf_keyctl_op and cryptodev_lkcf_qakcipher_op, and the error is generate inside the functions, it may be handled easily. Then applying your changes, it seem more clear. What do you think?
> 
> Looks like a reasonable cleanup to me.
> 
> I suggest to proceed as follows.  We apply my minimal bug fix as is.
> You post your cleanup on top.  Okay?
> 

OK!

