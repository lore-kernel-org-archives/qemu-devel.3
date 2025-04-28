Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF739C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9QFf-0004EP-3X; Mon, 28 Apr 2025 11:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9QFc-0004Da-LI
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:18:32 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9QFS-0007jh-55
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:18:32 -0400
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-736c277331eso5621302b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745853499; x=1746458299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bFvNNHIEyfNP22mgUhVRNeVt9KkQMyI7pBvpKjE+BxQ=;
 b=IVaElFyJ3C5NdNjIjLd+7LsLfycQuNFIlW7kAb6DZTBp382PvwDm2m3/vzPx/0szxb
 LXEGy09SzwzJ1gdD/E0hSh0Zawe8T9thuNSUx6AOl+558NipctbmOgsl3qgoB1rzrQCX
 5d4pmJvaYjNWfi30iLFmPr5lNE1ThzToT2BguOakIwUqmSYVpTXlD2qH/1eD1W32cvm9
 pBTzHe6Z68acR3rZlvw+oAAG+sICOzuU58WLnE3GH9wbPyQHBpJN5YSxHVks2XYv6y97
 +kcGV8gpOj3iuZQFt4gYgX98Va2Tn7fRaE1BiVm5vsjechXW7mxstn32hXxUhTStHywn
 QNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745853499; x=1746458299;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFvNNHIEyfNP22mgUhVRNeVt9KkQMyI7pBvpKjE+BxQ=;
 b=rpjQeR73WhOMy9MpJvsO6cx6/+uF/c+J2OOS80LNCTL0CVyU6L4tuA/Cd9ft5pFSq3
 AXcJfGxCuUvgDEoDWZrHkHKMQGyL42qnZEZU8EhEO2CMiSNMK8iGyo8cV7h4AojpkNji
 28WlmF88EDpElgdpCBYsAyIZummJH7iAjeVmgT2EH2tMM3qqCdMID/SYAFN3TcjneAsw
 esEVPv2KzGPsKs1hbKOMQ0U1UJuafJEZ74pM3JbqrkHn4OsW1L5U10wWq1pmL1C3qVSO
 q+k2QfYnh1PKb+zpJ0/DcwEewHYzvxwoE1IpXwsfE1m3JNhEpIkgAndyzKsG5QgPam65
 mo7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdc61HQMNIWxVs/D0oA0OQXUwjT3VdzeN7UNbgBETCLbZaZcjgnhFM25jYYZBoSKRXmBeHnPhJ3SC8@nongnu.org
X-Gm-Message-State: AOJu0YxPdv7Vyog0T8DK0XLbTUf1C2nFRiZ5UPH0qEgiNsfdZS7phJqx
 5307rUw+wvRxuhLdGpILnXuGTrRdV0gJAUIT99njMTIQhppD7QMpij2IypAfGg==
X-Gm-Gg: ASbGncvKbvcHh10YL6eobe9eDATLUEJeDig3LqUuPxqVsDCqKs3oMhKapzWMwgj/R6h
 vsaG3RCSc+1Gs5uNDMuS+jSERJ9/pngJfP0SsBX0s8QhLq/Abe2mcCSYeuIODjpbTNjWKbi2cyU
 AxK91RPUiB8pUY4u8xtJlkivt4oRifwrrqT1iaxXrlq7aSWNoW+rDmakrJPpImy9CL6oBB0cfgH
 HAsaX8KJ/qQbjVTC2oKT2lmC45kJ/26hNan9fqLSSoscFs7huvk2Tp10v9Uv2PtTuOrsBPoCDzI
 WF62eFewnTsmsSAOAUeKj0dAvvD0jNh/nNHiZrYTuBHHlA==
X-Google-Smtp-Source: AGHT+IG8t+43cLvpKI4o2oO4rSo8v/msssmySBPNYM3vS17Hio7SKxkiMQGYWRSOXuuuFhVurfQKsg==
X-Received: by 2002:a05:6a00:1947:b0:736:b400:b58f with SMTP id
 d2e1a72fcca58-73e2660902fmr27536484b3a.0.1745853498871; 
 Mon, 28 Apr 2025 08:18:18 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a655sm8340108b3a.101.2025.04.28.08.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 08:18:18 -0700 (PDT)
Message-ID: <3f848c72-c354-4d92-9231-e3ec10ac75c8@gmail.com>
Date: Mon, 28 Apr 2025 23:18:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] vfio/igd: Allow hotplugging with OpRegion enabled
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
 <20250421163112.21316-8-tomitamoeko@gmail.com>
 <20250424165713.683ff583.alex.williamson@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
Autocrypt: addr=tomitamoeko@gmail.com; keydata=
 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
In-Reply-To: <20250424165713.683ff583.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x441.google.com
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

On 4/25/25 06:57, Alex Williamson wrote:
> On Tue, 22 Apr 2025 00:31:07 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> OpRegion is exposed to guest as a read-only fw_cfg item, so hotplugging
>> with it wouldn't cause issues. Since OpRegion needs to be set up by
>> guest firmware, a guest reboot is typically required. For linux guests,
>> i915 driver is able to mock VBT [1] when OpRegion is not present, the
>> reboot may not required.
>>
>> Still, hotplugging IGD devices is highly discouraged.
> 
> So why exactly are we doing this... ?
> 
> Thanks,
> Alex

Just out of curiosity :) will remove it in v2.

Thanks,
Moeko

>  
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bb1d132935c2f87cd261eb559759fe49d5e5dc43
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index e94ed7029a..e3ff86d0e6 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -549,10 +549,6 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>  
>>      /* Setup OpRegion access */
>>      if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION)) {
>> -        if (vdev->pdev.qdev.hotplugged) {
>> -            error_setg(errp, "OpRegion is not supported on hotplugged device");
>> -            goto error;
>> -        }
>>          if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
>>              goto error;
>>          }
> 


