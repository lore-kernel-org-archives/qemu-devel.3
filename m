Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B7FC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 13:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0geh-0008Cx-Gq; Fri, 04 Apr 2025 09:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0gee-0008Bk-FJ
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:00:16 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0gec-0002zD-L8
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:00:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so1672039f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 06:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743771613; x=1744376413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=40jQKBMJ/aNzNcyAYEcfx8nB+/5raxxsr0RnBg+r3F4=;
 b=B7+TYdxYZV2YWZCPFFvdStxT2yxm9zxER8OT1Zs9w5/sAB9qdB+B26YRaelPThQ5of
 ltRnowZ4iM0h2H9xL1Nv8rj6N08RVRmuT+OZVdy3bT2okHJBLjMvX7LqXtp6lfXW5lHV
 MioyR/zIwtwnwJr40+XT73uvM6PMIR0roUxYfWgRoski8XN64Dxk1XJCcnEG8EBYIaIe
 vO2mkvWjFJUMMMOBnOd/CJBmlwd0gu6mUMScyrAFpHtnFwYy86FDZUGV1Npt7rX+Ylwi
 AjX/wvknmXQccw6huFAUKi6n6zVgaU4akEv1QqBQOwRjLXxfk0HNqNhJ+apTpvKil/nS
 RSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743771613; x=1744376413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=40jQKBMJ/aNzNcyAYEcfx8nB+/5raxxsr0RnBg+r3F4=;
 b=N8xA2/SVdBwRQs0kZjaUTqyTunxZfkpM4AqHyMkI2JfErazvFt1oWLy83xbvjBzG3k
 bhwe3ub8RfJ+dQrb+Xd+TaMR6zBfm8Lqf3E2VGmJ2xLRiGLIEphI3x50yCeLYEiQLvkn
 8uXbRH3PMgb69UT+I/fBQs/zndqYwLDqvir1PfjxRp/eCrOLg+a3KpLhaLjOqjrwGReJ
 pqP+MvqkSNv8TRksNFSF5i9NpY9S1/GIi71Bh3H6KMoLOkfFTlVNerAoTn9bc1SpoMHy
 xcS7U71XIO4fj0FDECb9CF3kKQLDNuxiU7s6Z9h4G9/hC4XTyxTqN2iAnI9zat9N4tot
 yX7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+B4o9T41sbwFLH4de7EynN0wP4bg8QwJ2JOzhyy4Ot2rKicQiB1suu2uHHEm6OhQRjmgU0zSzpvOZ@nongnu.org
X-Gm-Message-State: AOJu0Yyb+sL9ckWK6unZNHlxq+MrB2xnQtd6FkX9HQqt3Rn0AtnCS43k
 pjTnJ20LhyDwadSYeWvLq1/Vkimw5EeVp9J6LWTo9P/nPciaYxOtSlMrdhdr7/o=
X-Gm-Gg: ASbGncsiayCmmc4VAnij1/n+S1klhMkaG55jlxVdNlmlhd4mLObHyw5pjoVu2rXjt/I
 Pg5r7fpusKBRsD3AU6Wg16p+FlOSguUhvO9z81FKHkCrdlH39OMgap39RKHFJpE5o8dF1bYEkx0
 rDAO5LI3PSfoT2rdxVR6ZTqxtGAs9gWoR4YHdU5t7KRaCwny6aIc2WRjB+ZtI7j9+hNfdJwzRAF
 ar986D4IoyKCVXrUrdvyvEUTpI9zPgDWKa6ovX1s7TX7hV0KwBaQzwxMwHGtBObrXMaFuHy1STU
 /r/CFjA/7+mmozvAHby1VYRGq95MaetHbTASeH+nmfnzHZJtUR9k1rtjTkINiABuhMffTK17Hh8
 XNMutj6frnidP
X-Google-Smtp-Source: AGHT+IEcEpnJbw62Uqt3/H6Xs434Hx7FEVhon8NZRLMyj07Npu3aaolj9MDygA2BaOQMINaTAsBgaA==
X-Received: by 2002:a5d:64ce:0:b0:391:3915:cffb with SMTP id
 ffacd0b85a97d-39cba9825d3mr2583810f8f.43.1743771612659; 
 Fri, 04 Apr 2025 06:00:12 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a732asm4351047f8f.30.2025.04.04.06.00.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 06:00:12 -0700 (PDT)
Message-ID: <99497c16-cee4-4098-9971-f61ef7174412@linaro.org>
Date: Fri, 4 Apr 2025 15:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] hw/misc/aspeed_sbc: Implement OTP memory and
 controller
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250402091447.3381734-1-kane_chen@aspeedtech.com>
 <9171629d-a386-4971-802b-cd26cc42e194@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9171629d-a386-4971-802b-cd26cc42e194@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

+qemu-block@

On 4/4/25 14:06, Cédric Le Goater wrote:
> Hello,
> 
> On 4/2/25 11:14, Kane-Chen-AS wrote:
>> This patch introduces part of the Secure Boot Controller device,
>> which consists of several sub-components, including an OTP memory,
>> OTP controller, cryptographic engine, and boot controller.
>>
>> In this version, the implementation includes the OTP memory and its
>> controller. The OTP memory can be programmed from within the guest
>> OS via a software utility.
> 
> 
> What is the OTP memory ? An external flash device or built-in SRAM ?
> If the latter, I suggest using an allocated buffer under the SBC model
> and avoid the complexity of the BlockBackend implementation and
> the definition of a drive on the command line for it. The
> proposal is bypassing a lot of QEMU layers for this purpose.

More of the former, a built-in eFuse behaving more like flash. So using
block backend for the storage seems correct to me. However I don't think
the implementation belongs to hw/misc/aspeed_sbc; ideally we'd have some
abstract (or interface) implementation in hw/block/otp.c -- with methods
such program_otp_data() --, completed by hw/block/aspeed_otc.c.

Current patch might be good enough to start with IMHO.

Regards,

Phil.

