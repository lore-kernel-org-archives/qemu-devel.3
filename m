Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E3BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 18:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whX54-0002vw-PB; Wed, 08 Jul 2026 14:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whX52-0002vR-H4
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 14:33:08 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whX51-0005g7-3O
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 14:33:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cc80b585bfso953815ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783535585; x=1784140385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZtW1EXsDXo1rOnTmTfg/n0X2PYhiBHBDBMy97YJAtAY=;
 b=bl9R8jVCrjdxoupqBw8qyNkSzaIg9qajbkBTyfOuuD3gwczWw9WPhdC7J32TXBBUyK
 zRMtVU+11X5ofxK38V9DBJ1vHggL+dp7eacRASJXWx2uCMBMdabd0for1n5D8+Bx5V+G
 QQnfmskMYwOd46AZ8AgqOp934naPkYg3Wbe7mlvBnMDcskHNOg5nPBViy/UkGvDCRk29
 Wiw2euncgt8szKw5dgkdgdq5MRu1ax3/L+nbelxVe7Tr+R7zRun8ZWNgpAAhPrB6GdY6
 I7761AchGCbtzmD/F2ylg68+YlaFqWJJvqfmpt8F6rDdaC4WjMK9N3qa0Uq1BFfyl4R5
 yzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783535585; x=1784140385;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZtW1EXsDXo1rOnTmTfg/n0X2PYhiBHBDBMy97YJAtAY=;
 b=sclmhSEImRd1Gs7lw0nvuj5GHS0SsqIkaftUdNxxB8p5IaLZdrOzCbqWrVi69+pveW
 0M5vu0HP3ong5U1qRx1KDspDJare9PbCHzMz11yzlBf355JiNimobVAR1J56UheP1mht
 RstFf0raCz1DEgdhQMP+pAcK40ME+8fEOnVS0RyOOVWSQTOnkISvrdU5gNyjvaA8EfEP
 85GOMYV0b/3Ia/2FXp8MmFMZEwlkbc4/qFaTu6xD59AFXOP0beZ0qewP9oAE1+e7AHPn
 qKFIREqtGMgGYLSjomeiRHWgM5ObY2aPBULBm96VnlCioAhBcCIzfwMAuAZqMf3Xhc6l
 268A==
X-Gm-Message-State: AOJu0YyCq2FCcxg4+G9WBxzHQQpCwV84tuwOqViyAG3QMyg42OYXm8n+
 gkDRkpJVsUVmbqT9oVvHgncy0p3ySrFTzfAh6KNQLYUYDcTx+2sqkuYFI0i8akPu8wuYl5homFR
 GqalT
X-Gm-Gg: AfdE7clNbG6gs/SV1ZlvkVjfhsiwCokeqUsyyZ4WnrKNVn9nNZuGlmtKU/HJedxhAmz
 uiMlHHDCXBGVfy6d3bHtk6NahlEkfPwUUdVVXwuMNsllkzB2Dd0IVrbZLdma8PWopYbGl38Zul7
 l5tBOmT0Pe4Wtg579bPW9bH18o7vD8WPn92LHHo7bD2eHIzV1xblfScdo5xmVSPqbtrgfA2Zkj3
 27DMGA+VTEtOOBm+k/GPjObD44muajNRgOVf92JbE0+oa6RmlR3O4fZD1Ma+k7E147/RNWk6Jbz
 Ab4+mAjF8dL0dAYYvgBvmIM6Ig8wxVZv80Iwjf9m8Ho68v/XrZlxv5DbIAEOxAiMKYjxAnlmjAX
 KcTzL1iUdTuNr+syy+mus7rybinCBdQlJUYyJg45IjryioGspNq2XOrIQraMM0r92WCvSkWbanY
 Yoq67utR3I+nW1yYOVoewK9dUaAXxbS4qcP+oxou4mVXfazfhoEuIMTsk=
X-Received: by 2002:a17:902:f68a:b0:2c9:fbde:ab66 with SMTP id
 d9443c01a7336-2ccea472721mr43793215ad.37.1783535584793; 
 Wed, 08 Jul 2026 11:33:04 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccf9b78e3asm5321075ad.69.2026.07.08.11.33.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 11:33:04 -0700 (PDT)
Message-ID: <1037b525-583a-4f6b-b83e-777c0bff45e9@linaro.org>
Date: Wed, 8 Jul 2026 11:33:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] More Arm FEAT_FOO documentation updates
To: qemu-devel@nongnu.org
References: <20260708145841.3032079-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260708145841.3032079-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/8/26 07:58, Alex Bennée wrote:
> Alex Bennée (8):
>    docs/system: declare support for FEAT_EVT2
>    docs/system: add big and little endian features names
>    docs/system: document FEAT_Secure
>    docs/system: document FEAT_MTE4
>    docs/system: document FEAT_IVIPT
>    docs/system: fix sorting of FEAT_S2[PIE|FWB]
>    docs/system: add FEAT_S2TGran[4|16|64]K features
>    docs/system: add FEAT_HAF

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

