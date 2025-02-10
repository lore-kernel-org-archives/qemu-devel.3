Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9839C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 18:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thYSU-0006II-DM; Mon, 10 Feb 2025 13:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thYSS-0006Hj-IC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:24:36 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thYSQ-0004GE-Tp
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:24:36 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so3973942276.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 10:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739211873; x=1739816673; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GG691S8paD09D2xs/5uikDvgjy24u72wmjbW8fA7/E8=;
 b=hZ90dn8G+qYWr0jaHSPLczKnRpyXhzGDf+X5R6o1tp7hnYn+1PZoHUntoOwbqp5ion
 TFBYIUf8mqRqQNIRQIZp9Q4ztyphfa2Sd5hqaJkJL0CEpS+RDG2RiSKrLciZlfixuFjb
 Q41ALZi9s3wUHrZtrFUJPfnTubSIqNqjaz1fQL9IAiY13Y10+UIqhTEB1v3ur7rwPXm9
 PvkbXlz/E9ZTGP+gOYVufh7WzYQTLGJ19j0uT5mUwPZhaI0bwNfk4fS74Ib/WeJuUmDs
 Wjlnku4yZ105uX49quEe19qV+0wCsrBpTLgoi2rBbtG4FIs+ai0rC8jNWP5sf+KUIoUY
 ifuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211873; x=1739816673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GG691S8paD09D2xs/5uikDvgjy24u72wmjbW8fA7/E8=;
 b=bBUvwuySfp2eY1AY14iaxp9GaWnkaEENQIcI925p4ZcZGYwoc+z1EOK67QTr1aH2rr
 MyOD31G3yCC+0f3Gk8xBS0xM4AmNk+SjyIhk350ixl54AuVMqOLTnqvSx+aZmZvriG3f
 bUGeeJpxIEl4pFLHST4G3jMFRgxXEOiME5cmJlOe/wA8C1vAqFRiwZWBo+0c1xjJws62
 +qumA8vMSNuYgbj2Smnjr1f/vL3GIVkaascF3DpxVuTiAd+2FeVQDpusiAA8KXfJWhO2
 zdcfTBVI1gNeKSSMXPIOFdAhLyY+qR2axhN6WoSvrbmVgn08oj/6amfrdZoeh5XkEpxw
 RQjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU++iV0MEBM285hQLdTJjFamoAOHCcJ40X96a6BwgRMyteQMfnIA0AeKFSjMF38NJ2m65MrpXaeDcAf@nongnu.org
X-Gm-Message-State: AOJu0Yw+Q4uJOQ85Sfs0w8vRCdg6oLAqjcLu26RSwJrfjfC0pSIf4waM
 RWesnpPD/lqNqjKCe0mcdPovByOATXiY+J0Tthxw/IlJU9O21MLnDWZWdxxtEON6SmUno0T9ev+
 NND9vYTCFm31DxqC9Dl0xqsMmMkzhsIaJE6bk9w==
X-Gm-Gg: ASbGnctSPZqKRE3OTgB9YrlbYKbtxfjIoq7B26JJhrlXHH6cPUqzNWW04bb4Ufl5wGF
 CoGH9dFWQ29LI6SL2qHk0VxU5l8+FBjOJWdDd6rKRUteGttPNUVMp5VOIHUdO30TTbsyq2j6sLg
 ==
X-Google-Smtp-Source: AGHT+IGfspMKaY7jf22lI0uYNiQ4kZ1gdWXmyowZ8O5RQA2vWE0uV7tzurmQ6yIz7lPM/y5qv8sFEh2qkwZP4L84pvU=
X-Received: by 2002:a05:6902:1707:b0:e48:7efe:57b0 with SMTP id
 3f1490d57ef6-e5d93d30f5amr980298276.47.1739211873431; Mon, 10 Feb 2025
 10:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20240828111552.93482-1-danny_canter@apple.com>
 <20240828111552.93482-4-danny_canter@apple.com>
 <e67f8106-f741-4e81-a291-db06bfbedd7c@linaro.org>
 <1CE8C01E-6930-4DFA-8C96-CACCFEBD24AE@apple.com>
In-Reply-To: <1CE8C01E-6930-4DFA-8C96-CACCFEBD24AE@apple.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 18:24:22 +0000
X-Gm-Features: AWEUYZmPu8_UjAOXexgPN6NLNIUZbyhkjjw-zvGgLyfEtYXN6JJ4BZpezP5N6ZM
Message-ID: <CAFEAcA-Npf_9gV=LP2pmpgQ+dbqxQnJk1ubrtAhUc3nVbM-s6Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hvf: arm: Implement and use
 hvf_get_physical_address_range
To: Danny Canter <danny_canter@apple.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Itaru Kitayama <itaru.kitayama@fujitsu.com>, dirty@apple.com,
 rbolshakov@ddn.com, 
 agraf@csgraf.de, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 wangyanan55@huawei.com, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Mon, 10 Feb 2025 at 18:20, Danny Canter <danny_canter@apple.com> wrote:
>
> Will do. I=E2=80=99ll reach out if I need extra info. The issue appears t=
o be closed though, was this fixed/no-repro already though?

Whoops, no, that must have been a mis-click on my part.

While you're looking at address-space related bugs,
https://gitlab.com/qemu-project/qemu/-/issues/2713
is another recent one -- user reports that QEMU says they're
limited to 32 bits even though their mac/macos has a 40-bit
IVA space.

thanks
-- PMM

