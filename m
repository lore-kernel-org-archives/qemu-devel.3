Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E468CA0ED1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 10:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umVCT-0000Qc-EM; Thu, 14 Aug 2025 06:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1umVCR-0000QM-FP
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 06:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1umVCM-0005wC-Oy
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 06:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755167319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/Nef3vwlqlvhT6J7/pqXKoGpjz7bM1Bz+/+k2RMhoqQ=;
 b=c6tMcQaJR1FOsRxEd0bSGSDJCBojxO8Jbo7TSJ7nbf/7y8mH8eFlhxpHB3NuAPeRm1R47r
 QdRDP2OiHAlieOUs4+Km5cYoSoOU/6VB/m6smyRtCpTapAdox4KRuOl9Uo0OyXgM8+QKv5
 vwYlEPTaG1on8bPlHTPTlfdZ1llQc68=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-HCOLe3d8NeCD6s6ayaT9TA-1; Thu, 14 Aug 2025 06:28:38 -0400
X-MC-Unique: HCOLe3d8NeCD6s6ayaT9TA-1
X-Mimecast-MFC-AGG-ID: HCOLe3d8NeCD6s6ayaT9TA_1755167317
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1ac1bf0dso3874225e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 03:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755167317; x=1755772117;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Nef3vwlqlvhT6J7/pqXKoGpjz7bM1Bz+/+k2RMhoqQ=;
 b=OprKgjDFsmyL8Z+v9Pw273m9o69UNz/p4lhAHurPbL1ToBIgealWvareuDnILPswAO
 OrE+3RFhCshCNEzXk/PwUUskTF2iTuMwBEraHf3wACKBLk9T7IawwxGz/Bw/kVf+TtbP
 8RJYePMfsGd6OKU/3bDWrrVXHmYAZIlajPpPLyEcZ1+rWs9sr7axt90uobY8Neg3a60M
 awg6FgovDhK/GRH617I6ptLxI7mRxlCr48Yv9zh1LIxAvl9/nE1wMhaUYhNOCEOVlgyp
 XAXYtqqCQlQIMX2eN3eijDOxer07a/IRNaJlJdwCqN+TMYMeGMEMk3YqfAJnMobTUM9J
 6IJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgZNCiU2Ly3tdl4NieonSL7J1mZGW9r7Ciobyj9Y2z2w8Ct+aySETxGB+MoGYupwfIWKZxmjVQZREE@nongnu.org
X-Gm-Message-State: AOJu0YxNy5u3Ce8CzN/IatOvtXmCqolFpWZEY2+FFdTgB/WFys7fVc9L
 cELvVnScFmzWPcR3pXmMwDEJSub97h6oai3caOYHWdHOP8Ma+vyl4fx/5k74DETv8kPQHpqGm1+
 dPlIqHCh3Z9b4LjV2vNKBaNmmrDQzIqnJ2q4mJE7oYDYOrI/TLJzyHHMx
X-Gm-Gg: ASbGncs6N87JHqMmCgvlvz5VZeVZ2ScF+WijjmbwXiHfa1/eFNHmp42uT2sKRUyWjwI
 4kNMprnOLnFNziVzFgIa8V2K+c559PU7c4tN1OBS1KJDm4FnQt2ieRYL5oEwfvysBVcWWn6R8ep
 fm0vCam6akuCIbzsBS2FHns3EgO4vwcZqqKjcGxhiri5rkWXs2O2yhm6qM8kL4CZEQ+1GBhCI89
 uls9iTiQ+pkXS7I6rb3b3GIHEOz2cPSsDuIAJ/SDxi4Dxbr/RpROy6YgEbe8VZbqwvwNvg3OZyd
 A/w0IDpvpy/kK4zQSimQF7PFCw==
X-Received: by 2002:a05:600c:1e88:b0:458:bade:72c5 with SMTP id
 5b1f17b1804b1-45a1b79ddb4mr19477065e9.8.1755167316692; 
 Thu, 14 Aug 2025 03:28:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcbzSY8DrJEIF6+0qxFWOfnXP1YANpkTg+PHRZgfKeATN24tZkw+uT1JpRLj/A8TrXR/Zb6A==
X-Received: by 2002:a05:600c:1e88:b0:458:bade:72c5 with SMTP id
 5b1f17b1804b1-45a1b79ddb4mr19476795e9.8.1755167316295; 
 Thu, 14 Aug 2025 03:28:36 -0700 (PDT)
Received: from [192.168.178.61] ([151.36.180.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45a1c78b410sm16613965e9.24.2025.08.14.03.28.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 03:28:35 -0700 (PDT)
Message-ID: <b1093581-fb6d-4e4a-bcac-da9793f3df77@redhat.com>
Date: Thu, 14 Aug 2025 12:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/loader: Don't update kernel header for CoCo VMs
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Vikrant Garg <vikrant1garg@gmail.com>
References: <20250814092111.2353598-1-xiaoyao.li@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250814092111.2353598-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/14/25 11:21, Xiaoyao Li wrote:
> Update the header makes it different from the original kernel that user
> provides via "-kernel", which leads to a different hash and breaks the
> attestation, e.g., for TDX.
> 
> We already skip it for SEV VMs. Instead of adding another check of
> is_tdx_vm() to cover the TDX case, check machine->cgs to cover all the
> confidential computing case for x86.
> 
> Reported-by: Vikrant Garg <vikrant1garg@gmail.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Applied for 10.2, thanks!

Paolo

>   hw/i386/x86-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index b1b5f11e7396..7512be64d67b 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -952,7 +952,7 @@ void x86_load_linux(X86MachineState *x86ms,
>        * kernel on the other side of the fw_cfg interface matches the hash of the
>        * file the user passed in.
>        */
> -    if (!sev_enabled() && protocol > 0) {
> +    if (!MACHINE(x86ms)->cgs && protocol > 0) {
>           memcpy(setup, header, MIN(sizeof(header), setup_size));
>       }
>   


