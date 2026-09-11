Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019CAC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5A22-0002We-CH; Fri, 11 Sep 2026 18:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5A1z-0002WT-TY
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:47:40 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5A1y-0006xQ-Gf
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:47:39 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so1402866a91.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789166857; x=1789771657; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y2o2igT44f2T+6oxP5t0FyBwSzaHcFIpxhSYzs+NKEE=;
 b=wlvL8t4Lwa5LxM2ynCjwZAOaGeqd+zUxxsttGoabykQy2YC5jPMlVsy/vjT/mVrAcD
 fYrfAdfsZ+VR45Dr+U2KUrJJ9/em5FovrfLIhONaIyVym0SjFviRpsaZnsogNHOcnd/b
 eVd7moQqTw8Hpc1gTpCCXOfDI/sBh4tDOU8fHcBI2XZLm6kANaj6x00aRWb3mlzR30r6
 OFFpY3f3aMm221X52NfZKxu5RxyCYCY2lpAu8iD7hprit0T5suofiqXFUwWTXG4OgAMG
 Kdv/ENiLw3RQhNUn3qvAHPsg9Q3DQ6N0idFW+j7yTfYnQUjkO/aHU143YTYLadmXZQhL
 SvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789166857; x=1789771657;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y2o2igT44f2T+6oxP5t0FyBwSzaHcFIpxhSYzs+NKEE=;
 b=hqPPPlNjbm/atGPNNdyTVl9JbAOYOVSafIl92t1AITnUuXiLZ5dvGAgjy//rHpl7hL
 Tyf5E0Xz47hWHxSrJTFJ+0hQkbXcGzujGXWFA2RJO62clsr6/VCvquG0N8F/+rQTC5hq
 ZQeQhT9M/wc9hNpxwmgiKNC8iRnkHIO4ZwlC3N+L5YSP7AobeQLPQilO4keoyI+liClB
 StBtYA173t/QGKN/DLgBKK7bMv0+v7SDsLzC++mFhhsvcgK4WGoFnhK/Sv44RhYFIj4G
 AsoizMEsEIBsbwsLWqxAHnj4/W84FrBm3ENBxqg1WZ9um7KwjRge6qYA9WjRRcC49YH1
 9TTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3ATK8lHfL9ea0m8aiGbw5uQgS/ZXVYtdrFwM7eHQPo9pl2egO/PYLsahq/4Q0WJzbyqbKUNuRH+ee@nongnu.org
X-Gm-Message-State: AFuF++mjgIV5ccfYmlsTJgWq3D+EsboL+9fH696yWzvn3PEbBDECsbT+
 Hu+eG3U1f2UbVAtT0UCRHqY02RUsgTyNs0wnrgpXRbjMp22ifkWoruChHsk5sSUOnkQ=
X-Gm-Gg: AYBFou0J1YL/YYIdaiPJLSxfgMketV8Lv9TrY+IFGnRI5RL/vUZkqkeOpAd+C+60Ns0
 +5/CSrtwf18JhC8zmnPJxphheqTGISaCqgCP7wp48kdMj9fXmei33g1UVjQBNmftJMiys+C7H/y
 mVCWdZsJgJU4P/lQgIz1LveyX6z0IisS+UhOl5JHLXsNGac4YuxQJQ0nMEqRcs7HDKFFE5Mi+2X
 FdUXsf9gBd13P7aI/HIN4MdvWx2cRlak2WMmiPOAvXB7isMs5ArD7dg37UJGC711ybtFrrsxqOP
 0NlHKu4WpRu0inGHH+9b8e2r4i5YRq739OT+iFLjsehadxKL4hb/XWQv31f+86zvmXsOYIp693w
 jtrNSyLcU1L+OijlGk0y/qZ3d+/Yrr+sfWsB3sSrvLlxl3S5zFtsl19EbmToeG1T45mi9b2Oa1m
 8Dqm7LSytTuNMgAOumHcSfyP5A68S5APr+PO0j/tLHKEcW6nEcdRei9Dk6KSKRtIR9s4ExrfZ8K
 sh7wALMlOiPh2uIJaJFboLNltsVmQp5/7P4hHMhnyCj0MG1/o/VLWwWmQE=
X-Received: by 2002:a17:90b:4c11:b0:38e:6a44:671b with SMTP id
 98e67ed59e1d1-39d9b96848amr10185486a91.0.1789166856852; 
 Fri, 11 Sep 2026 15:47:36 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm9844658eec.24.2026.09.11.15.47.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 15:47:36 -0700 (PDT)
Message-ID: <d4156be3-be92-45b8-b401-972d76e08683@linaro.org>
Date: Fri, 11 Sep 2026 12:47:33 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] tcg: split out _var forms of gvec
 saturating/mul/shift-immediate ops
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
References: <20260911204334.1264922-1-brian.cain@oss.qualcomm.com>
 <20260911204334.1264922-4-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260911204334.1264922-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 9/11/26 10:43, Brian Cain wrote:
> target/hexagon is about to address its HVX register file through a
> runtime base pointer rather than a constant offset from env, in order to
> share one register file between several vCPUs.  Split the other
> gvec op families it needs like tcg_gen_gvec_{add,sub,mov,and,etc}.
> 
> Add tcg_gen_gvec_{ssadd,sssub,usadd,ussub,mul}_var and
> tcg_gen_gvec_{shri,sari}_var, plus the tcg_gen_gvec_2i_var plumbing the
> immediate-shift forms are built on.
> 
> Reviewed-by: Marco Liebel<marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain<brian.cain@oss.qualcomm.com>
> ---
>   include/tcg/tcg-op-gvec-common.h |  31 ++++++
>   tcg/tcg-op-gvec.c                | 177 ++++++++++++++++++++++---------
>   2 files changed, 160 insertions(+), 48 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

