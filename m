Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C43BC61DB2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 10:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOw89-0008ID-NV; Tue, 10 Jun 2025 06:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uOw88-0008Hx-Nc
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 06:22:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uOw86-0006PZ-4v
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 06:22:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so31808925e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 03:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749550970; x=1750155770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=7lslP2hFur8NQXFSzATNMpM+eyqV7pzgPRYWwkQKhic=;
 b=CAnkuyAM6rbohCNA9A2Xc3WhscHQFiQPF0wRcvF0Fy8dcKWyk/lv/kIP89yElTQSJj
 257+yk2fzRPy9WiYrJhdqxyX83s3RxGais1OjeX+nLAMDAyKrHGIzm0KyLKs4FYZFTgH
 3XrA//EvKkoZXoLwPDJHZs7pLIkywRedxvEGRU3QkVpcUDfXGd0TOTl4Mt8MpZE6bbaD
 qkeJCbKdWRRyebczSTErVoZQx2BLxFuE2ihvxcYTd6SJCQtinIhwMkw5A2xhO01eCI9t
 wXZj5fOK6hAXlZuVL/SCsRuB2TH8bYEhQ5lCTGFJvFJ6TGPcaYl8gUBJ/LSmh2EUTprt
 omoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749550970; x=1750155770;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7lslP2hFur8NQXFSzATNMpM+eyqV7pzgPRYWwkQKhic=;
 b=ZcT/Uss7dlwbBtszMsdUkdyoVT1qejmiZk0FxLZocJsGJb+rveJms6A9NLby0ljClR
 wiNkiPkzsLu8xQcPqZDLdbxUR9hKcZzW2PUNM+z5zU5Bgndq2gn/f8XmFpOv1fYdu0jp
 wDK9tb9mHh9Sat8UBH7grFjy4TJEO04OUxkfPPYj7OoJtToOrzNqgg3Zf24D5TeVN9/3
 xoNa7pekh7kJNRS0esyFKR1pfVTIz/x4HzP4xyYAfa6G3llB7ghzH/gY0hHnPCxAKTi9
 sr8k/mzm4iKAwvVo8Eq746aZzFjoLr1qV2TmOT+jkzMBUx/TnDoSlC8LH3aRQZtEocgK
 tvMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7pa0lugl/bMrXgw7SYiXj9sacE8Dge25vY8JE444bLAMsK8gR9Bnsb6KcUBOuZqAYK3F7KcYo5xM2@nongnu.org
X-Gm-Message-State: AOJu0Yy/wlORw0EM5AInSAlutBeVqJpo+1vzgYaSJNlr98a+YpgTJcwq
 XUaYc9in6uJw8JGlj69fUD8f7vJus/GYVRNN49jDxOMuEPMlza3Qv91QJbKELw==
X-Gm-Gg: ASbGncsdVmNdJCqID8hUkiBw/kurnEemdLIH6CRgCaigh8eX7YoTwBeXa4e//wwTFXp
 1+1H/ouqo3iirL0AAJTh/E74NxNWIbG1piS7YCd+W/29iN4eG1hLlO1eZmqfXBrD9wgYURo59QG
 NW2/DoCJUAqrPrgtMKtEecorjE5eaXVZXmlgR33ntVSwLQySlLNDLgCP88p/G61prKrIcf9uO/U
 Ye7//LyIDOMp8zIuWGiV64Cfo3JdXU+lJgmfaP+eseb/tKjWccBEDinkCJQ8NmCN1+oCFSqZ2v1
 TMn7hYd9mR2Jtus1zRW0VfMnbXgJMRk0I3E1rHTU5St+yUAs+jh1FRIz
X-Google-Smtp-Source: AGHT+IGKWY2tPpaLCP5QceZnf7fzrMquWPtxjBa4Epy4HZCQ3Us7Jam6A4KviorLp2057ZYtYRp/XQ==
X-Received: by 2002:a05:600c:3493:b0:450:d386:1afb with SMTP id
 5b1f17b1804b1-4531de060c7mr18662505e9.9.1749550969619; 
 Tue, 10 Jun 2025 03:22:49 -0700 (PDT)
Received: from [127.0.0.1] ([185.238.219.2]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209ce17f9sm139311105e9.11.2025.06.10.03.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 03:22:49 -0700 (PDT)
Date: Tue, 10 Jun 2025 10:22:40 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Controlling time in QEMU
In-Reply-To: <b3cef05e-8bb5-4390-8b43-914adca3b3b6@linaro.org>
References: <b3cef05e-8bb5-4390-8b43-914adca3b3b6@linaro.org>
Message-ID: <8CDF867E-5AB2-43B6-B271-B350E833316E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 6=2E Juni 2025 19:03:32 UTC schrieb Pierrick Bouvier <pierrick=2Ebouvie=
r@linaro=2Eorg>:
>Hi,
>
>I recently needed to slow down time within a virtual machine, due to a ti=
meout being hit because my QEMU binary which was not fast enough (gcov debu=
g build if you're curious about the use case)=2E
>
>Currently, people tend to use -icount shift=3DX with low values for that,=
 as it roughly maps time to how many instructions were ran=2E
>As well, I've been working on ips (Instructions per second) plugin [1], w=
hich allows to slow down QEMU execution by sleeping, as suggested by Alex=
=2E It's using a new clock update API [2], that is limited to move time fas=
ter (jump to future time), but not slower=2E
>
>After looking at how all this implemented, I am wondering why we don't si=
mply fake real time QEMU is using as a reference, which is based on gettime=
ofday [3]=2E
>
>Using faketime, which fakes gettimeofday I've been able to manipulate QEM=
U time:
>- faketime -f '+0 x10' qemu-system-aarch64: boot timestamp is 14s
>- faketime -f '+0 x0=2E1' qemu-system-aarch64: boot timestamp is 0=2E13s
>In both cases, the real boot time (QEMU execution) is around 3s=2E
>
>It works as expected, speeding or slowing execution without impacting QEM=
U speed itself, which can run without needing to do any artificial sleep or=
 clock manipulation=2E If a program in guest vm sleeps with an absolute tim=
e, it will be multiplied by the factor, which results in significant slowdo=
wn=2E But it can't be avoided, by design=2E
>By using a time factor big enough (x200), it can even trigger rcu_preempt=
 stall detection in Linux guest kernel=2E
>
>As it seems a bit too good to be true, time for questions:
>- Has it already been considered?
>- Any obvious downside I might have skipped?

The only downside I can see is that it seems to disturb QEMU's internal ti=
mekeeping=2E The GTK gui freezes for quite some time when the time facor is=
 very low, e=2Eg=2E 0=2E001=2E

Best regards,
Bernhard

>- Would that be interesting to offer such a feature in QEMU itself
>  (-time-dilation 0=2E10)?
>
>[1] https://gitlab=2Ecom/qemu-project/qemu/-/commit/72db6d54a4a9203736261=
fc63f32f6cd3486b7e4
>[2] https://gitlab=2Ecom/qemu-project/qemu/-/commit/847a65dd76bf1868c7966=
a2b2608dcd00cb68dc7
>[3] https://gitlab=2Ecom/qemu-project/qemu/-/blob/master/include/qemu/tim=
er=2Eh?ref_type=3Dheads#L809
>[4] https://github=2Ecom/wolfcw/libfaketime
>
>Regards,
>Pierrick
>

