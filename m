Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795F3C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd68V-0000Xu-0r; Fri, 26 Jun 2026 08:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd683-0000NX-M3
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:58:00 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd681-0000Y8-Kq
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:57:55 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-663167a3ba2so982261d50.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782478672; cv=none;
 d=google.com; s=arc-20260327;
 b=NFWj8HVZ7gJrex0Gu6gN8dSWcp2qOvxxh+McPd6ugW+X83M0G4XZdOiq00rjrOnuIu
 rWIqYq32mTp4otQJJFxXWqTzB6u7xYrMoG3Xg3GeZhFGsreC0p2s0zPbh8Jkc2slJ0r6
 qottDRAgwOxOacBTfJj+6v0e0gIjkNiy/icaPEKBaxcVnV/y6qIBhpRxSBv9OUcPqVeB
 sIh6cvtse4BH2wQKEpY3wNgJIVh6UMHJ8wEJs/JqCtz5rDUgBlPAFDvyEjGNgCnWkgyq
 6Y6VmELMxCN8UaSDm7WPID17PNSpD2koXX8kJsdKryCwlRYmbLT4ZSm7gCeURI7BQ1v/
 hlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8VwcliHq8xl464nnWTtg3JJJwkYrSrQwNu9NWItGi6w=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=nIJ0wgf15/qpxqsJWIZDKePiMlo3t89rl7uEFC60ZN2IWKEAn7053nvN7Bt49KGzxQ
 Z+AUfotfYAj7EIEEgSt0usUC++9Hj0p9TJpTURNgqsH2aPx0aVLR5h5yncb05Mdzy2wP
 qoz8IMMoJRXBFXYP8u3hIozck2yyKoY+hRQ/gXTjAyc7ZLTVLQgtoQydDZF/L7vtIMbv
 gxUjIsDlyQV8lVKNT7CpMs/kvDazR3iQ+3rd2Lz4mBTyLe8Y0KGSy6WqS+2kYoiNbWkh
 NGoEl01X2YSAwZ6nt7lRHP+1HsN2a21ubZNanjSvia2QNG2r4qCeHlzyGYrnvIKJUmC4
 HmmQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782478672; x=1783083472; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8VwcliHq8xl464nnWTtg3JJJwkYrSrQwNu9NWItGi6w=;
 b=vV2Z6ufXYZynAAQLsXZjqnGdhkXZXP+j1pik3kD4uaZqdiOWZXlABv+BgTuIlbzLRG
 HIWi/8A5j92m5OC2ge0F2tJbwZZiCVawXAFvCSOw5e2KBCzlyGtEYcNHyTDfeCGDAFVt
 o/benpiViEakAEV2lC88243CRSnnpF3ZtZO0jB+Ymxsq4b89dqxtgVoDWLUXPhSP24EX
 I5XWjBr1N/izQVxKbxf3xIZfqg3sSGNEtnGPSI+FeSTVNgXH15GXoiurkTpnMDSBrUWy
 9rE7KTHyrLYBXA589SVAVOsrrohtB2mF7InJ3RzXgT6Zj3ZuvuXWI4q+W+Scgwpjb0E9
 Qo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782478672; x=1783083472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VwcliHq8xl464nnWTtg3JJJwkYrSrQwNu9NWItGi6w=;
 b=Df21aekaDBU+Eym9koh9V1TsYgvtB6ygdlhKui7JydUOBbrn3MOPjjbnDQuHzZCnio
 ZKQbIlEumB6TCI+4WSOdsreDrS/1uTpt+HLpq/Jo2odeRuchOGPMqg/TEEStWb+obdtD
 NOelTKwWmqe8T4ptB6vcVSUOcHFKbLTuHIGqE/8eqFtmfy5jOCJVt3PRy6VLWXqs7HlD
 4Qj+qoGyg4ZMnmjpyWHcKE2slVIyvW47NkvwmyE2yPKk6CvQxMp+fRtlURDIhbAGu0I+
 D9mYy56bM0T/37zv2BJ38q78O733w625mnQzeRE2/FQzZI7RfjMI2mx/daKj6eNjlHAW
 leIQ==
X-Gm-Message-State: AOJu0YzAKOKHUKXUphXScvIThDFJPsmHFqurDWB45UpAJv12r9Ot/Xwh
 B+AwQkf+PpWVj/SP7wIKPGGfsurSS/3phjddI1U0Eu5r2RU8TfXx3HDrMs4c2ZqciXvHa/82zn2
 UsUhmnb57D+Aql43yNlcECQEpUS4VRimOU4pMPEfnKJgHkO29zbLodW2xV2mH
X-Gm-Gg: AfdE7cmHFkvloG4TblB/SLjv3iRm1IgiPXagYv0gwA7fFA8zp7CGgStrUGjHUXL9gD3
 e8pIKySuHEHcWSPcd27ywGD3pXeqv5WMpCyQW1o65LP4AeVVXdKSuNwxF1OzpJn6K/feJSZAWxv
 DWi3i0OFIvjUANrvWU8UG5BGYEEyiOzcdQjLStB+mFz16MaExu7OGI+Ez1h/bPN5WWVYGVYMmmb
 jpISXEfvoIcONx/NASJ3HZCL/3Bl5aM03+n+fE8mxpxYxZLCVa/YfP02VkgvBFVpOmGOUf6HmhV
 T1LhpUKWhBwM7X8+qD5Rqc8aWaIMr8/pfiniDnjkA4sy5pigyj2Wydc/
X-Received: by 2002:a53:ac93:0:b0:664:af1e:e9d with SMTP id
 956f58d0204a3-664af1e139bmr98711d50.43.1782478672447; Fri, 26 Jun 2026
 05:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-4-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 13:57:41 +0100
X-Gm-Features: AVVi8CfNbgKeeXjYSP2hx2Dm7X6I4uhVgGiBlCawov6A9egX96CXfl0sWqAHgVY
Message-ID: <CAFEAcA-VRpnD3jeg_KWGJ2rdGs9OX2J+8RHVeQJiZcPamqeObQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] target/arm: Implement FMOP4 (non-widening) for
 float64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 25 Jun 2026 at 23:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

