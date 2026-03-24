Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E0EE9A779
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w50SH-0003eE-NL; Tue, 24 Mar 2026 08:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w50SC-0003bP-GD
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:01:49 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w50SA-0003dK-PB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:01:48 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7986e0553bdso12454817b3.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 05:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774353705; cv=none;
 d=google.com; s=arc-20240605;
 b=Digs38AErXxvwd5MaM636M6Py2sTz+RnYx1QIPyJFvpaT5AklqLCCnzJNkrM3DSm9V
 iJSzPdxoaRyrYJGuYqijH6vyV1WbDFkOFR0LUVLXqQ/YLyGPl72kgb2Pd7M4O7b/1NW3
 PZaxO2EUDaG5AD6Yo/8m65HWSfph3QQzzqt6c3MlNrduF5NlTjXVCGzoJwKebycrIVhd
 WftuomuT9M74fMtSCEmGbiIkYlCxM8Au0ByQTHGOEjQOP7OfmrDoU097CfOoSuAXzn7l
 6OlWVyLPjxe6IOqo57CX7iqcmyg3EgxNNARYxQb3x8P0ekmDk9IFuJ4Xc1Ntg+8hXHs9
 FJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3lsP2JwMv66cLDbTRd3pQa0LQpVURmFthN5mUg9ce3s=;
 fh=gS8oh9EHdcTDcglskGyIv3/M5LtfI+jKdwGYJC227W4=;
 b=VQtwKHnPLVF4j9MIf8pf+jBuvK9un8tA1IxxOpgmh5PDKhIkg5QIL0hXTfneLRU9dr
 Omz53f5/cbRipGn4hnku6CaNmWe0/+AJcGLtKmu1DoMj1ooWtUmGM91RQrXbT5LHILyw
 hNQCh86pua901WUtUWqEETu3xBsM0Zq5ZVPf0DzM3dtORuWn0f+NIzUCzjOkbd8D7TSJ
 YfowQjz/jxbl+aLo4pyNVcOGT2vQ2RHtAtvOP0eUARBNjmAvmm24VOUCY99R5xl+yHiy
 7atjrQyL62lOpGzcDHWZWjwruaD7vmYt5bOSS96iEV8ZswKYW2xxUI3dYl/xjvph1L9X
 +Ebg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774353705; x=1774958505; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3lsP2JwMv66cLDbTRd3pQa0LQpVURmFthN5mUg9ce3s=;
 b=oVdLSEXhhfBdZ+rRZK6dwtRJlbU2SMki36uRvZZZrtOj3CkLLSyqbTrhn2A3K0vRih
 geEftfSiiiwkH3EeKfAVVyYOFOrAuL1c0qvVgJCOfX7DN5QmZ3YsTokG3PT+xnCSguaF
 Lfv0XQ8+hLZM/pITM2HQtc8dRKA86IXSqWB8unOnsjpguu+Nxr1j6vx4AyNAEaj3Xp6A
 Cvj7sjxtSb6ksjABVUzytG59BIrs17GCdzQMmSIgO91BxKRWRvNyQF3TbR5JmrKprqjR
 /wfkVfFurPmjmKGBz/Nn//9FeAZHj9oea2sPMGb/LYFfa3ScByx0uwrBLcVRnQDxmeLb
 KmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774353705; x=1774958505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lsP2JwMv66cLDbTRd3pQa0LQpVURmFthN5mUg9ce3s=;
 b=eTNov+q/vQkgZ5EUSmpu1YVLjvijJNgI+Oc7gfhOrtGLXqqdhQvLvtNdNWVV86oYii
 7MFb8KOaf7ZkLWeKwZwWbCgXR9ZofyobhplzNdBXwn8XkPukrUK6rFsSEsTo/l4iA1RA
 XPSk2ypW7PdVQC4nmLLINSFZdgydFO7VloLaCzHzKZ6aYHUSMmkbOZ2jdA2arroI+E5X
 D3aL0fr9LEseCXdhJATWnzc+FADGZV5QXQxuVHNaIqLB2KDYcNAOQBbLbCrscLjvlTDt
 9nJQpWv8DJJDA1aRq0hlNe04utPIU9cEjOGHbkBu49Eo8c0vGmMuZPaGzi1og/36l0KQ
 ZuwQ==
X-Gm-Message-State: AOJu0YxzBSL5i+t9A3MKVratKM2kgAif7FFbwBKT2QhFEcstC4/xkNPw
 Aa4zEfx4RoKC/oBVKDkTQ2Nu/WhtuQIS/dTcu+k2usEjO8eU+4tYKF7Ge4I4ei5lNQIvncv74uS
 EBF/Eqx01+e7hC7iaS0B6LVzTiBfokTmsWyvh34K7tQ==
X-Gm-Gg: ATEYQzzwVoCUnNfCZ5sHvhpjdAF+20OYW8le2IMElB7LNP2gzxEa7Lq/sMW3Ro4CN42
 iXS5UUdxRP6LlZLKPA/ZBpNybxIjBDOynQPdBFH1cJo+p3FIlCqr5PriTLKZFLq/Nxo24gcElM9
 uMNmKJ34mJS7qeSyt/mBZSfARJCYeT7dN3fHgHu9GSPoBphW1JA6UueH4xSKwj7OUOPTXfwqOtV
 MMRFuvEVBkoRyQQGQdZSwMGRIcPmM2J3vQ/+SkX5ZY0kpQaox0rvIwbpq7ckqhyG49UbOkYmWYg
 pcsHuH9e7lIsePSMmr38drReMAXYoKOZpnrdxw1wfgprMu15k/y00l0CN1bJy9Rwde8=
X-Received: by 2002:a05:690c:c372:b0:79a:cc64:886e with SMTP id
 00721157ae682-79acc649b03mr3170727b3.52.1774353704734; Tue, 24 Mar 2026
 05:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774282897.git.dingtao0430@163.com>
 <5856c66fd4e495b874815adba9dcfeddc1f47e65.1774282897.git.dingtao0430@163.com>
In-Reply-To: <5856c66fd4e495b874815adba9dcfeddc1f47e65.1774282897.git.dingtao0430@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 12:01:33 +0000
X-Gm-Features: AaiRm52iWQkGMAOQ0i383IesMR8GUpMcdWAeIgvm3ZG4qRN0aG4xL4Gtnq3feyg
Message-ID: <CAFEAcA_224me4-P6w_yo52GVEqWGHOeW6L0biQUEEdqcp9LNaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Fix transfer size register decrement in pl080
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 23 Mar 2026 at 16:50, Tao Ding <dingtao0430@163.com> wrote:
>
> Configure swidth to 1 byte, width to 4 bytes, and transfer size to 4.
>
> Configuration
>     ../configure --target-list=arm-softmmu --enable-debug
> Reproducer
>     ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
>     -device loader,addr=0x00000000,data=0x44332211,data-len=4 \
>     -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
>     -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
>     -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
>     -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
>     -device loader,addr=0x10130108,data=0x00000000,data-len=4 \
>     -device loader,addr=0x1013010C,data=0x9e47f004,data-len=4 \
>     -device loader,addr=0x10130110,data=0x0000c001,data-len=4
>
> Qemu monitor
>     (qemu) xp /1wx 0x00001000
>     00001000: 0x00002211
>
> The result correctly after fixed
>     (qemu) xp /1wx 0x00001000
>     00001000: 0x44332211
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---
>  hw/dma/pl080.c | 17 +++++++++++------

Thanks for this patch; I've applied it to target-arm.next
(with an expansion to the commit message to describe the
bugs it is fixing).

-- PMM

