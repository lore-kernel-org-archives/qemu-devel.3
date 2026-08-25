Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EA1C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypvB-00080Y-3F; Tue, 25 Aug 2026 08:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wypv0-0007zm-5I
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:06:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wypuy-0008L1-3c
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:06:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4956869750eso26815305e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787659573; x=1788264373; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k2i5vU1W42aXUk2NAHduwOU7V4+cTMnTETM9dlai+r4=;
 b=CyrUadvu4RBbRPszatWAilILa5cRgdjUrfG/bCP4ltri0bIitQa/n9GdWxe2HxYaC9
 CyBYgfCddyQ1sY8bmq2hsHfo7ARt4QmvRe/MWBcEFxf2rlE66Epsx/GREiY2ZWRjchxL
 tBmzsFJqE3vGfs0dJdiUYdhBTo2sGMZOt8FFITj96JhJdhQELEYa2n7rSlATU8gciste
 EWOVXdiWq5igZXmldC0VdL+ArkZqV9ED9trkfEYR70qQdcDx3kfp0AnA+V+miHD/Pyjj
 tY1RcTVVWKPk5bZCmz3Cyy9t7XGj086fH68HSz2ShHvhw/SZzMK0A74zoRBXccGszUCk
 klgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787659573; x=1788264373;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k2i5vU1W42aXUk2NAHduwOU7V4+cTMnTETM9dlai+r4=;
 b=LYvieSFL6VgEIE4oaj2OdrkIj9UI8KACfJV22whebfgh/RilDkPLpXPLYzeDye2K1D
 AjRPWoxf4UMENy1DaaHykRTho31GaStrKf7ICjBsZZ15tAVpr5VhJ/dQIRDWrfhRulnx
 NH9siel31xLmbRKpRDySp+Bco60q5mDRmvrPuDehcedzJn7yZpsDODcCbM1Lxa01Vfwa
 Koqn3ufex3DZcwyvLULFkxu941OVrlY4l/99hlS6by8BgpYYF09KIMpx88XVrlSOuwjt
 85KLpJK0QfQCvRMDAevsHaMTQzsAZ3SKXYDHsdHhS8B1bT0oR3Dzv+HSNx7ZFeibdtX3
 CPsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdB9D4ByZmfvRZgIq5j2IrLhAnFexSct1qjCosW9EXCezpbmLEB7oa08qDMhGAwgjcFoUMwCIR+sc/@nongnu.org
X-Gm-Message-State: AFuF++mIpvvS0cjzStkU7PPGNzTdypZ6zW0uhPi3AneUFaLO4gjtSatP
 2wVXtT3WMXb82G3Fa1kOBnIkzf3V4i9rAepKOofE/aQ8LC3gayepKt/9bo44ypDD+iM=
X-Gm-Gg: AR+sD12q/ntRsVn6IJs/4nsLALls0CvFe/qzifrYOvQYUpVVWXNabqL2WP+x/mDNc5z
 R0hz/apo5KR9CYqzF7ggP1cgIiZqTP5aFJs/vNyokV/PcN00qfuICaFNF+MSEXGJgpUW2SYgskH
 24fi7hqnLxtOyfSuyNLVFlicWHmOWAD0tyrnBI1nFNyDzALJOQKsHh8Y6x8VMXNhq6lDpH/JjMu
 vjKNIMkxFFZTNCB5/sFEmK8A+AvH39HZl1l0OpJh6xvBDxzFziBcjoCZvTYVnn2ujWx5D9IVVYt
 qtIKPLpsMRk+gAg4tiwziMdeXuzETAcMRI7CHRC9rn6A9gIE8WPEDgwTtTda8dd6Pk2hs6htjwQ
 0891DUQEjs85NTQAUegIgJf1f8Hnq9BQgUP3OkDIitP24vFxNeMFijRV8/G0r7YMQCoi19sP+8p
 W6wanJwyucZSkwsSZv7AHb7vSYa1TPAyODVqnJMyskUy8LWxuTfShH8qZ5qhZsyQE=
X-Received: by 2002:a05:600d:7:b0:499:db6e:40a5 with SMTP id
 5b1f17b1804b1-499db6e4107mr8120205e9.4.1787659572701; 
 Tue, 25 Aug 2026 05:06:12 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:8679:ff59:1b3a:5e93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499d6349e2dsm28228315e9.5.2026.08.25.05.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:06:12 -0700 (PDT)
Date: Tue, 25 Aug 2026 13:06:09 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC v5 21/28] hw/arm/smmuv3: Implement SMMU_S_INIT register
Message-ID: <ao2FMdD7kbdZGiWW@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162624.2809349-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162624.2809349-1-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x336.google.com
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

On Fri, Aug 14, 2026 at 12:26:20AM +0800, Tao Tang wrote:
> Implement read/write handlers for the SMMU_S_INIT secure-only register.
> 
> Writing INV_ALL provides a mechanism for software to perform a global
> invalidation of ALL caches within the SMMU, including IOTLBs and
> configuration caches across all security states.
> 
> The MMIO dispatcher decodes the target register bank from the offset and
> normalizes Secure-window offsets by subtracting SMMU_SECURE_REG_START
> before switching on the bank-local offset. S_INIT is a Secure-only
> register and its A_S_INIT constant is an absolute Secure-window offset,
> so the handler matches it using A_S_INIT - SMMU_SECURE_REG_START and
> rejects accesses through Non-secure banks.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events |  1 +
>  2 files changed, 44 insertions(+)
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


