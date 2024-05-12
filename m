Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6AEC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66SH-0007WA-TI; Sun, 12 May 2024 06:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s66SG-0007Vl-Ag
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:29:20 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s66SE-0001Un-O6
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:29:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34da35cd01cso3101363f8f.2
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715509756; x=1716114556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QwPr5EtNNaz/C16YN205D9pkomcVcn8tvY+4+dDIYaM=;
 b=rAjbX6Td9DGm+msEx8+vcRPqgW4i3UFzur+OxQPIx3yKV/9pIcOLmX040HaaqsYjry
 9pKmqUyUNe+EZ/t73LIN5cPIbwlT3vOyKpcHgB41lNdGPboLWDFdimL0hlsppu2wn2PX
 vkFg2a5g8eVf1gx4UYSCdNCqfxccoTYArLvRg54JjURmC5yXsfFaGCFmTG95bDX+PaEF
 P7gqfHnitN/49FZBFNu/2ytf3OpLuAY2xS7mfZ9XUM0FeJgABrFuOzE6wRm18OdMc1f9
 LB/ZiThjuRLQUx+G4WHB+PMSy8aJbqitM2WKU8ojI18aCscNG4/dLOCJqbqKsZjFq7LV
 gblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715509756; x=1716114556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QwPr5EtNNaz/C16YN205D9pkomcVcn8tvY+4+dDIYaM=;
 b=MyNbYavlHKScNK/fw13/EOu/FzjBM/a6oUBFKORW3FpQyrfBAM2DSKwcUrhkvVHcmh
 9NAUZDZz9aleuDTRF63XNpc6wKvJXD06T6/lUExx4FoNcGAisUQ1cm66D+4QegTxUhB7
 VlXu137aZEpm/wVzObfVTTs/dYSSf8Vaj9wcAOfqKpGvvzvCMwNISxxBe+wyaTvJAUMy
 FD1OBDxm79OVl71U1JU1fqZ7wj2MzuRJGHtgzim8qJg5SONwfsphsatIc5nwvNdLpvQj
 pD0S3Q+SXGrD4p/o66Kk5MCcMeUpR2kJyM3woDnjx/JIL7/eQ0WCiQsqA1Jm0NWpwkSn
 rClA==
X-Gm-Message-State: AOJu0YyxGgBg0SLITjEb3OzcyekRCxZpVzTPmkbRVaqktzIu2GDVCDuM
 LQpwjkSzULoGqfs9DcvdlMQSfZVpxCtHfMsTdFTWDceaBPdCXBY3Fq/ez+m2OsU=
X-Google-Smtp-Source: AGHT+IE9N9OC4mNm5Odq+RbI5+5G1wlZqamZUwYc1yQdb6OQlRA7K5Xe1ktYf/QxVfWnOlw4Z/h6Gw==
X-Received: by 2002:a5d:53c5:0:b0:34a:9adc:c364 with SMTP id
 ffacd0b85a97d-3504a630f38mr5987908f8f.8.1715509755958; 
 Sun, 12 May 2024 03:29:15 -0700 (PDT)
Received: from [192.168.51.227] (12.red-213-97-13.staticip.rima-tde.net.
 [213.97.13.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896ab0sm8671590f8f.41.2024.05.12.03.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 May 2024 03:29:15 -0700 (PDT)
Message-ID: <b85e90da-cf99-431c-8a64-80cbba21ea89@linaro.org>
Date: Sun, 12 May 2024 12:29:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: target/ppc: Move VMX int add/sub saturate insns to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com, lucas.araujo@eldorado.org.br
References: <20240512093847.18099-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240512093847.18099-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

On 5/12/24 11:38, Chinmay Rath wrote:
> 1. vsubsbs and bcdtrunc :
> 
> In this pair, bcdtrunc has the insn flag check PPC2_ISA300 in the
> vmx-impl file, within the GEN_VXFORM_DUAL macro, which does this flag
> check.
> However it also has this flag check in the vmx-ops file.
> Hence I have retained the same in the new entry in the vmx-ops file.
> This is consistent with the behaviour in done in the following commit :
> https://github.com/qemu/qemu/commit/b132be53a4ba6a0a40d5643d791822f958a36e53
> So even though the flag check is removed from the vmx-impl file, it is
> retained in the vmx-ops file. All good here.
> 
> 2. vadduhs and vmul10euq :
> 
> In this pair, vmul10euq has the insn flag check PPC2_ISA300 in the
> vmx-impl file, check done within the GEN_VXFORM_DUAL macro.
> However the same flag was NOT originally present in the
> vmx-ops file, so I have NOT included in its new entry in the vmx-ops
> file. I have done this, following the behaviour done in the following
> commit :
> https://github.com/qemu/qemu/commit/c85929b2ddf6bbad737635c9b85213007ec043af
> So this flag check for vmul10euq is excluded now. Is this not a problem ?
> I feel that this leads to the flag check being skipped now, however this
> behaviour was followed in the above mentioned commit.

This second link is for VAVG* and VABSD*.

Yes you are correct that this second case was done incorrectly. Thankfully the mistake was 
fixed in the very next commit, when VABSD* was converted to decodetree as well.


r~

