Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08F6CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0mMN-0007wB-OC; Mon, 22 Sep 2025 15:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0mMF-0007sl-Aw
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 15:37:55 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0mM0-0003bg-6Z
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 15:37:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-25669596921so50867075ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758569854; x=1759174654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wvGpCNfETywFWPaMPLyx79hv0OtQhAlPC5QGFQz8sj4=;
 b=xtMsE2x4MdjMSoVcV1gc+8EaKy4+yuS1C/F9m5HP9ZRvO3O4efxyHu3ythH+agOiu0
 cdPqwy3+m0+HGUXyOxFUjBbeqnSuVoQaJcbCQYRyHPZHuUuA1szOMXIH91uFzu1SpBGk
 LtnuYAyV8qJlQ+rn2heHvrvKwonLALlRccylCpY2D2xfYxb6Q6gdZ2In1sX0dWsQn5ka
 S1ZjeIizJFgl/Y6AxwEVpqhoup6NwPRE8DmpF6EPyriN37Qp5qFSYc4MaFTKN29mgqiR
 NF/pcDYgQ8MH6hqPI76y1ODUJwOFH7H36pt7c86bOYAW1xXUp/4Vh6iPXDQ0/7DWqDYu
 Wvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758569854; x=1759174654;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wvGpCNfETywFWPaMPLyx79hv0OtQhAlPC5QGFQz8sj4=;
 b=FUDe/THgi/oPuValg8Z7xFmqmVNyYShe8hOo+C/H2C5m/dt33GgYUBeiVdp38T+OF4
 /kq3DnoWpg5AxRMgfodRl8/THg7y8wcEDRd8St3XEJEfRg4Q6s53w81z6MYnl2i6GgA1
 Ad5GTZnERlgZ6SItMkzKJklwirJfhtUSZXjU6pXBnlheaXk6HHgHsGdqt8PdRPsnSbaq
 EFwvTr/uMHITmspC4zSrgnWUc9+ItHoDLkftYH7boCYcRRblQx6Yid4PHsii3MHUDI/m
 Zs7Xgvs3MlsQqwUiDSnVocKIiWW5z1P/YVeqHPOLOI4lJM623zd2qMEXwszDxuD9GATr
 NzRg==
X-Gm-Message-State: AOJu0Yx8m0GjldRsJ+9qDFxKS7caLEZ4SJyPLcXzpErosh/paiG4hbKt
 7jUpEHt21xp/ZaJZuaH+2Ad1lfek7JE/39yexkC2NKpBRZ8me7tKeDsPugeXT487aqTY8juM5Eu
 vZmLz
X-Gm-Gg: ASbGncsCJPkZXmjpo3/OHoWigVuRruRig5kry/mR6igwwtbuKIHOKz0LdpQm3NHgoV8
 U06OLmZMb/CZ3SOgjct48asrFlYIiYE4hsrh7dtTbhkZdbH3OvCii/lcbcenbEt2LMxnqrvkB9K
 QwX0NEEnJ+FnoOK3QjKZNiPbE2g8bAPtFoI/5PwspUKRF1zRDTv82qbfYqKBEBU4u20R55/nr+L
 x4Lh/ThxUY0EPBDZRKJeqOzP6K7/X0CWxnN7Gmwhq6Zj7NPqUJqSYL7LJlH4FJl605lQvAPZWiF
 FalcXnZd0huk3B/5+CaGTN4B5NGBwzJSsQVWZZwF4ZqY97v/XbkMVFymoZ15+tqokeqEefxTpSz
 YvRfT680HgRSQiPpiDPo7AX7+AJh2F/tNRFDY
X-Google-Smtp-Source: AGHT+IGCdBRd/Jt5/jaXVDIgunLtrFg5VWZ1tncViDmwsGl6v7xhe9M4d7riMt7/d1HJd7vE75u4og==
X-Received: by 2002:a17:902:ccd2:b0:246:d769:2fe7 with SMTP id
 d9443c01a7336-269ba5086ccmr176252545ad.28.1758569854427; 
 Mon, 22 Sep 2025 12:37:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802df76dsm136856545ad.74.2025.09.22.12.37.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 12:37:33 -0700 (PDT)
Message-ID: <6e2b53ac-2c07-45be-8b53-bdd711c4beb1@linaro.org>
Date: Mon, 22 Sep 2025 12:37:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] docs/devel: fix typo in code-provenance.rst
To: qemu-devel@nongnu.org
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
 <20250922093711.2768983-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250922093711.2768983-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/22/25 02:36, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/code-provenance.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index b5aae2e2532..af5d7349e12 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -331,7 +331,7 @@ ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
>   generation agents which are built on top of such tools.
>   
>   This policy may evolve as AI tools mature and the legal situation is
> -clarifed. In the meanwhile, requests for exceptions to this policy will be
> +clarified. In the meanwhile, requests for exceptions to this policy will be
>   evaluated by the QEMU project on a case by case basis. To be granted an
>   exception, a contributor will need to demonstrate clarity of the license and
>   copyright status for the tool's output in relation to its training model and

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

