Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4A4E65286
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 14:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmYq0-0007Pc-GH; Sun, 01 Feb 2026 09:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmYpv-0007PE-Lt
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 09:54:03 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmYpt-0002RK-Ue
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 09:54:03 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8870ac4c4eso563085566b.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 06:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769957640; x=1770562440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZ0ZmJqwxN+LNIRtRSnaOGO8yfkB64ygWtPfrFPI/1o=;
 b=AA4GR26JjxjjPMxv/dz32ZAuGWIJW5EOsPgA9Fkh/ANl6GCA54yGSN/JwkVbofMEF7
 /pol9BDKpxgCNHpntGnDRymxL8jzq9i1m6hjyD8EroGSM6UDflEFGtniW8f5KtOHbQef
 /YIQXBbVprDS1sNu3bN0Cg8OPKFv6fXzx9/NI6ditCZeXK2H5pIkkQT7Dhn48qmDlnBv
 nOLTKTFtHTXM0iy96lldhM4WyI9wRdZotXi7Xe0UkRiQSfh+RVSHIJI8viTptMvSwd6b
 EbehpCw0N41IN1BKtwKgay0g4WBYnBGJRlek8Mp3cHGFQEsQeF4JJea0TjIXT0h0ADAH
 +DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769957640; x=1770562440;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HZ0ZmJqwxN+LNIRtRSnaOGO8yfkB64ygWtPfrFPI/1o=;
 b=Jp4wkoFZhw0UyfC5aeNMeD+BZ4vrbGmyZE5QbbjdUq8DD+pAoLNQLqdfD4dv2SroTX
 d/f0+8KzXHzzYgziOImzNODhOTBXA9WZMHl4z6kIfj/ZMOGAqD+rd51rjaGG7ZttfW2t
 KKIbSETGdwgeGpnVMFHyeQQ1nAiFM8LxlU7sOMUEult9M1AJpMFwpU1EeChRjbQTPfxV
 1Kny8ip2v3aXYQJ9fom6rOc9nsJfGM9GgSF60k5Yba7b1/uHPu2P7ew3HbMBmFG3h3RC
 T1oepCLCXRnW/nU/FxS/5h4Fk2R2j7xzsHZ/2NYFkqthLuLXnLTVsGJlyt+eFcpjEyIV
 J9Zw==
X-Gm-Message-State: AOJu0Yzm2SJxujufs/8ZmK+E+qfNyY3kImMqvebbKPNT9z78Q2B27MDf
 cjN7oVr+vh/KhP9dZDLL6G+94TE68L08h/pU8FfMsuQKhFFJYCvM4WX7wZAcWM6DGk0=
X-Gm-Gg: AZuq6aIa/uE5bqkzuklR90VLtL9Hz3h6KL9wTzLDbaKSWE3VX4t7cMYpUo2d7ecFS7C
 36CCWUEEmHatgMIJXvQCyX5NUYdBF2oK2saMowGeleA8NUIpXUYzwQyhXDKko3lyC6fPQgSl0F1
 /rVO9Rq/YvOmeJQEDx1ZMytrAWcZ1TQRVoI0j9NMcCPeJAeffOgfcP2fKwj7X9Zbis1eqHFSpmP
 KymDL+GjBy9ZnA6lxOrW9FH35bND9pw9ZBK6Lu8GvR0ipSBniNwZBRjDvpdL0cOh3UAdFJKXKRC
 uUDzxH8U3WWZobCIRboESFt8CJ4cjTa+FSmX4rF8e31p5jgYuWHuF/8G6HcFRVEtdpOYhkhFPu6
 DO96xGBNP5cFJYjeIc/znlRGnrQr6EOy/v6T5u2X9u5nGeOeMWNpveIhoCDXjWEDpw++WuZhF+8
 Qz2h8bUHaBKXqkwHF2X7uY9g==
X-Received: by 2002:a17:907:7281:b0:b87:2471:def3 with SMTP id
 a640c23a62f3a-b8dff72c62cmr566943666b.55.1769957640000; 
 Sun, 01 Feb 2026 06:54:00 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbefc27c2sm721704466b.16.2026.02.01.06.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 06:53:58 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 58B0B5F792;
 Sun, 01 Feb 2026 14:53:57 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Warner Losh <imp@bsdimp.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: Question about tb_flush()
In-Reply-To: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
 (Warner Losh's message of "Fri, 30 Jan 2026 17:08:30 -0700")
References: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Sun, 01 Feb 2026 14:53:57 +0000
Message-ID: <875x8g1pmi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Warner Losh <imp@bsdimp.com> writes:

> OK. I've updated bsd-user fork from last year to yesterday. I had one que=
stion.
>
> I see that we've gone from tb_flush() to queue_tb_flush(). Why was that? =
And is it a drop in?
> FreeBSD's fork has this in the thread creation:
>
>     /*
>      * If this is our first additional thread, we need to ensure we
>      * generate code for parallel execution and flush old translations.
>      * Do this now so that the copy gets CF_PARALLEL too.
>      */
>     if (!(cpu->tcg_cflags & CF_PARALLEL)) {
>         cpu->tcg_cflags |=3D CF_PARALLEL;
>         tb_flush(cpu);
>     }
>
> I think the right thing to do is to just change this to queue_tb_flush(cp=
u), and that compiles. I'd like to get some confirmation, though.
> Did I parse the changes right?

Yes, because ultimately we use safe work which:

 * Schedules the function @func for execution on the vCPU @cpu asynchronous=
ly,
 * while all other vCPUs are sleeping.

>
> Everything else is mundane changes that were more annoying than difficult=
 :)
>
> Warner

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

