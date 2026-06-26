Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A48C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6cN-0000m5-NC; Fri, 26 Jun 2026 09:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6cM-0000jH-Co
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:29:14 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6cK-0004qm-VH
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:29:14 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8000e21f014so13623807b3.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782480552; cv=none;
 d=google.com; s=arc-20260327;
 b=HTYfyMrqfpah+tdtM5SEXZPZeU4Fy2SXOm20sT0rN7XyOfFTb4T0qd4vBk6Er5wY+z
 DS/jdpRcK6sFUJetp5tRhspXD8GYNXZETPLapNuNW0pyekmpuTa0bT5R4SQOb8YRK8rw
 SZcFj6Oj/ZFmhl6aE7NaGCDZzqjjm+UJjT+rsRCinv3iwxAREEnHwXN9sCWuIPwGl5ls
 7d+0PKwhXAdk9vF6H/UgCcm0Q+0dZV35kBTDdIcwXFDsuS5RkU/cGotSpI2zuc/ba7Ap
 uXesQM6waEwqVkRjTj5FZ5o5Ih67FHPnzqDpSofz5LF3lefPWVlu0gK9exVkbNzpfn6X
 LqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lq+9DCDJs4qcO94Qeuep0Dr5cUXp8On2jmGzG9pBI8I=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=XZ9j8dF0U+U9W4CNgu/UueBlZPeMy8wLZKMAuUFbTJTZ642JLtoTEcyCG2Aavq5aqS
 axognWNxgQ4FbD8B1YY8FyTXmSCVcEPNzWBX144qunbnfTw2dtBykngR7JLRDA/+IwSa
 6uA4TY59+rYcMwKNINCU0LbGkipFxCDkXSRuUAQd+hIwtm84wNt5JrpZqe2FVDK23huh
 xnqgrB5LBCRkBW1AwquktEwU426QdSY6rmzWwKM1lwWUc0SY5yn1784snDIUX/yqwvDr
 KQy/Hb1/pztzRLwV5WarkwDQMhq4sHmVWvMo/YQqUbR0r50HW+K7Q1WWXWY/usv0CkdO
 fqlg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782480552; x=1783085352; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lq+9DCDJs4qcO94Qeuep0Dr5cUXp8On2jmGzG9pBI8I=;
 b=obkk92lUOFwY7cr3aBorPAnc5wVtjR6n8vY+vxK8ALJl5A1W4QNyg7ZfgAbCnVpV8D
 7itwqeo1y7t4ZHM6ozitPePLi8JyOnNfJ/e63E8voQ9wJkMs634qjZioGbohMYXIvkFc
 ox7KEE1cCKKxF2DtzZ26pRJsivK7nBPZDSq4ogTmwKfNxEIhwA+RvsvWIaDLQGWVXPos
 BzIDJyxY+BYMkxsjESovhXkio6k69HFQYa0zc6zCbpOzLgetAZOFI+OSfYUilYONk3xs
 SBbVijGH3jFqH4zL6PWT7mf9jggwGjwv0PQag8gH/ZcsEAnSF5IAZJBEJ0sD+Fffh4ec
 xccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782480552; x=1783085352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lq+9DCDJs4qcO94Qeuep0Dr5cUXp8On2jmGzG9pBI8I=;
 b=SLn8ayLjekYnak4YOdX29NrldOqbgLMVCq/xBheiVAKAro796VgK7ZlCWn36iQoI2z
 riZ704AjQmDCGReZ79HnvXf99qv0RO4FkK2Fbg/WjEFImIvtBPrTyj1LI4JDMA9QZqDA
 LBroG0GSvvUsqoNdvrDRST3BMqDQKxljsEAEzHr9PROLbisDdl8YsXE5MrAW9RHjuTDS
 RBPHY1uE2mE6ia7CBOBY0uaPYWV+jbQWxnNwI/Gatb/4D0YyCYpRwc0BDhyZRw5T017u
 0tVYGswEnO1FQEwVq14fjOYSWC0yYp5GXkkBv4woi+kc811u6i1AgPaxN4wiw75Z5hKb
 FjnA==
X-Gm-Message-State: AOJu0YyEy6wkxjsw0kYrniJXotv7rphw5Q/kW7VQ2nR6ER2HO/M+2VAQ
 tfEtmYldDVDIHnSnDWTq2HS6KmD2WULqaEofWzlhf6rd5l4Te85UndB43/S4GxmQOR0LX4zJx7k
 RFUC0tHz1iHFTdJR+0xctAL2CdCUAZmcHTwbv9A5WCQ==
X-Gm-Gg: AfdE7cn45hDj+LOVjnHpGv917Pig47SF2uae2F11WcRAHoq28x5NepFwyvV4BWqYdD9
 gSSXs+KB2HFwEUQLhSt6XG82OdGdB4Go8ItVt6rmH84U2cnP5pYLsHfVNzmBwBMi4s5ujLkIqjb
 n1lC7CwGW7w73zhZXs2edGRtp5a+Azg1OvjTRA7qQzEIPpf0CKsh81YZZ2y3yuR+RCGbEvQYyxc
 hEi/VkBvMVXjHiuL2MHf23EgsscZu12hF7FtaYABhcYYECrJXAkGJJC0X49UEjpD65Y5AP15tPc
 YCqjmPUEyYV74dAJaeQwx+JQitKmtIW6CfCiiaQHApw0/HOh4xeSYRSl
X-Received: by 2002:a05:690c:d1c:b0:80c:2874:67d0 with SMTP id
 00721157ae682-80c28746a0emr12934317b3.28.1782480551688; Fri, 26 Jun 2026
 06:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-14-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 14:28:59 +0100
X-Gm-Features: AVVi8Cf1IejgidtdI8ZQT8o54GbL-e3f9NFPcLZNZLmxzL3r2FdD808ls3BvTuU
Message-ID: <CAFEAcA-LGmm4F2s_Y0YfQcoLtOveG-aQvHP4jzqCH0DJAy+JsA@mail.gmail.com>
Subject: Re: [PATCH 13/15] target/arm: Implement UMOP4[AS] (4-way)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 25 Jun 2026 at 23:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

