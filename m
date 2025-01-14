Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F18E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 07:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXb4z-0002aE-P5; Tue, 14 Jan 2025 02:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tXb4x-0002ZW-5t; Tue, 14 Jan 2025 02:11:11 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tXb4v-0000zJ-Jd; Tue, 14 Jan 2025 02:11:10 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216426b0865so89611145ad.0; 
 Mon, 13 Jan 2025 23:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736838667; x=1737443467; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kJBxlBS8ne6FW5Ff0gXp4elTIzV7LjvU3SM3QIAPQQ=;
 b=dWgwRicp3nyH65ZIAPVpAmluJJFslAAOEwTA7YATImDUCpHcZICl55+DtrkY0+J+SO
 BooBPH5V4aJGtsxvMAXGHrmit6m8PDzn081ICTEulm5kYthHQoiLYhLmvwPHWgYA7nzl
 zBgOPPnhpZ5gqoTVW6AMQRADg0/w5+ShvejWvfwaySH86qV0jOb6nWH2QhfwvZQRL/62
 wvrozK1bIdrthM45aoiWP6i4tcv+4iLMhk4V/E0F+IScR1tldzELvdW3raebvlmNLc7r
 sV5XZUUs0u2UDwg4WCxsX+7wzM0GZF42khu+GuwoMl87Yox5Y731Xca6zwIDQ1eYzJFz
 i8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736838667; x=1737443467;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6kJBxlBS8ne6FW5Ff0gXp4elTIzV7LjvU3SM3QIAPQQ=;
 b=FHHoFBd6eAz3vecxt7NuxBdEZC+ry7dO3mIO0gk9Iys3bZHo/+zTGY9SRYI0LOGeR/
 +V3YE17x0COkJAWO1Dtc4hi8BJvI9KFGVKFs7ON0/fsPcsbqjwLrgwmbQyRDohHGn5fY
 bx9zdo7wl/+yVhDMvF9mw+D3rX/FBqoYJ0JCuAP1wdlZXGNO8kYY/mDtZBcI5u1Yyh+8
 pKpJEUuGzyzgcQQUvdca4GYDlA0Vnxl722Nh4cguAnMjDZOO5rR7uuxqb4KMxKeKKSTi
 0OO3us0JwNgruplpQtvVa2l5BAsoRqASxkfnv7S3qS/2Lvtd3pjJh4WmTUg6T9TBBxaM
 dGNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu6d2XBZsDMKOSqClA4YavSmQ4Yu7m6Jw3/OJbVXIbp29NZtXhx4fE7N1R+wHAf4tbcr1zqCXyYY3A@nongnu.org
X-Gm-Message-State: AOJu0Yyj7oHB1MmkcSamncbWUKJIHFV+Lnl1D1mhsZoMSgYksvHkDAfs
 TOEQxv3p8swRemZW5qI0J7VGti1wQ0s53U6jkoMsK1OARVUKDL8Q
X-Gm-Gg: ASbGncsqr6UxpN+K8X8JjPpY2qEpZdiXWImriNB7PvIpFeoAPo5gClLmrkENuURWKP/
 921SehEu9hwY2LZHA+1NkguaKlRqjS7rEa1V77F8a++UNfrLLbFZ/CkWyzvpE3KvDJGGjJMYwl6
 yM6dohyAHL8z79DLqg4Ea5+fN6gAgJ5WJW2icdocf5hu9YxwYDC2zaSq++cSBox/ka38/P40x0f
 Cgemn5FCirNCpXMDYXYUlBDH36WqLXjiwOUjpwBr5TYVtH2
X-Google-Smtp-Source: AGHT+IH0d6YSPYVBlvLrpvDGC/py0uyl+eqIJeT/34FkhYf+/ZNQ02pkgtcLccPomveOJR77ZGJmHg==
X-Received: by 2002:a17:902:da8c:b0:216:53fa:634f with SMTP id
 d9443c01a7336-21a84009ad0mr396287865ad.48.1736838667562; 
 Mon, 13 Jan 2025 23:11:07 -0800 (PST)
Received: from localhost ([1.146.73.114]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f234977sm62463405ad.204.2025.01.13.23.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 23:11:07 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jan 2025 17:11:01 +1000
Message-Id: <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Laurent Vivier" <laurent@vivier.eu>
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
 <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
In-Reply-To: <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Sat Jan 11, 2025 at 2:25 AM AEST, Richard Henderson wrote:
> On 1/10/25 08:15, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi C=C3=A9dric,
> >=20
> > Cc'ing Laurent & Richard for user emulation.
> >=20
> ...
> > The deprecation message (see previous patch) was about the
> > "ppc ``ref405ep`` machine". Is that OK we remove these CPUs
> > for user emulation?
> >=20
> > $ qemu-ppc -cpu help|fgrep 405
> > PowerPC 405d2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 PVR 20010000
> > PowerPC 405gpa=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 PVR 40110000
> > PowerPC 405gpb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 PVR 40110040
> > PowerPC 405cra=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 PVR 40110041
> > PowerPC 405gpc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 PVR 40110082
> > PowerPC 405gpd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 PVR 401100c4
> > PowerPC 405gp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (alias for 405gpd)
> > PowerPC 405crb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 PVR 401100c5
> > PowerPC 405crc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 PVR 40110145
> > PowerPC 405cr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (alias for 405crc)
> > PowerPC 405gpe=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (alias for 405crc)
> > PowerPC npe405h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 P=
VR 414100c0
> > PowerPC npe405h2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PVR 41=
410140
> > PowerPC 405ez=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 PVR 41511460
> > PowerPC npe405l=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 P=
VR 416100c0
> > PowerPC 405d4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 PVR 41810000
> > PowerPC 405=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (alias for 405d4)
> > PowerPC 405lp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 PVR 41f10000
> > PowerPC 405gpr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 PVR 50910951
> > PowerPC 405ep=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 PVR 51210950
>
> Up to the ppc maintainers.  I don't know of anything interesting at the u=
ser-only level=20
> wrt these cpus.

Just getting back to things after the break...

We are looking at modeling some microcontrollers on the POWER
chips. There is an OCC power management controller which is a 405
and some other weird cut down 405 derivatives, we're not up to
those yet but we want to model them.

We should be able to remove a bunch of boards and CPUs, I just
haven't started looking, so might be easier to wait for a bit.
If it's not causing others too much problem, could we leave this
in for the time being?

Thanks,
Nick

