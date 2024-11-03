Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF64E67819
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 01:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7PAH-0005FE-2o; Sat, 02 Nov 2024 21:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t7P9y-0005Dy-77
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 21:12:07 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t7P9s-0004zX-Vv
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 21:12:05 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5ebc1af8f10so1351731eaf.2
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1730596315; x=1731201115;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IgUw8x7fM51katr1SstixBuiUoWdlPScOheKCr/xbAM=;
 b=uECZpFvHClm6UhKRBzjbZlSBvzr/Dy9BySF6FMLX81QahGqKMnvIgkfK6ySQdJZV+E
 6W0ibhJD1anK2+ScTgaQXqRCxePM1dDXYdZBiRl+7RnaWKu72Dmu9vSyrpCKLLIw7zGB
 2PCadLdNw6ElztFJoQoyP65ZWIh4Bm892pXtl3ct6ET/lKYgeDGSCKOn7nO0icrY40Cr
 f7rUL42hAlogq7utz2Y333JiPkuVtcSB1I8uU5VvDjoU5Qj4slsc0kVraZCZznYl9rXg
 6fmfb+kn8f3gnLKvEEz/aYF5RIvxQtsGUdF6OPM3jmwIZ4Kv1TMUFgIANbjiRioA4F2I
 DSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730596315; x=1731201115;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IgUw8x7fM51katr1SstixBuiUoWdlPScOheKCr/xbAM=;
 b=tdXBRzC/hHsJU7Tm4axRNw97QICvqD4oSQn1+RvhqMZUEG0UEYj8jQToNcRtqPQFrk
 Zb0yNbnK+vbRJI0kyWnONPttnFm5RXAjYhtrh0Cb2UKxQIYeRjp6phhSsI01z4+iVTps
 fYY29HzNIIG3z+KxTBp21RwoEq54XF/jZ3oYOyQLuLEQ4s/lRudOwiVGjtdKML+RgezV
 BUqryYcCLYYKYf5VBqc6GEt40ujGMbOdI8Gj+VkrcJdWzG5ftxMh6g+nagv/5ClAF3SB
 cGdQBN+CRDwV32Qx7Nd1dyoJ/2RMYjbJuwHXE1YcVuTzhMsZ4gpUFKMplNJPLzOWwiPZ
 LGvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7XF80dWjADbIKfXK/raolUGgsOZLGgvpvvJD3u2kiMQgVfkjXvWRtYfxo2zqQZuh4PE6+J3xW3G5e@nongnu.org
X-Gm-Message-State: AOJu0Ywc6YO4pVPMuO+jeNi3vgUmrID2ABiNpk3lpcPp4DKYHo+We4tt
 FRywRRnTXcCDcG5vYVNIVB1NDwG/52D6Y6tbRJ/1wKjX6aNwVKWUPee9LdziVoI=
X-Google-Smtp-Source: AGHT+IGhCyS5DAGGqVJ+Wqv8gdcaOyNcQvc6hCfxdfOXK3NPcq97RH9tn6dJC65LDfcRv3s7g1dqrQ==
X-Received: by 2002:a05:6808:13cc:b0:3e5:e4c8:cd34 with SMTP id
 5614622812f47-3e758c46feamr7477206b6e.25.1730596314842; 
 Sat, 02 Nov 2024 18:11:54 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:fa3e:9c23:b11b:a3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e66123f0c2sm1469672b6e.45.2024.11.02.18.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 18:11:53 -0700 (PDT)
Date: Sat, 2 Nov 2024 20:11:47 -0500
From: Corey Minyard <corey@minyard.net>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v3 11/26] hw/i2c/mpc_i2c: Convert DPRINTF to trace events
 for register access
Message-ID: <ZybN049e6IiqT93Y@mail.minyard.net>
References: <20241102131715.548849-1-shentey@gmail.com>
 <20241102131715.548849-12-shentey@gmail.com>
 <ZyZgjZMmqy2WHqip@mail.minyard.net>
 <f8a83ecd-a768-c648-d790-feb1e0b112a4@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8a83ecd-a768-c648-d790-feb1e0b112a4@eik.bme.hu>
Received-SPF: none client-ip=2607:f8b0:4864:20::c36;
 envelope-from=corey@minyard.net; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Nov 03, 2024 at 12:08:22AM +0100, BALATON Zoltan wrote:
> On Sat, 2 Nov 2024, Corey Minyard wrote:
> > On Sat, Nov 02, 2024 at 02:17:00PM +0100, Bernhard Beschow wrote:
> > > Reviewed-by: Cédric Le Goater <clg@redhat.com>
> > > Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> > 
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> 
> Did you mean Reviewed-by or was it your patch that Bernhard picked up?

Sorry, that should be:

Acked-by: Corey Minyard <cminyard@mvista.com>

> 
> Regards,
> BALATON Zoltan


