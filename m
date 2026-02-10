Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA44E7E0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 11:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vplhy-0000Pa-0Z; Tue, 10 Feb 2026 06:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vplhw-0000P2-SP
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:15:04 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vplhv-0006Rn-5n
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:15:04 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-794f701a3e6so51068687b3.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 03:15:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770722102; cv=none;
 d=google.com; s=arc-20240605;
 b=iT0grEf21wrGVx+68vxaharlssCxZCbsf9sDIyFbtC1stByaICy6G1c/ivhv3oCIiA
 4k2Mli98SveJP165yE/GXkc3ydgQKBleTc9Pi9UxY8XUJBlbg5aPJBfQtpTOPr6XnflY
 n5+Z7rs5zwfiUjcT7Rk/ZhnKoK9Igppu6qVPW9FVWVdUkezyntizsBQAY+RF18bpRisG
 uARkQ3soECFv7qFMqBz/Yd6E1IUrALGfhaROP/vBAu0rFyIs2ENQx4fkd/cTk2GTtt8m
 7v0B7yAblu9tuD61eSG+VXQvACEVCrIPNZEjV3ErLj+zuXyEjnT70IPgJ5LGGkQAQo1y
 TWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S3+5ZHupeNpaa+l4pvzXtVjfzFtCw62Pi0hyVcFDzxQ=;
 fh=/xakVGD2n2FDCL1IO59hU5yecVDHv+Y6YC8TaqIjnb8=;
 b=E28GezVrYaL0rEqTw/e3LuVc/A71SspW3MjcZCEytslG8Xuri2x0vHesmwsK2VnXaG
 Bi33c9LrKG8fvBNpXwaa/NV61cuQ5BjTOn+v6eIDhlGOj06+29a6yHswLnAmDEnHk0C3
 Oisz9gcfFvx0Fxo6G9KrJj/5OXnOZkrQ/zxbaqT+TwyqMc3WurZKkJHB1LxO7YTFcYFk
 WFVf8qvzfBU/bIpjrWvGBw0CID3LSuPjyJ+YcfLYL8mcV9wp0hGG1qTtpgGbYtj6cCBa
 EYj/GMRKFTFCXqRwVNlx4xiudmme01fhbTQzb5boHWeQ+FMHXgZ/EaWlJgHNW96fN8tc
 drbA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770722102; x=1771326902; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S3+5ZHupeNpaa+l4pvzXtVjfzFtCw62Pi0hyVcFDzxQ=;
 b=wvAilwoVFtKeVyrURYesbMM4k81qcUwWNAS1glYU/NxLDctvX+zHFz09Q05FZ6MO2I
 Dcow+ZQ9A0sjKKG02p5pMMS1Ytn6uA0MUom95xmjLD6qOMwYJxaLQQ1FJYl9GJy7kZ5A
 y382/6S8gtKcl9Vway9jAkJAV67bYu5sH50beuPK9oZ60rUr2g7MYtUZYbubhinIhlDG
 jp57nQVWJ4oKbV9jUP91Y7eVXA/RILUk4PnYhqROEIADLbJl95+aAm4gPoF8BuMBAGeL
 dKW8e9OPwhx7zd4E+PWs+SWKt5JnUm2iLGZYv7l9MZ7dli7GU3O+CfGxeNalo+quzO+T
 lf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770722102; x=1771326902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S3+5ZHupeNpaa+l4pvzXtVjfzFtCw62Pi0hyVcFDzxQ=;
 b=liUL6s01fmltQE9DsMvbzBBTlrKCsu3r7PiECNMsabK1urOJutBQqaDUe4Xf/4HR9A
 pFoI1NiHNy5LASJks+FJ5HJrdHPGlhmbvCaH4oBl9WVJYyZQSn59fjBPIR95TlH+2OQw
 0+0JDAyz3aCOwasUiqyFqYhFFH38VOibLxrSxHkiBpUdZ4/gb9vg/tIVvZ+Hb/FwfSU8
 uOPR/3yC49Idx+fqjxvqsRJB8jt+VFeyRiOgLIN47SqVOFUqLb84GIpHYHv7gi7p5Z1P
 p6yOLbuLa/vUnCGyct2T8OtoR3CGemA3uqdGqRHPuEuAgs0Jz1uA9gBebclXZ+UagVSa
 yGmg==
X-Gm-Message-State: AOJu0YyN95gnXDybEp9Lsw1fPvxk+0zyp594RW6l5F4xD2qaT8NB+U55
 0GJOTkbaDHy5B01CWp6ux5+EfSIeOXRtDnApo3k1QC3EI+85h8UdofU6dd8ycrb1CEJ3KOGc5Rt
 Z8FmeK3eGSRJPMyUYM9PAbpl/YQcD87S8cITJzaO4wY+PE7jgfNBk
X-Gm-Gg: AZuq6aLnuEEHSoYH6m+RnwPzAcRhEMi4tMrXhwRILna3SINjQkPgsu5qZsMPVCgfRNT
 1iqfuqNnJKSHnyG/Qagrm1f/avax7eRxkmVYBroPLJfBLr5nlbV8Lbuuy7u55xmvmN03eeVZLE1
 zGJnAQZ9wxxvNcM8TbEA+e8nQwuHT5u6X/mutpLY7kNNriXGTWeVNQB9+Nr5hnvOY7M+pj1e3hR
 52ffGsB6xp6re2LKh99wN3rIy+Mao0wwkLl5boqzMDG+zSx/PI7EUCD73UWqLAIYC/O36a/wUKJ
 BiA5aXDOCzMbWxJbS49H3/Wt+XdFC/X5FA33JokMg412bXGe+i5NhYDABsYQ2oZPrj4=
X-Received: by 2002:a05:690c:e352:b0:796:45d4:9e5f with SMTP id
 00721157ae682-79645d4af68mr54294357b3.67.1770722101821; Tue, 10 Feb 2026
 03:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20260210023040.3507338-1-gaosong@loongson.cn>
In-Reply-To: <20260210023040.3507338-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Feb 2026 11:14:50 +0000
X-Gm-Features: AZwV_QiUop-EKDPuqIB-cG52d8WQtalZkGhoR8EfJv-IMLsdE_XueqD5Gp1GdvM
Message-ID: <CAFEAcA-+FNtumeEQAtoyTnmXVXKJbB_5RH1_skS25r1LwesVsA@mail.gmail.com>
Subject: Re: [PULL 0/7] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 10 Feb 2026 at 02:57, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit c4a9d49c7b23a02c646ebac756519c15a24f7ecc:
>
>   Merge tag 'pull-9p-20260207' of https://github.com/cschoenebeck/qemu into staging (2026-02-07 17:46:15 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260210
>
> for you to fetch changes up to 59c8adc2830342c2cff5fe8867191d0e166abb29:
>
>   target/loongarch: Add LA v1.1 instructions to max cpu (2026-02-10 10:48:20 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-2026-02-10
>
> ----------------------------------------------------------------
> Jiajie Chen (7):
>       target/loongarch: Require atomics to be aligned
>       target/loongarch: Add am{swap/add}[_db].{b/h}
>       target/loongarch: Add amcas[_db].{b/h/w/d}
>       target/loongarch: Add estimated reciprocal instructions
>       target/loongarch: Add llacq/screl instructions
>       target/loongarch: Add sc.q instructions
>       target/loongarch: Add LA v1.1 instructions to max cpu



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

