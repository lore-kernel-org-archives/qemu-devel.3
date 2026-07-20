Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D52C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlk9B-00050y-Vu; Mon, 20 Jul 2026 05:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlk9A-0004zy-95
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:18:48 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlk98-0007UE-Tq
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:18:48 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81ed073fed0so60532937b3.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 02:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784539125; cv=none;
 d=google.com; s=arc-20260327;
 b=cfTQn8DfqPoR8tkZeVzWQ/nMbwtYP4iu3UFwW1CCEEUzuD0MmGBmX8PRPNLEFlsU4k
 TmwM2719MzXn9BlHK9Oqq2d7MplLHBW0N/KFzvaF3QOj5vX3SvaML8uf5KN0w/KrEl8q
 tu8Gv8dAwkSJ3FKTQGmseF77k87quZb2agzuCW/z5jcpPP82MiUw7QUaSu5QiEe+IFtO
 1C4p/Voi8Ky6NdhN/0Wedsz/iEna0stVbMFqJ9vp1qVI9krXhSNIpEsc7nKm8ANxWvQ1
 z8xKsGhoTf101f9vHLcnIwhAiZj7Dgjc93axmqULlPfAmlCtwAb3Ey0ARIfonhWSrU/c
 1tpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hFV1MBgS1ENnbxAOD1Dw8oIeg/DLN9gXGUzu8Crw3gY=;
 fh=mXoCpKTup2hux4vfeAobyNjPZsaFk2ZXYkZjIRJ+/A8=;
 b=YDPTRGkV1dP+SyH9em6Ttv/rBGAu3askLHeqdz+D2leA8N3mcBMdON+t09JfsVwuE9
 oPan39BkDbhF0sxFSPapztpsE0Qg9AxfSCTGIiMX3QRM3z1NwJVWdpOtj1YSNsug4zFx
 jt84rV56A2DZLNf4yEK3cKdFGyC5jzB02xXyge9x3rk2ZxPA2yW/QToe5jMdQWXbgBwE
 bvv6VovyXfDDr1d66245abMVl3HngBLq2O+e47ILL9qQqlpZ3rSN7+C8Lf0mXJDCiWTa
 05ZS+5GVRPJ0wqdCOwevvpQ9nFcDt2h1h1FohIrb15imNvDp7cOOAxZj8KM30lOWchiD
 EGHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784539125; x=1785143925; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hFV1MBgS1ENnbxAOD1Dw8oIeg/DLN9gXGUzu8Crw3gY=;
 b=lTeL67AB5lG1zDywe6N3OKVMedQcBAGG0cYqJ7zhGn8OSBBfIzqUWKfvMI0KjpAgoM
 ZTJpDqCZpY2GaIos8GWMM+RwlIy2fart1PZxqnzucik44GLJ25tEMMhZT7GLT2bj76ws
 KpIO+wdY1jSUbWL2wRYbyJfEHU4lK20Q7v2WhjxE+CcbxMcgQ81jZoNbzgB7thF6F33M
 u+TPj/AK32/kJgi+CIUukB7wtAQ35Z71YcgtAjWV5aP4CDHFAtW9aBbdrT18BYgeyes1
 8O7f8S1LHSBVs57pPTNktbRkYN7fIgJ7TLwrh+H/+8D+wHHWEhUevj3SS7zIWFlxZXth
 98JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784539125; x=1785143925;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hFV1MBgS1ENnbxAOD1Dw8oIeg/DLN9gXGUzu8Crw3gY=;
 b=XPINWqDuw2IOcILwKx9/BbsehE2SPOIZzZQ0j66we67213ZHo62A5I1IDjkbUg3N3O
 Hxb5U6zle0WEbm7KuwEcQrzKkOLGGN/kjcpUPJ7TtV7csAVR1eDJqeGgx5vfStPVJuUt
 lAcZ3tP6g5VbrGuCwTphq7LGhsQnpG3rm65slruzE6Wwq/lqqebK8e9OPRb1Ik04AVB1
 vMc6uphnntf0CwdPoUmKeZKkUbhZr+kDFEVnUtOEBG3+E4FJpolmrFk3m2A2uJC/4PIC
 GhmGW6FwpNbtEPojMje1D/ky+lpnCtO7jDcf846rHFjRGHoN0lq+nz6axoFT/AYrJWYq
 tiYQ==
X-Gm-Message-State: AOJu0YwiULJ8mvoQsIuz7I+MB35BonvEQxfO2vE9kmBqqti/6XjmrMaa
 WUWOjYXTW9aY9d2uPfl+uWVR2UOycl2Xq+VXoEoes4/4u/YR0aEXvS3rotnmElp7O18K3etglQc
 tq+xOtc1jto81e7DZ48djhil2+rxJFwvLEUIGrDxfPg==
X-Gm-Gg: AR+sD11+wpMr9dhlJgmI7AGxTv0S7mgA9ZLPd9snyp0pxIqCl2PpBJChjPqLTw1G7zU
 M2XbFfa2cfAx5j2kxIXPDaTOYqLa8xQojKzfcBJF4xjkxVYbflc7j6k8glyJHWW4v6AG6LRtThw
 G1AfmpFZQ/ZAANbMWAhwD/1pgFzV4niq1s51MjOj7NSpleaxnwskhaf9YOC1FJeLSd4ghNjxoXC
 KGk47rKBiXRgxN7BmnvZK+FmkQqBXYK37df9oLnrVgGYhVtd9BFNO1hMiUuilnqSvkWE5icOBf1
 bOhzgOOKrgiNVofaP7BjeVWajz4ZVkrR+lYCOSUqiTuO0uy5cF64Jvqd
X-Received: by 2002:a05:690c:67c4:b0:809:6b62:2f7a with SMTP id
 00721157ae682-81ef25a527fmr37856887b3.21.1784539125623; Mon, 20 Jul 2026
 02:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260717161430.37264-1-richard.henderson@linaro.org>
In-Reply-To: <20260717161430.37264-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 10:18:33 +0100
X-Gm-Features: AUfX_my6J6urq9aADMyjzfzXn0My3fx1hOazYLKZlNUvDPupMrrQQSKq1cLTPmc
Message-ID: <CAFEAcA8DYgLnV8YGPDsnQWR6wyVepbR=qJfJ5b4yFKJZD5mfuA@mail.gmail.com>
Subject: Re: [PATCH for-11.1] target/arm: Fix testing of raw mtx value
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, brookmangabriel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Fri, 17 Jul 2026 at 17:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> MTX is always a pair of bits, one for each half of the address space.
> Testing it like a boolean is incorrect.
>
> Introduce raw_mte_check, a mirror of the similar mte_check function
> that applies when MTX is passed in MTEDESC.
>
> Fixes: 8912ceced815 ("target/arm: load on canonical tag loads ext bits")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/mte_helper.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

