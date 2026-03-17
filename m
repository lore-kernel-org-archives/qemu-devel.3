Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BB5FED9E7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2WwC-0007B2-Kh; Tue, 17 Mar 2026 12:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2WwB-0007Ar-L3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 12:06:31 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2WwA-00014P-7d
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 12:06:31 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64c97997b0fso4446476d50.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 09:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773763589; cv=none;
 d=google.com; s=arc-20240605;
 b=SSyFLpIncgUa3cWVPfnJY9Lw1hUI0zpuH2NfyLk1YDJrzuK2qWdczzX/E84D7wqaKC
 949BKmkqbapqQtdQ9tM6vm25Y3YwMLkK9P8Pw057j1xTrGGCWeBEMcxjAweBPT2wwuq2
 E6r7bH5uHMu9VP4pd1rs8dQ4AwY6FWpRS6KStqu+vedXFvvYa0savc8FH2P/DxQt37Mm
 r/qEfCWcvzbY+SjZvsTKwNySF6yhGSDSJ+9HJyXnsjPbsVz0Uu1e6I0YlGQLDdUlF6Xv
 TGSbh8YHCMpwTdVjGL8xBbzGew1t6kHSuIZ3CI/NKxHfqBdO5vua4h2ECzTGXNp74Za5
 SYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J8xyU+BOMRkwXsRE84GBkaGT2/ohX0Nw2sC9m7rxQcs=;
 fh=lSj/1hQsilLqqrIQB6s4Q1wh6081l/JyVKvt7e1AODI=;
 b=I0oLhd0hTA43qdeQd/dFSCNVk1f5pFHugjzOtn6dZ16WMJORlM6avSL/9fIaUuZ5xp
 D4+YzZAw0AM1WmHwL422Kwd3NXLpK0nOepGkQ5iLWgOx7PE4+A+l1sRj5rc4MxSKRnQa
 NJDHZND0sv3i/kyyjt6e8aLbaKfX9MuNEk2E33Jh52go2ci+imTHlQWMV8hUjZ4FSnnZ
 dq0GugHYMNKqpANz6KEuSAIPW9lC8bpXdsAuOPzSODlhmhtvxVTWr7qMAlV0Oxff3cI0
 lGcxmHwCAZJmVJ0/Mvrg5B6SiKNR68KAmueNUVxirQ59A5Sa94AmMerzOXMgO2klz+du
 XMjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773763589; x=1774368389; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J8xyU+BOMRkwXsRE84GBkaGT2/ohX0Nw2sC9m7rxQcs=;
 b=tA3i+nJER4FxGesT/LwQfGmBAfikQbFSl2p9mpCwiTRvM8YiNlKthAMIYR5mRgAnis
 bm13RQmEpulTRAggrTG4LVwV6bwX4hTywIcyqhCF6/xKraCaK8ncreNo/W+JhOmFMowP
 e8Rxst2G+GNLELhELVevgbrwrZY91So6A/XCUyRL8zA0CwnH1g3qAHaFPYtqbSP/lBBK
 3ahASI1R+Hkh7vdi1ThisVVwU4uT7D7+4/WIexQOAk8Q1IDydHfhSZXjesoHptiGvFeA
 DPWj1Bmg/Y/yl4s4CFqg0mBMwpzdNR4Y8eU1/BN+H6iItLA5anE1BtKtXRnP32gdmqP9
 WrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773763589; x=1774368389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8xyU+BOMRkwXsRE84GBkaGT2/ohX0Nw2sC9m7rxQcs=;
 b=d0Srmiif7ubFm0c4TMbWn/XTbfM0kfDqrdgpTukMvpneuCDH9Utdlq+zfatGNyZhTj
 BOGmzMSOyoC8af32k7OZXAXGKKK+yVenldREf9dc8i+fEAR3MJDiaMXL3xi3GqHkoXDj
 WpkgEKP1w/3BWIf78Ws7KCNJnfI9+UnrdGiidWymX5UKe1v78ZN0FCLH3Udy1BgHJ6ss
 EHV3DoGGQSpavV6wD0KKT2l5/HDvuEoETNDrZgchDAVzG9cegltWHILfBfh5rJQ5WTgA
 oud5sLmLZ60+vnh3wJilam+FOOoPhD1fYN1iXcqktaP0FquZAADX6WtoeUsNjU5nAmZN
 hmRQ==
X-Gm-Message-State: AOJu0YzGTItSmDyYPQvsq0MFYgAfS1NtQqPZvjpoDyYyLH1/sOxGAwhY
 gaRy1nOUUn8RYztAY1h2Mc75z/rt3rQqX1LiIxPBKl09BhbsF7rQNdmbjkCT/T5R4AdTG1ypn7z
 P/hx/rQigVtoMcC/YSCmtAVsrxj+xPKu56dtFSOn0Yw==
X-Gm-Gg: ATEYQzxqVeCkehisA/9JqYBg8GDYNaCP50s2smPAEJkckrliqSFDzJ9OYJmI+rNXS5u
 xTBZXTgKCbgwAfGY+b50M16TinRO9nkPbmFpfXb4UpVa3eBYSFiEidswHs30UBbFmCNbMeGrv9M
 wWxag+XL2iAdAzhh9Q3oudKwdAa8sTIU+joMld7qnRrfpe+lhLjG/2MeL1+WtkaHdxdyAwWE1mA
 AF1npS3mymxn2ALseno3BjJ0M9km2MglCKldrFrTakB1SmKGSysV9HHZc3kv0t55WHrVN0vPTg1
 NdqeYHdDuwlfj8WC+/IFUOZYkuXqVMsfzZWXkpEv3kb/i9F2LgrDYzAX6Wf7iC3q9/0=
X-Received: by 2002:a05:690e:44d8:b0:649:f0e5:fab1 with SMTP id
 956f58d0204a3-64e9132598bmr195542d50.23.1773763588509; Tue, 17 Mar 2026
 09:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773618848.git.balaton@eik.bme.hu>
 <b5fe0e79fa342ffe995c767c8a8b081630cf6100.1773760410.git.balaton@eik.bme.hu>
In-Reply-To: <b5fe0e79fa342ffe995c767c8a8b081630cf6100.1773760410.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2026 16:06:15 +0000
X-Gm-Features: AaiRm53WTr9pzg_R_9NbxDCrUFUExNawrx0JUBxJDR-o2kxRqXzYIEsmfvKddBo
Message-ID: <CAFEAcA-KQZT6DWR3yE1Ja2LR4VDw3koQY=wuFi6vPbTtu19OOg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ati-vga: Avoid warnings about sign extension
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 17 Mar 2026 at 15:18, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Coverity reports several possible sign extension errors (latest is CID
> 1645615). These cannot happen because the values are limited when
> writing the registers and only 32 bits of the return value matter but
> change type of the variable storing the return value to uint32_t to
> avoid these warnings. Also change DEFAULT_SC_BOTTOM_RIGHT register
> read to match what other similar registers do for consistency.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> Rest of series unchanged so only sending this patch.
>  hw/display/ati.c | 8 ++++----

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

