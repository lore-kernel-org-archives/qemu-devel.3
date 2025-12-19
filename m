Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5412D7496B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 09:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWWiQ-0006Ky-Oi; Fri, 19 Dec 2025 04:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vWWiD-0006KK-AU
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 04:23:49 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vWWi9-0000A2-U2
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 04:23:47 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2a09757004cso17911195ad.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 01:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766136224; x=1766741024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+DgsuikWooVxewVXEMe468xXuh0Gc8fyD4RDTpT/Kjc=;
 b=kdVlYl9oYAjQ2AzXssvuk1FYLIBMVLwVhbQXo7JFr1V6I5+SbkhREIJSUFKfuL3W30
 ahrmMLRBLyMKDwzrE832VRx3mtIzw6RKpfe/uplgyVc6bE+DWBNQYhjgoeHm3kKtcjxe
 QVi0OfX3SMxpbwjG2VeyCC3kw/gTEgbtcDjqKx6x4FZTt+L5Py3j/02G3IHzaUHK9bi8
 jLSoJqhl8NAr0WIcXlzf+pTWtwtn75M/QF5cBQ16yl3k0cAX9OohTsd60UHIhAj9CgBY
 Iavu+g+VVtlm22RJ7/MDQkRtnirX6JV0kRePmVmiNdShLj7kqEEqy8AbSXcORi0d8KUr
 wYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766136224; x=1766741024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+DgsuikWooVxewVXEMe468xXuh0Gc8fyD4RDTpT/Kjc=;
 b=UePLy0k53QTxsEzZ2AYLwGRyUcmGtm/tMlN+F2qaLXVsmEK/kF+3qQzBlOpEnjGgiU
 ZJYZnjv0xjgOIhc7fl1sp5vEkLdc5Xw34q4+zaPZirt3wtebZq9NM6ymeCSpoX3SHy6K
 RmV2qWqWUd5O6wov2NIzKXx/RlNssDYIARRafAvx67LNMeijLeot6JokFMr0JufSp666
 psq/Xo5YS1Epm6QccxY3WoqtP4Ba9KkkESgh2r4oOiFktk8tfF2wxSEksrPK0+CNL/S4
 tR9+8avQrzlQvwA6aEOkLY+dlPBJKWZK5QBpnC1T6Ed331ZpnPGuLYHuIZFo4sMHdYPh
 u/EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2LYJfNDW2jhf+k6odVUDhXZBiGEFTQlkyAhmc6bJ/Xs7oJHFPUXVolV58R3dORhr2RB+WIUswgOqD@nongnu.org
X-Gm-Message-State: AOJu0Yzatf3aMDGfSPc/ll8op6FqSlsgUe+r0ww4MbZVWF1NIQqRNF4Y
 V58py3QVuL7kE/2HOyd2gygv1Sd5cB0NhgUjhbDVv29DJKG8LPVcFPZs
X-Gm-Gg: AY/fxX7RZZKXAHutVfQujpHbSzXqEbPsHQeEB2uUYbvm6Y5UnJrsMC04olwIu09A7w9
 OZ+7ddVR7VG4uyF5hji5MTg3igXMl9XBcYA1bCH0npPr5pgiIQoNYiX3L/0P4v8qNn6qkIoPjJC
 C85v3G+dgx228aadwXOOCkuxr4jxTcAiZ2Dof1nDjaK1iLiKvImsM3z8Nr2ZQOdWIm0uHmnYfE2
 QFEgmZJCbeXKNi3DkmS3NMNbIMpq+wn5LsmQPBLEQQnk3lTI0tGiVzL3OmeS3Lqu6aXcyooF5wP
 PhC74dYtlfPsdNJEOLJrYIygo0ywCrMb4DoMxEPkB6Y5Wk1xKnoO5qGvlrJlBcPhwZFTn/6kb92
 Fq4wyzsMHRgminN+CeuMBTXuAmbeleC+XiFzNWlwf9f25N59r9aUELqk1gmLzAAmrOJF3ueVMAN
 TqQAJqaAnNr1ZakCbZRrQfxy06KhtN4Ak=
X-Google-Smtp-Source: AGHT+IHY3x9p4YTnDBtIjDWBEufBHeWzDC07ulp+wHmKNth/ssnMfzXKE2i2Bl3vjZHzHw2Sbr60Jw==
X-Received: by 2002:a17:902:fc45:b0:2a0:bea0:8207 with SMTP id
 d9443c01a7336-2a2f2b5361amr21982745ad.49.1766136224253; 
 Fri, 19 Dec 2025 01:23:44 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c66bd3sm16921115ad.1.2025.12.19.01.23.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 01:23:43 -0800 (PST)
Message-ID: <625299d1-b04e-4c8e-8e96-8f353510ad3c@gmail.com>
Date: Fri, 19 Dec 2025 17:23:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] RISC-V: Initial support versioning of debug
 specification
To: =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "vivahavey@gmail.com" <vivahavey@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
References: <20251201014255.230069-1-alvinga@andestech.com>
 <0e543e10-970d-4a7c-aa79-d3a0a6358e72@zevorn.cn>
 <SEYPR03MB670057426CD1F169681C54C1A8A9A@SEYPR03MB6700.apcprd03.prod.outlook.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <SEYPR03MB670057426CD1F169681C54C1A8A9A@SEYPR03MB6700.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



On 12/19/2025 5:10 PM, Alvin Che-Chia Chang(張哲嘉) wrote:
> Hi Chao,
> 
>> -----Original Message-----
>> From: Chao Liu <chao.liu@zevorn.cn>
>> Sent: Friday, December 19, 2025 4:09 PM
>> To: qemu-devel@nongnu.org
>> Cc: alistair.francis@wdc.com; Alvin Che-Chia Chang(張哲嘉)
>> <alvinga@andestech.com>; bin.meng@windriver.com;
>> dbarboza@ventanamicro.com; liwei1518@gmail.com;
>> qemu-riscv@nongnu.org; vivahavey@gmail.com;
>> zhiwei_liu@linux.alibaba.com
>> Subject: Re: [PATCH v3 0/2] RISC-V: Initial support versioning of debug
>> specification
>>
>> [EXTERNAL MAIL]
>>
>> On Mon, 1 Dec 2025 09:42:53 +0800, Alvin Chang via wrote:
>>> This series try to support versioning of debug specification. The
>>> early debug implementation supports debug specification v0.13, and
>>> later new trigger types were added which are defined in debug
>>> specification v1.0 version. To support both v0.13 and v1.0, we add
>>> 'debug-1.0' as CPU property to let user choose debug specification
>>> v1.0 by specifying "debug-1.0=true". The default version is still v0.13 if
>> 'debug-1.0' is not provided and set.
>>>
>>> For example, to enable debug specification v1.0 on max CPU:
>>> * -cpu max,debug-1.0=true
>>>
>>> Changes since v2:
>>> * Improve commit message and fix typo
>>> * Apply "Reviewed-by" tags
>>>
>>> Changes since v1:
>>> * Apply suggestions from Daniel. Using boolean property instead of string.
>>
>> This is great work! Thanks to Alvin Chang for refining the sdext. It seems we
>> are one step closer to merging rvsp-ref into the mainline.
> 
> Thank you, Chao.
> Please note that this series doesn't implement Sdext infrastructure.
> We have some patches for Sdtrig based on Debug spec v1.0 and we want to upstream those patches.
> We ever submitted the patches, but unfortunately the patches were blocked.
> The maintainer told me that QEMU should support both v0.13 and v1.0 for backward compatibility, rather than eliminating v0.13.
> That why I submitted this series, trying to resolve the version issue.
> 
> 
> Sincerely,
> Alvin Chang
> 
> 
Oh, thank you for your clarification. I also noticed this when reviewing the
main patch series — it was my misunderstanding. Still, thank you for your
contribution!

I have done some development work on Sdext before, but I noticed that
implementations of the DM module vary among different vendors. In addition, how
to achieve compatibility with gdbstub is also a challenge. I will send out the
RFC patches at an appropriate time in the future.

Thanks,
Chao

