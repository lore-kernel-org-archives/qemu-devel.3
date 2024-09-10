Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27441EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so5cM-0000kZ-LY; Tue, 10 Sep 2024 14:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so5cJ-0000k0-Ql
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:29:31 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so5cI-0001K1-4J
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:29:31 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8d29b7edc2so481758266b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725992968; x=1726597768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DoYfyBNEQZqCGaJjh6sGX2mTcXisC2A+1Chc5NtJm0o=;
 b=rjMnCp11qg9r2O9QHI7J7SBjknK6O8Jvp3r+QTeetQ0spV1aQ1UPUtI9y2sAL8UnwR
 ze0wPj7EC6AIBytwRqeFnNHRj+oUrDqJLpcnvvMsOLsI3i6Frsbas1TC2PBEa7Uuag66
 zzDAMsT0MQl6VId1KYOee9lPGc3KuNcZGcObvdlL2STv3hjj1q5uktDtBwHMCD2be9Jn
 CV1JZjBLYfYZ3K7eq7+KMU8bj/xqtsbBm5CJgDQnWUFG0/ey8o4ch/uaZOtIm8CoTiEK
 juSoF/ggg7Err1aFX8lJ5t4prsafIIbIeozVN9OgcoSGQJ3fccCnpRixtUUyZISe3ib7
 EYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725992968; x=1726597768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DoYfyBNEQZqCGaJjh6sGX2mTcXisC2A+1Chc5NtJm0o=;
 b=o4QcUHV01oo0dgjvN8GkTdjBJSk8MQNeEo4rC+ZPR45VHgKsPGSaU/XiifKSuvTFsu
 5h265PitHDsJMxlb6nu93JxfGQOdNqKWRe/5y566qalg6bAG58q8HhNQkKGemK/kvvIR
 aaUludwZBNl4ZAG6AsXn0k5toMj2+dXFTEQTxjKzuq+uu4H+pJW8UYV3VrRZAfyZS27R
 RJBbn44hEIMcHdbmxi3ehuKhS3z+OXQzsw9pI7fFU5zfHtG2fH+0C5msOv37weqqpgyv
 rXP1uD26S0Giob3EO/onyIEd1XTSOlhDBi2ltR45hGVSKxvDt4DCvbzVh5/TeViHyUjU
 MaxA==
X-Gm-Message-State: AOJu0Yyvl0hkS3o8hb+7xS5+5Hc96NiPnnNBXjh+wOJ+GgyFN8IdV12U
 c++8RoSYLBYK5v4gjk4UKSE+a+xHwOMwkIDXHMADqGKqWbXqhIDHh2tapWVYW1c=
X-Google-Smtp-Source: AGHT+IH691jwkg4L/Cxi4CM0/gTNk6SseBxBklqX/WFAJfNLKmRqLEiaxsH41ZelUu7Migh9ecpQhg==
X-Received: by 2002:a17:907:1c1b:b0:a8d:51d6:b3ef with SMTP id
 a640c23a62f3a-a8ffae0b940mr148899666b.56.1725992968071; 
 Tue, 10 Sep 2024 11:29:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c72ea5sm513281766b.99.2024.09.10.11.29.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 11:29:27 -0700 (PDT)
Message-ID: <9c523e4c-9405-4d81-a2db-517863ec23c4@linaro.org>
Date: Tue, 10 Sep 2024 20:29:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer of VT-d
To: "Michael S. Tsirkin" <mst@redhat.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>
References: <20240820095112.61510-1-clement.mathieu--drif@eviden.com>
 <20240910131304-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240910131304-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 10/9/24 19:14, Michael S. Tsirkin wrote:
> On Tue, Aug 20, 2024 at 09:51:47AM +0000, CLEMENT MATHIEU--DRIF wrote:
>> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> Using index info to reconstruct a base tree...
> error: patch failed: MAINTAINERS:3672
> error: MAINTAINERS: patch does not apply
> error: Did you hand edit your patch?
> It does not apply to blobs recorded in its index.

I suppose you process your mailbox in FIFO order so you might
notice it before reading this reply, but I already queued this
patch since it was languishing and trivial:
https://lore.kernel.org/qemu-devel/9f4cba51-5aa0-4942-a7a0-6bd3eb29a7b6@linaro.org/

> 
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)



