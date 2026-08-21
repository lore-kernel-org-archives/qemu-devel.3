Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B252C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFdN-0001Mo-6l; Thu, 20 Aug 2026 23:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxFdJ-0001K2-Tn
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 23:09:30 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxFdI-0002BR-DK
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 23:09:29 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cacf197759so7924065ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787281766; x=1787886566; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SAI6cFjbBZZAS1lEk5hZJUsQYoUGz9d8CpDsBK5EtOw=;
 b=YqW+ZTClvU6EufnVReJuH0gKdMEkQdMcTWoIwT/vT4ab71ylQX4oSHHY3L9HNt2Ltw
 LngbELBJRmpXJnKPXC78DYcCmeOB+BLMKPjslkaZGkTPABJosgjNg5a+5fUkAO2o6rSG
 B6edNWgO9tPuEuCAgd6d6skDCLXzFp/Gb8dcBl6X+yDV1KIBq1GCE05FDSO6zxBn6qtV
 kj3VX5MpZ2RKem0ZrNcZHXuJw2kx3pSNJlG0/uQoMwXjGxBX1Jxaz7jlwYiXd2qBeNa+
 Bna25k8lclBAW5gjirjiO5vEX0mHxBefrB+btQHd7hA39kMiQ5pnxbTizodY/nriyM1r
 0GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787281766; x=1787886566;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SAI6cFjbBZZAS1lEk5hZJUsQYoUGz9d8CpDsBK5EtOw=;
 b=ahYbH6r6CZ7jfjzzaHXuNDDH06ZxYvKuKk1eHUfyMjx7SaowaP7Xhwl6zq0mDkq3PS
 6umSwTgz1XMM4ukX5IlId9DAHeMp3qbsuE3tPsLkeiskJs4I94DRGS6OT6f5YkKc1FPC
 xuVupRx2qeZMTPj61CTJJDy+i3o0H0khVmy8geYN0eXbv28fP7I+rW5JO84TU9sMWB+q
 pBgZxaxMBdUMcNRo4f6K5pB44qkRtqXKtqTe3MhiIuae4hxU83vbdkRqI0y5bo/Uv+tP
 JobPDd5m2Hxopxzmz4XVtHwdgSY7WYWKQTqLok2keshwIBxtNYVGYE4Coi91C2fpqoTR
 lJBA==
X-Gm-Message-State: AFuF++mK1mXVXORLiwZDRGHWgTVysj4mKncrPI3da9TDcq4ZKkYwGino
 yVSq4wa+xB04qEK3MaaqLFzyo+kkeCHo+v5vxteezJ7onHcW8SXuC/IJ6bUtm4bgQQMBZ4tH41R
 ouxoV
X-Gm-Gg: AR+sD10g/NSrc8GIG8ovEqYvcYD3KNpVoik7DsuzIN1YBeUbZzgfx+sE7tH4NqxCjnb
 i1qEc3K3SRLppcJbsJSsLvToHy8TesOmcdw712d+oiN2DpqnlpmCnZzTN+w+Y12H8jXkIyrrM55
 0CpGRiQeuAiwcOeeuNJCEbowUyj1COzvKIYy86KILuAqqpVueit/VgsexsrSVghj/pKnlzliida
 F/Sb9gIobfubtKQgsnwRMNLXmcXpcTGlRqdG0WeMT4BWqby5At5XLOvSUWbjKr4KmlIIM04Viej
 uWNl8OM30Uklvco1a/DVf+6fdWbJWPB8PpZmJeaOCUtyu+Inn94cyvBrBD15CPqT89lJCI8cjT1
 p5aDx+jok7r1c5erwHY7gPMOOOnOv0Arkjgc8oz0qs/rr2mM2ZPZ9gziqGxczOb/YJo1NbtJGBv
 2iWOiLPd/j4b9gWgkjnz2ZXvNIjERge8iUTe1iQTyDBX5DVqkzCIP56FKMuc8L8va5DziR8/fAi
 usR
X-Received: by 2002:a17:90b:5846:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-395c3718ee4mr6404157a91.8.1787281766137; 
 Thu, 20 Aug 2026 20:09:26 -0700 (PDT)
Received: from [172.20.6.151] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4be445fsm1132893a91.10.2026.08.20.20.09.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 20:09:25 -0700 (PDT)
Message-ID: <ffa3dea3-14de-4b5a-b781-483925975190@linaro.org>
Date: Thu, 20 Aug 2026 20:09:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/53] CI, Rust, target/i386 changes for 2026-08-20
To: qemu-devel@nongnu.org
References: <20260820164957.1895963-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 8/20/26 09:49, Paolo Bonzini wrote:
> The following changes since commit d49f87606ac1a6e15701b26c1b16c5d7e948ffcb:
> 
>    Merge tag 'linux-user-pull-request' ofhttps://github.com/hdeller/qemu-hppa into staging (2026-08-12 15:21:53 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 3ac34c6d25d84353c882ab0e11ea25229d4f1a48:
> 
>    rust: remove bilge crate (2026-08-20 09:24:57 +0200)
> 
> ----------------------------------------------------------------
> * dockerfiles: cleanup, update CentOS 9 container to Python 3.11
> * rust: fix issues in bits crate
> * rust: replace bilge dependency with bitfield-struct
> * rust: update build system for Meson 1.12.0
> * serial: fix hot-unplug issue
> * target/i386: emulate: simplify flags conversion and storage
> * target/i386: tcg: small fixes
> * target/i386: mshv: complete migration support
> * target/i386: sev: add support for SEV features
> * target/i386: whpx: bugfixes


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

