Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA00EE208C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 11:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voK5P-00089c-No; Fri, 06 Feb 2026 06:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voK5O-00088G-0R
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:33:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voK5K-0001wV-Na
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770377592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XuDlngJyqaWKz2GLSfvasgIf4P5mMqOtU34ZikrPYdY=;
 b=YhL66ms+Wy/SC3LvWVtcGzY6eKfdA8F7sVVwMVbYWXwajNZvBTtdZkzsxGg+x5T//c70cp
 sOH/p5DFvSC3Kx+SmGtDUVNpfGV18U6WP4llah+OwCIXMxBrLceXl930Tt9cqdsm1Jiuyn
 72DNtfTIT8XBErQ/8gky6KjBDpXms48=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-53qLXgZNMUSG0lTozZA-Ew-1; Fri, 06 Feb 2026 06:33:11 -0500
X-MC-Unique: 53qLXgZNMUSG0lTozZA-Ew-1
X-Mimecast-MFC-AGG-ID: 53qLXgZNMUSG0lTozZA-Ew_1770377590
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4325b182e3cso1762600f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 03:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770377590; x=1770982390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XuDlngJyqaWKz2GLSfvasgIf4P5mMqOtU34ZikrPYdY=;
 b=pAsoZzl/DK8CobPnLpmrUBpAXExRNrXIC9UN4qPA9eDlCxFM7Rb6TZrYi4Hni8AZke
 rOLOM+p+4oQ/877MnzghAbs1IJrfUYVz0dqwNuyuLRetrBXlPVbGDY9qxcj2MK5Ypafc
 se8maDVCC5IzbHXHEeioB1LyzqR3+PEBnFSbJTYxEGg+0X4L+LSPWLsmyffj2Qdb6781
 eLoBImZU371DbpKiP/J/QdkkgW+y2YAkmvcpgXE44CCET0rKbgAUqQv8RVleP1dRl7GM
 ZHfTmI6MEzDog6572SgZrITjukmU1jdUNFyfXsGwRAjM1DyJ3InVfRFwrgsqw3ePupEV
 hvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770377590; x=1770982390;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XuDlngJyqaWKz2GLSfvasgIf4P5mMqOtU34ZikrPYdY=;
 b=dj7BU3rq/RvYsl3U2XUI5lUcKkH90ne8eZHDB4NgqP5rVQQ+Mu9QzrEye/SPcw04LQ
 OFRiHFSa34V02h/uzhyJgXqF//wNVAPCIXlsTw1xeLq6A84hMedt0XDrjGHJceA7mw0r
 AytvNMG4GKCl0hc/kV1cuxJyAH2LO7f235Y8MRVpC7pamuJtsm6ciha8Ih1CkWR+AACi
 AjHxzsoyjS7DXciNtgcRy+wMviy1+QckTCxicmyeYoEWiZe4g2FjDk8CBVHMMaEEbXL4
 ZItiPu2lA/t1/vMk79KfAqDPAVNlbvrB4tHscpvcr9iuGYu80si0rpKw+SRzL9p2lIeM
 3HTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjm2zuHmFP6HQo9IjuXNtHG0QW/VH3eXD5DTlhofqYFk2XId3ye07yfalOBgOO/iByEijm3iShocZR@nongnu.org
X-Gm-Message-State: AOJu0YyIJfoOfibktzUMAsSWOla76RD7QoyKJ3/Eplw+xOqqBfP0V7RB
 +YN2+zcRlH+jeBXKraBJfmY81o+jKJ5ua885hfaxAd8Yq35lx7b79kvD70fPSQ28JWrsmRV929A
 XCViayfIR8NXFzW076/n7x/wXuYhsCSH15Ol3c2BwlXIUrIugjUAlITee71bWCOBK
X-Gm-Gg: AZuq6aI5FeO8l5xXW3sFcaE0pIfD+YE+SafK1kgt+erpX4ETTU70EpJRiHhJlzf8EBC
 u3afIHpKBGZ0/fse0qWuXgMC9ee4sr1NpWj9jcEq1fbDmSqpYdFU+VE/poTnlJtSUVyv5vgSY5U
 5isYydkc0g+Mq1ygNJejTLBQDVt4uxTks6MwlZhAsUra8UIa1wZc3kWKRmnEIrfKW1wI7QFtB2b
 nv4knultb4lB2BYy1hsOEE2k4BUG6vD+SgPfzca3zt1Zw2LYL3tDTcGW1FbGyU2DWxS7gMZ+Uc1
 GlUKEPZfVP4GnrZ4Y6zyxg7ZF4CXSWRAsYpCjQNYsahhn0tbiY9BL3/qiNbUejWpBw7zTAifRKJ
 gTgP0iK4=
X-Received: by 2002:a5d:5e01:0:b0:436:1a4b:de36 with SMTP id
 ffacd0b85a97d-4362923f28bmr3765463f8f.22.1770377589948; 
 Fri, 06 Feb 2026 03:33:09 -0800 (PST)
X-Received: by 2002:a5d:5e01:0:b0:436:1a4b:de36 with SMTP id
 ffacd0b85a97d-4362923f28bmr3765419f8f.22.1770377589435; 
 Fri, 06 Feb 2026 03:33:09 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fb81sm5583092f8f.20.2026.02.06.03.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 03:33:08 -0800 (PST)
Message-ID: <7985f32a-deed-4b07-a070-80a3a2791eb5@redhat.com>
Date: Fri, 6 Feb 2026 12:33:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: fix bash-ism warning for configure
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260114101525.4039244-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260114101525.4039244-1-alex.bennee@linaro.org>
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

On 14/01/2026 11.15, Alex Bennée wrote:
> Hopefully this makes the meaning clearer.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/build-system.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index b9797a374c7..35c77343914 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -66,7 +66,7 @@ Modifying ``configure``
>   ``configure`` is a shell script; it uses ``#!/bin/sh`` and therefore
>   should be compatible with any POSIX shell. It is important to avoid
>   using bash-isms to avoid breaking development platforms where bash is
> -the primary host.
> +not the default shell implementation.

Reviewed-by: Thomas Huth <thuth@redhat.com>


