Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE31061B0F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ErR-0008Ey-2O; Mon, 30 Mar 2026 11:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7ErG-0008EE-S2
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:48:56 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7ErA-0008GS-Kg
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:48:50 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6500040f172so5134032d50.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 08:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774885726; cv=none;
 d=google.com; s=arc-20240605;
 b=TXqQgoYtfA66VJUSrGJLGO5YLsKxzLfVeJcJfqJsqK1rtrMbEfUFgTCSdH1mW/tjvF
 eLcXURhMpaJd/lqdOWz2jmtVvwqmGHT3KwC068QJScrrFl885hOo3RQhtKOxUVzREaxo
 SiKbWupQkUtSsY2od92ATYW+7lyHe17Bync0QIb4SXwQTpdZrhUxBholW9z8I8ixEDwg
 SGZqxrNt8ekz1PfyEMTe13sV70Oy9UQjySh2wQ236iXkeboURNO6LKnCxfjMwje86jh7
 p08UtV2CQ2MgFIfpGPSnkJxEkPYPruZdIhyzZitHlcYYa/e5ZQShyGqWlQMBjeRILGS4
 nRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V6i2sWL9dKAk6nVDDaBFQoiz9YI09DaYsWSDVe6iPDQ=;
 fh=j0m/KHqzOQ6CKKktQSBLLiVo/M7SZnjHIyl4bugXt+Y=;
 b=f5TOwPfvrEx5AZk/bjWHxHmYusWEQWlaLaCzO//fCyrxOMOJXurY/gvLPKxUc6ZpJa
 WHNdK4R2sc/aQrSGaPOwDlWW7pLLT806iC3/lTyKdhke7wPHIKYjHu4WNk0e3i/4nPpa
 9TERBebjapmut3MQn7YvP90+CQoJUUnJEkacFnqxiS6tJ3f+PoJbXp35IOZn4JW9L93c
 GHt3MsRlCPmV2aQ75k0Jt0f/a59Kpjae+tXql+D4P0RcFBPr56HY43N2IgXzzzfaCGzy
 7m48sFSnWPv6a5BpJ25/3fLbG+F3z06w5ETi4Vh6mldTl8RolerJmZdS9WEBjb7b42Lx
 GhwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774885726; x=1775490526; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V6i2sWL9dKAk6nVDDaBFQoiz9YI09DaYsWSDVe6iPDQ=;
 b=d7bfAaxu/QB8JnJyPEf8VuAbbgwE2lH2I++I0qZ1LiDIPzQ+ezSxef2hC5C2dN0XgB
 aqcyDMuwly8H6u4h9UZhyrXgn9u7sjIjzPek56BxR9xEwHZpRqjd1bh+WBq+uP2DaaOg
 +Jx8BqydUisihH3hD8o5Lx83ujQ1xTZp3DoDTDlwwXKJ6P72HgpnpappCFady0QL9DPp
 vzKxF+9aNvon4vDHLCVdAxxVlkY+oN8wTixqpxt26IfnCM9RuF9Ei9e6lgIFufLgdhSx
 rmNYTJZfzpD0fJeORh5/RwMF830K037OHplYLGqplYlvDfJd4Z4a9yEqtxNQCJmluvKj
 8KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774885726; x=1775490526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6i2sWL9dKAk6nVDDaBFQoiz9YI09DaYsWSDVe6iPDQ=;
 b=kinjb1XjMLJiKlQHkI0cx5Q7gMCvu/Prulz4U588g5YnDnqQVdpGJBpkO9Nh/9V+0h
 HA60WFGNQiqWVWEQ5LH1I3lzI741XTCrchHr/m1I8dnKv+L66uWx6zQLhI8W8FGiJKfr
 fa+dLZ87FimMWlC+sz0L/ukG8v2KMN5eKEMrFNKJrCBBS1H3CDaefP95IKSLtXMwu6fz
 YJTfhv0KmLA7LPD8eHBifApSp8qw16bBhF0dWUOne6sn80OdwqnfUh0Qmgb1aQoVL1fm
 6u5iVMFcdXhzi3qioeYh61DyZ6QJjVWs/D8/6kcE7aPZ42BnbXgJwpLr5GsHuPiqO21X
 JnAA==
X-Gm-Message-State: AOJu0Yz4yXyMVpgTtfIAtLxEI1frKxiTeJ9qIEgClPkzk72kR1DcGZef
 sgDlEdNIFBbwb8uU1qaJk6PCHcVk13n1IrBsqUcRxk7dyMW2XNE0iAA9Mh3S0KNDI+PBtjpeHpM
 O5vpFdAH7Vd7Y4OQQnvm/9gM9duX+93mrNFxttOQHhA==
X-Gm-Gg: ATEYQzyoIUKk79kITnc1zuXCZj8VzaUuBd3YpRYN+jEENp6lez7JYk6NItKCK03ZB4i
 h5kzjoMgKnCcit8BcXZkjrnIAAHa7IqtU/+sVDlM/HJHSmgRFxjF8qKbqlNhH1yRHASDEgmDD6G
 qPiWaxFiSmJBq7v3jPzTC/xn4omv4GiT1VE0uyhL+INJDoi5RI2iqJg2Y/7ByIUWimHVzdsjxdn
 I4Jpm8x3e9PmGqQYWkTSmTz7yveVxvE5eh2OtRvAoyvHNPIZKQIp+U78yFUFPKdbZrCHmg2S000
 0oP8gbc97dvG7HoZZjqW2iDrzGSGEXTgxdSrw9YS13SapgbaQ0gOxYG0JiSbbxqYmrY=
X-Received: by 2002:a05:690e:4394:b0:64a:ec39:dd4b with SMTP id
 956f58d0204a3-64ff73ce71fmr9561885d50.43.1774885725899; Mon, 30 Mar 2026
 08:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260321135624.581398-1-npiggin@gmail.com>
 <20260321135624.581398-3-npiggin@gmail.com>
In-Reply-To: <20260321135624.581398-3-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 16:48:34 +0100
X-Gm-Features: AQROBzDqaOU0C1SVi5pWYv0482TN17d5umDujfohbL1EMtlizxLqOPr456PK240
Message-ID: <CAFEAcA90kRMFRO8odKLwPVxDDHtJZT7VxqAU31OXFyOKRpzWww@mail.gmail.com>
Subject: Re: [PATCH 2/3] bsd-user, linux-user: signal: recursive signal
 delivery fix
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000035a37a064e3fc93c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000035a37a064e3fc93c
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Mar 2026 at 13:56, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Synchronous signals must accommodate a synchronous signal being
> raised during delivery, as asynchronous ones do. For example
> badframe errors during delivery will cause SIGSEGV to be raised.
>
> Without this fix, cpu_loop() runs process_pending_signals() which
> delivers the first synchronous signal (e.g., SIGILL) which fails
> to set the handler and forces SIGSEGV, but that is not picked up.
> process_pending_signals() returns. Then cpu_loop() runs cpu_exec()
> again, which attempts to execute the same instruction, another
> SIGILL.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

--00000000000035a37a064e3fc93c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, 21 Mar 2026 at 13:56, Nicholas Piggin &lt;=
<a href=3D"mailto:npiggin@gmail.com">npiggin@gmail.com</a>&gt; wrote:<br>&g=
t;<br>&gt; Synchronous signals must accommodate a synchronous signal being<=
br>&gt; raised during delivery, as asynchronous ones do. For example<br>&gt=
; badframe errors during delivery will cause SIGSEGV to be raised.<br>&gt;<=
br>&gt; Without this fix, cpu_loop() runs process_pending_signals() which<b=
r>&gt; delivers the first synchronous signal (e.g., SIGILL) which fails<br>=
&gt; to set the handler and forces SIGSEGV, but that is not picked up.<br>&=
gt; process_pending_signals() returns. Then cpu_loop() runs cpu_exec()<br>&=
gt; again, which attempts to execute the same instruction, another<br>&gt; =
SIGILL.<br>&gt;<br><div>&gt; Signed-off-by: Nicholas Piggin &lt;<a href=3D"=
mailto:npiggin@gmail.com">npiggin@gmail.com</a>&gt;=C2=A0 =C2=A0</div><div>=
<br></div><div>Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.mayde=
ll@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
<br>
thanks<br>
-- PMM<br>
<br></div></div>

--00000000000035a37a064e3fc93c--

