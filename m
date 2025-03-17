Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F85C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 04:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu23J-0008U8-JP; Mon, 17 Mar 2025 00:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu1zL-0008Tw-7c; Mon, 17 Mar 2025 00:22:07 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu1zJ-0000hp-Oa; Mon, 17 Mar 2025 00:22:06 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22359001f1aso21276075ad.3; 
 Sun, 16 Mar 2025 21:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742185324; x=1742790124; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rC7L0rRFhPblcvh4yB37ZMVfoqzWp7quOzAYn/tIObQ=;
 b=ffcTANJHJ6Ukscg6ldRWz1gzoH2rYfeU8yqwCV3xfi7LbJeo7hztPXiUkHo3ui/0Rb
 c5K8b6KpOovGYV9IG9uYXN/GDXgBka7Nj2LJABf/96Np7RBhhrxLrYj3T0aqF5L3YhLA
 yFjuk4Lssd2KYLr4oVuJEypYHlvs7iyvKIXO72YCc5cuIag5ijybx9XZ2J6+mYHIdChO
 vA7b4jat0d2NfVM/wbrpFZStYMEl36IHP2f2AayhOzWH6bvCGU3NwGEhh842E1nsF4UP
 r+W+uWPf6zXnQb6aORt1JYgT6D5SLIbuQpch6FPkIJ+WOGUs7vs/fN2JBS624fUyUtdl
 ckhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742185324; x=1742790124;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rC7L0rRFhPblcvh4yB37ZMVfoqzWp7quOzAYn/tIObQ=;
 b=sc+PUOkEJQ2Wjg6R0r0hbja8cVek0tsTOtM/GdwM80oThI3aUs07Um4tNstJP+Yt6a
 CU1+2yyb3JeXRavdEDmFygxc0PIJDwBrqEqPl4uNqSnpSQrPlAYgFdJfNTNyB5b/1isr
 Un0b5qlA1+smwWC3a0c/n588NFU0tDIJYAnLOv6eO440YIZ4zANSGMZXFDjVJHJMN+lc
 owXwodVPsc6JfmyIplz24ZctTOVHxd1X7KjdF6hFIYKXM8JE5P/MA6BHVmPZRv0TfuK7
 DOT0rhionlHYXZ6RK6Q/CYb6NFWv3mrAoKpDlaJnRUbA6OM+A6+XSmaolFmM5yYNk1pO
 BfSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVatFToyijQq/AWcGux8MYyXH6dZQ5WZh45dFyIl8NAysflk0OHDR1vqvnOKIL/kxqCG75ovf+8LTQ=@nongnu.org,
 AJvYcCWoK5eBUlscaxx4ssQ7Pga6kjBTsB5l0QcOqDfjLRv7/3xCw9d/PzGR8wtnLSitriNWKqsoCYJGOk4W@nongnu.org
X-Gm-Message-State: AOJu0YxnL0cQ3C9lJcBWvZNxvgLDjtLte1G4OUs6fy9EiR+zdTRsH4gw
 Ph4LVSGTtYLDbPDuag/JgY5053IbDwnNxaZaoJb8zE3Najw5V+bleZSlpg==
X-Gm-Gg: ASbGncsGDMA+lGWXLfV2qn/xW8sHqQg0BvzlnYFcTlSOKaYtXzaDkW8vt4e2baQda6r
 lFFXXNWQndM52EBWX15Bu06XPZDQ/V6j3Gt5/prCIDyouAkWo1EEi4mBGA/T9WMKf4mJz/jnAkB
 QB1zsWQ8Nb7+7xi8b9gIrherzmsR0JIe2rfMBTEsLOdQvlxaEJjeeaMsb2pTSRR9Pq4vJ+7KCke
 fKxbHV2es9/eAsMut/qL2m6UW61rlMIySV9JplOkImKQvCqkyaX8Bqa85ptRnvVCpc5Ne4w7z7l
 EH7AUbfp5AF0ZC4z4OZljDiJUrHIAz32fle8SjU=
X-Google-Smtp-Source: AGHT+IHb+3Pz6Y3WglDCzZRi3u+8OyYZEpwTUqoW3RMMUIuzpATLE12pBKDWchXA9GY/YEg5lAFXeA==
X-Received: by 2002:a17:903:1446:b0:224:c76:5e57 with SMTP id
 d9443c01a7336-225e0ae708bmr139445415ad.39.1742185323804; 
 Sun, 16 Mar 2025 21:22:03 -0700 (PDT)
Received: from localhost ([118.208.135.36]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68a6e2dsm65441035ad.58.2025.03.16.21.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Mar 2025 21:22:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Mar 2025 14:21:59 +1000
Message-Id: <D8I95IV1G7O4.3LYPKXT7QU1ZE@gmail.com>
Subject: Re: [PATCH] ppc/amigaone: Constify default_env
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250314200145.08E0F4E6067@zero.eik.bme.hu>
In-Reply-To: <20250314200145.08E0F4E6067@zero.eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

On Sat Mar 15, 2025 at 6:01 AM AEST, BALATON Zoltan wrote:
> The variable holding default env is not supposed to be written.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  hw/ppc/amigaone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 5d787c3059..e9407a51b5 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -63,7 +63,7 @@ static const char dummy_fw[] =3D {
>  #define NVRAM_ADDR 0xfd0e0000
>  #define NVRAM_SIZE (4 * KiB)
> =20
> -static char default_env[] =3D
> +static const char default_env[] =3D
>      "baudrate=3D115200\0"
>      "stdout=3Dvga\0"
>      "stdin=3Dps2kbd\0"


