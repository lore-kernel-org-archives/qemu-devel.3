Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16203CAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 11:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Njg-0001Bo-Dq; Wed, 24 Sep 2025 07:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1Nje-0001BC-0k
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 07:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1NjT-0000ln-SV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 07:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758713539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3wm4aQYa97ehJU5fswKMnk8HHXPm1syDq073s2wb1ds=;
 b=CPzZdsBp9KxuYNYbti2woOhGwvhEjUjfEQmH6d7qN4z2Q0lxmw8mDWbbOGyAZ/A+OKR5JD
 ZxDTQBU1bkRM9/oNJENPRQep8QH6qr4uK0QsK79yyZvHFIwY04JbxQqP1lf5XrHoRLdi8B
 Q9t+KKjsbIAhJF6TE61Nhi8s6xJ7RZI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-TmDjeq2vNKqRy_kFBS7h6w-1; Wed, 24 Sep 2025 07:32:18 -0400
X-MC-Unique: TmDjeq2vNKqRy_kFBS7h6w-1
X-Mimecast-MFC-AGG-ID: TmDjeq2vNKqRy_kFBS7h6w_1758713537
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-401dbafbcfaso1498540f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 04:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758713537; x=1759318337;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3wm4aQYa97ehJU5fswKMnk8HHXPm1syDq073s2wb1ds=;
 b=vaREFJeJjf3RKy1wtcpnryc2Kbb8dYAfE8ymuGfx5/D+rbddX+/DUw5BVQWugXQ0Cg
 GC6mqoi3+jCNH59JL78MVcEk1qNyb6tcsAZRzGnHJAPZjfWt9i1wFsHkmhDexgxB+9rW
 dbz0ahgFQ/Iu3ivwbbwtEpYy0Wate/UmZX91PXDS3OdtKTyXjSt4AaxgcMTWeMP2Kw9o
 LGrXZH/6y4m9LS3H3l+A6zEV+fjIpZvZSgH/pb9En1BHQrvJ73H7KdQc8rNrQlFSeOb2
 YEHDJyQ+857/MI1Tw78R+1RT5e//auKWsiy5URupydXYIiVW9/rjQTzQTmaRtcQE9G/f
 oR3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLhcYsLzYsuXrIfKuBHqGRH48Ywm8mqjrKMWi+yFCqc8ueHrH2sbS15zJHxGtX0FEZS8Wo0Xj+Mxcz@nongnu.org
X-Gm-Message-State: AOJu0YwG5DTKQTGEP8EIkXPdTSZJHxEMguxLG8rNInIkJWPdS/Zv+2bS
 Pjq0aTbvd1zJ8FVDP7F6Qssv1WLnd+MGj+XBs0miKmulF5RIdyMZ7Dy9/Mnvq2e4WCxylthUPu4
 jvb3iYeAQ59LG+OMwY0X4hMw2jZ3lSl/OXru1OnMp7S/PDYGAgaFJGQFD
X-Gm-Gg: ASbGnct5XQNTOqD9YJeE2rioXVg9JtaFgQALmDm3d1l82I4/58kSGdE/v9GMQotMi7c
 GS0r4fyVZv05xPtnurGbDMoajW1er3OsJGbXQ4JKP9/Iuc860mNDKxDa+lT56P0mC3tauVTDp/T
 ICPQ5BJ6rAdmW+XZZwVPOjaLKwzpedSsbqSXv7K478QhCLI7sWqE6Bt24pkF3bpL+22qRhWeGWR
 ccgUjR4SyaCdHjwtU39YlGYGWsHkcZujlsBTL/QfiD7gJpK6/xU3tRdLxsf7Y44jsUwMmz8t0Ct
 3QS1gyyyxIT02ZyR9UPVmeYL5yb/7TxkfjltYwdu8quqf22QVcK4Srw6qwUWHr3hIhzVvLuukRd
 MIxo=
X-Received: by 2002:a05:6000:2802:b0:405:ed47:b285 with SMTP id
 ffacd0b85a97d-405ed47c21bmr2970225f8f.58.1758713536863; 
 Wed, 24 Sep 2025 04:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoNAZLN+nDh03f9cXRCLX0UgIm+FEEbH1KWxZOtQMveos7vpMCeoUcTE8YA9R2fRZI1we1Gw==
X-Received: by 2002:a05:6000:2802:b0:405:ed47:b285 with SMTP id
 ffacd0b85a97d-405ed47c21bmr2970171f8f.58.1758713536387; 
 Wed, 24 Sep 2025 04:32:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee15bfab67sm24078831f8f.43.2025.09.24.04.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 04:32:15 -0700 (PDT)
Message-ID: <ab5369c7-f7f0-4f0a-b314-ff5bbaa9263e@redhat.com>
Date: Wed, 24 Sep 2025 13:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] vfio: Do not unparent in instance_finalize()
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Bin Meng <bmeng.cn@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
References: <20250924-use-v4-0-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp>
 <20250924-use-v4-6-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp>
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
In-Reply-To: <20250924-use-v4-6-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/24/25 06:37, Akihiko Odaki wrote:
> Children are automatically unparented so manually unparenting is
> unnecessary.
> 
> Worse, automatic unparenting happens before the instance_finalize()
> callback of the parent gets called, so object_unparent() calls in
> the callback will refer to objects that are already unparented, which
> is semantically incorrect.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/vfio/pci-quirks.c | 9 +--------
>   hw/vfio/region.c     | 3 ---
>   2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index c97606dbf194..b5da6afbf5b0 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1159,15 +1159,12 @@ void vfio_vga_quirk_exit(VFIOPCIDevice *vdev)
>   
>   void vfio_vga_quirk_finalize(VFIOPCIDevice *vdev)
>   {
> -    int i, j;
> +    int i;
>   
>       for (i = 0; i < ARRAY_SIZE(vdev->vga->region); i++) {
>           while (!QLIST_EMPTY(&vdev->vga->region[i].quirks)) {
>               VFIOQuirk *quirk = QLIST_FIRST(&vdev->vga->region[i].quirks);
>               QLIST_REMOVE(quirk, next);
> -            for (j = 0; j < quirk->nr_mem; j++) {
> -                object_unparent(OBJECT(&quirk->mem[j]));
> -            }
>               g_free(quirk->mem);
>               g_free(quirk->data);
>               g_free(quirk);
> @@ -1207,14 +1204,10 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
>   void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr)
>   {
>       VFIOBAR *bar = &vdev->bars[nr];
> -    int i;
>   
>       while (!QLIST_EMPTY(&bar->quirks)) {
>           VFIOQuirk *quirk = QLIST_FIRST(&bar->quirks);
>           QLIST_REMOVE(quirk, next);
> -        for (i = 0; i < quirk->nr_mem; i++) {
> -            object_unparent(OBJECT(&quirk->mem[i]));
> -        }
>           g_free(quirk->mem);
>           g_free(quirk->data);
>           g_free(quirk);
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index d04c57db630f..b165ab0b9378 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -365,12 +365,9 @@ void vfio_region_finalize(VFIORegion *region)
>       for (i = 0; i < region->nr_mmaps; i++) {
>           if (region->mmaps[i].mmap) {
>               munmap(region->mmaps[i].mmap, region->mmaps[i].size);
> -            object_unparent(OBJECT(&region->mmaps[i].mem));
>           }
>       }
>   
> -    object_unparent(OBJECT(region->mem));
> -
>       g_free(region->mem);
>       g_free(region->mmaps);
>   
> 

What about vfio_subregion_unmap() calling object_unparent() too ?

C.


