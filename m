Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD05CF6AB6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmRC-0006Ms-NR; Thu, 08 Jan 2026 04:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmRB-00069g-6m
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:36:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmR8-0006Mx-KB
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767864969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JmYlzKDjfEESRc2s5U8tv8jTD9a9Di17LvPWIzjMs5k=;
 b=DCGDxc3G4E+oKlQLS4oQYQb5CmCd30QE4pg1aSUaRIwY57Oe8HS06Fu+h4QtcHAXFdY1AF
 ei+cmwGkveUNyt+7IirY2VD+k6qNjw71iWmA0SvxxTDCKyJde3U1rq+Kbd3ddSCuZNT0d4
 ZRnRDVekYHEkXbRn8jTZHO+6K39uKhQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-PO94BN_ANrqzOaUgLB03Eg-1; Thu, 08 Jan 2026 04:36:08 -0500
X-MC-Unique: PO94BN_ANrqzOaUgLB03Eg-1
X-Mimecast-MFC-AGG-ID: PO94BN_ANrqzOaUgLB03Eg_1767864967
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47788165c97so18156655e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 01:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767864967; x=1768469767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JmYlzKDjfEESRc2s5U8tv8jTD9a9Di17LvPWIzjMs5k=;
 b=PabydfINAASMx2X0fkXs49LX/yzUXDcs4d4+rlO/RYsaHztGIafcxlxiQ7U21L3Kfu
 CIeJEBIpMcP2JdfDEMshr429f29vo0Iouhpo3gk9++9dmvYxuriBBOqU0Z2oLaJvbZj6
 Yl8ZfOCffoRNTOAEmxMINQkkZHKi7WwVqstZPZoJLkxXVF3L/YSpbNIgm291aM0y59ZQ
 OxHzwDw+xya6biSwd/76edeUWt+TJeGXESC4M5yqKUKDVmBdl97l8amADfirRlE9uVmj
 u7d5vO1R/lo84z03gtQFBPxWAYZ0fcWNxWw03LWRhBpRZgYfBy+4UX5I5ZxYtsZzlypz
 N4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767864967; x=1768469767;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JmYlzKDjfEESRc2s5U8tv8jTD9a9Di17LvPWIzjMs5k=;
 b=mzAx++tat8AX8m+uFWplMbBcq5PLZ66D1qtnwnGaAD7NP4shgGToE51D2ReiTyfzL7
 YSgrHCvhLZdJocuIWK6fg/hX6+TBB4saWXX/Y/Te5hwwaO/FOmj3NtJ2JzlHMi+mEbaj
 wOsbZvTpCH0lgFE5SwK3YG2SNKM9yDD23fdX6ez7etRpP2mt6gKtli90gGu34fNmlN4d
 QCbh3TWITglsHb2ZXOMSMyP7a5tTfHgOOv/dup5Mhle7cNYNWsERVeC+GT4k92b6vlF/
 /lo85cWdWQ4yPaJcmGLrT7kZhD1lcz9RXio8TOS0LjBMolG2vjKpS+3ye6hQdMQZ294V
 NHTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdD1FlYKpzA0pJHVWcidaBMNio7sK+WpTyj6GrZqh8LPu4xmRN/zFsomw4RGb8o7bx3znnmGx7tKqX@nongnu.org
X-Gm-Message-State: AOJu0Yyl9x0bYMQvAdTGGZ2yd8KFOZ8xMc6OGrJZ8n01xbxsKlu8VEBr
 5Ov8NGIYT+Oths9xaPp4/I+296ucEGUvkBmPQBs8AkaWl4LSxxkAxi7U8DRM9xy+XN6OA1IVSpV
 J40vsNu/aA+IIsEHJbHOwixPdHlbAfwmrlId5WYu9DTbBBDsKwymGwwsV
X-Gm-Gg: AY/fxX7yOcs4ixGzaml+MzvnAdhtJhlkztdsL+zFuJKdrJpZgtqtvFuBmEM/Dn05M8K
 wd25XoQtSroD/pPtTL9yYMaUplRDF7CYY/nB9BUIR+VYsQrgkUU8ep//4eOPltYwggjhHFfEWEr
 jwXAc/iG/mUCg0M8oXfp1i51MLIFs8R8uAOSaDppeUdsOUYTPG2p/xsjRnFyProibuQbPozcjmO
 QZzR6/IKAQ10myDWdfBK7r26cdFW2DBWSc99hrVZolk/HCkLQVEj5DFT2r+9RlKeiarqPCs57cp
 sNbJ4+BN9PAJh/hQbPsxzo0zriq1BCTqhIxZxubx06CRBZ+kKuL8VBxXafe4v7FWxKFcKSiC5wJ
 PFhAAoiE=
X-Received: by 2002:a05:600c:1385:b0:47d:4fbe:e6d2 with SMTP id
 5b1f17b1804b1-47d84b2cd6dmr63152665e9.12.1767864966948; 
 Thu, 08 Jan 2026 01:36:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJBix0dHy+9k7RY9ECRzEi63CIIwOljTZ+IKi5V6FFtil2nXvJz+248EXbxCG0ZIYLOWY5rA==
X-Received: by 2002:a05:600c:1385:b0:47d:4fbe:e6d2 with SMTP id
 5b1f17b1804b1-47d84b2cd6dmr63152415e9.12.1767864966565; 
 Thu, 08 Jan 2026 01:36:06 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653c78sm150791245e9.11.2026.01.08.01.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 01:36:06 -0800 (PST)
Message-ID: <3d976f15-c7ef-4575-8166-99993ca6f571@redhat.com>
Date: Thu, 8 Jan 2026 10:36:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/50] meson: Reject 32-bit hosts
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-3-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 08/01/2026 06.29, Richard Henderson wrote:
> 32-bit hosts have been deprecated since 10.0.
> As the first step, disable any such at configuration time.
> Further patches will remove the dead code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/about/deprecated.rst       | 29 -----------------------------
>   docs/about/removed-features.rst |  6 ++++++
>   meson.build                     | 17 ++++-------------
>   3 files changed, 10 insertions(+), 42 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


