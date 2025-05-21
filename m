Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4A9C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlEW-00071j-CI; Wed, 21 May 2025 11:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uHlET-000716-Tv
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:19:49 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uHlER-0002y0-LY
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:19:49 -0400
Received: by mail-oo1-xc43.google.com with SMTP id
 006d021491bc7-604ad6c4d3dso2531769eaf.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747840785; x=1748445585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=T9ZTJGQNWlW1L3l8YcB0lOiknL//PP6LhWNCKbvy3IQ=;
 b=kqZlQlrtfQSHjVizSp9ajYEjLRa2pwcf9INM3vePRucL/QKlnbRzSSmpUEEUMRs4eK
 A5gEsX+uejn3gdLpr5Rxz/QZ+lCvGoA6v2KjQXWzKhgwRhpBapfZ4/FY2LSD02NarOTb
 jl1ucobB5wvFRepbWuv1okgKyYtJzSfFTNsjbQUHH6P+pqQvcsyBYYuGhebSeDHK5yjz
 QikoRXFyweiqcHFgiHfsmJ0dzwXK3kOPWzLgfTQxaZGkd1scAYc7z95a0Lhi7WtAaPYw
 faQNM+R2VANGF/3FvO0oIfdCKElHdd+hwTZb93P4NmW1WWcZNvFDyqArYt/NMPhPh4wT
 VZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747840785; x=1748445585;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9ZTJGQNWlW1L3l8YcB0lOiknL//PP6LhWNCKbvy3IQ=;
 b=H8wdA5bHSx+t9SFNUghQ1QkSbb9edTv4fQZtmiZTwdE/EmKs/6JYQywnzmF40cG+wb
 ZcxA24+BiQyUgrQUyAfm//OIj9MWiKm67qSxz1ycAm39e4HxWO6ItNt1zWWySi9r5KYp
 gjsIuMb724jFs3+twerU/dK7hXUzGLVEG6Xeu9Kje6VeY2hOXATY9FFHaGyxBrUXeQwB
 oqjRpj0pGeaFeN7zJklbyb5V6lpozvpl74qDaXg3DaGtrn/yDAAUeDyd1/5InVTdXQuq
 Ex6MNzx137Skp3zAfWxMg9ltq5FJiM9PQypveYseV1eHW/xoyOcaNBUTXKJIvNU8wd9v
 hq3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuPkJuyZNiZ2hcsbeitaeqq5t5cYmtZbCN3+c9oGkhp/TwO5MVSX5CE2nm8MGU1CMkeXek10NImtLJ@nongnu.org
X-Gm-Message-State: AOJu0YxdpgDnh9cZuU5UIe3p0UGxc0eUcaTW7Opi+Ikh/IqJLTb7xzwT
 Wx7HTTbrEX7Ut6NPPMT6hLm08x6WnbJe0YdAAxJgRa8sct2MTlWC3pRks8pUWoZh4g==
X-Gm-Gg: ASbGncsN2RPLIfvpuACEJ2CEjPJ3anyNHD20L/T4CkhAjMYizSqGGWm37xjmJlix3H0
 /7SDxsVoxD/OsyckRXi+y/n0a5TU66N2Blm7HRfmdwkbTMrw2cZbfYS/GFVnlqWdkgwzvOjWlmA
 JEW4OyLwv1JHelTwWpXqDdiXwzucG8VU6+SA2pN0itr3Jpcy/PavUo2JsfS5jOstCfsh6mpRfXQ
 wIownstPhZ6njmwWB8yfHUxrP9VjwI/sazrde+hh5y/DAt5f/uNHymDJVfO32KE5VjBUJj3rB9o
 Hr+7bJGkDwxymLe9JWcHbXHgLP9WIJ64WgHE4gNWcMv71tjfj2VhCEPTWg==
X-Google-Smtp-Source: AGHT+IFIgqNZRc1zjBP3AF9k5wnigfmVSJqs8RjYkx1zz5qEqzR6uLEKPbet+ECkNE6vfzLLloLWpw==
X-Received: by 2002:a17:90b:3a88:b0:2ff:52b8:2767 with SMTP id
 98e67ed59e1d1-30e7d548c7fmr27109278a91.19.1747840774004; 
 Wed, 21 May 2025 08:19:34 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.250])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36385b68sm3782396a91.11.2025.05.21.08.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 08:19:33 -0700 (PDT)
Message-ID: <30044d14-17ec-46e3-b9c3-63d27a5bde27@gmail.com>
Date: Wed, 21 May 2025 23:19:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: Respect x-igd-opregion=off in IGD quirk
 handling
To: "edmund.raile" <edmund.raile@proton.me>
Cc: "clg@redhat.com" <clg@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <tgKYxqCs9bUrxIZV2h4pSnR4gEjle4oq8tKs65J8lM70PMsBpuxOPKbv0cUJLfLQdks2C-PUIBJx3kqMQ78ufP2EMEBwwjzT6FxfsZlBfcs=@protonmail.com>
 <9fc2ce95-0846-48ab-aecb-d79c9c1a01b2@gmail.com>
 <p2Y0fDoEs3EoN6ugt0QeR2rm6jSPUADZwOuLL94q6eomD6Kp7lZgyf1p95E8khWZ1bwEIROkstnt67oVYM5uRj2ECi-_B9SmHu5q93Hr9uE=@proton.me>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
Autocrypt: addr=tomitamoeko@gmail.com; keydata=
 xsFNBGeBS+MBEACn/yFPrdM6on+MxXrQMYXDCDzOrIPa60zJg0DvQFW/LDTDuOvduTOIVgKS
 Zxwtj2PGjIfJLir94olButVmhqrmwBaSGDlmONQwbM99OJt0jur70XQJkvBZyyd82ZuTMOO+
 aadlfwFmpL9tnMBHxPG2msIAd1DtB4UVKk1vU0VyCfUU5urCbKjpd8qKDK0WzqZSq+bfbUnm
 0zJtKu3IRgJjHYIOicm7nuD981kx/2mqYYc4rhTMoRuXV7j38MOc2EBwajzn0AIkQPKDNoh/
 39YqWnUvkrAtJBTOiPTTFzKnTi/U8RUUlv2xkVHsDbQn5Hk3hw+dgZ+KEnZoN9mpM742Bdxl
 NZV+ux1/xTBjhc4JMsn+fnp/XMQEu7heGXJBpTGpCzFfF3Lww/wv0IZo6LqoL/oNKlvqtCZv
 R0Vke7YxI/LWPJg26vA+lpjDfZsnuOKR6e7VKH7d2Ys4SM7wdWH7Skmvzzi32OaWXgSUT7ts
 N5n0s7hhsDQNNQDAegENpFdBH188zZaNvxORAicmQMjp+LIWhxQVFmEFehOPAmnq6xD/fbWV
 wPg9iJ0TEvrX6jsT5f4YYH2yFBsOgXCoykUwN6P52lesF2p5naeUYhN7Qe+9m25HZ+XUzoWE
 wgqcBoJVdOksFcqL6zsP6Y5WcvefuHQwtfF164+zLcOW4BCQjQARAQABzSRUb21pdGEgTW9l
 a28gPHRvbWl0YW1vZWtvQGdtYWlsLmNvbT7CwY4EEwEKADgWIQS8KzUD0amz9vuEE3wF51cy
 H0ouBgUCZ4FL4wIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRAF51cyH0ouBo2JD/9p
 QkjDLiWAcpqhW/agYsxPTQRea8CxaZGSIESa+T9EmfY59Wn30mUkZMEL0rJD1LRJnC7r2Poq
 Z7WnvhiUv25lpXBTugD3mBUV9egKgTKUMen9fpdj9cBiP1OiHchJke0F5cM6NeJxgWSifBVV
 cKVnsCyeCMQq2i340g8IsJJP9tSPeo8tF4ijkO4KCn2aXdY3NruGuKH7JrNca/QjhMlav1ES
 2j18TngTxIqPD95O5U/BeDxWA1FonDOANode39naK1qwYBu5v+T8U8FE/0peYU+HEe1OmIfH
 DVN6BKgRrfz6Or446PWS0tfY2H3WsUD+Z9oOQllbIa6h/FXULPtr7yY3UwV5pbZkHmfeaZ+m
 pmROun9WIPXUsva+E6HrTBvUBmcytZDc1v5wYb48xB9p4OgBJtC2i1BJP5jS3Pnl2SoLQAgR
 7nlbBqQdugAKlfAB8jKOWFbZ+eZssMXYIKCDOvPc5PwFrfDUj2MVzgzaxgtKYMWPATTj6L3j
 nfT9elW6RKSSF+dhycQTt9dd368BmpnHnM0MQvzt/rhH3uzYcHceOkBUjaqJzlj4EBJhY6P/
 QSXwnwkeuXdZLZ27Rluigy9O9pIdJBCEWPQ3hvaZnP+BKkObqD+1wOXNFdcMvFVsfRqEpcbI
 3GSXMsP3O0IQ803Lx3c8T8/tUN3mHTx/dM7BTQRngUvjARAAqO+N3GXDWSOTAbylaiDDQ6jM
 Vl1XucU29l9ODuXpIaovqlfxvZbl4snGB2rdFP+rmO0LuwpxuORWUuI3lh3whKjQv19YaNbF
 U0DblgBvPYQsXtv0gYoQr54RcLaQ52Q1Yz07Cy+M3tA0FK1wLKPHFcfsY1zfF9leJZlzw4hO
 SSsKk4RvidXK4NxgkWw3VYfFm+eDK5dikosm+AT8L11/PPVAlqqz5m7CqAWyP2DV92sMe9Jb
 i+O4suIQsF5vvWWQaUCzA+CshkbMiF0xWVeJaftM1X01z+r2GA+dwcrrac1qrsqN1nw8aDa2
 XJ2IbIGk1lazW7yqm/KEXLx0bIO3opyack81+iVUU2Yb2+td9n6zj1YScl2Aa1OzKJsnEnfJ
 Pw4GE98wv8hYMEfKCHNIY1ajVDXiCBw3sqtTR2lpXeOVwHDhF4FyLIiy/DrTOW58mCZG+Nz9
 /fBM9p1WSJhUWcYzFaBq43imaCrvBg14edaFWBK+xkK+trdjyZBgMWtmStWebS+Ifevyu9oH
 jugTlm81F/eWZAAcTM5fshhUe2JSvOerEM5jHUla5YNHzMuv7j7/xSNJSpeNOe3Q4H2oaejl
 idHucoLMe8OhIDrNqTX3s+DbKonvexavLLBp/9PKrmPWtxTV7qcvUoLNK3I+ctTXZez10/O7
 z6fnfk3mLb0AEQEAAcLBdgQYAQoAIBYhBLwrNQPRqbP2+4QTfAXnVzIfSi4GBQJngUvjAhsM
 AAoJEAXnVzIfSi4GoiEP+wUV4uOcaMOTdINCOWAUX3wNQf7wvdLUBdWHM/7wm8wynBf9ZvPR
 YOTEsI2sHy2WK44eexnws4xLeR41X9jFbKYtA1zDGQJumpillnnMKVaNYWt/G9hj6QmKsFDw
 hT/A/QWwMH9fjH8nBxgZjZCqIraRUrhNChqm2Lm3nkoRpnSZgMfcllMtXt4ld+Eh30Mir8hD
 80dmaHJJB64xOrJzIKQVvTnWD3qlFXtL+OEgqT4HPIFOEfbCka8WbMmyIiDDI+3xx68NKTpV
 733RG/I5+dhr+DDBEIyd+i/IilykqA/zHOeMTujwlIUMeor+QsoACG3LydkR/oKpOqexl4N6
 XcjwZ6dEoeJOLBzq6vikF9qVYUmY0hfaCh77ly4VHtKL6xGCb8PYawgiyTHO5on0h4RzDJKP
 P8jzYYK2wSWe7EJgk5EW9xs1irmawzven9NZDEaJrBecWrN4c+V7MpxpIOrCg2mRp1WnKh8a
 YtmMnmYQqDpGW/+M14/jLkNPxW62q0DEoeLLaRI/eiljk7Ld0rpCSK1r4zLYF4Ad4D2/TU5c
 eR8oCkBhmfKaLFohZAxwwjHLm/iLXKH3Y3E8AKCEO9bDtjM2/O8cu6mRWCrU97NWiqlxtvqa
 1knqGaLNT5NXjwaR3PHbrp/Wg0UxLznD0LzQeT5XHrROJ1+OH0ntUwQd
In-Reply-To: <p2Y0fDoEs3EoN6ugt0QeR2rm6jSPUADZwOuLL94q6eomD6Kp7lZgyf1p95E8khWZ1bwEIROkstnt67oVYM5uRj2ECi-_B9SmHu5q93Hr9uE=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=tomitamoeko@gmail.com; helo=mail-oo1-xc43.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 5/21/25 04:46, edmund.raile wrote:
> Hi Moeko,
>> On 5/19/25 16:03, edmund.raile wrote:
>>> Restore SR-IOV Intel iGPU VF passthrough capability:
>>> Check x-igd-opregion=off parameter in vfio_pci_igd_config_quirk and
>>> vfio_pci_kvmgt_config_quirk to ensure x-igd-opregion=off is
>>> respected despite subsequent attempt of automatic
>>> IGD opregion detection.
>>>
>>> Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
>>> Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
>>> ---
>>> This patch fixes a regression in QEMU’s VFIO IGD quirk handling that
>>> established automatic IGD opregion detection which ignores
>>> x-igd-opregion=off necessary for SR-IOV VF passthrough of
>>> Intel iGPUs using i915-sriov-dkms.
>>>
>>> Please review and provide feedback.
>>> Let me know if additional testing or changes are needed.
>>>
>>> Kind regards,
>>> Edmund Raile.
>>
>> Hi, Edmund
>>
>> I did a quick test with x-igd-opregion=off with c0273e77f2d7 included on
>> SRIOV PF, setting x-igd-opregion=off works as expected on my linux
>> guest. Per my understanding, SRIOV PF should not have OpRegion address
>> in its config space 0xfc, kernel returns -ENODEV when accessing, and
>> QEMU continues after vfio_pci_igd_opregion_detect() fails by returing
>> true. Could you please share more details about this issue?
> 
> This is with the i915-sriov-dkms module creating a virtual function
> from my iGPU:
> 00:02.0 VGA compatible controller: Intel Corporation AlderLake-S GT1 (rev 0c)
> 00:02.1 VGA compatible controller: Intel Corporation AlderLake-S GT1 (rev 0c)
> Which I pass through to the VM, allowing both the host and the guest
> to use the same iGPU.
> 
>>
>> [    0.655035] i915 0000:00:02.0: [drm:intel_opregion_setup [i915]] graphic opregion physical addr: 0x0
>> [    0.655490] i915 0000:00:02.0: [drm:intel_opregion_setup [i915]] ACPI OpRegion not supported!
>> [    0.656088] i915 0000:00:02.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x0000
>> [    0.656462] i915 0000:00:02.0: [drm] Failed to find VBIOS tables (VBT)
> 
> Where are you getting these logs from?
> These aren't kernel messages, are they?

Hi, Edmund

This is get printed by guest kernel, with `drm.debug=0x2` in cmdline.
 
>> If you are mentioning the log "Device does not supports IGD OpRegion
>> feature", it is a false error and can be ignored I think. Maybe we can
>> improve this, making it more clear?
> 
> The exact error I am getting without my patch is this:
> qemu-system-x86_64: -device vfio-pci,host=0000:00:02.1,romfile=/path/to/intelgopdriver_desktop.bin,x-vga=on,x-igd-opregion=off: Device does not supports IGD OpRegion feature: No such device
> after which QEMU immediately exits.
> Maybe the issue is that the parrent device (the iGPU) DOES support
> OpRegion but the virtual function child does not.
> The intent is to give the option of disabling it back to the user.

I did some further debugging, and found it was caused by a mistake in
error handling. In vfio_pci_igd_opregion_detect(), `errp` is set when
OpRegion is not found. However, in pci_qdev_realize(), the caller of
vfio_realize(), it checks if the errp is set for failure, rather than
the return value.

hw/pci/pci.c:2268
>    if (pc->realize) {
>        pc->realize(pci_dev, &local_err);
>        if (local_err) {
>            error_propagate(errp, local_err);
>            do_pci_unregister_device(pci_dev);
>            return;
>        }
>    }

I will submit a patch later to fix error handling.


>>>  hw/vfio/igd.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>>> index e7952d15a0..e54a2a2f00 100644
>>> --- a/hw/vfio/igd.c
>>> +++ b/hw/vfio/igd.c
>>> @@ -523,6 +523,11 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>>          return true;
>>>      }
>>>
>>> +    /* Respect x-igd-opregion=off by skipping OpRegion handling */
>>> +    if (!vdev->igd_opregion) {
>>> +        return true;
>>> +    }
>>> +
>>
>> Here (vdev->igd_opregion == NULL) is always true, the pointer is zero-
>> initialized and only get assigned in vfio_pci_igd_opregion_init().
>> Enabling OpRegion or not is by VFIO_FEATURE_ENABLE_IGD_OPREGION bit.
>>
> 
> I thought `vdev->igd_opregion` would already contain the
> `x-igd-opregion=` option state of the `-device vfio-pci`
> parameter but you're right, it's not assigned here yet,
> so is this the correct way to access the state of the
> parameter option:
> (vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION)
> Which would then make it
> +    if (!(vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION)) {
> +        return true;
> +    }

Yes that's right.

Thanks,
Moeko

>>>      /* IGD device always comes with OpRegion */
>>>      if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
>>>          return true;
>>> @@ -689,6 +694,11 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>>          return true;
>>>      }
>>>
>>> +    /* Respect x-igd-opregion=off by skipping OpRegion handling */
>>> +    if (!vdev->igd_opregion) {
>>> +        return true;
>>> +    }
>>> +
>>
>> As I mentioned in a comment below, GVT-g vGPU always emulate OpRegion,
>> so let QEMU fail immediately if OpRegion is not avaliable here.
> 
> Agreed, you are right, it shouldn't be necessary here,
> I'll remove it in v3.
> 
>>
>> Thanks,
>> Moeko
> 
> Thank you for taking the time to review (and contribute in the
> first place).
> 
> Kind regards,
> Edmund.
> 

