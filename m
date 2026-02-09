Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAA9EF070F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLJy-0007Nm-4P; Mon, 09 Feb 2026 02:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vpLJw-0007NT-4o
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:04:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vpLJq-0005jL-0o
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770620500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NbgW+9xqD7q7L3Gi19+WXACOaJJ71iwHRjugq+6Pyio=;
 b=J0rdWJnLYnCPe5HZPHmcfK/3uylHJRZ/VAHQh2nyeP7QOCapRDXHm2i6lPLJsDsaPyceUC
 HjcBl/3+j0tG4/hiW05Z6RU0NG6jSuIr5VXmLVgTsFN2hOrE4Y4Huy0NYcJ3WeMM7RXTkz
 qyTnACy9LWJkYBCGHHpZPaTq/6aQ6i4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-pwVlArxDM76oa62nOvt-JA-1; Mon, 09 Feb 2026 02:01:36 -0500
X-MC-Unique: pwVlArxDM76oa62nOvt-JA-1
X-Mimecast-MFC-AGG-ID: pwVlArxDM76oa62nOvt-JA_1770620496
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4802bb29400so39353115e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 23:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770620495; x=1771225295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NbgW+9xqD7q7L3Gi19+WXACOaJJ71iwHRjugq+6Pyio=;
 b=Pwh3mopMn8CYsz27Hd541ToQlBtdQUNcGaLU4qekRdQ85hO6VF2+lQN3FVViVYNVFU
 zjyQ2wfR5/u0b8RgsvQ4BAJa+QVVVCzvuATyaeaS/kMw5rIDZWT1G1QJPnLitsfNeYlP
 Fl3kulxZJ/lQ4vfOLON7Jm53sthhEnLvX2RJYftCQSeQAjQT4AS9H26cGlqpx7NuFc6D
 cwdr2gkx2NH43b7iNA0oCFJWBiqHWbznz9O58C+JNYJ5fdKcjNaU+OCu7/Axzsu4JTl6
 5A1bge/C/KhaiuxN/hk85m8f9M2MpxpVsCjGs6zc5hLoS0p+BUGtuWte3ELqqoohQDik
 Tl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770620495; x=1771225295;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbgW+9xqD7q7L3Gi19+WXACOaJJ71iwHRjugq+6Pyio=;
 b=U+P1N48kMp1FpmMriSxC7f+4whwRw4jyWga9EKabN6aG8zx4w2Iwm/9b17PTGpo+Yp
 W6wyggR0Px4vwh/iuZ9ILto7VLnx2er3lMoXE/y//2G1dN+hBGG/HQU+ndHWnbKD6ULb
 NMH+6fKd6pLR6NEiubfuhFUaUwUkm4mB8DC98df1xnwrvBj79VK2ZqraZUIt61PgWAOL
 hAkXL1GWvpqV7/e+cMchRlazNyJ6If3GjRFd4DWphTgJfmKzA6goYQU4mgvaVtgrEToq
 CashMHVphB2ff1g7RKLgOyjDvmUgrmwHj8FxpDFMpN6bQxATG6jTyzCcvRlCobIKXnpV
 HMXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM7s0Lv8fGqjY7GOE9sq7O/qbW4TXTYM02LYtbbEBWqaGky9UnEesddokKmACFTw5xVpTbqCoaXBo+@nongnu.org
X-Gm-Message-State: AOJu0YwG6Xhgl4liwKWuQ8OLFTYPtom4euWnJngt+I4VzvoePpGwfa/0
 qufgXgwLfRq95vOKIV6uP5bNFkbAZl7X4vKebutfGS6UFCbA4me32PEWrxUerCiNpB3ry1EIkX8
 flgHBt6kJoieKB3M1KhcSJVzCLPb6phK7qvLfhaTE0yVEguxkyFfYg/f3
X-Gm-Gg: AZuq6aI/+tiBAqGn423Gs0He1DdPnq+XcQxCWJfkmSbgSOfhx1wqKiiqrljJZVYrbfs
 GPQAqZbGk9AvwuzOS8uwsCMuiaXN6fskx8V9Um2rgMNes96OgRYKPiHC8Lcro+SmlJZd4a3cae5
 Ioolh/oeSUartI9kgMMlzI92cjF2Bk5vMJoX58DdkixEeQhZQutPdWhuaDHFIS0URJPkMY4fFi0
 SSJFHWJABT2oDjVHLhkNmCRuqo0bw4A93K0iWubQbVcYCQWsu5RwbTfWeTlL9L0Qccu7MteKAGb
 4Et7Ur8eHJxwQapsqEEAD2hdtYv1FUwTZGXEkpS0hzYicmDEG4juzoJqsnQnTtXtfqxBeLfYP65
 wIEHY5DYb98qdqyiSngmJcwAptXx6ndZCnEfiz2z3r5nXfhqsxwtcyjxz7tNq
X-Received: by 2002:a05:600c:1f16:b0:482:eec4:758 with SMTP id
 5b1f17b1804b1-4832021fe37mr152182405e9.26.1770620495284; 
 Sun, 08 Feb 2026 23:01:35 -0800 (PST)
X-Received: by 2002:a05:600c:1f16:b0:482:eec4:758 with SMTP id
 5b1f17b1804b1-4832021fe37mr152181825e9.26.1770620494746; 
 Sun, 08 Feb 2026 23:01:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296b25casm25194066f8f.4.2026.02.08.23.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 23:01:34 -0800 (PST)
Message-ID: <6a44c66f-1e4b-4d22-aba3-235bbd7337a7@redhat.com>
Date: Mon, 9 Feb 2026 08:01:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/33] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-23-anisinha@redhat.com>
 <CAK3XEhOet2pFNT2PLOHuBZFNAbXtYq3Hghr0XNvd4FKyPPX7bw@mail.gmail.com>
 <76421356-de3a-4941-bd4d-7c362fbb228f@redhat.com>
 <CAK3XEhN6gbALmc4xewbh0FmsaZzwOzd1gYnP96WtfYfyD0g_pA@mail.gmail.com>
 <9A3531C1-1A3A-4D03-9B8C-E2E40B349C75@redhat.com>
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
In-Reply-To: <9A3531C1-1A3A-4D03-9B8C-E2E40B349C75@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/9/26 06:44, Ani Sinha wrote:
> 
> 
>> On 9 Feb 2026, at 9:37 AM, Ani Sinha <anisinha@redhat.com> wrote:
>>
>> On Mon, Feb 9, 2026 at 3:38 AM Cédric Le Goater <clg@redhat.com> wrote:
>>>
>>> On 2/8/26 15:39, Ani Sinha wrote:
>>>> On Tue, Jan 27, 2026 at 10:47 AM Ani Sinha <anisinha@redhat.com> wrote:
>>>>>
>>>>> Normally the vfio pseudo device file descriptor lives for the life of the VM.
>>>>> However, when the kvm VM file descriptor changes, a new file descriptor
>>>>> for the pseudo device needs to be generated against the new kvm VM descriptor.
>>>>> Other existing vfio descriptors needs to be reattached to the new pseudo device
>>>>> descriptor. This change performs the above steps.
>>>>
>>>> I have not been able to test this change. Can someone suggest a way to
>>>> add a functional test and/or test this manually?
>>>
>>> Automated VFIO testing [*] is tough because it depends on a "real"
>>> physical PCI device.
>>>
>>> I have tested you series using a sev-snp guest with an assigned device
>>> (SATA controller) and verified that the guest could reboot. The SATA
>>> controller has no disks connected, so further testing is required.
>>>
>>> However, a 'system_reset' command issued from the QEMU monitor leaves
>>> the guest hanging. May be this is expected ?
>>
>> I do not think so. On non-coco, I just tried it and it reboots fine
>> with x-change-vmfd-on-reset turned on.
> 
> Sorry I had some issues with my testing. Neither non-coco reset not coco reset was using vmfd change path when the QMP reset command was used.
> In non-coco, it was the normal reset which obviously works.
> 
> I fixed it. See https://gitlab.com/anisinha/qemu/-/commit/c5514dbb2b52d474397220cfa3a0b8faa26cda0c
> 
> Please use this patch and test. I have tasted this on SNP and seems to work. I will make it part of next spin-up.

Looks to me.

Thanks,

C.



