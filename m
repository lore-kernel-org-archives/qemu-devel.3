Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD2CC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 05:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq47n-0005lA-TC; Thu, 06 Mar 2025 00:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tq47m-0005ku-Gh
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 00:50:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tq47k-0000JF-Hm
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 00:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741240222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3syLFzaHMXatZ8dFo04m8GqKmf4x8o+I0TMYQkVK8DI=;
 b=SZVOSicSDiPV/QHbuAJgOKWrgdxV7tjz8e1dgvqEHNATA/u0reXCorfDLWoRBjbZJSF/oJ
 gu4CiJ95PgYUStXYvTQTrpwnRivx8DXYNR+J+0P/ooQb8Te1HJh8Hrw3JO4Guk4vBMJZ5v
 8naDaDinLtSCW/ePli5y4LnQdAchFG0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-nBgjlq_HPJGOXtSjMaS6uA-1; Thu, 06 Mar 2025 00:50:16 -0500
X-MC-Unique: nBgjlq_HPJGOXtSjMaS6uA-1
X-Mimecast-MFC-AGG-ID: nBgjlq_HPJGOXtSjMaS6uA_1741240215
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-390ee05e2ceso166204f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 21:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741240215; x=1741845015;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3syLFzaHMXatZ8dFo04m8GqKmf4x8o+I0TMYQkVK8DI=;
 b=aCtAQwiaS6iFA58TmvkwpsuRRRAaZhfEf02p17hds6egb2XBCCifUUaTgf8wg9pexJ
 rtDdRkKk7CFpTFu+CIc0pqsx+axhiLsp1mogfCaSYxcFFdSZw6RXgdWMYZeTmuKHYFOa
 YnVokg0kdRRSBz5gT3IRcpeMGdLiFJmVyrBxwiDILbG7yNQ67qoDTxTGtKB1/wSex/fb
 15rwl9ekg18U3kbbFe5W6er9ZmtqFQsQLFaEkiUNnWpSTPvtRlp9dOPdneR4P8wAxifR
 sOoJd52f4FopacF/8wJndAlIzyRFJcFgRFOaDUYTDql1u/5A7VUihAbwByHVI6Vkuqlw
 9xRg==
X-Gm-Message-State: AOJu0YyZFtmcL/LqN9UqybZiunLT8oJEE2J8R6z6cyvAc2FlXB8RCVoc
 aVM1ALOE3CdKjD72l7Iw5MbWZcF0Aj4gOhMDYjzaN9IXTi6hNAwsFRnPo9omL+h93gt51pJC9rR
 etMSCpu/W+wUGxYyiVy/L8DjjLVlKZm7oOKwpVwZXkVkcw5CzLnrB
X-Gm-Gg: ASbGncs0jFaRsTyJPeLsJLqA3TNuGAxQeGNn5UdnNVgy+v1k/3jE74vN2/Hx30Ih9yt
 3J8zVw4whEDam8PY6ZM7i/pINiTaSMX6pmK9OxQiOxWg3Ao9pp9GE+oqg9yH2r2SMxQhxcOMOQq
 2CqCyEBv/wM5MKNMjbUM9XPFgZ5Xp+1IohJujj0NReEozioJ+UFPyIlamajDnItGYfwd8I6s0kv
 tponkZC+gQR0Mt13cXSgseNldW+9fYzLLtPn1wrvyghe3YD0uhVdWwKGe0SfFj91QDaFvN/kWGD
 nVyo4TpLf9Wm0HuxROpL7DCUdIqqoY9JHRPll+FhzkSGExfe5P52wA==
X-Received: by 2002:a05:6000:1f8e:b0:38d:ca55:76c3 with SMTP id
 ffacd0b85a97d-3911f7276bfmr5134619f8f.11.1741240214969; 
 Wed, 05 Mar 2025 21:50:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLs3hDtN+VEvLZMbjkWepAoyLQXtUnCp/VqYu+2yXDcSeZ7wrUew+ChlnoDfqN+rleASrGIQ==
X-Received: by 2002:a05:6000:1f8e:b0:38d:ca55:76c3 with SMTP id
 ffacd0b85a97d-3911f7276bfmr5134609f8f.11.1741240214550; 
 Wed, 05 Mar 2025 21:50:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c102db1sm830750f8f.95.2025.03.05.21.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 21:50:13 -0800 (PST)
Message-ID: <c6a67c17-c845-4b28-b01c-d5bebc327314@redhat.com>
Date: Thu, 6 Mar 2025 06:50:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] vfio/igd: Decoupling quirks with legacy mode
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <corvin.koehne@gmail.com>
References: <20250303175220.74917-1-tomitamoeko@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250303175220.74917-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Tomita,

On 3/3/25 18:52, Tomita Moeko wrote:
> This patchset intends to decouple existing quirks from legacy mode.
> Currently all quirks depends on legacy mode (except x-igd-opregion),
> which includes following conditions:
> * Machine type is i440fx
> * IGD device is at guest BDF 00:02.0
> * VBIOS in ROM BAR or file
> * VGA IO/MMIO ranges are claimed by IGD
> * OpRegion
> * Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
> 
> If one of the condition is not met, the quirks will not be applied.
> However, for recent generations, espcially Gen 11+ devices that removed
> VBIOS support, not all the conditions are required. For example, on EFI-
> based systems, VBIOS ROM is unnecessary, and VGA ranges are not used.
> 
> To have better support on newer UEFI-based VMs, this patchset makes the
> quirks independent of legacy mode. The BDSM and GGC register quirks are
> applied to all supported IGD devices, new x-igd-lpc option for the LPC
> bridge / Host bridge ID quirk is introduced for possible Q35 support.
> It also prepares for supporting IGD passthrough when it is not primary
> display later (kernel change will be merged in 6.15).
> 
> To maintain backward compatbility with exising configuration, legacy
> mode will automatically be enabled when:
> * Machine type is i440fx
> * IGD device is at guest BDF 00:02.0
> If the legacy mode behavior is unwanted, option x-igd-legacy-mode=off
> is provided for users to disable it.
> 
> Note that a major difference is that instead of simply continues, legacy
> mode will now fail immediately on error, this may break functionality,
> but the impact should be low as IGD passthrough is not working, and
> there would be no display output if it fails halfway.
> 
> The first 2 patches of this patchset was taken from a previous one,
> details can be found at:
> https://lore.kernel.org/all/20250124191245.12464-1-tomitamoeko@gmail.com/
> 
> This patchest was mainly tested on Alder Lake UHD770, with Debian 12
> (kernel 6.1), Windows 11 (driver 32.0.101.6458) and Intel GOP driver
> 17.0.1081.
> 
> Btw, documentation change would be added after everyone considers the
> proposed change is okay.
> 
> 
> Changelog:
> v2:
> * Keep legacy mode for compatbility
> * Renamed from "vfio/igd: Remove legacy mode"
> Link: https://lore.kernel.org/all/20250224182927.31519-1-tomitamoeko@gmail.com/


QEMU 10.0 soft-freeze is next week. I plan to send a PR at the end
of this week.

Thanks,

C.



