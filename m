Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C2ECCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tQM-0007bj-OM; Thu, 09 Oct 2025 12:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tQJ-0007bB-N3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:23:23 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tQG-00014j-M6
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:23:23 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-339d53f4960so1310456a91.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760026995; x=1760631795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sh6r/H5gespgATSZUSS/3kbN3pXdo1bp2u3FzJXBn7E=;
 b=xeX59biJM7uTz+VNoJDEjs7JJXABTC8Chv61PrNIdsnz3C1OTwlAkwGhNmDZ1iDKLN
 /04vQYElsnBwZGrOKa8PNfvn6wMmicoXxEa6dX4Tr0DNDOE7gt4Tk+3y/zhoSM39bP7J
 mE5kEa/2GRZxPA3KS/axUHqfMGdSFGhXNa793Zz8Rnry3N2kfEp0Ds/w8KNwAZvBS3E9
 6CYMEoXhEdDIzcZgjjlDhS5PzGPZdGGsq5Pn8gtFUbaVtvJDqWlsVl2i0Nu3v7K88rjC
 fYKAOZhV0FEkjS5/5ujWPZJnDOvp9a+bXGQXXFSCyc1zEID2XsiV+e8xuCmt4wM+Nsjk
 01WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760026995; x=1760631795;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sh6r/H5gespgATSZUSS/3kbN3pXdo1bp2u3FzJXBn7E=;
 b=kkML9npy020yzXfEmdWEC+wGlgj7XxMc6BVfgcVG3aCkEPxK9bNT5MFhz/4WFnBEEI
 rsd/1Ptcx+OjFypYZkuhyzvDtknc28tyxdCZGvzFjjnnWK4Qgv/4FSxBV2z7GYCGgJIn
 /QutkJetVWPcWnbs7J5QMWf1QR5Q8yYWAa5wIHveX005WcQHTBysbyWC82tUhVmGZVEp
 kxUldwPUhV6hIg5FIEhb5maRVlZsqmUKi8AYfK7J/7K4h4c/ZfT0iJ7v3ABGscmlgtOt
 COnb4/eh1Gct1hLclSp5oT9WB8Cj0ngAP/Om/ZzcaO3FLfAPB+s9HIJ07CtKT28RpZaJ
 pPAA==
X-Gm-Message-State: AOJu0YwRGsgi+EODdcphomDKcw1Ry1SshDfVXFP4zv6wvzuM5CoRBi6D
 +WWqo/nmtHZ4evMUELqFTSDf/+pgG9nAQnXamsTTn4In8R939yNcs7EfOeXkl9DzKlbcz8FRhQO
 /ULLK0+Y=
X-Gm-Gg: ASbGncsrLBc9jL8c1e77eA+Hh6VZWzU84/2wWS1ioYzOk1QO7N1zhAIh22QFthxQADB
 IptQ/HpWdUGHV5AquyJv6s3vo1LgmRYixVVqj7vzdLXtfNq4djynyYnjX+gcGb4E4kRYSqqXMOJ
 sAXHhzU+Q+msxUNbwP9Du3MR3j6YuzcE5HcOGD57yNsf1yEETNEhg6hkNkANiXJjgVXYVzVl4pj
 0qEfK6itot0taI4hN24hMthRl7HpAtncUCFooFnX02pX5CW/2YqGukE9sTRp0iPoNpylyl/Um9A
 8puA8euU2XR5om0Qmajr67WFVFLK0bkXet+KLWjPfsATbN/0MChjhYl+sU3nu/GMqFzR+bGs442
 z39nvRrE95U5AIsfFzVFupCKXOd7kPDkjJa2QgAoyw/fb7GmJGG13tS7bxOMzEP6D
X-Google-Smtp-Source: AGHT+IFAYMYiuqXhczNwh2/zgxc9jxC1VTBumpQZ277j/Y1IQr7R1B3VtCuhigLOa0TPFhxFuKaxbQ==
X-Received: by 2002:a17:90b:1c0a:b0:32d:e75a:5009 with SMTP id
 98e67ed59e1d1-33b5114d4f2mr10953608a91.1.1760026995255; 
 Thu, 09 Oct 2025 09:23:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b61da88aasm217192a91.21.2025.10.09.09.23.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:23:14 -0700 (PDT)
Message-ID: <df0a333e-723f-4be2-8951-a7c6dd6d9413@linaro.org>
Date: Thu, 9 Oct 2025 09:23:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] loongarch-to-apply queue
To: qemu-devel@nongnu.org
References: <20251009123601.2380901-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009123601.2380901-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 10/9/25 05:35, Song Gao wrote:
> The following changes since commit 37ad0e48e9fd58b170abbf31c18a994346f62ed7:
> 
>    Merge tag 'pull-10.2-maintainer-071025-1' ofhttps://gitlab.com/stsquad/qemu into staging (2025-10-07 08:46:28 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/gaosong715/qemu.git tags/pull-loongarch-20251009
> 
> for you to fetch changes up to fa6af7f6bf6dbc4c83595905d2572ad86358aa67:
> 
>    target/loongarch: Define loongarch_exception_name() as static (2025-10-09 19:11:37 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20251009


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

