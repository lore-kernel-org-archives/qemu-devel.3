Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0488CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ8A7-00056G-V1; Thu, 21 May 2026 14:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gumenezes2019@gmail.com>)
 id 1wQ8A7-00055y-0K
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:30:27 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gumenezes2019@gmail.com>)
 id 1wQ8A4-0001rt-S2
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:30:26 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7bf0b47d2f1so57951607b3.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779388223; cv=none;
 d=google.com; s=arc-20240605;
 b=cipk85dixcIkXD0oEGF/KDxG6wci0rCbmqAUhfvw9kOgh3GtWUrQVl0hy5frJ8F2UO
 CsyQ1+I64rEnaJz8ImVHhC04GrE8osBOrG1pWA3+6/2ej6KyGvsc/7gco8z9VqD6CKi3
 F6rezrJla+IFzaJB9cyfdm38A/u3wAaQT1Tkj65yfu77cFdTjTJXIQUqKLlWfN9QnSmY
 2kjLiMFb9yxgofRyTcvzVf0M86CgoEeXCuXsPLzt+L2L6pBRIXjOfQMy3BxuTp6qZM2W
 tFmqgHiy1+mAnJzWE2yb3hCoAv9zXiIo90qdooCB5HtFd+fKl48Gl0CewfB4JTAp2YJ+
 vxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=yF/KJBZNubywlEnOiKwaIzfrPhCgxd/jzWCTmZz9prM=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=lmZVFTV6BQafW2S4S6HH4b8gh56x1tWB82wkX0z2GR2aCn3UEzbrDM7XJB/ogG4TZM
 4aAhXZNuYXHFQ2cHeYRzRYosVzy+Gr2FBb1i8dBf+/c1iZBUzmJ1ihM6YqS1jZxBJegw
 7JZLi4FVoKqCM2Y2l6aZ2RC4p/FEfDcEgs6kKDOdpiHfW32YnvXsZxQPJCbinZs9rgyS
 XFrvNDoPYs7eMvVlG4NuZAVai7TdPu5BiWFWY/Y9hUpZTVUedvA5FhgfPIVhAXYAXcta
 ogMHI6NHlDSFcdlANC+8bQeeucFLk7nr5CzLY1PjRaLa2gX7L9WeNyaUibzhcKSEHRsy
 FNnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779388223; x=1779993023; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yF/KJBZNubywlEnOiKwaIzfrPhCgxd/jzWCTmZz9prM=;
 b=A+T/rcIxmrw11pryoEmz+vrQexTxBbAnYs9XmSN1CtMu/srdYLnYHyJEsODOJioqzI
 t7ciyc7WJ/dTK6gtrDUpZqsjPflgPNs4COBIZ3mfo28PNeLmqSXzFF2hGt8PMIQU8ccz
 NQ9Ko1LIsOgtNnNXjz8SS/r4yWfTezfpqUc/L9zsxpCmXgZhlSsi17sw3b0pn/3lbMPM
 rkCW4wNnbOX05CqnqHHUQBLz9Ny8RM4VxtyHNMrpxTr/2+PeDMmAXU7tfTBkg2OuOamq
 2h43Rxkpxdwh6n6hspAAyKM8Q2cd1SmyOtm4kXwZ82uiMyqHgV/ahdPaG2oSwddcf2+n
 QZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779388223; x=1779993023;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yF/KJBZNubywlEnOiKwaIzfrPhCgxd/jzWCTmZz9prM=;
 b=iZeAAyLrY4AuBEMG28xDOtDRlKAGBgCYDRCUZCLBD7cx3VJeAVn163DyHnAvjyGWRQ
 Qems9VFa1xoi0BdLTqWp8+jVEbeXHZnWamrl4MM7gnq4XuNwFNACtPF28SZ6OcsiATzl
 staZW9rT48ifH+3rSQBmUyC1wescJA1RC0v4sO2XNDACSryi/jeeKF/7uWVbdxdwa0qW
 zxg/BHUV8dxcXP20ufiIQQN5aRjRQbjEw9LBoQaZSamdubvvlXz3okyj/fUrBgH8KzxB
 fvchQlsPu/BpIZNQfBSV5PVUBWg4+1J+D+LEvBlo6xRwAL1uCGKujJdmlJzhT6E+jUxn
 jY8Q==
X-Gm-Message-State: AOJu0YywsShskIEQ/4uDLrHP+HCaEi8E3VczTHLk3ktWxNB6r+RYllN4
 lGuBhcH9vT3nmuEVPgUU2aZcLiyc27jOx4BCtfo7+n1lA9Fw/GRwHQKo3UfojEEYw4ozEdty9HS
 CqF6kXw+p4apDbOe3Q3JSf3GsLEznGJ8WNiwv
X-Gm-Gg: Acq92OG0OehZTko7CF5zA9pb7fFZ/bT5G5BpFdHWTHAPtGGsCad1stjwGx4SfpoCn0B
 bav/9Yl+MSSMQpuF46eT/emFE22ARmijEIPiIPWjieKMyfyqxEd/3dWczGbXsIBJKz05PrmRUls
 lX9+doSEcq5YBiOv2DMnwYMWgw376Jq0YlNYREGPit6ksxgfqK5rCv/HeOig1RzWUXn8d9efsxw
 Ok1jlpYn6n7sg9YxAjgkyHxAf4IUNXBCCSrNuTJr0JMm3ufPOL1dmEZkuD95ak5TRVktNmgYsOr
 41gAnU4I4fPA7Ew7iPaciC2IMDQlu81s5CHTCAoeGRznhzWWYTaI9mDH5ABcMWcGMQeSOJAFEqj
 EhzZk6A==
X-Received: by 2002:a05:690c:4b0a:b0:7d1:9c6a:d5fa with SMTP id
 00721157ae682-7d338787f7fmr5636677b3.17.1779388222888; Thu, 21 May 2026
 11:30:22 -0700 (PDT)
MIME-Version: 1.0
From: gustavo menezes <gumenezes2019@gmail.com>
Date: Thu, 21 May 2026 15:30:11 -0300
X-Gm-Features: AVHnY4I2--8ikx7MeiHjd3rkx02aHPAuuXhF1owZE4guz70OlRivyS4QRkVzG3c
Message-ID: <CA+YAEjo9BdN6RuRbg=bfVqke4kf24my21Jk3P4aJDzR8A5yqyw@mail.gmail.com>
Subject: [RFC] Add initial Qualcomm MSM7201A platform emulation
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f15f320652581a52"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=gumenezes2019@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000f15f320652581a52
Content-Type: text/plain; charset="UTF-8"

Hello,

I am interested in developing initial support for the Qualcomm MSM7201A
SoC family in QEMU.

The goal is to emulate early Qualcomm MSM7K-based smartphones such as
the HTC Dream / T-Mobile G1 and related Windows Mobile devices.

Initial targets would include:
- ARM1136 core support integration
- UART
- Interrupt controller
- Timers
- NAND flash controller
- Minimal Linux/Android boot capability

Longer term goals may include:
- LCD/framebuffer support
- Audio
- Modem/DSP stubs
- Power management
- Windows Mobile compatibility

Potential use cases:
- Preservation of early smartphone platforms
- Android historical research
- Embedded Linux development
- Reverse engineering research

I would appreciate feedback regarding:
- Existing related efforts
- Preferred machine model structure
- Maintainership expectations
- Upstream acceptance concerns

Thanks

--000000000000f15f320652581a52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>Hello,<br><br>I am interested in developing initial su=
pport for the Qualcomm MSM7201A<br>SoC family in QEMU.<br><br>The goal is t=
o emulate early Qualcomm MSM7K-based smartphones such as<br>the HTC Dream /=
 T-Mobile G1 and related Windows Mobile devices.<br><br>Initial targets wou=
ld include:<br>- ARM1136 core support integration<br>- UART<br>- Interrupt =
controller<br>- Timers<br>- NAND flash controller<br>- Minimal Linux/Androi=
d boot capability<br><br>Longer term goals may include:<br>- LCD/framebuffe=
r support<br>- Audio<br>- Modem/DSP stubs<br>- Power management<br>- Window=
s Mobile compatibility<br><br>Potential use cases:<br>- Preservation of ear=
ly smartphone platforms<br>- Android historical research<br>- Embedded Linu=
x development<br>- Reverse engineering research<br><br>I would appreciate f=
eedback regarding:<br>- Existing related efforts<br>- Preferred machine mod=
el structure<br>- Maintainership expectations<br>- Upstream acceptance conc=
erns<br><br>Thanks</div>

--000000000000f15f320652581a52--

