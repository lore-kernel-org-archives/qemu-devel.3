Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16AEC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFC9M-0001JI-BP; Wed, 14 May 2025 09:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFC9K-0001Hn-AT
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFC9I-0006GJ-LR
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747229271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JHn8AdZYh5rmsPnGxFSZXcuFWSETN8ZSVj1hGnT9uJc=;
 b=ac8Fuk4J63vqEgikwFeqiw9aJeiGGaID7qKOGLBFXYSJ0AbOumgfafsMOIWouC7JyKmWpY
 e19VPTVmxsuaUNlh7CIVzEVNilYUqe5kMNhOL2MSrAZ/eivT/KkAxWnPBugSlbIHSCQzCc
 Yeb3j4AXJcNeiVMjCcvKTfUCdgERGFc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-NRcJ4bcgP7eVcFt3HyP5gg-1; Wed, 14 May 2025 09:27:49 -0400
X-MC-Unique: NRcJ4bcgP7eVcFt3HyP5gg-1
X-Mimecast-MFC-AGG-ID: NRcJ4bcgP7eVcFt3HyP5gg_1747229268
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0b5d18cb7so2659271f8f.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 06:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747229268; x=1747834068;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHn8AdZYh5rmsPnGxFSZXcuFWSETN8ZSVj1hGnT9uJc=;
 b=TTogB/+nqJpFNbqck4cel7bMIMzidxnaPA9q8yBl+AWCASp1C8/U6Uk3Uw0ZL9ukfB
 VfxUEXbwM3E0TLlJEJQuyXg7MMXz0iZpfki55m2zqVe3vqKVQ2w4u0yKnQwCto3Pq5YT
 beEXDRZWrDTMzOWrGP/0RdIXEI8CFgfklMpmK/cPgg8w+ZULMBVwFcFzrtzbLbaaL9Tc
 2cTzSa2CoBnr1KowCCVCjPI5PAYULlSDI1jpyQ9163UazamGTK8OSyaqp8I14FZWV+x9
 bVQk+crSXydjKU4DOXBMqwReZiVoe76QrC1YCUbIej/9TCRthzAHpMcjLE8isM+jabPb
 /nBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZEU2GoIkBFWIho52sXC4mfPClGVdAUWAPIoHIHqxG+uVb3hOKBqcLH24kfoOceuby+3vTPfK3te3A@nongnu.org
X-Gm-Message-State: AOJu0YwSRakNTGGPx1Q7rVcSOBgHb4tEzJQEtGbUkhvPFm1sRIo5oFc/
 G6qMg84utma+TUAqVsZc0ItCIAq6n6ZVDbjtiZIn+wFMgdTFS3YM8TEnKCPdF0GgN0FpUwcDzlz
 J/FTOrejb7c4oaxHbEh9XkySynrXPnZMCxZ2er/UZChkCnBgXpBi3
X-Gm-Gg: ASbGncuAdqmQpHSgLKZI8cbYoFaUKRVChhTMpoU6fwGAv9ShWer8hLrzG4jc2ZC2ed6
 nD7Xmdz0raSqE1hT0Jag8CwIurFVrmsdpQrj3QOHcxklqYgOQWcf82HLge9unCGLoORGcr/dypV
 sbe0lAkqT1c1Cm7fNRiq2+1dvwTnm/tv6+LF1K7VlEq8FjUDIYMhq/cyJnTpzLYqDy4vnLclpif
 Lt0Qnhs2J92ZKrQys00wh+PH196deu3RxwVgiD6bgOZ2mhuNXUw/YB0DeKjhVdr75zh3fxhoikN
 McrhzVeEje/WG+yX1HjdcxhOpbN7NZ5zXe/QpVyYp69rAZc3wg==
X-Received: by 2002:a05:6000:2510:b0:39a:c467:a095 with SMTP id
 ffacd0b85a97d-3a3496a67camr2677118f8f.24.1747229267664; 
 Wed, 14 May 2025 06:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1LIttmdU2MZi1SooChNWvXIE8Ok5fIW3Yo2+ekGUu+Ytpe8Wu/ggio6gWzeH9jWNWKRR1GQ==
X-Received: by 2002:a05:6000:2510:b0:39a:c467:a095 with SMTP id
 ffacd0b85a97d-3a3496a67camr2677089f8f.24.1747229267305; 
 Wed, 14 May 2025 06:27:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ebe4fsm20074754f8f.39.2025.05.14.06.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 06:27:46 -0700 (PDT)
Message-ID: <395b5586-67f9-48db-9830-c4ace0b85e47@redhat.com>
Date: Wed, 14 May 2025 15:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] hw/arm/aspeed_ast27x0: Fix unimplemented region
 overlap with vbootrom
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, longzl2@lenovo.com, yunlin.tang@aspeedtech.com
References: <20250514090354.1461717-1-steven_lee@aspeedtech.com>
 <20250514090354.1461717-3-steven_lee@aspeedtech.com>
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
In-Reply-To: <20250514090354.1461717-3-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/14/25 11:03, Steven Lee wrote:
> The unimplemented memory region overlaps with the VBootROM address
> range, causing incorrect memory layout and potential behavior issues.
> 
> This patch adjusts the size and start address of the unimplemented
> region to avoid collision. The IO memory region (ASPEED_DEV_IOMEM) is
> now moved to 0x20000 to reserve space for VBootROM at 0x0.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>

You didn't reply to the question I asked on the v1 series.
How useful is this ASPEED_DEV_IOMEM region ?

Thanks,

C.



> ---
>   hw/arm/aspeed_ast27x0.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 1974a25766..bb61c30cf4 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -23,14 +23,14 @@
>   #include "qobject/qlist.h"
>   #include "qemu/log.h"
>   
> -#define AST2700_SOC_IO_SIZE          0x01000000
> +#define AST2700_SOC_IO_SIZE          0x00FE0000
>   #define AST2700_SOC_IOMEM_SIZE       0x01000000
>   #define AST2700_SOC_DPMCU_SIZE       0x00040000
>   #define AST2700_SOC_LTPI_SIZE        0x01000000
>   
>   static const hwaddr aspeed_soc_ast2700_memmap[] = {
> -    [ASPEED_DEV_IOMEM]     =  0x00000000,
>       [ASPEED_DEV_VBOOTROM]  =  0x00000000,
> +    [ASPEED_DEV_IOMEM]     =  0x00020000,
>       [ASPEED_DEV_SRAM]      =  0x10000000,
>       [ASPEED_DEV_DPMCU]     =  0x11000000,
>       [ASPEED_DEV_IOMEM0]    =  0x12000000,


