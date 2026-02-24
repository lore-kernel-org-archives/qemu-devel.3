Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E997EFB819
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 09:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuoTr-000424-71; Tue, 24 Feb 2026 04:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vuoTk-00041M-QM
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 04:13:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vuoTh-0003BR-Fe
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 04:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771924391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FR2nGH/TLezukN/2n/e0ILFtuWyjeiAK2I7s85ZYHUc=;
 b=AkqjydNz7iWdMvTjCv7tGi6D0i3tV5XTyvMVmwCilJ1QD92azeR3Yl6fzhFzZ5QJ/IeIrO
 pYnj8Jl8sqr19kBjZePZtJ3UF97OnygjUf39d0D8ExIIKR+4q4Awqg0zw1bIR0MVAtwzlw
 bxIM2poorR5rq+/Kwu4lEk2jnia7lxY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-HlyyfIshP6u2wI9hQOKMSQ-1; Tue, 24 Feb 2026 04:13:09 -0500
X-MC-Unique: HlyyfIshP6u2wI9hQOKMSQ-1
X-Mimecast-MFC-AGG-ID: HlyyfIshP6u2wI9hQOKMSQ_1771924389
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so54085675e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 01:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771924388; x=1772529188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FR2nGH/TLezukN/2n/e0ILFtuWyjeiAK2I7s85ZYHUc=;
 b=XMWZbVzRWEbp2l/N6UhXS4+0yXeswECgrpeSbfGROxFqKppURoDpPhXza737U0or2O
 EmHu64tGLWCnmQapF8bLF/iYROxpWOlmRn+C0nHJZZ16aBvXaAkp13CmlVOK+NrOvcjJ
 MOkrbKZm2uzop7Q4N27qoZqmEi3f324a9yjHB6dlVsGNGG0ESTo2smy4XLxnbZgXjJSM
 yyIstzbXe3tusXAXFuopPsntcYllDdLciYgxk/6Vj9cSAg/k4cthVdvjplpqKpFydgCm
 ONAdEBqLWNGXXV8P+SczGBepHHmgtN6gfpEBUrFMDdVfR1vDMdZfiX+DCGiWxE7RvGQ8
 g6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771924388; x=1772529188;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FR2nGH/TLezukN/2n/e0ILFtuWyjeiAK2I7s85ZYHUc=;
 b=g/BB8Q0gIE1mY5KKugcUAsQGBlLNVPmdzo3NgGQey3+dhrG4HKxSFSGgwt+hJYviHL
 f42OZA772qWZWgZgxhcPZKYQNtRh/I+lvoKDpQFUqXEVPH3VzUBpd80U8bTdLhfXWXrh
 dBECYRMXGCV1OUs86N3I4rXDtbhLoEhUt9FbUs+tuWudzUYx1vxyQjvsXcFPW1PhpnwM
 xkn64pwRynHihWgJU+x8v0sG+d+3j6R+EhrvDLzbKEzZ9KdxLCraRXTAPIGk+mlbSf6y
 JOtt67Bnj+HK26HUyUuusOXOLkeMKLVEnwQm4Ej+llFbV2+aZtiCRTS4vGADkhQ720gT
 aXvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtO7UJLzlooapCHd0LQC9KLtsWdd5itxarDUoW6KqBGo1ofriWgu/ke+qqUitAJygFNPwn8iWVxdUW@nongnu.org
X-Gm-Message-State: AOJu0YwhOGebDC6r+u7h/Jg5Iupp/Ze/EgAccfT3HOvMv0GhVLBPT6wj
 paZvBC7ja+dBDuuSH9pZnm5kPEnLdDa3Qo4WpjwNiXl06/Ly5MaI1cMQsscXVK+GKEp8KMct/Ms
 nHt1aTuK3Obqm2qZF6F4ozLMpjR5GvoDw7fw+5K2xJeYsuxFMbDiX2/Dz
X-Gm-Gg: AZuq6aLMkZaXuUB+ZBdiYErvL2IyJFJ/vs4ogeWSkNJEmhNN4OJmp5B2K8zEG2X+6p/
 CiPNdFn9uRXY05IvO4oSNp2pBAH89O2+mT5XRKOMjjuX0Zar0+fPSFeJt7nb9q2N7zPXqSuvSN3
 4TJ9Wn4CXR7PuEfuhpU1IWvinP8E93wMrDfow7hkeF3ywqAI7ScUwqCd7K7kViNc1WKzpuYJHwd
 TyNyKnyoAfRCLe77BdDvPg311LHh030TlTSJW+zG9EhfVnHCVGV4fNxfckjpMLJhOYuy8Ncar+A
 Pzzlm/oAHVmFDNGhPyNqYfKLfV2jy8iABzb311+bJZRQIz5qpw9goyrWcqVuU4vbDfhnsk7KQvK
 LqqTs4fro+uTiyVjj/UoQ7k/ulBiiJeSRYacn3aSq6sILAPY31p4thfqsLw==
X-Received: by 2002:a05:600c:528a:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-483a95e9570mr182843375e9.17.1771924388448; 
 Tue, 24 Feb 2026 01:13:08 -0800 (PST)
X-Received: by 2002:a05:600c:528a:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-483a95e9570mr182842885e9.17.1771924387987; 
 Tue, 24 Feb 2026 01:13:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:2c1a:3780:4e49:dfcf?
 ([2a01:e0a:165:d60:2c1a:3780:4e49:dfcf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31bc0e3sm295347065e9.5.2026.02.24.01.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 01:13:07 -0800 (PST)
Message-ID: <aa6cbbb8-d8db-451e-9f9d-c430b2e030d9@redhat.com>
Date: Tue, 24 Feb 2026 10:13:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kane Chen <kane_chen@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
References: <20260212213955.2225662-1-clg@redhat.com>
 <20260212213955.2225662-3-clg@redhat.com>
 <CAFEAcA_oJgTc2SyRr11QTeTkmCPgvKiwngAaDiDNw5nUcTFA2w@mail.gmail.com>
 <CAFEAcA_9Np04vouA-m99xB8yU-JhduwxxLj_dTG0QM=AnDbHoQ@mail.gmail.com>
 <aZMwvfw4O5xeH-Gm@redhat.com>
 <98898cd4-de19-41b7-b519-541c48b462ea@redhat.com>
 <7b68fe15-f8fb-4d72-9559-8b6b89bd7563@redhat.com>
 <TYPPR06MB820657F01C98468E1F166C7FFC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <TYPPR06MB820657F01C98468E1F166C7FFC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/24/26 03:53, Jamin Lin wrote:
> + Troy
> 
> Hi Cédric,
> 
>> Subject: Re: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
>>
>> Hello,
>>
>> + Jamin,
>>
>> On 2/16/26 16:08, Cédric Le Goater wrote:
>>> On 2/16/26 15:59, Daniel P. Berrangé wrote:
>>>> On Mon, Feb 16, 2026 at 11:17:38AM +0000, Peter Maydell wrote:
>>>>> On Mon, 16 Feb 2026 at 11:13, Peter Maydell <peter.maydell@linaro.org>
>> wrote:
>>>>>>
>>>>>> On Thu, 12 Feb 2026 at 21:42, Cédric Le Goater <clg@redhat.com>
>> wrote:
>>>>>>>
>>>>>>> Add functional tests for AST2500 and AST2600 machines using the
>>>>>>> OpenBMC SDK v11.00 with Linux kernel 5.15. These tests complement
>>>>>>> the existing SDK tests and verify that QEMU correctly boots older
>>>>>>> kernel versions on these platforms.
>>>>>>
>>>>>>
>>>>>>> +    ASSET_SDK_V1100_AST2600_515 = Asset(
>>>>>>> +
>>>>>>>
>> +'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.
>>>>>>> +00/ast2600-default-515-obmc.tar.gz',
>>>>>>> +
>>>>>>>
>> +'ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6
>>>>>>> +')
>>>>>>
>>>>>> This asset file is over a gigabyte in size, it takes forever to
>>>>>> download, and our functional test asset download framework has no
>>>>>> mechanism for giving any kind of progress indication for downloads
>>>>>> (or even for telling you the URL it is downloading until after the
>>>>>> download is complete).
>>>>>>
>>>>>> Can we have a size limit for test assets please, at least until the
>>>>>> framework can support large assets a bit better ?
>>>>>
>>>>> Followup: we have six test assets that are over 500MB in size, and
>>>>> they are all aspeed tests. Please can you have a look at slimming
>>>>> these down?
>>>>
>>>> I see 2 big assets from aspeed only
>>>>
>>>>     64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7
>> 039e93
>>>>     ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a857
>> 44c0f6
>>>>
>>>>
>>>> what are the names of the other files in $HOME/.cache/qemu/download
>>>> you have that are over 500 MB ?
>>>>
>>>> With regards,
>>>> Daniel
>>>
>>> These are the files :
>>>
>>>
>> 5732255d4617d98b76bbbc116d331d6ac89906fa212969eb8213fdc4aea86451
>>   166M
>>> ast2500-default-515-obmc.tar.gz
>>>
>> 2768e2526bdd3f928df31341801cb6de3b9a40ca942b538a3d0800cd26fbdbfe
>>   166M
>>> ast2500-default-obmc.tar.gz
>>>
>> ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6
>>   1.1G
>>> ast2600-default-515-obmc.tar.gz
>>>
>> 64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7039e93
>>    1.2G
>>> ast2600-default-obmc.tar.gz
>>>
>> 4f8778be176ece1b57d33c4aee13bb989be114c3e4703150eaeb6f996bd5587f
>>   582M
>>> ast2700-a1-dcscm-obmc.tar.gz
>>>
>> d5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76525
>> 520M
>>> ast2700-a1-obmc.tar.gz
>>>
>> 0e93f7976139da71fab9df7952a58bdd80650e23e7abf5853b0eb6695deb02d0
>>   581M
>>> ast2700-dcscm-obmc.tar.gz
>>>
>> e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de4dc
>>   519M
>>> ast2700-default-obmc.tar.gz
>>
>> The image size for v09.08 was around 250 MB for the ast2500,
>> ast2600 and ast2700 SoCs. It would be best to keep it like this for testing.
>>
>> Would it be possible in v12.00 ?
>>
> 
> 
> Thank you for your suggestion and for reporting this issue.
> 
> To allow QEMU to accept the image tarball size, I will create new tarballs specifically for QEMU functional testing.
> 
> The "ast2600-default-image.tar.gz" tarball will be based on "ast2600-default-obmc.tar.gz".
> It will contain only the necessary images from ast2600-default-obmc.tar.gz for QEMU functional testing, such as image-bmc.
> Including only image-bmc in the tarball will significantly reduce its size. In SDK v11.01, the size should be around 64MB.

I think the increase in size comes mainly from the rsa* directories.
Removing these would save 1G.

Can you keep the same v09.08 contents : u-boot.bin, kernel, dtb,
rootfs etc ? It is good to have the different OpenBMC files for
tests too.


> I plan to create the following new tarballs for QEMU functional testing:
> 1. ast2600-default-image.tar.gz
> 2. ast2600-default-66-image.tar.gz
> 3. ast2700-default-image.tar.gz
> 4, ast2700-a1-image.tar.gz
> 5. ast2700-dcscm-image.tar.gz
> 6. ast2700-a1-dcscm-image.tar.gz
ok. No need to change the AST2500 tarballs.
  
> ASPEED will release v11.01 this week. After the v11.01 release, I will update these tarballs and the QEMU functional tests accordingly.

Great !

Thanks,

C.


