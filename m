Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95930C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiBJF-0003mS-3w; Wed, 12 Feb 2025 06:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBJD-0003m4-9z
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:53:39 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBJ8-0003Vc-4R
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:53:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-439585a0544so4416035e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739361211; x=1739966011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p0kCLBrA/2Fj54USDFRu9GbFiKimb0B+DPzbLP3+Xzk=;
 b=YLpjblABOdktwIu0S5pp2uEHheGK8525E/Pkdbohe2nZVPdFHgEZzWW7rpnujtMlrG
 wm5RJQDg9K7YoLI1IB9uOaqDFd7rsCDD5AlNsybjE11pV4YZ+5MDMk9r7Z1p+IbfnPeJ
 hJ2xri3VEBDR+ufs932FfkTA3hlJq/B9D0ckdV3qSHXBhgRzz9YmCd8abthMDWS0IzrG
 kMn0lAFuSVolnS+eNHz9aMy5irT7JqPIrSpXXLdu/mNtUasRgpSdL08oqxNuZ+334Ka5
 ytpQzKVplZMOMZnGCs8zwTpE06702nhYGip1PYAZ+mC6wBrY2/zv42HLtrO3UGwZ2ttL
 S9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739361211; x=1739966011;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p0kCLBrA/2Fj54USDFRu9GbFiKimb0B+DPzbLP3+Xzk=;
 b=q8gadAj7h27Nx+sWdz/nRIcRgs6g9E5oo88wA0o5O5QmpTvGLYyspPG8xdsH/wcDqE
 7eH9YbQv+RTiC7a8J5iE8kN02NyBqhd8TvVHsc4htLZ1OHzo76mA+tkiF1p3etDOoDgn
 CNG44RqkZn9IoCQo2JlfSnvrPi77utOEghrUeLZDy3Dk71AhhHp8Dt0VOdGiJJQTaJ9j
 x1sywtQMdq8835IfQDptcwotOOKc+BXacv1Li8KeVycvoSNN8zVrZc7R0dF7w65bBUYT
 EjjI7izpS80w1yUqtLd620R6p6KQ37NwFfRrAcpodmbO6IE+OlqrwiptSMvbH+OHDpeW
 zWAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYeJ/XIwUd0K+PVwVCu8ecvPtS0k3voCp7KNZcIxgqvOFLwuob6/UgV/3c9fXvzkghwsvhxF5SjPxN@nongnu.org
X-Gm-Message-State: AOJu0Yz+PzGjK10RPz5a10ABUPgR4QOnQIQwZ8AGtAGAj+KXuBUJyB3D
 mFlB8ZunGB+qGm9s3kRhXmcSdeKKomFCbZmpotCDDYmUlmGY4dA/Y2dw/Ie13Vc=
X-Gm-Gg: ASbGncvVtJegrQRY09tGpOw0mQ5MhZl4ffj6xiG/VPgPpss/ZiqMvFySr7p3zdOBJyu
 GKNo6kx7EfpLtjLmLGqUNdCjkC8eSBAylwffrEOMTqRilgn3yuEiIB7PJrv9DtozPDw9A1MU5p4
 f1/FiUw0Iib4YDgVyofWU0EuXGSU2ZcACFs4I1tWtmT91XevUUurhcKMCyoE+qeTyL4fXrCOQ+s
 HKPsoZ3T4jfIF9EEsd589pRPKdyDgLXkZF96ZTxUtSKvaBMhwcBOCiCQY+2fJ+Sahb9zoOy/osg
 NRHzvxKXgW6d7zoVkK1ZdMQsRCqwUznH9CKP+XFLSbGiDUwxbE8ofaIfWHU=
X-Google-Smtp-Source: AGHT+IFVS87fVCZMryKvbm7YqKYa18Gv+DOrxLzeQ6Pkm+sckpdAFWyj9PIvxJ8eR/IU6PKCdzZDew==
X-Received: by 2002:a05:600c:1e17:b0:434:9499:9e87 with SMTP id
 5b1f17b1804b1-43959a927c8mr16818195e9.25.1739361211108; 
 Wed, 12 Feb 2025 03:53:31 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a06ae8asm17577245e9.21.2025.02.12.03.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 03:53:30 -0800 (PST)
Message-ID: <95a37e26-7ae6-47b6-9892-40ce012c9956@linaro.org>
Date: Wed, 12 Feb 2025 12:53:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/11] tests/functional: Avoid using
 www.qemu-advent-calendar.org URL
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-8-philmd@linaro.org>
 <86753d5f-c9f8-4107-91f3-4477fe44cc73@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <86753d5f-c9f8-4107-91f3-4477fe44cc73@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/2/25 12:49, Thomas Huth wrote:
> On 12/02/2025 12.24, Philippe Mathieu-Daudé wrote:
>> Avoid fetching assets from www.qemu-advent-calendar.org
>> website, prefer fetching microblaze assets from GitLab servers.
>>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/functional/test_microblazeel_s3adsp1800.py | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/ 
>> functional/test_microblazeel_s3adsp1800.py
>> index c382afe6bfa..5bf94d88dd8 100755
>> --- a/tests/functional/test_microblazeel_s3adsp1800.py
>> +++ b/tests/functional/test_microblazeel_s3adsp1800.py
>> @@ -18,7 +18,8 @@ class MicroblazeelMachine(QemuSystemTest):
>>       timeout = 90
>>       ASSET_IMAGE = Asset(
>> -        ('http://www.qemu-advent-calendar.org/2023/download/ 
>> day13.tar.gz'),
>> +        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
>> +         'day05.tar.xz'),
>>           
>> 'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
> 
> You'd likely need to adjust the sha256 sum as well since I repacked with 
> xz instead of gz ... but according to Eldon, the original download 
> should be working again, so I'd suggest to drop this patch for now.

Indeed, I forgot to flush my cache before running my tests, and now
figured it out:

9d031aa55fe988fddffab26932552c53dc9adeb75f30d04ece8abce02b226179 
day05.tar.xz


