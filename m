Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3878CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 11:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7BUS-0004I5-0c; Fri, 10 Oct 2025 07:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7BUP-0004EZ-D5
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 07:40:50 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7BUF-0001Gh-1I
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 07:40:48 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-73b4e3d0756so22960497b3.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760096428; x=1760701228; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HnAnwOcMJ2GhF2EY4pQnKOYtxUCKD6UQqaNJzNgnUHw=;
 b=sDhPU8c1NpWvY0yeqNrR+g1NDXrX6reEhjj7K/cKSxJ15JNoD0PPN4Y4OyzhiDzNtz
 Bardw6dearDuCcYvetsCJA7bBJbibpYA2USfmiKHL/aakgT4pvMuKbL0O8p3/LW2PAa1
 JZp9yPzoxzJPRwJ6hgytXI2dy5EcCmSzGJ7qPqFcjaMZgjXI16axBuFLJ/9MApkGNI0D
 ZpatYZLmKRzYZ6EhVv0vFA1zR7ZTSS4eB26M5dUtetMVqI/fzJA6g8pX/W7OraCoRxXy
 BzhYgF0wnM00BmYIQvbpCy/FRQGtu45oOLfcqoBhUaPfiiNA0w8XgB2ZqjF7itGTjSDp
 bbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760096428; x=1760701228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HnAnwOcMJ2GhF2EY4pQnKOYtxUCKD6UQqaNJzNgnUHw=;
 b=unPDG7RwNTm+6H0gOoS1pfKsMUSOl5ghgXPhVhMy1XJ6oS8U28eoBLiFSezZykUmmN
 SyuS7TCumrYpjSNcu8D05+1azf6OrDS555udLwfZYulftcpYGQHPwlRnHuODNm+kv0/v
 wi7gK08mJQrJzDdQFE5gziweIzk1o/bdnZbfrjE2iPyHGYW+hT8rAqTAjiu6ikArKgaG
 KYmUWK7QSViA0NsyGyCm9UlPWB++wBUXFlLwE8MXvwUUxqzgmuam9PWajqYEiBKoqMi9
 ba0ZbACbb2KEg8Wy+tsLbaACVvBG7W3FeR/4CTI+4qvkbkW8unTF5ipRQlpV4WleHzwz
 8Yvg==
X-Gm-Message-State: AOJu0YzF1AjS6v+AY3C573oRsFZZZEGWPIHSgrLcPnUHfkcgNwxBhAdl
 wRf8fbZVdIyfpm/E6u9HjxWO3Aj1s5glNftN/GfuT6BXn6jYOeh/4QGDfCn17aOed+uht1t92w3
 qYr+8/xVmYYr4b49GX2ui3I5Ozxlk+j32jXRcbVhRdBPsc5x/PpuL
X-Gm-Gg: ASbGncsDUEjEFh7syJReFzuMmF002RhYWpfjlwyVAySCEsX0+3VR8dsmr1rciOCNd3a
 chvhjSDtQrLQw9sfK/a59636pCTha+xuSJ/doXjp9stwxINMVZZrr6UWxOWBFjfz73r9xjTnWk0
 7w8XuK5t4ESiilp7Gr3yIFQCh8Kc2SJv9RgUp6PvpwvZDv0+GvGoIXIYdKAoA4r70BTqt4zR4rF
 5+iHch3FKMf7XknryGJE37IRqoy+HzIq5ykgVszwQ==
X-Google-Smtp-Source: AGHT+IEINEgWdW1qUku5Zgqhfj0NVzRiaFdLkxrRRfaPNjgpgSNWtv3kou4F2O6kU21QJaN0HwV40JES7D055SkfB+8=
X-Received: by 2002:a53:cf11:0:b0:634:94a:3e65 with SMTP id
 956f58d0204a3-63ccb90be3cmr8115537d50.24.1760096428041; Fri, 10 Oct 2025
 04:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251008215613.300150-1-richard.henderson@linaro.org>
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Oct 2025 12:40:16 +0100
X-Gm-Features: AS18NWBXaKeo0bDbyrVK7r5h8nDWBqOASsFvw7b28occxkzmsDBQRC-LaFAu0HY
Message-ID: <CAFEAcA-q0aB1wTgZrDwk+wgrZK7aGkGv23nmEGxpKmUC31y2Vw@mail.gmail.com>
Subject: Re: [PATCH v7 00/73] target/arm: Implement FEAT_GCS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 8 Oct 2025 at 22:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes from v6:
>   - Resolve conflicts with master.
>   - Fix size of TCGv cpu_gcssp[]
>   - All patches now reviewed.
>
> r~
>



Applied to target-arm.next, thanks.

-- PMM

