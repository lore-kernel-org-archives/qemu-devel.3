Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB460C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 20:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkU6s-0001XF-2W; Tue, 18 Feb 2025 15:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkU6n-0001Wf-5H
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:22:21 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkU6k-0003xd-Ak
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739910135; bh=5DJYctcBOU4hdUoWUSfAKVatoqUDQyn3Z45VnZ/hBN4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=HNk7FNRxcKwuOaXchJc9qEjGXZzkQAl9QeRVNQavH7PfwTFQyfay/2vlMnbFJ3tY4
 CvxFu0t0vvEQqNr9iFRRepP8cJ4V+lrbM9u93EQnlgKroSAJojJ7O8zYP34gox909u
 GlvsmMFdd7fBR0pPaCNMlU/YUbDNE6us6NOYYoLA5Y9WvwM+OJSZ6QkqOYeh+gpqz6
 f4add8zXuE3Nr9cEpfoNOeNGtigZWAL4q9hQQMHiXBhckyWoSCr9FrcsP3dGeKStHU
 SdwJxGiIacugpF26kvB5Rav/zWXHh+HvchPi5oAhdHhypzyu+mRJigYCqV5rMaPuKV
 dHo/EBPGy6Qjg==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 9C3693F20D3C;
 Tue, 18 Feb 2025 12:22:15 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id jGQo3uLbV8_e; Tue, 18 Feb 2025 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739910134; bh=5DJYctcBOU4hdUoWUSfAKVatoqUDQyn3Z45VnZ/hBN4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=RU8U9jzw7WEhGxQdwLA1I1dweIWqp6ZCYebRcuyUB8wGBGkNnHv3Gl1jA14qlsqY9
 LowSnTM95crrlbcpJiK7QhGWQilpJlxg2DVcynEqy3riAlRhrae6cBHmjXvaVxPpH7
 E5F9pKl288tMSIU+P9RsW1dYxVDgsrHm8owl8jk45ZPr5RyFkxccPUUTbAlm1hOM+y
 I2tQUo4s5o9oEGOUduv4/uMEfbqnjNGW+c6MI06mLTVSjaEYldtEP/zXzxl9kOY5kK
 wrQRZQMpRfAaEOWiyrnHjcK/L8l+RqxhxMmofAsiJfh/Y+qjFyWUaoELUX0vfysfaG
 JPz50d8EgiLUw==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 0DDBB3F20C61;
 Tue, 18 Feb 2025 12:22:14 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id E62521E60096; Tue, 18 Feb 2025 12:22:13 -0800 (PST)
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] target/rx: Load reset vector from memory after
 first run
In-Reply-To: <CAFEAcA9uGeJoVGpHBU=830ZrNBojsVT6fER6OBkDw0vDfxXU8g@mail.gmail.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-5-keithp@keithp.com>
 <f7c1e671-f114-40a6-a02b-575bde2de4c4@linaro.org>
 <CAFEAcA9uGeJoVGpHBU=830ZrNBojsVT6fER6OBkDw0vDfxXU8g@mail.gmail.com>
Date: Tue, 18 Feb 2025 12:22:13 -0800
Message-ID: <87ldu3ype2.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> So I'm OK with this patch doing this the way it does,
> except that I have one question: what's that
> process_queued_cpu_work() call doing? We don't need
> that on the Arm equivalent...

Yup, I needed that because I was running this bit at cpu_reset_hold
time, not waiting until after cpu reset was finished. At cpu_reset_hold
time, the re-initialization of memory_dispatch hadn't been executed yet,
so attempts to resolve addresses crashed unless I synchronously flushed
the work queue where the call to tcg_commit_cpu was pending.

All fixed now that I'm setting the pc after the call to cpu_reset has
completed.

> Also, if() statements always have braces in QEMU, even
> if the body of the if is a single statement. But since
> if you don't set env->pc it is zero anyway, you don't
> need the if() at all I think and can directly set
> env->pc unconditionally.

Thanks for the formatting advice; I'll get it cleaned up.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAme06/UACgkQ2yIaaQAA
ABHpHg//eWZbl6s119sIzYYk1oqLHs3VsGSkcL04T7FDqEhX814tbOXX73djx2Xy
Omf4zMo+g3iajQh3e+bd72N930hyj9JZyHYFcWeTV3j6DOqPeZWdMm0BdgTkS1+e
4Ls+qi+9q2McN0cXsmCJrC18G4UZcNlUdsEw/gTZpU71+c0olzckdIY+KQRQ6V5D
sWXDei+Vsc9OlzVdQ7FgoZE0Hv70fYnLAwBjUG2i/gyO6tXq52aiPN7L4rG8TEuW
D3FrlBHuIK7SF3XxhwCwpxsknabq9OFRR4G6O6aw8kSCaskZKcZm7VIVv0V9Fip7
UawnRSofQzJXcCtuxzXjV5Brs3Cx5uJgbvkwC6a3qsqjKyyYQb9I4TbTCBfAwXBl
X2Z9ZGbKvsQ6yh7M0Jipvl7ILtqzBrDQ479YASSPgFeDPcikrhrlNSwThXwQtdbS
4JAMoxc2blASAuCZbS/LpABVgXiLF+/yF2n9nyW/Pz7rH+MBigWiuTru+rX5qiD3
hcukzsm3imbX9wYDkVJRsnVfRVLw3/+0MxoI7SDowmtfBMeAtpDVw4yrdpqUV33O
m0IWtAeZOhIAeHpwsWFpzmVfdUmo/691mvJYR90Pte2KDJ1oL3JxkfZuPVxHb3wB
6wL4zs4h13PGPjCqHT/2ynhUJgIdejY9DJishgVr0E+bw1+M3Mc=
=eTqX
-----END PGP SIGNATURE-----
--=-=-=--

