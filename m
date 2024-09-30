Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56593CE835C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 15:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svIi5-0001HB-RF; Mon, 30 Sep 2024 11:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svIi4-0001Gh-HX
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 11:53:16 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svIi2-0000iR-TY
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 11:53:16 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c87853df28so5055809a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727711593; x=1728316393; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OSehD90NmzxSOd4476TeuH3zyinKxJl//eu/9d6Q3fs=;
 b=Eqzix3tp+mZC+JGUUI6aANT5VBcnZhfpIoHvu6eEw3vKNczYSHbkKSesvKlDkEMNrI
 Sf3X9ymWTcflJ7V5Kt0ej/fJDwnYMQXGnrbMGOp/7U43UumaObXNZlwBfn3EhMhNZfAS
 1/zx7EyUiFUOkOPrQvdM4bDrbtiVYqphXuERgTrRwOkblI+FeiF7cEWpnwYuqQIhXIvV
 zg3ydvY6/W7FQ5PNlNIUQb1K3LFDrtSUxA0IuuovJ0MJOASdGjF334Mhqn8/Eljv3kND
 Yx7lt1mUVzMAEbAJYD/wvm9qq7R4naRUrnrz/fEAomdH4t7tl0ey/uYmirdgT/i/P3MG
 UOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727711593; x=1728316393;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OSehD90NmzxSOd4476TeuH3zyinKxJl//eu/9d6Q3fs=;
 b=KFodh+ZYXp4STBSuxOhOl5fINnbt/XgPtGS+D01YrHB3ex1PmPsat9ZRwJeLAM3YzM
 bjuLGVItgJ/yxOigl6omlBrFkM6J9wUXqEmcu51Luma1yUA5SzpO0LrxG8vjrkFVklc1
 F9b8riwvYOYk8KaFq6XDUH2hcbjGb9BjQksMRkzR7G/7lpKThZd295cnmU1slsvhxxFx
 vqj5M8bh+EX/tf0NhkNzmQgS/AYhF6sLzAzPkb0snvePkkR70kNXeodqyKvpreum4LuJ
 yzVJCr8S3oq4DF4wtbjBFp+5SVRwUEpR6b7ApzndBg5VGFqOEHSMezMe4c5CjJVR/sus
 2Nrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBiQfzaPgwaocKooWSk989Kv6c2a15DKRAiLgUM0kpKlTDfbYLvM8+V8DH7NpLOKqYPCUZgwK+nMVx@nongnu.org
X-Gm-Message-State: AOJu0Ywy5nMp2Ktr1hCqntz9tcrok4+ADTnTCHI1iH6h4rlAQ4ngTUI+
 AGhEJJEbxeEcMKOFm7UJDZm52SvnlFhNFIDf7CfnCmQLTTHKq+M+2TYQouuCxEMT+X9boUb1phY
 kH8RYfrQowjW0CIC+m+k9KUQgmU+6jK6Ab4zaPg==
X-Google-Smtp-Source: AGHT+IH77nXGaZWfP5aJzLG3iSTnuTPNzlZ9o5zrUXRHM3DwmDxWyew2TYF/EcBoS57nhWgQFarp1xH52g+nFR+CD0Y=
X-Received: by 2002:a05:6402:2552:b0:5c5:c443:c22c with SMTP id
 4fb4d7f45d1cf-5c8824e7967mr11467707a12.15.1727711592951; Mon, 30 Sep 2024
 08:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240924112035.1320865-1-Shivasagar.Myana@amd.com>
 <ZvqabpGOlBcQoZ1T@xse-figlesia-l2.amd.com>
In-Reply-To: <ZvqabpGOlBcQoZ1T@xse-figlesia-l2.amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2024 16:53:01 +0100
Message-ID: <CAFEAcA8Lk17zf8SQ4YHEO1t_p+=iEyUiSX-fJgK80+FbNzjy0Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/ssi/xilinx_spips: Fix flash earse assert in dual
 parallel configuration
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: Shiva sagar Myana <Shivasagar.Myana@amd.com>, qemu-devel@nongnu.org,
 alistair@alistair23.me, sai.pavan.boddu@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 30 Sept 2024 at 13:38, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Hi Shiva,
>
> On the subject:
>
> s/earse/erase/
>
> On Tue, Sep 24, 2024 at 04:50:35PM +0530, Shiva sagar Myana wrote:
> > Ensure that the FIFO is checked for emptiness before popping data from it.
> > Previously, the code directly popped the data from FIFO without checking, which
>
> I'm not native english speaking but I think "from the FIFO" sounds better to me!
>
> > could cause an assertion failure:
> > ../util/fifo8.c:67: fifo8_pop: Assertion `fifo->num > 0
> >
> > Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
>
> With above changes:
>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

Applied to target-arm.next, thanks (with the above commit
message tweaks made, and restoring the truncated tail end
of the assertion message).

-- PMM

