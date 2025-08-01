Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9C0C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhuPV-0000qG-Gj; Fri, 01 Aug 2025 14:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhssd-0007Pb-W4
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:45:20 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhssb-0003zl-JQ
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:45:15 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71b6d27113fso10865957b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754066712; x=1754671512; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aSu0Lh6UVCZWXGQ6NawRS/oExQyBCp5VkeGOgwYHlic=;
 b=RRQhIOGXIf2xHJ+hj8q+eZ9wfTo8ASmfQRZgtm8O8HBdyVaTbKDD8V1+lW/DpBU3Jd
 Ag6EVXgJ8XGVanhyHKg5z4KajwlDaYZRoBGmb/oc1UadctSleVkXLR8Z3pOLkeTDtAYI
 vYj/+Pl45Vu8sKO+AjRmaF7H3LQjjn9HrB3+wrJzBcHf5BwbtFDAQtfS7LSRCWBl52uc
 UAt+m6fJ4O1tndsd1ppRbJF5Xya2lMd1+ETR6cCPSH+/If+KuGYBQDqv0D0MZVDD9Ryq
 jPnTh1BMN2hRMzxqtR/8m/i/rbgRAMfNydBckaFXDkqjm82IjEQXnjcR2F2USAx4jug6
 z9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754066712; x=1754671512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aSu0Lh6UVCZWXGQ6NawRS/oExQyBCp5VkeGOgwYHlic=;
 b=G0Pvzm6mRJGDeuyrCH3H1kuZZnhWBC+50lzQvjWVVpVHIgOOEogmPrPOSunBho5NaL
 65QwsYX7ehWsKaZax9E3Od85nRkTCUa1k3Y++FDHTSNnqMpBfv8nPUSXfhUW5g9UBbUK
 bijUtf0hPnrnYMsQbMBvyR+UuTJOoHFKDXPV00KUxTfdKoyNWqf2d5TT+/QqOh0hniBQ
 DZzU+m8DuYudEHiSogIsvydLZ7fsZtOc5WYwO0peOhuP2tx6j04dp9InZ/mde1lbY4LB
 euyxalN/hgrwnnScD84ztukAmyf9rO5zwGEqy7+exS4q8aQxrX8HXFCkJEIfnNIQkgCO
 xwfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUozv4fPd8b6ooUBAODDHXPQ13KZ5x2zKG8igh0ncnDIW+lrSa88zGArLk+KHrhQeN0ke7CLXg1Cl2t@nongnu.org
X-Gm-Message-State: AOJu0YwU5BKA+28QvdSdZHhG2sRMIHEXZ80hPehh6HRa+cPCDkGOVgUj
 PHQcpyGnjytwysTf6hOD5TxYBV04EQiE8+++V1AW0tgclgvAohqt4mIMiPlTxDbaivqP4OJfBL9
 RyFnU03Z1L+kfjeK2xJfFnJsTtZXKRZxu+Rl4GYILQQ==
X-Gm-Gg: ASbGncvEQq5zMcvE4IemhMdBUsiJInsV0i/3aHhNNBVssXaf/KSv8wfSfsnCQnGpqFv
 BjmRXgZjI6C+lSHrmCDFf7kfsUfhQPyNsaHNM4o+CscTBV2u9e5Ey07x5umCF+rX/OvzLy8x+BA
 on+fDvFAjBWFNd13UIxRzO/ya3wALdqEUPnl0oNgNlZjzPqeBr+Fb1WCTAz/xsnIEs412oNipdB
 4n1qz/t
X-Google-Smtp-Source: AGHT+IFXEy0sTpmOlg0a7QU4ytKQxQ7N2P9DPIsneGqDHmDICrMICCGmT2x9s3wckFjICHzXkQ1SKnITj7HKJ1prrqM=
X-Received: by 2002:a05:690c:6891:b0:71b:4739:9d67 with SMTP id
 00721157ae682-71b7ed016afmr4343777b3.4.1754066712067; Fri, 01 Aug 2025
 09:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
 <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
 <CAFEAcA_9tkv1EoM33=G=zW6Pw0gBirvjs-SsDaC8ar8feyH_8g@mail.gmail.com>
 <2c337408-5caa-4e24-a8dd-d947203a1dc3@linaro.org>
 <CAFEAcA-LmS0dus5ZW6P+-VXkw=m4K3MaE6O+Qtj5i3H7ULJFFQ@mail.gmail.com>
 <cedc5b94-78e3-4d9a-bdd8-60c82673c136@linaro.org>
In-Reply-To: <cedc5b94-78e3-4d9a-bdd8-60c82673c136@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 17:44:59 +0100
X-Gm-Features: Ac12FXxTNpE5QMWuNIBTE0ckr-9NIXZc-hsQCOc3g7x47w5B7TKnGlJ6qi-g5so
Message-ID: <CAFEAcA8j7S6qVxmd8dairF=4kpn2=uBeFFxY22M5FgyTnjcJ+Q@mail.gmail.com>
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Fri, 1 Aug 2025 at 17:41, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 8/1/25 9:37 AM, Peter Maydell wrote:
> > We do at least define the fields so you get a nice view of it:
> >
> > (gdb) print $cpsr
> > $4 = [ EL=0 BTYPE=0 Z ]
> >
>
> Do you have specific pretty printers installed? On my debian trixie (gdb
> 16.3), there is no pretty printer for cpsr by default.

I'm not aware of having installed any. This is
GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git

I was assuming that this was just plain gdb doing something
useful because the xml defines the field names and bitpositions
(at least if your QEMU has commit 63070ce368e1a where Manos
synced our xml to upstream gdb's to add these).

-- PMM

