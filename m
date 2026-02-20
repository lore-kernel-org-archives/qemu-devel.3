Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4D1C53200
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 08:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtMJL-0001m0-Pi; Fri, 20 Feb 2026 03:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vtMJI-0001l8-1R
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 03:56:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vtMJF-0005iM-83
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 03:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771577782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9YbtkG9/UhEyXP4cH/mUo9oadIiDz2QHrRBrlIl1lts=;
 b=cIXv9eIN1hGIcvMF+Cm6pOQ5LevxauwzMpSiNRf4SyKyTW4ID/HoP0mJLtD/AWFxB32c4Y
 TnzCUbbxP+paTndGIfB/W4PMzrVOHNnTf2LrdzBjMLmOyslUssGnPClV5YfOOSCYJZsK+Y
 HO/6oHi41+pzMYDBgfEKL3qpjXhusQ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-HFNKymdPN8a0um-0wBuG1Q-1; Fri, 20 Feb 2026 03:56:21 -0500
X-MC-Unique: HFNKymdPN8a0um-0wBuG1Q-1
X-Mimecast-MFC-AGG-ID: HFNKymdPN8a0um-0wBuG1Q_1771577780
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-483a2db68caso11680095e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 00:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771577780; x=1772182580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9YbtkG9/UhEyXP4cH/mUo9oadIiDz2QHrRBrlIl1lts=;
 b=gQHCIe6kA0eyNMMQ8NEnMe7mqN/ufTLb371r5DhpVXTcPb3NHQC04fwlpXWgAKNWy0
 IpmBI5KAtgaWlN5iOU1H40/ds/L3JUJEA4CgAOdclE6Nx9pviwStbXEcwCSd/DKDdk2T
 Zsa1n4D4NvbUKBGoJtAg9Vs+nqDfpjJGfvrcr5Rn4Hi1NOjTkAcypGH3haDPGkIBTF7B
 +0HqS2mjDN0YUNI/8svXssRmjuEVPDGYGK1D2mEdneroQi4qmJuSAu2Qe9xr1igEwllm
 j2CBTkqlxP9bq6p05ZmtqHEd8IYRYkd5P33HBii8KO8BtSXVZJY/uHs8Z4IDQb1JYrUZ
 tPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771577780; x=1772182580;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YbtkG9/UhEyXP4cH/mUo9oadIiDz2QHrRBrlIl1lts=;
 b=M5MvOARb4lgxopmhRygIoVhM3QKsQbullzTVLUzPlcTTaD6x+RVRcw2hUdVeadSX2B
 P1uuwChjVSGDJqcWXqiUgBPhrW+o+yy7yWPl/BFtT1HdLauLLNFUzb+8DpzUh6msTmE6
 v2hEfNY2MmmRx1G8bwqeaxVuURvKFwJqnpjw45fN5s3LDFgZW0hXAqgVYQLnQUl9KoFS
 gRnIMYTRdNrQvykinxCMOedlWyB1/bgJmc9omhS1huCSvNpGfcHyj9oV1DWoRRDGj++7
 5r/KgO9639XMpYwy+FVPV7A7pHr2+bwPI+ooqdUXNVK1Jzox37mQXrdb7zLaw6oZTrve
 4/3w==
X-Gm-Message-State: AOJu0YwEzTzgs3WSTRlzQDeFffqfSZB7Mfobt6nXf383AchHa5n57PS+
 W3Utus+Ce7jZZb9n5KWBTHgJAeh21o3Uwwocs4TGj026WqNfc8CtdEePPO7utCpCNFgUO09Texw
 yMr7vTLFrJHl/15Fv5PWF4fgpp44PpAggaskc/bONs/Z28iu4UJ+f1NnuhpIYTBKK
X-Gm-Gg: AZuq6aKhpGQkkUnQRPRe5ZFmEJ+wur2Liv7fycO9lUHQADxKCWdWqk4pLrfcX4jvwSs
 +aQRHAoydNIrdQ0uR3wiAu+f5rMECoZRkNkM1lTttf++zxDb2qnEx1+09Be4Fysvgf/kcylk2+1
 dyXnUQ2gQLyN4kA/PE9XjK4Vl9ZqPKw9m2In8RGif7ZSq+64tVgmwyuewy7rfywNNvL3463lcTs
 D86NHHSYOKJqdCfnYB8iA+aQ+qDmVzIwRAGahK6tq+UjbrExZWCcpodV7/VN2+vOkWmBdXLSbLI
 UwYhAOAPsW8NW+Gouxhl58ZIgBsv5SaP5kjK47dTp4rGI6TXhAKIWqc68s9T/UllfVKLQk+yjMk
 H+F2o1VWUtqn1/NslluTfS+0f1YtrL5sVMDOOKRsK7+WqAJpahaLiQ7NXNVqO
X-Received: by 2002:a05:600c:19d0:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-48398a57fd9mr155918945e9.15.1771577779492; 
 Fri, 20 Feb 2026 00:56:19 -0800 (PST)
X-Received: by 2002:a05:600c:19d0:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-48398a57fd9mr155918565e9.15.1771577778985; 
 Fri, 20 Feb 2026 00:56:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b1d79sm110199965e9.3.2026.02.20.00.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 00:56:18 -0800 (PST)
Message-ID: <b780d16f-82ba-43e2-b189-ba70594c7d7a@redhat.com>
Date: Fri, 20 Feb 2026 09:56:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/m25p80: Fix Winbond Fast Read dummy cycles
To: Peter Maydell <peter.maydell@linaro.org>,
 Joel Bueno <buenocalvachejoel@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Marcin Krzeminski <marcin.krzeminski@nokia.com>
References: <20251221105340.2699327-1-buenocalvachejoel@gmail.com>
 <CAPDLHD5HGNAu1=JD=V-9YQMpR_8-tWjONex2jj4ZFHbNe9qVcg@mail.gmail.com>
 <CAFEAcA8xsFeCAnvna4+mFQuZCx8gNEJX5BbFzTYkr6rcaX43Lw@mail.gmail.com>
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
In-Reply-To: <CAFEAcA8xsFeCAnvna4+mFQuZCx8gNEJX5BbFzTYkr6rcaX43Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello,

+Marcin,

On 2/19/26 21:01, Peter Maydell wrote:
> On Wed, 7 Jan 2026 at 11:30, Joel Bueno <buenocalvachejoel@gmail.com> wrote:
>>
>> Is there any feedback on this patch series?
> 
> Which board model(s) does this affect? You might have
> some luck cc'ing their maintainers.
AFAIR (10y ago ...), the dummy cycles in m25p80 are modeled as
extra "dummy bytes" consumed before data phase begins. So,
in QEMU : 8 cycles = 1 dummy byte.

There could be bugs in this area, but this case was supposedly
fixed by commit 3830c7a460b8 ("m25p80: Fix WINBOND fast read
command handling") and given the number of QEMU boards booting
from a Winbond flash device :

   tests/functional/aarch64/test_aspeed_ast2700a1.py:        self.vm.set_machine('ast2700a1-evb,fmc-model=w25q512jv')
   tests/functional/aarch64/test_aspeed_ast2700a2.py:        self.vm.set_machine('ast2700a2-evb,fmc-model=w25q512jv')
   hw/arm/aspeed_ast10x0_evb.c:    amc->fmc_model = "w25q80bl";
   hw/arm/aspeed_ast10x0_evb.c:    amc->spi_model = "w25q256";
   hw/arm/aspeed_ast10x0_evb.c:    amc->fmc_model = "w25q80bl";
   hw/arm/aspeed_ast10x0_evb.c:    amc->spi_model = "w25q02jvm";
   hw/arm/aspeed_ast2600_bletchley.c:    amc->fmc_model = "w25q01jvq";
   hw/arm/aspeed_ast2600_catalina.c:    amc->fmc_model = "w25q01jvq";
   hw/arm/aspeed_ast2600_evb.c:    amc->fmc_model = "w25q512jv";
   hw/arm/aspeed_ast2600_evb.c:    amc->spi_model = "w25q512jv";
   hw/arm/aspeed_ast27x0_evb.c:    amc->fmc_model = "w25q01jvq";
   hw/arm/aspeed_ast27x0_evb.c:    amc->spi_model = "w25q512jv";
   hw/arm/aspeed_ast27x0_evb.c:    amc->fmc_model = "w25q01jvq";
   hw/arm/aspeed_ast27x0_evb.c:    amc->spi_model = "w25q512jv";
   hw/arm/aspeed_ast27x0-fc.c:#define AST2700FC_FMC_MODEL "w25q01jvq"
   hw/arm/aspeed_ast27x0-fc.c:#define AST2700FC_SPI_MODEL "w25q512jv"
   hw/arm/npcm7xx_boards.c:    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
   hw/arm/npcm8xx_boards.c:    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));

I doubt this change is correct or the issue is more complex
than it seems. Please try to run the functional tests, all
ast2600 machines seem to fail to boot with this patch.


Thanks,

C.


For the records, fast read commands are used in the tests. See below.

   [0x406c0641] : The second byte '6c' is the SPI operation.


aarch64/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/console.log:2026-02-11 13:22:45,545: [    0.510414] spi-aspeed-smc 1e620000.spi: CE0 read buswidth: 4 [0x406c0641]
aarch64/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/console.log:2026-02-11 13:22:45,713: [    0.650635] spi-aspeed-smc 1e630000.spi: CE0 read buswidth: 4 [0x406c0641]
aarch64/test_aspeed_ast2700a1.AST2x00MachineSDK.test_aarch64_ast2700a1_evb_sdk_v11_00/console.log:2026-02-13 11:49:30,173: [    1.517517] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]
aarch64/test_aspeed_ast2700a1.AST2x00MachineSDK.test_aarch64_ast2700a1_evb_sdk_v11_00/console.log:2026-02-13 11:49:30,320: [    1.608993] spi-aspeed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]
aarch64/test_aspeed_ast2700a1.AST2x00MachineSDK.test_aarch64_ast2700a1_evb_sdk_v11_00/console.log:2026-02-13 11:49:30,346: [    1.625580] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]
aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_ioexp_v11_00/console.log:2026-02-13 15:50:03,329: [    4.852499] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0041]
aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_ioexp_v11_00/console.log:2026-02-13 15:50:03,850: [    5.178221] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 1 [0x000c0041]
aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_sdk_v11_00/console.log:2026-02-13 11:49:31,247: [    1.275618] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]
aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_sdk_v11_00/console.log:2026-02-13 11:49:31,369: [    1.352064] spi-aspeed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]
aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_sdk_v11_00/console.log:2026-02-13 11:49:31,385: [    1.361942] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]
aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_ioexp_v11_00/console.log:2026-02-10 16:47:50,922: [    3.123120] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0041]
aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_ioexp_v11_00/console.log:2026-02-10 16:47:51,224: [    3.312014] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 1 [0x000c0041]
aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_sdk_v11_00/console.log:2026-02-10 16:49:00,279: [    1.264763] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]
aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_sdk_v11_00/console.log:2026-02-10 16:49:00,408: [    1.345588] spi-aspeed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]
aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_sdk_v11_00/console.log:2026-02-10 16:49:00,424: [    1.355559] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]
aarch64/test_aspeed_ast2700fc.AST2x00MachineSDK.test_aarch64_ast2700fc_sdk_vbootrom_v11_00/console.log:2026-02-13 11:49:40,859: [    1.568162] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]
aarch64/test_aspeed_ast2700fc.AST2x00MachineSDK.test_aarch64_ast2700fc_sdk_vbootrom_v11_00/console.log:2026-02-13 11:49:41,032: [    1.676511] spi-aspeed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]
aarch64/test_aspeed_ast2700fc.AST2x00MachineSDK.test_aarch64_ast2700fc_sdk_vbootrom_v11_00/console.log:2026-02-13 11:49:41,069: [    1.699459] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]
arm/test_aspeed_ast2500_buildroot.AST2500Machine.test_arm_ast2500_evb_buildroot/console.log:2026-02-13 15:50:25,370: [    1.333537] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203b0641]
arm/test_aspeed_ast2500_buildroot.AST2500Machine.test_arm_ast2500_evb_buildroot/console.log:2026-02-13 15:50:25,659: [    1.625199] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:2 [0x203c0041]
arm/test_aspeed_ast2500_sdk.AST2500Machine.test_arm_ast2500_evb_sdk/console.log:2026-02-13 15:50:22,593: [    1.287417] spi-aspeed-smc 1e620000.spi: CE0 read buswidth: 2 [0x203b0641]
arm/test_aspeed_ast2500_sdk.AST2500Machine.test_arm_ast2500_evb_sdk/console.log:2026-02-13 15:50:23,319: [    2.013603] spi-aspeed-smc 1e630000.spi: CE0 read buswidth: 2 [0x203c0741]
arm/test_aspeed_ast2600_buildroot.AST2600Machine.test_arm_ast2600_evb_buildroot/console.log:2026-02-13 15:50:35,593: [    2.848343] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 [0x406c0641]
arm/test_aspeed_ast2600_buildroot.AST2600Machine.test_arm_ast2600_evb_buildroot/console.log:2026-02-13 15:50:35,876: [    3.086504] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0041]
arm/test_aspeed_ast2600_buildroot_tpm.AST2600Machine.test_arm_ast2600_evb_buildroot_tpm/console.log:2026-02-13 15:51:11,310: [    1.769397] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 [0x406c0641]
arm/test_aspeed_ast2600_buildroot_tpm.AST2600Machine.test_arm_ast2600_evb_buildroot_tpm/console.log:2026-02-13 15:51:11,400: [    1.844341] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0041]
arm/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/console.log:2026-02-13 15:50:31,578: [    4.177582] spi-aspeed-smc 1e620000.spi: CE0 read buswidth: 4 [0x406c0641]
arm/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/console.log:2026-02-13 15:50:32,052: [    4.571849] spi-aspeed-smc 1e630000.spi: CE0 read buswidth: 4 [0x406c0641]
arm/test_aspeed_ast2600_sdk_otp.AST2600Machine.test_arm_ast2600_otp_blockdev_device/console.log:2026-02-13 15:50:27,134: [    2.312565] spi-aspeed-smc 1e620000.spi: CE0 read buswidth: 4 [0x406c0641]
arm/test_aspeed_ast2600_sdk_otp.AST2600Machine.test_arm_ast2600_otp_blockdev_device/console.log:2026-02-13 15:50:27,533: [    2.644716] spi-aspeed-smc 1e630000.spi: CE0 read buswidth: 4 [0x406c0641]
arm/test_aspeed_bletchley.BletchleyMachine.test_arm_ast2600_bletchley_openbmc/console.log:2026-02-13 15:50:39,306: [    2.488488] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203c0641]
arm/test_aspeed_bletchley.BletchleyMachine.test_arm_ast2600_bletchley_openbmc/console.log:2026-02-13 15:50:46,183: [    8.220262] spi-aspeed-smc 1e620000.spi: CE1 read buswidth:2 [0x203c0041]
arm/test_aspeed_catalina.CatalinaMachine.test_arm_ast2600_catalina_openbmc/console.log:2026-02-13 15:50:34,667: [    1.470919] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203c0641]
arm/test_aspeed_catalina.CatalinaMachine.test_arm_ast2600_catalina_openbmc/console.log:2026-02-13 15:50:41,745: [    7.369080] spi-aspeed-smc 1e620000.spi: CE1 read buswidth:2 [0x203c0041]
arm/test_aspeed_gb200nvl_bmc.GB200Machine.test_arm_aspeed_gb200_openbmc/console.log:2026-02-13 15:50:22,255: [    1.277601] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 [0x406c0641]
arm/test_aspeed_gb200nvl_bmc.GB200Machine.test_arm_aspeed_gb200_openbmc/console.log:2026-02-13 15:50:22,589: [    1.558898] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0041]
arm/test_aspeed_palmetto.PalmettoMachine.test_arm_ast2400_palmetto_openbmc/console.log:2026-02-13 15:50:31,164: [    0.840722] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203b0641]
arm/test_aspeed_palmetto.PalmettoMachine.test_arm_ast2400_palmetto_openbmc/console.log:2026-02-13 15:50:31,405: [    1.082523] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:2 [0x203c2041]
arm/test_aspeed_romulus.RomulusMachine.test_arm_ast2500_romulus_openbmc/console.log:2026-02-13 15:50:35,622: [    1.281889] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203b0641]
arm/test_aspeed_romulus.RomulusMachine.test_arm_ast2500_romulus_openbmc/console.log:2026-02-13 15:50:35,832: [    1.491569] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:2 [0x203c0041]
arm/test_aspeed_witherspoon.WitherspoonMachine.test_arm_ast2500_witherspoon_openbmc/console.log:2026-02-13 15:50:44,149: [    0.885126] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203c0641]
arm/test_aspeed_witherspoon.WitherspoonMachine.test_arm_ast2500_witherspoon_openbmc/console.log:2026-02-13 15:50:44,193: [    0.932894] spi-aspeed-smc 1e620000.spi: CE1 read buswidth:2 [0x203c0041]
arm/test_aspeed_witherspoon.WitherspoonMachine.test_arm_ast2500_witherspoon_openbmc/console.log:2026-02-13 15:50:44,242: [    0.982561] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:2 [0x203c0041]


