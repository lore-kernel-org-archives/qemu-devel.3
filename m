Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA9EC43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKGS-0006Bp-6j; Thu, 02 Jul 2026 12:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1wfKGR-0006Bf-9a
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:27:47 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1wfKGP-0005Rb-9x
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:27:47 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-37fc01a7835so1535301a91.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20251104.gappssmtp.com; s=20251104; t=1783009663; x=1783614463;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:to
 :from:cc:in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rOeqxOtZwjDWkTGmQycoQ2REh3vUsAgJGmTMFLoe1G4=;
 b=YQ0myY3qRcT878tZ7UYXocVry3PqAfA925x+uDVEU2yYjp52MQ+CbZ6SPFtY9SmEBE
 zmp1qgndL/BB5I22i4VErZVI5V877gAIl3M3iKr/jBG7mENwh6Lw0DPf3kxdqzMYAzRF
 3n/+adjdLT1oRrGd/aolHgeQ/NJo9dNkTarxxlDeTAgCLbQ5KFf4+t1e13TDY0kQoPbY
 J8YTjf11HAjII1yt5FWELF/jfNUVW1xxdbfPLPrPYeqS4WNsn+FFVL3kyc9gx5jPi8SE
 OF79rflcQkIbLBvz1pvcj+1xffOxn7k4YBj/e7dlahQU2lJX40nXh+eWWKCgdfypJ930
 WZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783009663; x=1783614463;
 h=content-transfer-encoding:content-type:mime-version:message-id:to
 :from:cc:in-reply-to:subject:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rOeqxOtZwjDWkTGmQycoQ2REh3vUsAgJGmTMFLoe1G4=;
 b=KUnUqCQnrzkBpAvknZ+aPgkOJAS7T//gxPBgtbjc1GaxJwZ2iUoRtoLji1nvRWCsRP
 FltwiS5mGmckf4wdFU85xnYXS5pdRKq1jWWQQATVIxRuuaQincKHwrRre38k6McDCdDk
 yLQ+bChU/UNG2c3r2ew7qqPQujyI90k/L4lCvwOzxmPS+eOROKmeV3jzHGMSZdTy2oaO
 Dz2vQvdK9Ey+Qm250+kkxalVrKVZZaZSPZe4NUqcXs9Ox2FXNPZPIqwNK94LXcSMys44
 GOFWoX+JS+D0sNpUt6lBN+kY5K3hqKqmqvPQhpT/JNAOCBGgnjQaWyR88V0DpCjHvtRH
 cgcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdbfSzBbld5ly2U0M2SoQFCO5xjD82Y+88puuJQy++T7uyF+5B1aXU2NK9dnKk0wONYWrJFsj/fzI8@nongnu.org
X-Gm-Message-State: AOJu0YyvAEFRkWN80+pHd9+fd7I1wbqzc0JEk3vwZ/Vh93/Mx/xmpZC9
 rMEr6u0HuCB5uAQcEA9RIiS+0J7QMfJV0aMqLC3Bx2cWaTH8LeKwkTMGhFajM0o5u74=
X-Gm-Gg: AfdE7ck6SVl0lsgulqgCvljTI3uYpm+xMULavRETLqbmxpYG3j3YIiZZSWiL3/VjRtR
 GaVSh4sK5f40EEs2+pve6b4hqkXbGvMQolfGACZJgRoAsr246YwCvcbaKeCMExDxJUytb6bWIXU
 XSon8ZztNzhfcpXhNoQECPyPI+vxb30LjFxeE0oi7g940J5E3Oh5uISVbIoMZE0J/8qe1FrMVYk
 ZV0xkIi3B2RpuG5NAZ7B5a96JNofTB+GSwUvphpJ8FSxYfA3CYU/O+VoK/R7divDRapZL92NH+F
 hB1CV4rQvGGbXPARmCWocV1mRgZS5p8/DeZ5JWk2jeIvXX3gWbI8qUTfQUK72HnIVEFJthvKtjV
 EfY2+r7HIvWWzY1VJ+1Ro1ZwTICYBVuTGym7S0UNTqUDSYS7wSw+CAB04PcCK5lBARoLn5+Ex+i
 yn2skAYIIWWsANKbsxzg81GA==
X-Received: by 2002:a17:90b:524c:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-380ba87b0c9mr6113992a91.1.1783009662756; 
 Thu, 02 Jul 2026 09:27:42 -0700 (PDT)
Received: from localhost ([12.38.208.106]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f116065c5sm8905621eec.11.2026.07.02.09.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:27:41 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:27:41 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Jul 2026 09:27:37 PDT (-0700)
Subject: Re: OpenSBI docker image RISC-V crosstool gcc URLs 404
In-Reply-To: <5be16244-7148-4691-8ee2-669a71b0a1a4@redhat.com>
CC: stefanha@gmail.com, Bin Meng <bmeng.cn@gmail.com>, qemu-devel@nongnu.org, 
 philmd@mailo.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: thuth@redhat.com
Message-ID: <mhng-FD339FD6-9FC0-4E9C-9303-6F4211BB5A7A@Palmers-MacBook-Pro.local>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=palmer@dabbelt.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 02 Jul 2026 05:12:47 PDT (-0700), thuth@redhat.com wrote:
> On 02/07/2026 12.30, Stefan Hajnoczi wrote:
>> Hi,
>> The docker-opensbi job has started failing because the crosstool gcc
>> URLs in .gitlab-ci.d/opensbi/Dockerfile are not working:
>>
>> #8 [3/4] RUN wget -O -
>> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz
>> | tar -C /opt -xJ
>> #8 0.510 --2026-07-02 10:11:48--
>> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz
>> #8 0.511 Resolving mirrors.edge.kernel.org
>> (mirrors.edge.kernel.org)... 142.0.200.124, 2605:f480:58:1:0:1994:3:14
>> #8 0.579 Connecting to mirrors.edge.kernel.org
>> (mirrors.edge.kernel.org)|142.0.200.124|:443... connected.
>> #8 0.643 HTTP request sent, awaiting response... 404 Not Found
>> #8 0.805 2026-07-02 10:11:49 ERROR 404: Not Found.
>> #8 0.805
>> #8 0.805 xz: (stdin): File format not recognized
>> #8 0.805 tar: Child returned status 1
>> #8 0.805 tar: Error is not recoverable: exiting now
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/15145227587
>>
>> Maybe it's time to upgrade to a newer gcc version that is still available?

There's been a kernel.org bug that dropped some files, so maybe they'll 
just come back?

https://status.linuxfoundation.org/incidents/3y1k8b4ky71t

> Remind me, why do we build the openbsi image in the *QEMU* CI at all? We
> don't do that for any other subprojects in the roms/ folder, do we?

I remember messing with this at some point, but it's been a long time so 
I don't know why we'd be doing it this way vs another.  It's possible 
this is just because there's no standard RISC-V platform, so we have to 
build firmware images for each (which would make firmware distribution 
more complicated).

>
>   Thomas

