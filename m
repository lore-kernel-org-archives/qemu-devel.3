Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3891C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 11:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzz9-0005VP-JI; Wed, 16 Jul 2025 07:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubzuC-0002Co-A5
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubzuA-0004XI-OR
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752663749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jGVTYeK5G4is8onJQLWDyJd+BgOOUm4MTD/WD3pCaHg=;
 b=S6NSu2E3ZUiU1vL6yRQ7rgGIcaMB5C3bsasAHeCkFkve0bmzjNvzj9B4C9wgt14O5BSsNe
 EStzj434imC6J0tf/RdAds/52c3TF9QWsNtuoLCy2VGlEt3C274m3QFitiO3KuPDQWQiFi
 xXLwpWOSOK6z2Jr3Rrzq4LFtb41DkdI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-p-Y_AqWlNb-mMnwrZlsN3A-1; Wed, 16 Jul 2025 07:02:28 -0400
X-MC-Unique: p-Y_AqWlNb-mMnwrZlsN3A-1
X-Mimecast-MFC-AGG-ID: p-Y_AqWlNb-mMnwrZlsN3A_1752663747
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4538a2f4212so36731385e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 04:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752663747; x=1753268547;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jGVTYeK5G4is8onJQLWDyJd+BgOOUm4MTD/WD3pCaHg=;
 b=idk66YoTHQhlcthrQzjDIAqp/6IyZ3zDmqe1rjoIskJPyEPH0ySeowj+g4p670mDDD
 x0AWBCeekApBc3plKwzrUR2nL9m/mKdmqRy9iE4qAS9XJHdeGlsHZAPkXEgGqj7gVNue
 zLsV11qfSkcP2VuPlQ1XvYzNBjixEeIxdDvI4VjNYfiRnPx3q9n56pTQVOaHjgY/wcIt
 +4+hGHuJZW5GrWmtjHvP+pOymwehS7E3szLMG6zUVDdO3OMOd8kB3sBpXd70cJY4maCK
 6BFdK8Ua2pPEmotR5Ujema3N7i0rdB5Af4BbM7gmJBSJ3Mn1ysOCQUl5+R4xUaQYfvdF
 78lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh3PBsb4GNMR55HRIItrOHJvq1whzoA60C6xdPxE1IpHaanLMptFwrAARRsE3DeTWNM594TGqnBhYC@nongnu.org
X-Gm-Message-State: AOJu0YxYzYdtVkyYYyVCVc9Sg3vCllN+3PBHLYz46nljSIcsjLnWfvMx
 tqREny7eMzv6AnUZV1JlO7nLmgOjvgeAlrhpezO8Z1NmF4mmlJ7j3tBU9jwQ1D2BTJ7rjt/JkPz
 Ha9c09c3r9U/3Ai9J1iud6UELM8dN+s5J3TvNmCcCXanEKvVREeqz9Mb0
X-Gm-Gg: ASbGnctDCstGD5yqNo/XOdpybiHqGcfpg4jQXfyv4gEalwUGenl50CWI2/FSOZ9UXeD
 bQbyde3vkdhdXnVpC/xeddI4JKRG7wUj6DwyPR94NnPfcR9T4/8+F8vGwPbQZyEKTI4EaHHyGBp
 ZTU+8g7NfIAbDNHFC4p6QdMndFXzi/pU+W0if0TsRwz1Sm8xyeYQfjUn+Nd7A8htDOCS6Tpa8oI
 jYECPO997McUcr+xocPg87tt/Y0tL94LRx6gyM92M3bCXx/AmdsCdfr9st3wSJql+fB7btI+Sbw
 ECYVGUagxaRVQNWS08ygd017XzSmyayKADrLmHrvsiEWLnaQOnlZCxmnQMFRmgmNF/oQLhtd5ML
 TabIw
X-Received: by 2002:a05:600c:608c:b0:456:21d2:c6f7 with SMTP id
 5b1f17b1804b1-4562e037079mr21744555e9.23.1752663747149; 
 Wed, 16 Jul 2025 04:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEyUZ0jct5EZSPgQ2YWuePtY7X4xZmJG/NYO9xGOB9htZp/p7Tc1mZdf3Xg5YyQN6rEUh4GQ==
X-Received: by 2002:a05:600c:608c:b0:456:21d2:c6f7 with SMTP id
 5b1f17b1804b1-4562e037079mr21744125e9.23.1752663746663; 
 Wed, 16 Jul 2025 04:02:26 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-130.pools.arcor-ip.net.
 [47.64.115.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562f7514afsm12949905e9.8.2025.07.16.04.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 04:02:26 -0700 (PDT)
Message-ID: <381ee2b8-a6ab-4770-aeb6-c1e83d2478ef@redhat.com>
Date: Wed, 16 Jul 2025 13:02:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] docs/about: deprecate add sparc/sparc32plus-*-user
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250716105414.2330204-1-alex.bennee@linaro.org>
 <20250716105414.2330204-7-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250716105414.2330204-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 16/07/2025 12.54, Alex Bennée wrote:
> Even with a toolchain *-user is still broken. Maybe we should just
> deprecate the target. I haven't deprecated for system as we have
> functional tests that work and will continue to do so.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/about/deprecated.rst | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index d50645a071..c2199129d8 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -267,6 +267,14 @@ known-good implementation to test against. GCC is in the process of
>   dropping their support for iwMMXt codegen. These CPU types are
>   therefore deprecated in QEMU, and will be removed in a future release.
>   
> +``sparc`` and ``sparc32plus`` (since 10.1)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +Without regular testing these targets have bit-rotted and even after
> +scrapping together the seemingly last packaged toolchain we can't
> +generate binaries that can currently be run.

I think it's fair to deprecate it in this case. If someone wants to maintain 
it, they can come up with patches and we can revert this patch. Otherwise 
it's only dead code anyway.

Reviewed-by: Thomas Huth <thuth@redhat.com>


