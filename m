Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17254CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEO2a-0007ll-IZ; Thu, 30 Oct 2025 04:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEO2Z-0007lF-CI
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEO2S-0004zL-2W
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761812982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u+XakWZqWO2q4rnbaFIdBjPO6h8waqIqnzqZGe2qrSA=;
 b=XHGMqNEo6SRo8Y4KdKv6iXAEeWjchUJMLW1Fms5hbPiAVwMPFTNUX6fqrGSROsHuIAW4rC
 7vC3p8bCQE3rPSMnOPpDfl1k9Xekyp/ZZ0G+SnqLzegcrHGX5ZRQrwbfVNtv7Z3Hebhq56
 vIaSl1FRHPnP7c4gC8PmWt+vZtGEcac=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-yBo6pf3oMDyTFpuRmmFXIA-1; Thu, 30 Oct 2025 04:29:40 -0400
X-MC-Unique: yBo6pf3oMDyTFpuRmmFXIA-1
X-Mimecast-MFC-AGG-ID: yBo6pf3oMDyTFpuRmmFXIA_1761812979
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429893e2905so933960f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 01:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761812979; x=1762417779;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+XakWZqWO2q4rnbaFIdBjPO6h8waqIqnzqZGe2qrSA=;
 b=xD76xKHp16VKuZfGWg41PodrNAoF7tEWENdDxGslZDg3XSVFZ1gopzk5nwcpBZyF7s
 YDjsp98hvMSZZ9bN+rLqhm7KnJYFCTtdB2ivBqdXO+k6Nca3Fz7ZJJvWuip3KkpmX96U
 rD9JaPf4YIj3BuhLra8ASpKEpA+WqzeNC77+Uc9XWNhmBCWXZ+Hx3qoGy/vy5Z91ZlDb
 8zg/EI/mg21tyXwTFIX9HyZgghFhaHMP8jZQN238p5hfOA2fZ8MW8f0HBAz1k3+je0Jc
 veB3uMfdG5lzmy1/vgp6pRppkHrA7jcgY7lxv6CfQNkHuzFTuQwLtd4kulnTKSktBjPa
 Vyvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcATEsHl1Y4pVeBbgHydOVyvq0JXl/LsLFLZ8d+HRc2j133wCkKbLruJCTRadzXWbqVJ2HhkbEgnEe@nongnu.org
X-Gm-Message-State: AOJu0Yx2AGieMCKh13FlNsXhj8dNN+JuARh/EcgkCpU5tpE2IP5bVuRl
 xsFaSOWVAgu/92VVNvPnQl8i2lmOl1/5c/9mmKJRjI1TycfK+ou0YuVHQrzXKiVUMwAuIIhQbQ2
 do422prabNdNxQrUx0mZ2LxdTzXbGfQ0Pqf4jcF1gT4axE+LXFCJA/4q5
X-Gm-Gg: ASbGncs+GKpsb/acU1PvqYCoJvX2ztKEWoijZRFUTcr4F+mQ4skc8F7rHYeYVhAYFnB
 lObSFeNRTVWggFDnYHsSlrmEMO/AIAIn7mMQbk+Wu+9O+2zo+fjg1ZkCR7Mw/rwqVPWYCxNfDWf
 OQ35PzAwI+NGQ1yihx0TXTA+bvpxaTuNhKd74nMQU3KFZbxbngtPk2BEqPrJ+C96onptu50h7ly
 HTOFwXf8JfoCj8nHtjkb1rRsqV3oXDbycNmVQEXFMs/UDDioMYsuHFFsMkZJZ57vNzuckOi4aHp
 i8x8qUsW8wXRBlFC8Qy2fwQ9LhC1HlQ1EhPHAvWzcsO2NErHX7j2ShhQXWYh9GxVWT632BA=
X-Received: by 2002:a05:6000:260f:b0:429:b8c7:1817 with SMTP id
 ffacd0b85a97d-429b8c71e1fmr681540f8f.30.1761812979216; 
 Thu, 30 Oct 2025 01:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm7zWtir7Pmm1ce5EAUE5V09Vj3lQ3ip1kw/stZ35p3jPKvLE3DUinefP0h2RYm854Odx1WA==
X-Received: by 2002:a05:6000:260f:b0:429:b8c7:1817 with SMTP id
 ffacd0b85a97d-429b8c71e1fmr681511f8f.30.1761812978529; 
 Thu, 30 Oct 2025 01:29:38 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289e7cf5sm28240625e9.14.2025.10.30.01.29.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 01:29:38 -0700 (PDT)
Message-ID: <6d5432b0-8156-4e26-a65e-04471e3b36ed@redhat.com>
Date: Thu, 30 Oct 2025 09:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/10] python/mkvenv: bump 'qemu.qmp' dependency for
 testdeps
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20251028220342.1407883-1-jsnow@redhat.com>
 <20251028220342.1407883-5-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251028220342.1407883-5-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 28/10/2025 23.03, John Snow wrote:
> Firstly, there is a new v0.0.5 that should be used instead of
> v0.0.3.
> 
> Secondly, the use of a period in the key name does not behave as
> expected when installing and checking for dependencies, so use
> underscore instead - which does indeed resolve to the same package.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   pythondeps.toml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index 98e99e79005..daf5a18989a 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -32,5 +32,5 @@ sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
>   sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>   
>   [testdeps]
> -qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
> +qemu_qmp = { accepted = ">=0.0.5", installed = "0.0.5" }
>   pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }

Reviewed-by: Thomas Huth <thuth@redhat.com>


