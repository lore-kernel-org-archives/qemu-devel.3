Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656B7C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 07:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfD5U-0002MG-9g; Tue, 04 Feb 2025 02:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfD5R-0002Kx-F0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 02:11:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfD5P-0004xn-5G
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 02:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738653065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QeKfa3/FqNOrTsiIT5bZDFSMoxo3ZoxiTxGpBbOMIG8=;
 b=Zy21hbddpC87huiGLWesZ5+xkjPa75aXHvnRFQGQ2TANIFoVwW2WYP8mlPtkr1EnbR2GGD
 5oYeCxjz5TSWFhCfLNqwmSJLHo00adTqjEmpSVp5wHZaxeheS5+10TB8jYEqBYiwH0Xoo+
 tzQkH0Q+OuH8aAWOdJX7WONTzgpsX5U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-YSYD__x4OVCoKVpQu7PZyA-1; Tue, 04 Feb 2025 02:11:04 -0500
X-MC-Unique: YSYD__x4OVCoKVpQu7PZyA-1
X-Mimecast-MFC-AGG-ID: YSYD__x4OVCoKVpQu7PZyA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385e1fd40acso2569126f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 23:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738653063; x=1739257863;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QeKfa3/FqNOrTsiIT5bZDFSMoxo3ZoxiTxGpBbOMIG8=;
 b=QaaUvqY8Ov/+FCFcUBML6w3F820GTFW1Ua5jc+gF4i/eG81ArCBPF/KigziYU8KMgU
 fx3N36cr6z4W77C57AHMJYsZdk26tLPbZaFfEK6bDYAxvY6FIYGRP2nwbuEpDtSuX0N1
 QmcmlVD4NyYycukVeyPLq0Q3aaURpEZ8oFhnHxeW2VOykYECpbhzJ4Dn1uDB8LIEFeqd
 igPEtNn+dKlzXM5SrVWQGtfdHoWjILXXED3AKByA+xtBzjbXMcYwlvrtEEMDNkczRqWA
 sUxhyQSKmZ4ykBTIf2pkbR/U++0fJdLXAejigg4i6Yq0fJq7a0vF4Vpp5oXzRLY/rFtZ
 mK0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUOGastcBXlaiQHrG01g4K9PZWq6Pz15/sHaa9m/WIcAOTdlSxp68Vrm1phBNdVVTaR2KVJyKQviK5@nongnu.org
X-Gm-Message-State: AOJu0Yw7S0lxunURcm3JG30UtImyny09SrGEb5zvP7s3RLNxHXxgHbfH
 mpG0CYRNLN96ts4jLdvT30wCQ/GRqEo17VrEsYlw9hnX8WVurwk5GG3aYWRIwQ+cnnor+CypknP
 FIXIXphDkiIHg8PpfQ7KGYjQF1IAG5xdi9yddBHntqa2xH6euKGYZ
X-Gm-Gg: ASbGncvtwRbcz/1h+OyeukRVlL8E+/1iNTAF6Qq67A9t+imf83rOx2kwvfWSM/ONSKX
 oRmbs97H50s7bizT6vAxeUzEYqfP6d90Vn82HRzt9sGwGOSU5pMXaCcyEG1zt2dxrbiz+5B1AHK
 GZv8qg0WMdiQc6JyVx1qj6NK7HnkwPKveqmqZen4Jz3c3UAZNNcMonhEpUWooOTl2iCBfb8rSXC
 DXwTf/6LCdB/7bjPNwTxI8sE2ggpUuz5Beol5UCt233lnNK1qWn6xJLHWbISLhWfo//EgS20+ku
 VjeRMNoaY6vf9B/OWchUnW3+jAj/ZJP9DRqz
X-Received: by 2002:a05:6000:1884:b0:388:e377:8a1b with SMTP id
 ffacd0b85a97d-38c51b60c11mr19565161f8f.28.1738653062955; 
 Mon, 03 Feb 2025 23:11:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE83OA2ZdyUwpCoRoa/dxWcenK51tCxhFW3QmQtkn2l5hNJ2xyhgJCA3aB1GNno4GhZ+fAV0g==
X-Received: by 2002:a05:6000:1884:b0:388:e377:8a1b with SMTP id
 ffacd0b85a97d-38c51b60c11mr19565135f8f.28.1738653062640; 
 Mon, 03 Feb 2025 23:11:02 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1016easm14856161f8f.24.2025.02.03.23.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 23:11:02 -0800 (PST)
Message-ID: <03497b94-e681-4bf7-8e1a-471d616219da@redhat.com>
Date: Tue, 4 Feb 2025 08:11:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 0/3] hw/boards: Try to make sense of
 MachineClass::no_sdcard flag
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org
References: <20241125181420.24424-1-philmd@linaro.org>
 <219be312-4acc-46c9-8a56-16e5cb483ae4@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <219be312-4acc-46c9-8a56-16e5cb483ae4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/11/2024 06.24, Philippe Mathieu-Daudé wrote:
> On 25/11/24 19:14, Philippe Mathieu-Daudé wrote:
>> Invert MachineClass 'no_sdcard' flag logic and rename it
>> to 'create_default_sdcard_drive' to make sense of this
>> default value applied to all machines. No logical change
>> intended.
>>
>> Philippe Mathieu-Daudé (3):
>>    hw/boards: Convert no_sdcard flag to OnOffAuto tri-state
>>    hw/boards: Explicit no_sdcard=false as ON_OFF_AUTO_OFF
>>    hw/boards: Rename no_sdcard -> create_default_sdcard_drive

Sorry, this felt through the cracks, but I think this series here is indeed 
a much better idea than the code churn in your other series that simply 
changes the bitfields into booleans.

> I expect next steps to be:
> 
>   - Remove nonsense create_default_sdcard_drive (where
>     machines don't have SDHCI devices)

A fourth patch like this would be very welcome, too!

  Thomas


