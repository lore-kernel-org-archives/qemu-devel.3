Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9DAC87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHMI-0001Co-LQ; Fri, 08 Aug 2025 03:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ukHKr-0006oR-OV
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ukHKh-0007HH-8I
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qLOmI8IlBtbgrQnUFHvVhlMj2g53HioXDwBsgVDQCOk=;
 b=PVrDxJ4TSdOB/0YGEXcFUTuyZkgQrrtsxDk03Hyw9Wi4U7t9eU5523ABuk0FUJq6qBR/3g
 KUxp1Kg5LynnxvOjtI4Y4mT9JRp9uGuGEHC6sdUx7LSVZK4QDEer1v58m8hwdRrmgjxCsN
 8tumurJlFYfsGb+iEVN9kgxLd88vHQ0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-7M8izIrsOkua6vuKeQ91cw-1; Fri, 08 Aug 2025 03:15:59 -0400
X-MC-Unique: 7M8izIrsOkua6vuKeQ91cw-1
X-Mimecast-MFC-AGG-ID: 7M8izIrsOkua6vuKeQ91cw_1754637359
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-7075a0b5580so33724766d6.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637359; x=1755242159;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qLOmI8IlBtbgrQnUFHvVhlMj2g53HioXDwBsgVDQCOk=;
 b=EBB2PB3caKI3Qfpl6SGBcPp1tYOBYT5luVBBxUAC2nrBVCbGEzcnmMpn2fERr4c3zP
 xMuK2BQ+I/VfuWYWzUO4oIxK9FCmwJZKuyPoSsrVvfBgzeT62UWXlfzTXG/Pl1wKfkrv
 UEGmGnz2+2JZEZ7pY0f4FY1d3S0tuhxn9WtPbEp+X7Qnhf8YSc/lNcvJKQx/3DHLQwxN
 6QKHkQbfnNZaH3+jKqeuqpH9itVAkzFW82zmca9Cru02moeGs9qKs+lFega8WlyIIYAt
 PC0Hf1mw0tu8i5e07RBqTGtw9KkIQGxJNRLxunh6oQhqh4TPVyce3L/zzeh8fYMFlsBd
 MxTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDUO3Bk4AM84lMcoqsHAOctdgkCX4NYFjukxRPVY2/3+wODXq+PdwfMoiRYSu162gbeOIxx5QH0S8n@nongnu.org
X-Gm-Message-State: AOJu0YwFzvj9L+nGGvBfOBeZ7EphDXgiCw+5KbaSaxY+YqegeZhzBrHp
 iETzXXFTmEOekv/ixXU//4E1faDzWIuY9GNrb9LBG2YtWsU1BaiiJJEJYw1JHdKpLZg8bXJhR3w
 e/pAJ8F5L8+iElyTqOvL7VXwjiVY1ZQiplkNC+ulrf0GIVql2nkCzSVOk
X-Gm-Gg: ASbGncvsn71cbkz6Tyk+jkZPZmXCz1K+dfpimUlykl1fgVo5hCuv+qS8p3VUBiOET46
 b1GQeS/c/To8lKgQ1CUohUYQwBF1ZB5+HS0rBVSpnDeootB6hkq+V9RRl1ZijiM/w9A5WWB4mMP
 rsvgaRB3TKyziCLXpFcJV2x7smRLo3vAD25Zxf96j+KGMLBdExI2sE2YuRDDB9CIfsv6yegUjqi
 4DQMnZayKu7lV6JrBZz913xJ4INclKoHzenHle3uj7JQBqwqR3gOi5iKcEyc27PHK7U9foPGTHK
 9dY1yb9XGTYD/i82TQpRPJ7SRk4naLFraCrO34eIxj6VXM+71VOEaYzA3GkiiTEXbWqdW6IBpLn
 I3w==
X-Received: by 2002:a05:6214:600b:b0:709:9f2e:6b61 with SMTP id
 6a1803df08f44-7099f2e6c5bmr10673896d6.21.1754637359348; 
 Fri, 08 Aug 2025 00:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGONpWk2UpgSaRYRUPQqU6zInU2DWV0Co9EQmOS9jTdATYFBPIcqscpwWnxdiYrjCLzVElUMQ==
X-Received: by 2002:a05:6214:600b:b0:709:9f2e:6b61 with SMTP id
 6a1803df08f44-7099f2e6c5bmr10673696d6.21.1754637358818; 
 Fri, 08 Aug 2025 00:15:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ca3621asm110601706d6.33.2025.08.08.00.15.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 00:15:58 -0700 (PDT)
Message-ID: <5b9e0a81-c2d9-4c55-b761-a43a69ec400c@redhat.com>
Date: Fri, 8 Aug 2025 09:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] Deprecate Power8E and Power8NVL
To: Aditya Gupta <adityag@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250607110412.2342511-1-adityag@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250607110412.2342511-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/7/25 13:04, Aditya Gupta wrote:
> Note: No changes, only change compared to v6 is rebased to upstream
> 
> Power8E and Power8NVL are not maintained, and not useful to qemu, and
> upstream skiboot also has removed support till Power8 DD1.
> Power8NVL CPU doesn't boot since skiboot v7.0, or following skiboot commit
> to be exact:
> 
>      commit c5424f683ee3 ("Remove support for POWER8 DD1")
> 
> No direct way to deprecate the pnv chips, a field like deprecation_note
> could be added, but felt not needed as the chip will only get used if
> the user requests corresponding 8E / 8NVL CPU, which will print
> deprecation warning.
> 
> Also, no separate pnv machine for 8E and 8NVL, user has to pass --cpu,
> which will throw the deprecation warning. So just deprecating CPUs should
> be enough.
> 
> Changelog
> =========
> v7:
>    + rebased to upstream
> v6:
>    + change qemu version from 10.0 to 10.1 in doc
> v5 (https://lore.kernel.org/qemu-devel/20250422043843.26115-1-adityag@linux.ibm.com/):
>    + split into 2 patches, defining macro, and deprecating 8e & 8nvl
> v4 (https://lore.kernel.org/qemu-devel/20250330211012.2932258-1-adityag@linux.ibm.com/):
>    + remove unnecessary 'if'
> v3:
>    + add 'deprecation_note' argument to the POWERPC_DEPRECATED_CPU macro
> v2:
>    + add mention to docs/about/deprecated.rst
>    + add '(deprecated)' in output of qemu-system-ppc64 --cpu help
> 
> Base Commit: 96215036f47403438c7c7869b7cd419bd7a11f82
> 
> Aditya Gupta (2):
>    target/ppc: Introduce macro for deprecating PowerPC CPUs
>    target/ppc: Deprecate Power8E and Power8NVL
> 
>   docs/about/deprecated.rst |  9 +++++++++
>   target/ppc/cpu-models.c   | 20 +++++++++++++++-----
>   target/ppc/cpu_init.c     |  7 ++++++-
>   3 files changed, 30 insertions(+), 6 deletions(-)
> 

It's too late for QEMU 10.1. Let's not forget these for the next cycle.

Thanks,

C.


