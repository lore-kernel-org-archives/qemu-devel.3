Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14D6D1A63E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 15:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veE0J-0006xR-Bk; Fri, 09 Jan 2026 10:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veE08-0006t9-Cm
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:02:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veE03-0003vT-TA
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767970915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3OmRdB2KSZAZ1bzTFk4iWzfuAfVEAloZNwSSRQo6bjQ=;
 b=Navn0mcv4068Bapup1zn6sIEmUhf5jlQf8XFAQASIFHCMcr43F2zkszC5JqRE1mn2yFjhf
 CvHKTvp8CRK/0ATZL7bP0861PUPpunr8eP2p68igWS5na+nCvvYQipX+JqmaluEYtNW2ak
 2BTOYTbztcHYg7pItiX7YuiAqCS7TJg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-j5CN57xtODCeDuMm62R6UA-1; Fri, 09 Jan 2026 10:01:54 -0500
X-MC-Unique: j5CN57xtODCeDuMm62R6UA-1
X-Mimecast-MFC-AGG-ID: j5CN57xtODCeDuMm62R6UA_1767970913
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430f8866932so3467662f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 07:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767970913; x=1768575713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3OmRdB2KSZAZ1bzTFk4iWzfuAfVEAloZNwSSRQo6bjQ=;
 b=DtrBIulWhLFt45/UKTKt/AC4QejMUk+pb0AxIcm9fmPg19AOKzbrQBqlagKn4UvbxA
 MOfZ5KqJujzD6uAH9A/EbW+9hAjwkiSB7srMOSonoYXhaAkSwAweqA/nZ/norfzHejfs
 bk6iMCuEXEtTtj35ecwmTLXahGOhAk7sNmE8fTERCsjWRNLnU0o3gXdsiC0Uxg4joyeY
 HquKOW+HJ9JF1hlLmIEOToxDeZB22V2piGwFKnMgS1IXfEUMdXmMUGz1dp6aecpGB2wg
 Whzd9JlwmpRNRQp12sFIhYuwSIj/r7BV6sNHQCxekTRGMGMHdNCw8z1D3li9SZmusffM
 3UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767970913; x=1768575713;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OmRdB2KSZAZ1bzTFk4iWzfuAfVEAloZNwSSRQo6bjQ=;
 b=Nz4G6GRcgdvflGR28ZNMdVR/o73O/Un05ePuCjUX4DDAemVkFccnjDI7X/0uf5K5m7
 4yV+tNQIiRHE9ZeA7JORai95z1D29rfmrd0aeTWVa3O0J6dn38NepSlqMS34f6C0YYK+
 R7QvP/o4DsqLe6i6ax6YZsxGFTZHVryIyUj4zDX3R8PCCgWEVm5/eSO9/gCu8jCaYYd9
 Ds5YauF816ru9Q/g48Gxr4D5MakUR8ZIvTKlkNCEpmuIPV6c9BOcnf9ezJLJ8poDte2x
 14SFXenL/Mpb8etz6nmBIt/euetG+AGLUApB6uJ9u8FfYOQPEFYWI16NV99SFu2a7OT4
 OGuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmMxjG7eRXosm4yEGRotVfQxhh48MwnNCT0eDjNaxaOQdrWA7GnJHz3Q/c2kqWOnxthVpFjDFfU8rR@nongnu.org
X-Gm-Message-State: AOJu0YxOY2hGGl6xjf2KKiJobk35/WEIMNaO7g5PRUyo6VmtSORVanNg
 om7g4tGetzOKzQvgkw6zqILN8WV7EeSpHzohmqBC/9a5J+DwXOrxLCmlIPRuTwhDDmeGEAz1yHF
 uFNqnG4l7g1aTjQs+VRDxm+wZcf1tRXJtzzB4sMGPROutST36GawgoILy
X-Gm-Gg: AY/fxX5EakkXqZaLjO291ioeOGEDa0H32XQt65glYCd5StnLTLL6FG31eT3gGpLUrpd
 hq58+0D+3T4jduB6vv4gDE+x584d2ON8M/zaaGGuef+ipTGq24UHxjUSGubZFHWj5YcVS/ph0si
 esGZb3s8abp2ZeAmb1V3jRvxCIFU77f8GYZIC99NnZh6JkOB1GdK6JOB6xD4kB41U7sF3UiI/W7
 ofJ1Zjuhks1NwlUXEs0OE3aUuT++btNQXBYOggh9NSYbtAU4AsFL3yOFmwfGGeekmAdr6M/Gtmm
 Omi3XHf5hkv8BlGXVYHkpQAkq72zy8KPrv/+WJxpIHY8OUtq8owUCGvfXZQOPp4fNWkjO3RhXz4
 coBoNFI6z9KdnTfoMt5PTZCFgGV4cdB2pO2PUMQ7lJpaXuZsw
X-Received: by 2002:a05:6000:2384:b0:42b:4185:e58a with SMTP id
 ffacd0b85a97d-432c37758c0mr11707968f8f.14.1767970912851; 
 Fri, 09 Jan 2026 07:01:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw2M+xmrVKkpIJqpqGZydw9FJMxRpyQME3qh1WPhxZq5jlX1XrnwEYLHLdfIQzMQPhadGcMQ==
X-Received: by 2002:a05:6000:2384:b0:42b:4185:e58a with SMTP id
 ffacd0b85a97d-432c37758c0mr11707925f8f.14.1767970912346; 
 Fri, 09 Jan 2026 07:01:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm23712915f8f.22.2026.01.09.07.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 07:01:50 -0800 (PST)
Message-ID: <6ac8b1d3-9252-4e63-83b9-c92915a8b78c@redhat.com>
Date: Fri, 9 Jan 2026 16:01:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] util/vfio-helper: Fix endianess in PCI config
 read/write functions
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, fam@euphon.net, alex@shazbot.org, philmd@linaro.org
References: <20260105222029.2423-1-alifm@linux.ibm.com>
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
In-Reply-To: <20260105222029.2423-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/5/26 23:20, Farhan Ali wrote:
> The VFIO pread/pwrite functions use little-endian data format. Currently, the
> qemu_vfio_pci_read_config() and qemu_vfio_pci_write_config() don't correctly
> convert from CPU native endian format to little-endian (and vice versa) when
> using the pread/pwrite functions. Fix this by limiting read/write to 32 bits
> and handling endian conversion in qemu_vfio_pci_read_config() and
> qemu_vfio_pci_write_config().
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   util/vfio-helpers.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)


Applied v2 to vfio-next.

Thanks,

C.


