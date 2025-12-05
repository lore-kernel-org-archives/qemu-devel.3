Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE13D2E009
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRP0X-0001wO-QU; Fri, 05 Dec 2025 01:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRP0Q-0001v0-TY
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:09:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRP0O-0005iZ-CB
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764914963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MKKEdbIqPZmTABUq5vHo6Isi++vAeukgQQUDeNULi0c=;
 b=huhjGp0Op2dogEFM3Q7tCAOijk9G2PuHgW5uxroHAeAo+wpPxz81lyBcgOnu18cRWrc9IW
 4rXu60VuVawPa9DvlVILKD4ieWQLH2VwphodWfO7sBODqXQlXT5Bgxrstuf7rRj6KyX7cq
 Ow2MYI2y4PDtKVxWoKGd9Gah/PXFL4E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-vKM9bLBMNwqVvjWXjNXBag-1; Fri, 05 Dec 2025 01:09:19 -0500
X-MC-Unique: vKM9bLBMNwqVvjWXjNXBag-1
X-Mimecast-MFC-AGG-ID: vKM9bLBMNwqVvjWXjNXBag_1764914959
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso7272015e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 22:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764914959; x=1765519759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MKKEdbIqPZmTABUq5vHo6Isi++vAeukgQQUDeNULi0c=;
 b=H4MSOngXsH/TmPB8ZPcjuJiesVopPyL9EEwoSUqDJteaTiOyXTjjHA+5I+t0FHGOWk
 ViYZ4WjQRtN6CkNM/JA7tpdU9fNnWC3BgYdL7DvRWLZ2AhX86fZ0aLeooo9Gz8kYiy4d
 HbV94Z3ktx3kUaEp4n53x9P0kr16KKhaqXwSWdo6kwn2enZHprIPkUgrwtJZdTfHtLj8
 Ly5o12MN2KeLfaBsiwg9pcDvMmkXOn7Sn3vMh5mIxgRcjkNCNboXNcV9Qq9sZN3lvVZx
 w58Isrim+10jkAtp+2zt42cktbk0H1NFqV9wIj+84/9mLCg4p4UxAQHm3pTxSTAA6izP
 xDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764914959; x=1765519759;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKKEdbIqPZmTABUq5vHo6Isi++vAeukgQQUDeNULi0c=;
 b=BNUPR53hi1zMeOg/upoErFH9V0DARn+6hv7xup7K2n49p5MHWiomMEbijyyskrCcSY
 2PPuaUjOwotSCnXssE6+GokTGViojjzn/sDwqVWiuNyrKugoO7BO2JinR2dkFbPwHlOA
 iRyqVrjIpSN49ohNYQV72Vn2rIp9UIorrkZ8OrrLdxMd+y4kRn2RofdgKr3aPNSOLrbx
 RGxfy6STzHLrLe+ne+7HOCRyICmaj0hfsxyTOeHipw7M0ld3A2mno9jFgtFIRvWS+kCh
 mMvC8JKeG754eJyg0oo3JQFtE63I/hAtB5tphbb0XWrqosUdwPl8SM/vY+ZiMHMy1EGx
 dCKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVid8IxllxRhHTZqQa50DUOxcjLJ2tXxCOH5mI52dxGzFzUwg0opdMOXy5inofnZ3bFcv6KUE+kwgHW@nongnu.org
X-Gm-Message-State: AOJu0YwohdWWrzO6kzKnPxthhFPJBLd83MCld/+vdqITPFBSr0aMK4IC
 ZKM6S+Jzy2qu05tN2VrK94p3oB0tk+Fe5W31VMdOeALebLnDDzNbGbAEn5efHrnGa+i++8qIsAL
 YshPquLh8FrA2ECFfA0Gq5/fxlikPyGfdUt4i0D1dVkE1e0XI09VpqPEj
X-Gm-Gg: ASbGncs96TEHblPZvPPeu7bsPAdg0KKWJFzu+46IoeN7oyaGjXJElfvPabENM/5ryRA
 ocXhb84aC6NrNe3Hf36JYPp5WlDUaae0dQ0PS2t55Z6qLE2ZgLdInm0JjvTAGw8MrnbmpIhm7Ha
 luJPSWpoSKHGYdbPceN/nBbOiiMzfy+/susSb8xVLAR2OtM5iBTrc8hUZMvEdlggQBjXIfliXtS
 8M/jdHMPK8jiGlYDggcilZtNhdDt5KOrRcprL7dTP4FXPd1nTcFdu8WAqD6D6aMMl1+RtvvR+i6
 Pc1qPNrU1FbrOvmLaBvO7qgOtvRwKhC8EHEnRZBivm80Ic8lEAZz+JoIHGCe5aAyQi+vqgnq15/
 ovDgG0F4=
X-Received: by 2002:a05:600c:1e8f:b0:477:9fa0:7495 with SMTP id
 5b1f17b1804b1-4792eb47356mr51577575e9.14.1764914958788; 
 Thu, 04 Dec 2025 22:09:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8X4TaJVAejWmksHlYkALy6RmV0je9c9EPjRdM7XBhaxAKtmOCkK4nhmvpbpDgQqXw0opTDg==
X-Received: by 2002:a05:600c:1e8f:b0:477:9fa0:7495 with SMTP id
 5b1f17b1804b1-4792eb47356mr51577355e9.14.1764914958437; 
 Thu, 04 Dec 2025 22:09:18 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47933aef61fsm30312025e9.7.2025.12.04.22.09.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 22:09:17 -0800 (PST)
Message-ID: <3498ec70-4114-43ea-938e-8c03971a3e5f@redhat.com>
Date: Fri, 5 Dec 2025 07:09:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] MAINTAINERS: update the custom runner entries
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
 <20251204194902.1340008-11-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251204194902.1340008-11-alex.bennee@linaro.org>
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

On 04/12/2025 20.49, Alex Bennée wrote:
> Fix a number of issues:
> 
>    - update the ubuntu references to 24.0
>    - add the s390x and ppc64le yml files
>    - replace Works on Arm with Linaro
>    - Also mention IBM (s390x) and OSUL (ppc64le) as HW hosts
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d007584b476..63e9ba521bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4444,12 +4444,13 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
>   S: Maintained
>   F: tests/tcg/Makefile.target
>   
> -GitLab custom runner (Works On Arm Sponsored)
> +GitLab custom runners (HW sponsored by Linaro, OSOUL and IBM)
>   M: Alex Bennée <alex.bennee@linaro.org>
>   M: Philippe Mathieu-Daudé <philmd@linaro.org>
>   S: Maintained
> -F: .gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
> -F: .gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml
> +F: .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
> +F: .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
> +F: .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml

Reviewed-by: Thomas Huth <thuth@redhat.com>


