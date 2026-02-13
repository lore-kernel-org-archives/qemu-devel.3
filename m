Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45BEEDF166
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqtth-0007Zm-Uc; Fri, 13 Feb 2026 09:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqttf-0007Zd-RB
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:11:51 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqtte-0000BB-88
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:11:51 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-794fe698e36so9962897b3.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 06:11:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770991909; cv=none;
 d=google.com; s=arc-20240605;
 b=TI4e52KiXgVEJr5tiSl7HMZS6sS38XPRBapDkoCbm2xNHZI+fjShGprbFPfgxXiUet
 RnGnF0FWolihcg11pRYvMGNVPHFsbSsTFzHhEeZqfJ6QX8BmRnrWGojx8+UthD3wHzgb
 0Mlm28d/QH/4S9OX3vY0JE9R1stPYMSgRocDmyqLK9q7+lM5KksBDDUeApBWkCFbXiMy
 ibTYr3d3EQyx5nsA8mnFlDbSEp39DMj+jQD3TupPiqzOANXszuZd4uBJvwaokCOvGCsw
 3RRWSNvaQOy8OiWVESV8SVhg9kcifiG+2VhBDJ7kVmHSuTo1laVIJ/jxtcMWFeeUNb2Y
 jOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E+Hcp7SIum9H3zzUJZsKPurFW4IHGWWeOhHlNm8iPEE=;
 fh=01aamc+uN6dUjC6VROdYF5g2Rg9EITyKiLP7WL/eO9E=;
 b=PY3v7YexKMBsaiEXpLUEtUtneWVkDc24BFl3QOTtK9eUCsMGZOgu7tO2oT5MczR119
 VxLfX74lwINAYUHFQFOGYXaVQ/36jDFTdrT9Jf+5ufENp4iyBznuBovYC10H/meZiuxc
 doiXsNUBdTDP4bDxeEcqq/F6ppiIwInxWr+Vb3AV0fZer3tLm9oWgcZs5T0ds+xnw/nD
 uK/mf+jt8HNV7duhZQbNlBqAP0RFNajbKIadX1Zx3V103uhAIpWP9vYoqDXJ01pAW0lA
 rirpL+rnLKEn6mf0u6iNGe9uVC00lPvZYRhWdob+ttDLNkN+Bcnzn67cT+7yZ2iGgIo5
 3/fg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770991909; x=1771596709; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+Hcp7SIum9H3zzUJZsKPurFW4IHGWWeOhHlNm8iPEE=;
 b=O5W0McsEe/dSgvoAonmoOHjUJMrpdfTt9VEO4zNsjBycSogw4Xq4zcgGLRed0jqMbt
 A30yco86mj/JqraIQl2PYc/HHLXmb4AHOZAlvjUcQa9k/odi8NtidGOiIbVm6b0ZAJb6
 +s9EmCC6NabIpBYRpaVSI8O1uQzy8Tg1Qoa8U2rT19JBTVhm+43Xhtbm3m8oFbWz/X43
 1xFeT+VNB8DWKZy5Vmqq51ayf2VtcloLDRe3d26WJEyRpy4AIVcHkq4Gvc+OaSuX8hgZ
 dQb3HqxE1kXlvwmnyFfEB1MbBz/MH+ngDOAnfu6hdWmQQ48wFI4ex5W18VpH7dv//aOm
 YXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770991909; x=1771596709;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E+Hcp7SIum9H3zzUJZsKPurFW4IHGWWeOhHlNm8iPEE=;
 b=b9YF96zzyLf0egzd1lduHyOZtCRlyAzWAHctXTcg2/JVg3hvit0mDorqkp+qEmQBBL
 xOiqeqC+NngpoiakUB9HG/WYNKJ5WiocpNhNkBBQR6ABfFm0Gt9vTo6VQBS3oVgBCfYu
 Ccoeq1UDyycbxyVx3WPqcpw1D4CwtMWiSnBI3/+fMhV0ZjuMHbU3NUT0dzASMEre9vHN
 Fgl7CoMINWnQzg7xCsFLuj6szSdnOqGQpSYtpxVHV+Z66rlAs5TkQHZajbYYs/ccwJ+F
 rzpVZm7zPAWK9CLNFTLy6DLRVN/OM1duTtVpFFjLbRlr14/6zg5vsFMzRRugujmT/opV
 toMw==
X-Gm-Message-State: AOJu0YwI0nnx+NTV1FjOjPhiKwsPUbmC7ZXmJt514xrnlAhPN/7/RPnl
 M2Oiq6ZFHyaI4ap70NUQn93SHLiqWUYFPbdzfXMSCPUUW9iT5wsWIFCQN5RlegjfOXadPjijMIk
 5dZVLs/PNiA5s6bzJJrEaME78QWPQMbQ7NODPiLvm4A==
X-Gm-Gg: AZuq6aLmU1UngRdtNHi58U2Vb93TZzSI+3iHWe5Pyp6+Szksls3LRyvU70m/WRMiDoO
 nkP85y27GoPGy84ktbmlg4vupJ/nQ6c+nbYeFlMBhWrpuuWRRFclfIiexffWqSiXpXlTZntxj0J
 kdlTzhbHoZzCwJE8Fy3iyzWqjFD7w6RL2goQc2f6UTAz42VBPg2GEoxWbPdy2QULifyU7D2gVDr
 iHLONfnXz1oycjQL6ZRU5PdFctzbLzIVtmgdcY4/33ucC5qMwe5HfoZOq8YSnT3lMLEKL2nSZXY
 RsnvVK7HU12c8d4iREkASonoMeRmW0A1d0zWZcpkSp6thsnf8qJNURJhakloHcQut4s=
X-Received: by 2002:a05:690e:bca:b0:649:b535:46ab with SMTP id
 956f58d0204a3-64c19b196fcmr1343989d50.49.1770991908901; Fri, 13 Feb 2026
 06:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20260213094938.4074478-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260213094938.4074478-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Feb 2026 14:11:37 +0000
X-Gm-Features: AZwV_QhTszuPHuF69gBdjMmghGZj0GECDjqjodvkLk8R7I407V4-YWO9HB7GAYo
Message-ID: <CAFEAcA9M4OvfOEnAaATuUQwFk3YthTUjPNFLo4izgd+vORHbFw@mail.gmail.com>
Subject: Re: [PULL v2 00/15] Char patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paul Durrant <paul@xen.org>, Anthony PERARD <anthony@xenproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 13 Feb 2026 at 09:50, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 4ed6a7f2fdc09d9fc3411e83e278da00851220=
16:
>
>   Merge tag 'pull-block-jobs-2026-02-12' of https://gitlab.com/vsementsov=
/qemu into staging (2026-02-12 14:35:18 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/char-pull-request
>
> for you to fetch changes up to 98ba0e479771a391137119264156e9661508bbc7:
>
>   baum: Add copy/paste bindings (2026-02-13 10:45:07 +0100)
>
> ----------------------------------------------------------------
> chardev patches



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

