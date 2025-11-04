Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE951CCFA07
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJim-0003Hg-9p; Tue, 04 Nov 2025 11:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJik-0003HV-BF
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:17:22 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJii-0006CI-L6
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:17:22 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-786a317fe78so2286127b3.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762273039; x=1762877839; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N6nR/2K9cY3+SI3+cUdNzyMYZkm2xDvgsUkuGKj0bhk=;
 b=PeSDfJfaw4YIg/s61RVg+CD69HZd07dagmlsZvzdFn9njLIVkvAIhS6FlXjrcGCJKF
 0pbOmRGM/d5SQYx/yr5j5Vqu5XZXCvekX9ShnR9+vRy/ObipVoL+IMEXZ5WfTKuGmVrx
 d7XC8d1M0kpyxjZD9cn9eRFzH6f+8W2OharUosd8kaGWQqwcLYxKcau6cGy9OFHoZBfU
 9PYaG2lnk4xak3++aMoQXhViiwDF2L+8oNRqRLK05e8GlRvtSpET1b4j+lDbAxFS4J2l
 2TAAUvTquXn2UBZ7I8x76uFcATFDHKwRFMdwvYhbWoverVOWWqn2RHgJsC5rkeIHlb++
 fTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273039; x=1762877839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N6nR/2K9cY3+SI3+cUdNzyMYZkm2xDvgsUkuGKj0bhk=;
 b=bASLFOOTKdpk1DUSMTXBW40QACLT44Mvyo7xltPKnIsFG/mJ7hZuYUDpNzBUowNVaE
 OUN+aogupnhhvFNibrY39BdVvRrqLpqx4ag37kEBW6z6ZIvl/bXoMkvc09VmveSmHnt2
 w+ipdCpHiWjj7bKtHodrtAVcWPwv74Gjd3TOPHy1omlp0/v9DlDme9zXHysIkdMP0Cci
 nNmuVBc3fzQ1VOfosmBN+Fsxy6ioBQeU9dLCQB1Mta3BBNz0kFanNBfQv/fTqWLLyO3i
 9AFcSnXdB9bw30uhag0HsGBXr37pt91L/dICdw/5f2W3MeEl0/ISlpYGVoi3DlUOM0Ho
 zS6g==
X-Gm-Message-State: AOJu0YxeTZpUCj7X8ppz8J6lEYnGM7d/wfgaGrgWfZDskhbKwz/V9rDz
 DPgPQm40uBHETzJO1PyngyidxKmA6MuzgZzWhcWYtT/RTSTI36payX5U9zs5UogG6CoSFjHL5EJ
 mDhDDOGJVUWZpDH4iSIr5pcJ73iT50s1EY+olADoqeQ==
X-Gm-Gg: ASbGncu+zP9haziBQ38PFCZXpteWhEDegFWvrZCulWWbTJ9HhfVOkoF239Tqae6Mtre
 VK99xVSyBDMpLvDv5jc0fTzKFxTd7FNidUgAQWlqse3mWUZzPbGBEzTRKkXyE70tlPPvJdigumR
 duQk37y8LKmif2Zd57CinUB90Whi4JgoCw79zyQwL1x1aiseWH9PH7KURa4ElVqCZBFCFekAnJl
 euzSq1k8I5YtGc/JBBDmpw20k4/PgvdT7RGXJP1oMOhFaZlw3Vz9UWJhfO5HA==
X-Google-Smtp-Source: AGHT+IEQA/zz1OkKWAJjUZ/uTRsiM40/IdTiRWnDiL3N9O45E9ikBGJ4O/38yyKOW5BISftrMIgzR7W2yc4/v0LxT/U=
X-Received: by 2002:a05:690c:2081:b0:786:6383:658b with SMTP id
 00721157ae682-786a41d32b6mr113827b3.46.1762273039418; Tue, 04 Nov 2025
 08:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20230228113926.11485-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20230228113926.11485-1-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Nov 2025 16:17:07 +0000
X-Gm-Features: AWmQ_bmnenLb1jgyqO-h8dScu_xe7WMIATgbA_sN_1Is8wPZVE4sP37SKfbNhok
Message-ID: <CAFEAcA_Dm89kafy028KWjbtxTRdCKLgc4KGCPJwxLdXf6monjg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Fan Ni as Compute eXpress Link QEMU
 reviewer
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Tue, 28 Feb 2023 at 11:39, Jonathan Cameron via
<qemu-devel@nongnu.org> wrote:
>
> Fan Ni has offered to help out with QEMU CXL emulation reviewing.
> Add him as a designated reviewer.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> --
> Thanks to Fan for stepping up after I requested help following Ben
> stepping down as co-maintainer. Fan base been active in testing
> and review recently so great to have Fan on board.
>
> Based on patch [PATCH] MAINTAINERS: Remove CXL maintainer Ben Widawsky
>
> Based-of: Message-id: 20230220212437.1462314-1-armbru@redhat.com
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ea56c6ccc..838e1a91a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2633,6 +2633,7 @@ T: git https://gitlab.com/vsementsov/qemu.git block
>
>  Compute Express Link
>  M: Jonathan Cameron <jonathan.cameron@huawei.com>
> +R: Fan Ni <fan.ni@samsung.com>
>  S: Supported
>  F: hw/cxl/
>  F: hw/mem/cxl_type3.c

Hi; I noticed today that Fan's samsung email is now bouncing
with "550 5.1.1 Recipient address rejected: User unknown".
Do we have a altenate email for him, or should we remove
his entry from the QEMU MAINTAINERS file; and if so is there
anybody else we should add as a reviewer for CXL ?

thanks
-- PMM

