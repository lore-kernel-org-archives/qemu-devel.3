Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D90CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScJD-0006xq-AB; Thu, 28 May 2026 11:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wScJB-0006xZ-Hx
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wScJ8-0002rZ-3V
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779980760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=za7VYLJvg8o4dQtlblqfQG+uM5Fo+p83UgejNxGCUcI=;
 b=ijYsseM8eupZt8jC+RrOYDCTGOJb05KOfWJnkrWHeoSq0ieVVIL/PTUqD/P4/gyFhsGqdA
 LqCs4ULNDpJXRBFv+41HrI5wJ/G8zaQoZORM1/bP3G6bTw7cuQfkDFwOFWNidO4ZYomARa
 PSKvLROISSlKK7oKy3P4fD3EjUJNEU8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-pdZqZw3WN2WWnn8azaLx_g-1; Thu, 28 May 2026 11:05:55 -0400
X-MC-Unique: pdZqZw3WN2WWnn8azaLx_g-1
X-Mimecast-MFC-AGG-ID: pdZqZw3WN2WWnn8azaLx_g_1779980755
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4908af8d7f9so9601635e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779980754; x=1780585554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=za7VYLJvg8o4dQtlblqfQG+uM5Fo+p83UgejNxGCUcI=;
 b=RUxcdBcW4coKe+nMvNW44qmnAS0w3IYv9jEvIMOPgJQ4ZRQDrNlDlslMF1Btzwx+W8
 1in0WaoG6nS9MesxiLwJQflWVgU4IoH1w2loQhUAUX8L2R+DoGrh9x6e2Mo2nlqwvCXF
 2kxofi/qAR40NepCetY7kYfnLldN4XVSzi3wVguXAP3/bt/mNKkLOdRRFLyX2NLjzKMd
 89mKtmOJmC1Ic+dPwme4yPnHvLrrm/KQlidIfm0aEnoVj188G9njPInGK55isNtSiqmB
 6cpkyj3VoPJtCrEB8WHLFpc9RqPs24yMqQaNETNcrAn5KH3nba6zDtaRxp6uF8ysKjf1
 pssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779980754; x=1780585554;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=za7VYLJvg8o4dQtlblqfQG+uM5Fo+p83UgejNxGCUcI=;
 b=V2DgXv8GUlpsO5OvZ6hhvSzNNqZEBsQ2vO7TWCS42tIJdBM1bGibubGXWrwwzCgTLT
 e/UcfcM7bVn2fm7tuIiH4hhP5Qpt5aIJVGmKZhIfMukOgvhToINWk42GzvZ7HhkjDOmY
 BwrY4tib5T7RyfBW0600Ba7uOQ/8wer9ZUfoBNw4HdVbPSFQWJSC71y5G0ck4vdOQILZ
 YEHO4M2WcRNIrsCt7+JSvudEcAgyQqoGHL1qBjYuiZqsCmjx5uv3UABnLtHITzM8bo7Y
 2WnkOTsinTRS9ExZZcdWslxgMdX/6MqkAh+jsZiqigWTrZh3DP0ipb0XescEKYAr5XfF
 VHoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hM76m+MIdRlzvbecd1TXssuXs29nvNLUf0AeGAsG4jcGHM3LJO/rLyr0Ji0I9KDTxrxyJtAv8wn3U@nongnu.org
X-Gm-Message-State: AOJu0YyJmAJFC/RM68F1RTfUG2qYQ7sk3kjC48RVlalPWPzvwVd3EvBd
 XYH7E5YNWw248pGUvOzet8L6yDyxEFWp9bDY9epG2xeRSKQg+PtUn7AENuxb13sIJr1nC4tAggN
 i+qCkZEBOS2ECG9SPBtGdSN3GUa7TcANNQOrLCXKA9HRlbIb/Jnl6AMeB
X-Gm-Gg: Acq92OHXj26PlswJcFnuxdHZd+kf4os+XTJJmfxKKaB/pFo0iwtGW4KHBzfXzsVjP3S
 WTbeKDL/2TUkdLPwMhIiBFZB/wJfITqF2OV6DvGLOUfykwaJUKheMCjuMks6XyK/rvH1KO1NvT7
 gsYYovh6eA2A+rmncctzsDauvqUNzQ1sFk7F7pA6pGHqyct8Hw1J4FDSg0v+jRRv2L0lWLNDiX0
 hkuWQ52/+3DoJqT29L+LS4M8CdkqAF/a7q8qEHCHVNwM/m12BAtZAVsSQwjBxO121e9ExSqx1rF
 KEicDyaIUSm4jtRCo2ZNbZQNN6PX5D/D+xmdtkUaJR45jjO+XqGYC4yRUZMy3UVLB8xdV7igvTF
 EV/oxGCFRYAwzOT+ugN5HS8jO2sIrxPzQXWVaiTyNMpMAhZFoxYJ0l+rQz2pMCFHpv59f+Mg=
X-Received: by 2002:a05:600c:4ecc:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-490424b25abmr441847515e9.11.1779980754489; 
 Thu, 28 May 2026 08:05:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-490424b25abmr441845335e9.11.1779980752614; 
 Thu, 28 May 2026 08:05:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909284a895sm42177965e9.8.2026.05.28.08.05.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 08:05:52 -0700 (PDT)
Message-ID: <db82450e-a3fd-41ba-963b-4e0730ea34cb@redhat.com>
Date: Thu, 28 May 2026 17:05:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] vfio: propagate IRQ notifier registration failure
To: Cornelia Huck <cohuck@redhat.com>, zhaoguohan@kylinos.cn,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>
References: <20260510084353.58263-1-zhaoguohan@kylinos.cn>
 <87o6hzmvm2.fsf@redhat.com>
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
In-Reply-To: <87o6hzmvm2.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/28/26 16:55, Cornelia Huck wrote:
> On Sun, May 10 2026, zhaoguohan@kylinos.cn wrote:
> 
>> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>
>> vfio_ap_register_irq_notifier() and vfio_ccw_register_irq_notifier() clean
>> up the fd handler and EventNotifier when vfio_device_irq_set_signaling()
>> fails, but still return true to their callers.
>>
>> Return false after cleanup so callers can handle the failed registration
>> path instead of treating it as a successful notifier setup.
>>
>> Please ignore the previous version.
>>
>> GuoHan Zhao (2):
>>    vfio/ap: Return false when IRQ notifier setup fails
>>    vfio/ccw: Return false when IRQ notifier setup fails
>>
>>   hw/vfio/ap.c  | 1 +
>>   hw/vfio/ccw.c | 1 +
>>   2 files changed, 2 insertions(+)
>>
> 
> ...I guess this should go through the s390 tree (and not the vfio tree?)
> If yes, I'll pick it up.
> 

I included these patches in my VFIO PR  last week. They are merged.

   https://lore.kernel.org/qemu-devel/20260520162115.1613601-1-clg@redhat.com/

Hope that's fine ? Sorry if not :/

C.


