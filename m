Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722F3D35160
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rbQ-0006NA-98; Wed, 01 Apr 2026 05:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rbK-0006Gy-6E
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:11:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rbI-0003ss-Qm
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:11:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso65127695e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775034658; x=1775639458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bFeUPDzKxPjIqA/gUOu+malgG/GVhTIz5qjs532Hzj8=;
 b=v9lLgblMPgT0rw0c3YgvRvxih6vkoo9GxNVsyyHFo5uDp0nnlH6hpV8MRyz7fjxN8q
 tQO1Buc8b5ntSPL27K2H3a7NYG41H5LCNlo010FpbFh3kBNsYcxcuN1XfP2gtgXZr8ka
 uInBpDMg1rm8oyHJIV+SZncuaK+CnBEr8fLlkWwH3w3eToPkzuRtwaf8ThuHvbMP+aoD
 4zPd9i6cVMhCuhhkhjuXSraPXNx2/9AJ88l+1mv7saoIQgljdP16UTiih7gsvK8U5RKX
 ReecoAVUJcxWds90N79wNRzytaShMcRNSCrmHM8MW5YO8fGp4KEFKDqXUYGevQEYlVUd
 85RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775034658; x=1775639458;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bFeUPDzKxPjIqA/gUOu+malgG/GVhTIz5qjs532Hzj8=;
 b=MSbA7i9ujPn7ItEWBo+aENZ5/UdpL090SI5toCkPENwgDxHXEAExDgF+0Kkv5/+HaF
 mTrvcXvUJFCtkGi25h2wTtcpOEQfyRZ4WUTqzepIJH67IAErgv3VN+K2kQhD/ahP9ldK
 Jg7pXf7dTK9JpeQlBWhHYGv67jUjo/tiJwtL28E9/CxGiSf/ZPPoUAYd+ai+tGxVTf8C
 AX8r34EBLZyDPNaf5X+rxnjU3Ou59Yi12N2yrgP6T1gMTT3GU+DtEC++uqO+/Dqf8Fxg
 pCVAbhVHRWvrSoobQUTGbgANTTloPkWltVRZ9go+6sFocPcFadvtuOzxRVWjjd8Lngaj
 WMyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPbytIPpAr08YPdv01cJ5Fg1jBfzwfsVMfSt8SSsw60gwOvolnmsPZJxyEkhV+FCFkLjDGTS8yoHtu@nongnu.org
X-Gm-Message-State: AOJu0YwKfU65HNDv7V3ezbav8IFV4HcKQF6EznbvnSE/tgzQbzY9vddU
 cH7/Mc1qsTq0yI4qU+Q5kQpUp9kbqUOAIcnmMU2mMcs94hs9ULmGDNQcpYgIyuyUNhA=
X-Gm-Gg: ATEYQzy66T3heH6PfrklRuQa7rCn+m2vVeYJER5v4baGggtIR/HTH8GjtGZ0/E1KKkj
 TUiui6k/dKo2+/fORH7cKwXnwv+ds/IqJqP56tuytQjQdqSFHhizX97iBYU8cQNUOBzmI3S2fdz
 G6YGfLJHg3PxAzeR9TIDKVnR5Qr/jUltPgZzoB0pZ9Aev6x2b23+1uVw+6kFyKYI+GlpMI2SPKT
 x+kU8NsWpeQ8ze7ozxfAAtSpf/U18ReRrrJgOwHto3d0QKdwGU+82TGpt+QLX1+9FcdmfO8i6yF
 IQftwNpJymMfSDO09UWavANxwdZAAIdwDutyi2R/Lx/ANgEmUTEdPgW7ed3TwCWKZqTdqKgVjkH
 gUgowmaBCwMxuFuYwKzoKWARr3BBl30Ikxqs61imoSEeo6JMXoTsnkaMreQln2ygTGFut+Epr2M
 K/1k01+3S9z+YYcnAOAh6IOGtqRaJJhPu/G2Iu+84CTG4vgJmbipYEnKMpCoSU/NPaOQ==
X-Received: by 2002:a05:600c:a16:b0:485:a4de:f4f9 with SMTP id
 5b1f17b1804b1-48883599b21mr46125455e9.27.1775034653396; 
 Wed, 01 Apr 2026 02:10:53 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e83e906sm95174855e9.8.2026.04.01.02.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:10:52 -0700 (PDT)
Message-ID: <25410812-3206-4417-89e4-11a849ae6f60@linaro.org>
Date: Wed, 1 Apr 2026 11:10:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/60] ui/console-vc: make invalidate_xy() take vt100
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-18-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-18-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> This decouples glyph rendering from the console object, continuing the
> QemuVT100 abstraction introduced in the previous commits.
> 
> Style fixes.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

