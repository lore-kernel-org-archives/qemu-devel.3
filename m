Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91A3E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 10:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM36v-0008UD-Bt; Fri, 13 Dec 2024 05:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM36t-0008U3-RT
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 05:41:27 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM36s-0000pX-3f
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 05:41:27 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3862a921123so1140473f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 02:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734086484; x=1734691284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oMzkEQKl3c2//nxe8VClfHqkS3BbZJtumlv2lSlRV0g=;
 b=z2QvPt9zU8R71L7D8DMIzwuR8ulrRkA1n/enWgK0IGQ9s0TPVR18x8xDO2WBOYTgba
 oEVPz+5Ki0+CR/Unz8OSS3qGMzR8QxJswSyqJf1T4oG2hYiSDBong4p6HXOUXjsj/6dh
 lvK3KXxiAOPnnA2fLLnJW3PZA7QIBtdkLxAtFIxd7Of5oyDKEP5XTYFzsDe5oADTOMws
 zRUBHcnCJHAPvHK8xukPhGfKZserLwZF1IHp2wN46DuIzzEwKECsywteCYV/BVrBhnZ6
 ueq7DZOZJAXADujpRfsA6FxvRHgIVymoqbtaG4wFsx6hM28ss+aKfERGiBYS0bP3ErSY
 kgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734086484; x=1734691284;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oMzkEQKl3c2//nxe8VClfHqkS3BbZJtumlv2lSlRV0g=;
 b=X0oiAu+ClrMMzDqxwPPvbS0HceVsiGDk0QPMY5DQKETHMUZ//ewOyBJGF9OBhIaml2
 DMAPuT4yAjv0FS4ersI75XWqEY/JW+HX/ZFfPHQCkg1kjYZxeZwyzc7BaoDHEDi5nyuI
 CLz2fbUv45aABFTQ3Kiiwvk9FOt1osd/BkdYNO2RnByNayzf0rjbCaokeXpfJoVymwAe
 sTQbFSubvybhwD9X9VRrk1wspLf2y1iNHQqtNJpxBKes/kx21Uo6s+JfoRooxnSFBbIW
 7I2E0TnpLIavgaShW0aa0N7OvODswJ2kqy0p++2rUBamvmGwgNXrqO5350PUOS00l5p0
 FuEw==
X-Gm-Message-State: AOJu0YyiiPRl04AIF39GOrzq+aiuxcYOmiLOtYrHHiIh8EcWXNp+SfXg
 BZqMKdHzRvew5FH7VUHY+0SvOMshgUhlnY00tHhyAqUS3cCCGRR4xFuB0GnH6xA=
X-Gm-Gg: ASbGncsRkLed6vQHkVyt/6BuM0pbvK/1BGxpgxnP+4hdXYeKv7mbWJp6ol3oYblRFGz
 EcZ0JIbSas/fk3ktoE+0MdFQNAWPYIxOKbJvkng3ussjVCLLLC7ZaL2uQZzJCq3pDBsZDD9VdbS
 3LwzF21AokhhfAgXtMrj99YTMhoQpJeUpHsSRBfo8eF2dQfJe1OqY0oLxVj9pLXfm0iAVywT1Fa
 k7fGtS3quf2NmPYkITzrT3Lgv8W41WMTnYEIxvA2ERH+UEbeJY9RB/AKlI+VXEVPkPHj9cZoINP
 IshIO6wrmUOmeZ8DtZ9DMvOa
X-Google-Smtp-Source: AGHT+IHgOY2dzmM+yYSsVZL2+6BFRB/EtFTVc6pZX+lHBAA7u0FmAnooLu0IJuhHNloGzvwCn7+OUA==
X-Received: by 2002:a5d:5f53:0:b0:385:c511:240a with SMTP id
 ffacd0b85a97d-38880ad9d4cmr1524310f8f.25.1734086484095; 
 Fri, 13 Dec 2024 02:41:24 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824be9cesm6628789f8f.50.2024.12.13.02.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 02:41:23 -0800 (PST)
Message-ID: <6bfaf34c-84c2-487c-997f-6aaa0ad2506f@linaro.org>
Date: Fri, 13 Dec 2024 11:41:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] tcg patch queue
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20241212204818.2468583-1-richard.henderson@linaro.org>
 <20241213012124.GA395472@fedora>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241213012124.GA395472@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi Stefan,

On 13/12/24 02:21, Stefan Hajnoczi wrote:
> Applied, thanks.

I guess you are pushing to the 'master' of your personal
repository, not the QEMU project's one.

