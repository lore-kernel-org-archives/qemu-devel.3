Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38FCCD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slWYM-0006xx-SW; Tue, 03 Sep 2024 12:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slWYI-0006np-Lc
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:38:46 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slWYF-00078X-QT
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:38:45 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-374c326c638so2088751f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725381521; x=1725986321; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmHYRpE5cDo3krpudjkkf6vZQqE/rCgFPn3mx8tfzDU=;
 b=xpJO9DjI4EmQaGqIWvddyt+rct1oX19PjHUMVYIFc0xozOR/iFh+6xL2rsxeg24xvw
 b4rYp+ZCR0svXSETkvn/LNZkan+ot4BFaQ23np1MgWnteUMIiFbOOAnLZySloLmFoZUv
 S/dQ8y6X8Hj0LYxFs60sMLp2Y1+Lcx2+FAIm2NtTANRrpF75OySgMGa8+UlcN5EoiiUw
 JRo84qt6bkX6bRO0lIldEZZoDYO5OZNMM4+QSuDxK6hYss5J/ftts+kOdfQbF7xO5ac5
 FDMdRCOtXJay+csi0HJDBa2WvUuZU6BKS2T8RMNxX774eFLfg6AnT33+DckKNyBnERTL
 AOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725381521; x=1725986321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmHYRpE5cDo3krpudjkkf6vZQqE/rCgFPn3mx8tfzDU=;
 b=nphcZpISl7FGxu4FTnFrn3wVoQaz0Xg1E2xbzWlEeek+AI3DXhArLfJqUnpzgJgzdM
 pNUnD3szJl71JpWGeMPVkt7PXliAk0Z2zRZoW+TFGpZN1EAGIBqak3vjX/jd9FNEV5Z0
 /wlDhwG4nBnTxnphgcF7c1lOV8t5MLacFDu2ByQvdFqT11CwZGa0cKgqKVHX0Lv1NFNJ
 9fkP94LQB4cDmtR3sMYXpZQOfm6M4T2cf33rGmsVRZYeQhttgmm5mo+y9O+zcKTXtTc7
 t12ShQ8G00PmblB5R7skX00cG1Z4qsryJWPeEYY3Jk0TdgfGhn0Z7UGz4dcr+I0Ju8yv
 cErA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPUKAtcLnm3+oVziObOL2uwFTVNTwuuCaSQALNwveETG1QYuCPZaa5HQ2gPA4mELFvyAu3h6Of9Jr7@nongnu.org
X-Gm-Message-State: AOJu0YxTdRUm56td2wdRbaEWWuH0gz5BKuU5eNyTJG/HxsrgD48cSs0u
 L9fCVy2zfZrUTFLEKrgwga8XdGXKwo5ZSD2Te7LUmXUdhy6IjdxmS97H8kHDcnWPavpWqbYLDvv
 vJeA8fjUR3Xbd7/ptFFtWnrk2bb+HOZrh4VcnkgyY6VLQwtZn
X-Google-Smtp-Source: AGHT+IF3BF9QHCe2FGpvMy9kS2sZ/MdtTVp3Bu3rX0/EPDezBMLIcfGdmfWOBbjuv/RyPq96HoXbOTvY3HEPipNsrXs=
X-Received: by 2002:a5d:4f08:0:b0:371:7e73:eb43 with SMTP id
 ffacd0b85a97d-374bf1c9498mr7075937f8f.42.1725381521357; Tue, 03 Sep 2024
 09:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240903133940.3447430-1-changbin.du@huawei.com>
 <cceb62dd-742c-471b-8b4c-6bfc304d4565@linaro.org>
In-Reply-To: <cceb62dd-742c-471b-8b4c-6bfc304d4565@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2024 17:38:30 +0100
Message-ID: <CAFEAcA-7FjL0SZzJsJ6WZ-Cccx8W2711_CrkNpknrJgYtJx=iQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/arm/boot: Report error msg if loading elf/dtb failed
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Changbin Du <changbin.du@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 3 Sept 2024 at 14:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 3/9/24 15:39, Changbin Du wrote:
> > Print errors before exit. Do not exit silently.
> >
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> >
> > ---
> > v3: use load_elf_strerror() to format errno.
> > v2: remove msg for arm_load_dtb.
> > ---
> >   hw/arm/boot.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> > index d480a7da02cf..6c895e05cbc0 100644
> > --- a/hw/arm/boot.c
> > +++ b/hw/arm/boot.c
> > @@ -839,6 +839,8 @@ static ssize_t arm_load_elf(struct arm_boot_info *i=
nfo, uint64_t *pentry,
> >                         1, data_swab, as);
> >       if (ret <=3D 0) {
> >           /* The header loaded but the image didn't */
> > +        error_report("Couldn't load elf '%s': %s",
> > +                     info->kernel_filename, load_elf_strerror(ret));
> >           exit(1);
> >       }
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

