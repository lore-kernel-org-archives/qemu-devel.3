Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2B4CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 15:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtYE-0002Nl-MD; Tue, 26 May 2026 11:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRtYD-0002NL-3V
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:18:37 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRtYB-000807-Er
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:18:36 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bd21ffaca79so1980876966b.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 08:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779808713; cv=none;
 d=google.com; s=arc-20240605;
 b=B8wAHXFSSe8I6buw4jjoTM2fBZlDuhIUQ5d3v4n099krSj/RLfrYk8HCsr0bkc+hXR
 eS2QD+FWKZwINm69A7vLZM6htE0BXluz8EvF628yIuQkdRaDu7zaqtgQ7m/VwRYz6yph
 sNXEs0nmG0XstbdQNy8qLcmSgFAqCuvjd8Jf3Zd/KzZJh9yVpK6n6+i8YU/X4Wcju6JA
 hTJnDFX174XPNteDp7KXvLD0S3jZUOm9JA71fSOGCiU8A0gUxllsOQg7e4UhLwgukKh5
 buB594oQfTrNBH5/54si6mOTVoiQj1k5VVN+8ITURK3GXoZCt7Vf2RYDNhhA6FOYWsRo
 Sk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=IVThKAysnnJFckUmsvjGSuR6FKYHsCUmETx/QObSKsc=;
 fh=Q9dsMRTk+dymOtqMnm4zjFnvJsI8ndl93sYRZpilaGk=;
 b=Yw9vynNyLdxqxYfr4lDkNBdqujsaZjTxjOW8iVBRh2Z6ne0uEU4N1+K/9kpysubbj1
 qN5t86RjnjRM83NnUGeyo/ueRTGMO5vWp4cmqChrLHpXO7x5Oiu0FhVDx4mzBU0RByeb
 JYtbhJt2UWgcfhzxnlssXCVA7R89ABh2sQJzDsoxGaxrvXl1DvwXrtLV9PkG/90dZrjf
 473vznS66KeWX8/f1dZ83Xa8y2oOI7iQCVj0Bv8ykK3E+eY6Em1+uH5P4umJpSYe5sm1
 7KLngSabc0ExIFQnQLkGrEoDXI8FLNSEBwQowb+8wQJfn5mU91ZouSsLLfkMcPiWCQYj
 9z5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779808713; x=1780413513; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IVThKAysnnJFckUmsvjGSuR6FKYHsCUmETx/QObSKsc=;
 b=Qq5B7SiMYZCU1t9qT+7RpLYJLYRRimn7OB2d8LTq7o2WWOy/87waWaqEKziBVDT5AN
 maEHFzHTABG240vKyf9To22QrUrjuO4hJGSbMZPGoB6PB1/QbHJwLdl5mMgW5v18Yzde
 eFIzZkFcb1/DApuXJVfDAukvlLqXF5hbQ4YaXTt1YwcQhLFqU/63CkfiiK4CmBXnob1I
 TU7LT5VoEebqr78qy4BAz8kLbRpiMM8icB8AOncULnSV+0P0vW8QI55GH4R17FGIwJ9s
 Vf/A4wU4+NPJDu9YJdA2mMd0xvmh42zj/mjJhgghDtBXaVDuYOo1qM0pzEXWPVbjPB5X
 JI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779808713; x=1780413513;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IVThKAysnnJFckUmsvjGSuR6FKYHsCUmETx/QObSKsc=;
 b=TJShIM2K2zYgYcGCF7YNZ0N0OFbOboqab6CGlPhzB3wYBP3/E8R6LjqvgcNdCIFFsb
 LAB12hgh0BpTICFphybpNjudue7bGW5Oj0R4urkm4sCjlV7hBtq3n+rxTx6K7j2ZdXPe
 reqbEC7tP5wzvP5QYGsRMbNWTA760wZh3dIMKNe99wX4jWfJUxZY80EjWkQM1SzE8HHg
 mYDnzRfdcS+Prwt95em2ury2+eh3CYZBf2ZL6thFQJylMhkAIm9Fis6u0PJQliHvo4+T
 M7miLgkRW1UMZnBrUAnvn1L0kvbo1yr2ZgF3E43xR/y41uJgLENTluFyMgruvWUBte6e
 A1JQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TcutaPFjJbHmLvVS4KlBtmmfn9iRI7uYIBwubc0Kgfuiu7PxjaaIvyFomogyFgPzWhNJZOXpIAJaz@nongnu.org
X-Gm-Message-State: AOJu0YxOP5eWzfKquH7bSekapm0g9nPu6tYagFABQ9KzY0Kq9sFL3eF/
 tDvfwZoEtbX//Kh2LuowUZRifj7r9VNbUZbSxlsfZlFJuHCKy3xZCUsTdau4pIsZWFW2PBOdwmC
 WtH1HQHcn1mX9T5zm25ARqyQof9C0dm4=
X-Gm-Gg: Acq92OHfVzCrabbB6INn1PSR7gDg8zp3pdiYv5v3Zmwk1buZgXRzdu1w7I3xztFHzIV
 0pShlcScYyL1+wfF/rtBf/u4WdOH1iQPYDSbT+Blct4nLTGMEO9U4BCdamBYg+bKbu1tIt4voTg
 v5lqyWFY1a5ttFNj5bbi4fmlT3LWVrUODQh8zHx1AeNEldCxAJPTSwatjCeFPqfwWLK5g4CEhYm
 3qDvQ0Rh8inWfRAryi5PKwp3A3KUXO+TxDwhNG2zoE4cvvHJxQm8XZ1R9Hy5yqLE7aVCJeFbsMP
 ifalAG3wA/sOwPBsZGBP6wb909YZw2BQoQsxL3Ggig==
X-Received: by 2002:a17:907:d0c:b0:bd5:1ad4:cd73 with SMTP id
 a640c23a62f3a-bdbff5847aamr1261485166b.2.1779808712913; Tue, 26 May 2026
 08:18:32 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 26 May 2026 11:18:20 -0400
X-Gm-Features: AVHnY4KV-RW43o2de8E0eLWRRI-elwwObzNOfbPqlrIIjU6dFY3PDA0bkNLIRnU
Message-ID: <CAJSP0QUzgvjca16p+HXJTtfbBiT4TM7t6CWYusCwrEAyTWCFpA@mail.gmail.com>
Subject: Migration broken with libslirp 4.9.2
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62a.google.com
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

Hi Samuel,
QEMU's CI has started failing migration tests with libslirp 4.9.2. An
issue has been filed here:
https://gitlab.freedesktop.org/slirp/libslirp/-/work_items/94

Please let the QEMU community know if any help is needed fixing the issue.

Thanks,
Stefan

