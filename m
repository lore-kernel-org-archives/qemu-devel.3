Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F7110F284D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AXO-0005Rz-2y; Fri, 27 Mar 2026 12:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6AXL-0005RZ-8l
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:59:55 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6AXJ-000748-NK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:59:55 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64e8ae85700so2601550d50.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774630792; cv=none;
 d=google.com; s=arc-20240605;
 b=bs5N7CVElZlRJ8e/1kNFE7bVQQXEduFjOtLyc3qwBT8Kqw88eOfWh9I+8f04ycysGC
 hlictkcw2TwUEbyGjokNjfW8Is3PPC0uTHEquQOPshYhPGUk5SZSsuvEbz0tBiOVZe4M
 N1NVbQpTkvUtPdqTFoinwCdNTyKjpQYPO51KX2voYr2dIHfr+XVdtezeK877PTGTp6VC
 owkCIAONDJzd8q+cU8WDwkrs6GMBaW599au+yrt12NgJZu84cN57/Cx5P2rLuhmN8hkm
 zol0bibhvhkJNLliui3fUFiuiODuTznoYaufYmy6y/R6rNO3DG/chYbAKBeOSqNCnnyI
 CvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=riTbA31r3tXJJKrgG4WTjXlWs34t6fRrVnYqEfVWbrE=;
 fh=VCw0zYq36+ImszfhkRQ5b/3r7rdKhLLzDU6AyHknI5w=;
 b=Rvt9dq17uVAo5fcG2tRM+h9dt1/T+ASvtqZcaAWfLnuzSKhh2uYTK6jfihDHdS8KP3
 ESCQNAaNKJd9CXAxr70p0rUD6J17lm1B31H4VXdaVecVENRJwrATCB5K6TiR4+awQq5r
 FHz4sdKMr6IzdHl92SWjqoa0ESNk/GCUXCW1aoc+jIR5A1B8pxps8tAg1qNCwLjS63YV
 Jp1Px9uL3fEi0dwe/0q1ubQLI1aDCZ5IZ3hgy0NH/U4QLl+1TZOgOr1ND/01stOS5gPT
 IZRDowSOZp0fggTjqDLC9JF1hl6V1/1eb5NbXsXk1iYdWC8Wb2gAfMok4Wh67N88B4UM
 c4UQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630792; x=1775235592; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riTbA31r3tXJJKrgG4WTjXlWs34t6fRrVnYqEfVWbrE=;
 b=WD0YWl1p2ICfw3jr7u/T3SCQGOLz3Z9WIKtifsA0Z2IOzoLtL60OEcHcUuALxFfnJI
 GmxBEdOB/wQGNP+hCSgwvtPCoAlucbvlJnBPNfCpmdYEsxnRt4zOeZrTQTwBdiNf/udU
 weeG2jQtcINtqiuQ5IbRaWacQbrO/DHZBAWlSuJi/bg0+6pNJqRXTU8qMiabm0WOyt8n
 iKSs/iOhEK5PZC3zE3JttrFuxwVI3J45sHbO2NHKbB87KqDyGGWgDYMzOTCvmkFVbtAA
 DaQmfxDdN1TjYvSdA4hMyBoX8RW7oHjbZu/nAhLD6cQQE0BZEFskUQFSxEsBM1mXxGa/
 ckkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630792; x=1775235592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=riTbA31r3tXJJKrgG4WTjXlWs34t6fRrVnYqEfVWbrE=;
 b=kaqUxEer6+VPJ16BEfyvTig2MsJsXDpZV5cYj+C03XJTUGd2/BrKUfH7kIrGaE4w9z
 XJSdBZGenKxTZcnqsKUlvt/3emjA9CthlxKuoRIuxYgejAJ4ggxH8PiNudwPxdMLK9Dr
 GedOsCk2DrzqbaPpvDuDgDOx8+3iKmJhZeTyhXqHY6HTazRiZdbqssM1CVlpnPkSfBxF
 7QjgbXqCmFDtg+XIxGHwoJPQCM2DyCrqXRyh1tkfGR04vmpgWA01UbGtb26q2tLxd3AI
 jMQ6CnpfwDMTF1TSXUJl2Zy6YhJ/uyir1mMFBICFDp4uZYk2izJK6ugWj5HQGimWuoTp
 gX0Q==
X-Gm-Message-State: AOJu0YzqTgXab2viqIY0D/IqdNu5NH5ttN1ySNwttkHnMa4pDVDnZ/uY
 5KQM4CtW6TXavHL7eFQq8M15/oM5zZLntpRmzzz0XvTN0emtV0xSk/dG3mjoy1blXf9/JXo3bku
 twR5WHd66zpKbHzblBAHFQDadyMrs7Q8LMKG7dJvRvre6wHwDTa48kIg=
X-Gm-Gg: ATEYQzz4rgHIO5oIWM7HIfK9XmnrGw1OlZk9UpNH4YTYO9KYdI8hWX3mdWpsNTNkUq1
 8YhErOu1qT3yk1bLSpy195upPXfjwYDmh87JyKFwYVNDjJGtJ3Vw5qbT/r8B6YiV1Q2X6Z7PxSk
 v4Ty7vUtLdOEjsPXnmuRZBwYbARdytJb5t67NHzN/6nffG9AP8E5H6fNj8+8294J2jW17ggUv5X
 PyB22WZUFLzFcGXG3B62vOqnrXcG7M1DnxPRIkZnIC3gqE2pUAHmM4S8i+XGUrDulheR5bFu4CD
 Tdt88XmU+CY2KmoiNtFeYPPAedLeahMDvas/khUkNiHCv2I0vQGJQYx4EQ1OTDFUSf0=
X-Received: by 2002:a05:690e:43d6:b0:64e:e90c:5692 with SMTP id
 956f58d0204a3-64ff73f6ae8mr2741095d50.60.1774630791911; Fri, 27 Mar 2026
 09:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260324193530.375628-1-peter.maydell@linaro.org>
 <2395a353-36a9-49ba-bb0c-824f308cc90d@linaro.org>
In-Reply-To: <2395a353-36a9-49ba-bb0c-824f308cc90d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 16:59:39 +0000
X-Gm-Features: AQROBzCN7MvFhRN4JPpgwYgSo2mz_JTOE2aqwPLki4NYHdxl4CKqGYj71p-qcII
Message-ID: <CAFEAcA8fNj+gAvkqPucDs85FgZ0EORXLcrY9YwM--dLO0UsB6w@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rocker: Avoid double-free of l2_flood.group_ids
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jiri Pirko <jiri@resnulli.us>, 
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Wed, 25 Mar 2026 at 10:00, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 24/3/26 20:35, Peter Maydell wrote:
> > In of_dpa_cmd_add_l2_flood(), we allocate memory for the
> > group->l2_flood.group_ids array, freeing any previous array.
> > However, in the error-exit path we free the group_ids memory but do
> > not clear the pointer to NULL.  This means that if the guest causes
> > us to take the error-exit path and then later call the function
> > again, we will try again to free the memory we already freed.
> >
> > Fix this by clearing the group_ids pointer in the error exit
> > path, so we maintain the invariant of "either it points at
> > allocated memory, or it is NULL" (both being valid to g_free()).
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: dc488f88806 ("rocker: add new rocker switch device")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3253
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/net/rocker/rocker_of_dpa.c | 1 +
> >   1 file changed, 1 insertion(+)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks; I'll take this via target-arm.next unless anybody
objects, as I'm planning a pullreq for the next rc anyway.

-- PMM

