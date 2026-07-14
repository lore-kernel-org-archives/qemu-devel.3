Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C0EC44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjeGt-0006hS-Qp; Tue, 14 Jul 2026 10:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjeGt-0006ej-2b
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:38:07 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjeGr-0006FO-0G
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:38:06 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-37e0a189b0bso946741a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784039883; x=1784644683; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IhizC0UMQxD3S+L7Didm1/5n4/tgK4DYc3dRNl57wzk=;
 b=j01Ps1PKg4Q1Q4cbx7s08RvKuJztDQdZNSU5CNfwSyZCPVrv3kgg7+enRFaouCt1Yi
 jZsPSmX0T+rYP2AT/kHlvqu/+u9Nn4OJS87zqsfnJjR9XDaoLFaKWRcutzx9/jWJQeny
 Pxv8HN19IG/WqHUEljLF3n6fk95RdJks+AgOgm+rWKjZ8iG7JxRSRoWBN9u3Mh+EC+nr
 S0hBS13vWuB2+7TxtUifYzqV5tVFAbAxoIsPou+c1S5R1FsqIebnYokTn7VUNOSqrbro
 /ZjtKKNtaX48Zl5Jp0jo/koYhxxkY2g0mZF0Tm8qDif1NeruNhol+xhkQKN65WjgKLRF
 NIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784039883; x=1784644683;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IhizC0UMQxD3S+L7Didm1/5n4/tgK4DYc3dRNl57wzk=;
 b=PfyQu1xy0UtVYbsdqruq1lnGqKVL60foiC4DybiKY1U3QKVJc9iVlavLa5UReOKffM
 hVGLGap3LwZe3cyzp8xwMtEtL1kYkls+VPaLOP6sjxGB4vokPHfpEvxFwWfteZSvtCZB
 s60JXu1qQD2NxLIb+4uumAW06iCP81HDYBqvjTvE0FNnWbSwG7LdaHH45Om8QM9i2EH0
 s9//hmRAt4oSvT+SluQ3nX3nZxIlJ1AMAelZB1d4e9iHgOkpwFxxe4viWQE/UxNtpZxD
 ilVbMnN+3Yqbmh2Ph9KpAI4vauR7Ebtdt6Usx0KAQ5Yxktd7pK3U5qc0W4BE5dUb0Yo0
 qzKQ==
X-Gm-Message-State: AOJu0YzSuO+KwyrgPSVzun0JQTCkhSl8j/Lu11lbzoDDkYcT2JDv+ROo
 pDU6C3B02JHlghCYsPd275kRHfflobsycs2VRP5ET6ZwSMefEJEuDoD8b4iiyjocwg4vknkWUft
 af6Z9
X-Gm-Gg: AfdE7clZvreAvwIj8m8DK4Nj6f+gffvareLDLeaWWt3/yfCZmQAabXK3USP6bzd1Qk6
 H9H0TCYyNRBqFXfjYx5NBEBCEXP6t8MP1gGbA3S7cRrVjQDfPr1+qCMbEdkwUmOeghVnq800k2Z
 0uaf+RjxVHTnBWRGTllzB3ZSjztaljyx5sTkqhLJ558BsDJN/khVGvywhUgIxX6+YZrFRK4Ve2M
 gqn2obUunt+fZTLRJjtc1ic3kvXeBIWUtT0QN883VenUr95TBX91oW0K2E6c94KkNRRelS8nOQ5
 7IkNS8Rl75WvVt/LEqV0b1nlfk6ibZa8blSG97vPudySKtBZBUp8cWA8G9LYS/1vqCpAcp/5hji
 p6vX8/oVLNBBR9r/YXjrT2VYlq9F1INvC0AsL6Al0bUzJLmaiIoLecEGFo9F1BfChM83fkVJ71Q
 w7rSC3m8k1du5wU0tP0e1SHGEVrO47BTYWaSyc9KCwIoCRj/s=
X-Received: by 2002:a17:90b:3d90:b0:381:973e:fa08 with SMTP id
 98e67ed59e1d1-38dc7a49f4emr13189122a91.18.1784039883524; 
 Tue, 14 Jul 2026 07:38:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.146.49])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172b8020sm1625305a91.3.2026.07.14.07.38.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 07:38:03 -0700 (PDT)
Message-ID: <4e046322-2a83-41ba-8eb2-fb932ccc4703@linaro.org>
Date: Tue, 14 Jul 2026 07:38:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: GICv5 cpuif: Writes to ICC_APR_EL1 can
 change IRQ/FIQ
To: qemu-devel@nongnu.org
References: <20260714091806.3568281-1-peter.maydell@linaro.org>
 <20260714091806.3568281-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260714091806.3568281-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 7/14/26 02:18, Peter Maydell wrote:
> The ICC_APR_EL1 register values change the current running priority,
> which we use in our calculations in gic_hppi().  Changing them can
> affect whether we have a HPPI, and so the value of the IRQ/FIQ
> outputs.  We need to trigger an update in the register writefn.
> 
> Fixes: 9bd90bddb79 ("target/arm: GICv5 cpuif: Signal IRQ or FIQ")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/gicv5-cpuif.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

