Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DD3FF8850
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHF3i-0003x8-VP; Mon, 27 Apr 2026 02:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHF3g-0003wR-Mt
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:03:04 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHF3e-0007Qk-Vl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:03:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b150559bso77706415e9.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777269780; x=1777874580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RpI9ajCYW9UMi87GZ+YNncOmRzj6km66U9eU8wsRaME=;
 b=K9vPH5cPQuj+tgmzr41H9MoTaEYjXKGD7TY9EcyJh9nbjEwKRW54vxLiM0cvryfH/p
 6Z8VUS9rpfNDPJ/5s95aUy7YCxyxFBdGGouAUKg3y6jvCgM8uppuhL2E/hpXjxK/RFZL
 k6TgFUyamxy8MEKf4T3rgGTdgxgAiEx6i64ztjR2SffRjy7WQQBEDg2w85mkpWiIF+KN
 CEH7tj7S9x7rZKuEly0yOCsyTbfevGny3rRQaW/AAAlmuGjNThxBDBouPtisxjCX5pec
 EkT2iD2eT/qqHKCed053OC7k9dXkRIwkSiWFS6RQSun2VSnI/LRc06amt9MJ+m/XfY6f
 fjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777269780; x=1777874580;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RpI9ajCYW9UMi87GZ+YNncOmRzj6km66U9eU8wsRaME=;
 b=k5ftkii5qakBWNI3cNUk+McaMonXBJIsTVjB6CHTQqww/rYkKuiZtu6PyOrMQBhf1g
 rNAYfR11WLlYy++/Yb78+D3HXduIw5U12+VWv1ruiiSuE7NmsoOjf2QyoKDnLjk4qSka
 TQpPTnm05TYuovfEiVtSjoDN9chLdFjQETqxSBGF+JRjmNhm5xM5oPDPCqfHgWy458c9
 t/LI+uY+Tp980qnfLGCqPi9D13x/WMQSqj10OPWOIeq1oVNG/So/m+Ak7/VwE1/s30H8
 XhurW5Cg9958zXc9x0pYY5OgiTa60mvPz6MvyHPek5bGu/RXcZY9qVlvosfFFqmYNhQ/
 HAew==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DJJxeBXPWhIKRahGFuwGg9Vn2oLOUg4b+E9aFR1or2o+qJ1HE3AILVFlVaRGFPdlfsubeX3+nqz8c@nongnu.org
X-Gm-Message-State: AOJu0Yzh5XioZJGtQScbamXgE+LFrN3Gf4FU7rMqrUmOzN1HjONf0012
 wogUxM2WzJX5qi7fSdtSV+S+jIdLeSgv4gaRv8b/CQ8DqYxoE1eLavp91Ss9CAoakqY=
X-Gm-Gg: AeBDies3+kZpJzZ0wTY9yl/3EDgOV1+x1H8QDizi2IkA4RdJDH6fxnXdIK5r+y3Q4i8
 oeZYtj3FSVrYoFbpalXpwaMvSKiSubBrPye71IL0tAcL0Jv5GlGZR/KfARjlg6NgEKGyqgvsLwk
 d++9YwTayuMT9nGwkmztwlzyaGx34l51wj16osvdLcYIeN5QtcFcropmWMK1Bbgin5t/J+z6Qe1
 26qtIgJvF7iaKBl2RggHiOKormVKy/tdin75kCqag+3Ec8iUz99DaeR4LJFC3kxKFqmqNUOHln+
 GMj/gOhscYd3tl8vIVLIO0emZ7KTEgnEiD1xhpTm/VfXaTxi3Oq6bkgENL3lQuCPAzNC4EueHcb
 0IY2TEPRQZmXdsxAapH6R/FF0iInCZXyvUix440f113eJYbVUM09MmntpCNWswsODsZ6h8sxdnZ
 MlVmU3T44ZUKAIT9V2uBlXXq42kW0++Fy9JVpIbglEu84cZWvXYYIEpTb9Dz+yEqcy7xezkIxjL
 7FS
X-Received: by 2002:a05:600c:1390:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-488fb78ea6fmr603882105e9.29.1777269779801; 
 Sun, 26 Apr 2026 23:02:59 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a6124d7e7sm453556535e9.5.2026.04.26.23.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Apr 2026 23:02:59 -0700 (PDT)
Message-ID: <cc90c4de-6b8f-47dc-a52a-f032a1bcb685@linaro.org>
Date: Mon, 27 Apr 2026 08:02:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Flush errors by using exit() instead of
 _exit() in error path
To: Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>
Cc: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260425144852.46590-1-deller@kernel.org>
 <CANCZdfoOPvn0JJiF5Nar_UNEWMzmQCvEiTKV1vbuVFy2qiMpfQ@mail.gmail.com>
 <d54586b6-8213-48e7-9e7e-2c966948872d@gmx.de>
 <CANCZdfqa2XU9OHt3kJATkaU2D+g2=afRdjNvYE0o6Hx8YvFy0g@mail.gmail.com>
 <CAFEAcA-9A+sFfaJEF=AcCPkpDB-i+fbdG_uvn==utNFHjCtwkg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-9A+sFfaJEF=AcCPkpDB-i+fbdG_uvn==utNFHjCtwkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 26/4/26 15:06, Peter Maydell wrote:
> On Sat, 25 Apr 2026 at 16:51, Warner Losh <imp@bsdimp.com> wrote:
>> I don't think this will break anything. The printf can't possibly work, either
>> we must change it to a write or do the exit. exit is done everywhere else.
>> This has been wrong since:
>>
>> commit 03cfd8faa7ffb7201e2949b99c2f35b1fef7078b
>> Author: Laurent Vivier <laurent@vivier.eu>
>> Date:   Fri Aug 30 01:46:44 2013 +0200
>>
>>      linux-user: add support of binfmt_misc 'O' flag
>> ...
>> +    if (execfd < 0) {
>> +        printf("Error while loading %s: %s\n", filename, strerror(-execfd));
>> +        _exit(1);
>> +    }
>> ...
>> but the full commit log doesn't say why.
> 
> My guess is that the "print an error and exit" if() block was
> simply copied from the bit further down that does:
> 
>      if (ret != 0) {
>          printf("Error while loading %s: %s\n", exec_path, strerror(-ret));
>          _exit(EXIT_FAILURE);
>      }
> 
> for the loader_exec failure case. That one dates back to
> commit 74cd30b811cc2f in 2003, which changes some exit() calls
> to _exit(). I have no idea why, and the commit message is cryptic
> and useless. But it seems unlikely that the reason is still
> relevant today.

Could it be do discard any atexit() callback?


