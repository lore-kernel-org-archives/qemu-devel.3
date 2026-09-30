Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E203DCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpq1-000254-2v; Wed, 30 Sep 2026 04:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xBppt-00024h-Uw
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xBpps-0001HY-5p
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790757521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LijUbx/S+R0qcxUjGWDcIuZ65eqb5pxri/zlgZHUDsw=;
 b=a53khi6+hnYtqH8Fjq1x+1GEtu+c4z1YPk5+eMBBsdPMe+lgqLgHUh7hNdSDnUme2+ULzb
 jw1jj09x6uCpFdSWydh38by5BDIn3aDqcAzEu17Y+gs286w+Rtcc78nv9EFjET+gEUqVTQ
 pThbYjPPXvxavWaCajc7ee4uR39xJfM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-WJMZeoLkOD2kyOyKnfJdgQ-1; Wed, 30 Sep 2026 04:38:39 -0400
X-MC-Unique: WJMZeoLkOD2kyOyKnfJdgQ-1
X-Mimecast-MFC-AGG-ID: WJMZeoLkOD2kyOyKnfJdgQ_1790757518
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48589603501so3497762f8f.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790757518; x=1791362318; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LijUbx/S+R0qcxUjGWDcIuZ65eqb5pxri/zlgZHUDsw=;
 b=XJA85ia6JVQAKXYt7ia2FtoW3NA9/BZm+T9SSGeXdQnhELttPWFc93stmxJwsJVgAu
 qlILlPlM0ya7iP1M32WfvOieb/30iF3FkJcYoalVVJbhnXNQdf8fWp+kZsYF8TfMMZyr
 ahSb7/xTm4oPGTRy7iga6YkLAC4YKO6ykOfN1PqXISbSfbfV45r2q8RM2l3gLgGyn//F
 1/2RZXbWzUR256ZvUhDX7WiNdoz0y7bKgGgMS+a+85u3ci8g40ipt2Os9uKD32c4iwZh
 ZyIsU/KLUBOyRTJnDNOr5yyrHT9CjeHo4BO5GWyYsv1OrdBF/1bZs2k3+cMq9/hJ/9mQ
 1snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790757518; x=1791362318;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LijUbx/S+R0qcxUjGWDcIuZ65eqb5pxri/zlgZHUDsw=;
 b=q/Fi0N8F5PnxsWXPEZQxzn6oKR0S7GW9LWDXWkLQwfsbzUJj+uPIaUfadLoW51X+bK
 T2ZaHwV5NfnE01t7IcDd2JSgdG8jF7hDyLEJIy5lYHPigEityXPemhK0GxxY/2eEeyE4
 ymgKHXDCD9YTEh6sSm6TNbmVyo0ce4bS4XlfseSDQ8yV7OPcYPO/xXGjIom1OX65dTd7
 Ep37H13RN0/Rez/ZysHkV9Jx+cO/nW2tuNFHBIZL2tL3W7UexdHWwm+kxE3V1Lb8fTwb
 L3LYHnp0AA1l0tI25gUu0atKEtSFdj3S6SZvMSZZCBlROqVw5nRZngy3Q7P+JCGPPmci
 S/Zw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfgUXZKvffR/L2RKKSJAD4F0nDmHLEuN+wbdCO8zLA+tbZcHZsarzQMNRkxUMyNMLRCJojX2PvfuOy@nongnu.org
X-Gm-Message-State: AFuF++mPBlOfT28MAA7lF3jryyP/QYo+DlUObyLCe29snKVBZguZPBUX
 xQdzmM8nNzeyOxOJNW3VesCgSikXemG5BeDoscTeio5GNAmN0gF9qj1OFwBuwt9KW1pxfAoYLzW
 nUBjVbuzf94i4RnRMqMIEgkf8gCatSs1tRZxDQJm67rt1Fc4vasGqK+M5
X-Gm-Gg: AYBFou0M5gAVITFC2OMoUL5aH2ENOwAibSi4DInQGLGWVh+FLJiQE633tNWZUTo75Kh
 B77zIu7lROyK8lQsz/t5wi6ewESzzLhCHm4+3Xm7vHqqTaRPQdldrn4URb7fMdQPbUYyKQLHpDY
 TBH3IKcNt82fKJfkGK78msNVaeb0qVmeAhkVBKs7U3//uDR2xaC9ffk1DWmRh5BVlepS+IuJtSc
 g+0vsNQn8yURPZ7ucAkM1crvK7uRi85oZfvb68hMpi8lyKuJ8VtqFo4Lr47dsQJSCKBowP7KAf6
 bg/5nWDgK5HK4rxfLjbmwrnspmuoIZfi6aqSGi40okrGfsJCMy452dazGeP/54VEpG3eKk+PrUb
 8UZb1glZIUkk8yj5Xj0RkM+x3wFgvoVrLpg9OS/S6
X-Received: by 2002:a05:600d:82d0:b0:49e:7c4b:1753 with SMTP id
 5b1f17b1804b1-4a01ade8ebdmr12559325e9.12.1790757518178; 
 Wed, 30 Sep 2026 01:38:38 -0700 (PDT)
X-Received: by 2002:a05:600d:82d0:b0:49e:7c4b:1753 with SMTP id
 5b1f17b1804b1-4a01ade8ebdmr12558835e9.12.1790757517754; 
 Wed, 30 Sep 2026 01:38:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b02a018c0sm1697328f8f.30.2026.09.30.01.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 01:38:36 -0700 (PDT)
Message-ID: <fe975f14-e3ee-4500-b109-080fa0386161@redhat.com>
Date: Wed, 30 Sep 2026 10:38:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vfio/igd: Update igd-assign.txt for Intel MTL and
 newer platforms
To: Yuan Wang <yuan1.wang@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, tomitamoeko@gmail.com, bosheng.xue@intel.com
References: <20260928084226.3537126-1-yuan1.wang@intel.com>
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
In-Reply-To: <20260928084226.3537126-1-yuan1.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 9/28/26 10:42, Yuan Wang wrote:
> Update the igd-assign.txt documentation to reflect the addition of
> the 0006 patch in the ECI repository. This patch is required to
> enable support for Meteor Lake (MTL) and subsequent Intel platforms.
> 
> Starting from MTL, the hardware-accessible BDSM (Base of Data Stolen
> Memory) register in the PCI configuration space has been removed.
> Instead, IGD devices now access stolen memory via MMIO BAR2 (LMEMBAR).
> Consequently, guest firmware no longer needs to program the legacy
> BDSM register.
> 
> Reviewed-by: Bosheng Xue <bosheng.xue@intel.com>

I don't remember seeing this review on the list.

> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
> ---
> Note:
> 
> We added a patch to the ECI website to skip the DSM zero-size check as
> the sixth patch. Accordingly, we updated igd-assign.txt to reflect this
> change.
> 
> Link:
> https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html
> ---
>   docs/igd-assign.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
> index e54040335b..b9abfdbac3 100644
> --- a/docs/igd-assign.txt
> +++ b/docs/igd-assign.txt
> @@ -263,6 +263,6 @@ Footnotes
>   [2] # echo "vfio-pci" > /sys/bus/pci/devices/0000:00:02.0/driver_override
>   [3] https://web.archive.org/web/20240827012422/https://bugzilla.tianocore.org/show_bug.cgi?id=935
>       Tianocore bugzilla was down since Jan 2025 :(
> -[4] https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html, Patch 0001-0004
> +[4] https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html, Patch 0001-0004, 0006
>   [5] https://github.com/tomitamoeko/VfioIgdPkg
>   [6] https://winraid.level1techs.com/t/tool-guide-news-uefi-bios-updater-ubu/30357


Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


