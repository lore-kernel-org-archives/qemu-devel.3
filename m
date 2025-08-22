Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971F0CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSnN-0004Pc-Ih; Fri, 22 Aug 2025 10:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upSnJ-0004O3-Lf
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:31:06 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upSn7-0001N8-EZ
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:31:04 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b47174beb13so1517014a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755873047; x=1756477847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PLNTU53ljORTky88qET0MLPgGguVw0bEU3PpVKGMfpk=;
 b=rqfrX232s1Z7ZGSmBnvV52BA/P5Dx0TL5P+N8NEk13IMMUX+jTiXIOCybu/Je+KBYf
 7RMh20HZd9ePl34gLi+NrtiqE/axjQaqMtP7b+a4P+9aqmHkVr2JcJCqFnxqcJparYhJ
 L4N7Ybj0tJorBcZPj4GdF5mUICMOHaG4F3D2NleTPF9Ck+dJN3mnOAID0sARKhVJ2T8i
 rhRy+kXFJc68kJN78CC+KlVxo+Kh2gWeUFJSJbyASS/wEjMPXhhM+zgL4rQyAUpce88P
 82zmuizz1bIh/znTWkO1kjPeKOZ5YfEbfY84Qzu0kS7+wZsii7lFSt9PCwn0Q34RDjQq
 p+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755873047; x=1756477847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PLNTU53ljORTky88qET0MLPgGguVw0bEU3PpVKGMfpk=;
 b=MAO7p6Sk+VTkl1dOnEaiJj5hPw+IZhdhM8doNA6ZxYkjTz5fuvdvB44NQemsrKKhSl
 UqmNvnIrPwP8mebTpl7XYug5ThNvlf9gIWelcOqSe578hUZ3afqzGfgOP2Ij0Znb2ql7
 F5wOG6nCCdlseuDHOf/MpQ9WmGtEOLjFNbyMi8igKaw2BzJiX2ZxHTSDlxC/Wz+VZi+k
 74ilvPSsuARg3v38UoBKHu+fPRkAm1l57sqw6O+a7mkbWFHDov48YXSAYifSP95qd4Nx
 3rQtov5kM5Af4ITQjokMKn7Y+sfZebktATW9r/AoaK1na4BRcU2z5fczi7uRb45OWzlb
 OLsQ==
X-Gm-Message-State: AOJu0Yy80k4PkGbgjaKvrAs0MCwWwZxEl5GtmoGUmwp3yTnnSxys4HhH
 EkJ5KMIVcg6/kfuU9XiZTNJSlyhc1QWSq35BlEAVCbSPK3P152GnuHB6yadq9eyJ2oAsPMITIhJ
 ePZt8kZSGcQ==
X-Gm-Gg: ASbGncvxAbkx2z99bSPmP4eKJdwsLnyqXmel9qCnxNLRdr/YCCuN/8O6WlX14f5O6i+
 j1/OJt5xbM7AtCIayEu6S5k5HX+WCm0fYk7vhRzS/ydAlLcx9dLBSnLSyJtLtEJUNvYU9J4zL/2
 B6DT5W6M2+lOSeFGTFzzKK5rIOQwsPE0Pcr8M7aRxD6f1l+t2PSJxkyuDx9Ihli/8/KDIHwRNqn
 +4OblH67yF26JdnXQu7EP6b08orQ+pAZzyteAFuneySbj7lS0RplllmwOEokTexBlwGs6moo3nV
 NwZlZELceh1iTkTsbsF2vLcefsS+oFQ6va/0Ywb038PAUETVzoAQonisPeXo2L3jXJW6AJug3z3
 ux4qH+ScNzDhIQlzz1Y+/QaKs/7Ee5VTVRsWF
X-Google-Smtp-Source: AGHT+IHdGnrufYkXQDMnfMkqp92dNheALr5avMcLu9wzfRt4yEfdNfG6VnnrxTCibC4VsHO2KexuMQ==
X-Received: by 2002:a17:903:1ae4:b0:235:e8da:8d1 with SMTP id
 d9443c01a7336-2462edc46ffmr43143735ad.8.1755873047120; 
 Fri, 22 Aug 2025 07:30:47 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2465ccc53a2sm4790465ad.88.2025.08.22.07.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 07:30:46 -0700 (PDT)
Message-ID: <8d706a95-9f90-4ea6-a9bd-e39a2b84e768@linaro.org>
Date: Fri, 22 Aug 2025 07:30:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] single-binary: compile some top level files once
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2025-07-30 15:05, Pierrick Bouvier wrote:
> We still have some files left on top files that are compiled per target. Start
> with the ones included in this series.
> 
> v2
> --
> 
> - rebase cleanly on top of master
> - remove empty page-target.c file
> 
> Pierrick Bouvier (3):
>    cpu-target: build compilation unit once for user/system
>    include/exec/target_page.h: move page-target.c to header
>    system/main.c: compile only once
> 
>   meson.build                |  9 +++++----
>   include/exec/target_page.h | 11 ++++++++++-
>   cpu-target.c               |  5 -----
>   page-target.c              | 21 ---------------------
>   target-info-stub.c         |  4 ++++
>   system/meson.build         |  1 +
>   6 files changed, 20 insertions(+), 31 deletions(-)
>   delete mode 100644 page-target.c
> 

Ping on this series.
I'll be out next week, but it should be ready to be pulled once the 
trunk reopens.

Regards,
Pierrick

