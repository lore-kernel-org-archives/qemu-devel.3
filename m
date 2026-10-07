Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C2FCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOMq-0003ES-9l; Wed, 07 Oct 2026 05:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xEOIL-0004E1-68
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:50:41 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xEOIJ-0001gD-NO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:50:40 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8acda240937so15797207b3.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791366638; cv=none;
 d=google.com; s=arc-20260327;
 b=TXzfbyaCov1v1j4oRDFldSr2J2OkpZpRVrcfbRcqJAes93YsiyCwGGSjqz/HYMpGFw
 BhldVKODWVY+wk15vRJ6L8GqAD09OB6Fm5WE4ss7sMGuGE4vgzeDX/bFruENQXiF4S+s
 pt3MK84J/J/a4XwgHI0WpwA/DvBDlzeIoFEYyxiUTzJVx4VUunl4mX+7MkTn+EIKDY47
 /RtHEo40zpfSpF5VEw4KZ1eyI5XXWPV/+nWsRH9wgk5SwrPLF12bX85q5UB1ipLgz2EV
 7WDIXHiuiB8cLvBlBiMkNIysMQDfI7hHJRpPUfIWjjhshBJCyvnYVnXnQoF2XgcAlXKA
 /fcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OP8HOU/Jxuc6BI5HRZH3ttlhe6t9yJpzW5VfaWtyPHE=;
 fh=Lig8H/jH2baTm+GszLnPsKx2URAzEOqJCEaRQ6iUluU=;
 b=QxRpzwII/frimZa3Vt63cBS3damusjmJhGspYk9uLjSKYnrqzac6CCZDNTjuSxglU2
 sbDaNvHZ+FfQi3CpNLCMDaZKt3YXqYfrt8tEb7j/0p/kfKw57VAJnE+Up0+tZFCf3+CL
 +sxYkl95i6qOcIYIMT6saC/yNcs45M40A2qT0RJWQFi8qYHdS4qEQpKRrtminJM6ezSg
 0Fu4CgKdUOp3l0Q6fUCYIJ9Bkt6onRCGNlECj6f3E7X/B8+DAT0eFJtCO0gr+FcCyi84
 2ezYgM3BkqLYMk4iQbIX5MVruQz2jQWZzAZHafvkSDfcBOJb6FjY/wXgPeV1SPo3mUAC
 2aEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791366638; x=1791971438; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OP8HOU/Jxuc6BI5HRZH3ttlhe6t9yJpzW5VfaWtyPHE=;
 b=qde77bDPHLqj40uKbdPbEjOj8F0x8yAdB7NJmJJNtpRce2MfXqn98oozgxHhjqNdjm
 HKGxEIHl30tfQuG0yBoOS65MnUWcGOWMiZH6RupIJ8CQdVqFP/nyrerCUqJTUov2T8IU
 OUManR392UnZ6D2XAP81Hj+8bTnt47V3Qii9SW9u2CEtq2b6ZhmG5v1Sm0ZGkeppur2g
 21MOuVCa5gswPV9JyI7jpjHj5T6PQt7qKc3bopOpTKoWBqDWR5NypfV/9TzHRrlSLANI
 GnEOdPCdg74z4P0w87sNjOPbuP30zEmEJiSgHFGtcz91NhcZMZqHcQhZuWuxouJ305or
 Fddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366638; x=1791971438;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OP8HOU/Jxuc6BI5HRZH3ttlhe6t9yJpzW5VfaWtyPHE=;
 b=u+wjPKtwha+DPRFl/2gcj+7kXF5dzqxY+AtEq7jiZTKLcWfD92E3ZkPM48/9kNVFiU
 MoJ4tSFr5SIWQ3Pm/Mfb3cQ8nJPhFz+ItX+894EAyyJhwIbcmaFnU7vXvb9kzwgmxtlC
 qiNvh7E02bL4uLu9HKECk0Zn8QQIwtaaReMKpuLRA3WP2doYca6pHVnyEM+7S0RAc8vf
 w0+9U2z84kbzeA5vjsbbp7QxICNhfX61oiSgvC0m04wOgHQ434GXBLHi98wLfGpx9xOD
 aHhhEQvY237d18DCAiKlHk/HBm6DtU9L8frscYeA9YJU+KF9Nn+oHCRNcC+5L0nBzOvd
 BtRQ==
X-Gm-Message-State: AFuF++lhMoN9V+JUjxB0FIxFICM0tFmdVyrvB0vXasoqzxGWUrXCqVWs
 6Xh/jTKaceiC4Drebc/Sh1jnVNni+t/iR0yETm3lVyoU6bqxMvkJKaUZdhSw+J8/TYhn1f+/arh
 KldtiCwhtemwMn5yEOCpFbKdjSbl4vJQ=
X-Gm-Gg: AYBFou3iI9jug1LYQQlbXorzLal6/BmjaKr959AXVcD1tygDDqTLj3XFmf/1CpvJIU4
 3/FpF0k3xQz3Xh4COyTfNWJmGbrrf/JA6FDyeJexC9yp43Og6NKve4K0IJ+ANuNQILIpjDkgG6s
 EYaE2EQ5+Ql2TmK5hLI9kyiG3OhOQt3Mvhzbhi2iivqE3hLHpq00brkpDTp7rJTpehnj5i9d4Eq
 V70ZbafKjFRW/0ANeWojhCqmIJkoqHaG3etoQoQLI6nPRpQ3QLrDWfZLDJxcLAqNImx9rRdFiAI
 oDjK8mCSYLUO+mtMm3ZVxUX75WpcGXH/AoYzZQmT7RK5rs7PI735dNdxNXpcko4UVqZnzZOgdVc
 JowzTznOb+NjZatDL
X-Received: by 2002:a05:690c:4142:b0:8ae:a5b5:e97a with SMTP id
 00721157ae682-8b05ae826e1mr9528207b3.13.1791366638004; Wed, 07 Oct 2026
 02:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20261006083445.30362-1-shentey@gmail.com>
 <20261006083445.30362-5-shentey@gmail.com>
In-Reply-To: <20261006083445.30362-5-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 7 Oct 2026 17:50:27 +0800
X-Gm-Features: AclHuK-pfVeL7Bv97IeM7Mpg2Anw3T7OhhimCeHiHQkadRh967HvhBZfGvHudFg
Message-ID: <CAEUhbmWXkjHFFz5kC6arkRdmPwyREknZC=HgmyBPb1HRcCoCEQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/31] hw/watchdog/wdt_imx2: Remove redundant attributes
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org, 
 Jason Wang <jasowangio@gmail.com>, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Oct 7, 2026 at 5:03=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Since WDT and WDE are write one once bits, their values always
> correspond with their respective locked attributes. Thus, the attributes
> are redundant. Take advantage of this observation to simplify the code.
>
> Note that removing the attributes changes the vmstate structure which
> constitutes a migration break. This is allowed since QEMU does not
> guarantee migration compatibility for i.MX devices between feature
> releases.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/watchdog/wdt_imx2.h |  2 --
>  hw/watchdog/wdt_imx2.c         | 20 ++++----------------
>  2 files changed, 4 insertions(+), 18 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

