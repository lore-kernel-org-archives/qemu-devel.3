Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9997C021B2
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2025 16:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlsoT-0006UB-PK; Sat, 22 Feb 2025 11:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tlsoS-0006Tx-9t
 for qemu-devel@nongnu.org; Sat, 22 Feb 2025 11:57:12 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tlsoQ-0002yE-LN
 for qemu-devel@nongnu.org; Sat, 22 Feb 2025 11:57:12 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fc3027c7aeso6330089a91.0
 for <qemu-devel@nongnu.org>; Sat, 22 Feb 2025 08:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740243429; x=1740848229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eHtQQXmljBhTPvbKqtMClom4XSeLVSB6/iyVcajcjPM=;
 b=rfzwj9UpZ/l3uyvdPswHex9qln6pX6U880Jm2j0cwJ+i4eUi6XoCnVuivKoJxmp6Dp
 ELP5Ktc0On7oQ+A4qA78od30HtIT+GSxtc7kSY7lU/6+rqc/NCM+I5bQW33CKyiNu8FO
 BlFtBsT1v6CktnGkEvw03PbUdClHXSugh/OuUp59f9O/dmkLUH8AYVDIaaMLzKN1zggD
 4hSq0YmiKuRoQBhNS90k+E9D5R2sUjlb6tNPXI/oCcUo+wkL+ynyJCdCNl1wyXrYaiSy
 0ltmleJYMVOUguFgAsbqRu7UIzb0s5QoIokvWSUvOu+4FnEosq6JCPwNLOf/d9u9iDmc
 couA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740243429; x=1740848229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eHtQQXmljBhTPvbKqtMClom4XSeLVSB6/iyVcajcjPM=;
 b=iyQ/VWhxsKKxMJnmSsJSjUFen+DyLo7cgK1h74iJd+Ud5iUjPywPsoaxJ5FtxOyjUW
 EAFY/tshm0rud6AnJdOIpc0symS6/deRmdGm1RmBPBh8FqV4tK4gBK5OECcZ3+XZOH3u
 RgCmjS3TbPmo1sLJ4fRytt61/pDx3TmnwhRy2Oj8X3D0b2ZCY3Xjuiyk2/pIEX9jqiyr
 CuykKbU6qLJg1qW21G7SqDbndSxp14IX/ebn6ngHEvaTHFAnp/tEi0bbtvOXBegMIt9u
 MJb34FNdT/+ruDtoHK7wa2HrdZBClurLaPBOh5DPJ9y2rZ+bM3KEY+vUzYviXHTZ7gFt
 7iuw==
X-Gm-Message-State: AOJu0Yzknv3tCEeQ7g5qMpHVbEevE8aycwJ35nrFqyqBHVnlArIHCMYN
 Hz/BAfXlXbK9go+ts+LQk1JCiVgsV16Yasx19cLwX/tUzndqaBHZb9U7Oggt1aeBDc4uNKIghU/
 r
X-Gm-Gg: ASbGncvlugaG2amwoPQq6hu1DftBCaRPvUNpQdH4BhhK6CCmmohtjCsonF2OgjUfWYG
 /MegbPmvtCJDRUCAPBeRRdwNvPVpMItxW3SGaK7ZrTbcTf0oLuAlk7ckdcOUXA1oXn0VUPx1Her
 A5biuohbCp5FMRXbxUVdastOe1BBG8wDZOwRLsJHUmgmwo2/CxzldyfHid4rzyzVKfvYxSLixfu
 eGdGbs+vdV3g8HhkuSnrTXiKTfiFq6YWQoQWTMTfvQfyWRFWyweoSC+HPNbdUCf6/Un6N/r0yFX
 n55PcM/z4F9Mt25famYMSYGyzODh+SxRoyr0tx0lEI1DciS0zWdgu6f4Mohj86vDo0YDKTHvo7v
 m4Fq55bg=
X-Google-Smtp-Source: AGHT+IF1ciZLZslJkAIdi00fT6FBEkcgtUj5la3TXXua4AkOBWlLt6zVCoPDs1pyA6OM7et2fmDUSQ==
X-Received: by 2002:a05:6a21:394c:b0:1ee:c8e7:2032 with SMTP id
 adf61e73a8af0-1eef52f8796mr11014707637.19.1740243428622; 
 Sat, 22 Feb 2025 08:57:08 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73269ab8d5dsm13253874b3a.151.2025.02.22.08.57.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Feb 2025 08:57:08 -0800 (PST)
Message-ID: <b629f86e-6406-4732-bc2e-de4862939a6d@linaro.org>
Date: Sat, 22 Feb 2025 08:57:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/arm: Move vfp_helper.c TCG code into tcg/
 subdir
To: qemu-devel@nongnu.org
References: <20250221190957.811948-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250221190957.811948-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 2/21/25 11:09, Peter Maydell wrote:
> Peter Maydell (4):
>    target/arm: Move TCG-only VFP code into tcg/ subdir
>    target/arm: Move FPSCR get/set helpers to tcg/vfp_helper.c
>    target/arm: Move softfloat specific FPCR/FPSR handling to tcg/
>    target/arm: Rename vfp_helper.c to vfp_fpscr.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

