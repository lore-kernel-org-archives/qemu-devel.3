Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C216DC982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7dOO-00062H-LN; Fri, 18 Sep 2026 14:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7dNn-0005yk-Mc
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 14:32:30 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7dNk-0004af-NF
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 14:32:21 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 41be03b00d2f7-cc515bef69dso735343a12.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789756339; x=1790361139; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dxSarQg+McxfKDJldMmFZBH+EBNZ3k/Z35T1ze68w3c=;
 b=RelbdhTPM3GogJJxrjy/IPFZe3QVUIVobggjhVTSqUJKONFEjYL8EIsnerJ3Q03WGZ
 gWn7mH4QWPasCCsYP2hOr3z+SbDZvY5ErH7RUBt894ncJiDtnbMprWzAxxejsRVZJP+E
 gTlZGk4HYZ9IPlYA3/GvC+M3/niZ++sJ2WnVDaAN+KjBR1FnKH3YYhenXtSiPjYafnW1
 k+KC7zpzgKuQnHd2oDvm8DCzIGoW/3YkWmlmvimyK8bNjcccZl3vCQBXMK7ASq7GmmvU
 maP4QpASm6netKJmTL7R/iXUBZ+JMfxjpHL3pTNd87zZiACyPDcGy5laxC87eIORtaHm
 2Azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789756339; x=1790361139;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dxSarQg+McxfKDJldMmFZBH+EBNZ3k/Z35T1ze68w3c=;
 b=z6ypsnshWdmA4dSVxuCmtitSehYuOI4wZO/hqh7Ksv2Ji4GzSdr6YHu9r6S4eIxXpD
 PkRe6VNJIhFd0FeURPawOYmH1O1isFgH+poMhYdyXQsQKS0vQKUXwEva5j0cKwuUNOls
 hWrIgE493wlUDe4GK4NIMg8EAvPsUlUURMkIcqaHWrXL/sxt9QmDz/5qsEYSjXmcMGES
 //E7mZwandAPA2hWdcO7TQ3jIinMnCM/BOuy7AAt/8WZcrwTwP9nCWgsUeYcKE5O12D9
 5wwQyBeMJF0ZuUlm3WVJ6lEg60L8trYobRVoqT349PiYJDLGeRuj95EDJdb8w+TWmxAz
 xSZQ==
X-Gm-Message-State: AFuF++kOuqMloe75eHqG2nyO30wnSMrChyQhgWrj+rn/qQUXuRckR83I
 vDWnslW+MbenJH9uLuRzadywPbfFC0HSCSBqKjVY6Awd/FnydWWgWlHagfFgVJaiVkE=
X-Gm-Gg: AYBFou1RurYcdpC3vuUCuDHzsDw5Lzn7j+pG4Ex6svjdqGuSZ4rqJpr/UIQrB2h1IeQ
 acv8o4WlLe3+kymbKwTPm5FSCKYIpZ6YfV6iL/eGjYpdTvpxMPfthDeRsrZWMNvjuopFnlJXwny
 MYXo4uKiu++x5Wi+uYiTFu9QDUyt0smnIWL4B/MKpuW/N8AWZmCZXUQy8CURQZ700J1oeqFdMDW
 MzCsn8FuP8FUSIf0+P0eIcjMZu+4nuAu5i0rKInvsP2PD5nHBLPAW4EG91w6J4A+mQDbZ7U5pfd
 jmzqutRGg7EIHDCI3fzfEgOYH1pm9aWZVl05bUNee16gREwMPIFknR2m8QHp03hLbHzDd8lT5Ro
 flgaQ1OtwLD3NofqWddnHMLmvPkKBFUPu9JVxVvPRJJArP0UctyK+QTeyYKdDNbo0Nlooja8Y95
 YrXcpR7EpVEttFCJapvkjSDrrRtUrogtgEx6YrjYqzVOA/ybjde9es2HfvHLBy9s4inEihR0Aon
 w4X5tPSJTH1tPbVVAK+1wz2QJIONk+jDck+BIy57FqGUn1LcJ2y9TCURQS2rNfVE9NdnSc=
X-Received: by 2002:a17:90a:d88b:b0:39e:6c6a:2091 with SMTP id
 98e67ed59e1d1-39e6c6a22d6mr706133a91.50.1789756338730; 
 Fri, 18 Sep 2026 11:32:18 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:317e:3514:d7db:974c?
 ([2603:800c:7900:ed00:317e:3514:d7db:974c])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55ab3a3sm549882c88.5.2026.09.18.11.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 11:32:17 -0700 (PDT)
Message-ID: <5bc81802-f243-4faf-822a-04adb5717563@linaro.org>
Date: Fri, 18 Sep 2026 07:58:38 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic from
 docker.py
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
 <87fqz77dln.fsf@draig.linaro.org>
 <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
 <96e3f93f-a12f-4d18-badd-2ea60efc715b@linaro.org>
 <26dff9eb-b48b-4fd1-822a-806c3e83aadd@oss.qualcomm.com>
 <87a4pf6moc.fsf@draig.linaro.org>
 <d1cf4f82-5604-47b1-887c-99d69cf1b754@oss.qualcomm.com>
 <87y0cy6ace.fsf@draig.linaro.org>
 <7393baca-7746-4211-94cd-e0400cb864b2@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <7393baca-7746-4211-94cd-e0400cb864b2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0c.google.com
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

On 9/18/26 07:07, Pierrick Bouvier wrote:
>    # finally create a top level target to rebuild all tests
>    alias_target('tcg-tests', exe_targets)

FWIW, that used to be called build-tcg.


r~

