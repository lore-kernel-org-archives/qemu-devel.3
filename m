Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E69CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEO1u-0006ys-7e; Thu, 30 Oct 2025 04:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEO1q-0006pV-Lu
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEO1i-0004sH-PX
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761812933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n0Z7rn/y1g+2k8a5Vt7pM7Q5Uq2zCTYXbxsAwh5DW7I=;
 b=FmFkOmbPfO3GMJyB/XcUrxeerARNJZnszZA1np00I9Bz6S3u3tM7ge1X2JYseHCd+a1wdr
 FjMym52cpOamhqs/3z7irNav19n/whsM6T6nJSctiFinhJ4I64sdJo32GZVkRdTeKjUFca
 T2/MMn4i/QaDiGdQROUdnOld87/rBlU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-ScqQc3d2M7GTIEXEzT1Qjw-1; Thu, 30 Oct 2025 04:28:51 -0400
X-MC-Unique: ScqQc3d2M7GTIEXEzT1Qjw-1
X-Mimecast-MFC-AGG-ID: ScqQc3d2M7GTIEXEzT1Qjw_1761812930
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-475ddd57999so4910005e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 01:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761812930; x=1762417730;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n0Z7rn/y1g+2k8a5Vt7pM7Q5Uq2zCTYXbxsAwh5DW7I=;
 b=euvGDa13J/417aj209JDElBR8pEpEiDCAPfkVBq584oca1h4XzY+x9huQvtlBL6tpq
 MFr0rzrWcm8kxWCv/Pw6C8z7kb4NLqcrUgYReKSep8v17jy2coEsK4gfcAeCcLmNPR3M
 QXPyP2oFM2ERTmo1mZTFFgLaxxmzrE2bjOjPNKGN9s6/Hs1Pf6++UwftSeChRLOjso9b
 gqtZqTlzIhqHAB1kxpEvEz5XNUH1fTYLxq8WvVngbLguIE2OVEps0NqicHpNH/5Sq76k
 CJUtQyaa74gCnfcXO9GDxI3cZOWRfL1kzIkkNWq88RJHd1Qn/AHCnaLpzy+XYcXCKr60
 Vhxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfYnVmkGu0nVA4OxIfyIo0BkID3g2GVbJWFBzxy2v7OC0u9oNF2449sULhfTkKiAbChx+NJSDjktxm@nongnu.org
X-Gm-Message-State: AOJu0Yy4tuRvufdh9iEwg4zasyiEMXhXz5vnmhkNpoCy9T9kz7VAzeNg
 upEp1Ef+zG7aISuEExw2PB7sF4D1i8bxLS4CgubBwclupp5Lang5qq5qMGM6kqqg5GwJ4Di9v1z
 RPRLzm+zCshP4qeQEveX5rpnJfuShmEvq5XW37ky8FYAUU2Z2899aHkgi
X-Gm-Gg: ASbGncuaX0BznPyJ9PYrDaBfjKoTKAuvuzTt0gGM143OphL5ZVM3GqBMjNUBoOpBKlo
 LsTN4XeMHl5FB6v/sUo2yvDQswA3UsAA5kiKB/AzK2bja7h7laG51m+y/6eZScBhSLbAHD67qRt
 nn1MQgFNzp00Jm/RK3vVPIcwX+GEPE6PInGo8vDcWYO4RSDCBczFYwz2hixG6gYymPcck2w1vyM
 HzwEce8JCPr/UmXaVmUhQVf4OooVb0kErfa4M5chNFH3TaWye+XnlLPEj5/IPsPeAj3r/EDuT9G
 JoMCMf+DWFgd9VPyjqyK6LnsR2FkA+fiIT+yebe+SMlJgOwT9OBqXmIrWKkRoIMA2T8747A=
X-Received: by 2002:a05:600c:1d29:b0:46e:45d3:82fd with SMTP id
 5b1f17b1804b1-4772682d5damr21625465e9.31.1761812930100; 
 Thu, 30 Oct 2025 01:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG88jgYWEGjBNITDnI/ToLMman7XhCv/HoiRHFrP6xeZTmgtZce0Wtv1vhy7vIsZ6oTO7Mbkw==
X-Received: by 2002:a05:600c:1d29:b0:46e:45d3:82fd with SMTP id
 5b1f17b1804b1-4772682d5damr21625125e9.31.1761812929675; 
 Thu, 30 Oct 2025 01:28:49 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7a7csm30822510f8f.8.2025.10.30.01.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 01:28:49 -0700 (PDT)
Message-ID: <de0c1bf7-7ae9-4087-9a33-ea96d1fa6db7@redhat.com>
Date: Thu, 30 Oct 2025 09:28:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/10] python/mkvenv: create timestamp file for each
 group "ensured"
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20251028220342.1407883-1-jsnow@redhat.com>
 <20251028220342.1407883-4-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251028220342.1407883-4-jsnow@redhat.com>
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


Missing patch description - what is this good for?

  Thomas

On 28/10/2025 23.03, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/scripts/mkvenv.py | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
> index a064709e6ce..a22e3ee3394 100644
> --- a/python/scripts/mkvenv.py
> +++ b/python/scripts/mkvenv.py
> @@ -838,6 +838,12 @@ def ensure_group(
>               raise Ouch(result[0])
>           raise SystemExit(f"\n{result[0]}\n\n")
>   
> +    if inside_a_venv():
> +        for group in groups:
> +            path = Path(sys.prefix).joinpath(f"{group}.group")
> +            with open(path, "w", encoding="UTF8"):
> +                pass
> +
>   
>   def post_venv_setup() -> None:
>       """


