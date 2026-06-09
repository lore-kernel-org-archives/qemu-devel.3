Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211D2CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWv39-0008EN-4N; Tue, 09 Jun 2026 07:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWv37-0008Dz-76
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWv34-0003VN-Vs
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781006113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=on6xrvwakW9orHJOGOUPYJSMWrQ4v/q90J8KJ9EM9ak=;
 b=EZDNrggffYYDId4jD3+cgYJVwARxjoweVZow65jeWkIBx8VhI9lvfCSL+oJ5w2Jkt+9j5R
 rvseNLlKeDjWuXMhxS4a8ON390+TKt/zo4ucQiXDTqQ9HSRYJF+3tqmLNotPXMNpq0chfd
 t5D87+ybeAbIYA4YVYyPOSi4r+GwZcM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-aMg7lf2nMfCXW5IdPpm4yA-1; Tue, 09 Jun 2026 07:55:11 -0400
X-MC-Unique: aMg7lf2nMfCXW5IdPpm4yA-1
X-Mimecast-MFC-AGG-ID: aMg7lf2nMfCXW5IdPpm4yA_1781006111
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4601c9b630fso2208045f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 04:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781006110; x=1781610910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=on6xrvwakW9orHJOGOUPYJSMWrQ4v/q90J8KJ9EM9ak=;
 b=rwUaym1UodcfJ/cTaNOQmzPp/evhDuUsdgyHNoOD7a85doP0aMXhDTcoIhtE0VYSI2
 igp5GPmp1NWD/zSPvfGakAzHuvFRIGIxqG9KZ1weIyl/JlCx2VhKw4swQSiMQPutQL7p
 bIbI+CcNYHH+hH171ZbNbwwo1xAcZrQPCIb+XAuQIMCJ2V+8ng6QAhgtTrXxgJig09fA
 aoZSkwi7+0YdMm2ou+lQadpiw+gzQ4hsPwe+35RBGWJLEPeHF0tEvDkVOQOSYEn3iiK8
 LPvEiY/8jLa5YpjfxhwoTkyC2Kl8ZMsyv18FX6XYjRTcQTLMvo6RqPIV3A6SfGPDZRj2
 /4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781006110; x=1781610910;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=on6xrvwakW9orHJOGOUPYJSMWrQ4v/q90J8KJ9EM9ak=;
 b=SFZpvte7VoFaMsKdledX366u6sg5lWlTdSyiC7lXQJm0WCepNKDPBIx1lm4XJ9n0Yx
 HTviN4YD9AJWvXKU/cjJOsItD2KPLhZoQ8iBrZ8nLeTeP1KQwY5QrvkH3eIfuSH67SKw
 bwaz1MSafc8CgQ9Cy2nY64T4aQ1b8mPpkm4kOXYKM4jwixpiVV1EjLI/9dVwvUVOVGGy
 o39ZrQ2JIxadfws5l13WLAff82rhjYb+NANNDgjMhtf+u2+pm+dhaUO/gdqBqUp/JDUJ
 8c5UjLMPrWF1VsZQFi4WFUxOVCJTrbqD8RvkAN1EaubDbd5blLNbhaZUZojLLJHy2SyL
 nnhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Z9v8CtzATqb7lwDH530vYRA2Y1cgTmXhdvKNZkKapMDASWdf/hugZsTOkVteGKcb0npp0KaMfYsq0@nongnu.org
X-Gm-Message-State: AOJu0YzwLHWGETeN3Y97e1tYIjN507DmUqHc77OpsjsGgVX3PgUX5rLx
 Z9K36z3GpNhLPs4aFuw3SrmMtaQdJZO7nrWldcPO9MQ+EHyObQyzTSMeC21uUCG3sUfmq1QCCRL
 oM/XPCNyd4FmqvAIK6/ZCZgWnYHtPB8A5oQsHrTJaZCJ7ib1ONWMY+uth
X-Gm-Gg: Acq92OGcTZ8QFcnzy3xDaVWmFWS600NYLQY+1ZLZtASAp7XHs7KexHvJa6piIAbvwBZ
 622/uNxLJVT3fGEIWH4ZaVK1g1D0QE9F43St/4i/B3toY9h/HJOqU+nMzZeurBL4N6M3wUPSwdc
 eEUJR2cY+YNBhCnr95XSo8cJLosUv+r6h5PTcM0xqoR3vUACJ/Or6jAWJ5JyWlnR/K3Rj3N5S8J
 Zd80Pmmk0/ddcccJVPbgjlVBbA7M6tPWESioAa5Amyer6lV5NY1/E54WCND7qX8BZf4pgsrmp/o
 vnOi3zemRJ/RGOWSdRMGPvNjs6om0QM8ifwPlc1Q3tKZRbmcI0MkTWeMpNI7LPgHHjRU1WC8j+W
 Qq7EDFPYFBNwd5WNRNM7aKUhw9ReSYTLLBDcR9QUYzHgL5L8h9MlD13fdainTY7FTwgIU0Zw=
X-Received: by 2002:a05:6000:2081:b0:455:fbb:28bb with SMTP id
 ffacd0b85a97d-4603075f442mr32040346f8f.35.1781006110403; 
 Tue, 09 Jun 2026 04:55:10 -0700 (PDT)
X-Received: by 2002:a05:6000:2081:b0:455:fbb:28bb with SMTP id
 ffacd0b85a97d-4603075f442mr32040303f8f.35.1781006109870; 
 Tue, 09 Jun 2026 04:55:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3444fesm61694842f8f.20.2026.06.09.04.55.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 04:55:09 -0700 (PDT)
Message-ID: <35a62661-1f68-4b4f-8a9f-14f8803bd1ac@redhat.com>
Date: Tue, 9 Jun 2026 13:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at
 load time
To: Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, K S Maan <kirandeepmaan45@gmail.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
 <20260608134559.23971-8-tomitamoeko@gmail.com>
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
In-Reply-To: <20260608134559.23971-8-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 6/8/26 15:45, Tomita Moeko wrote:
> IGD does not come with a ROM BAR [1], the ROM BAR read by default from
> kernel is actually the host VBIOS shadow RAM region that contains host
> modifications on boot. With AI-assisted reverse engineering on VBIOS
> binaries, it is observed that VBIOS saves BDSM register value on first
> access and uses saved value if present.
> 
> When the image is executed in guest, since there is already a saved HPA
> in VBIOS, it keeps using that value instead of the GPA programmed by
> SeaBIOS in BDSM register in PCI config space, causing VBIOS to program
> GTT entries with wrong address, resulting in garbled output in BIOS
> POST and the error below detected by i915 driver.
> 
> i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])
> 
> The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
> mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
> guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
> ("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
> values in MMIO BAR0 and IO BAR4.
> 
> Considering it's unsafe to expose HPA to guest, a ROM quirk clearing
> the saved value in VBIOS image is introduced. It searches the BDSM
> accessor routine by matching a 19-byte signature anchored on the unique
> `mov $0x105e,%ax` instruction, then locate the offset of saved BDSM and
> clears it. This makes the routine fall through to the PCI config read
> on the first call inside the guest.
> 
> The quirk is invoked in vfio_pci_load_rom(), and is gated on Gen 6-9
> IGD devices with VGA access enabled and legacy (non-UEFI) PCIR code
> type in the ROM header. A new trace event vfio_pci_igd_vbios_patched
> is also introduced.
> 
> [1] 3.5.15, 4th Generation Intel Core Processor Family Datasheet Vol. 2
>      https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>   hw/vfio/igd-stubs.c  |   5 ++
>   hw/vfio/igd.c        | 110 +++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci-quirks.c |   5 ++
>   hw/vfio/pci.c        |   2 +
>   hw/vfio/pci.h        |   3 ++
>   hw/vfio/trace-events |   1 +
>   6 files changed, 126 insertions(+)
> 
> diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
> index f7687d9091..879a8aff56 100644
> --- a/hw/vfio/igd-stubs.c
> +++ b/hw/vfio/igd-stubs.c
> @@ -18,3 +18,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>   {
>       return true;
>   }
> +
> +void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
> +{
> +    return;
> +}
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 834539affb..4b49038753 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -734,3 +734,113 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>   
>       return vfio_pci_igd_config_quirk(vdev, errp);
>   }
> +
> +/*
> + * IGD ROM BAR read from kernel is actually the host VBIOS shadow RAM region,
> + * which contains host modifications. In Gen 6-9 VBIOS, the routine below is
> + * used to get BDSM value when programming the initial GTT.
> + *   xx xx xx xx           v: .long ?                  # saved value
> + *   66 53                    push  %ebx
> + *   66 2e 83 3e xx xx 00     cmpl  $0x0,%cs:v         # is saved value empty?
> + *   74 07                    je    1f                 # if zero, go compute
> + *   66 2e a1 xx xx           mov   %cs:v,%eax         # else return saved value
> + *   eb 0f                    jmp   2f
> + *   b8 5e 10              1: mov   $0x105e,%ax        # dev 00:02.0, offset 5E
> + *   e8 xx xx                 call  pci_read_cfg_word
> + *   66 c1 e0 10              shl   $0x10,%eax         # left shift 16 bits
> + *   66 2e a3 xx xx           mov   %eax,%cs:v         # save the result
> + *   66 5b                 2：pop   %ebx
> + *   c3                       ret
> + * When running the VBIOS in guest, saved value still reflects the host stolen
> + * memory base address, which is not correct in guest. So we need to patch the
> + * VBIOS to clear the saved value.
> + *
> + * The unique 19-byte starts at `cmpl $0,%cs:v` and ends at `mov $0x105e,%ax`
> + * anchors the match to the routine. Both `cs:` displacements must reference
> + * the same offset.
> + */
> +static int igd_vbios_find_saved_bdsm(const uint8_t *rom, size_t rom_size,
> +                                     uint16_t *bdsm_offset)
> +{
> +    static const uint8_t start[] = { 0x66, 0x2e, 0x83, 0x3e };
> +    static const uint8_t middle[] = { 0x00, 0x74, 0x07, 0x66, 0x2e, 0xa1 };
> +    static const uint8_t end[] = { 0xeb, 0x0f, 0xb8, 0x5e, 0x10 };
> +    uint16_t val;
> +    size_t i;
> +    bool found = false;
> +
> +    if (rom_size < 19) {
> +        return -ENOENT;
> +    }
> +
> +    for (i = 0; i + 19 <= rom_size; i++) {
> +        if (memcmp(rom + i, start, sizeof(start)) != 0 ||
> +            memcmp(rom + i + 6, middle, sizeof(middle)) != 0 ||
> +            memcmp(rom + i + 14, end, sizeof(end)) != 0) {
> +            continue;
> +        }
> +
> +        /* same saved value address? */
> +        if (rom[i + 4] != rom[i + 12] || rom[i + 5] != rom[i + 13]) {
> +            continue;
> +        }
> +
> +        if (found) {
> +            return -EEXIST;
> +        }
> +
> +        val = rom[i + 4] | ((uint16_t)rom[i + 5] << 8);
> +        if (val < rom_size) {
> +            *bdsm_offset = val;
> +            found = true;
> +        }
> +    }
> +
> +    if (!found) {
> +        return -ENOENT;
> +    }
> +
> +    return 0;
> +}
> +
> +void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
> +{
> +    int ret, gen;
> +    uint16_t pcir_offset, bdsm_offset = 0;
> +    uint8_t checksum;
> +
> +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> +        !vfio_is_vga(vdev) || !vdev->vga) {
> +        return;
> +    }
> +
> +    /* Only Gen 6~9 devices have legacy VBIOS as Option ROM */
> +    gen = igd_gen(vdev);
> +    if (gen < 6 || gen > 9) {
> +        return;
> +    }
> +
> +    if (pci_get_word(vdev->rom) != 0xaa55) {
> +        return;
> +    }
> +
> +    /* Must be a legacy ROM */
> +    pcir_offset = pci_get_word(vdev->rom + 0x18);
> +    if (pcir_offset + 0x14 >= vdev->rom_size ||
> +        memcmp(vdev->rom + pcir_offset, "PCIR", 4) ||
> +        pci_get_byte(vdev->rom + pcir_offset + 0x14) != 0x00) {
> +        return;
> +    }
> +
> +    ret = igd_vbios_find_saved_bdsm(vdev->rom, vdev->rom_size, &bdsm_offset);
> +    if (ret < 0) {
> +        return;
> +    }
> +
> +    memset(vdev->rom + bdsm_offset, 0, sizeof(uint32_t));

May be add :

   if (bdsm_offset + sizeof(uint32_t) > vdev->rom_size) {
       return;
   }

C.


> +
> +    checksum = pci_rom_calculate_checksum(vdev->rom, vdev->rom_size);
> +    ((uint8_t *)vdev->rom)[6] = (uint8_t)-checksum;
> +
> +    trace_vfio_pci_igd_vbios_patched(vdev->vbasedev.name);> +}
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index bccf31751f..45db968681 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1592,3 +1592,8 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
>   
>       return true;
>   }
> +
> +void vfio_rom_quirk_setup(VFIOPCIDevice *vdev)
> +{
> +    vfio_probe_igd_legacy_rom_quirk(vdev);
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6cbd65126e..66d6315e6f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1088,6 +1088,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       if (pdev->rom_need_patch_id) {
>           pci_rom_patch_ids(pdev, vdev->rom, vdev->rom_size);
>       }
> +
> +    vfio_rom_quirk_setup(vdev);
>   }
>   
>   /* "Raw" read of underlying config space. */
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index c3a1f53d35..d8d6c09632 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -251,10 +251,13 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
>   void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
>   void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
>   bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_rom_quirk_setup(VFIOPCIDevice *vdev);
>   void vfio_quirk_reset(VFIOPCIDevice *vdev);
>   VFIOQuirk *vfio_quirk_alloc(int nr_mem);
> +
>   void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
>   bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev);
>   
>   extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
>   
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 2049159015..7dc334ccb3 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -90,6 +90,7 @@ vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_
>   vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
>   vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
>   vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
> +vfio_pci_igd_vbios_patched(const char *name) "%s"
>   
>   # listener.c
>   vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64


