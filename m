Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880D7C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 08:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNS7Y-0001TD-NJ; Fri, 06 Jun 2025 04:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uNS7T-0001RQ-3I
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 04:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uNS7Q-0005xJ-Ct
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 04:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749197282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9fmzYjKqR6+8EbYEeV/irp7fd7mrp+KmEPT6BuDbM1M=;
 b=J1Zcv1nvJ3V8hlQguv3NaX8+3jE25Ym1wJHPCoS6SnhL9UDL34BJiesdw8YyveNw8IhB/V
 UqfFo4PaWySzCz0S1rfQsD6LkTQxrpfzFICQacrH6eFEZpcgg6VCAWy0Bl3F9Yo0H6Zaue
 ve5uuHZZRFJZgyYAD9D1N2xSLex2/Bg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-klth9ukjMD2bdFQ0c1yWxg-1; Fri, 06 Jun 2025 04:08:00 -0400
X-MC-Unique: klth9ukjMD2bdFQ0c1yWxg-1
X-Mimecast-MFC-AGG-ID: klth9ukjMD2bdFQ0c1yWxg_1749197279
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so1018472f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 01:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749197279; x=1749802079;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9fmzYjKqR6+8EbYEeV/irp7fd7mrp+KmEPT6BuDbM1M=;
 b=qPwZk+BYOPQjZE7dWM3RPW5cPvtnLQyJHiS7WfJdxCRtCOHxFjOmcrSuUguovQsFx9
 j8GJQsVphW8TJAbXdseMmXP1upDlMQ4snSJxs4VMeNFPs7KR06Of5iUbX3QS6svgn6Cj
 8s9GEUwX40CmIQwGZXGQhrzPNRuW6vlfjbbvoxYrDnQyutbA6ZdDAWy3ddlRiYaTlYEP
 y1BMOqTGGteY916/tLH3rsBPztZ8XAtaZWXLiX87JPSqQIA7AGpRVqWshJpADmMoBJUz
 VGuaavqYFdeEYTvMur9gRy1zfUCGz2kcUZKPHYtlJkohKaEA4fwPE2bm+9c3YH2+34om
 SzQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9qnTEhbz3MjCPLj0Bny1sBubbIS2vGXDDl5NjjxStI9b5Tg1O/3D04wkK/C5RsSHepNkJqBNo6Feo@nongnu.org
X-Gm-Message-State: AOJu0YypUM/ZBVcV9kh+PP9lylaDcpkXqt1kijIubNLN/NLty9kal+ju
 B71D9BNUArTnwk2ePaY5GujHN9jPU85mGuJbskuGEJKrGa7qlJgmDg0G08YQWl0i4Y+3qciXa55
 YJD8/f9gzGc5zkoMncMLriTwsk8qAiE8ISC0wL2M3rqBb6xsh98i+Wowx
X-Gm-Gg: ASbGncs8/abFkg4HnwGvphvdYbXmZOs0NO2eiwF5vRF7fQOVTRpkQ6JURJt9is2S5Yy
 JBkW7md6wrNK4MhUzdgxU35j+lTaD3CHcoGSOhCpZ7ToP+vMlH8C6BH3r9V06yKJZ6CLzfZPRVz
 Igw1NMXWvQuTzCycQoz2RQHPGbPXiMJWfpFehXkYAg4iMQhqcv8MqKlR6V4e/4oJr35P8enzy8s
 sI227NjG97Z/VnDly3fnL79jEmxZ6/CxtD8PyMJ3dImG9//0JwXvPZZF5BbdgYcfxD/KtaFuogv
 XFTqHkJSnaCADy1aGREi+Ylui3qVNVkcq6O9hKwdKRpQ3zNFBko/Ma1+5ALN
X-Received: by 2002:a05:6000:40e1:b0:3a4:e238:6496 with SMTP id
 ffacd0b85a97d-3a526e0cc1dmr6169364f8f.18.1749197279205; 
 Fri, 06 Jun 2025 01:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9P43IuSdRz3yw71cNyxdJ9ZimGLWH1cipXn7Nl0wx/7jwcbB6bfq5NKzcz+uV9Blno2HtRA==
X-Received: by 2002:a05:6000:40e1:b0:3a4:e238:6496 with SMTP id
 ffacd0b85a97d-3a526e0cc1dmr6169334f8f.18.1749197278795; 
 Fri, 06 Jun 2025 01:07:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4521375a392sm15432825e9.36.2025.06.06.01.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 01:07:58 -0700 (PDT)
Message-ID: <c373ee81-d094-4b40-93c9-5ece6e24e520@redhat.com>
Date: Fri, 6 Jun 2025 10:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ramfb: Add property to control if load the romfile
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20250606070234.2063451-1-shahuang@redhat.com>
 <aEKeNSc8mAZ8vhGj@redhat.com>
 <cf34f5b2-d422-453f-85d4-15938ae59e9f@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cf34f5b2-d422-453f-85d4-15938ae59e9f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/6/25 10:06, Cédric Le Goater wrote:
> On 6/6/25 09:52, Daniel P. Berrangé wrote:
>> On Fri, Jun 06, 2025 at 03:02:34AM -0400, Shaoqin Huang wrote:
>>> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
>>> the x86 need the vgabios-ramfb.bin, this can cause that when use the
>>> release package on arm64 it can't find the vgabios-ramfb.bin.
>>>
>>> Because only seabios will use the vgabios-ramfb.bin, load the rom logic
>>> is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
>>> for ramfb, so they don't need to load the romfile.
>>>
>>> So add a new property use_legacy_x86_rom in both ramfb and vfio_pci
>>> device, because the vfio display also use the ramfb_setup() to load
>>> the vgabios-ramfb.bin file.
>>>
>>> After have this property, the machine type can set the compatibility to
>>> not load the vgabios-ramfb.bin if the arch doesn't need it.
>>
>> Can you make this a series, with an additional patch that updates the
>> current in-dev machine types to use this new property, so we're clear
>> about the proposed usage.
> 
> yes. And please change the vfio-pci property name to use underscores.

Sorry, to *not* use underscores : use-legacy-x86-rom


Thanks,

C.



