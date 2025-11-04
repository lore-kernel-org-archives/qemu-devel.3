Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B5ECCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKxw-0001eI-PJ; Tue, 04 Nov 2025 12:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGKxq-0001e4-QZ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:37:04 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGKxo-00014X-ME
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:37:02 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63e336b1ac4so90384d50.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762277818; x=1762882618; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4wGHWEk/Rh5gzFqxqbkpagzlruOfPdJLxPI2HdN8FWQ=;
 b=kQJH5z+oklRgsD9Scy0iCcobiAsdeLVJ92RDrjLAitlfRxQl7oK4IWqoAWxg5yVFXe
 mF2cB51dBP/iZZeSBPAKrRwrTkhJRmhv8UbmYP1wP1uDlERN4LyimaEBxQUuxmIxl8WF
 Wcmi6rMPZhA7mliCPlkFC6B3lQxtNX3qJFf5wtPSD4kROjnUm8sUl0WlQJJT6fgjd2Vt
 vbeDra0G2wlsAaafzis44gXRc8EPmi2t7v8VRCKWbNdNA+6jiaui76v749OxQQd2eMgR
 qRycOf4sQgA9rf+f+ccZAXxtVSHKG1XmmRTTQFRbq85BWaoMSaMhJ/wzLh0L+K7SyBhi
 wgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762277818; x=1762882618;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4wGHWEk/Rh5gzFqxqbkpagzlruOfPdJLxPI2HdN8FWQ=;
 b=r34BVzeOaZ85U2wZZdid9oq3NQq0RalNwrz2wUPh0ZKvKKAK0az3U4MqCeyBPcN6jF
 DPCo9uq7AQS0ejvbYE2OHaYHEfay8djKAyApBToAuGl1ksdFKIrnX9rJJ5/9tH5ZmuAh
 XV2Vnq6B0aLxJDi+aUFtwXE5CFRy/dgoO833ebJXHnWvqp86XzYK/oLp6Z5QnV5WbVek
 3+UDprAN5E7M2VpTtk7hQo2KTLMiC/JviB1dOfQrlHRKPlgjpmM3dcv8AQrXXxEpNXl8
 5Nq5aypWSauhHdkVv1XpxMWrSMVswdovnJeolNoAfsyoKP8Bh5oVvYbk3mZ8FZw2uBIE
 /E5g==
X-Gm-Message-State: AOJu0YzUv6EXvPTuJdaLaRZIMI+f71gLGV26WBai1PoLhQ6sTM97iqfL
 T6laIICp1rTPtMPxFu6ByREsNJkUeZB8ZpJObW09IsjB8/rvN37PkU841vwVVHzqItoBi5XuVEf
 KrPIHP+YSvZr7thoXx63grxCLfkBRDLNtqgkg277ebvhbamW6nYe8Dk8=
X-Gm-Gg: ASbGnctg4piYsl60eF80uduS8y4l4XVuUEG1dRu3CjKIyY5EM3Qx/aetll0/RpNrs50
 MYYN6kUJ3O/kzCzTcRar6XYdWtLrDt91GOrIDe0DuBQi/QoJbvAQTZiiPNizR5in7Fd2jG9iDIV
 9ApyC16wRw4X2PGvJbyPO6RBRDmHWyL2dCkW59dpwUKlQn8rn9JhYjcL5hVvhnk7Ds/RaRJF+Mw
 LAUNiVB7+KO1Gcr9y6IX3oigCc8EDz7x3rrQJu0GXZsZis+quVgVhUG8ht74g==
X-Google-Smtp-Source: AGHT+IHYmqL+bxt6ogb0eIlzXMInaulBTJlhfIbK27uh0nCjZcw+nJKp6osD6DJvU85HxjQqeHjl/ZWijTeIHXDIZ4M=
X-Received: by 2002:a05:690e:168d:b0:63f:a4ca:dc21 with SMTP id
 956f58d0204a3-63fc763245dmr3324941d50.19.1762277818287; Tue, 04 Nov 2025
 09:36:58 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Nov 2025 17:36:47 +0000
X-Gm-Features: AWmQ_bkkRHPaMhGxFZfMNMPvn6Hced-_H4gwsNcVvwstbdOpmX4d2Aii_32HnK0
Message-ID: <CAFEAcA9oUfFSFXrN+swbCtr4LV+S+-DuUjdP5miGnSbkCt2ZYA@mail.gmail.com>
Subject: MAINTAINERS spring-cleaning
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

I just did some analysis of our MAINTAINERS file with the aid of a
local copy of the public-inbox archive of qemu-devel, and (unless my
scripting is broken ;-)) of the 258 emails listed in MAINTAINERS,
50 have not sent an email to qemu-devel in the last three years.

Some of that will be things like "the address somebody uses to send
to the list is not quite the same as the one they have listed", so
it will need some manual checking, but I think this shows we could
use a bit of spring-cleaning of the file to remove stale entries.

I propose to send some (not cc'd the list) emails to these people,
asking (politely!) if they're still interested in being in the
MAINTAINERS file, and treating "email bounces", "no" and "no reply
within a month" as "I'm no longer interested in being cc'd on patches".
Then we can update the file accordingly.

(This was prompted by a series I sent out earlier today getting
a load of "address unknown" bounce-mails from a corporate server;
that's not a particularly rare thing to happen IME. And I also
have developed a habit of manually curating cc lists to drop
people I suspect of not actually being involved any more...)

thanks
-- PMM

