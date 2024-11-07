Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E3FD43349
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 11:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t90OC-0004JB-J2; Thu, 07 Nov 2024 06:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t90OA-0004Dm-AH
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:09:22 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t90O8-0002QE-Ho
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:09:22 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so1095946a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 03:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730977758; x=1731582558; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GalgV6GSghPHiaAAPPVK1Ya0Hq9G3gyMbmRR5kUgZhY=;
 b=PTL6hx7UrbfM0rXeft9HVjD63nZ0wQ6f9hPY0WNbVUXfC50AVyeGsuS7KOGOxOM8Tx
 ET5njuHV20voiXrXHNJg/cESrWlYrDCkfMx8o35uRyb1L88lvM3uS9V+YlwZamEQKOH6
 060XWpcSVjwjElZ9z2B9KPv3dSBAPulUobITCjeG5A3YqzNZ+uG7QzTY5au3Q56toE2G
 rmMHm2igM9l4t8BuUCL97cGO56UT6tb3ds53Q34xTlI/SAgstTlzKazTBi+EDCtNausg
 5p8LwZTr5eFWoObk//ONTnCS2BSXPIXzBi8L/6CcgsvElE6CK1d76XmAnAVl9MXrSZdA
 F+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730977758; x=1731582558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GalgV6GSghPHiaAAPPVK1Ya0Hq9G3gyMbmRR5kUgZhY=;
 b=ihpvw426rxzoYf/5Yc1F+Kpzbs1vPNFuh3wX+1tPjjI+7Tx764sOPAGmKAHkHqvpuq
 2GgzoEMi2jIAYjNyIojFvproF4E7A7rAVAFqzddbxMx5PzaB2LoYsORvEHhWFCd6uMKP
 rr4rEOGsLcIND14kDNCWbowBV1EU20EXapoknKGWSHdJl0qepCXRw7bij95UH/koocXK
 F13RUnvkniM2gozAqFjsdaCzfr4ajw58C1MoVU8jUT+wir3n1QZfjto55jbbFalH+qI1
 g7uOzHKq83pBwAaFF/YDEOz1B20Mjdrs1JKF7F1pOnay6ZWfgs9uNDYgHilP4J80SXOu
 EGtQ==
X-Gm-Message-State: AOJu0YxCvE2Mmdne1M/wc8hMgJ7+tyuBv58irx+Xvqlupv44xJ0z83NY
 Q7sM3g+sF89Vwfe1zCBRF2q8N2mN4YnvNo9k3Pym5K/UhSLyV0I5QZNLETOfiwI2tuFYp3X7iiw
 3La+Dt+hOWakWgY0Mwyf7kT/VSW+S7vojMjvIHA==
X-Google-Smtp-Source: AGHT+IGJtgJS3KvdD5o8OFsDiwCdCiwWpYCG++XkwgN14IvWvJ1341ynBBm0gLkQG32zE1sjCf6mCsKGjGZt6cBaG2E=
X-Received: by 2002:a05:6402:42ce:b0:5c8:9f81:43e4 with SMTP id
 4fb4d7f45d1cf-5cbbf8891b1mr32120742a12.7.1730977758143; Thu, 07 Nov 2024
 03:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20241106180751.6859-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20241106180751.6859-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 11:09:07 +0000
Message-ID: <CAFEAcA8P-a5XyACAovFLwCSPT-s0CX74aMKoPtHku0G89cYgkA@mail.gmail.com>
Subject: Re: [PATCH] tests: Adjust path for swtpm state to use path under
 /var/tmp/
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, clg@redhat.com, 
 lena.voytek@canonical.com, Stefan Berger <stefanb@linux.ibm.com>
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

On Wed, 6 Nov 2024 at 18:08, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> To avoid AppArmor-related test failures when functional test are run from
> somewhere under /mnt, adjust the path to swtpm's state to use an AppArmor-
> supported path, such as /var/tmp, which is provided by the python function
> tempfile.TemporaryDirectory().
>
> An update to swtpm's AppArmor profile is also being done to support /var/tmp.
>
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com/
> Link: https://github.com/stefanberger/swtpm/pull/944
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks for writing this patch. I can confirm that the test now
runs OK on my Ubuntu setup, so

Tested-by: Peter Maydell <peter.maydell@linaro.org>

> ---
>  tests/functional/test_arm_aspeed.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
> index 9761fc06a4..a574b1e521 100644
> --- a/tests/functional/test_arm_aspeed.py
> +++ b/tests/functional/test_arm_aspeed.py
> @@ -227,11 +227,11 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
>
>          image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
>
> -        socket_dir = tempfile.TemporaryDirectory(prefix="qemu_")
> -        socket = os.path.join(socket_dir.name, 'swtpm-socket')

I think it would be helpful to add a brief comment here:
           # We must put the TPM state dir in /tmp/, not the build dir,
           # because some distros use AppArmor to lock down swtpm and
           # restrict the set of locations it can write to.

just as a guard against somebody in future coming along and
trying to clean up/rationalize where tests are creating their
temporary files.

> +        tpmstate_dir = tempfile.TemporaryDirectory(prefix="qemu_")
> +        socket = os.path.join(tpmstate_dir.name, 'swtpm-socket')
>
>          subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
> -                        '--tpmstate', f'dir={self.vm.temp_dir}',
> +                        '--tpmstate', f'dir={tpmstate_dir.name}',
>                          '--ctrl', f'type=unixio,path={socket}'])
>
>          self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
> --
> 2.34.1

thanks
-- PMM

