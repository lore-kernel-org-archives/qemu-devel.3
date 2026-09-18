Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBF0C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Pta-0003qf-DF; Fri, 18 Sep 2026 00:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7PtG-0003m8-Ar
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:07:59 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7PtD-0002Ws-0h
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:07:57 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so140386a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789704473; x=1790309273; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i73JhmuFtiOCF7fpsx84esZNAun3tv0001Vqi3W7t9c=;
 b=bvNXuDEWOywQIhQq23OaXQo0QvAyWX1+SsgerRl22OOCsKMrYqUFzTyz42A22uP1Ry
 8v9F+FfhHH8p5ccUvUlK8OVUMhPT4Yykg9xE0TztwKGjq5E45tmN+J3p069utfu6imgj
 LmDIKGE4Zoe1yLahp8+pisrb8hMDgaIgJV5L+v7HCboYMaPQt7d/992633iC1fcrMSZ3
 AcBxbItfqIses+FK20ClClS46Xeyq1Sxl+NgyT81q7O0wc5yHF++u9gjMuAWuGxy50yW
 S7h23QS4Q/Vj+o78Ck+ANHearcUBjCHVdNUYyhlEZWMTfJtwfLocYmcKCCgjcDxYg5jL
 TZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789704473; x=1790309273;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i73JhmuFtiOCF7fpsx84esZNAun3tv0001Vqi3W7t9c=;
 b=U7m0+CYif06RbP5daeNpxRCzm3aAkxD69X1xOBG01byXmh0lccUw0v8ZB6SG7MldHt
 3JkzSOztgLXw1ZMKplE3QQdzMZD3OfVfFE6kb91Zk7W8aw9WES2SbMh8h3fs6br7xDU1
 xstNFh0PsxAzgngJDiAii8nuQ5177tLmNEc2GD99EOTnh3AF+xI5Z03Ozvd1M2j7dZgB
 iaa/dTZONMOQcqPsSmKdg5f9VDc2mQ1rKbGbxlndjnIcjOpmo7y5zBRNc3jtk/rVU22o
 jTiMPYipdzjd2scUVIBW9lDWdY/EWr5DTVOGYVYn1MwTR4+r2Tn2tv99njsGtLaAJk7E
 2j0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxo9AwrTW/GhsvleM9u0wgwGfOQtMde/8tpX1N5+6ICgHEue8uvEms7XUQkJzBPAXCOQuuYDNyn+w1t@nongnu.org
X-Gm-Message-State: AFuF++k1X0RVjR8sjW3PAAD/BC+1CnG6aboQ7B77iBomzsoNBJXm+mXE
 OPx2jcrKGkf/asftETOlDpLftXFRXQqzo59eLH5A+Nu4VZl4A3+UlV2mlWFtI7cK0ek=
X-Gm-Gg: AYBFou1UeXl86CouHX63Ps4BUATSLOIXAHnUxuixbXhoIq5se/0sQZ6mqz9kI3hcfZx
 Q/YbJs/TUr0La5/gg4SSAfvXem9j3LL4RRI+1jnPOPXXSBjFmIOtmVEQtJ8l6cMs1L5t+j5y5pC
 aQWheRyuIaSw1/6JvNQr2BOKOxHLTy2ORu7v6VIyHNd2RM3XzaXNwqSCOZkztsdVHE+JZYgGyiy
 e9hrM56nBNPjHNm/UV92oWrdjPsh4Ue7XBl+huEkNbVpWtTcZf2S7K1qL0yrmiJKlWGpylStppV
 nBDAelN/WgII/lVNCLhnfOyfkSdhOG2h2tUC+b+5tKBC0biPjeHMsiLuhp2WeEkRRqrXuFhhkPI
 dUKCwiqdkXHXy5mgjP4GmLIZEuFykbM2VJGOT2SQMPLX2YwkC/VBhKP3fL5EuzzalGtvsOa9U0T
 hxxQRaWniJ29MuDupLqaID3ljAH8likvnDcwaEwaFEGAVOsjP79sdW+qxhg8l0iNYK0JgLGEr/C
 db1kqEvOcf5F8BtjKY32f1R0Pv1iuu5eDkdYuTJc+hM212bitsoT9gh82LYiQ==
X-Received: by 2002:a05:6a21:7481:b0:3cc:3d08:da2b with SMTP id
 adf61e73a8af0-3dd8c2f6ab9mr2212788637.15.1789704473056; 
 Thu, 17 Sep 2026 21:07:53 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:83aa:9d68:3956:350a?
 ([2603:800c:7900:ed00:83aa:9d68:3956:350a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c286d98c6sm748349eec.5.2026.09.17.21.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 21:07:52 -0700 (PDT)
Message-ID: <14b457b5-8cc8-42d4-8be1-79f14ded2613@linaro.org>
Date: Thu, 17 Sep 2026 18:07:49 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] ufs queue
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 stanleyjhu@google.com, stefanha@redhat.com
References: <cover.1789689763.git.jeuk20.kim@samsung.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1789689763.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/17/26 14:08, Jeuk Kim wrote:
> From: Jeuk Kim<jeuk20.kim@samsung.com>
> 
> The following changes since commit c66824ffb01931be0ddfe49a1642a78570abf44b:
> 
>    Merge tag 'misc-fixes-pull-request' ofhttps://gitlab.com/berrange/qemu into staging (2026-09-17 10:21:06 -1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20260918
> 
> for you to fetch changes up to cc1d72231c925a632f360937d9eb48ea12bd539c:
> 
>    hw/ufs: Reset controller and MCQ state on HCE transition to 0 (2026-09-18 08:59:52 +0900)
> 
> ----------------------------------------------------------------
> ufs queue

Applied, thanks.

r~

