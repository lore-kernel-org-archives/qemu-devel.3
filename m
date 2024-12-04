Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6E7E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIyD7-0005e2-Mv; Wed, 04 Dec 2024 17:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIyD6-0005dn-3Q
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:51:08 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIyD3-0005Ht-CL
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:51:07 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee76befe58so279816a91.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733352663; x=1733957463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QXDF0lonXWbBpfVL/fDmMgDLsbbFe/NogGDebwE1OIA=;
 b=PxbbfLvQ5+ymabGlPKoF9A46Bexi1VDCRL4De44kXUJ/IBzL+qwCjkTIUzbh5C+nAH
 QvdQRZiPfPwham9AGGj2UbdQg4Eino3+KVdXLhZK8aeIO7mfAgNMIV+MFWv0ETof2Ip9
 y0s8g5j877sFsC0L3LR9fHzO4ISpyGuPrkYs5Fgx1H8WCAkNsZ5zYOhf+kzMoywyrNaK
 yeX0l3xFacf+1ECla0WDQNdIqsXb8Is+qAaBXI7AQbOz1efUI8oW4f80awuxvhUgport
 9e6qrGxZH1cGeBf1PYE0teIQzvEgQm/W8T0YDnSYW6Q5oCXwmnvQntxVMkkPMkYPfzpC
 R7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733352663; x=1733957463;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QXDF0lonXWbBpfVL/fDmMgDLsbbFe/NogGDebwE1OIA=;
 b=aoPt6mCbMfCi/QdUOrVTvS01d3x92zTcdbW5UldPIFax0VGx5QQS21YTs+aBeTP4cn
 WyvuacaW+kFnVYYHwXkxHX/F1++3CPXLDHvgVQzmuEp1KUViJibiD50Txto20sehHWUQ
 ubvqel+bMO5MN0yK/sl1WXe/gzk1p05brwN9UARrTpAipZfDG1mm5JNCgYZNOT78PEVo
 XAaAxu3SCRQVgJrhFhNsUok2kE16VenM0FiBUfY07noajdE2caqYiM4qwkmaYL3HeB1F
 P7/xY7iMtjJCfxSWUI6e4chvqyYJuEfSPkZr2ZorbwCQbjSTSsLlXvC/VqnF0oZ2uf5I
 atEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCv00ly+2j3ulBhLuBMgTYPIVVHWUZWltaJGXRDk4K0sed7rIHMidJFSpOiJvGX+TZG81y2A0NNwtJ@nongnu.org
X-Gm-Message-State: AOJu0YwZIB2TscGzdrrJ8Erzq0dBM9M1xW012h1PX7ys8N5jfqEnOPEe
 nJoLPOy5foUVf2pWbNQ3WWloL2mYJnEv/o13FkfW9lcoVZpXgw6Wf0baE42/r94=
X-Gm-Gg: ASbGncvfmOj0u2aAr9XWqzovo/oUwUPAD/nHtb9iA0NYoviVuLpQ/3qlRqsDikbFRkF
 nA7N9CgkceCDyakCckQZVxt0zdD10GfUUB1g+cPS4FIgqxYhCIOomKZgjTC5RIiUEAi4ldmbmbt
 7/KNpPHt7b4P3RNEoj4j78L+mjgaIRUDiUPz4k9pn4F0VIUyUfdV0OsekRMSIiFF4oYTtIc903S
 8SXtOvVyRLrNopM6sPOUERCUvDTJ1J0nfI7aH4mhK63BZBCs4Npz9XzY2H+eYP7kGv4yaGzjPDZ
 g5JHobL5u0fZ1HKy/AlZ2A==
X-Google-Smtp-Source: AGHT+IGhzYHEAkVHbx6bFC8LKoXxF9x3vdtvluAGB8YxuTSKumoo0sjABkv3x8cA6Twbws3984GRug==
X-Received: by 2002:a17:90b:390b:b0:2ee:70cb:a500 with SMTP id
 98e67ed59e1d1-2ef011db5ecmr9752059a91.1.1733352663599; 
 Wed, 04 Dec 2024 14:51:03 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef45edf1c4sm82052a91.0.2024.12.04.14.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 14:51:03 -0800 (PST)
Message-ID: <855820e0-e907-4fb0-85fc-5ca7daa5cf73@linaro.org>
Date: Wed, 4 Dec 2024 14:51:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/11] tcg-plugins: add hooks for discontinuities
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <cover.1733063076.git.neither@nut.email>
 <b4c01153c63444c11c81d70bb2588fb09fcee925@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b4c01153c63444c11c81d70bb2588fb09fcee925@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 12/3/24 00:36, Julian Ganz wrote:
> Hi,
> 
> I just realized that I forgot to run the checkpatch script on the
> patches again before sending and did not include the Sign-Off. Sorry
> about that.
> 
> Regards,
> Julian Ganz
> 

No worries, it's pretty frequent that people forgot those.

While at it, you can fix the style issues checkpatch has reported for 
the series.

