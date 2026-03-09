Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39870F417F1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbye-0006P1-Mu; Mon, 09 Mar 2026 10:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzbyU-0005yp-6k
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:52:51 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzbyS-0005sH-7c
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:52:49 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c9a6d6b70so10010021d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773067967; cv=none;
 d=google.com; s=arc-20240605;
 b=ZIvCwhxwOTBmn+hYRRdRNO/sATvqowfCqvtIa6tjlXb4glR69HaNq/cefV+bFp/MHQ
 BVxI4De6zeMMMo/h7Hd+PVaWWko60UGzbira5Eqy+LHPgFofDXT8FyKLSivr8peeSBkA
 EdZqGcH2UyoY+EsnuaEL1LwuoBSb58/rhWKQ2U92ee0p8dSTcVbxpSSE82GZYPrBR6OS
 GSHK8Zl7olj5x5fyOavLh4WHpPGyvE+tyU30BlsUyh0wuWdRT+Fx/Bo92fwP3dL8nHbO
 HpGL92PjnWBF7aNhuVmJ3kC2jgkHhAll/TEdRko4mP3gYLd7p7be+WwHu3C0gMCLULX9
 TmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aaWxmCygS+06T1Z/6OmEDJA3Qwshp6nQxuZAsy5aVhw=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=c7207Ga5uGH1QY0qLGZqmF1YTq09kqYzltwdNtYlICTuaSjSE+NGB/h7MLnGuLtRSs
 kY935tchsShDpIhAo4e7mYDQ/e8SZ4Na5PjQoH5tqIrX44VnMnbFmdu+ne10+nG4o5CZ
 5DI1S0OiMpGK8PF+sKYf1aSB29zlvBfcHmCxIB408seS5S+8n4Nq999O81fs3yd9bsBr
 SIHyY3nAOOaejIiRdgA+jRc2S000UQtuHQnHnW2iQXEtnByZaHQHUGtyjoFYi3KsaDbq
 SP5cMh7+CuBQ6u31XqVX6Gb1rlfQ4gBsNO4LiL7ulpIriMFAsHzukHR0r53fRX3ffqh/
 G6+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067967; x=1773672767; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aaWxmCygS+06T1Z/6OmEDJA3Qwshp6nQxuZAsy5aVhw=;
 b=jGy9ANucMghTTjBWms/JErcOCt+ic4kknyutsCVKZxBbLDBgPKQuUHa0AmmxqmBP3p
 EPBQUrP/dC4k2tW84I+FypnDMp6fpI8FwO4zAHHn0hAJKhmHcI79UF3mxqL3ZkLntQnZ
 qF/vq8apbqqHuZQ7StbiXHVGQp0+WBEJf4LfcM+kfrcO7spjVRvVNVCBKhBwXSaUHLjv
 2kORxsEsMxBW/0cUb/5nXarG/V+yh1vGT4KgiNqkY1i6oMLCOvliX5mTvJ8+2beiB1+J
 6Y7bKpXZPKQvL+MchbxQpQohlU2Vrr9Km51cJbCk0sV7ETftGwfwCATKoJE5a6ESeqvB
 xnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067967; x=1773672767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaWxmCygS+06T1Z/6OmEDJA3Qwshp6nQxuZAsy5aVhw=;
 b=JZVLC2z8AxJ+68bE4zDbif+zxxGVOF55J5k+ReQGl1spNTqQI9B1Tew4GXxm3T5nzo
 7KLBw4iHVS1ZuEMUxfMQ+u1hFKdlzv9wGNSNqtmVGQKWe0iOaxfQh994Gs1aTzxIK2M2
 r6HZdt5sU7IVPQ4BT90+S8K8BgAj8r7N7LJZ0k+wpr4P+v1ZxJkh/Y4294b04X6X15sw
 BWSwrBRm56uooaY+Btdcb5GcqxJZQj7tW2KGBWUFT8kaOkl1DMSlBT8Lh3Gqi8ZV+dv9
 3ZDM5i2fh3BJLJGj7+t+nKO0qidxEKyaklOp1nblEkYCY5dhhwjOc1LbrZ2Gj0oLOjdm
 vbBw==
X-Gm-Message-State: AOJu0YwMb2F7WOgjQKDoIr0P9nBhwnMBY2QWn81Unjy5q/oJXhmPCpxi
 S6j45qf7vH1rYSZQfplpyDB11ijSwBnbZsQtgVnDc4f+SvOfi1KbsUvRviboWTxIkT1UtHZBF3P
 0IAHLy76McTrTQX1gmKXDb284ImIXi1g4Qv6nZ61gDUYxN/RE07RB
X-Gm-Gg: ATEYQzxmstwcOMaQ31uW6siFD/3wd2kfOmriDQ7GqylmZ+JMA9ikcWDCx3IE9ug8KuU
 MhtpypRYE+kDT1RbxFA+1/mcEgyOnxIPAYVbm6o3RQxTVeYa3s08Y8sfKVJ92a7zo7nfNIGCnqr
 4Xe+7rE3WFZqdcf27+jU8IWWeIxTaStqY/5Xn8AShqFCoJd2eDNbToTQgidTRlxcqRPq0isje6b
 4jMAzi4/YDVru6TDNbaiwLEFCgTu78mqtIw95MgGEkMFm5SWuqObN6DwBVr3jl05h55hyTQ28WC
 175QXDUIIMNytBt9UhArnfiaw00bNHPhZG19pf6Am8RLaGjab+X4zXS5fkvi3UH6y6g=
X-Received: by 2002:a05:690e:44a7:b0:64d:10f4:5d3 with SMTP id
 956f58d0204a3-64d142c583bmr8321295d50.57.1773067966978; Mon, 09 Mar 2026
 07:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260307210021.878274-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260307210021.878274-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 14:52:35 +0000
X-Gm-Features: AaiRm53ILRV4Jzq0IWSe81EArvfW6WCKjyKgNNV3aMVoeHELuG_8fduP93rQOgQ
Message-ID: <CAFEAcA9DVvoEsOs5iiA-omjvnJBY=WhzkFbuvzgn9cn2kvNcpw@mail.gmail.com>
Subject: Re: [PULL 0/2] Plugins update for 2026-03-07
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Sat, 7 Mar 2026 at 21:00, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit d41b9b44ac9a9c4d82cc74f59bfd1bdd4ac4014c:
>
>   Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-06 18:57:12 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260307
>
> for you to fetch changes up to 1a1cfc0a32b4345d5ef3f643994ae409eac9b164:
>
>   contrib/plugins/bbv.c: Check if file is NULL (2026-03-07 12:59:36 -0800)
>
> ----------------------------------------------------------------
> Changes:
> - [PATCH] contrib/plugins/uftrace_symbols.py: ignore zero sized symbols (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
>   Link: https://lore.kernel.org/qemu-devel/20260306051553.2778652-1-pierrick.bouvier@linaro.org
> - [PATCH] contrib/plugins/bbv.c: Check if file is NULL (Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>)
>   Link: https://lore.kernel.org/qemu-devel/20260307-bbv-v1-1-d5757d1deac8@rsg.ci.i.u-tokyo.ac.jp
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

