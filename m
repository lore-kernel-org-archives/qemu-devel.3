Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C1F10F92E3
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7cIS-0005As-VP; Tue, 31 Mar 2026 12:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7cHD-0002x9-9v
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:49:15 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7cH9-0000jA-SY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:49:13 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64eb84d1e37so7340777d50.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 09:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774975749; cv=none;
 d=google.com; s=arc-20240605;
 b=Ygh67IQtlXF63DGd/N5STejVRsmwAkcpUQS8FmEGrUQN95sm/y14PtONnFGb6JcoRe
 8rcN4KMgO+IXO2a0EjNLk3nbDZ+7JvTZdw2vLR5n2t8QY2cOuufYB+gLw54DAc9CaIRS
 6/c1nUqniwjeUOCnWovp/gvKU1o+EioJd0hufQ20Fnc0ZD4nZkDdQQqzkN76Pl6dGLYR
 rBlBulLLXSu3zv6G37aok2dYN1ALEcDdUBTZBOuwO7ubhHQ2UT6eZLbVze/X65Uw7bdn
 47EKfGIQqVXRTAKEbYDN9pIzTDHKKPMrbe+Nfs54CENvtF3yc8+ihcHUbeRfCMexfqKJ
 CG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m4QdvmL3h1yrMq2hECA8e22VT3f2QJLlzFBq6xX6KhM=;
 fh=j0m/KHqzOQ6CKKktQSBLLiVo/M7SZnjHIyl4bugXt+Y=;
 b=hcG2X4ybDfLYVt29c84l4/oqoUx5yqQ/e7PasDz0/wYsVgg0Q8virMXyr0dpdFegfq
 Q67UOU0hNEXNMOjmL/InJXXkT95rp52GOOdqnQSimhITf0EHXIb8sMlW84ur40aASbqs
 SCqCSOaWLCe7oSpb2pS1oeGWgjoJ02JVP7vHFSlkibFFktvXWg05Z94UXOkrvVs90tIf
 AZEedymu6vOUCzZIc8jarZdNFbCnJkPDwpfi2tzQ09+iI9rKahB19WHUHfl9u6250WZq
 85pMnKJl3duivL7HPsspP9wrmXeojuLS513FXiKn+OhAh7K0l8PNJuayz/jT2FzCTIkj
 NHag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774975749; x=1775580549; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m4QdvmL3h1yrMq2hECA8e22VT3f2QJLlzFBq6xX6KhM=;
 b=g5guuspgzy9yvmysKUxByZn7T0/MGOtWjAJYoL30VgLI0Izw4FYo3chsTNKNNQMHtS
 A59Ngs43saR0P6NHfpQE5AqnCY167UpJclq07xLd2qhHmed8qmwca1qZQAr0I7Ylf8N7
 Y7+//1qlurbosAcz8Ce270R0LPRsK9ZtDomAWv8+n8+v1/b3f4FfRdpyxftijGfp/Loa
 e5T0CfaPOffLGSm749z6yDmoPj42ySTIOfpGIw6WBXPRMPSpvjxScSyKjS+YZSH1Gles
 R5pcB+626lv8tpjg7rlp1DwHaDiQqhBA8+2guuQb2XHTCPTtBcaA5cXoPgn99+LIeWeO
 CzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774975749; x=1775580549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4QdvmL3h1yrMq2hECA8e22VT3f2QJLlzFBq6xX6KhM=;
 b=freVF2VTToVVS+obfRpy+f2sfJAVjMhycLPHqKqkuVH7ZSKtcgS6WenC/AwowEowKN
 VAAbKnWM2vHC6vpdTq076luwt8FNNMEhJ2cfsPO7H1EWjst3Zht0kQE9FmGy2cZ1vuwb
 DZqWdyZixSVETp6LG0zH1SFq8pJQyAmw602wTQCyCYYJViNX5AysfCTPHtTq9uJ4ToTn
 D6ogo8vML1HLBqCjSj0cM8BTmFy31iVjBzCnJBH71GHnLfMQZlPqUx6zATMt6AZ7zmWX
 sqOyOwBBVcphW7I40lomHrLEeMwIgk+MgpsEx+66cD9WP26sYb0jkvLYD3RkOR6JQo/V
 Fjkw==
X-Gm-Message-State: AOJu0YxY9yB8D1NX0SkThIbDbIbJaDk6lxfIh77D281WaYBfQ/2iFr3Y
 dh86x9b5wEjwcdauzAsQj06C0TidbO+i0zmAZgN2rql6rszm8vkaCY7EQXRYcYAvPJPovwPA706
 2+z9TiyGpKc1oocp+ZkJj6ycTnW9VniHF9VzWdn9Y4w==
X-Gm-Gg: ATEYQzwtIWGWbOFRRFHH03VmSPVZGvhoTLRSjRPHMyUy1FDny+p29kf68iQAux7a+qt
 5pCUta338QqfKKdYEJVLm9zLiKZutQRx2rQYz+zlF708bj8NZoNSIh7VvIErezrHKXIzAZEYAbi
 vS6P0xtiWkuYQXB1SoCPUGpH1x6qKRBoDuINjjEs1+7KLodNpULTM1aIZh2/wNNxQkXyeRkCWoO
 adZ9UGmifVVO5101dpU7CgzMYKpwAp28u8TmGjFWS3L3Qcm59dlG5Z/p98zKFMIANIRrjXNH3wQ
 p05UY1nR4EBYERE5WhDZ/JW1Qa8W8Lf8df2s7Pnb59gUp5KFAv+mMa7ZqJy1kCqkS9w=
X-Received: by 2002:a53:e101:0:b0:64e:f106:60f0 with SMTP id
 956f58d0204a3-64ff73cb80amr13166674d50.51.1774975749412; Tue, 31 Mar 2026
 09:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260321135624.581398-1-npiggin@gmail.com>
In-Reply-To: <20260321135624.581398-1-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 17:48:55 +0100
X-Gm-Features: AQROBzD9qx1xkyhy1eCZzZCj2s9CSdAnQxzSYYwJ0XrB76yK8O8eCMcVAghSWIs
Message-ID: <CAFEAcA82PE6UNCJdQ7grwb=Br35egPeY1v2+3qyipED_aw-JKQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] user: recursive signal delivery fix and test
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Sat, 21 Mar 2026 at 13:56, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> I found this recursive delivery problem when testing new riscv vector
> state support patches (plus a minor lock user balance bug).
>
> This or similar type of issue was fixed with 8bd3773cce1 but I couldn't
> see exactly what scenario that was addressing. Is there any other way a
> signal can be generated during handle_pending_signal()? The SIGTTIN
> case, perhaps?

I think 8bd3773cce1 is fixing "we try to deliver a non-synchronous
signal, and in the process of delivery we got a signal", whereas
this patchset is the rather similar "while delivering a synchronous
signal we got another signal". I think you're right that the only
signal we can actually get during handle_pending_signal() in practice
is the SIGSEGV.

-- PMM

