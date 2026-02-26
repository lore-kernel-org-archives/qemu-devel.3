Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A06CFD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 21:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjEV-00087b-JB; Thu, 26 Feb 2026 16:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjEU-00086y-8J
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 16:49:18 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjER-0006If-BS
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 16:49:18 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4836e3288cdso9276565e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 13:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772142554; x=1772747354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l7PkWdLOlPn7obFcKRiFNIy8gZI6yyioHnaAuurSmEM=;
 b=c7JLBc7cIYokFhQKGITccy3fmT5Aarfl8TOxsDALTKV4vcG3xM/K3k8WxFM7vBhCJ9
 TRO/oUZQBxd4BO/o6YNH+zW77wgB7YilPIwneH37Wv3LW+ODigOL5poEaqVKtPFal11U
 DzKalMDm/HruWZDGqaLy9TSoxBrpFa6JcjXaEpgbKa7nCHiuxxVIPwUW0rGkSu7moQiL
 f7i6xFMTp9yqjGPCiYQJHQSHWi6l/xHZp0x9AL0o1p2FVmQt2IhP4gpaBudMChceUpaA
 QN1X1dzkRjqSaqVfX5csXi8Ujov/ea3oarT5kG1HeMIZyk4ikiAD+noqg2q3Vzl1aE7T
 pSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772142554; x=1772747354;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l7PkWdLOlPn7obFcKRiFNIy8gZI6yyioHnaAuurSmEM=;
 b=nreL5WIzHszoX1XEuhTCM+knaBRMoWLec0a/Es871/u+aC8Aq5YZ/14h2Q/QNTdEtG
 FBdNyjy4ad/KaEhs8JLuyVvL08GQVrEiY2ifL5EF00TcgwEKLlWTcm/wpKhFLyiZhTff
 bBULYwHGsUYHDHiDuHaL7JgTd7zLbnVVcZKKR5V1vkgpjLysoRrbe8EfdM6R0yCeeZQh
 GO0te2FHnSivR3XGOZ+RNUZ3ZZVgYlBKCrMM1CURHpj/a8MEBCkoydkXZL5dJw5viDuN
 6f6GkQt2yhWGtox4deYQT1A8XPjHJTXZ0MC3wylvfc8TGXYSeRi3x9FwapEuo9uiFZT9
 aQZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzsxf+GUZt38bx7dsmL2PtkX+4rpKbfOnPWIwoDa/3g5nU0vfRnIrGRF8Uib06/BMC2NuIobnJJmwk@nongnu.org
X-Gm-Message-State: AOJu0YwgLWBWdPGqNYEbgZEjQji9QmRr1YmRjZiTx0xnh12araDKgvtA
 ScPvy5/17zYj7Ml8x0qyNtbk0l2TWPnsYLH1UTtJK3MDyK6jvoe917Iq8GuLH2m30Yk=
X-Gm-Gg: ATEYQzzOCWvtgDq+GtTVakAmkhMhG56NUzZMrsYsCGdvqlwwnqrtZrSRjQf6otQQJ8A
 bs9SInAM3ZmMQqVPxJs5teKge/sOFxWBOjGtoGMj0sSw7EihPKycrYlPEiMeqigIf+yYfbOxTzV
 GFl2fNzG6K147l0dTD7Ppoq9XAv4F1FiGn0mh72yYv0zTPs/9SlIKs49GdvCWgz8vTUzLl1Rk2q
 4jLNfe+cGtls6j5YhyMfY6tJ69Pw0WJ6Re++TT0jJkRKwyGDzKzMPnYMhCljtNdCkZd4PehNcRI
 M40wK9ScuKBkmgVpqXzaDEVUbnfaJtdMpHyiLmpQVHwPSiIb2v0V/IQOvzIGaNkeslrTyOE9s1B
 iJ5OXloHJ0S0Z77hxfa8nxY1OT9K5E/DzmOIeXQQ2YNP3UbNDrREwYgnR1SMxiUdXSd/kAvakPA
 6+SQId8G5b1xtqdOUnijlOuxFC+ZJ/YROhJ1GVa3x1IS3V0pYYQ+dXJs88p2JN8CFypw==
X-Received: by 2002:a05:600c:8b5b:b0:481:a662:b3f3 with SMTP id
 5b1f17b1804b1-483c990c263mr11061735e9.7.1772142553794; 
 Thu, 26 Feb 2026 13:49:13 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfccff00sm46648725e9.25.2026.02.26.13.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 13:49:13 -0800 (PST)
Message-ID: <65e0593f-d5d6-4e22-a730-ebe65bc1a332@linaro.org>
Date: Thu, 26 Feb 2026 22:49:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/smc91c111: Don't allow negative-length packets
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
References: <20260226175549.1319476-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260226175549.1319476-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 26/2/26 18:55, Peter Maydell wrote:
> The smc91c111 data frame format in memory (figure 8-1 in the
> datasheet) includes a "byte count" field which is intended to be the
> total size of the data frame, including not just the packet data but
> also the leading and trailing information like the status word and
> the byte count field itself.  It is therefore possible for the guest
> to set this to a value so small that the leading and trailing fields
> won't fit and the packet has effectively a negative area.
> 
> We weren't checking for this, with the result that when we subtract 6
> from the length to get the length of the packet proper we end up with
> a negative length, which is then inconsistently handled in the
> qemu_send_packet() code such that we can try to transmit a very large
> amount of data and read off the end of the device's data array.
> 
> Treat excessively small length values the same way we do excessively
> large values.  As with the oversized case, the datasheet does not
> describe what happens for this software error case, and there is no
> relevant tx error condition for this, so we just log and drop the
> packet.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3304
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/smc91c111.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

