Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8457C83F27
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 19:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udDib-0002F0-2v; Sat, 19 Jul 2025 15:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udDch-00054P-1g
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 15:53:31 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udDcf-00017h-Ko
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 15:53:30 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-70e5d953c0bso33862517b3.1
 for <qemu-devel@nongnu.org>; Sat, 19 Jul 2025 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752954808; x=1753559608; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1Ll4J0AUFjnln5RHN86muLwD1C5wmTwfcL3z6XoVZ1s=;
 b=pwACGYKSC0yAj+udrOsrMJ+bGlEm6JK37sHtc2b6jAKguaPJITfJ0PFR0FYCNgnKzv
 iscK09iMPjNUiOGrSQA1G0YYFkfQgEl9qmV348igNbypTMjMFqiturpY6zpVPuIBnFkf
 +v6OLFlbBQuN46fyXJnY4lzm7uinHEX6Rp+osdmpJg9KsC18X3vFh3lw7lma0LEcp8NW
 L3j2H1Aae5p1PKaDcApl0pOSjFxx3g5ECBt96+FplTGOP2yBQOI9eSCiGb1NglMdFhJD
 CTuLzQq8gz2RPG8/oNHTxCEJwgJLOgq7ydqbfa/t1j85EeMZGwmYbx4bscQi/MW+iGWn
 NBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752954808; x=1753559608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Ll4J0AUFjnln5RHN86muLwD1C5wmTwfcL3z6XoVZ1s=;
 b=KmTOzLObWtMdZDW5WPOcYZB/vhMu9TORTlXrd1O5knvousbcW3bYiSZCQKcrP7c4UU
 0AQ7AozvlSb4Lmw5SMCK+3QDUcpCxVTzKId7VhlnC6czMgbnFgK1TEYKtXLuzqH5JW1y
 scUcJyZxMcLn1/7uDCcUjIdi6q4q+Af/QUGE99A+JimKiiiXi9ZDFU+RMYRyldEh8nWo
 fk+03lgEkVc9RwAEo+VcNrIlfTYDjbj+W5W+E/mHq+fs+iZZkI9DGYC1LogEhcLUlaoN
 HU+605ZskgbJiDVUpWrGVg+hQ6edqqCiSocRt1ILA2GkEy7dtgoi9aTNz1rV8cPCVGVr
 9EIQ==
X-Gm-Message-State: AOJu0YwvaPQHACv7elh4lHW4X/hJXturbpiQtVv9K1lUi9JAcpvrERR/
 KhxdozwMjFD+zOYjQgWjS+SpiHg7LyqjYQk8Hk1nx7rqdSWfS/3V5DjhesQPsf0FPXTHRRrnzPd
 tRtMyY89+GLN80nsCj4/+dwaxjGhQDarnDy9xMO8Xvg==
X-Gm-Gg: ASbGnctyNV7yHm9uyzOZZMlrM9CxZf7VXrs4TFLTNF0ADJnmpXGCQ29tJDdLBUtt3Z9
 FOTkwa1v6Y2h0pvj2N+Cau28A1pZT0R39XO65Gb8h5VDghvtjxvJSle8H4vAPLc8BE2qvchYieL
 u89bH1oaLMUgFJCXMzXgv9qp/mRMAvVml+QvQ1IB5Kw9BLt6KQJA9KeQk2RMd575KbkKkRKiafn
 TwLMdoZ
X-Google-Smtp-Source: AGHT+IFls2xGfl2v/M07BjbtDPY+QzI22ydqoZA+xGON6vYRPFIuqDjxpS/8CBWU5+qeXuDZueJ5lM3r1czVPBOADkc=
X-Received: by 2002:a05:690c:6312:b0:70f:83af:7db1 with SMTP id
 00721157ae682-719522ba98amr78674477b3.19.1752954808362; Sat, 19 Jul 2025
 12:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250717150805.1344034-1-lvivier@redhat.com>
 <20250717150805.1344034-4-lvivier@redhat.com>
In-Reply-To: <20250717150805.1344034-4-lvivier@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 19 Jul 2025 20:53:16 +0100
X-Gm-Features: Ac12FXz3-tXWa4n74_Su1hn82bS5XNvZ78IESMgS6UUPuKO_5uylfKHyl0Vdm_E
Message-ID: <CAFEAcA9x4CsF+XjEN+PM_TcUkZYQmQcB-M1AtCUv2wuEN3A1-A@mail.gmail.com>
Subject: Re: [PATCH 3/6] net/passt: Remove dead code in passt_vhost_user_start
 error path (CID 1612371)
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 17 Jul 2025 at 18:50, Laurent Vivier <lvivier@redhat.com> wrote:
>
> In passt_vhost_user_start(), if vhost_net_init() fails, the "net"
> variable is NULL and execution jumps to the "err:" label.
>
> The cleanup code within this label is conditioned on "if (net)",
> which can never be true in this error case. This makes the cleanup
> block dead code, as reported by Coverity (CID 1612371).
>
> Refactor the error handling to occur inline, removing the goto and
> the unreachable cleanup block.
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

