Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993CB106ACC0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 16:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0iZf-0006rm-IM; Thu, 12 Mar 2026 12:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0iZb-0006rF-MG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0iZZ-0007cp-Fn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773331660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rblwEFBO2fCo2o0CWbHZ2CiLNMIZX6UHuD8cMP7mNyc=;
 b=XYZkMS2rcrV6oTBqG/mWq/eU2tqBiK2VwBvtsltcXSwmvhAA6Zv6M+MMYwzxfP/9woIemK
 Azx5tYFiH1zYcW+dEi3mL3SCi0yQflm4KHC2O6k5mGrCWkKuti3Lgn64FWdsZshpLS4RN4
 9kT67ICwvnfiHIzU+7u6LNyk17+D0K4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-Wt5p8fwGOgC1S5zsPrsRGg-1; Thu, 12 Mar 2026 12:07:38 -0400
X-MC-Unique: Wt5p8fwGOgC1S5zsPrsRGg-1
X-Mimecast-MFC-AGG-ID: Wt5p8fwGOgC1S5zsPrsRGg_1773331658
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853f33b7dbso8855825e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773331657; x=1773936457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rblwEFBO2fCo2o0CWbHZ2CiLNMIZX6UHuD8cMP7mNyc=;
 b=eB/2Uo51yOj7CEizRHeHelQERj+0l9LDxIP02h6GXMq6Ph0Euwsa0o2SNKaDS3vdi8
 z0fdAD5g1NAz+o5q2l6gMRnymmPTs+gFYlqC4lg4FuI8fyPjJMv5fNPevd+mSXwE1Ih5
 ISaDgLqY6E/wwPF97rifQltUJAnFlXYb7or8m1ZDtgCXFQfd1RQLAS0iQGjzFnmeKTSC
 KnJaAT24ox7sLznUQLOx9+qiWAcgqQ05Ei54gen1R48dNx0hoiWHGaYSzoMjNH6rBAfO
 m9KAwqvngOgRb+qveoh2FyL9yaSv4YR0sPEAREqdi3eM+8EpMIM8+LHMXN3LXqO1LdfB
 x2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773331657; x=1773936457;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rblwEFBO2fCo2o0CWbHZ2CiLNMIZX6UHuD8cMP7mNyc=;
 b=cAO/RktzfA1jjdnbovzH2pdW6IuN5/ONNgXiWPRosF4+cQbUa514qFdf+RkddTYz2Q
 pF+4evIuh5N5m0istrpl7013BfaYuP3kq3aB4sgjhiBs6zWBML1zH1Z0WYjRo6Ef5Kl+
 PXwalhKQqBWhb0Z0HmM2miIXCPyKaD36AX4YpQ/gYkE+4pickoCLWuAWh1MgLcxRLqzc
 yknS7LyqaIqw3hbT0uAw2gmFcYFMfeKpVJkTg8wfdPL8y+ONsbUSxMVVd6Z/RnaENYCd
 HiZ4We+Ot/0v30vUSNl3ttvCXj6T0HfMUdtwStaN8DYvoIzuw58OC3VF+XqKWIajEMMi
 G/AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGWQj7LxxTr4bO/+B4ifPuU/E8ommfknf3ktQjgb3wXjDTIo3it+yV4vnOUcqvAbaDFpo/JzzEFuAf@nongnu.org
X-Gm-Message-State: AOJu0YzPQn2JdOY1+yKCqjTBh3FNTc9lgWwEtrJmDVOPxtQHozomoOhH
 +METcR5/ia2+R/Dlkz98sOO1xy2b+tsdSkfnQVlB66icK9u0RkiQKMSjbvJQh7q/7kJQXjakiHV
 R4Ol42FzjCBINxcau98gxkusLct9itRqyJywq9Rh1eaI1n0gEE2sUAs6pXRZ6O//7
X-Gm-Gg: ATEYQzxvPx3BlyYDIZYcW3kynjeNIajGM4iNDuAZFdPzZ28vBGbgrrGOaY0UlxfejgO
 RSciHV1tyB4Nc8M1/zlyyeHjsthyV3r8g2IBLJQOdtnKbVP9Qnf4ZTMA/9ieeCjNViJHoCS0lZg
 CPSJW77bD5a8tfeH0JE1zcdrpeN9jHq15BV318bvbv57FrWLSW47YjTfkx77OqhGHe2wQpdwn9e
 tCC/JdpvfDVRhPnf/hAqPCtzYUT+NI/2FfVYqifPXup0GrqKMUyr4eOzm8geABPWcN/kc98hEzx
 FLVIysk1FugU09h7REFQ5o7qNk2H+spMyf7Gbav4uAVIcnUdKby6CnheyH1hCoaDlWp6MIzcz5C
 hn1TSKartzsHRp+jnxexwWbid5sZfwMobEdh0C22o9JP7fU31/hm/ry3/dL4S
X-Received: by 2002:a05:600c:a44:b0:485:40c6:f526 with SMTP id
 5b1f17b1804b1-4854b109d5dmr103450355e9.26.1773331657289; 
 Thu, 12 Mar 2026 09:07:37 -0700 (PDT)
X-Received: by 2002:a05:600c:a44:b0:485:40c6:f526 with SMTP id
 5b1f17b1804b1-4854b109d5dmr103449605e9.26.1773331656787; 
 Thu, 12 Mar 2026 09:07:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aa73dasm684744525e9.2.2026.03.12.09.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 09:07:36 -0700 (PDT)
Message-ID: <b0bcd095-c914-4a05-aa21-c7d1d09af72f@redhat.com>
Date: Thu, 12 Mar 2026 17:07:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Don't disable PCIe atomic routing for multifunction
 devices
To: Kurt Garloff <kurt@garloff.de>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260312-enable-multifunc-atomicroute-v1-1-b7d66ca54319@garloff.de>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260312-enable-multifunc-atomicroute-v1-1-b7d66ca54319@garloff.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello Kurt,

On 3/12/26 16:48, Kurt Garloff wrote:
> As included in the comment: The PCIe atomics routing does not hurt,
> even if some subfunctions of a PCIe device don't require it.
> Graphics cards often have an audio device next to the GPU, so this
> actually causes them not to have PCIe atomics support. The amdgpu
> driver however needs atomics for fully supporting ROCm.
> So stop excluding multifunction devices.
> 
> Tested with Radeon 7900 XTX.
> 
> Signed-off-by: Kurt Garloff <kurt@garloff.de>
> ---
> The amdgpu driver requires them to fully work with ROCm.
> 
> The good news is that qemu already has code that detects the capability
> of the PCI device and enables the routing of PCI atomics in the
> pcie-bridge. This unfortunately did not work on my system, because I
> have a RX7900XTX which is a multi-function PCI device with the GPU
> and the audio function. I pass through both to the VM.
> 
> I could not find any reason to disable PCIe atomics routing even
> if some subfunction does not require it -- it does not hurt.
> So I took out the check.

Alex explained why it is not that simple here :

   https://lore.kernel.org/qemu-devel/8b3e30e6-3c3e-49ab-b9db-8296aaf819d1@app.fastmail.com/

Thanks,

C.


> 
> With it, the amdgpu driver works nicely in the VM.
> 
> Sidenote: I had used patches to manually override the autodetection,
> but prefer the automatic detection which is much simpler in both
> code and usability.
> ---
>   hw/vfio/pci.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 94c174a773..077ff3a6a8 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2112,17 +2112,19 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>       uint8_t *pos;
>   
>       /*
> -     * PCIe Atomic Ops completer support is only added automatically for single
> -     * function devices downstream of a root port supporting DEVCAP2.  Support
> -     * is added during realize and, if added, removed during device exit.  The
> -     * single function requirement avoids conflicting requirements should a
> -     * slot be composed of multiple devices with differing capabilities.
> +     * PCIe Atomic Ops completer support is added automatically for devices
> +     * downstream of a root port supporting DEVCAP2.  Support is added during
> +     * realize and, if added, removed during device exit.
> +     * Note that we previously only did this for multifunction devices to
> +     * avoid conflicts; this restriction was unnecessary as routing atomics
> +     * will not harm and won't be generated by devices not requiring it anyhow.
> +     * The restictions hurt many discrete graphics cards which have an audio
> +     * device next to the GPU.
>        */
>       if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
>           pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
>           pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
> -        pdev->devfn ||
> -        pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        pdev->devfn) {
>           return;
>       }
>   
> 
> ---
> base-commit: 769a37d8bd0c81c39128fc292352f01bad0769f4
> change-id: 20260312-enable-multifunc-atomicroute-ca11e3a399d2
> 
> Best regards,


