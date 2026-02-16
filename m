Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8055E7BD91
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwXj-00046H-55; Mon, 16 Feb 2026 06:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vrwXf-00045o-D9
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:13:27 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vrwXd-0006jO-Tm
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:13:27 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ae2ce2fe1so2654497d50.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 03:13:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771240405; cv=none;
 d=google.com; s=arc-20240605;
 b=khkdLmHs8/Pdwof5MPJquKJiG0yr+3K372kO8mGEA4n6OE+cAzaU7Rws9ai7gygXCH
 bltz/2jcNkyiT6RyR5MzAYVESJrTmL1nmExXPihqXHvJxMyN7EY68arQ/bEogwXMjxMB
 a6dFf5kBu2hjadl9ogVUV1YwppK0KzPjRWsihFK3PhzdF5tfXDXPe6zFddlklQ7W7u/t
 +NAARq0tNzuQkqNYyo9v810/Pl5DLocxj+pFqnA3AkYrbSluKgzWykymN1u5fKdvhnMr
 ePItDBwL9C9YixI1k2YqScqX7915tYT6xACazMAE+aKK87YgMOj+GFuZWVwNl3L0jEXz
 mVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bnj6PYX9XX64sJHAlUbiGDSZBG2TAqZE+5aCucDPgzg=;
 fh=vvj2DZQY5LAdehuQPz0q2ks1wDBqfeLL9XHCMNWn8sw=;
 b=iHcUP7HW6bkY/+jsWhBQ6bHFCfinBpKo6SU3JPCFCxh9DPB5RuCPOfeVkfofMJxTcN
 Fbkf1lpgoa9kyyCmObc9At3YSEMksMirYh1HzctzaqfY01DUMBZcX9jk/LfMaPVM+Fe3
 4TNy+GfZKe9IW3fr7iThZcGTVztjwNI2vNIjHZfUnumoVAIUmbH+suzO6szmr1NkcFM9
 Xf9isk9dc58vDochCatq0uuXuHUnsAfguWvH9M7/etcYK0toLwZdLBnAOtEF3+1wHjrU
 TCEMS0Inizaa421tzE2n0Fj2tW2/H1unQ3UfwPz9jI6UaRxpNGb7zKpC0Uhsc5psQmkw
 7IFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771240405; x=1771845205; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bnj6PYX9XX64sJHAlUbiGDSZBG2TAqZE+5aCucDPgzg=;
 b=dXiIZQLUoBVxbYAUkzuueHQbsn9hFtMCoM0pDjkjKXe4aC/1uHXngVIyOPlg2VlIz0
 Qhp2XnpzXxgU1S9SaQ4vnOrCeNsGTGGww3UH17i7AZowrLyZywP94h5cbhAQoKq/VTkY
 NRYfWdqPq+T0BKFMYt1FNmthB6o0TZb53ZQILFLAhOC0o4Apwi5Rdu7SoA+XelccNJE3
 9TjOfavxM6RwEA1JVMOmzH9HXZdsRSQmDJ+h6qzV3jCBcKit4POryvkyAGVUVjIIdPcB
 aW9qMLqq3P6yz3V+NMiTFGrekV4F797/PCPW4Dv7CuRhwP55LBwLgaRSZFiqnAWSMCao
 1pUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771240405; x=1771845205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bnj6PYX9XX64sJHAlUbiGDSZBG2TAqZE+5aCucDPgzg=;
 b=FyHHYrVyx+ch3xbDDhZW9a0NOalsdLFQZm7CcocrJSH1sEII0JEEEeIaAnDLwTbsEx
 Wuj2q84vFfRPd6EExajtItX835gNwjZuOAu6malPFdcIslu/nJTINKZ2lSAtzlHfkCZc
 zGg1AxSwxy2k5GmWw2BCLr09QMo367aJB+gqBS0hipzFthxXDgukjlNdkBGqirzz8YZO
 E/JEiNlNqGEVwKpz59qGX112JxORxrjpaY6A34kzeXEFcFhzNZzZreBRNY817oNcy6x6
 xJMdSCA3eqE2+ACTss0Lj5FKrBhU1GyXzKx+VcyTeRXNCutt+eQ7dbh6tuAa6tQrYkbs
 aJ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp8icOOlkD3Q1qzdLN535WTOXMlP00DRgXt8sbqVJGaWFd3y201gs+ZMwAOo0uAnwuLLHLSIqOX8ZB@nongnu.org
X-Gm-Message-State: AOJu0YyEw34m1uU/HYHM4UW22fbC9v5HIFqjO8JaA38Irh0y6Lt/QFM2
 YyIxtRm1vu052wRKis42vdN9GJH/CQCleYDzv6O80dnqndbkO2jiwAjHudnihr/in7iNvgsVywm
 F6E/RpXmcRyN60L0XY8DqXCpsDb+tfLIX6NFlE0JpVQ==
X-Gm-Gg: AZuq6aIch855A4y5gj6jM5rw9dRh+0S5YHzEqvhLnbV+P9rar7H1cALg3/wG55ei0Hp
 QMz2Cog/Ev6l8JAf/Xp5IQ2kbOl9f7hcwPSXKTmTo0Vb1LCSmvwhH9SW0OGpstMUxJL4bZPg5FJ
 z4Zm5KSUOzBJm5Iw9zMQ3mk5yzMQE/keFBp7dhFo5KA6MM8TbDv2zW2yxq3y0GhX7W0fma2Hmf+
 CZlFjsOIqz73UCWEdfQWcFdJ994Tq9Rw/uEAT8P6Zwgndupv35Y5egImiXJDApjiYJ+f5NcG5Sn
 uFd9yNU/IeIgJtmWiBYYrbe49PpB3rWt3/W5vIueP6qAlfuX5sqNa9kErYLuMHB6Mz8=
X-Received: by 2002:a05:690e:408e:b0:645:54a9:11b6 with SMTP id
 956f58d0204a3-64c19b196f1mr7675589d50.52.1771240404710; Mon, 16 Feb 2026
 03:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20260212213955.2225662-1-clg@redhat.com>
 <20260212213955.2225662-3-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-3-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Feb 2026 11:13:12 +0000
X-Gm-Features: AZwV_Qi3cGskL0yyDjDTutpSoqbX2OXFxE3VeTo0RHl0QtnqdczfaLKUuGaj3u8
Message-ID: <CAFEAcA_oJgTc2SyRr11QTeTkmCPgvKiwngAaDiDNw5nUcTFA2w@mail.gmail.com>
Subject: Re: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Kane Chen <kane_chen@aspeedtech.com>
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

On Thu, 12 Feb 2026 at 21:42, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> Add functional tests for AST2500 and AST2600 machines using the
> OpenBMC SDK v11.00 with Linux kernel 5.15. These tests complement the
> existing SDK tests and verify that QEMU correctly boots older kernel
> versions on these platforms.


> +    ASSET_SDK_V1100_AST2600_515 =3D Asset(
> +        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11=
.00/ast2600-default-515-obmc.tar.gz',
> +        'ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f=
6')

This asset file is over a gigabyte in size, it takes forever to
download, and our functional test asset download framework has
no mechanism for giving any kind of progress indication for
downloads (or even for telling you the URL it is downloading
until after the download is complete).

Can we have a size limit for test assets please, at least until
the framework can support large assets a bit better ?

thanks
-- PMm

