Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCDAF0180E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQw5-0003CY-B3; Fri, 06 Mar 2026 03:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyQw3-0003CA-8P
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:53:27 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyQw1-00051S-Rr
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:53:26 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7986d231b3cso117796397b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 00:53:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772787204; cv=none;
 d=google.com; s=arc-20240605;
 b=I49lfH66hAzkDn4uJ0x82YaDLFYvyLKiltF7kmWjAY8ltgOGBn9LzZs2jR5lZ9FFXX
 vAMC37Utmqeh8/wWkUQvdd0UnS1JrNV7OysMNJ+zSp3VKDsk9NJlBa0dIHwXVtKbiVKI
 NobfFetoaDIC6MYpHpUpM1JbvRxZQs6Ng91aPj6h7YVzpOIirfMRXU7m29ChM3yuG1xA
 2wAqqFlfad/zq2KoRDCU5aDURQjGc7CbzNzG1XqNidXsIGGIqQism3P2MGHsHlrJ2ykk
 Oah5/1or02D6IG6tj2IkHWyrCi9SpEy8K4FJFB63VaxsxipQFfD7KCJQGLP32Z2dYcJy
 9uLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=okanVdwcf0fNlQUPTwSZ5RR0AMs0V8T0J9NcTSkXjxs=;
 fh=YL0NE4lWf04jcNGWdUc9cgi/Lvh5AUmBxwt6lA0XDZ4=;
 b=CX3infGsPRz9deDohjMlKOhcVsasMDU99uJ9UPKjTqxfDRwFsF8joeT3TSejindVs0
 8hLRVuKCKKW1sXiU9MPUGTJxYyo0EUK4NlfivSECjC0/rMBq3KkBbnz4hfrcVJcj+Odn
 HGLheVNZxo4fVk+0a2dvQDTJJNwzacPRqDNukBREAkdiElpAdYNhT8xpfPN9GwDCzR6i
 tIt8PGgHubLW41aOZxyx1DWO3aJGJ8RofgII9obl532M59/RE7Y+MGyV9FJmhxXYYPRb
 pV58dkHZvq/Alb5u5dp3OaJ5jFtUF16r79pEedO6HySUGSYrta21ma3hxbLrA9ri1WfW
 dwfQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772787204; x=1773392004; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=okanVdwcf0fNlQUPTwSZ5RR0AMs0V8T0J9NcTSkXjxs=;
 b=exJZc741GlK6lRUAkMz96HtNQqdtohK9brHkNxNIx8FsM0vNimGt703YnR8T8BvI7b
 AFoUx8+G8afTPr3vZRbWiynmBHLX0X5iLgeyzCquB23pFIC1s5Mh32i93N6oOy2fELd4
 RbqTmRKUkdzDcMrV5O0BU1PBCQPCtGvHehQqIRcuIi9W7UnQZkqootYI7qg6xbSOPZTs
 KsJkB9qm5srjtoQFVrtkpfzfLAK0lw36m6A5WJWVhVuKsG7lgKT+KFEe7Z9gE866O1Gc
 HmFs4Ub24wpFFc9aR+QgMBmFNpAQcJxxWAdz0nagi49b72t7H7gyV10DaWwVnXfWynv7
 YjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772787204; x=1773392004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okanVdwcf0fNlQUPTwSZ5RR0AMs0V8T0J9NcTSkXjxs=;
 b=M+DoRGs1GVp4iUxCObcvu7gcfz2L213eykVLdGwlgNScrWxRnsZsVFhawOtJh8iiGt
 RN/HHl1PI+9krIugoN2tfLO7EdMkDPOlA+KfNI8MAa2yvvLTueHdYSFoUAdZ4ePFvEFe
 5thavc6iD43wT/7B83bif9bhSyyt37Tz4SHsgj5n5RiGdmDkQMYGJI/8M5/FEGZX0KhS
 ssg85mFSevRo5b00ATKN3jxF6h9+ovKJYEqixzwEz9GtWSrfnc4qXSEACHCjcC9o+azR
 ompIODyQ44f25lKvQdCzBjchzOTs3YHATSdrXmPdly6fY6Pqyxh+/3ZlVy806hlG7M7k
 /LTw==
X-Gm-Message-State: AOJu0Yyg2qe31c19UogOtwtqlYr0GzhHppn9riUJZOts5KkRvadRO78A
 jOpAWCgfknvOk0E14yPVSl+KfB0p1BaOCOFYGU8x+vZLHBbHL5UhsiBYuIQJ+wiJIZ+rKLZx97u
 em7Tyn/6EV4UEfBuHI+ULhCI7EsJ4QCirS12VO16c5g==
X-Gm-Gg: ATEYQzyUBbSWqZWHgf44uvMs3mb++axGjvw4lRho6yvJgVvxFnrlivsxhH0BwC8FiFc
 gL3yZlJF8YO3GKZHDXHtQ/np0/rC8fMSZdEiLJSWNENtLjT3RW/O8g/CwDbArExNCqcGQlBBtsd
 zp2a+PRHkfl9ELTAjdAtHjw9B+DV43H8r/KrnmtlYM3AnqOncuU9Y8BE3KWc8oBEcF/56jvH93f
 It7gNFKrhU8MOlQEUYaeWsCjJtLHizjL28Q7H4N5RQc9kh+UBijQicdvTFfcr7CSlZMSLpReVoi
 EfCntbbehSmuzqmViKDHFt0PRVqGUZjQW/AyuIvRc8L7eW9/WoWRdvwjEFThmjgOrwA=
X-Received: by 2002:a05:690e:118d:b0:649:601e:432f with SMTP id
 956f58d0204a3-64d070f58e1mr4798344d50.16.1772787204178; Fri, 06 Mar 2026
 00:53:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1772760714.git.balaton@eik.bme.hu>
 <ab3d9d449484c4597e9548bb8ffc4c30f3808f12.1772760714.git.balaton@eik.bme.hu>
In-Reply-To: <ab3d9d449484c4597e9548bb8ffc4c30f3808f12.1772760714.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 08:53:12 +0000
X-Gm-Features: AaiRm50N2SrN-kN8ysjiN9axmYqyMTuEtPRzFoMWt2sES4hZT9o1LLAennvdVT4
Message-ID: <CAFEAcA_uznfXsdqtgB+HS9qwXZxUoaj630e3aFc7XuMkA4HOZw@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] hw/xtensa/xtfpga: Do not use
 memory_region_init_ram_nomigrate()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Fri, 6 Mar 2026 at 01:40, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Convert to use memory_region_init_ram() instead. This breaks migration
> but the machines using this device have no migration compatibility
> guarantee.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/xtensa/xtfpga.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

