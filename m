Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41626CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 02:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v49Hi-0004GP-Oq; Wed, 01 Oct 2025 22:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v49Hh-0004Fo-0t
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:43:09 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v49HW-0007sR-PZ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:43:07 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-330631e534eso626426a91.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 19:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759372968; x=1759977768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0arLxYg4xw4zIdDXcuBme143/eqPjLu5ZvaWFg+W6sY=;
 b=qRTs9xQYMqAp6AP1PYH8hEdrqp6Iz/feCV83JJslJO1WznHW6Cqii5w4MFieBLJM6E
 CisyE+dRZvNEjt+gDPFbuyZ18/crmgjuoZSH18HGz9tnH5b6rINhaTy8f/S/gvYx1fFW
 rnT/2f1RZ3iNg1bYDO3C0Wr8hU7hlNVB6jUA0dKlOB6ofNjdpqTqCt87S4tlxjETKNhR
 9YYoFBKolY0IejoKbarIlDh/Zk9/u4wPUI8JQCVsjzf5E+uDRtk8lw5dVaxkfwSNjiPz
 egcQoRwZK6tf4o6AEh+7OYfHYfzXS+3QpueVOtgLP8YTfT7X2f4mMcM2BuHlj7/UlF1U
 eLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759372968; x=1759977768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0arLxYg4xw4zIdDXcuBme143/eqPjLu5ZvaWFg+W6sY=;
 b=o+uJ0Qf6ebBbZ6dybTavO8RVMe3XiqVDCyot7AgnoZE0fTFDxsghb452mCQ1Ln7qrH
 zRxPv7r4ofRah2kGdehLbFa5DEfzPWfzFU+inwCmhkPEszPrILpj/Qy0uBAtaGF8hxcD
 /G3U3OoP9WaLAz0oHLpVX/Qf0IbM1Gvz8OORGTo4llxDE37cb/xuN+hkzAoe0iJ71mfA
 3gZo+iDUIMOWWfEyNUvHnUyCAAnKhuuK44xjVOKOJVPnR3B+OSzAS7sGZJQquCQ5ZvQS
 M5iy2HoaJvFuEt3Qzb94kR7Rvk+LBc4BKJUqgc2pDNMYLCHHX4H16z+Hsan4xxISyHJf
 GuGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo3F1XsVS9nZGExt7BfIavV5O6TTifrv5oYdRcbn/36ZgjCgovZW0dJFuIfCQ59fGoiw0ZNSjK+cY1@nongnu.org
X-Gm-Message-State: AOJu0YwUGw5D5GAS6qdrT4jUb1S8ZEdjTGNPQhYT8FlU1jtQ3+/0nPn5
 7GsUX6G6sBT/NgVWaE5rf4CslD49yMiuBxS5DKdLp1Nql0bknBa0RCJR++S12Y4t2fo=
X-Gm-Gg: ASbGncvbsh5yBqPW0ItiX6fbT+Vl719lwJWj10RzCatUqarnwLQACu4pG5BHBTgZ1k5
 m+mzB3qficGJrU+Mci3W53l++/Dqc7Wc6fQpPa7OC+zjPxQLG1Or/TvLY4CqOFrtHVUAz9rXPsB
 L1L7SNyqIUDdgTRg6FfmckuBg6gZ2d0CLJd1u9cO5ME/jPUELbCYzDRJPgvcxeQb8PPA6pCvLSc
 PKt5KpHdMS5PPHrrXeqR0wvLG0GzXW0S1uaJlFfl5KKXt6vBToyVYmAoVxAudAYSPbTcYsqxlN2
 it0uI0GehXL4mw9Ky5eUEMMH+yAkKxyc31c/0p/k5i4bapFSui1Bo7c02s8yA+vJG9tw9k6ASFi
 3ZqgWtPi3X/rI60ApFayoHfDuVeGypVEtyfwjOf+20Gw8JSq5W6LhbxXjVBDCcGM=
X-Google-Smtp-Source: AGHT+IHOHyQi6WG26g1S6RxuOrn7Ey+YgJgxY/FRr5dt8lQSSZph/5+gnOmgz6fJG9clj37v/GP+FA==
X-Received: by 2002:a17:90b:1811:b0:32b:c5a9:7be9 with SMTP id
 98e67ed59e1d1-339a6f36babmr6166248a91.25.1759372967533; 
 Wed, 01 Oct 2025 19:42:47 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.59.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a7039781sm3673145a91.26.2025.10.01.19.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 19:42:47 -0700 (PDT)
Message-ID: <69de1286-0750-47d1-bac6-26512a339018@linaro.org>
Date: Wed, 1 Oct 2025 23:42:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DOS 6.22 with LIM 4.0 Expanded Memory
To: "Daniel L. Srebnick" <dan@islenet.com>, qemu-devel@nongnu.org
References: <ebb4d277d49d53e55d9c0d56375df29981631c3e.camel@islenet.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <ebb4d277d49d53e55d9c0d56375df29981631c3e.camel@islenet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102b.google.com
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

Hi Dan,

On 10/1/25 19:14, Daniel L. Srebnick wrote:
> I have a need to run an old MSDOS 6.22 image with an application that
> makes use of EMS 4.0.
> 
> After some extensive testing, it seems that DOS' EMM386 driver cannot
> find a 64k page frame that it can use.  I can manually designate the
> block beginning at D800 as a page frame but then shortly after start
> the system hangs.

Certainly I'm not the right person to ask about DOS and i386 machines,
but I'm curious: why 0xD800 (54k)? Shouldn't the EMS window be in the
640K-1M range?


> I have a test program that is used to determine if the system is seeing
> the EMS as expected and this fails.
> 
> If anyone is interested in taking a look at this I'll provide the XML
> for the VM, a config.sys as well as the EMSTEST program which can be
> used to validate a proper environment.

I think that would be a start yes, but I really don't remember anybody
looking at DOS in QEMU in the last couple of years. The problem I can
see is that the original EMM386 driver is closed source so it would be
tricky to debug it and observe what action is possibly causing the VM
misbehavior (I'm not saying it's a VM issue). Maybe the issue can also
be reproduced with FreeDOS, where the EMS driver is open source and can,
no idea how, be debugged?

A command line to start the VM would be better than the XML file, IMHO.


> If this is not the right place to raise this issue please point me in
> the proper direction.

If it's an issue with one of the machines we support, yes. Better if it
reproduces with QEMU built from upstream master branch. The problem is:
how to confirm it's a VM issue and not an issue in the DOS sw stack?
Ideally, we need a much simpler reproducer for it. Also, is it a regression?
Like, does any other QEMU version runs the same sw stack without hangs? In
this case you could use the sw stack to bisect the QEMU code.


Cheers,
Gustavo

> 
> Many thanks,
> 
> Dan Srebnick
> 





