Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95BECD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 14:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRWQH-0002F1-Jx; Mon, 25 May 2026 10:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRWQG-0002Es-FO
 for qemu-devel@nongnu.org; Mon, 25 May 2026 10:36:52 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRWQF-0004Yb-2p
 for qemu-devel@nongnu.org; Mon, 25 May 2026 10:36:52 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6896c54a7easo2147800a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 07:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779719808; cv=none;
 d=google.com; s=arc-20240605;
 b=L2pYwcRY6N30LlVwuk6O+S5qZFQBDgOr4kZb1rVcylSqGx1lAd/Vbp01y1DMkS3mII
 XYhq2u1xH8kxzIt6EoE/tHzlVMiK3vVCXtVb8ie1JK0pxESBe14MEpSCagVQjZOTfo8p
 NeSG/c/zbjH+376ORJrmkphTix4Iz3XSljZmvNuxVft086m+2yDQ+yYJb/fKpVAfPsKL
 mKDEWddkQzyruggX9jqNu0vsLBCx/t1W0b2/mRy+AyKM/SzHpb0t8KJb4zDhgO/Mzzux
 +wT2ND19jsMWM+B3eAgwXfHb3xkZ4pjQ/SY/fNm+bnS5i4gDX6nquvcAwIcqe5BAoN5o
 rDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XQ6kjjLZKQri0yzk4/iPKGPbcMhCLV1lozg8t23C8W4=;
 fh=PeEc+hEKn7gVMxphu2cZtpHuEwxyX1sG4BZ5gRuJIpw=;
 b=RPflNHBRCwIbNRjoxfs7tBG0Kd4ENwKJNtFuNGNQ/Y4CXvEvoDoP2RF0T6697PJRt5
 VBKottslSHWavuauXHfFDRMXG+5JgQoPlxPWFQ0lOAUC03oETMVVqiLJ+qMsFQtL8d/a
 lCcnvdeJTTGM6+YGnek5SKhWmk+AIw2vXA3vJ3pS0ThMqk2Q5CJqkn/BXHN5pJhLGwZ8
 BnSzyXd3Yx+hhtCz7UY21WAVlvtXNYg4qCNd3Z6W16RFfzcioXJFofCYH2CQu8Vl6gI6
 U3gD1a7Z4xWyg1sC13mEtBFUOOJR3soWGwOOI+Kq7c0mhFcR9lQMf4U8tL9yi8iIgs/q
 /VRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779719808; x=1780324608; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQ6kjjLZKQri0yzk4/iPKGPbcMhCLV1lozg8t23C8W4=;
 b=cYKYBhqkysIwGrOAGIwgZmfbK9FrIXIhvSqoZEfozchy7JU9zcL4KfI1OyOH8O0s83
 kQD0mws3B2Act7FNURkBSlLn4/5TRVjAx/4n+8TEJAupF5hKLKJZy0rLUqhUf54ug3k4
 baSJidBvmdE+oHQd9IsaTEMihfdhb38oQgfHf9OaTh/Nt22SIyorDPrg7q+CoxarGWdD
 WSor6tsdSW4EZ/AdRWiWfviwP1IXEeg44SKN8I+eo/HoGcaHNRcxzas1CIkald116gGX
 ww7CJoggUWqYRoIwxXlHGlr28xAcHC+TBTPjIoF+/9I3klfEz6JvoCgJp5ct7cdynzOT
 UK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779719808; x=1780324608;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XQ6kjjLZKQri0yzk4/iPKGPbcMhCLV1lozg8t23C8W4=;
 b=aYO6EKM2RFrskAA2eSZaxQ4ua2o8fbvb+L9oD5NL3igLPbnU0y9nk1GEUON5NU7o2N
 fyi+rbdJ9C2T/wr/S7yFC5Tn+jeElm/mP3eFboqdgki8W5VCnhOwonEds1t/0bYIpzgf
 FDFqUQYudO1nf7xdjqAh+yL2WvTDTIB/EpzVIK7nK2SuZYKP1G0q4FDXHLLWcOoDZBxK
 HGij1U4MoTVedQICYlwEPmnDdt20eGqpjOeoarzu+7wRkHYOX+42VIYzUJBMvEU4mhQr
 zuVerRpAANSGo6iErTr77dCDE5Uh1nqDB/ZVQ++1os7CwWRNPy22ZJU1KnBkKuiMEioN
 kchA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ICR/HubJPJz4X3WGAZlmJtkA6Ux3cBoNoLreZQ48YCP4JVmBoPEH7vtjmDat6ra7ELDEGMDkZ3Tr/@nongnu.org
X-Gm-Message-State: AOJu0YyFuCs9k1OdU81lD7ktkK9Pa7trXlFgrd4Pp8YGPV7cDBX0Nd7R
 Km+qB4ZwLjspGznV+bvINKZ7Cu1dh6vUzijWRM5Ftq4J7o46sgxeYFOWInEFSWbYVVxJFZ/YZiv
 zH4XNgmt/m24B8rWBiBhjMqQ41XhOUa4=
X-Gm-Gg: Acq92OGA+bL5wmakgyd3+KDClg+SIegz4JhdncA15UVjPhKkoH9ycXy1giDUQ2zCd9b
 C+kLmHy9IYXmvD53ZTHJcYrxJ4qi+yATVlNlVY/KHiO0zD8LLl75u9wjIXx9hFDqrdK5hwq03bO
 hZO9L5UdrclfsoXpS3Gxh0vIXPqZmT+3j/Q2sExgN5RtI5U7H7F7LghOTnS1XGhtH1SXuVxf8Mz
 JOP3G2ldUkmGLYauCN4M3rgfxEOcwr1hVxYEMv5OcfszsPq06EoFqtAadEQE+g6CJvAP4fw3+GI
 T6INL/1drfGkf5moQh3QMeY3XCQuuSJDdY/sulJhyu6VHJ2AeNo2
X-Received: by 2002:a17:907:a68a:b0:bce:267f:19cf with SMTP id
 a640c23a62f3a-bdd236004a7mr836465466b.12.1779719807964; Mon, 25 May 2026
 07:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QULyy5C0YEaxz2ChNy3_zfc5VwaMhB18R=yHDgnhBYo9w@mail.gmail.com>
In-Reply-To: <CAJSP0QULyy5C0YEaxz2ChNy3_zfc5VwaMhB18R=yHDgnhBYo9w@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 25 May 2026 10:36:35 -0400
X-Gm-Features: AVHnY4JbDGW8-IVGI3taTDJue3yhBUg_8GH52QB3xnj9yPs5nkf4c-VWRVjSWqo
Message-ID: <CAJSP0QWt8Q5+yY1F6--XyvcAV3afg3msAcO6vaNDeWS=B9Oqag@mail.gmail.com>
Subject: Re: FreeBSD CI after Cirrus shuts down?
To: Li-Wen Hsu <lwhsu@freebsd.org>
Cc: Warner Losh <imp@bsdimp.com>, Alex Bennee <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
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

On Mon, May 25, 2026 at 10:01=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
> If you have a FreeBSD build host available, you could install
> gitlab-runner on it and I can configure GitLab CI to send QEMU FreeBSD
> build jobs to your runner.

QEMU has an Intel x86_64 KVM VM with 1 vCPU, 4 GB RAM, and 60 GB of
disk space available.

The following images are available:
- FreeBSD 14.1
- FreeBSD 14.2 (ufs)
- FreeBSD 14.2 (zfs)

I can provision the machine for you via remote console access and add
your ssh key. After initially giving you access, you would become the
maintainer of the VM and responsible for keeping it updated and
connected to QEMU's GitLab CI.

If you would like to do this, please send me your ssh public key and
choice of FreeBSD image from the list above.

Stefan

