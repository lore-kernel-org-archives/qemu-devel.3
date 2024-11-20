Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34CAD63936
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 13:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDkS1-0006ZA-Ed; Wed, 20 Nov 2024 08:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDkRz-0006Yx-Mk
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 08:08:55 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDkRy-0004MJ-70
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 08:08:55 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3823eaad37aso543196f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 05:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732108132; x=1732712932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rPaQuH1cmukHHX6uEt4jybwTUcjQO8kgiNOQcPRjB8w=;
 b=h8REjH+fBnxJ3z9200oKxSvCYMEXDsrnlOySW9M/bSWDEna3nGTNDPfgOrSOzKvBo3
 zUvNYojVSaqTZc6j8CNMF1qo4VmJfEl+yM1+nWp7ImlvCPBL5Vljg+RPfKiMkc1RBwGz
 fB8phrqD+m17s8qq+h1Zvl3UoQ88Z02nU/zv694tWzUfPLSQHbSVNUZ/IEg3wd3FXOSv
 N4Qyp+LHsEiK+UtxJPPWholAWIJQFwsWPDmQlmHGWVZt1GScU8QxOl/oqF8Et56Tjrsv
 xYE4HtSonWXyBYgcDiPbjuKvu2xftJBWl1JhojMVNXuPEQWzNYGK/D2lfg3n8UvUXWsa
 QCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732108132; x=1732712932;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rPaQuH1cmukHHX6uEt4jybwTUcjQO8kgiNOQcPRjB8w=;
 b=CN2fLpPy6+i+I93beDU/Zz9X3sKQod5dkde/NPGdgcNRZ/Wu2V0ssFJw0cBwudZ6NS
 fwy2UL2vaS0BglooPLmmdpSs5dGyCfUyihOnpkCs+u9WDwDphT4/BTJXr++MTmaQlSmW
 Pn5pRmtsIpSxxlqdu61s1/fu6X6+XLwkv+JcjE3IsZnFBz8YlOk0SLWNhAttKsbHvi3x
 7JBbL9Obniy+kiFjXxl2Ka22Vd2GYZVGvMUWhj9M0nUgp9BlZm2lqhwV4teRyWBhCJZC
 SvE4TKIB3mrqMW1RmddFPioR1b5aEcDiW/c19/nsyj8RxI8fehGUHKYq4bXZ0nY7fGjl
 hBWQ==
X-Gm-Message-State: AOJu0Yxts5p8wwG5t5NDtystHXTTacxJ79L95uw81jmKpjXM9JaDsBOZ
 2FkbyOgVwD3mAxcZf41vSYpIbcZlWQvYEjM4EJ1tN/sDuv76mcjClYJyi72Avns=
X-Google-Smtp-Source: AGHT+IHpaWKEiIzXbF2cMfWEJfi6xkNhwpOg0Z+sqYVBoNgsMnKwQTuQUWa3cld5mRcYISD0/xGCQw==
X-Received: by 2002:a05:6000:184d:b0:382:442c:2c7d with SMTP id
 ffacd0b85a97d-382544c069bmr1794696f8f.8.1732108130882; 
 Wed, 20 Nov 2024 05:08:50 -0800 (PST)
Received: from [192.168.69.197] ([176.187.208.27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38254933cbfsm2012499f8f.67.2024.11.20.05.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 05:08:50 -0800 (PST)
Message-ID: <617489bf-6b4e-4443-afe1-4124f35108e0@linaro.org>
Date: Wed, 20 Nov 2024 14:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/scsi/scsi-disk: Avoid buffer overrun parsing
 'loadparam'
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>
References: <20241120085300.49866-1-philmd@linaro.org>
 <20241120085300.49866-3-philmd@linaro.org> <Zz2p5qm776A3q5J4@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zz2p5qm776A3q5J4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 20/11/24 10:20, Kevin Wolf wrote:
> Am 20.11.2024 um 09:53 hat Philippe Mathieu-Daudé geschrieben:
>> Coverity reported a 1 byte overrun in scsi_property_set_loadparm
>> (CID 15657462). Since loadparam[] length is known, simply directly
>> allocate it in the device state.
>>
>> Fixes: 429442e52d ("hw: Add 'loadparm' property to scsi disk devices")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Paolo already sent a pull request for a different fix (just allocating
> one byte more). I think that's the better approach because other users
> might expect the string to actually be null terminated.
> 
> Such as scsi_property_get_loadparm(), which you forgot to update:
> 
>      static char *scsi_property_get_loadparm(Object *obj, Error **errp)
>      {
>          return g_strdup(SCSI_DISK_BASE(obj)->loadparm);
>      }

Yeah I missed that.

Maybe consider the first patch as cleanup for 10.0? I can repost later.

Regards,

Phil.


