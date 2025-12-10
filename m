Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDCAD3B9A9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 06:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTDIX-0007E2-Tn; Wed, 10 Dec 2025 01:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTDIV-0007DN-Sg
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 01:03:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTDIU-0007Yr-6f
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 01:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765346611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ccCGCvKtVokVSkyz9606XMeOuGT+lxxM6NzxhGfhnnc=;
 b=LvUp+aU3Axz6afzTBi0F210BYhtESAew9rB9aXfydsWD+24ZDiYjxjXJlhISusvsWD3HQB
 iLeeMAfjHi2d3jvef0fSzxHu+aWmCADbjwJxIAkzy1WKj97RdLbhOTHbocI+YIc2e2pKAV
 u8+lAwpaJWszrBYzIOCiaOg6lwaQSGA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-3I9-Jo36NJiwZtkwqSkfbQ-1; Wed, 10 Dec 2025 01:03:29 -0500
X-MC-Unique: 3I9-Jo36NJiwZtkwqSkfbQ-1
X-Mimecast-MFC-AGG-ID: 3I9-Jo36NJiwZtkwqSkfbQ_1765346609
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42f9ed47dd8so647537f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 22:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765346609; x=1765951409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ccCGCvKtVokVSkyz9606XMeOuGT+lxxM6NzxhGfhnnc=;
 b=j7GHGGBHRZAnGByUika0xsHo3IF7IlDYkN5aRPZT3hAXeefE9GExVO0RFhm6viwXPC
 md0Gt4+aGIc5J379z7B80HRvCj9O3uFPigcRJO3CWTMQxVOuJpuUpRFVujWAJKocD54l
 FYbRRyF9x5oSkQLK+L60Go1xiZa+UookN+3TdhJ03H2ezVR2LKZyzzIPVLGpbkMWSw6u
 hR4Fm6CXI8C6eVReWxWjoLo6cBgrqH936Zsb5OYPIqfdLTSGpzcfif7Qy0QrmWrrnCkx
 0VSHDL3pQYsHbIwsz28NRlHq25dc7w0ZaaRPEpwM4Vbv0mWfx5pkrU9JfyjjnBA6kXrM
 zLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765346609; x=1765951409;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccCGCvKtVokVSkyz9606XMeOuGT+lxxM6NzxhGfhnnc=;
 b=lx3ZsdcaP9h/G8FQnYUb8idEbLLZTdjzsdErJDTI5g5CmhmrGFfFsrR3IYmFsaevrL
 Xw/IQqIriUDRix6XLVldBsz74dlZ+j5tEHlwZYAnkrQEBCp1sgjR1GsDFiK7i/H9BZgu
 i1IxEHCekHyHcR140ilgeoYCyv8W8FDAi5czQ3M5GL1nvqpA7sQmQggCtBjwaTkraBMv
 Widr7lkIYgBw/EcRyOVfe1gDc91gJwMoGGyXpIBTT8IqgcMsDNcA2VXFABfT0TmotGab
 naqdRy0shMeNMNJqV9z/AZN58wsQ6T5LwLRBnnartlGuyFTynxXZ4lDW+xMFLaamxHAR
 /3Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+HqiKnqZe6VGVbZoZmxZxkVfGLliCzxQ6lmhPgy0+Ad4+wpR1Aul2pDLm4cZNcfNieKaFf4KQqUFo@nongnu.org
X-Gm-Message-State: AOJu0YyQZB86FCRhWFlXGXlfBxhzqg1lbxi9voAT7a2Rz9MWqgE/QbRs
 0sidoQQy3ciS9blzOL9Tn2Bt+ScxpjCcpjAiaHnjyP2n+njLf+ypOjz3qSh3HdHf4z2tKk+HTxK
 h/v/lJW1s4Q+cjz3gWZdM1D6mgA21SERh/rzLs8gN/5mJBuSF4klS2ZZq
X-Gm-Gg: AY/fxX4Letgv+Q+LJHORdowzu/p2I1AQwHTzWT6Jj/U6ZaW4LFK2hcUoEipOScUeOGz
 fNlhKBI5jF2yjabXbGf2Euaw1vo5OPdrvrigf9eygU075tSzIEb/7Qys/vBssatRGQfd6j7vRkp
 wdTUgComRdlRMfgSnCz69ika4BEs1RriW+6quumPcqr5xv/Clh9cGDDSaheoSmgBovPL2QPYWh1
 aEPWn0y5E3u2iSnVOtizELEnZ5EIQeAgVmAE3MyhYYkQik21nbBBNwQEQTLOrWa1djdmn4/gsqZ
 j49qNE+jvAEizprdio8coc5r32BXf3oNAGV6Rmfo2O2bfA8rMY7WCzL0T8Mw4Tfe5EYIi/fzn2N
 SrvcKqlxA0UHk1GFmAWtOL6rdFUVAd/AECKwMZq+ATTVvqgOD
X-Received: by 2002:a05:6000:2dc2:b0:42b:3ab7:b8a3 with SMTP id
 ffacd0b85a97d-42fa3adb80dmr980585f8f.27.1765346608697; 
 Tue, 09 Dec 2025 22:03:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQIGya/i9XYSachnxctoBJhmiK6xwcp4CgCfeLDe8+997ghuiPT1s+84tmbxRbGSkkB8B+FQ==
X-Received: by 2002:a05:6000:2dc2:b0:42b:3ab7:b8a3 with SMTP id
 ffacd0b85a97d-42fa3adb80dmr980545f8f.27.1765346608232; 
 Tue, 09 Dec 2025 22:03:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d3319ccsm34711930f8f.34.2025.12.09.22.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 22:03:27 -0800 (PST)
Message-ID: <f9b0ccce-df77-444e-b131-d796936d5078@redhat.com>
Date: Wed, 10 Dec 2025 07:03:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Fix const qualifier build errors with recent glibc
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20251209174328.698774-1-clg@redhat.com>
 <788f9e4d-86c1-4830-8eda-dd70d8fec7c4@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <788f9e4d-86c1-4830-8eda-dd70d8fec7c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/9/25 20:17, Philippe Mathieu-Daudé wrote:
> On 9/12/25 18:43, Cédric Le Goater wrote:
>> A recent change in glibc 2.42.9000 [1] changes the return type of
>> strstr() and other string functions to be 'const char *' when the
>> input is a 'const char *'.
>>
>> This breaks the build in various files with errors such as :
>>
>>    error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>>      208 |         char *pidstr = strstr(filename, "%");
>>          |                        ^~~~~~
>>
>> Fix this by changing the type of the variables that store the result
>> of these functions to 'const char *'.
>>
>> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Most changes are straight forward apart from vubr_parse_host_port.
> 
> Better keep the vubr_parse_host_port() change in a distinct patch (the
> change isn't really what this commit describes).

A rewrite is preferable anyhow.

> For the others:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks,

C.
  
>>   Please check.
>>
>>   Thanks,
>>
>>   C.
>>
>>   backends/tpm/tpm_passthrough.c | 2 +-
>>   block/vmdk.c                   | 2 +-
>>   block/vvfat.c                  | 2 +-
>>   gdbstub/gdbstub.c              | 2 +-
>>   qga/commands-linux.c           | 7 ++++---
>>   tests/vhost-user-bridge.c      | 2 +-
>>   ui/ui-hmp-cmds.c               | 2 +-
>>   util/log.c                     | 2 +-
>>   8 files changed, 11 insertions(+), 10 deletions(-)
> 


