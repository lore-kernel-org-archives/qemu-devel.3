Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FE7C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzUe-0005nU-Ti; Mon, 19 May 2025 08:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzUb-0005kB-1G
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:21:17 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzUY-0005KY-Ga
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:21:16 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7053f85f059so35461727b3.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747657272; x=1748262072; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvdp8E10IQiP/aBRIJBldJS1n/rXEcr27fZoSCiJULI=;
 b=tOswSj8GJAA07q4eLXcFvQDeWnYzvdjM9Nzsh2WbaGX3b9iCGOmzn/kYQ+hkKpyAwL
 vBUP8btoYuZCH47vur1Fs5hwmepBrVxgime/8E7thCKsEoZlaejpAY1kmTbOqv6Ik1j/
 Kh4aPHF3Q9O/y2dVT57DcwxvYo97d57YSi6gyfHFqpwC86Qy/LHhDIema6wkvhOhUXix
 P0ixAYa3F2zQ0sb9/6zHjYo2upA9xc+1cvKW9xbShUc5pcrMhrZzywgj1dn1nPjvfF9X
 3rXjuxy84kl6uZIw1AqeJis/OKXADvarcnr3RWmyhRmaBDOcOGf/kzWV+UgY9TU2eAtz
 Gaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747657272; x=1748262072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvdp8E10IQiP/aBRIJBldJS1n/rXEcr27fZoSCiJULI=;
 b=xTOSpvk42lsPcFiF05pTJw3sOWtKQA5nTbMmHDQahlICGzqfpTaxw8tC1oVDO5uB2a
 B/KGaFA0COvTxULA5ad/r9NPpbrDCd1XWtcwfSG2WobW7NRopPAQXNYdjVLiFksAFyAF
 +wXk6qbmZhHxUqqZFrjzDm8pgrZjJr4j35dNsmqCEd/gClGY1i+RxypOLJ+LpB+zrRTQ
 QaF00MaSkLhQ8yBVyZloytCX5GsaJ47iO+lUjXoW4kyzR7XWhoKthZKmAlAtNu8R2roi
 cHGPuyyrLPV3PVUh3l64g28zN7i41qHtW1g0WTaVBGwgys+vyGzSpV0O3mJDIAzBd9tA
 hEgw==
X-Gm-Message-State: AOJu0YyxhVio9TFAYoGZak8VxBFaP+u0JEiRLvnQCiqGz80Jmx8OHH8E
 pKXhzqZB9D7fsrS1cXE1NOlaqwl7x+d7KNN1sP0vkFe5vV/8xa5jdB/4kQNLSP/iFAk6nGKVNZI
 0mP2YhIjQeV7bZNZCHP3rPdSp5CcOTJbe3oO4p5xDwg==
X-Gm-Gg: ASbGnctuQ2TfuBwelz4oBY/KT6KHVktGQ3sObkkK6EOtnkOtRw04EG+z2MY5B8TALPI
 CA0Njn0eDjy9PzpBPcIfxaNGcOZQY/BEAxSSnqCgKIIhgbGb7t0M6RU5dRX46QecyHzws7ONQpk
 scHjtN1/on7Pni7mUlokuX+pyWE8CoPYGc8A==
X-Google-Smtp-Source: AGHT+IFzyke/dRGIuAAWI+62cn9Tf0mBayN9nLoJzpEBOVfhYagVA4qB6kuuCKiEzt9ozCqvoGAtlima7PocBY1gcrg=
X-Received: by 2002:a05:690c:f8c:b0:708:c91b:4ae0 with SMTP id
 00721157ae682-70ca79f1ee4mr206953237b3.16.1747657271803; Mon, 19 May 2025
 05:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-8-berrange@redhat.com>
In-Reply-To: <20250515135936.86760-8-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 13:21:00 +0100
X-Gm-Features: AX0GCFvY7YWKe1E-8CxxeR7luO_Fsi3ZLcVPpe_DEBmL1TQ9ppLpNO4SVJ-o5a8
Message-ID: <CAFEAcA9Wt9wDf3Xt1+V2bZ36Ud7z7fXzhku=xUn3fnvftWE2hA@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] scripts/checkpatch: use new hook for MAINTAINERS
 update check
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 15 May 2025 at 15:00, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> When seeing a new/deleted/renamed file we check to see if MAINTAINERS
> is updated, but we don't give the user a list of files affected, as
> we don't want to repeat the same warning many times over.
>
> Using the new file list hook, we can give a single warning at the
> end with a list of filenames included.
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

