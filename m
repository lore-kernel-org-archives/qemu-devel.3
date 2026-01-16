Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264A9D4A60D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeiI-0000qd-5m; Fri, 16 Jan 2026 02:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vgeiG-0000ox-2C
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:57:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vgeiE-000484-EC
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768550261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LQeED1LprtQUBjJWR2tVLf2FOAA6uQ2wOLzo79S2Mgw=;
 b=OWkCbnxk1PziX6elRZs3aEvgR+5Qvb2LnIdheEKRxMyFTBaRz3+9fSqptYCujbWVgUjIBo
 KX50EGJ0ZK/W1ONeBrZaA5mx9h9ke6VZpD2v3alrZ7ngvcgLFqmPhIvlseffhBD9BDv7MJ
 7ExX0U5J3QAzFm5rariWjcS9whIRpzU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-lb9wFBYjNkue6Gge2f-AYQ-1; Fri, 16 Jan 2026 02:57:38 -0500
X-MC-Unique: lb9wFBYjNkue6Gge2f-AYQ-1
X-Mimecast-MFC-AGG-ID: lb9wFBYjNkue6Gge2f-AYQ_1768550258
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430ffc4dc83so1359880f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768550257; x=1769155057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LQeED1LprtQUBjJWR2tVLf2FOAA6uQ2wOLzo79S2Mgw=;
 b=eDXRaShn+EIJJ/q30fulwj8SGy4WdYHAa7+/SB4JnyD5HBK1eKxAMspwPjOy0XrgU9
 42/0PHHJipzROgZtdZ4LvMkfjpscF1Pzn99K/7ONTbqx0sZsSciEnjyz7h/5gD8y1YJG
 cXK865rFhysQgXrB1n3Y3M8O3Z37h+1woWUihQ6fP4/rK4kugSDUExNIGOtNosaZGA4l
 rtTdDy7xaJgK/onQUNUCcd7NaH+b/kXEyAAuta5N0iK5wbaV6/BRnq8kcKkxf//GzWZA
 cZGPonCVAYRPLxO19ymdl/Qdvz3DBRshOkWJjP1HX+f88u10VZP1eoGuwoM8Zp9NZ/L7
 Xo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768550257; x=1769155057;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQeED1LprtQUBjJWR2tVLf2FOAA6uQ2wOLzo79S2Mgw=;
 b=B0qxieewk/1ruMeAw5RpkBG3FfFhahaAciCk5WXb5A5Vdd7kOx5e1VNrpAqy4rvQCS
 I1AOqwepm51KINYRNYDIkQ7xINuuptYdiZrs6L7gvytRo5mmlce6v66/DZI3iRiVAzPD
 nR/SqiHFEERw65w5fhtn1fzBjEEso2bO21SbGOpn6ytusU5lGJtKZt+DKrGeET4VWdWU
 LjDa1ZJ7WPCK2cDs0yfs5Z/QaO77iEgPQYUI+qEn2WSNYbfMaAmMlAapHSrZhXqWPT4k
 +TH4cTyMQgWyKXdfFo++jUICkuqz2qQugLavfY8PiOMq3Dmp223cBdAwwwWnDbShmm7S
 N+ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtysaDh4cvMqaIMv6J94KKiMgzKLWwcG4rWZ+k0B8ldrTxVieulG8nojV3NNygZOW7n7rBhag9nFmT@nongnu.org
X-Gm-Message-State: AOJu0YwJ08Rt3CMi2Pr/f7Q8odOTw2qu6bD/Pjcjy90jPc21BhswtFhz
 /7DB1m9QsJfRM/WyLUu+++UyH81tGM49XGDVHenvj+AkPAJ8hKMVkIPZFiFIPA2SfNTFFbuvVRh
 Sr49KMxEIb4seXQy7uCYMzvw0ED+fVeUrFaNGyXRmkhEd5Bf9OGjlsMVR
X-Gm-Gg: AY/fxX4hbSJXQPAYTxdBKh7gr7B/nmEhB0dAKOxV86cMvNB/B4B0A74DDVocqrycRBJ
 Cf6MCYVx8pRYXXlYkupl4jh7hiY2DwmEpdbtL2yyn5vBF9F2S77kBcYtaj/AlG8o2bpb/Qltjlx
 5abOsn41t/6hkhFj7Wr5oJ+I/JE6sl/GKLrs3Qy1eEdynnkuYFw1CiZDpcJtZTy2MeVEumx9cyd
 aBVOa40i0CbsmMfUtdC7SDH+07f8vHD2pOOk6cm24OhEM990QzEZJ6quYpqYCxg4fNhXwQCYTob
 aUcf34VJV/nIxg81zE37b5Httglwo2hyFr07eTNnEOs/RwnzDmnM7dZprcAb3JtyeNKLtuL0Tyg
 P67kjTku5eWcmaBv/59t4AAUfHP5MZG5lUD61qK0sDRg47ieZ
X-Received: by 2002:a05:6000:2f88:b0:430:fdfc:7dd0 with SMTP id
 ffacd0b85a97d-4356a089943mr1942584f8f.63.1768550257590; 
 Thu, 15 Jan 2026 23:57:37 -0800 (PST)
X-Received: by 2002:a05:6000:2f88:b0:430:fdfc:7dd0 with SMTP id
 ffacd0b85a97d-4356a089943mr1942559f8f.63.1768550257218; 
 Thu, 15 Jan 2026 23:57:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921df9sm3686098f8f.3.2026.01.15.23.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:57:36 -0800 (PST)
Message-ID: <5c7ab831-a3d1-4d47-90e6-e0400f9d17b1@redhat.com>
Date: Fri, 16 Jan 2026 08:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/3] roms/vbootrom: Update to commit 1c8e9510b22c
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, kane_chen@aspeedtech.com,
 nabihestefan@google.com, komlodi@google.com
References: <20260116073024.3485812-1-jamin_lin@aspeedtech.com>
 <20260116073024.3485812-3-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260116073024.3485812-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 1/16/26 08:30, Jamin Lin wrote:
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   roms/vbootrom | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/roms/vbootrom b/roms/vbootrom
> index 183c9ff805..1c8e9510b2 160000
> --- a/roms/vbootrom
> +++ b/roms/vbootrom
> @@ -1 +1 @@
> -Subproject commit 183c9ff8056b7946db1ae49cc23e8980ac413174
> +Subproject commit 1c8e9510b22c5b0fd7d7753f08042a4bcbd2939d

patch 2 and 3 can be merged.

Thanks,

C.



