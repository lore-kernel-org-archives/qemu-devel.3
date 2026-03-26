Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C487E10AB800
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5pio-0003pj-3E; Thu, 26 Mar 2026 14:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5pig-0003pG-QE
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:46:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5pie-0001l9-HV
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:46:14 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2b042533de1so7495935ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774550769; x=1775155569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=06CLszYF3UpqeoEHTtkZtfmlnUqGvrFEWdMBRGtDlD4=;
 b=gvn58aHNUBTeLr1F4VDSYsn33UdP5ECH++04Nh67nsqAu4qqoyk/497SWX1SwIOxHl
 sgOTaM1KEOqs+vWoG04J+xcFo53HLHXXKlM173osppBATFVENSPpDDgQTKWp8eG4PkKz
 AFlvGWdgOO0aDRaltyLisl/ExwXZTuzVLZdrHbOCQDalB4h9A+3Rz+aBDgNsIDvZ4PgM
 O96WLXlTvQEsvql2qs9B6C7NvRAntHFNEsq1ZfjDys48h3yyXuVPyJ1sfHerkDbnsMFb
 T1pGAcNrUC230wITlktEnLwnHjjG3v0mQhYwHaZQiqjRy3pbQBW+j2H6I8TWL3q2qMmo
 XQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774550769; x=1775155569;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=06CLszYF3UpqeoEHTtkZtfmlnUqGvrFEWdMBRGtDlD4=;
 b=i9bsJ9BRsDY7gqearToDrmwc1glm1sfeoHyoQuR4IpOoMKtB/IazUD+WdTq6UlWxDL
 IkI9nmixpTL36it6BSwKi55sjOZY9FriLPzz3ymYvPhkwhV9uWbY4p64bHhkXmee3W1l
 wG1RRATER29oOGUQGIOnLsaunE9DV97CKUtyoxZWhyYKElWlZK9/XfC/+K6zF4mIeFuu
 xaR8/rB8wR51rPJ1XudeuRx3x6T7nQIfVxwbdeVnTAPSnhosNhPa7MeMuCHsIgJqgZ0X
 D1wDVHlRg8iB1keDPwSVR+Sva2Y4zJRzNSWsQE18PtOWT8M8MhclWk3LIGe6qOq/XDaB
 dcXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWIa+OEG39Z0LHNRCMi24+jxUj8+Ug9rCcOAnIDyWLAXalFo8bM3mJz99Y7WfnzqOBayZS8L+bNjXk@nongnu.org
X-Gm-Message-State: AOJu0YzHQO6WPXZLIwNwGTGjrdVrtRUnFVtiiBP9bTz1bjQrpkglZMKG
 cAXZyfIr/wyJNQ+w5VMcNDYTL8SnjFnMe7BWQsgKoyB/Z0cOKGQYxDahzgR14QytKU8=
X-Gm-Gg: ATEYQzwVW8az2vI6aXymPwO0r1Z3cF2QnNaiEwkAWJzNeqpry5UBsbh7YzdPe/ibxSY
 RM7gzc7V/Y48xqm1Gc7lVasVpIoeUz09vmOkgJhs7vy5D/9zsPowYku0Gcfi8ubXuuggI5MVfM+
 Tp7rtNBSCdz8X/TF1E9uIKENSh9CYr+s9jMOXzNOOcHX4Ke6mauRaB4V6AYg/o5bcG1MPOOKnSV
 3ctdSKRFwY2RfYG8pn65kFIOVbhdazwVtzCUyhRtn58E0fPGEd09T+sO8idkwHWFAJFvINbWIGL
 G1WuoGSVpe6mFkFx2AlMSTTMYBLuEW3y4GUBjodcI3LyDFAyw0UkalpFdefddyPq4TKzMkE5Nh+
 dYOaLFFY8qp4p3LX6NBV4OaHB2LgdQ5e9KwzXqH9HP66jF/llGzh/i6nf0jgrxHRU/xL+o+z2YT
 NnLjsHLoZ5nPk7ePooW9xkCCIGYNHT988lBekQ/sQuB/BX2ls+nefK+FWPgbsNvgP8IHXr
X-Received: by 2002:a17:902:ebc8:b0:2b0:64c4:34a0 with SMTP id
 d9443c01a7336-2b0b098b26bmr87982015ad.10.1774550769498; 
 Thu, 26 Mar 2026 11:46:09 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc68914bsm39465595ad.0.2026.03.26.11.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 11:46:08 -0700 (PDT)
Message-ID: <b1115dab-4f72-4c8a-8d81-3c24b3475faf@linaro.org>
Date: Thu, 26 Mar 2026 11:46:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] target/i386: emulate: make unmapped GPA warnings a
 trace
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20260326183628.79281-1-mohamed@unpredictable.fr>
 <20260326183628.79281-3-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260326183628.79281-3-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/26/26 11:36 AM, Mohamed Mediouni wrote:
> Some guest OSes trigger them way too often.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   meson.build                      | 1 +
>   target/i386/emulate/trace-events | 2 ++
>   target/i386/emulate/trace.h      | 2 ++
>   target/i386/emulate/x86_mmu.c    | 5 +++--
>   4 files changed, 8 insertions(+), 2 deletions(-)
>   create mode 100644 target/i386/emulate/trace-events
>   create mode 100644 target/i386/emulate/trace.h
> 

To justify the change, it could help if you could add a better commit 
description explaining:
- which OSes are concerned (older windows?)
- analysis why they do such a thing (at least see some QEMU backtraces 
when this happen).

 From what I see, this code is triggered either from hvf, or when 
running an ins instruction, so you could explain which scenario you're 
covering.

Finally, this change is quite unrelated to whpx, which can be a bit 
confusing giving the initial intent of your series.
In case it might help you, git update-refs [1] is a great solution for 
working with stacked branches/series, without the pain of having to deal 
with multiple branches.

[1] https://dev.to/onepoint/git-update-refs-in-a-nutshell-574c

Regards,
Pierrick

