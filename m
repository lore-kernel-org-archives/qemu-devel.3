Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0967E7BDA9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 12:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrxdR-0005eo-V9; Mon, 16 Feb 2026 07:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vrxd4-0005aM-3i
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 07:23:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vrxd0-0007jD-Dr
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 07:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771244579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3FnSuZWZkc9CV8ugjfaOS/A7VhMeU06KMdwOPH2kv7w=;
 b=Xsv6m3CcUNIwWFioXW/WM0K/wq04yeiMAAkiATNLrhhziD446+btokqWUkbgaGefOGpbcr
 YDSJyRy0n2xhZheQVjiK1mYGuOX+Fa2s2akBRiioQTbbIhRPmFwaqomB/LCf8aoGTcro0P
 DC2CMkgm00sg6/pBVsKaMjdgh/PMznA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-8sFjSGemNh6U756UsZee9Q-1; Mon, 16 Feb 2026 07:22:57 -0500
X-MC-Unique: 8sFjSGemNh6U756UsZee9Q-1
X-Mimecast-MFC-AGG-ID: 8sFjSGemNh6U756UsZee9Q_1771244577
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so16451045e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 04:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771244577; x=1771849377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3FnSuZWZkc9CV8ugjfaOS/A7VhMeU06KMdwOPH2kv7w=;
 b=poRqAo6oB5XbUO+uKp4Y3Ss88lC3OOpt/jTypUXO9Scz6P75VDE5tuN4aPwz3KfCzB
 xHd21/Jq7FMkQo8AC2MVGFm2W0Sawz5iRyYDLN2dpNFSMJJ6VnwPuiK0UQwXUvuA7ofE
 IPwJtWAwz1TU9cGIb+ot7nUJzIfysmKh6AKq+gwu8H+NEwIVTeldQuTOakVXGpRGcDII
 nIl1be+FodP+5V66JA98HSpkg7plIQZzVVkEiSjqYWDi5TkdGUCzahnihV4P4by3/Vwr
 cLlooKFLAwWRKKOcDNTAoANl6UzwsMo3lhdxNJ7y8jaHNOVepmUKvctDDnApFMvDyigH
 7J+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771244577; x=1771849377;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FnSuZWZkc9CV8ugjfaOS/A7VhMeU06KMdwOPH2kv7w=;
 b=DVXntbkDRpiRepOASksWsJJC7CJ73vLaUs4dCdpulZEKtpLwZaW81bgoWcwtfnRiDv
 U0l9rX/+Kbt72tOeUju45LFZ+NHFTpLMipikX60o3jzAjNw2niT9241G7RcRZC4T6S7T
 mH2rgnvwVraGzodEMgipPns8VbM7o86O/pprLcCkfZjO+pgKyafxHKNipMwDm/gHp5a2
 m+jFckKwiR2W5Zcnn1wKOege2Lr9S4uxEzApf47igidrVu3dizO054PM4eQwWttgQ1vq
 oRJIkWKmI8u/b/NA1/sXKg1PhATq7SeEiksiBtdRAua40lj8J8T8dXwwtoW0r7bFqK7j
 YhHg==
X-Gm-Message-State: AOJu0Yw/su93LT1w7WUlAIdtziYS1lI44kq5fdz+nya47jx5lDaEp5B0
 /SVNVpV7N7raBzgvxe0Ysn+58wrVKlD/OrnPom5VbS5y6rfNiy3oFZ5B0wxWfpz+Bn0fJmqw/1n
 xQXKaD6rlSILZK2WApGTY4a8uSaTW1hohRsc+iVz3qrVJYw9VbmBCISpy
X-Gm-Gg: AZuq6aKj5DNJ6zWyjeY7cnOzyWAjdV6fyff3NTG83MvMhZlh07udyIouuPDqf2APOTt
 EvQCO/UVTNByuGffrgK3Guj9LBp8iLvp3tJK9046EtW+Lnppehr464kKZPFflL4xZ7HRSfw79sI
 QYcul6bW70pnrx3MjQaJmv0sPYOzCpfMF/7AlWZJ6i0UKGueCq2vhjnw0NwKwNtg+ganCm+kUTM
 fRb0F01kFoXeIra0UoK08FUVUyJzdQzkvbGYcJ94WZYnOCKNTYCOG+ShPCHeMnTjGrQHX7ojIBC
 Q9QvXUObB/BroitlaIb/EB4Ux7CNuS3aqdE3AH0uQMEaE51OGjPsbMHR1Q4vnBNmWRwFslc3rK9
 hNiDblvf4hhXcnxiigC6AjNezweQnBOXYkMyMbRx6FL2Dc/hMqS7jspxceDyV
X-Received: by 2002:a05:600c:6814:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-48379bf4788mr122691655e9.34.1771244576653; 
 Mon, 16 Feb 2026 04:22:56 -0800 (PST)
X-Received: by 2002:a05:600c:6814:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-48379bf4788mr122691225e9.34.1771244576209; 
 Mon, 16 Feb 2026 04:22:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac9d77sm24860962f8f.33.2026.02.16.04.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 04:22:55 -0800 (PST)
Message-ID: <57489f93-0439-402d-b9d5-a9d2a0a30a25@redhat.com>
Date: Mon, 16 Feb 2026 13:22:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <24ea8ccb-d904-49e4-bd27-5378aac4a56a@redhat.com> <aYIqDAdld4a41VDy@x1.local>
 <87cadb65-af45-4bb3-8090-8301a1e67103@nvidia.com>
 <a0dbd63d-30b9-4c83-851d-abaf50d4c9fc@nvidia.com>
 <aa18ad15-580e-483d-8e29-20c7e6ebb6fc@redhat.com>
 <1260f024-b22a-439b-a70a-ef5429162b3e@nvidia.com>
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
In-Reply-To: <1260f024-b22a-439b-a70a-ef5429162b3e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter, Avihai,

>> As for enabling the VFIO migration events by default, I guess we
>> all agree it could be done. We simply need a stakeholder to change
>> the default behavior.
> 
> Ack.


There could be value for the sysmgmt layers to receive a VFIO
migration event reporting progress. For example, an event could
be sent from vfio_save_iterate() including relevant size metrics
to indicate progress (or not).

Any opinions ?

Thanks,

C.


