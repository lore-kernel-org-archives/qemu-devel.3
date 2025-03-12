Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECA6C2BA1B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 06:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsG1S-0001ov-5X; Wed, 12 Mar 2025 02:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsG1M-0001ji-5d
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:56:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsG1K-0001VL-Ho
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741762609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aOpkSjkdXnSS16Y8kAP9uC5dq6Ij7gAcLwbYDHdtqMI=;
 b=dOrMRd/EmVUtyUKkUYo2bs7BEsU/Nz6sRNp/IqBJPli9/mhdM0aQ6dfMpCaYMt2T5Nrocy
 IOoGWb1UVP4+O+Y1n8fJCOCPSHiIfvvc1T3kVRk9xVTw1/w5W/J92huMP+Wf5dpuRq61jR
 bAtVb/G8KQQEHBlIj3w+Bhg7SaEEYLw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-F-XNmaClN0u0J0fXNZsY2w-1; Wed, 12 Mar 2025 02:56:45 -0400
X-MC-Unique: F-XNmaClN0u0J0fXNZsY2w-1
X-Mimecast-MFC-AGG-ID: F-XNmaClN0u0J0fXNZsY2w_1741762604
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso52464745e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 23:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741762604; x=1742367404;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aOpkSjkdXnSS16Y8kAP9uC5dq6Ij7gAcLwbYDHdtqMI=;
 b=TLmm+U68JkLHZDUccVURVQkgIxtX+3nj928U6fNRp5x3F5a3Fzfplt0ta4wACbzagb
 pbGJeTWIeXbI/3KozTcriMzuYrUslHwmY58xaPMj2Y5Tm509hlLkvAlmYDk97k3TJ6za
 oT2eqCYsgIxxODkB4Ospl3RgpYSIDyO0aPROr6UUcxDyn3Fes/86r+74I4ESTVeIk6+t
 tJhJ/u9jj+UPEMD/cddKrQ12uho5tTPnqmS9OnqKS6WU5hs42s73PswDKdafNo82Q6Si
 FLSY5huOY0IvTdNd5WxtWN2ebJ7gC44cuDylFHgFswnIBThVJgksG8YYiIRVtn2M79Bk
 UUGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiYrzuJw906BlXgo/U7MBMkGCMy/xS3ryq/quRuSZSycgDEDRocG3vPsBFqF0lbiD+dDrPX0LGDhAB@nongnu.org
X-Gm-Message-State: AOJu0YzEhA6/JKdQga0nO8T3q5FWhXubQ2FNIU4c820Ldic+cKqzxPZ1
 O7kVonKS/ywjC/yYniPzsVzIVspspW3TzTqJQp8Fk/5mx5xBgJ8ILFWWtCW3VkMVdmk1CgKSYPY
 HwvF6BjYKhW2WcDe689ezHOq2wGCsTwzvTfqcv7p4ZhcUQATMskZU
X-Gm-Gg: ASbGncv9u2pxjC29G43saIUPNsAs4UEAhW+9vKzkKx7XboQDM0utu/PaVd3Jm6j4R2A
 yr7dud3HiA2wz+o/pyOq9vsRdja+QAHPqXv0jlKxFLLvojX2g23r9z2oP+Hviqv+6vhTfaOxW/I
 3uo8RJ2Kkq9kopbFw4YxL1jYN11c+gkh8/b5o2K9NnW/GIVI+bo5eigvgLjZjFd5ZeKNDZfoNw4
 Q6BAA+YIPFp4aXHu0C7a5lab8Lpgsqzx464h73tlIPs6gHbgaJJV4+zsA4Qqu1wvhFhumGoKcRp
 3+jxjoJbi4yp1iImZOE1bxbA9dMOC/s0zbVcZe6XJqbt/+U=
X-Received: by 2002:a05:600c:510f:b0:43d:b85:1831 with SMTP id
 5b1f17b1804b1-43d1187484amr1320785e9.0.1741762603876; 
 Tue, 11 Mar 2025 23:56:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEboTBeLYbSXsV0NolEjgPOiSP6lM+gXi6UxiGftCI6/pG4PwijM6ARAJZLnWpY9gupYqPzQg==
X-Received: by 2002:a05:600c:510f:b0:43d:b85:1831 with SMTP id
 5b1f17b1804b1-43d1187484amr1320615e9.0.1741762603499; 
 Tue, 11 Mar 2025 23:56:43 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-149.web.vodafone.de.
 [109.42.51.149]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a8c5cf7sm11622055e9.29.2025.03.11.23.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 23:56:43 -0700 (PDT)
Message-ID: <10656ca0-1822-4505-a164-4e45db84884d@redhat.com>
Date: Wed, 12 Mar 2025 07:56:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/functional/asset: Add AssetError exception class
To: Nicholas Piggin <npiggin@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250312051739.938441-1-npiggin@gmail.com>
 <20250312051739.938441-4-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250312051739.938441-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/03/2025 06.17, Nicholas Piggin wrote:
> Assets are uniquely identified by human-readable-ish url, so make an
> AssetError exception class that prints url with error message.
> 
> A property 'transient' is used to capture whether the client may retry
> or try again later, or if it is a serious and likely permanent error.
> This is used to retain the existing behaviour of treating HTTP errors
> other than 404 as 'transient' and not causing precache step to fail.
> Additionally, partial-downloads and stale asset caches that fail to
> resolve after the retry limit are now treated as transient and do not
> cause precache step to fail.
> 
> For background: The NetBSD archive is, at the time of writing, failing
> with short transfer. Retrying the fetch at that position (as wget does)
> results in a "503 backend unavailable" error. We would like to get that
> error code directly, but I have not found a way to do that with urllib,
> so treating the short-copy as a transient failure covers that case (and
> seems like a reasonable way to handle it in general).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/functional/qemu_test/asset.py | 41 ++++++++++++++++++-----------
>   1 file changed, 26 insertions(+), 15 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


