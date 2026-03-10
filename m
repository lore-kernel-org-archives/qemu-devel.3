Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C31EB106E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzys2-0005cb-HK; Tue, 10 Mar 2026 11:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyro-0005MP-5J
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:19:30 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyrm-0001Jk-G4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:19:27 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c9fcc24b3so10070963d50.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773155965; cv=none;
 d=google.com; s=arc-20240605;
 b=dn6eylP5Jn7pQHDsa4KmuQm5YOiXBXABPOq8sJKIYQEHIVbLbF1CLnecSki09/+u+M
 1m3qf6uibSs7ijnct9VKcSIiOkW0QQt1Mu+3CfQ5voGhHpYqzwqTSQMZT8iwQJz4Ckx1
 5W8nH//M2jys5oGUCxDWXOXyl4MhUUiFwmYji+ktI7XyfSXb230rRnlI4+/rvahELc3p
 6VQxnfY6b52STA0rbWU51XbyC3REqU40du9zyNe1SNPgveTJJnAKOwN1ltsnP6Msns8E
 5Zl7596A6+/ZcK1LwJNT9t5ZjWVaoU9sr+lZj7E632ZH3a15koeSWqINB3YnB1fpgXwo
 ADag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lOI1BRDxCMVo/1iUiNUleDgDN4Xwyre47yAQ+qV+A8M=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=Hcg4raiNXT2mZ5evlolwIUBEx+SOH9pwm45GP3q0iaBzZEvhxPbqVQrtAHEPTuNmsQ
 tT4SI2sAUQNBZ+bDoMqdKZ3Z9FnwU5h+uzcDWEPhvecfoCnFXVQSMqPu2J8yG7DBDGJq
 RQ2lCxra5BP6d7BLkSq0FbhCPYldoMsxnDv8ydgxsU0slRzxHGgR4OplwFG/cTVkq9up
 s0SY1VeuFg20QlAcZury9/SWGCCAQcCldirzEEUplHtyfAKMe+c95xJ8FoI8c0rYgDvy
 zb0oGl/vXTGqRki7dbu1wxGvyzVCVdfqmG2cCN4WVQtBijby3LPbme5Ew5+bpQbCN4o7
 I5vQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773155965; x=1773760765; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOI1BRDxCMVo/1iUiNUleDgDN4Xwyre47yAQ+qV+A8M=;
 b=dMHuWzomfLdGFqCmacCr4uj4vcHSZyOuibETPCCY8XKV+rBd53/oeJyFbU88qE62Cj
 LXghE5QSNLRZSQFzgkaeUA01uyVLNx4qUMTAOJsh0ssFQoiQW3TL4o53EWD16spVg74L
 M10Yql55AG7W8V7Y69wO9Is2WFBCY8N9FYO846HZhOE2K6ounDJUAqku2PToi3QBDh5c
 lsRxwnooyG0UWW0I5FlIluhc1d7esXK2ek8E7mETP6bl+DcwNt6meQP2eZv1VOVrgAzv
 wqt38DU9pGDMe6auBPy4FoBoN8XdMUWM+KiwQJi7qIB/QlCezY450YUUDXN5V880geTF
 f0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773155965; x=1773760765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lOI1BRDxCMVo/1iUiNUleDgDN4Xwyre47yAQ+qV+A8M=;
 b=qJZR2++6w9SLOVyoRhJs5cfxO9oK7YsGtrwpXDB4MYZoIg6tW9FaIWdQdP6IEuLdI8
 YgFMeJlyHS3KMWG63d1Xd6XSS99GrDkPcLzQPhsrKprZw0FxwIyqWXlAlYVSJmiizhPY
 ABnqWBOECfg0MU/nCeGHsLD1Y5MHrb2t/MR9yKIsQ8EMBUCe4vdqE/C7T/maurFvexbU
 Ih/oJTdmAYHON51zqBMbA9tHsXXihC5KML+f2QVpfzaJZEqTxDpramRKIoqD8+ylRbjB
 8PjVUNxbjnuLGuT/NjssiTinZrdxuDJq31eO4qemDmpaHKZNsVsB0S/2MRT5Qafo16y5
 eH2Q==
X-Gm-Message-State: AOJu0YywDE/85vuWNNuBhsRBHo9o2i155hhGGNd9zxta7kYblqLlmpZ/
 sEGOzA6xjqY8svEUg6BFhvnqpxdpwUvNKRiNfesTy541VuTsM6EsU6CyXDvZWKfYP7Bz2YTVHsq
 aupXiw45tudKV2OF7+d+uJBMsr1RGPc081tjlYSJYN5wM3Adrl5Sf
X-Gm-Gg: ATEYQzzfYwAYWrqGogi0CxoEJ+86Q01PGoc76vL5zr/2p8G8OWce2IPEO+c/Jvt+9po
 cIRCUf+pnQVnwxV0SNPgyCfiFXBlrzWQE1SG60ppFFiBoSdNgpIqABq9QtL4cva1RSGM+RxjWaD
 RPMXzyN3QL5ZDTp2UNqo6raDshjy+42JA6sFuJRaFDjDKXZP/AUU0wWDRiK0dwxYv7KdEuelCdq
 YxBqLS5yWCHHAEcoyKLr6orLHfbXaHSSqLH3sDKhcL4887/ULyFWEL6brIVG8vxWKObJpteeARR
 l5VbJ8uW/fORZCpJi+EeBB0th5qg3pB/WGe2GinREbTrFs6YIzKg6ODAgBIHN6XcW1Y=
X-Received: by 2002:a05:690e:d8b:b0:649:4302:cea2 with SMTP id
 956f58d0204a3-64d142794c8mr15066188d50.43.1773155964973; Tue, 10 Mar 2026
 08:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260310104511.12670-1-philmd@linaro.org>
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 15:19:12 +0000
X-Gm-Features: AaiRm53UC89M-8VTQqTr0eol5En4YxibiZqL849JFoTa8kcz3YcXhDMNG-j3Dfw
Message-ID: <CAFEAcA_85Up12iEFMhPDvhV2cXgoUVbGriNXwpkBxz=xtv_otQ@mail.gmail.com>
Subject: Re: [PULL 00/16] Accelerators and TCG patches for 2026-03-10
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 10 Mar 2026 at 10:46, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 31ee190665dd50054c39cef5ad740680aabda3=
82:
>
>   Merge tag 'hw-misc-20260309' of https://github.com/philmd/qemu into sta=
ging (2026-03-09 17:19:26 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/accel-tcg-20260310
>
> for you to fetch changes up to c574ff9245c7e9d10433efd60df2319ff4d69084:
>
>   accel/qtest: Build once as common object (2026-03-10 11:36:21 +0100)
>
> ----------------------------------------------------------------
> Accelerators and TCG patches queue
>
> - Improve TCG extract and deposit
> - Build accelerator stub files once



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

