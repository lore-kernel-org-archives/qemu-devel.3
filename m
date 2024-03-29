Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94912C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 12:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqBdG-0005TO-CY; Fri, 29 Mar 2024 08:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <constantine.gavrilov@gmail.com>)
 id 1rq98q-0003FP-Mp
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:07:21 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <constantine.gavrilov@gmail.com>)
 id 1rq98o-0001FS-PP
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:07:20 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d4979cd8c8so18122931fa.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 03:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711706836; x=1712311636; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XkgsFWNIXztItQ2G4EaOCCMBUWh4a1ePKjQ4SY2F7C4=;
 b=hrjLlTUEwRmqDb7I1j2BfnSyNO6O9EKT9ASf3rB2+638zPQag3Ptz/vKmPuogAXq+r
 mlPlZ3bhLGpRX56rfOgTPtOjqqu2+X4HCV7Kl3LcO5pW9eqR/hXTANDlZg3t2Z0Ix8M/
 zRCx8WX08/hpUzOrKlaXJmGKWAu0HPbgJ1ey+5uCxSTDIaHWcgv5es+ivOqOOsPOjeM6
 mN3k7tchcX7sp6FraqMf+xbvbMswy8wwxfW9rzJ70K/gIgCzu6bzSiBGMQtpHZcxoTxa
 aCLSDukFIcbR1hIAQskomEsr2Q9SeqWc5gdumUysl/xEeuHvsXvHDGKfZwUlapD0cCpx
 SjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711706836; x=1712311636;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XkgsFWNIXztItQ2G4EaOCCMBUWh4a1ePKjQ4SY2F7C4=;
 b=JsCySlABlggChRadSw2hSFcsU2Kn4VWFB5VX6Na1yoAHtx7dnYbMbY0G8o8FAxx9F2
 8qd4KjUg7mD8lrJCENwyGDlJ3wErmC8mZupP/RureT/pjC7NoBBa5XPNGt3HHrggC3u8
 SCCljXwXTrP6EtlJZ0gLg6AmlHI/ipahcQbbelHcy/UC9JmwVlpdVlg51KLM03f79AOE
 L+4nJtL5Rx7ZruiSnluO3Z/ecZZJ5DHxN4EmhJJgAIaHP7Cyhe/GR2xxngyFN7D5l/xa
 dx0PpYcc4CfNOu3CV/G88/oAzdzKlEp17T/twnYKk4yKLzanqGdf51jmRVMj7voF0hgA
 S0Tg==
X-Gm-Message-State: AOJu0Yxv9PiMFjtregNunLlGxQ8fGoGs6MGvDq3TFdEfBi7TTNywCrWO
 axvC/FmIF09KgLAYiycR0WGkRC/e8eqAlJPMReCoZcN4OqBZF/XbK1gE2F6LL3brVEVtDy3ZzuL
 wIcSWuYOX6YGeUL4pLsrWEFXQvEtAmLnP
X-Google-Smtp-Source: AGHT+IEA1Eg+ldymDTA6Nb0p55eaAtkH2k3GXYZwANRbKoKycKvF0kJ8XSxKb7iUvqqjmEKcG/KJqmG02rtX3XmUPH4=
X-Received: by 2002:a2e:9c02:0:b0:2d4:9334:3c11 with SMTP id
 s2-20020a2e9c02000000b002d493343c11mr1771418lji.16.1711706835697; Fri, 29 Mar
 2024 03:07:15 -0700 (PDT)
MIME-Version: 1.0
From: Constantine Gavrilov <constantine.gavrilov@gmail.com>
Date: Fri, 29 Mar 2024 13:07:04 +0300
Message-ID: <CAAL3td3sAwRv4AUZ0492wTVJ9qVUevM1FU2u_xxp93jCOi1K4g@mail.gmail.com>
Subject: QEMU NVMe Emulation does not seem to work without Shadow Buffers
 Config
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=constantine.gavrilov@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Mar 2024 08:46:50 -0400
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

I am trying to write a custom NVMe driver and I tested it with QEMU
NVMe emulation on Fedora 39.
I have not tried to set shadow buffers, even though the controller
reports such support.
What I see is the following:
1. Only the first command in the Admin queue generates interrupt and
completes (Identify Controller command).
2. Any subsequent command does not complete (no CQE even if polling
CQ) and does not generate an interrupt.

I have a suspicion that the implemented shadow buffers config support
causes this behavior.

Any ideas?

-- 
----------------------------------------
Constantine Gavrilov
Systems Architect
----------------------------------------

