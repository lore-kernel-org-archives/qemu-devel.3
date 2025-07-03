Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8948CC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 07:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXDyf-00083X-Bv; Thu, 03 Jul 2025 03:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXDyZ-0007yZ-BS
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:03:19 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXDyT-0002F0-1a
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:03:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so40080195e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 00:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751526187; x=1752130987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6f/NrQXKxo1H8GNh0j5wdieBWLWa/5wRgOkRobnip5s=;
 b=akjdC1ad2AraxvxkX15JiiJRYSSJHPBk+v7mZr3IIH7WogDz1I/jORtYc8qavhgfbR
 zqGn4ErMVr1EEAyK7RhsDxAww9SCf1rtILxG8a16dZ9krQBwUqFNpTvWszn0WHM90H1I
 MMpS3YsprNENoIwi9yC1WKMR8IklHg3Zu0atGKVtlK+2rFiVURrLlmTyeFhxo15W+1Ff
 EtYBn6TN9UAiuntyHrvvs/zXqtB6e0WKWAk9mwmht73MQxknhSvyrQ6ltDJMYQaGKZ42
 GcO9EajNWMIDihjoFEriV60hYFozwQTcchSu079I4D2X4hp+Pdx0admjrp+5AqsgnUvG
 hACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751526187; x=1752130987;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6f/NrQXKxo1H8GNh0j5wdieBWLWa/5wRgOkRobnip5s=;
 b=pqTSeE+y67kpbtR5PCG6gWmkXjyqEpuuVG+ZbCIP+lXT0ISrIL2Dl9OfhpfEk5B0kt
 JsUDvKF1aEh6r3canwKnFi+oCgQx3KgJykpeDnnkn6aRjnGQoa1dxHMs1xIVt/ZQt5jY
 6FpkuZNOcYNehYtRBrHvlaYjHeuKOsvYGkgzYyLPLmXUEfRykzzXwTPdMOZA0JY9m0C8
 ca7iKP1A2XFKfJg+Hh2BJMmaMTfpyRNwCrk55KfcjyQ7IxH8aVUgqw2YQzDZGBKDVcle
 6yqf0m/TEYzbjVEwY4F0xsxRXcGscTpI6uU078hm5DAoEbsOsBk8GE1R3Bs5LbWb8e24
 /Q1w==
X-Gm-Message-State: AOJu0Yw3um/ltxmmJcbd7pISDEBLvkXmV/QJsY9ypcQDTuGWQ0rRzXrj
 4JGx3IykTIdKGSYT19GUOsJIMG3OazGRALz+3h2AtGAFyDBxMOntnUjkp8MdDsqW7FQ=
X-Gm-Gg: ASbGncviYhMOqRvTRRPz9fIbqVejDDAaJyO0N3+OFL/HRaY/zDfndybvIz3mto/HqQ3
 qlV+J2GQgwVZsHuDo1oxLWZ8Kf22VP5/bJqS7flsA49LavMQtlEvT/SiJOLk1RBEZpkepJjCdK/
 ea1o3bgUa1aaSSKtUGtiu6PFygUsXOKUd7H/v3Zn12YBw8qocUGETxBz8Mb+FK9asxvAyG4F65B
 mIpmt2lWsAO7teGHbYuvWr0u/y3K0EyR9W4JkmIKkq2tVZ18VhniK5wWnAfYoA6bkevfiKqoQIS
 HqTNe9b7w326zbkXNfd514SizjOldn36GJZPSlLVb2tOc+xPdjvkw4le2AwV7Bk=
X-Google-Smtp-Source: AGHT+IHw1Pj6iDT6IfXr7wLQnJR/TcyrhdOjruspMvC2e/tWhC9pFzuQeSo8tG/9xbSPEK9zxFKhMQ==
X-Received: by 2002:a05:600c:8715:b0:450:d07e:ee14 with SMTP id
 5b1f17b1804b1-454a9c9fbe2mr23900505e9.17.1751526186767; 
 Thu, 03 Jul 2025 00:03:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e595d1sm18010721f8f.71.2025.07.03.00.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 00:03:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E6CF45F8AE;
 Thu, 03 Jul 2025 08:03:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v4 01/65] system/runstate: Document
 qemu_add_vm_change_state_handler()
In-Reply-To: <20250702185332.43650-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 2 Jul 2025 20:52:23
 +0200")
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-2-philmd@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 03 Jul 2025 08:03:04 +0100
Message-ID: <87ldp5dadz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

