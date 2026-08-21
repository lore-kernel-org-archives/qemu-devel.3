Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A14AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRe6-0001p1-BO; Fri, 21 Aug 2026 11:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxRe4-0001oa-Bi
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 11:59:04 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxRe2-0007SC-Po
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 11:59:04 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15cb6f5c12so214770366b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787327941; x=1787932741; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ipXk87hRrBVPPFEG1cgHwlJAVff8zSkNe7NfBfKH06w=;
 b=L1YN3OXSALBabYZu+BNWBJncnoh7HU45izQq9iQTqXd3hjyoaHoh8rLpNJewypqpKY
 DXktyDSLbpRLw4hIrYQje8uiITieDC4T0QMYim2DlshCCVGhe0EsNGLeuYFO9I7eXtWz
 6j0BXVHjdObP0NBBGTxI92nMqIorbJvhDEuXztvKcFjACXe+RA5fbj5UC/MrJ6BrHvCg
 33t67OshobGfWyPTgLKDzrHDqiDBL/dsGlciajaU0lGaUjJDsoD5TdPzLLmQomatfyLQ
 Me0O0yICFqwh8u0iMR2M7ht4EQC5JDG97lnva/Fs11voV8oMXxpsBQMxsy0hMUmG84zx
 Unew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787327941; x=1787932741;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ipXk87hRrBVPPFEG1cgHwlJAVff8zSkNe7NfBfKH06w=;
 b=SZ3yp+ORo/pcZ8TaCR9PouGAfTlqhHD5G7US00Cbqp4wVhFv61YgYsiRW7DCEoTnTX
 pTPNg9bdRhSeAfcJBEFcdww1quzNpKFLiauAOGADyveZ7jIyZMdJ/jOKublhMlsOtN4/
 Q6y4UaWN+sdnMULS9BMqZ1bDzJtz9qrzE/Q3IKex8gaGobygYDfMtTPNFD8D5+AA5W53
 5JJgGcfriTc7S6LOrhnnezpH5S9A1qb1c7YbPpIRKeboBTRhaEkpP4GwYK5L/p4XzG9q
 BBh23eavfX+8qvyFbKSvfTYPMav9ctLL/eSawlK43EjN5YFJvGKBfpei9jAqW890MSQQ
 Pjug==
X-Forwarded-Encrypted: i=1;
 AHgh+RrU8NRxm8MEQmaTE2VYQEuh8fECkN8qWvfuFjydxhXT5vvuoJnbz/ygbV2sO0vccOmdGUFZQY/u19RN@nongnu.org
X-Gm-Message-State: AFuF++nmc7Mq0AFgU5blVE7bXAzrnGaWa25nIiI0wO9O+irJjtfZCqty
 sfpLhDkRyei2FBQ4VFN0QbCRq7MZplK+JWlglnD/yb7vRa+H6YVzAyJlP9BeUJxQKq4=
X-Gm-Gg: AR+sD10xZQdWu7sPqCrTcN7uBwZNJeTNQ5X+tOzAkXgRJawPUKTzA/3lCGAcDLZf1Hx
 MyHWjH8q5EO4hADRLJDbH9SAuOfVlaJ+fjvmpmfKDkfjWIpjRtU4gag5J2bDjeUr1TpW0YIxAWq
 5ue+lwHjupo3JwVYqe4cirQ4bUrv9H2df5Udac3kCEQMaSmeVHC2p/BMjAoJBrikSRShsJUUKXJ
 uUgz4EWJiGuU0wCbHDYrWSkWG9GMjB9nG6ERQ1plkb8GJD5lSxSYoeukhTXk12cp0TlGpoBnEkD
 Ffu/eUS/Y7w76VpFBavIG8LA0NjCrdUlWeKzTW7O6bb6wsKqR76GFbZ4GxXxLQk67gr6HfrPoMT
 pL9eJlhNsG3spQpShi6gf2KSiIMdoZmJOj/YQhdH7nI6MZ8LVK/00NrdvoAbd6VGSxgagaJ5DUM
 KbilWGCEpdmx4purx9KqrL0DvzG8E5Bw1Cb+cYg03CQIyQdpEuP0mXGA35EF+ZD8g=
X-Received: by 2002:a17:906:581b:b0:c16:14d1:b529 with SMTP id
 a640c23a62f3a-c246a62761fmr593753666b.18.1787327941144; 
 Fri, 21 Aug 2026 08:59:01 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:fa47:b339:78a1:d4c6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459222200sm490316066b.56.2026.08.21.08.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:59:00 -0700 (PDT)
Date: Fri, 21 Aug 2026 16:58:59 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC v5 14/28] hw/arm/smmuv3: Make evtq producer use SEC_SID
Message-ID: <aoh1wwbdXJUdzpSC@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-4-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162512.2807281-4-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x62f.google.com
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

On Fri, Aug 14, 2026 at 12:25:11AM +0800, Tao Tang wrote:
> The event queue producer path wrote entries through address_space_memory
> with MEMTXATTRS_UNSPECIFIED, so produced entries did not use the
> sec_sid-selected DMA context. Pass AddressSpace and MemTxAttrs to
> queue_write() based on sec_sid.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


