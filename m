Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E171ACD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMXWX-0001S7-D3; Mon, 11 May 2026 16:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMXWJ-0001Qr-1j
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMXWE-0003ho-IG
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778532384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lzHrtaJwV7G5vCuPZFJxpKhxHm+vk/UeGk0gSfEdbF4=;
 b=D5AQb+Ei+Rxz7q7oqjR1FsfVFAgOUlbldFAVE0Ar706FrROPwTXom9pDv8NJYyBGNnZGKa
 vcPulXEPrzOF+LQJadv0UAZslAPrZ5ZYQ0perj210FL2Pcs8ZmD0B7TK8R2TzQUzZLygCw
 XVxTGTlqak1LesQqceTQyIYCBQrj7Lk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315--FzEEQHHM9yGsv3WCzfprg-1; Mon, 11 May 2026 16:46:22 -0400
X-MC-Unique: -FzEEQHHM9yGsv3WCzfprg-1
X-Mimecast-MFC-AGG-ID: -FzEEQHHM9yGsv3WCzfprg_1778532381
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488bd1ee9e7so52763675e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778532381; x=1779137181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lzHrtaJwV7G5vCuPZFJxpKhxHm+vk/UeGk0gSfEdbF4=;
 b=C2LpPbQlgptqbcngIPwhcLakzdnO2r6juxCFrzUZhclHJQ6q3/kEQdU75xmgyQ7mxy
 uezm23vZEl/s5LtsvIqHDupjPp8AR2jThPATp10ZlQYnic9XJha63RX3Y0xk1s5ZF/Op
 ekirR5I2o4lXEZL8ySAUV4iIHugkzb6zOCAFCGXq8OnLqS5D5Bg4ak8d9NfcCzqvUecr
 4CnyqOnC4+leiYcltQUC0HIIhowITtFsJU8f0jl5WHNT8paZO56u2YzGU0pYMPrXX5WI
 4d+RsLyTaAmfIMvMvgoP0feMoXNxZuA537n8QE+iUeUBs5V3Gb7vi1Qv6s/VfVgV1UdA
 EdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778532381; x=1779137181;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzHrtaJwV7G5vCuPZFJxpKhxHm+vk/UeGk0gSfEdbF4=;
 b=bTpoRJONONCbouD+b1MtD/nblWlnOXLdOJAoPWJlafDfekRvW/57QgV3OjVUlnh4ex
 GSUSpyREC7o1Ukt1rZOATOKxEBvHYBSMvgnZChXZxfn0/J+IyQxFMc3CqTZcJaaWp/Qr
 o3GBAHxoeqJsIXJAMWRyxHbSW4Ie6Qdx4W45Sg0UACfOKX9eCU6mPylL/FzIWVs6zxNk
 dTpHnJR3I/DpJCaHMJHyVZJS+mqKc7R4DhbKvRNR3k2ifzs0jww9Y25vowSY6QXHvKdx
 sPXyUNA7QH4Dn2piI5FUpTBF0w5Y+WYjZLAt2ow7YyDlvzhi/dO86R21mTh9pOuBmfy0
 mp9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hvx2AuYJXGvdoScQ0kB8dWbNWf8Vsy7ffMFbZ0OBaEfPkMlkwHx0ohITASiBTWobFbkPfCZdXImha@nongnu.org
X-Gm-Message-State: AOJu0YyAElkGSK5mdKqm3lME6GfHB4lGBT4MgTRw/dfgCKXbG4v3CoJb
 ConSPFrL/5oLTTA3oxYJn1IJZ7TFZ9hHOvbjJeJA04LmcXY18sADWVhl6sD6HHYbdPIQF8oZ+5+
 qfSh/q6gDdwLOYEd6ndLg/762SSwkiXeNWdpyMDLvptdxeXvccNrR+dPW
X-Gm-Gg: Acq92OEBVwT5HuNayJRYQX2CxxnYf8fIdm6S6iyBGhA8ATu0Wrw1+B7AQ7EQYMXc1bQ
 WmNXyMeiM+I80C14VseTtnPbWWPsZmmMHw0qCqhQvwYle3HIvQgBnxkUGvyTo19C+Byxu0m9PvG
 TdHy43wxMrDMI7v1pwKh65lQ3JOgTK32IhPw2jMN4fyp60TcTDZJ+aTIr6lHI/bskeMfO7jn9kW
 2VI4UT/XLAVNtqpDX+v/gYMuO/xCjh6v2FjjTVjMYQgtuGfyDspuggJzTeKPi/jls/C7Ow3L6Ze
 5eauVRnR4TlLJu6VrdTQalYP8t3SVkp1bOa0I9eau95w17GQjjlj9dsn6T/WIcvrsQT3tLcFR15
 gifcBTNrlJpGCnpn1pI7ezPerXw5IfmHQ93q2In17lqs8XyFN7ChmfcsEnIdI
X-Received: by 2002:a05:600c:4e0d:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-48e70700e20mr188954345e9.19.1778532381074; 
 Mon, 11 May 2026 13:46:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0d:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-48e70700e20mr188954115e9.19.1778532380603; 
 Mon, 11 May 2026 13:46:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6b00fsm30468904f8f.11.2026.05.11.13.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 13:46:20 -0700 (PDT)
Message-ID: <dbd55bb5-392b-4a8e-b332-bc009b99014d@redhat.com>
Date: Mon, 11 May 2026 22:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
 <a57d5120-dabf-4953-a680-a9c875ecf238@linaro.org>
 <49384318-3050-46fd-af06-4b5c0a14699b@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <49384318-3050-46fd-af06-4b5c0a14699b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/11/26 19:59, Pierrick Bouvier wrote:
> On 5/11/2026 10:48 AM, Philippe Mathieu-Daudé wrote:
>> On 11/5/26 17:48, Cédric Le Goater wrote:
>>> Hello,
>>>
>>> On 5/6/26 15:55, Philippe Mathieu-Daudé wrote:
>>>> Introduce a source set common to system / user. Start it
>>>> with the files built in both sets: 'cpu_models_user.c'
>>>> and 'gdbstub.c' No logical change intended.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>> Message-Id: <20260423135035.50126-4-philmd@linaro.org>
>>>
>>> This change introduced a regression with PCI passthrough which
>>> stopped working. Guest kernel reports :
>>>
>>>     [    0.156501] zpci: PCI is not supported because CPU facilities 69
>>> or 71 are not available
>>>
>>> and other devices (ap, ccw) are impacted too I think.
>>
>> Is it something we could test with the mainstream CI, or does this
>> requires specific hardware?
>>
> 
> It could be tested with a tcg arm vm + nested VM with PCI passthrough.

Yes, adding VFIO tests to the QEMU upstream CI would be great.

> However, the problem is that you need to cross-compile QEMU in CI to
> test current version to launch the nested VM.

Intel comes to mind first :)

Couldn't we install the QEMU CI build artifacts into a VM matching
the configuration in which they were built ? I assume the artifacts
remain available for some time.

We could then install them in an L1 VM with a predefined emulated
igb device and assigned that device to an L2 VM.

I think this would also benefit the QEMU CI in other ways, as
nested setups allow tests to run with higher privileges.

> This would imply to have a "standard" target environment (like debian
> with X,Y,Z deps preinstalled) which CI does not have at the moment.

Why one "standard" target ? All arch are impacted, as well as various
distro flavors.

> So in practice, it's hard to test it.

It is.

Thanks,

C.


