Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A5CD68BC8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBybu-0007s6-Jj; Fri, 15 Nov 2024 10:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBybt-0007qs-3Y
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:51:49 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBybr-0001oi-Jd
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:51:48 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aaddeso2387861a12.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731685906; x=1732290706; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EftnpNiwBgrVXB/8eoCTfPu0KjnD2KX89QFp8f3SzDs=;
 b=e3jjj6O1KJNrb+oU7hx5YiKkeWFRxbhMjUUC3p23EZMjZp7fu+th/O0VNrawS96rO7
 IVBlWToljitm2eKaJcYt4RPPoWLflt5NmDnny8fMTOpkTljIu7/UZSXHS1xjZHqwiDQG
 ptocopgH7w9HwDDDoXvnOEAgoA7gmoyZfEisEv6pLUl5sXDlG7fi1/xjN7PgL3h/GBAg
 T7Lu9NUchFMY94wVlX7rWemkIAwB9fqtjDoFaJ27uZ4n4ttLx7azsQBczNF0ba7o2zPN
 gfa5DrZLgeTbl0qPj5U3C90/MrFpg7V8WLTftC+PqBDyuN8Ph6T8KtO/xwXtyvTbJgfV
 f5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685906; x=1732290706;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EftnpNiwBgrVXB/8eoCTfPu0KjnD2KX89QFp8f3SzDs=;
 b=FQgKPlNamH+5hp1NLYUZal2k/5rgixoevOmwW4zzVRkqrj1ZNsqsSnA8St1SuhbR8n
 0LFx+uXS/K46xWk0iMvWNeqFhkMCMw7T1iojgA6Tkia1FiJQXZEnMwKh09G+/1xL03gQ
 czC9DtXayz4CEb8YvWTE4JztCSXKOVp6xwCmfzEr8FpDkFECkxmAUaGlDGOEOytQr0gs
 d8Ct3mwqNjJKKJ+kTeJmS6zQSH05AKpWDlR66Cue/iSRn0ZHRonb0nqHOXciR7AfUBz6
 KkLxygDZqcrwzUItVLAVXqO8JiJoziY74urcloH74mXGzStn79s4SRouQ9CADEoC3y0D
 wjTA==
X-Gm-Message-State: AOJu0YyXxg2TikCY/cgCDbFP3KIFTiMVzoLMSoD8V+98i5PwjW/djp8F
 KZK9caJumCGXcq06tUSxj5powvMzHfQyCyKmTtleZNXBXxmf9J0G/gzZYeuHiljoz7Obr4U7Tg1
 ko4TDyDIkfzj4lLIi1RWgvdx2jHvj5FI/HHGABw==
X-Google-Smtp-Source: AGHT+IGwE+6O8UWpvk0bZMNDkMq5VnjuISyEnfqH6m4YleDTSA92blfWXic+BLAUf9+zHMYwClnUrnbMYixSCIEwqks=
X-Received: by 2002:a05:6402:2345:b0:5cf:9f58:a919 with SMTP id
 4fb4d7f45d1cf-5cf9f58adfdmr420796a12.8.1731685905847; Fri, 15 Nov 2024
 07:51:45 -0800 (PST)
MIME-Version: 1.0
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-8-philmd@linaro.org>
In-Reply-To: <20241115152053.66442-8-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 15:51:34 +0000
Message-ID: <CAFEAcA_E10JRu6L3Nci+8X6F2mtBYgn=BSsVvMYb28vqwBX01w@mail.gmail.com>
Subject: Re: [PATCH 07/10] accel/tcg: Reduce log_pc() declaration scope
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 15 Nov 2024 at 15:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> log_pc() is only used in cpu-exec.c, move it there.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

