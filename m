Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC78C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 08:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7qdL-0002PF-5Q; Sat, 19 Sep 2026 04:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7qdF-0002ND-Qw
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:41:15 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7qdA-0005Kn-2T
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:41:13 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8693af0d7c4so1728498b3a.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789807266; x=1790412066; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eHdxLmUj0LMv+NPMwDsc3wsCddiFEfoKqwE5w4PmUy8=;
 b=GsJ+5YHawgY9M7WNuQ+RLvTKZVHyRHZwADOFzteU2Q1QgtnnxSAb8C2Nc+c4Gpkh8r
 fZWF27z+FJ5xK+SGsBRtczzk59fAPwQD4/sBdoJnc0ajYwJ4MwmfMq3EvVFSsPphg7wX
 c6YhkRw97P0fMCThXO/HgWzzsiXEv0fLb6uNRDPeLfDcUIRAB+uVClZ5SA++ssnKn803
 mYT3oemp/eCNmySHrchRQE0RUCybRqlcDcIw7xR2lMdUdN7F+kWbqrgv5BMsHafBFtTb
 g6T9BAI+AJ8BxLJOXzjnK4TYoHni4PVqtVVHFvBxjuokGsM5ydYhTvM+N+mGHRswzCME
 bVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789807266; x=1790412066;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eHdxLmUj0LMv+NPMwDsc3wsCddiFEfoKqwE5w4PmUy8=;
 b=htbUM+AubFwH/Jvr+7bMlFAxAZPHgzWrNCR5DGuwIEZ+jlP5SOByZAf2I2leR1s1pm
 6JpLlBZfO4uRWq86BFTxUcivLm/dQO5Vvoh/y+lyyk6Tuox919+AnOv0DOillQ9slzFy
 4nmMni+Zl6GaBNnwUZpgxWgyASYRdaNwg0nFalmmFKBj6mbRoFIXMZNoLjsNMg0CtKZA
 OzGSjkPTahad68klu5RJnB/x1p1SU7Drws8y0Naq08/E3S0LCUuRcepmULfv99d2sWvz
 cRRSPjZjyHA64AfLnIM1UJI9FPytOi9Z8tevDxwwbyJqjHHJ7AHlCmTjayZhR81itb7C
 l0tA==
X-Gm-Message-State: AFuF++mpcSwpHPLdskxEzsNm/Z9SBbouNXw3qrfeAZ5auFFBh/Cxo3Rm
 1o6daADuY6Xbvmm25qfkZWF4yFD+d5tM8rem4dIoamdj1kRy0INdzsqbozJ5Yz06oM8=
X-Gm-Gg: AYBFou1y2WJgWnXY7lwBBXdZzERbM0UO+smj1XAQIMxaGADK0jnFwDwvx4H4KIBvBmN
 T7/L50pLKzRivRBa1NzhoFDmjUIru/CPoVl75A51JV41wpN5tgLh3xNWIjNKur0A3uuZ1ldDFDf
 pCgJqxS8xQLO2xL7Js35/c5+F+eMLs5wpqamBP82212BRvkGtDGzMwUpHKwHFE+RDTvOeNx3Lse
 Mg/5RwdtrYLqfnp6qQBc8NvID5mblCc3D26sZnVvuQpv3xN5maDg69taynwoWzJ1EKSFOIX7tqB
 8BYEYfsd7/CLbJmy8xVavWKVn0Ay7jTi8dDzMLoQEafaXFgoJmBcQy1svpMY0Qz5EVyakjLNrHp
 vTfclZBAA++stlvdOaA9MeVVIxTxQMmhRiLJBRYsrUNwaDx4QYChdAY0SyaJ7GSEbZUdPp8hon7
 mhm0E1I01BHl5tW+Pl/9Y9aPtq6mnknd8F/Aazmbru3p0pKobU7YsyPegyxOkBb4jPpiYaW2Pe9
 zVU+dVG/nNI74z2Nvjujr2lXTqJlMlUw0+G2nnYfM55eOsDFfO2BbQn0Hc=
X-Received: by 2002:a05:6a20:244e:b0:3dd:a197:cf31 with SMTP id
 adf61e73a8af0-3dda197da70mr2519664637.85.1789807266062; 
 Sat, 19 Sep 2026 01:41:06 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:9141:cc7:be11:1ef7?
 ([2603:800c:7900:ed00:9141:cc7:be11:1ef7])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55a4378sm4245381c88.4.2026.09.19.01.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2026 01:41:05 -0700 (PDT)
Message-ID: <288f6e74-4ddd-4b8b-b6e3-1148454bcfc8@linaro.org>
Date: Fri, 18 Sep 2026 22:41:02 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/riscv64: Set vtype before whole-register vector loads
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: qemu-devel@nongnu.org, max.chou@sifive.com
References: <mhng-9266D400-F468-4D4D-99CB-0F754C22F36D@Palmers-Mini.rwc.dabbelt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <mhng-9266D400-F468-4D4D-99CB-0F754C22F36D@Palmers-Mini.rwc.dabbelt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On 9/18/26 12:38, Palmer Dabbelt wrote:
> That said, if I understand the ISA correctly, we need a valid vector
> configuration before executing any V instruction (assuming the post-
> change ISA), so I think we could also just throw something like this
> in there and maybe catch some mistakes in the future?
Yes, that seems reasonable.

While you're at it, can I get you to look at

https://patchew.org/QEMU/20260914000814.785155-1-richard.henderson@linaro.org/

which does something similar in adding assertions against the integer 
instruction formats.


r~

