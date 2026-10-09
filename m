Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E87CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFD7n-0000tf-DY; Fri, 09 Oct 2026 12:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFD5v-00007G-CY
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 12:05:36 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFD5t-0002y8-PB
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 12:05:15 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so3485149f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791561912; x=1792166712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=azsOMPutt9pW7d7cdOcpt84fHo84qTVEBrJpsOy3pk4=;
 b=hJW3m/rg5kwRNyWyGlVa7TbvHwHDt5Ly6KM31yCgxDjiMEAA4e4LrRAfN3sS0CUEvz
 FmJZOt+TW1QH1lgTL35lBEsbrkABlYgmwvMKqaQPmmTx8nyzE7WwwCqfeROqZbKVzlGk
 eT+pEm2mXt7E/BDjqWjBgvamMg3QPvwr9LViEAgVs4PICgzO0eNgEIyQLyUvSeeAIB9b
 uo3/d6JoQacoyza6sV09IMXXewpzxJMllSXFXVUygmeTIA9pRaYo1AZDkFl21a5cZrNT
 HYUdIbmwKeeqXlQvepaebhWX6S8rx7Bs1fCY2v35cf04/IHZ+dFo69FyIlaiGUU22DJN
 xn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791561912; x=1792166712;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=azsOMPutt9pW7d7cdOcpt84fHo84qTVEBrJpsOy3pk4=;
 b=xpLE0AcHtShEVuvitWwRvxPPqs/r2qWO9M8CzMojZfDDW1825Q1UVqBxfbbMjwTFxo
 ZKpOutoHR9XbaobuHGBcMJnMvVaAKRYlKQqoS2P9xCFDhjeuZ/hkS00XRQ+sxWwrHALD
 E0okwWfoCqUfOORBrG9AMGgWHQUMb0w2ykl869Jgoei1jAzNwbRpjPDFoA76BB30xKs0
 IerE6Vz3pmB3lVvoZGk4yB7c57R7AA47IiX8Errlv/F3VdylXK/BLBnOWkRv6mimybWU
 Zi0obM+aaFQUQR3W2awHuqzFb5MZt4FHuT1ydtF9kXYs05h5gUnICEtjafi93gPFHmlP
 ic0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYV5TNnzWjS4Texkp1LeKYoS2RefS2dQjMduPXr6sh/vu1LQvkUgkVf8q+rspzTdhn7UUCqyFO9Ujc@nongnu.org
X-Gm-Message-State: AFq9FYJThudDjEzI9aHlCwTpH3MYZKlCpKbXx6T8oyYqr6tdqQykJ5NM
 2/Cyshr6a9cpjeIaKEyeP/zOFE6r0eTDkZQE9V4yCch2+JZhZr1QP4mlV5nCUF5NOj0=
X-Gm-Gg: AYBFou0jFbprvXgd+We2tFdIIbFDebLNJ/73e93+teqsrOARnfdsIgmEh6LXSKC+XXE
 qh6tKIXoHXaTZj10hqccdcfwm5D/HZ9egELAxGHm3qbV5sLgdALppOey6EEJFbgXWuZk6Y8dtH9
 iAr2V2ycIP/ChkvisuJcRC1x/zBzYPk20w9X8CB54l9AA5INzp89UZ60TRkbg+SgZOeFBgVvgIz
 8iJEHy67CKKd8e2eHtJAwA8/HcBNxT8C1Y5EObteDjrIK+kzTGYNZlaGJbzw78XcbH1TGKScqYz
 H68mUiNvcPnXTHyaYe5XS36KlX03JSF6xSrUrnMr9kI9XAatB+Upa+QkkuC3QlkA/5UP7d7aS6T
 2COKMJJefROz8nlqZbYJw+jsMmioQNMGULAgwPrVEKHls4PwR7FLeCiSaUFh8qpQkgwdVFEcTZD
 VFDtdMVdBVWTU0Z6rTSeRoCEG4XUXmaEZUTplDtgBUhyVbKNzaxyYJ3uPg4rQIntCYHERz0L8XJ
 6u+x21dJFw93s+YpGLryMoYazWwD4YMYzHM96OKOzPoq/LpKBMccb4=
X-Received: by 2002:a5d:53c6:0:b0:488:88f6:36a9 with SMTP id
 ffacd0b85a97d-48dbaae3916mr3558220f8f.21.1791561911469; 
 Fri, 09 Oct 2026 09:05:11 -0700 (PDT)
Received: from ?IPV6:2a00:1e:e082:2901:7191:7c34:a82f:8d0c?
 ([2a00:1e:e082:2901:7191:7c34:a82f:8d0c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e530esm4481506f8f.13.2026.10.09.09.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 09:05:10 -0700 (PDT)
Message-ID: <8bce23ba-1380-45e9-85cb-599e2ff78d7a@linaro.org>
Date: Fri, 9 Oct 2026 18:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 00/32] target/i386 and misc changes for 2026-09-28
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Jakub_Lipov=C3=BD?=
 <lipovyjakub@tillia.cz>, Yuxuan Li <liyuxuan.darfux@bytedance.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>,
 Artemii Mashanov <ralerrdirsardx@gmail.com>,
 Simon Scherer <scherer.simon89@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Andrey Polivoda <apolivodaa433@gmail.com>,
 Jordy Zomer <jordyzomer@google.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Vulnerability Report <vr@darknavy.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261009122832.348427-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261009122832.348427-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

On 10/9/26 14:28, Paolo Bonzini wrote:
> The following changes since commit 9c88811b81a935a172c5c873b2ada2d9b38a5f74:
> j
>    Merge tag 'pull-target-arm-20260929' ofhttps://gitlab.com/pm215/qemu into staging (2026-09-30 06:25:37 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 7b596a6918055eee8e17a78c84127b934ae4531e:
> 
>    agents: Add a skill for finding your way around QEMU (2026-10-02 11:11:37 +0200)
> 
> v1->v2: move validate_vex() before all operand decoding (patches 6-8)
> 
> ----------------------------------------------------------------
> * target/i386/tcg: fix EFLAGS reads in TCG plugin callbacks
> * target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL
> * target/i386/tcg: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP
> * target/i386/tcg: implement APX
> * target/i386: Migrate error code only with an exception
> * agents: Add a skill for finding your way around QEMU
> * tdx: fix buffer overflow in tdx_parse_panic_message
> * accel/kvm: fixes

Applied, thanks.

r~

