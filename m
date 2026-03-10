Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21DBEB105A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyTH-0002O9-IF; Tue, 10 Mar 2026 10:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyT9-0002Nb-4T
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:54:01 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyT6-0007vB-F4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:53:58 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64c9707fc11so9575967d50.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 07:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773154433; cv=none;
 d=google.com; s=arc-20240605;
 b=X5pC9SjzFyavfT7YeJV86PwAfgEcnyQwomzrIur/9PSS2eyrf15/XYbIFxLTARO+PK
 xK0iasSKcKtutdPRuvg2Q8zTDvkbWdzlgsGMsBdEYvflv3exNUWdWn9VMAolB93ue5fH
 7T+h8/Uc6PcMozJE+yqq42sW/FkxKYhNstIsg6QHDiZLNj7+FygASTl5Kc4qBlVbudq4
 j4C1diUZ/vhU0Et786rySYyPjBOHP25nJ8r7C4qxiUAv/mBXrJwXZN9M2htIeuY69nRG
 AEYiJ1iU2X46RHeUdcvx6YNkDWcH+xzEhfZOMSxUgG15WDTjsuzMaOPDbDo8XUopZ4X+
 SJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z94pQJHhqAsbNWlTjCSoPpfMMuvEr86vdQmfbAcRKnA=;
 fh=BFzlGlhJxSMQdNCS+i9+PDMTEaxrZE3j9rEjWrtl+6w=;
 b=kSvE3F4sTnG5Fra2Do6S2tXahKyxnxgJhckXX9lUP9+0kOsixxH7j15wP3JdBhT/md
 p+9sS/xCtlf/1p4G9GA6QXCiGaGqqYk95lLK1wK7xh5MET2Kc0GUWtaDt+xq09dAAcpD
 c/OGbVhnizbmKXiQ8Mug0nEzWD0D/vsX4wna/fIhTJdaw7Np4M+KuAZYHyPJpLQvGppr
 PJg1XT8stFTJKFkx5ijO/Bno4Y3Q+i38ax0+Td4hk8hOafGKG3hqplPwNCIfn6gyO4k+
 lrgjJ4kWd0TlqFCcyhfVZNe7YEb1Xkxa+OHjgkgikWootdoNRV0h84vCHJ8E7SUAmxci
 uf4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773154433; x=1773759233; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z94pQJHhqAsbNWlTjCSoPpfMMuvEr86vdQmfbAcRKnA=;
 b=zxKugYCglZvT7gxByVv7di7deXangzfCpVS7gFMrvpjoeZ6xjWItyB8dUwu0DH8T/Z
 5Q88cHJPFOyJEMQkUT0XnYF7LQejYHcqlCfPebXklrqVtJd67PpR4jWiEtrtN8aEJsh5
 S4nkC0GibzumtR4ABgq9Q5wmyHyaqZpfnAyfHXmA/+ykDzzMJoh+zMP5QvAV3/MeBE4d
 I2lcxAllL7yKlMxvTG1Kg9tfSkP2jR0PDWFr51inNg0FHP1Kny3sUX+fw61HWWOHsxsj
 YPtYtU7wD3aZT8Faixax8ntobeyj7bp7x7SmYeBzR7ruwrFj1QmEy7aWVMi40epUY2Kt
 AKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773154433; x=1773759233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z94pQJHhqAsbNWlTjCSoPpfMMuvEr86vdQmfbAcRKnA=;
 b=Gf+1t63BvZziYWwuLibfgenv2ReOdY9qkNqeDxkGY+6ZtAaioKL6FEimhCinZtgPIZ
 QBPe5assFGBpV1Js3iV/uiYBIDwrYCXGjWnqoAdZA/dEt4QlOxuN63CUJvo/ZuEWz8HY
 DJhvtqCOMPI52F0sneX0vWmjXO4TP1kbt3U21Dwf2cCSuj3Cz24YN7cKYmHDkRhK2lBV
 2bKr7SRaliAN7MOf8RbU0AIiZPHDE/P7rZp4mcrSFHcVVPydDtMERGRTbgfATGLh8iOn
 LY6i6yhMW5+P0qNnl+2HCgS5L9f8n5BLieBejxDJwdRKmHP6wDaQOCmekR/+8ghaHxCC
 xfjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYF8kPC+OySfKjfbdI4dsYBDr/oAa5TR0tq60/38ozkYe85d/sZhHTIjwM4kQgYQN7Kcq8VHfeOm3P@nongnu.org
X-Gm-Message-State: AOJu0YwK8irid2RwlQChUDV9hzdwBcpabF0gFzGznkXlH/OmXFo+iN26
 8R1cZdO4UcDtI98v8s02tuRpuriRjD0KaCkE8hTRETsTt1s3fWMaMtYwZ24TAXVspmMfB59wNO7
 esOaPC8Wb2o1WaZW6OKc8kLM1vnB0lFyWwX+akEhLc6FUFwfY0fZq
X-Gm-Gg: ATEYQzyq1vbmayRhX5qrNWZeN+JuIj+aluogE5PWmhJZs3XvkgbPW0pZjNNfwjgPcCd
 x0xrhOv+IHaNgT8Tjr2/HsO+zRXq1JXOJAy5ZrGLBkjTTE//0hW6YUrfZ97q1uiDq6tdizK18/N
 D8YnCwa4JdjSMPolrvwPZ4RuQcX11Wgp67bkbgMiNw2MHXeCtlkAj9O1Of/Y+tchPhAG4mogSdR
 W4rL4n0QbsPiOGFMaipx3NxruuM2AThlCcrNyQNHkE29pEmkasXB99yT9B9awLIoeys7ERsBXEO
 a+n0xI2tyl1AkEux6TBMSRVUhw7tvL2Ib28f9XwplFuvZrfSacKFvMHIsDobdvflBMY=
X-Received: by 2002:a53:85c5:0:b0:64c:aab3:43eb with SMTP id
 956f58d0204a3-64d14200c84mr10649761d50.40.1773154433167; Tue, 10 Mar 2026
 07:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260309155219.62400-1-philmd@linaro.org>
 <20260309155219.62400-28-philmd@linaro.org>
 <87h5qn23v5.fsf@suse.de>
In-Reply-To: <87h5qn23v5.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 14:53:41 +0000
X-Gm-Features: AaiRm51nkBpTav3gVEkBPzM8EyyMXB2geGmPCghGLxHtTM9Jrlc3RwwTBLiZDts
Message-ID: <CAFEAcA8DpJno_LRrxyjMxDx5gqH_m_PNeqtZxnkg9mZ_QwbzFg@mail.gmail.com>
Subject: Re: [PULL 27/49] meson: Add -Wformat-overflow=2
To: Fabiano Rosas <farosas@suse.de>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Tue, 10 Mar 2026 at 13:47, Fabiano Rosas <farosas@suse.de> wrote:
> ../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_output_pin=
s=E2=80=99:
> ../tests/qtest/ast2700-sgpio-test.c:27:33: error: =E2=80=98sprintf=E2=80=
=99 may write a
> terminating nul past the end of the destination
> [-Werror=3Dformat-overflow=3D]
>
> ../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_irq_level_=
high=E2=80=99:
> ../tests/qtest/ast2700-sgpio-test.c:85:33: error: =E2=80=98sprintf=E2=80=
=99 may write a
> terminating nul past the end of the destination
> [-Werror=3Dformat-overflow=3D]
>
> ../tests/qtest/arm-cpu-features.c: In function =E2=80=98test_query_cpu_mo=
del_expansion_kvm=E2=80=99:
> ../tests/qtest/arm-cpu-features.c:578:35: error: =E2=80=98%u=E2=80=99 dir=
ective writing
> between 1 and 10 bytes into a region of size 5
> [-Werror=3Dformat-overflow=3D]
>
> ../configure
> --target-list=3Dx86_64-softmmu,i386-softmmu,aarch64-softmmu,arm-softmmu,p=
pc64-softmmu,s390x-softmmu,riscv64-softmmu,aarch64-linux-user,loongarch64-s=
oftmmu
> --disable-plugins --enable-modules --enable-werror
> --enable-trace-backends=3Dlog,dtrace --enable-debug --enable-docs
> --enable-rust --enable-strict-rust-lints

Could you do a configure with all targets enabled and a make with
"-k" so we can check that these are all the source files your gcc
complains about, please?

thanks
-- PMM

