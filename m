Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66383CF6499
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFJM-0005DN-Lh; Mon, 30 Sep 2024 08:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svFJL-0005BD-5p
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:15:31 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svFJI-0001eK-4O
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:15:30 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53995380bb3so950522e87.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 05:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727698526; x=1728303326; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D4ok94uWEvJdBWTe7Mk8PxxA8lDwoZJK5LnhQjRtM4s=;
 b=wBWL+SuUYyO5H7n+qXmr7Y0RdVHaE6PirX41iwl9YdhYSKCkdFgbR/VpMYXGIS5r4a
 MVeMiE0brW8sQLaT+VJ6hFN2gNNr7lKA4DlLmHxUMZENzQRMH7F1Z9EN1xFcebrRUVYX
 DgHLlae5aKL07kte+50U+KO3Ph53DNYb5PijIQJktBD8o9wJDPgjMN7wcNyZR2vxBxZv
 PO50bzfEbxx6CTf8v6SFwwFMznDHc9g7Xv42e+N5U9pq4s9ZlW4tURlo1zEkXTqA+tKw
 +AyXp/WNCcLmsMR5nqIqNbUFPx2vtMw117A6iHqrKB2aHZIzXXvIapRrCR/Zk/ZX2f9L
 TkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727698526; x=1728303326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D4ok94uWEvJdBWTe7Mk8PxxA8lDwoZJK5LnhQjRtM4s=;
 b=lAllAWVCrHtMhDyu6dfdGHgJK+GqsfiNEVUQ3qr/rw26zQUHfqhR2VtGsEM8CoSVVn
 /cnO8gT+l9ZdfYHNqZDHBzfjQsibAb43657R2oxzCYR2kEC9lxxkq8zfIT26z2n0AKJ2
 6nGu0Vr1hNC5DvEaFpdN9dj9fr8lJwn5IQXCgqnZ9h8uGsM6sA6fXsN9K3KvKjqG7cUG
 4shGU0Ta1kmxlzQcuvA6DHptNtwStqMhxj3Yy8048OZrXhxyrP6BzLcud0aPY7vIhZWg
 oFedihvN5Ifqp5aUGCu4x8FjoIL6es8dc2wYW6pdNtBZW2JG0pSY5WaP+B3/FIQ44u8O
 w0OQ==
X-Gm-Message-State: AOJu0YxHiEMQGfBQcxIAofXN6uL7EDD3+1+dCmww2iEMuZZmwoxzKBm/
 ejx0Su9GyD6CLlxOMQIfXODw/ifxmnt9dCzcnaTlIGozCfrMvf3ngxwcaf/+KNcmDuwNzXTgeOJ
 MW1/bDoDEbMNcpoxZemmi/aWBOUaXqjlerVyHyw==
X-Google-Smtp-Source: AGHT+IGPTc42htggXIPMVmBVASqed3nKtfyMKF1TOfWaYQ7m/oWnib0bd7GKvk+4iQ/Z0Q/0L2XqvuG1tT/n05VwiRA=
X-Received: by 2002:a05:6512:334e:b0:539:8d46:4746 with SMTP id
 2adb3069b0e04-5398d4647aemr1814742e87.60.1727698525966; Mon, 30 Sep 2024
 05:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240918103952.1985232-1-Shivasagar.Myana@amd.com>
In-Reply-To: <20240918103952.1985232-1-Shivasagar.Myana@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2024 13:15:14 +0100
Message-ID: <CAFEAcA_1fXs9yRn1dob0SK4qiR_uS2X=xSbWvF-RuNNwhCvT3Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] m25p80: Add SFDP table for mt35xu01g flash
To: Shiva sagar Myana <Shivasagar.Myana@amd.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, alistair@alistair23.me, 
 francisco.iglesias@amd.com, sai.pavan.boddu@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 18 Sept 2024 at 11:40, Shiva sagar Myana
<Shivasagar.Myana@amd.com> wrote:
>
> Add the SFDP table for the Micron Xccela mt35xu01g flash.
>
> Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
> V1->V2: Change subject and commit message
> V2->V3: Added reviewed-by



Applied to target-arm.next, thanks.

-- PMM

