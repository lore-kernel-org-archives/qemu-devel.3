Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7F1CEDD9B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLMr6-0000Kk-Sf; Tue, 18 Nov 2025 09:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vLMqv-0000JU-T6
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:38:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vLMqt-0000Ak-UY
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763476716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iPKJSJmOqNld8p4r74kZDi2fhdVbSmJMbizEasBK4Ts=;
 b=AKcFg0I1D5Vnuk+57I8wgbh7oO0YB6ydPL7C+BzOE5bf2CZD8Sv+hZCDMZ/iwnOMFHuhV0
 T2AsPDrEtLg4aTOH90UQ3p7M4tD83tnFZJ5DhXofnCxNGuHJsS8feO5cNtJF4S4KVzwFhm
 wWzQbwTMhzZ5jCs4m0g20m/edrx88Ok=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-kvbAeffsPtqzJu3J0GawlA-1; Tue, 18 Nov 2025 09:38:34 -0500
X-MC-Unique: kvbAeffsPtqzJu3J0GawlA-1
X-Mimecast-MFC-AGG-ID: kvbAeffsPtqzJu3J0GawlA_1763476713
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477a60a23adso12578105e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 06:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763476713; x=1764081513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=iPKJSJmOqNld8p4r74kZDi2fhdVbSmJMbizEasBK4Ts=;
 b=qgREYNgCaN/SuH+J/BOmTtxqZCa+kkzoYq2wGkZLnnhVLIhJfH+NStauHilxUfUZ1w
 0KTuA4brBFEXRdfyNLCCGSAAtXZMLORW7DjzMXLV/3IoK01I2fsIhIn0fiEg+oq057oo
 oYiw+aaQlIEdri3QeTddBXSDzyStMVXRZTRQ8ENOfZEmUyzUtdTgfxUWY5oRaZsDziok
 cS95GP82Aoz/jBbnqyXJhCxOdh6o8DqflWysw7apQ/P03B1ACK6eddCm1RL8HC1480Eo
 x7yeeg6qZHaS7hvhaKOGYWMcOZdqbF7KMuqhDyNnsbA7n+Ou5uK3LxSAwSPolVqa2isW
 UBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763476713; x=1764081513;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPKJSJmOqNld8p4r74kZDi2fhdVbSmJMbizEasBK4Ts=;
 b=P+qrSd0aK8ciklsCnTGMLH+WVft4+ImsoQbfXXVeTXRCT8n38Gtg8PCE8j0ZtyBigO
 czgLMS2ecm8KgTE0FMMiXUyeknbyNDBVfJDJ6tVZ8oHVqUF+w7CFKQLIB1CD1iYhZQ4H
 hcNXIuec9VkxIdWEdaSmq0MuC0qKMN0wHB2N6AnwiMWQk1JgjaStDCe5iA7nB5aWbpdi
 AguYOO+ldWKWh6lS5NIxAaCzqjbQuoChYEEyelutvrBN+2ac5t22VJBw8aBQAesOmG5r
 VM2N03Q1fHZdAtaGZttgX1Yr9z0tn6NezRl+lQWv39OYcFHWoQdoLgt4P0c6/I3Gr/UW
 efOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQT9srFuvdFtlMi2W2aR50y/gABU+EmKBryUWw38FQUgtGiEgefoGSqGaRPzynqpb+la9Hiss5F4rB@nongnu.org
X-Gm-Message-State: AOJu0YwR+cfE+NuQ0A/eUtWNjQUSsDkmKo9J4ZtJ1+d1k7FKdbOd/5h1
 Tdo1j5lIlODUMgjLwfJLECcpBSVXxKYJU3hJQq+P3Gkvp2Sqlnao1OMY3xpK64KijIBYc0uPjsw
 OVUIigNMBlAxSLDYgqDeG23s/BgipJ00i6NBN24xP58ujX5cMuwBM+vQv
X-Gm-Gg: ASbGncsohZzwJDUnyObSxNUn2sGd/H5jSwu3DS+la5sZ2TZIG06QWYpzUDG0gbsO4i/
 3Yl675jL4TCROhXyN+NQ+oAAj3PtZnyN5UAdVYiq7jvkmO0XatX143ERYQ5xCfboYCCukrLWJtx
 oNmbCaAPQxdn3kVsU2xeb1NZrdtcMa9OKAipnB0/4Q5y1L/mAecjdCWbAm2GMJOuK0UJ0d4VBEy
 r048sbtMtiR1exKBedro07irk28q9n6XebJvQBfrogBDjziD47JiqlhUuuxgNhXaajF7KyQhq3N
 wGd+tjoM4d6IURKjQi40ogvOZcJzMINtDAxY7BRDDB3rhBSCZwYgD0VIpzPJrQI08Z/r76iHKhN
 YFTjK7T2n790FwQo/TobY/XnNXISSfDnm5p1SqA==
X-Received: by 2002:a05:600c:a47:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-4778fea0c6emr181482565e9.30.1763476713466; 
 Tue, 18 Nov 2025 06:38:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFabVpx/p2jxfgEkNun1rd8Xfw1P1+TrGJY0Fdlj7UiT+A896L7PH4J7Nwy04SWxfA9/H7b1g==
X-Received: by 2002:a05:600c:a47:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-4778fea0c6emr181482335e9.30.1763476713056; 
 Tue, 18 Nov 2025 06:38:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9dfb639sm17813975e9.13.2025.11.18.06.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 06:38:32 -0800 (PST)
Message-ID: <a10938f5-2ab1-4d5d-9bd9-a463596b4cc3@redhat.com>
Date: Tue, 18 Nov 2025 15:38:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] vfio-user: refactor out header handling
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-4-john.levon@nutanix.com>
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
In-Reply-To: <20251117155656.2060336-4-john.levon@nutanix.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/17/25 16:56, John Levon wrote:
> Simplify vfio_user_recv_one() by moving the header handling out to a
> helper function.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/proxy.c | 101 +++++++++++++++++++++++++------------------
>   1 file changed, 60 insertions(+), 41 deletions(-)
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



