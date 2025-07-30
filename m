Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAE5C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 14:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh8B9-0002Hm-3H; Wed, 30 Jul 2025 10:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uh6kv-0003SC-50
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 09:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uh6ks-0006ew-Pr
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 09:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753881720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RAJ7D49lZZveSrV9yXIwtRIwJhIV3w+/LAAStps5N70=;
 b=Ai5ASKm5r3JcfmvCLQL15l8yG1FdK56tm9DjYulRy3blGDhTgurh2x1ci6w25kc4I6ijj7
 JKWvewzgoIwlxAe9FA/DtxULwfD2iYLpuqI7y3wJ/QUrtLmlNCBm40x/QYt98MaGS+Anz+
 nP2DACLDF08Si2K2++kwgE4R3XfSXpQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-STd2HGKzNyOezLH5Kskc2Q-1; Wed, 30 Jul 2025 09:21:58 -0400
X-MC-Unique: STd2HGKzNyOezLH5Kskc2Q-1
X-Mimecast-MFC-AGG-ID: STd2HGKzNyOezLH5Kskc2Q_1753881717
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b78aa2a113so1536024f8f.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 06:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753881717; x=1754486517;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RAJ7D49lZZveSrV9yXIwtRIwJhIV3w+/LAAStps5N70=;
 b=iPI0erl+nu17fSWo7u6ncWz1Jt4ZcK2rHHXDVLrqw0dTwSPzkEXcW6/nkvStg8g7QX
 oHY58H2Kml/Qf9mGFk71VxK2zo+cxlFUf9Ht4DTN8VGLbPqREZVjLHBLNTWzQUk8+zXE
 qWjjMH7DWrc0AULagev00md1/cQjt7+3hhEvmb001Yd/FwekVti6ikjpKfBynLfBcoCg
 8jDKbC+YDpnPvyDiFpz7+0w4HMF2/60PpaI4vfV+3sM6ogrj5YU5QJ/AG0LeRTIBWSsA
 UWJJsKOd00pwXZ+X0NB4OsquIrC8LyaTGN5fnEhDZqKa4uDcLbxOIJq3Ljv5/ceR+eJq
 s4kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrnVrQRi4yeC9haEYOQkYjUoJPMdboY1bHmVgLcZ5dvfG7JXWMnC49n3rzEHcXwSydvli8zLgjRXA3@nongnu.org
X-Gm-Message-State: AOJu0YxXwl0/R+7iF8cK/mrAehxVaptAUlwoiXBn6WZh2QLCfKEWIOoN
 f6XN3YmCRtGiglLCbXgFJq40kbeD9KCm9Ryjdhlx1vW+ODejwGSw4nTLfbievzRd/tN0DWbWDqA
 R05LzizY81isejeVOhHK4tCncMjHm8tK/iFeI/6xXMCf9ba+4dJJ/Alt+
X-Gm-Gg: ASbGncviMWNGU64hzCDDKNkSfMU8o53TxNa1V8ZCYskE9cgqBMvrVdD2VSMRnucHcJZ
 /C/HUhOTS+Dg6mAkzHEvIbTRlLjBzprGboZMbPf+RHf06NkmN1sHzhqMMgEjzhhm9kdLqXLudLx
 CsGIlLWYKm3lrNqpvrSJwjPuizhGenqANRsmV9lZOi4I46tkZhIdngzJII9RxfB+ZPkX82AiOvH
 1sSyVEmn9j2qo8U4pebslD3TF4e9Xq1vS5HUjlmhr1ifgkMTkP3Qh5+68huoXVQU58lF/rXs+P2
 /6aURwDlAQYJIEPlAljnAi5WwS593eHd6nrHjDtJpl/bMJj+nUsFUOS219xtOLsDwVUXemJ0Czs
 1ls+Mg34=
X-Received: by 2002:a5d:5f44:0:b0:3b7:58be:8fc with SMTP id
 ffacd0b85a97d-3b794ff8883mr2479894f8f.43.1753881717357; 
 Wed, 30 Jul 2025 06:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdNT6NYHZ2qz+EjIkBKrd65jn2DmRN9fIAdHzNn9SS60NOF2fNYQ22sq1MuvTH0WyW6LaCVg==
X-Received: by 2002:a5d:5f44:0:b0:3b7:58be:8fc with SMTP id
 ffacd0b85a97d-3b794ff8883mr2479869f8f.43.1753881716868; 
 Wed, 30 Jul 2025 06:21:56 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b78b0941a9sm8659111f8f.31.2025.07.30.06.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 06:21:56 -0700 (PDT)
Message-ID: <bfcf9674-238d-4716-8fad-aef9b20c9d0d@redhat.com>
Date: Wed, 30 Jul 2025 15:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] pc-bios: Update vbootrom image to commit
 183c9ff8056b
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell
 <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>
References: <20250730045813.822132-1-clg@redhat.com>
 <20250730045813.822132-4-clg@redhat.com>
 <SI2PR06MB504176530DEA90C6B261758AFC24A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <3db87420-ef95-4548-a74b-be38f0794a90@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
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
In-Reply-To: <3db87420-ef95-4548-a74b-be38f0794a90@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/30/25 13:47, Philippe Mathieu-Daudé wrote:
> On 30/7/25 07:08, Jamin Lin wrote:
>>> From: Cédric Le Goater <clg@redhat.com>
>>> Sent: Wednesday, July 30, 2025 12:58 PM
>>> To: qemu-devel@nongnu.org
>>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>; Michael Tokarev
>>> <mjt@tls.msk.ru>; Peter Maydell <peter.maydell@linaro.org>; Hao Wu
>>> <wuhaotsh@google.com>; Jamin Lin <jamin_lin@aspeedtech.com>; Cédric Le
>>> Goater <clg@redhat.com>
>>> Subject: [PATCH v3 3/3] pc-bios: Update vbootrom image to commit
>>> 183c9ff8056b
>>>
>>> Full changelog since last update (1287b6e42e83) :
>>>
>>> Hao Wu (2):
>>>        Automatically search for UBOOT location for NPCM8xx images.
>>>        Dynamically detects NPCM8XX UBOOT destination and size.
>>>
>>> Jamin Lin (5):
>>>        Add initial support for AST27x0
>>>        ast27x0: Show build date and git version
>>>        ast27x0: Initialize and enable SSP/TSP using SCU with reserved-memory
>>> from DTB
>>>        ast27x0: Fix missing SCU module reset for SSP and TSP initialization
>>>        ast27x0: Fix Makefile to unconditionally set CC to support correct
>>> cross-compilation
>>>
>>> Compiled with gcc version 13.3.0
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   pc-bios/ast27x0_bootrom.bin | Bin 15552 -> 16408 bytes
>>> pc-bios/npcm7xx_bootrom.bin | Bin 768 -> 672 bytes
>>> pc-bios/npcm8xx_bootrom.bin | Bin 608 -> 672 bytes
>>>   3 files changed, 0 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/pc-bios/ast27x0_bootrom.bin b/pc-bios/ast27x0_bootrom.bin index
>>> 0b9b3a2360e375bb6007ecdf13b39d931870f6fa..a4c94d64da55ade9b4beb2a4
>>> 09132f315fb51347 100644 GIT binary patch literal 16408
>>> zcmdUWd3YSvmGAG?Ew$Q`aJ00R*#4rDmwcu%c#|v{oT#)wAWjC;^aI9_QMaTv
>>> G7^%t
>>> z7#v%{W#gGF;=SjJ+O%;1$%f3JddwRh$cdXFgK$V5!Q?$7%xVlR*=DnoQM{@_(tY
>>> 2#
>>> zRV}s5GMPVL^P#S;I``aj&+<Fxo?EU2JgI=k4R~e%o;1J%0Q8*>cr+M;rGQ6=F<1h4
>>> z0x$-b10Dm$;8MUd0Ap}5;EBN)ywVx_|I=ry#$Ojg<O9awUX;CFr0PGfVCYv;a9b7
>>> h
>>> zcpb36M&qxK36bAZ&R>7OoWCAG;Tva!$S=B`-ByX-!Ac#kmIvl`J;rg{iyXI|<hZQ|
>>> zDW@#Jzph$8@DD(AM<&eAgvhVvxGj|Q+y%pz{QP<#JeT1%9f<dQo4?+p@z)dc
>>> 0)=lJ
> 
> 
>>
>> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
> 
> Did you meant 'Tested-by'? =)
> 


Indeed, that would be nice to have for all machines.

Thanks,

C.



