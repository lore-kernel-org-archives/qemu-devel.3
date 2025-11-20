Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BA9CFA442
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMB95-0006My-RX; Thu, 20 Nov 2025 15:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1vMB92-0006Ae-Hc
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:20:45 -0500
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1vMB90-0001mZ-88
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:20:43 -0500
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-9486d008fdbso56154239f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 12:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763670040; x=1764274840; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/7cW7CUaGiTDpShaL8t1dEiy+l6vkD+unenEoBfJ9Lk=;
 b=DH1rsBDaCRslss+LA/Uu03duQ80lmTgnK+xJLwj6y81vU8cFNsonf1lJ3uqBCCbCmV
 BreHFLoidH+pwYDu9LFwsiKBk2FH3AJYjGcaFYtG7wDRu16EmeR6agzhivkUF3+tFVC3
 aS8xuVZuPiGCLgA9raRuS/QIA2qIYRjLv4ZJI4/6KUP6tKpUynFIN9NBj3u4WPQyA7CH
 Qr1iOYUHjKFswfB7lOr+1VuRs6ga6gdv4u1qhgpZ8ePvSWNRJBSaAZQdNNJFZ8ac5JE4
 wVt1mCepghmU90aJaYazomfKtiD2TF2hzOvuyS+imIUoHDX1ckkmfcxn5fbhIb5X0L6k
 7GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763670040; x=1764274840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7cW7CUaGiTDpShaL8t1dEiy+l6vkD+unenEoBfJ9Lk=;
 b=EIGmcJlPyEgvzd6yTfyaxGZdRKRVqqTI9DP94hYRaG5Gkpi/Ejbn8ibx5ufCkqgMVO
 LrNBRHc1Nb+iPrcJI8wQZzZOzxo3llXfVKHiyE163lCcg216fTf9QVNSCqrIWqXBiChd
 jOYxAu+ZgIcLYogBU0weCRnPER3yLOYIN+bBIWGgnZmqYhVvK9KFDzClS8QL2h9wudOR
 W8DZYU7ZZgWsPL2F/IqdfY0jAyOjqe6nIvdVs/k89yQXkXNn7lG3KwSTX5QOpjTWJ9EX
 GeP9Ncz0TpKDRqlsMcrsTou5f5w34LtDYvxnHggUbCeL5vSnmlbN+A2kioeRBegoCwhO
 ffXw==
X-Gm-Message-State: AOJu0YxYoqRUQjMDIGq2T5W2fqvNpd19AeuqkisvqiD6UdIlyQoTZayT
 oF90ZY/FMBn7/dECKO3BnPt3PrOWRbF0jDK9VLbtQU+j3nxVjMO7FDoSuEp+/mrOiTnEPdl2Ivr
 QOXvHbcgaqJAtvkWerrjP/EbSIzT/eXG6g7orzAdSBzZd/kJYwgD/fyhE1Q==
X-Gm-Gg: ASbGncv8bzuEbrnjXd+IV8exQdX4oYCAr723Hw1HZ439N3hKCymsciW2Z8+KocI5SBF
 JrOC4tQkarPlSgD5csI6bRIb/lPQn6ZEg0LRabtzyBAQRGAfYdmyxlu0LTWXneXx1orj4w6W7xb
 Rdmez1/OYF1uhXVVO37xvKBEPzoA3q5T4Rp8KPCKkXNx4jX982PLj29pnAiksFxXnhXvUht+s59
 oeI4e1mQv9xxVBXlAbOFRZOA7yUqhW7hr6mAONSs1FDdTGzjC3Iw4JzfjH2QVRLzQ50wg8=
X-Google-Smtp-Source: AGHT+IGHpMHHbOBKS36CK+ks0Zw+H8W7/KMXCqqAMGnE9eZdi1rMXB6sCIfanwhT+fzD87P/6i7/3ywKq7gq1Al7k7Y=
X-Received: by 2002:a05:6638:c3e1:b0:5b7:d710:6632 with SMTP id
 8926c6da1cb9f-5b956973ad9mr3430921173.11.1763670039901; Thu, 20 Nov 2025
 12:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20251120175914.6515-1-philmd@linaro.org>
In-Reply-To: <20251120175914.6515-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Thu, 20 Nov 2025 21:20:28 +0100
X-Gm-Features: AWmQ_blTg7A8LjA0pr8qb3ePbPmty2HHhi1xPGWl7coboQ-qSoqnF-KOhfO8GLs
Message-ID: <CAPMQPEJMkCnatgF2BggR-RCmpm=vH9ARRB84=uvYgh1E8UB1rw@mail.gmail.com>
Subject: Re: [RFC-PATCH-for-11.0 0/5] accel/tcg: Remove some MO_TE uses in
 cpu_ld{uw, l, q}_code()
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003ac5a206440c6e83"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-io1-xd2c.google.com
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

--0000000000003ac5a206440c6e83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Nov 2025 at 18:59, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> Hi Richard,
>
> Quick attempt to remove MO_TE uses for fixed-endianness targets.
>
> For the other targets I started to propagate MemOp in the call
> chain, but since IIUC it is constant, I wonder if it isn't simpler
> to have a CPUClass::code_endian_mo field, set once with a
> target_big_endian() call. I can post another RFC to show, WDYT?
>

Not needed, figured a simpler way, posted as v2.

--0000000000003ac5a206440c6e83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, 20 Nov 2025 at 18:59, Philippe Ma=
thieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org=
</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_container"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Hi Richard,<br>
<br>
Quick attempt to remove MO_TE uses for fixed-endianness targets.<br>
<br>
For the other targets I started to propagate MemOp in the call<br>
chain, but since IIUC it is constant, I wonder if it isn&#39;t simpler<br>
to have a CPUClass::code_endian_mo field, set once with a<br>
target_big_endian() call. I can post another RFC to show, WDYT?<br></blockq=
uote><div><br></div><div>Not needed, figured a simpler way, posted as v2.</=
div></div></div>

--0000000000003ac5a206440c6e83--

