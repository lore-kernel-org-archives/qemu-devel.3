Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE98FD2D83
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxBk-0003HG-3V; Tue, 10 Mar 2026 09:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzxBi-0003Gu-LQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:31:54 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzxBh-0008Cr-4S
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:31:54 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-797ab169454so131674137b3.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 06:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773149511; cv=none;
 d=google.com; s=arc-20240605;
 b=SnA8SmNJzLooM0mR33teHcplNgStCDYblrB/DkW8r5Z6+wpU3QIiGW51RcAIt7Stfv
 f9WCmRDH1y59+YzfQkuMiLp9VpW7iMSFYw0nUX19Ei3gq/aiPDbR9Sv0j6CphOZcCtpj
 FNXo2RAtvKDIe5c29RiEOy2qMt9c5JNIcS8s0RXZXB3/4M3s9ls+hIDkQtA16Cb4J2g2
 A6SFXOfdnOp+aXGlISU4U8Tt5lq5nSQBfdhISzniwK0wt9vJ07SrPljGq9h6qruaOdnH
 0tTn0j1xHOkD8l36oOVqjdIvPk5NVGUhgxf+RT4RWRDlZj1hVwMq0mWMbeUFI/JkQi8D
 /92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9OTKoDp7hyAQ12kmmZrxeBElTf35CSRv6BpuYlDNLbM=;
 fh=q4CEMG0Er9cZWvqkTyrPIEB7c5qJovcabgcELgobYIk=;
 b=OQLmk5dPsMg0dkIydM0iIelusMe/mo5qHF0MG5oIrUn5KDSwMxZKpOzsQgf/dwrRS+
 KppSo8VAmgIwFLbY9AJc6e7CCcrDK3Z2uYYfQDZu7TXOxBNMF/PKT4WT+xNkPiesvByJ
 PkvfXd4DIX2/IhycSdNEQCBzjPdao/A0QI/y8keHXDXdXC8UTTm8Cqe6lFn7RUcflGM9
 N+ABjVVDu7fCoRPPf5AnSxX9JPLn0n2WU3ncj1GxHGfrhHfJHHtIX+ZC9XewjDFJnZG3
 2oj/A4ORjhQrdDzafR+IqDC02y1B6x+ReAQh30VMbitQ7H8YJ0GJZLpPv8EzrEqHtdDL
 hbVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773149511; x=1773754311; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OTKoDp7hyAQ12kmmZrxeBElTf35CSRv6BpuYlDNLbM=;
 b=LcHicwiyXFVUBsQefG5UB17hnOF6fWyzGNA1hvTTNGmTzkDeGsbuloriLnZeLhjUFO
 NoYyk3QvV53agIMpIwgLEDa5c6bSgjrasT0Bm3AuSbhA+MpxJy+lDaV0kdoNub7X1ftP
 +eoth4gHMYQ/z0FQltFhDpefeVpr86I8e24/zNFEpnQpc8DF5O/hzAXe4+zM/r/TWLFP
 rYfE2OUy1jPmSju1DuGWJ023wnr/SW4CcBKXzScaNs+Re2uB10rqwlRCpmNbFrXh35ai
 Lx3L89l/qj5fVUDzLec/Nkiz4kjgbdQcUPNn+oijOU00IUmxLHj+jn7x55O7hZlSNddj
 U/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773149511; x=1773754311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9OTKoDp7hyAQ12kmmZrxeBElTf35CSRv6BpuYlDNLbM=;
 b=FH6wVjVc741e97+Ont6LBgd//jZbosy3nwpZN9dg97wIE0s86a+zF1xYFAJzX+x0K2
 89ziJVUkWYPv3I9hLl0oEg+hEbBXfEaleHsXsH9fDzwlZ0ArFNOQb3gyJmJrc4UD6mxC
 Drn+LKusWY52K3LOz3RepE0AZibfzNYDaXUwY22hDNBeiAKGc7/ua3NLCxisIh5UBeBs
 rY0rW9Y3y1wcf0A5DNklwr5OY93NKf38WqBj+2PsqgmqzYU2A5k9J6NKdoNM666vbfRQ
 nmr8oAtbLQxAGKT4XrEF98k210rqBawSdJpPTPYQHs+WzW8Rec33vTkq1Nut/Nk4NStI
 u+SQ==
X-Gm-Message-State: AOJu0Yz/0B6/BXmN2/A0bJXMvryJ//kVj9AkRncvXsv+EO7kxreAloCs
 qV9jL5FkaNSk2y6DkzMzSwraLX0dWDPb+LEZw15fiFnZ29K9DvczFF1ERjbr5IO0iHR4jRO5cjE
 tdDNfr4qMBYGm63FrZMy6Rqmz6b0kHVrItjXIFzTPY/z+bllUxahv
X-Gm-Gg: ATEYQzy/G6+dr6QIn1F/djII8FlrCZ30E51PtqtHvsrWnABGx9FaoFMGfaHtRvXtf1P
 gviePy7472mNmL83gSt2ieGDqF8mzs8uMJ2SQbO4uORODqHbSEnjNwq2/xgk1MKp/VM6u/xhrUC
 xM7x3sNh0YszGwSAMm6Dp5H/wa3EXwaVY29XLorwgXDQBECtsNOFD8AQZxI/T+sMotx5FMa4Rr9
 A0Ndbchwvo8wpPFB6QIjPpsW0kIy4yEh8Ru0yhcyLM+tySrzEHqVdNW5BUv+97L7Yap6ST2vo5R
 fb9V0Id6V5lAVepbucdUtvIoJ/Rr/kPqMCUPwp//Dt0nT3mn0o3Sn200NHFW3O/yAro=
X-Received: by 2002:a05:690e:1488:b0:64d:29b4:d60d with SMTP id
 956f58d0204a3-64d29b4d6c0mr7256233d50.12.1773149509669; Tue, 10 Mar 2026
 06:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260309204007.1709441-1-peterx@redhat.com>
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 13:31:38 +0000
X-Gm-Features: AaiRm51JnEObtJQoBeW7CFVdBreBVt6wbvV_XgIb_7PsL1E79P_LGOw8wRlBtLs
Message-ID: <CAFEAcA8zjfAqdEDLga_HWOFCWxcr9G6o42VNd3EaMMDkcjLPKA@mail.gmail.com>
Subject: Re: [PULL 00/18] Staging patches
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 9 Mar 2026 at 20:41, Peter Xu <peterx@redhat.com> wrote:
>
> The following changes since commit 7608a95d2e0bd8c8d069ab77824d02586dd946=
48:
>
>   Merge tag 'pull-xen-20260309' of https://xenbits.xen.org/git-http/peopl=
e/aperard/qemu-dm into staging (2026-03-09 12:15:42 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/staging-pull-request
>
> for you to fetch changes up to 40aa899d030e957f815beab33e997a1970914580:
>
>   system/memory: Have memory_region_type() correctly describe containers =
(2026-03-09 15:27:26 -0400)
>
> ----------------------------------------------------------------
> Memory pull for 11.0 softfreeze
>
> - BALATON's memory cleanups on _nomigrate MRs and else
> - Phil's small constify series and else
> - Marc-Andr=C3=A9's initial cleanup patches around ram discard manager
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

