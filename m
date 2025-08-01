Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9AEC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvlb-0006Sm-2L; Fri, 01 Aug 2025 15:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhuC6-00009C-0b
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:09:26 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhuC4-0002f1-G4
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:09:25 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71b6ab52e8cso13355727b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754071763; x=1754676563; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zi8B1VkCTjS0moahny280LLMYoJPiYurgKrgFmjpWk4=;
 b=dHRfs72gLW4U9dQRLP6q+f4vPpbHYnuvlM5THvVX/JPwqC8aCmMSduFnytXJ+ZIRil
 5jrB7IDqwNbrLvclJGET2E+3+IZm3wbZgBgH8hdBH9eSeNRxtrig7OLwQEQWEGikesF1
 7//kkxSRO9BIkc0tLCILAinqYVDMuJuOnwWJJ5koAhLcKW0pTaAQE9QAyMKjbttD0c/4
 PBn3jbytxoVIzI8RBICS3vF7ZJUuPdd3dBQTZVSMgxesKH2YcMzbAfdTmoIJMU/DErNS
 fRgr7GcHGYNmdmwb2BfgNOhO6DmYu6BdGZcmRyCM0lwnoAmIBTdVbOtXl3JEg1AydQAe
 iBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754071763; x=1754676563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zi8B1VkCTjS0moahny280LLMYoJPiYurgKrgFmjpWk4=;
 b=IGka7XKDaFsB7W5NryiFzVm1JntsU6RiwxkMZfrAVen+O1qvh46OY81iP35MqOgis0
 HB7Nv+BW+Yii4ovxsRSn/ZYTLMHEUQvGQ6bc37k4PcJSApzQi4FGE2pqd+CvJAAW7paX
 e6qCCTO6DMNm0175vHyckdr3ZBHGQWJBc9vZgXUPFDvgYWZjOT1YQiPahe6agpj2TqKQ
 LNhdmBcX8F5UBKoCFOv1V2Kc8TxkgjjGYq6jvfGWoNE5WyhS0PK7tfFWuW9wrmv1q6uL
 eX7v7VRi9hXw3wnukN4+OR29yOThn7w4MNRgjdfBJ9ii9diW5ncNSFPFNihywmLtyr5G
 UsKQ==
X-Gm-Message-State: AOJu0YwMqtO8AQ5dQBEp/qAl622omTWqed661lk8cu6RH2UcObQsk/qr
 SXeQiMhcP1A6P5JWyfJECM3iH9v+hj+/yG7lNJ18YacqvYkMOHmjkjxDE7FY6cOOgCtJ+mVlGob
 36K/2uTxnpgOGJ4xxfJVv7tkd7Nt2gelkHaGq1ytXqQ==
X-Gm-Gg: ASbGncsPxYZQepY2lITTctK4mADMxZ2t0fBpxilXngov9nfq4Szp60DxuZmJFzOtDEs
 yUTWpRImcwKWdaqhfQOT+w0WAlGTZ280qi2bzNMO1DfiY6nvaf3zUnlNZMLOrymmnQQ4/cZ+Y9C
 aOnJOVbeLzdLGf4Tn9kpk9UzXPb3PXywtirBSHm4CBJZ9znXqLJBT74KOGmyhVBmIeUz+EJ7BFH
 h/Tessp
X-Google-Smtp-Source: AGHT+IH7FSbcNsP6Qg+Q/zGoT9N3MAxulAsa6QpszsUjBFMe4bv/AxOng3lW6idzitApGzeH8KsxswnDQvghkpWQSWU=
X-Received: by 2002:a05:690c:6407:b0:71a:51f:81ba with SMTP id
 00721157ae682-71b7ef858e9mr10314527b3.31.1754071762646; Fri, 01 Aug 2025
 11:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-59-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-59-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 19:09:11 +0100
X-Gm-Features: Ac12FXyXoA6aCKtHA9l6bgocmFAS5e43Jk7M4Tm-qnCtTxkWCC8hQSz7JZh0bGI
Message-ID: <CAFEAcA8c0jTdw6kMp3f-F_NupAFqEK1KnwFmHuO4avoacBUccw@mail.gmail.com>
Subject: Re: [PATCH 58/89] linux-user: Remove INIT_GUEST_COMMPAGE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 30 Jul 2025 at 01:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Provide a weak stub version of init_guest_commpage
> instead of using the preprocessor.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

