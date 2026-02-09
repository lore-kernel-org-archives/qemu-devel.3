Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97EBE7E0C7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 10:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpOxE-0005TN-RD; Mon, 09 Feb 2026 05:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpOvy-0004pI-Kz
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 05:56:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpOvw-0004sL-10
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 05:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770634558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TK7dMFwD7Qry9p4nvhcJqmu0xwXs++0I2zminyyhmLI=;
 b=D5KuPUe32Dppx97SylIwiYvJz98stivs9ohV43Lof2/l5C2FixyVvxLwtQ0voxGierWTCR
 RJhPSvb6REtJXGKB7xNR5R+sz9a7NKEvAv9fLTBo1ebdl0TSyymUYZA6BrQeBOZRQsvBkZ
 ZfknzkcKX5TIwAVN5ISCTlBNTaP8RA8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-H0pBHZjYPW-_n5LOvBY1vw-1; Mon, 09 Feb 2026 05:55:57 -0500
X-MC-Unique: H0pBHZjYPW-_n5LOvBY1vw-1
X-Mimecast-MFC-AGG-ID: H0pBHZjYPW-_n5LOvBY1vw_1770634556
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b8e9c967910so546363166b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 02:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770634555; x=1771239355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TK7dMFwD7Qry9p4nvhcJqmu0xwXs++0I2zminyyhmLI=;
 b=H/dBiwesjsH2nMR7c6H4mq0+6aVuttP9e5xluXmXiGAa4EDQoNLAeR3kpDuj/CLgOI
 yvnfK/dv+xtKbMgKbYtX6rKDVwyJgvOUfYGaYgzRo8BGSv07AQk9ijviY6YgtPR/uQHQ
 6xC/GvZtWBFf8QGBAY4bFiY3k0yKnhhPxIKUjoysjqYTWBbDZ1hZkQJ5jrah4t79UUGK
 7clDhM4a1pBGEd9GN1tIeDqblnqUQqe9YWxqIQxw9v1KK8z7gD/UMWCQcsZw81nUu3V3
 wnr0KD6ny+us80oSD18iToDPaMIt+VBQRJlwehjgHwV1MFpxpgR1NDqP1pTyhm4BN0pi
 uc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770634555; x=1771239355;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TK7dMFwD7Qry9p4nvhcJqmu0xwXs++0I2zminyyhmLI=;
 b=um+Fkk2xMSbh5dcCnrPUOUzm0NGsIoBQoQifd9zsaYAvqFdYXegaOiS7vNUiWJKdxW
 l/loRPBsbH1vS8dffxjVKyTs3LcrYyQ22wEN/Eyy74uXSzlloXDFpcOmULjo+I/7Ey0i
 cVUxLG094T5amPeDeM4Xdo+fBUi5HzCxxLsqCKiUceO3hiP5L9w47ZIFXn9PmPSePDYe
 TE+SVnC1Ttma7J3STE9IURpaUHYyjZ+2KGK7tYidY6bVPCrZziGjgyr4QbIsfFs2pKVV
 MdMAxbxX3QAIHqvKaI1whDO2vGkZ6G6Vnt7hMf9u7AarkAvGssmxq6wIdwJF86PhJatA
 yuRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVScIln3PP2bp4o5rDyc6aHHFgnPnH/P6d3yF2ik88CsMO71loOIM0ruog3s0P5SjVk1VxuOokEuUWl@nongnu.org
X-Gm-Message-State: AOJu0YxCGUIXbeVceZs/SM8H+TydrnRk16aqDgNYOaEf5ZMeyqbn6A+6
 kI2FlInavtZTdFmqLWzXVBDOLa7akvptOej9uH9p3yDHtiHLlnMkmepx7ARWbLrq2S1CjXc6yjT
 x1HE38R+erOG4gywei4SPyhzgO1iJmoTAorGeeTpsV4x89W+HK0sSt1in
X-Gm-Gg: AZuq6aLhqTecqiE4PKNZ6uUTpHIGnSHHpL+BqHWk5uQhhjx78HWpyHJM1zswFgeVh6b
 jOEYt8Vlz3x9cRD1nD9OpOWznAiBn33VNx85OqBjhWq0cAoIMkMOOKWa9ooe1ji6u1rXcjqdTai
 r+S5h7MGn15f7UcQ+77fZdlaEpkB7yj+T381xw22C8Pwqos9FlCYGSqL36Sx583qxjvlmld+Y99
 2TWBvdDhoA8aUcWKFgJuTq5nOMOAR43q61cBz3yIMp60nxaXI0r9SI+LWBpGoEuBg5u4BZ42MIY
 oAITmz2nY+b05/EB9wNZsN6Xt+c9dHv4CyZDMVnQApn23oGObeZYvIdQv+st5Nd4Qu0v5byWKUT
 b6UEiDRbLN4tZSOus/mucEAbzq7N+XB8PtMgjQooE3UkZMB9bAK0M7URHsMAl80mszjCn01OIuv
 MHvMmLWoOsh50fpw==
X-Received: by 2002:a17:907:7b9e:b0:b87:6d6b:1366 with SMTP id
 a640c23a62f3a-b8edf377411mr649831666b.41.1770634554735; 
 Mon, 09 Feb 2026 02:55:54 -0800 (PST)
X-Received: by 2002:a17:907:7b9e:b0:b87:6d6b:1366 with SMTP id
 a640c23a62f3a-b8edf377411mr649829066b.41.1770634554257; 
 Mon, 09 Feb 2026 02:55:54 -0800 (PST)
Received: from [192.168.10.81] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b8edacf1532sm377095466b.55.2026.02.09.02.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 02:55:53 -0800 (PST)
Message-ID: <c3b39124-ee51-4930-b760-969c6c9bd496@redhat.com>
Date: Mon, 9 Feb 2026 11:55:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/mshv: Remove remap overlapping mappings code
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
References: <20260113153708.448968-1-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260113153708.448968-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On 1/13/26 16:37, Magnus Kulke wrote:
> This change removes userland code that worked around a restriction
> in the mshv driver in the 6.18 kernel: regions from userland
> couldn't be mapped to multiple regions in the kernel. We maintained a
> shadow mapping table in qemu and used a heuristic to swap in a requested
> region in case of UNMAPPED_GPA exits.
> 
> However, this heuristic wasn't reliable in all cases, since HyperV
> behaviour is not 100% reliable across versions. HyperV itself doesn't
> prohibit to map regions at multiple places into the guest, so the
> restriction has been removed in the mshv driver.
> 
> Hence we can remove the remapping code. Effectively this will mandate a
> 6.19 kernel, if the workload attempt to map e.g. BIOS to multiple
> reagions. I still think it's the right call to remove this logic:
> 
> - The workaround only seems to work reliably with a certain revision
>    of HyperV as a nested hypervisor.
> - We expect Direct Virtualization (L1VH) to be the main platform for
>    the mshv accelerator, which also requires a 6.19 kernel
> 
> This reverts commit efc4093358511a58846a409b965213aa1bb9f31a.

Queued, thanks.

Paolo


