Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05E7C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6OW4-0000rK-0M; Tue, 15 Sep 2026 04:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6OW1-0000r0-M9
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6OVv-0005bU-JN
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789460854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CE5z4FacnsphZY+jlak3oW5cOlOt5z6kT/UKXTKkOps=;
 b=IRfa9Jyir0xbv0o/Q6iua8+SSviL1ETTgZrpxQpcoQh3w5k2izlDal6Dl+d2zD16j5eJkV
 xTLUXSp4GCbTTmUwIVqGy2VV7dy8+dOpOvQufC+kzVFye8zei+CkMtTWZkvg6FO2c9c8Bu
 E4vqVn66NW4X8TOLRmSffh9FzqtU6fc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-3LSqcF9NOhK2Y6I6Rtn55A-1; Tue, 15 Sep 2026 04:27:32 -0400
X-MC-Unique: 3LSqcF9NOhK2Y6I6Rtn55A-1
X-Mimecast-MFC-AGG-ID: 3LSqcF9NOhK2Y6I6Rtn55A_1789460851
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a9cd44bfbdso3577632a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789460851; x=1790065651; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CE5z4FacnsphZY+jlak3oW5cOlOt5z6kT/UKXTKkOps=;
 b=WCUlC/3mQonGWVdvDDpXx7hvRmTKrlX3M4Le4s5xEWd8gJ43R/0jT7VAIui1cYvnAu
 XyiZrGhwr22yJlp5PWbNKkp+SDZd94n64nHk7GsGeWxDtkbsc/guFHLZYz/FUEMS9Z3t
 vcDKpcg+3R/ia1sd5qq73H/h49nj90PgSpHPuRGe7Yg34tWB6GG0uG7iMznlu/jY6gng
 0N2NCT8UyIka2LBfRg53gfrniQSqUqQd5fZFOMl0ERYveDDeGZsUXdsgKy2tF3xmZwGc
 YH54L+uMoVCtwGDw71vrNHWnb/UYm0tdanVzs5LlGLEegPqkou+T3WPzH2WgDrxe03vb
 lxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460851; x=1790065651;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CE5z4FacnsphZY+jlak3oW5cOlOt5z6kT/UKXTKkOps=;
 b=rY4+l9kkRCH7r1UHz2gETQTOWdJAa+i5Khh+tWCpPVzItkqd/oV7dRRFu+G+/SGrwZ
 7j6NIVeiUdX/Z64/pf/AmKCdOoOyO8bai4XsebMUBI8FRZRrQnH7pT6dMwDsaSxmwwHR
 T2jkB6aacl+eShBg/X8Q8YiFU1+dJbxCbrZ/byimOEXTqWtcX5YQvfla2Xwvx53RnMqj
 zHwegiJoTsiAZspsRCR+KILf3jbuoFBQQyeOpJ3RTprOZV4dv3MRLbuLvMrIQlKeQraX
 XeRGQ9DLhE/sRATCbuWXVMKGpvCBWsuJEAVz8rmxThStISa26AuYcL3dL4qG2almkay/
 cF3A==
X-Gm-Message-State: AFuF++kvbVBT18ukbMnbOgGNUmecPhE/4Yb8KEWMrSXcEOI0GNQO2nz/
 rirkOJKvojYX7O2ZArYxdKPTdZ5c4DPzGae5F8tnMJTu/2UJz+swyTf6LDKQYOf7Wr6uhyzB5wO
 6HRZhoeetqYVhdGxmyv3v+BdRuz8Ub7ONADBZN4bjWye+Xig21hmabMUajaMzFa93a57CgKqanu
 DLPdGPTTb2JWhMN0B9RngGiVMYYSR4WaN3RA==
X-Gm-Gg: AYBFou0f0BY2JuqnCj9ADcfmJEEtVDt1Wp7z5h3Uhayh1sTFF735CaUrQwb9DzlzQx3
 /hD3ECTvFY7q3SL1SJGtDdwJy9IYbjH57baLhHdA/2tekLyyw1iO5pXL6V+kok6ulIo6LTf55k1
 g4nyooVa9c//Qdmr5Fw28iyBHYvWHsyMsCiuZGHLlgf6/wE0LxkJsvaPMzhcFOLd2tdiRoHMYAO
 bRN/EGNOJO68jmswr/ksPcNEAAYaI2Lq7gwngnoiuJA9sJI9H45u5f7R7EVwkAFTVYkhJx/kPD/
 48uEvAOTq7o0kFLKAqK7v5dD3TECJeahouwF05qP1hK+/zXbQKY+ghfUJTdOSvdTtf1yIy9F2kM
 CSl+3F8MwC0dMRa9gfmlBMbGNNZwsW4750mMcrMD32Q==
X-Received: by 2002:a05:6402:44d5:b0:6a9:93cf:2367 with SMTP id
 4fb4d7f45d1cf-6aa12f0825bmr7212a12.41.1789460851251; 
 Tue, 15 Sep 2026 01:27:31 -0700 (PDT)
X-Received: by 2002:a05:6402:44d5:b0:6a9:93cf:2367 with SMTP id
 4fb4d7f45d1cf-6aa12f0825bmr7193a12.41.1789460850702; 
 Tue, 15 Sep 2026 01:27:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5?
 ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9b594e462sm5477729a12.24.2026.09.15.01.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 01:27:30 -0700 (PDT)
Message-ID: <9cd1f3b7-183f-41ba-baa7-7c7d0ef81ce0@redhat.com>
Date: Tue, 15 Sep 2026 10:27:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/pci-bridge: Add x-speed and x-width properties to
 xio3130 ports
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Boaz Ben Shabat <bbenshab@redhat.com>
References: <20260915072507.1230187-1-clg@redhat.com>
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
In-Reply-To: <20260915072507.1230187-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/15/26 09:25, Cédric Le Goater wrote:
> Hello,
> 
> The xio3130-downstream and x3130-upstream devices lacks x-speed and
> x-width device properties, making it impossible to configure PCIe link
> speed/width when building PIX switch topologies for GPU/NIC passthrough.
> 
> Fix that and preserve migration compatibility with a 2.5GT/s x1 default.
> 
> Thanks,
> 
> C.
> 
> Cédric Le Goater (2):
>    hw/pci-bridge: Add x-speed and x-width properties to
>      xio3130-downstream
>    hw/pci-bridge: Add x-speed and x-width properties to x3130-upstream
> 
>   hw/core/machine.c                  |  4 ++++
>   hw/pci-bridge/xio3130_downstream.c |  5 +++++
>   hw/pci-bridge/xio3130_upstream.c   | 28 +++++++++++++++++++++++++++-
>   3 files changed, 36 insertions(+), 1 deletion(-)


Reported-by: Boaz Ben Shabat <bbenshab@redhat.com>

Thanks,

C.


