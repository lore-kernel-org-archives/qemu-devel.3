Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D640ED185D5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdo3z-0003j7-7e; Thu, 08 Jan 2026 06:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdo3Y-0003W7-Pb
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:19:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdo3W-0003b8-L5
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767871193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e5WKrdw7zKgx0TOWMUcrjHZmUemQQnLrO4lLA/grXak=;
 b=OTAxvyW6bCGkhUnmUr+i/sCVUbStj8KYd6mUKEmAsIgLD/ucKaeZtvWieMkOzmNWGOMrHP
 PJeJ03V2x3uym6smdtQCu8Pes5pHRVlX4oT9anAuygbG2qtb4aAYbnekSicYhyCyYSIdhv
 lcBO8ibhK7jVQtVsdwNXgEzMfbbr6jU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-gB6REqLiPFukyWvm4-se_A-1; Thu, 08 Jan 2026 06:19:52 -0500
X-MC-Unique: gB6REqLiPFukyWvm4-se_A-1
X-Mimecast-MFC-AGG-ID: gB6REqLiPFukyWvm4-se_A_1767871191
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso28973895e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767871191; x=1768475991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=e5WKrdw7zKgx0TOWMUcrjHZmUemQQnLrO4lLA/grXak=;
 b=D28K3bJW7dg3z4t5/5oI0E2FtDftQ86gXuk4/MP1y9rrGPQ5e1ecyzJ705gITt6ue6
 uCs9LnGMAM8OsbnM9hxGB+Dd3u5BZSZ8FkFBUu6sw9w2Ch33zYLVg506Te2FoQ2OngWB
 NmTtte9gTzG7stl9q7SW749yPHNn5tvlh6QsZOR0kLR4ZV6kmc+ww8hMp2d6BcdjPRqj
 me8larQKxNGYCwlOKK4SIWqsrPvlun3UPt7ya6VKzyRujwI6vuskNen0o9dop3a6yk7N
 HvTcZfeVQQLmyJQ+ycNyP1E2dONeJ69wgM9YWFWb9u+AuK6u4PXBiL63CImPiueyuU9t
 1dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767871191; x=1768475991;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5WKrdw7zKgx0TOWMUcrjHZmUemQQnLrO4lLA/grXak=;
 b=TADQiT65LR5+bllWn5r6vmhb5naXDyuZO8RCUqXbCxctstDkPwygnZK4ecXifs8a/2
 QbMEA3oRvTDnqHSXHs//VA6wm5R5h2sO8bRNkeHK9l/DZSiV9K3V+h+nGkN4/5PqpYb6
 WiSsg1OoDHwbw3VLKUjcMELEmm23alR5J8nDqtozGGYePhE6xWd6Jr8vd6RR8/lQ2rIb
 eC3WOqbdWTijEUIz8D4xgFa35hHdOp7c2C2yWhOlP4yRkjA2xZBSbo3idRIHNAMyGgeP
 YjAQqlPFkvz+hcFrkTNnbxzgvU+OXwtFaZru0lPcZr7jq3dx67IXfqFxR+86A8wGWpQf
 +e7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUssEIPR364BhXgn7bAS9IuN41l1ULxxM2Au84eE4YQjMaSUFirxBeL/+Tv2aEhpdrf1hRTJOlIvWiy@nongnu.org
X-Gm-Message-State: AOJu0YzSlJkCrFsC5W2IZUBKYLJEWQsaf+rNKcxiTIc4N7X/PW3rELs3
 l1zj6Wak/9D96kfP2ez0miKd29Q0pP0ijnzPcFK4773yu5U22cWjcE5pWCU4G/nZ3Xi4JIqZrvH
 YPCL9SHWGejGsRHI1vNdU7KvvmiUjxgLVusPLnCLgiU0H8aYZVu0c75bO
X-Gm-Gg: AY/fxX6i7W/GWdZUz+Oim9KkGfsdR/oK/0o6Ns6D8g3lFB14lcXmCO/wEViekLQyqBe
 ns9B9l+XWLpwZMw4xZiIW36VIThanLCMsl4bLLbTSxVyeF8+ruF95fiub5ClVtJFV33ez+EU++l
 HdkM9p+92fKFasrEEwhc4Qiat+mQ4WKLeBHtYXZaKw2oFzlJTGLM1u+zxhA87PPJnVDLl3r/cZB
 g9cnvc+IwQTD7/W8ixKa8s07JmYQuRmmtgH7xzXSkm918oquU72yFlTz4CLmNzuFGk/p7VBOcD0
 aTWpeiuiCXBSPw72n/vpivadBSNAly6RmbYER1LxT/CN+4PkY3YgbqPwn8nvdRtK4k8bHh6D8Y4
 QhmGod0k=
X-Received: by 2002:a05:600c:4e86:b0:477:9574:d641 with SMTP id
 5b1f17b1804b1-47d84b3281fmr68020595e9.22.1767871190890; 
 Thu, 08 Jan 2026 03:19:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPoG9XbQ2SOo4mCBQ8RgMOn7ebM2I8cNoHVqVeMnr0VrUcxu45vxjCSd9jLr0+AEVGBIu5Kg==
X-Received: by 2002:a05:600c:4e86:b0:477:9574:d641 with SMTP id
 5b1f17b1804b1-47d84b3281fmr68020325e9.22.1767871190494; 
 Thu, 08 Jan 2026 03:19:50 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm158526465e9.1.2026.01.08.03.19.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:19:50 -0800 (PST)
Message-ID: <7ea878f4-6eed-4f41-af8e-b4415379778e@redhat.com>
Date: Thu, 8 Jan 2026 12:19:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/29] crypto/x509-utils: Refactor with GNUTLS fallback
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-3-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-3-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Always compile x509-utils.c and add a fallback when GNUTLS is
> unavailable.
> 
> These functions will be needed in the s390x code regardless of whether
> GNUTLS is available.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Acked-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   crypto/meson.build  |  2 +-
>   crypto/x509-utils.c | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


