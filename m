Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520E0C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 19:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU8ws-0003xf-S4; Tue, 24 Jun 2025 15:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU8wq-0003wf-TH
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 15:04:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU8wp-0003rf-CJ
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 15:04:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23636167b30so56123925ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750791885; x=1751396685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xzR3EW2ZT30TNyeFZ9jTAZ/kkB511Orm6QiOE+BKoLI=;
 b=yCrC42S8f7QJQwJs18Z9uCWETvAVZCcjH5S74MurFNmKXwRyVXrZv/vC0+Q72y1/Jr
 LG1FgTMRdkRHhRX/FFx1Zj8LJzgLfEtj07rBsqE0xCVJnv4x7aAL6I7583mUbXlEmqTN
 AjYM3fUmnXdT+WZ2Dh5ksKgWiHx39JtozhLnW3ySCpTD3AlEMSuoloV3D9+u1mjzZ7Eo
 /p2AvVFAvVnWSPqB1xfBEWkdMyW1F1xsZnDe0cBZpIMLdpnVoCdL0Ddsv/BCrma44Dv4
 +nKZTLY814kl+9MeRIyjcd/FZXeOjlf2FgFWewiy+FZApgFoDq3KGDUzd5S8Cj/7X2G8
 MosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750791885; x=1751396685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xzR3EW2ZT30TNyeFZ9jTAZ/kkB511Orm6QiOE+BKoLI=;
 b=mJdHi1mjzvxlMpe7uFH0/Qx3qxemC3CVkYUsMEc+rbE/ZGLwp7q0XyGaPSkWITknAp
 cGVtoYhVDr3DuVmiGWZ3UOG9EwbzrIs/Jai6zH/RN2Y3pnAp/ca9MECBZtYPnCoYSg/M
 s0WA7IyVmdmpK8uH0jaeTYjLuJERDNy67LTMDUSNnhpmTULJRntfh5rRLsVrzdeWlhG3
 1p/g7MOIlzuLdA3r7QD4yZWtEq//+mwsxXvn7pDlCCxgGtNqRV2EJ8Nqzk80FsysCL11
 wkdWaeGHFS+S43/O1wXJaP9y/tRr+Q9RY2TjxignQMP7XHhPwffuuUB+WRC8xDJJSN0H
 cMaA==
X-Gm-Message-State: AOJu0YyTfNfi1prZY98rcq9Kz3Dz8nNcrYbiYr3U2XR7XgAPAVRucJff
 2sV7NXlke4pVgVAEuRrEmbcxAttDEI0xeqOn73QRmeMRh1Tnixoz0fxdlLCPFmjHPxg=
X-Gm-Gg: ASbGncvzU7Lya5xK2BB/mNRCpBESXmKVKFJTNllqZfp/btigiZ21ww8furH7J+0W/Zn
 fi8XIMl0RxDU+iwbYH0SfmcKzkzhQ7x5FudxGQuQn3mL52kF0RS6GLVpInstSzWewIYZwEeqKBS
 0bN3aE19Nb749+eeF5MIsGprDDfZITvYf9yATG1t9NMjG2TvJn0rGVa3QaHoS41zC7CZY0InLqs
 wX3BA+RHC1QGsLJSggzv10bdWf5ZpKmj/kuj3sBtQNyqnJb1Dka2GacUc4Fp/4uTzbhEgIjTmLX
 f5egkH7t9mPEwtrNLD2jlqTt+mMTPd1BAjfbY9+0tLz/z1SQroEzIHx1zCGS9C1FgLiYmWSleJc
 O3c44V/FfqSpPebeiYYZnHCGO9Pgs
X-Google-Smtp-Source: AGHT+IHaNdMg2l5ZAywpdiHqXLvZ2V113NGBGlGcQW7XoIUY9pv+zcbLglBo68J5HpKW2Fh0/RnWRw==
X-Received: by 2002:a17:902:d483:b0:234:aa9a:9e0f with SMTP id
 d9443c01a7336-23823fe2b19mr7104455ad.23.1750791885354; 
 Tue, 24 Jun 2025 12:04:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8393210sm117004035ad.49.2025.06.24.12.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 12:04:44 -0700 (PDT)
Message-ID: <a25d9c55-5f4a-49e8-9dd7-dc2b5f6ba734@linaro.org>
Date: Tue, 24 Jun 2025 12:04:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target/arm: Fix 128-bit element ZIP, UZP, TRN
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20250622213509.277798-1-richard.henderson@linaro.org>
 <20250622213509.277798-4-richard.henderson@linaro.org>
 <CAFEAcA_AOqcN0=CQ30vpxsSXG97PUZhoYk8zYKGTuyDn3Vd2AA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_AOqcN0=CQ30vpxsSXG97PUZhoYk8zYKGTuyDn3Vd2AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/24/25 07:59, Peter Maydell wrote:
> On Sun, 22 Jun 2025 at 22:36, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We missed the instructions UDEF when the vector size is too small.
> 
> I think this part also applies to FMMLA_d and trans_LD1RO_zprr
> and trans_LD1RO_zprr ?

LD1RO is handled in do_ldro; the address calculation is done beforehand, but that's easily 
discarded with the exception.

Fixed FMMLA.

> We should also probably put something in so that if the
> user asks for a CPU with a max SVE VL of 128 then we disable
> FEAT_F64MM.

Done.


r~

