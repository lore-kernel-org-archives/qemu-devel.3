Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2A0E776F0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 17:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYSJT-000806-6K; Wed, 24 Dec 2025 12:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vYSJN-0007zb-8E
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 12:06:10 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vYSJH-0007fK-At
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 12:06:07 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso6963501b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 09:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766595959; x=1767200759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hRfUgC286zP4KC4X48668Y7WkN+9DMmlhFc/d5D2AxM=;
 b=NkXaQX7fkbDRPmcWmLUvrwaTJ2xte/mcTl1kE5LC2vauGxVEL1SZh3seiMZym3bxuV
 ScbZ33nT0FhXDFnQXrurSfdKf0/RDut6POck1CQXTNxOr3Osp6a/Bxxv2evYkF/Aj9TX
 F7X5ui6v+eKL80h5rYuA3ZlMssVA1oRB/8tn1wsVqXfE2F5mEbI6MILBrXqeHB5IWDkj
 /AZF+OTDSjXag/pe5seJCnwLSFJSG1pijWpWYodeyzAC+nvAYzHH7on8cjSi53Bz82FP
 vLJgTxMHkfREQwYx4T/FHGc2dQF8VqSwQrwdfgi1xXGUKUG2OecbIyxqVYY1O/MdBKC9
 g12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766595959; x=1767200759;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hRfUgC286zP4KC4X48668Y7WkN+9DMmlhFc/d5D2AxM=;
 b=d5+xzTdbIG8W/y4LumsYRr9Xs8rfRANXETy/h2v0gWYu/KIivLXSlC2xBzW+8MVPjC
 l7Bfd+zklPCD0jNrthE5aStrwaS71bFfdc4/YZDa9TQ/qRStu/yttoKTGUp8jdW/U567
 KhlnzUahaZ9vmULDY+rYPBVGlnMBkmM/7CBlpzxPKfZ6dHbdSc2yjH9l23rd28Jj/PFG
 SiT93Ptv3+ZeWm8TpHP+bMS7CMBYufeIWRTErHl3EZI0a7Up4xmrMSMh7zRUR+F53F4a
 GLuT0I5oKDzqeOnsToG+eQ6oX7BSUNfnU0wSzMIKb9e1/edBDY4QKD3EehZuq5hlDIkZ
 W3yA==
X-Gm-Message-State: AOJu0YxewFJmMYvln28A/Az1jT+Cq6Z2lRXs62stmqMyqrF2D/BkcGWg
 8TDRJjgqI/zPYrlRRRABggXKfrgB9E/D4loKelxgDLKH2JUd30AZMRkF51rys223Fxo=
X-Gm-Gg: AY/fxX7pnJEHsMAOrE4lQC1HAxSa/B6B/0Z59tLPBD7MtMZXVzkbulc+c6GSLBT9nGP
 zcTOC2F63DuNVJ6Dk4ODLnRgdCyFegm581MrBneNiZUl1w9sjRrIPKpJCy8Bd79hpdYBI54/rO3
 VR/73oWdzh7PjaHmmMgNG7zTodvkdCNgHQ70pgKEq/pRbFL0Wk8/IbSJjds8UMIIA1GrN2rSGQA
 W1Xz0n1wDTg2OvxKmpIJT29nRQZqL6840Yia2LH3EfjeEOHA/twROufgU55A5PRpyFIHOH99g43
 Z3kItqLivpn7fyBaEn+emLLLnyjVFg1qtFrpb207kOP+4f8AudXw8Bn1BGCcrfPMqZggRb6oOWY
 1oOC9I0FhU6ATtnN0AO5z6pXEUUzeYsKm1uzJv2xyst1ofPIvEXcsv8KW07QjuMpY4zVHo6PdgL
 cHay62Qian8zgvkAFqU5QkXHyS7mS9vgaMF8xWALXRxp+qirWBAjSh/vo=
X-Google-Smtp-Source: AGHT+IEedNVivCQ8TmVkNXSCz29IJvFWoLh9QzZqQer40LaOzyX2k4/UuauK8h8ocKMm1xhDnnCF7g==
X-Received: by 2002:a05:6a20:3ca6:b0:33e:eb7a:4465 with SMTP id
 adf61e73a8af0-376a8eb7155mr15568344637.22.1766595959436; 
 Wed, 24 Dec 2025 09:05:59 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7a018eb5sm15836548a12.16.2025.12.24.09.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Dec 2025 09:05:58 -0800 (PST)
Message-ID: <473feae0-81a3-48b4-8f1b-cc51c94e41ea@linaro.org>
Date: Wed, 24 Dec 2025 09:05:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 2/7] hw/arm/smmuv3-common: Define STE/CD fields via
 registerfields
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-3-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251224034647.2596434-3-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 12/23/25 7:46 PM, Tao Tang wrote:
> Switch STE/CD bitfield definitions and accessors to the
> 'hw/registerfields.h' REG/FIELD API.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   include/hw/arm/smmuv3-common.h | 169 +++++++++++++++++++++++----------
>   1 file changed, 120 insertions(+), 49 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


