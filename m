Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704FCC982C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6V8u-0000Pp-Qv; Tue, 15 Sep 2026 11:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6V8r-0000PN-1R
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:32:17 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6V8p-0005kl-HI
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:32:16 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4aac929eso506568d50.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 08:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789486333; cv=none;
 d=google.com; s=arc-20260327;
 b=pbv1+0BiCuZ8w60JiEag2ed19sMyiRSNbx7mgKt6tHT2VLeS8nv4u0NrGRlg+jchoF
 cgG+eM9GWFcDJsG3xIm7xfJ5CqLyxSCVSPQTDrzIC3ON97h/KVt5SEQuiA6cSA9nA37T
 ERk/jPq0mMKfb/eS6f0O4Do3jwpdpzq1vyCABA04qDO/s/WDyoXYyoz4UG22j2LNUYrN
 PXez+6T9EdCH9Qyk+/8qCd2aURdLDqImhLcgXn4WAPIWMFIaSqOIrNGo4sFrVkV8T9gG
 JR2GDz3aa6ciLDUqqjNU1wRpj3kzJtCCbNvk4deHztnMGG56YLDxLyKeibdBUzZgl6Uy
 uKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kDfQfufnfBJUyNtSydy9xsVwpmfRYg7ynzDy9E1+p48=;
 fh=gicmf1zLCz5mLo37/slHRwiGNwG9FuwwhzHTeCt9t94=;
 b=Ybm/hPf8s3T2lnQaARox1ACiupAFSuJwAsK9bBgLTU9X8yCGphYRTXFrEZFIhG83eA
 mxC7XKzI2B+gU7gDb7rQk42iJFLpS4NW62zseN5wN9IjeFSuZ2nAhYkhXXxxWNBAXLGw
 7DAu6tKkIc/aIDYTYUREUoni/n1bOvqjpGy84LjTC7OkExtubRvQOagq0JOcfnusEIQj
 715GsyherdE+0sNM73V6PgAZOlVyhG2cEQxOMrRziibpQRDOhJ6CWzn53oWvJXcT4lUQ
 +x1crxsDPNPGbfoA+MBCEI5J4kZ9w79E6bJFimxC7G0dyeZ+6VmJuM7TJ5Xf0WTPtIKR
 NtOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789486333; x=1790091133; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kDfQfufnfBJUyNtSydy9xsVwpmfRYg7ynzDy9E1+p48=;
 b=U371fyrn3aqHSkqmJ0cRmbyP3AM9NFQhGsheFNNNZxIIT52zoTEfZCXzpNqgoIzlhq
 O8zeeDgBfbfj/3U4Kt5JYwfagc/w0Z9PPx2pdRCbnUMViyxoZtx63PqpM4Gt3L8NPxUi
 Cf8UE4CaRJnfvw11aCk5GSYR6WoqI3pZUs3qLzCNk2Dni4qZEdpig29jyhwHYzdUSDw4
 2t1VJu43uQMofQqN3mUVSt6QV4jpdeTweiUL0LOVDLWJtqURqMkqUq8dUj7nE+996pnX
 UKkb77WY9bvmg5SCTbVL9kLeYegLTpzQ1Bz2iaKsEbgnd6HYLU2HhDoaEQ3tn/UrL0CB
 WbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789486333; x=1790091133;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kDfQfufnfBJUyNtSydy9xsVwpmfRYg7ynzDy9E1+p48=;
 b=XhAi5LTad7U4fW8TwV0pM406GwhFUyWI/8Yj9TCBCetJ4cDSme1DM/WgGNJyInf5KO
 LB7lAO8wgGKTF6QuzwJfJXpwGe7BkPMq8vAqL5OTX65BLd7z3SCU0tfSsIU1qOdW7PNM
 yHZIkzx+LEgJ/IyVE1CdneWxeEovGKlRZTFSZ5WrA4frnnt9gSsrWOQqdGtZWNOTGOaW
 g3mCJFqu+VYSn5qFCjVuR2u/oSHuWuW7ebNO+tDWsWeqea5IAOaPDdVrOiY1VCEmL3pb
 WdWhiIxZJD1dvYChS2UZhz5QahiAUq5J74gxurd2iF6/+Wu6742vd49Qhv4zXYRBvv1p
 +mVA==
X-Gm-Message-State: AFuF++n+Av29kKZhahJ39aK3BAuhkV0u7TCzRNn1lBA+2ZasHxi9jTkU
 KYEx6+hdEMeuSFX6ngU5pGC1nGMtH/MNQmS07Uzc6u+Oc5h+919jqZ3WCVBo8Nt/AF2oBFrBCO0
 XT0bis2BdvjTTM6wvU8Dn9r/k246sF9Oh0tiymVCtmw==
X-Gm-Gg: AYBFou0UsoNqHpfxziYRPuagl1GQY1V8IoNG3KLkIC5weYS6iy2Z/se0fzE/kxotHIZ
 anFqVm2c91AyLwTxnylAJJJ+3rYrqCjimVpzd2jKI8PF/NbnmXbDHDZmHNPbKfTnXYOu2qw7K1X
 rUPn357DcyS1sg3wVI+2WLsKsCg/T4D/96YxqS45H7ckxgVupxarVskZUN5UNzqZn2Ahaeu+EFN
 cxuGx3ymEp4AyZi08oi9uFffGqOfRMeCWOV6c//QPVpf5sNfwkfjPXna/I4kLB2fw2h4P1F7xjp
 qsFHFz5yZYTrFQGWR/atURBDkV9MCTyzqZHyZrrwvXBUv7NPi6Bhg7o8Vnj10nAdNR+La9mXH6P
 AZJeIzbi7Wayx15/Fl66I5IxXZN0l4tT0HDyGs2A=
X-Received: by 2002:a05:690e:4084:b0:667:b84f:e402 with SMTP id
 956f58d0204a3-6715cba53f9mr561851d50.50.1789486333292; Tue, 15 Sep 2026
 08:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260913-allwinner-gpio-v3-0-a9affa474b3b@gmail.com>
 <20260913-allwinner-gpio-v3-3-a9affa474b3b@gmail.com>
In-Reply-To: <20260913-allwinner-gpio-v3-3-a9affa474b3b@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 16:32:01 +0100
X-Gm-Features: AcwNN1XK-5z_vfTfxjcU7TSFEKGqx6VwiVAAk7VJVW6c2JCjP-nmIdD-OUAPr78
Message-ID: <CAFEAcA9SRQz2aK8=T2y=n20Xq6RcFE61aDLxOyViYNj-V72P_Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] tests/qtest: Allwinner GPIO tests
To: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jack wang <163wangjack@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sun, 13 Sept 2026 at 19:18, Strahinja Jankovic
<strahinja.p.jankovic@gmail.com> wrote:
>
> Add Allwinner GPIO set of qtests to validate functionality.
> Tests cover input and output port setting, as well as interrupt
> functionality.
>
> Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

