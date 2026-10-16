Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28094CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHcwe-0002eJ-QG; Fri, 16 Oct 2026 04:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHcwb-0002e4-83
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:05:37 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHcwZ-0005kF-4M
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:05:36 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-35f036b17easo1965080eec.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792137932; x=1792742732; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IcZP7ctEM8ki8y3pX6yBxiIR48lsGT9abvBY/GfXhbs=;
 b=wgRBCC25XZ/6m1dw4lVoSvstSHmQLiwWnNhqXtzPV1MaO52gByDhf5eF4peGAeJYsL
 oGzdegjKg/rgIV15c7eOs/naBTaS8PnTgrzHWrEQXKdAkBSqs+jgdPRzD2EOT8VAxkTw
 ZgMfAmcmKABrJra4DY6UfHKRrOzPw52NKAFy9yS7kPsZqCJI4CW5Gh6unB7hwp1oKhqO
 iYH+aDvaDfXAmtTokgUEpUrP8df1SNHX6DBGLQTY2NYGNlOgxHCojsgEJqhOPgiylj9F
 nuhTs2vSs4I2mqCOugJPyOtL03I56GtJnJslkWYUmyYnoQUWks6Y5G8XSxF/TmJJSF4U
 NFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792137932; x=1792742732;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IcZP7ctEM8ki8y3pX6yBxiIR48lsGT9abvBY/GfXhbs=;
 b=L4/TpkURxE33PyVUmbiEVbrm8PjOeNFq9ePpoJi1C5hbcQLlfQJ+6vy+aOMVK6dyDZ
 OgXllyJAWoFSfmTK1Uqg+a/Nw8aq4TKpyOZ1wlHXoDBBBo1i6ZexQ3+wPrQ9cntbwYCJ
 SCK9TXFiPn8ZF2jSryQQ50fIzc08NManeIIfd751zVkSdpyUXzQVDw+Na6u+biuTZ+Hn
 as/B2Kr7bF2zFC+iWJoeNrBYNSVvrNFFS3umtxJbSCsPTT7pwIj3t4crJsWlcOcQsaGj
 HqCK+4ZSd6S7z9TbYF2goLIsQL/5rPMWEti9tqo+SKDeTF2udKBUfLdn1AEP+M3w1pkI
 9o0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPM8Hc3BewaU7A/vJrtfzZPIOgHisYv9OpeyqIaEWQ/04zTRlItDIjuQw2aMmkFtSyWjc/ryg2v7z0@nongnu.org
X-Gm-Message-State: AFq9FYJU9oFnzNI8Qvl+kGUIQgZC//iO4u+u1kAGWJYi4o00p7HV/Wux
 +a6+VT7S2ZWygQKr6n/qK3DWwJ0Cqc19lgpYvt+cHfVO19kURh6N/xrGWHs5VogTh6Q=
X-Gm-Gg: AYBFou3Rf4As6qZkDBEy8VkEgqxw6sfVe9Qf/CChUOGTOeAZggcUI8/20uTDkK4BI8p
 EDmETTvrmnP9Av+iJbiVQudeBxHruaYSOXnU36ds9hsUqNDIcfSrwTEv7/R9B75A/f/qU8ahTs/
 dzbFoY2AkfXAe8MsHt7WYy+Xvt6O3q0wsAX4jZm7tyBRW8WvhGOIDfr1jSeac43EEZurQXAnVsY
 6L0Rm6bVEd2SOjGDDL5mt0WreYyFy2ySrwS9XNaxq81WA/hm5pYqQt8TPx8z0O1dJ7uXw3wKypW
 zefAhUUGg/jdVV4hkS/bme5EqAWrA8ydSWai4xeNGmuu95ApFXdvgmFkGyad+CrQN9ASlZ/lO0T
 ftiMp8WLeSw6+/7wgA/mvK3Gcq+4v+JGyq3XhtjVm2YM3FzWfPAFfULayZ65MMAOWg0azFLUtJC
 mrZtZUSnies9H/17b8qwOJxCXdltWJDYOr70Rwig3bBYR6uusfWrmpQ2dJeOMKeZxU/PK5iSWUh
 vFed9chLAY262GwiPwSKjr07c7dqD3TFbsrw+Z7
X-Received: by 2002:a05:7301:1709:b0:35d:bd18:58a8 with SMTP id
 5a478bee46e88-35dbd27a1e8mr9990927eec.37.1792137932186; 
 Fri, 16 Oct 2026 01:05:32 -0700 (PDT)
Received: from [10.233.235.227] ([172.56.182.215])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36083283478sm4334562eec.29.2026.10.16.01.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 01:05:31 -0700 (PDT)
Message-ID: <f3931884-a858-4c34-9ee7-9851eebe22a2@linaro.org>
Date: Fri, 16 Oct 2026 10:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/20] Multi-target 20261015
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=richard.henderson@linaro.org; helo=mail-dy1-x1331.google.com
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

On 10/15/26 21:30, Pierrick Bouvier wrote:
> The following changes since commit 7e8d3c7fc460fe7cd28a3e423d7466fa292bc269:
> 
>    Merge tag 'pull-aspeed-20261015' ofhttps://github.com/legoater/qemu into staging (2026-10-15 14:58:28 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261015
> 
> for you to fetch changes up to 269cab810cd7ee2f6955be2048979b206a711817:
> 
>    qmp: reimplement qmp_query_cpu_definitions as a dispatcher function (2026-10-15 19:30:24 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH v3 00/12] multi-target: add hexagon (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261014210526.104215-1- 
> pierrick.bouvier@oss.qualcomm.com
> - [PATCH 0/8] multi-target: remove qmp_query_cpu_definitions duplication (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261015005355.62406-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

