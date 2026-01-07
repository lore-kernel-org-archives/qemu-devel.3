Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4368CCF6BE4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 05:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdLpz-0002Ja-59; Wed, 07 Jan 2026 00:12:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdLps-0002Cz-FX
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 00:11:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdLpq-0002b1-Ht
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 00:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767762713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Vp9h5EhGAEo2Y0ttLXTZsC5v7qZvrK8vJlBC5NtKS+M=;
 b=VsqeHLFYXPNapfTPK9xI4H2AR0l5i6PAgAm0xylHfGYetSIacGCS1f4CI4HfTZ5meT49/J
 XvNNI9osoABeRqNH2cMREEsFgHKstUwV2Po/uL3+ooKvJC56ZMbtGF4kk0bjBhjwAA0Q7k
 ofGeTN3oVAfFF90DlZz1xI01PaeC5NU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-TRzQ5X83Ni2N16up2kMlEg-1; Wed, 07 Jan 2026 00:11:51 -0500
X-MC-Unique: TRzQ5X83Ni2N16up2kMlEg-1
X-Mimecast-MFC-AGG-ID: TRzQ5X83Ni2N16up2kMlEg_1767762710
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so13055435e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 21:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767762710; x=1768367510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Vp9h5EhGAEo2Y0ttLXTZsC5v7qZvrK8vJlBC5NtKS+M=;
 b=K6xTwhFUOuMXDZJtnPPN81ZgjVm/ePWtNxrzc0rkCU2AoaM0ChqiANgWPLBWDDM9dx
 V+wUyZsh/AbDuXsnMGpbFNHQD1xP5AOsaL2maDnZdZUdESWIcITrz0EyJ8lxF588lYax
 o4D7hushRnvyPyCI2OxnMuNhb0KKsWCfCKqSdwkgR+YWaGLwGc/JBHUkpKdD9u2DGEYH
 9Nxvin8O2rGCM0Ha2rWUY+UtcZPLesIq9fBiOr4YD1v9Dh1cfgJ40M31R27Pe3GEXbKT
 uGapREm17AiinuI8OqYtvs2rjV0tSunz6g6I0M10nTm3OTCE9StpGhTLow8m3nDP06/N
 ZrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767762710; x=1768367510;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vp9h5EhGAEo2Y0ttLXTZsC5v7qZvrK8vJlBC5NtKS+M=;
 b=ZveEf9IqPY51mk6sXO83c/3D9UZlyeuPC0B3ZonxA5RmsSk276kDo/00dHaQeXewSm
 32R7ihnCfkqfEjA9iHBC22n+4juJ6TMrwnxkWQ3NBISzc3fBGTrZzgBgeHwjTdPLSYMW
 Cg5aD13cZvgp/wcMLa3NzCt4AQ+VZiBfdj1otPLbz9NtQiA/F81zOP2TegUCxstgABbT
 yqX7GQHkFfoWYQv78/wYE56AOwkVPIUNkUdJQjixpjFJFyAbW82JKeLTVEkJWRiKDLEg
 dvweDXeo9qHi3Fkythi5fU31fXUt4Vc7z+7qrjFEaP06+F0wrJDCfj9eMV2nT3VyMAvO
 ZeYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMQdY7+hmKkohU6XbU7ZZYDm2ermdK+PRk9h9OqRJsuj1I55lMREYk2j+8Jis3YiRmrHX4cztdINc/@nongnu.org
X-Gm-Message-State: AOJu0YxbDO8dD6+hTRO4axCVH21dH8r8ty1uMjhQhMJo+1YQKqGGPN2R
 jKwDg1sry4Xcl45JopFdXt8Jv9NtTx2FwaosadkLhsZyJyKJ+FLeRAooghafzD+RM7SOQOtzala
 h/qUjtpvFoZOS0I2R0eeFnKzlCnF301nrehi8r4Dq8Q1xkdahBqtetQdX
X-Gm-Gg: AY/fxX63yPPW5vFKQdB1PQ+NOZ/FLxxRldY6ldkFjT+LTwCMGoJLKYljcMp5p/0h7E+
 6Q2eCKdp7YvbFuXEELwPhiDAPszZj7/xfiB6hjE91ridSoQ4hrPaZjWU17hYM5OZJnvFjw56+hm
 /FCKS+vr7o26g7pWwgsJa1I9UnXY2Nhy63ILcwXkx0GmTSkr1U9pJ73mvc1Oz9J25awmSXVKdLF
 n1vbKXeXhkyP79WllHH5m3rlsGUY2GVcxur/luj48MUoBLZzSRmduLjjsZtrxxe2Ei6j8k/TbSZ
 baRatRO4VXtSMsU2fAmOETXqQ3fixAzDs1AlQWL1FNLzdiWXVNl6K0t6aNJ2erwagDoe6JQ8AGI
 tqphGKRQ=
X-Received: by 2002:a05:600c:a10a:b0:477:7bd2:693f with SMTP id
 5b1f17b1804b1-47d869a6980mr3457225e9.6.1767762710469; 
 Tue, 06 Jan 2026 21:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1gOr9C4T1FpxRgsV3wClZhg3G6J8HAbv/DLFavKJFfPDjg9E44QkGGb2I4Ik1Avtar9cMeQ==
X-Received: by 2002:a05:600c:a10a:b0:477:7bd2:693f with SMTP id
 5b1f17b1804b1-47d869a6980mr3457085e9.6.1767762710121; 
 Tue, 06 Jan 2026 21:11:50 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f70bc4fsm75696895e9.15.2026.01.06.21.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 21:11:49 -0800 (PST)
Message-ID: <8cd94520-8f57-4e03-be16-b2dbda276ba2@redhat.com>
Date: Wed, 7 Jan 2026 06:11:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] configs/targets: Forbid S390x to use legacy native
 endianness APIs
To: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Anton Johansson <anjo@rev.ng>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251224162036.90404-1-philmd@linaro.org>
 <20251224162036.90404-9-philmd@linaro.org>
 <41ab3dd6807e59420117f200b390be3544735347.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <41ab3dd6807e59420117f200b390be3544735347.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06/01/2026 21.29, Eric Farman wrote:
> On Wed, 2025-12-24 at 17:20 +0100, Philippe Mathieu-Daudé wrote:
>> All S390x-related binaries are buildable without a single use
>> of the legacy "native endian" API. Unset the transitional
>> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
>> further uses of the legacy API.
> 
> One nit is that this text confuses me, because the code below sets
> TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API rather than unsetting TARGET_USE_LEGACY_NATIVE_ENDIAN_API.
> 
> End goal seems the same though.
By the way, both definitions seem to be completely unused in QEMU currently, 
so this patch is currently for no real use yet? Unless some more 
infrastructure gets merged that consumes this setting, I think we should 
rather not merge this patch yet. I'll queue patches 1-7 for my next pull 
request.

  Thomas


