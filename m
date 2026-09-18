Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96044C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7cn4-0004aY-V5; Fri, 18 Sep 2026 13:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7cn2-0004aG-JU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 13:54:24 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7cn1-0004bN-65
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 13:54:24 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-39b31b4281eso1133492a91.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789754061; x=1790358861; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cBbrd4UylHTdxSGmgajUxStwLqnV+Nx3pEBRu8g5XuU=;
 b=AQBOgT513ND2grrKTpUtaFGOyURhgPUI9KVnSvT9fshOHXA7v9NtoiLik1kIi23yUn
 hmm7pCO05IYVCev/4sHGDMvmZVOz30NEOdRsZ54lR3iTb/gLYAvxKcKW2CGX1xyh3xc0
 iKAR3ky0TYg773TJ+mmEo9bRtwZk+rNEUsUAYWgHMBIY/yvX8hXGtbdmkITNPq+JgVbi
 uYid4PebJQ+MZZzgUln7LdcOvXh86a0MpD1X+yPigOcPb+F5JUipqQuPn1VPn4ZMkwQh
 GIEuLVIjN5ftVHXeVcJhpIUFDzgLu3LSxD/pt/5F1oWwvEp1M+8hRfJ9upZ39ddSaKBV
 84Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789754061; x=1790358861;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cBbrd4UylHTdxSGmgajUxStwLqnV+Nx3pEBRu8g5XuU=;
 b=QxQAzGHpgWRRSFmiDYq545qAO/8WKV3z3+uzkqLn04aTEby/ue/OB4wz8bl1AWOPf2
 YM3PfHATFZGTQREjLBddsByDotkcsnHlvDrLh8yfZVmeGQAL+0E1EZYVWUev1Vu6/LbB
 iMU4jbQBteZdzZaj49jwhfTbpv3WuMCGELH3vBxK63+Xdaxx2rP2Y438XYtIAClEDWxO
 sRTYwfZP983F1mvdPoj/95Ix1aWnuBozSrhilJdA9AcHYTviDAH9XL8YaK9rpVhiRgsc
 3y2Pre5L/uTVCjQTggkdk+WJMs2xTd90Hh52VTQ913s1dYYYUozgrbMYBK85RdsBBW83
 7JnA==
X-Gm-Message-State: AFuF++lLVM6K4X+WshDCLnTUySLlgwIOdP6bPCCMIkBZT6WWyp9i01/0
 zV5LowWpkFUnC1RbXWSsmaWNxfPv7ijNzRfLKCu6Brx1IFC3uvhrkFHHzCeLGCyI4/dpKEKXveP
 uAiemLkM=
X-Gm-Gg: AYBFou0eifsY7ELOiBekhgIP4cVL9HDQaMLxypOK9xZzuM9PUMHJ+Yuwsc88Fz3KlZu
 FGMUIqBhfv6kO6A0FsW1nGl4UrKOw76t1PB84yIsxbtsEGAoKqarKe/VPwo+N7NVNWNK3IgzPPl
 r9VofZrpFOSzP60UmfVNRfcEE3uSGS35TUjY12bKyq3FHksumA1JFp9c9vQ1wEkKZCCP92Gy4V1
 igzjyWAsOJHpEoGCX9OuZ3dkpCOHZO0ii4Amsvl1JjTBwKbBE3i5s333y7OdJQxaLXBbFFeIun7
 f6r+Rz+uK5Nfe4YHBc3xXbuB/E/hV05pHQJkgfIsxFUwvaBCNPhEWAj7V1wIpWls9TfSsi3c+PP
 NMHERyVK7SbUCVEzAc2pPjGlsaWdUbhyc479HU0QNr2+8kwiPKQJ5w7PIY7MrLJhzVjqcfaulSe
 DswwnUvJQhDsnszy4XqP2t2gWDQv+z2FQ6r8Se3ggIoL5Z5L+5xkErwspl8UCPJrwxuUzRDuA5N
 5O61xgyQES8bhwW6iX9kLA3eiupWeeg/K1q3ZGtQSWYB5XyOIqpMTbB59HENGyohEMzyCB2
X-Received: by 2002:a17:90b:4d91:b0:39e:6c68:c782 with SMTP id
 98e67ed59e1d1-39e6c68c9f1mr549125a91.56.1789754061037; 
 Fri, 18 Sep 2026 10:54:21 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:a77b:e7c1:e15f:5180?
 ([2603:800c:7900:ed00:a77b:e7c1:e15f:5180])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55e8954sm251770c88.14.2026.09.18.10.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 10:54:20 -0700 (PDT)
Message-ID: <8a7f4fb2-09a8-407f-b655-ebfe5036c794@linaro.org>
Date: Fri, 18 Sep 2026 07:54:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] accel/tcg: add helper raise_excp
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org
References: <20260918004225.827-1-luoyonggang@gmail.com>
 <20260918004225.827-4-luoyonggang@gmail.com>
 <724e2043-fbd3-4c1d-85b3-a2e6056b9ec8@linaro.org>
 <CAE2XoE8X8cAS0CsQ52pgBXsrbND14bL03SehRnx64tCGSOxrWw@mail.gmail.com>
 <975a89d3-3614-494e-bdc4-3d892658f095@linaro.org>
 <CAE2XoE8HqY3XH-myj1Y-w4g9FM1mbzFXU+cf-3pkYeV8-quRog@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAE2XoE8HqY3XH-myj1Y-w4g9FM1mbzFXU+cf-3pkYeV8-quRog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/17/26 23:17, Yonggang Luo wrote:
> I'll prefer HELPER(raise_excp)

Yes, please.

r~

