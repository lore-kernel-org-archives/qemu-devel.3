Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB27CDE00C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclZa-0003Ot-TH; Thu, 25 Jun 2026 11:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wclZ7-0002rd-UM
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:33 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wclZ4-0004KX-Fn
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:28 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6647a6c1f0cso1780924d50.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 08:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782399625; cv=none;
 d=google.com; s=arc-20260327;
 b=NN1F/3XldQKKQXuq5vKwftJAL0Mca5MmCLu09y2VCbTLfcL1An6mLLfIeXVtx83iJo
 rr4rH0CnA89i4vPVU91RCYZdM8J95qatNrLT/ZjPRCc8kOZFg5SPl8hWrHci5B6ptPf4
 udUvNdAjS8psnTbhXfwWW7WkRRMWWfdT/73R+c3qgONe1HeEAEjmDSlzaP8QMukbh+6h
 hg6T5UUeZ8mJ1Yn9AvEh4LK1v9uJR8ubs3oxUpr78x4iaAAsivttGWmlLG8U3AOG4zL5
 wctAwTdloIZvsbTTLP4HRkAjhVYYE7Z0Ylavr4OAYty8WXgF2nBKg7VJ/LYYASoX3Npa
 uTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dfgXG61S4y9QZs5MmI0UQgo4J1SUZuJMXX7wQ0cwHYI=;
 fh=Y/+yWNElImv7sjUmsr9J/66ymQrTph2UwmhC37llMDM=;
 b=APhTYv+GBoPvvfy1w0USjL6XW9FypfYiaLBvQt0kx1sPbn9mgRt4WGTmdTeLLWGc2H
 wNoXsFRmufPaOgA29bO1xvdXEvY77IxXa66Nv3AoYHtxNgiK4l3z18/c6tH4bF4ms02G
 vyReScoqKWAeyusZ/6pyxWL9Lur2Gu0AYwi9btTLB2OCOwzfoJGqLJUylvFJitovlURW
 otDk87zZN54HVBW3qqIoId0Tuq/I5NIAulzwYyXmKs6X2hdUopjZc/E9Cf2POlNXH/tc
 lIe9r3Fs4ghITM84s8AHsDpaHNwShPUp7Pbk72TrHdKV1fNHir6Q2KV4vLMwCXFOkzIG
 7dJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782399625; x=1783004425; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dfgXG61S4y9QZs5MmI0UQgo4J1SUZuJMXX7wQ0cwHYI=;
 b=hHtHLtlyY4ZsIiu1OT2SDtn/eti7qbleLD4Xb4b7VfsUtL5Wq00bUkWV4wapGzLCFm
 rZ2apb/xFUG8Ggmq4XqU7JOPPwQl3lR3wetIhfX6UkmqSXGZvyG18Xh9OTCTEQRnGEEi
 Sut+YdKGjH5Yq9KRCZE3VqPz78FlsxSg0FrzfqNnY66xK5TZFiC8sjyaq00gYn3t6kHh
 CWDSV1mdXfaPzvTgtFXkil0k0rwRnnYYlHLJtNev12qSG82O2Zv4RfnlXtggv8l2XdD+
 d26LHdtF058Kuw0vP219quwbSIbdZXvp/TVTSN8zn8DH1VTwqOzY3Bhghy74ka5qbE64
 semg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782399625; x=1783004425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfgXG61S4y9QZs5MmI0UQgo4J1SUZuJMXX7wQ0cwHYI=;
 b=WORgsRfaljrYUna9hMXW2q2UC7UViA7VkRO+VVJE9dtenCO7s8EBmBwAfBIbz2aafO
 SH4O3byiJUSyb+eSmC6wXw/+dNh0mch9moYf6luzAFg4PV5spSG3/pNq3jnDKmBfc/Sw
 7I+oai9DV77Fkd4MknMtl7T1S/6JE5eOOfw356+WZugUWE4phBavlJIiNgifY0Y5X3uN
 B+PnJITlqsWPXApUA5qXyDpjaltRcHwOBKOzwv6wLmBZEaD3P0KKkwZLQw0VdCrAs+Ku
 Mm6tbmOm7ch+GNap4KISOJqU+tQ5O1vXMVIQ58HDWcn9mg46epuEvyVDtxFDkxgxzk7f
 QlHQ==
X-Gm-Message-State: AOJu0YwQfLve70mrrT27PIrwjuty47KuKqzQOLhQ7Y52YKB4j+B5eekD
 sZfYSi/T8mKvr68+vzRbNWTYlCw1jx08F+l0F3ccyNADNlf3jQ5UBH9d4wd5UWahtJreVsXIjiL
 Dl4G8eR1ZHA6kdifA2DgSi7/+v8ReqhAbq3X0GBb+0w==
X-Gm-Gg: AfdE7cnZ67fRXAiQwU22DYNANZfAA2dlkHUBeuHnxBJZLuFjuUnWHIjUidCLoI84rfz
 EytwdhMmU4ZIcL3+bn1XsMmF5jvcnrrbyAyuXMlYA1CsjfFf8XLnC5Jlbe2Q2GIly1p1vbaowIA
 ujHwE4bjuOgMiyodI6QoF96jvY4O/FkUaaassCK9jUBizi7zaiZVr95J8YQ1feLfIr/Df2fPcvm
 L+Xq1uBhsd192mCvOtrZRYxwzuKakW5V5IZTk6STvcVjvYvKeFCoUzjdCF2hzR2NUrZs22J0V4Q
 Jc6RC6rnI6SybRJqG6pZtn8xDo0P/rjFOt6hEwuIjEY2zZvKctrZt7sP
X-Received: by 2002:a05:690e:12c6:b0:65c:6dbc:39c4 with SMTP id
 956f58d0204a3-664883cf072mr2064803d50.51.1782399624698; Thu, 25 Jun 2026
 08:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260623170354.43981-1-163wangjack@gmail.com>
 <20260623170354.43981-4-163wangjack@gmail.com>
In-Reply-To: <20260623170354.43981-4-163wangjack@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 16:00:12 +0100
X-Gm-Features: AVVi8Cd-jtKXwO_oqqYC44dGW1pgj8FSZMSOD21cEwgjob0sns7mLlNEW4K18PY
Message-ID: <CAFEAcA-ALs7TtxySitahcYk_P=99uh5078Ux7==Kh4ER+EQPRA@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/misc/imx31_ccm: Replace DPRINTF with trace events
To: jack wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 "open list:i.MX31 (kzm)" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 23 Jun 2026 at 18:04, jack wang <163wangjack@gmail.com> wrote:
>
> ---
>  hw/misc/imx31_ccm.c  | 33 ++++++++++-----------------------
>  hw/misc/trace-events | 10 ++++++++++
>  2 files changed, 20 insertions(+), 23 deletions(-)

Other than the missing signed-off-by line,

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

