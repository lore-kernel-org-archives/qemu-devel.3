Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B6CC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1POE-00082g-2I; Tue, 01 Sep 2026 10:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1POD-00082D-DS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:23:05 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1POB-0001pk-Ej
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:23:05 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-86162c086f8so18687027b3.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 07:23:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788272582; cv=none;
 d=google.com; s=arc-20260327;
 b=GDZZQ5+6D/rFTD//3mLTSTDkGVITKfvGcF2/Z0QWx0FRSFwTD/Xq70WpgVisDXFzei
 eqlV+5dVziPErPc7sCxEQFRn2iKSjG2iKRyFCZfI8BbKSqLOGK5MVsA5nEx4B5WDJ5hx
 IcnD3ZHUITCXUJHxVZgN1GSLKc4cLUnxt1U04e81CeDCePyvUT9PI99Fi2QqqA1V47s8
 +OrJO3f51RVaFM1zM1gqXYrv1oMS9E00Sy80nRvj1zN2hR7og/C8ROoxLLodtr6mvbbT
 mJ0iA6tFZaIWka4rSgPeQkS0mOpkwFcyDTEuHC3DSpE+zzoPglmSFvwxLycCm+a4a+Pp
 weow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g1QeWZXUfVAZiaj4mSH166n13TxqjngX461xWPOuwb4=;
 fh=/HmZTtYTGRzUoXNodUpbgfFx3rTopm+VA3eCfRm/1og=;
 b=l56uVXQ+c2dumcfZbNkBTSSF70HeLPNp5RgxMNhAACxbVe3ahS2MprzjXmq2bdWKUD
 QO7I3VvfOgsR0+WiE3SpN91tCYBzKD6hjC9PmAw0Kyu1Py6I5SupDU31KloNBEvpfRgN
 6dhaqXN/pKDoIIJgdQSdrDp6xDMnBK4qnoLTwpxBDXHtlL9CbLynuvSmcVAyaNWhhhUJ
 TLGutJKfnERz2C5yc5XYeWYh+hqP9x6fWnGRuuGQbhhrcxPFiJWWKcCdl4POOnYUojAI
 uL32dM991RoyM4s+QHUzinNKj7gsaZFxDU5yqVTCAG0R47OrmQTKJnlbmgQbGubfnnGc
 mMcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788272582; x=1788877382; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g1QeWZXUfVAZiaj4mSH166n13TxqjngX461xWPOuwb4=;
 b=mR23GEkYyAYUrPb9YXXjE/fLqSyK6Q34qVlDkNECwX+dYc6EVgVvb6aHF2dJJqDlxh
 tQ9ImJgpghiI1VZTJBwh2+Uk7r71UMjIwqZcjL0KJWIRMZQ5sgBn0tpimwwhLqr2J7sN
 Sk1tWnz2rfIrl4xl6c6rUfXVfecn8ZhU5jZ3HN8oo/7HIlFyVMkRPsWaXYsJrX7CMRI+
 fc10RyUCqcJKNEmffyC1nWh8rTW4p+kxPA/L6JB1HpHhSDEWdx8MKYeq/AfPIGMUU/Pv
 l6PfkKMzRwtyQIeLtPnmbkfdl+ZWqWt7hdQ3KXIg66/9/32H48aggGQpC86z88DYrXdA
 CEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788272582; x=1788877382;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g1QeWZXUfVAZiaj4mSH166n13TxqjngX461xWPOuwb4=;
 b=EAA+OevJfPYW68ZHjzfLxATsTMwdiJvSq37hpvqR0czkiuVSV4zbXduWy0mqTJYWK6
 Gp77MBGaJSyO1PR9SC8EBvXc8kJsaKufMsBEK3jjemz7sNjUdSjb7UQFS+zR6RpiUitA
 +QzvKeyZe+DGXsHE6l1N1B43P4FTkrn/OlNE3xViWeItUJMxVY8QXKffD1tLN4ATJtfb
 xTzptX+obgsOI13Jo9eZE7tWyKuTDAxpCxJ/4efRna9vbT4VseX/+yyVBoiaSDk7z/Ji
 XJUGriW5Zf1gHcd64K86nk8gsclSrsB6tPLxaXiJ+HDdbRENP77RghlkYJBdE9A+cy0U
 EyzQ==
X-Gm-Message-State: AFuF++kUSrWG+3x+R7ejhxtaSDA0QnlZHh9yhrK5/4EzIvPSWa+6/zEM
 lhvmX54ZmSK4ysKLe9oQmNlREITi+oNz3C3Fe3SXycPU4HZ557maNs2dDs8sjHuf7cDYh2+Fm8A
 Aq+sy1fkqFOpsU9gcAS3D6UAV2N9Mj52+0AqKvCH7fA==
X-Gm-Gg: AYBFou3gACOej1YZTsZOEvPOWbqzDzencf8u5/whJ3fbAAlmiMW+q9PCp7btEKlDTKK
 LF0bCQstAhmeE1f4/kh2hs/sHPwdqeUWCclDA1Rq9lIAkeK/Gyr/ZUsmkrVJ057gITFpLQABPyH
 5ZmRwak/9R+ZGB+ogRhhKyNnZoGegRtIeTFpytTE8IRjCqRXUDjOQRvI4Nbz3uKpxWCxfjNYNFb
 +jnmScbmpN/5ZLlcK9YXCiOTbKonNFNfuAyJDH485wbuf8c4FxN3yjSx14XsmTy0c2Tr44Rrcco
 PdE/8FHq9whba17jCRY56mxZ+4Mg5QQiMGHxjLRClYH+3sPgHKeZRjYvVMO7Ob45YmPsCapxRWa
 Vl9MhQAvzwSXZ8bVBHFXSSgZ4l2Tl
X-Received: by 2002:a05:690c:6:b0:80c:16ad:2f16 with SMTP id
 00721157ae682-8694a045dbfmr25945267b3.8.1788272582068; Tue, 01 Sep 2026
 07:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260827193942.69406-1-ombarkare123@gmail.com>
In-Reply-To: <20260827193942.69406-1-ombarkare123@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 15:22:50 +0100
X-Gm-Features: AcwNN1W1JliP9ks8HYsDwWCBN81SKiT65AxiUmmbDZa0xe2ohI3__jiBl0IZ8FY
Message-ID: <CAFEAcA-_C1qZ6DS0O4Zbs=ZbV4uDL_vuSSxxxZcs-JuRPrB2Wg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/block: Add migration support for pflash_cfi02.c
To: Om Barkare <ombarkare123@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, kwolf@redhat.com, 
 hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 27 Aug 2026 at 20:40, Om Barkare <ombarkare123@gmail.com> wrote:
>
> From: OmBarkare <ombarkare123@gmail.com>
>
> Device did not have migration support, which would result in its
> internal state being lost during migration or saves.
>
> Add VMStateDescription to serialize state and set memory regions
> romd_mode to rom_mode field in post load hook
>
> total_sectors was changed from uint32_t to int32_t to satisfy the
> VMSTATE_BITMAP macro's _field_size argument, but that is OK because
> it's a value is calculated using the size of the flash and it will
> never be large enough to overflow int32_t
>
> The only boards using pflash_cfi02 are the sh4 r2d and
> the arm canon-a1100, musicpal and xilinx-zynq-a9
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4157
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Om Barkare <ombarkare123@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

