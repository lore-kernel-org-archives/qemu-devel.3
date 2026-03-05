Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ABFEF8FE4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 13:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy8z5-00071o-3E; Thu, 05 Mar 2026 08:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy8z1-0006zz-Nd
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 08:43:19 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy8yz-0004C0-RE
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 08:43:19 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso9884658d50.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 05:43:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772718196; cv=none;
 d=google.com; s=arc-20240605;
 b=hXl+eUn4WZN2ijiui75jpSAJmU3Q7WGLsxRKFGzK6LpxUOrUPT+bBD+uBlTu54bT4h
 vmSBBj5ETTvmvwimaAzH9TAGvbggJcGsj4/Jm3NID/LNEBpG4BmcZzgUFadRzo52iNCN
 B5m1U/P5YCilpOz1UjjLiba7WJR9GrVCGaTatpiu3TICVrpyoaUkzs7B1/8DNa68zqdo
 AUfQsUNRLV3bYCsvIeBbz88Il0d+MnPnQfdHnlMImuREzuL9wLkTGMe+gan05/aHG+cL
 N8XQ0yDOb7QFy0+pz2RBIPPi3iKYoUaQePhIFdv6PaGdFEOwcc3FqvrHxJzFA+FZGFt9
 AllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Y9mBEjmqWn36e+AiRIj1Yn9IYn3x+1lZXwECaKn4kpI=;
 fh=V6/n0/ijm39oi4A+DkC3gv3osqLMyqGjLkit+g5M884=;
 b=jMlRpYmo2xxx6wL0/RQc3RzOt+iLEuJy1T3Sr/yim6KqB3uwWmS3vgmbvl6QdDak7L
 y7or3uwfxEwoz2yGrepXOF6t9+VtozSm63ThBwd8mq42987EY84jW7qb5KK6TbVBECYA
 5EbArZiw0EWozDpGb8G87A+EyF6nMT+dgvKOrO1MXCshnoBYtxMdERPunIo43VzOfzyu
 Nox8fiAkmUCFgyhHU5L+Oq1Y8mlJ/t/j3I1YaunQJYXdH1KZNXp5rwu4tjWy5ecrOJzf
 pzgPeqvrEFiu9uhAxSe9ZwEfqeS4HMBsl2vazHLb2HIfPMX9rKaPZgFFzXSOQb0GZIoQ
 xO2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772718196; x=1773322996; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9mBEjmqWn36e+AiRIj1Yn9IYn3x+1lZXwECaKn4kpI=;
 b=RHxkrs8oJ9k272Mmrxoa7RWfPOhNYhcw5pXAvPtIHu7SA0jPN7qzjQRyx2bolwVIuI
 jnIcUFWnAp1H/CXLY9fIL6o4gWapSPcMPO/XZF9/WpmkLmZ7IJhH9/NEEFQrdWRb1paI
 dceUMhcQs90zHoA2C7RBsgVnxKdOMlKTBnxqj48x+BQkgThV5K70IvKIx08InTTyrmrD
 nmF0DH6z677tI6siZS0j0Csyx67Z49JtbdtEpCBUyn5tUpn6stsEAA3sqB08cRTbGZN8
 qU/6qsWAcEuaF1ZciAz01JjACWabCX83RW1M2Cd5bygmmAOrOZNLo590vwlSWQfiqrwP
 R+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772718196; x=1773322996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9mBEjmqWn36e+AiRIj1Yn9IYn3x+1lZXwECaKn4kpI=;
 b=fAWPE4lgiqem3Fjoqk9vgbFlwLWezijxgr4OsMHrOkTZMlroiyzL9U4QcyGTlVmNHW
 ah1TObH6g/wW0TtJ9kkmngCjcarq2IhTXWqo5Qga6K8n+jEjdFqo6ZbZSZoR1toweMbx
 IPhKnSXaX56dGH8pHE0jum2075cI7+u4nTvz6AAXLJntt5bJDYfL0fOcIT0evFX6xRIS
 pWFJ0RznGJ6wgVHuLF04zKEe8zzRdnHWUxm3Hdcmd2OFtM5KH1ynD1XVifxM62ult+5W
 W4fetVfxL5ZNHBpLfUh0tA9ZuBXOMer5NAY0f+3TUwI1rxjndLIN/4NWpsr6Kkm0LMES
 iuNw==
X-Gm-Message-State: AOJu0YwRA3O1oEh487lmGyPo5bF5h4bHVZ57u8Onyd0gI3kTNCA3U45e
 7dcLdijVFJ1CFP0p4danWoVKYjtQOP0PXeuSV6q6gu6jCpC6thTHhCBjKHnRe4MSkLL7EvmYq8+
 loJ9slFNxVuC3n9hPqvXGLUgYwdw6aRoqq530iJArog==
X-Gm-Gg: ATEYQzyHgp65Onmv6IUiFoDETrhopc6bDDve7h29fp73qxH/QPkNuSHU3xE56RsJHjP
 QNXSfZOubcrjoTlTINdaT7YGncVpsD+3LHEf1a4dMNfAwsplVt9rSTIrF5jIJIt9QjZoC++Tbqu
 DMvFxjsY4yG/dX/1aEybwyYQBwTaB00pQA6MbNmZEyE6mi5JJDey6u+3YcrvIOjT/bbWavHD48P
 LpFY2q9lq8hKB9uBTZD6rYsPJtTaiPDPbKRsrhILmGKbyXV1K9pJw1bcXH8UMIh7pB43hOF2NDw
 XEv2MVQD9CvU6WEjwDex7FG0o1KgGGMOofb1qZEZ06vbMkdvYm54HqJagbqLbA2s66g=
X-Received: by 2002:a05:690e:e85:b0:64c:b401:f3e with SMTP id
 956f58d0204a3-64d0713de0bmr1471670d50.39.1772718196303; Thu, 05 Mar 2026
 05:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20260305111832.1068093-1-peter.maydell@linaro.org>
 <363d2abf-0e7a-4f1b-bd27-59b3e276e300@redhat.com>
In-Reply-To: <363d2abf-0e7a-4f1b-bd27-59b3e276e300@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 13:43:04 +0000
X-Gm-Features: AaiRm536W0TVeSr88AQmihxzuQ_ygqRki_8Luchkm5uqGsuXzMz2F-zAVHGidl0
Message-ID: <CAFEAcA_mi_xFxM8x6ZK5k-R0_7ncyQbrNg4SfO=MXMqKD3PJwg@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rtl8319: Work around GCC sanitizer /
 -Wstringop-overflow bug
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Yodel Eldar <yodel.eldar@yodel.dev>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 5 Mar 2026 at 12:18, Thomas Huth <thuth@redhat.com> wrote:
>
> On 05/03/2026 12.18, Peter Maydell wrote:



> > -            ip = (struct ip_header*)eth_payload_data;
> > +            /*
> > +             * It would be more natural to write this as
> > +             *   ip = (struct ip_header *)eth_payload_data;
> > +             * (the IP header is at the start of the ethernet payload).
> > +             * However, writing it that way triggers a GCC bug where an
> > +             * interaction between -fsanitize=address and -Wstringop-overflow
> > +             * results in a false-positive stringop-overflow warning that is
> > +             * only emitted when the address sanitizer is enabled:
> > +             *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114494
> > +             *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
> > +             * So we work around this by writing the expression in an equivalent
> > +             * way that doesn't run into this bug.
> > +             */
> > +            ip = (struct ip_header *)saved_buffer + ETH_HLEN;
>
> Uh, isn't that a different pointer location? I mean, this first casts to
> struct ip_header*, then does the math on that pointer type, i.e. it adds
> ETH_HLEN * sizeof(struct ip_header) bytes?
>
> I think you need this instead:
>
>          ip = (struct ip_header *)(saved_buffer + ETH_HLEN);
>
> But is the warning still gone in that case?

Rats, you're right -- good catch. And no, if we fix the expression
then the warning comes back. I guess we'll have to do it with
a warning-disabling pragma :-(

-- PMM

