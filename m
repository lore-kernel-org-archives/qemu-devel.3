Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68360EE0204
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE2h-0004XK-NA; Tue, 10 Sep 2024 23:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE2g-0004JD-AL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:29:18 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE2d-00015g-CL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:29:16 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7cd8d2731d1so4338583a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025354; x=1726630154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aCUqyKmdkAxs9C3oIu25Na9qN5U3iWzR8HGs7Y8E8aI=;
 b=OetKLyzjoSbliElezgVZRvMzH48yG6JYk8Zr/Yrez/1ouJr7BgcRdkkpHeYAtIv0y3
 +eP8AjtAB90F3DDvYdcd8lRY66iDVLsEnEeBSryE1MJNc/9YIPr6VuEegn68Ir/NcX7O
 oDR6jJHP7UV4/MvZTHl+gZgewuJMqLp4XCN5m4ycmLRRC6s0cdtdLcccZhUpswvMMGpc
 vxRgs41kw+AG55t8JMg5Z5rc4hV/9j/saRbxKPFzSVh5onh7Q7R/3Bq+KlqrTyAjhzjq
 30I5FJLNrAjn9AuovfPxlqJA2xuedyjg5pejxpuA8/IxynlV4wZ+rBFRIkxgoq7YnO8W
 a2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025354; x=1726630154;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aCUqyKmdkAxs9C3oIu25Na9qN5U3iWzR8HGs7Y8E8aI=;
 b=Sr0+HIXXRCHbM6dS0qbX9H10/09KzaUj7eSWfKuBf3HSliPdOK/20CuDeHM/X0dJY3
 PinFIqaQ63tjKk2rdEAkdJx2tFGOo//bZkbkIi+w8SeX7TBbi2SB0Sk/S4fpvZcXVodr
 vORX7desz7pUp52nSmAQlyixob3J9hn22Y3tWin6EC7leQgEMSp1ZsIUY7plIjpe8N8Y
 U0HPzVO8Jy0RQih9b6q2DNgL4zK6fa2tHfp/yx+S9eJ5ANbSNO3Yz8zgZrwZ3iN5lR3W
 S4sQAsLCoUyGeZFG5XRrpec6QCCAjTgvCtcg40MM2RwURL4QRaeKUN+aB3vsotyoWWbd
 WAyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxa8Urejno/do+zxDwTloVoFRc81WaIHw89GeKGlHqNQOQb+99p7d6Bsz6OxDpNdLxbFbDUkYqJdUt@nongnu.org
X-Gm-Message-State: AOJu0YzkVxfZnT86WV4DkkSfZl2qpbL+Yap1Ql+e9y3ASPvj/dyf01qI
 mhFXx37LpODWmmNLZpsSn6ZOvdNiI7sRKkilcDjcxdP5acC/jbkOjuKdAWFyS4AiDEbJA3x9zo2
 H
X-Google-Smtp-Source: AGHT+IHNIh69+tcuvkM77VD4VA0eU0URis9gcadzt5XHUVXD3RT0YjAiyiPmiPHKj2nyF26rFgw9uQ==
X-Received: by 2002:a17:90a:f188:b0:2d8:6f66:1ebf with SMTP id
 98e67ed59e1d1-2dad501b555mr17364899a91.20.1726025353122; 
 Tue, 10 Sep 2024 20:29:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc1105f1sm9357580a91.46.2024.09.10.20.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:29:12 -0700 (PDT)
Message-ID: <039afa50-dc1b-45bf-9c01-ab8e7b16af3f@linaro.org>
Date: Tue, 10 Sep 2024 20:29:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/39] block: remove break after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-26-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-26-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   block/ssh.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/block/ssh.c b/block/ssh.c
> index 27d582e0e3d..871e1d47534 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -474,7 +474,6 @@ static int check_host_key(BDRVSSHState *s, SshHostKeyCheck *hkc, Error **errp)
>                                          errp);
>           }
>           g_assert_not_reached();
> -        break;
>       case SSH_HOST_KEY_CHECK_MODE_KNOWN_HOSTS:
>           return check_host_key_knownhosts(s, errp);
>       default:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

