Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B04FCA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 10:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqUuX-00089l-5G; Mon, 25 Aug 2025 06:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqUuU-00088C-4U
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:58:46 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqUuN-000150-Lw
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:58:44 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-55f48cb7db9so401528e87.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 03:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756119513; x=1756724313; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QbwWs2+ydTs8g64zcQoevgXQBlwL0ffFlBvLl0V3K0w=;
 b=YvRn52HlN9ZImgsSG/Ofo1UPwPjsCWq4yZCCJaO6s0FwHhZeCqi4VMhPh8GOLD3dlh
 Jaf9cfPgspvDwof+iE8Rlb37SFQI2/CZ+klFIm9sgu01xPraFuj9pStSn5U5qGoPqykG
 n1GkSg85VE1aabpExLEeS4hycHRNd+G+2aSDPtciDNZ5mgMsQSOxxkuRT0uopljjr2IQ
 JtP1R2FZC4FW0RKLvD8bXqoOG1/b314HU4o3TTAvhVVgNbbgVcylno5i92p2Z0fzFQnC
 EDtqA9G3jHYNJehVPtwmGLF7szJE9EfIGwBHrMHDDKOZ+Qz1eKhyxAeCq2E48LzmHyzx
 j3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756119513; x=1756724313;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbwWs2+ydTs8g64zcQoevgXQBlwL0ffFlBvLl0V3K0w=;
 b=CgFr9uousH09BieQihAQ13pCXO1TvxMVKGE25vYOtJP+gpDQOX34GtUdSVaV1jtKQw
 uRBSwkugiyFJrTTLkPUWyJoLBmZIKUHkG/JX2u8HypqPpHAZjcm1IetJ8q5/V8jvBEhq
 XinNiF73mxqCFNxnJRVsbmk06H0IB0QM6gp2u1hC0JO9D8QLkR7fLnO435AdISFBioLB
 GhzhXm3ynm0s/uUMC+6ClSWH3JcQI1ZD3K1udXamSZ8wWb10cwLia73n3eEgZsr1h7If
 zqWpw3HeC9aPFXdXBuqo07TrICuI10FihGVtDkP/7QyIbNq4AgvZoWPYzo78kvVxD7/N
 qRLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIEJYePWT4vbpxfkXT36esyLn0iocxSrOQ6BDZ00ga9DRZ84Bj4ZOY21jPFPEKwbiHTeNqVCOkaQeF@nongnu.org
X-Gm-Message-State: AOJu0YwYYP4rC7iM9Lwe1OAlOyJ8CkySqfmeBpSG54Kv64K12vNBQwVE
 bVCxKLvlm1XmtanNQ+SF9mHm5kzwszuU4WOznKwt4P0AwSsKh6Ig8ncb
X-Gm-Gg: ASbGncvlNs18/Zh9EUOOQIdDd61EmV8XlgvWRa6LUxCQa0UxNOuo2FlQ/kBAPyIPQWf
 ZR4b3xujQu6S5OJ1eqoEnW3qnAe63vjpzcSb5AsAzfhhEUOyx83Ozu9s4QKFVuZlF5vEKWga/wW
 MO5PO1y6y441fw1yCOTebE0tGT3u/KwLrkNL7daJ88qZUixFEaQQ5W/iHyWJWFK6RDPZUapjtKO
 DCRKCJa8KD2wzUfFfbX8EDGT/1zWLJp1iUTAOekDZIT9tfWvoSej/bJg5eSn//ArycVMadTqyRx
 hWHLHs1SXWDGg+JJ3D096GLnOmZsHEv7IbOJiNu22OSEFZ0xCUlNR9GRQb3pvviO4eg+TNK45Q3
 3esHfjUvdivMekkpy6NLuj0qIIkACvX9vBkPJtEw5JJgkTZ9M987qxbE9/VVllU/5D47jpw==
X-Google-Smtp-Source: AGHT+IEOWLBcDutsKCGJbtB4zgs+/nH1CQ2tw7szfI/oorRmrJ+95ebgdHdbCzFxTk6ifK2sHuyzyw==
X-Received: by 2002:a05:6512:631c:b0:558:f694:a65e with SMTP id
 2adb3069b0e04-55f0cd0a837mr2692730e87.34.1756119512437; 
 Mon, 25 Aug 2025 03:58:32 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3365e5d1b1asm16203511fa.50.2025.08.25.03.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 03:58:31 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:58:31 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 edgar.iglesias@amd.com
Subject: Re: [PATCH v1 2/4] target/microblaze: div: Rename and reorder
 function args
Message-ID: <aKxB18pZPajWdLSe@zapote>
References: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
 <20250824222734.4151956-3-edgar.iglesias@gmail.com>
 <80a82610-0423-4e25-a88a-14c4f7d95ed3@linaro.org>
 <a879c454-626b-4194-80f2-229ad60ca971@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a879c454-626b-4194-80f2-229ad60ca971@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x133.google.com
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

On Mon, Aug 25, 2025 at 12:11:25PM +0200, Philippe Mathieu-Daudé wrote:
> On 25/8/25 01:32, Richard Henderson wrote:
> > On 8/25/25 08:27, Edgar E. Iglesias wrote:
> > > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > > 
> > > Rename and reorder function args to better match with spec
> > > and pseudo code.
> > > 
> > > No functional change.
> > > 
> > > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > > ---
> > >   target/microblaze/op_helper.c | 18 +++++++++---------
> > >   target/microblaze/translate.c | 12 ++----------
> > >   2 files changed, 11 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/target/microblaze/op_helper.c b/target/microblaze/
> > > op_helper.c
> > > index 470526ee92..092977b3e1 100644
> > > --- a/target/microblaze/op_helper.c
> > > +++ b/target/microblaze/op_helper.c
> > > @@ -69,9 +69,9 @@ void helper_raise_exception(CPUMBState *env,
> > > uint32_t index)
> > >       cpu_loop_exit(cs);
> > >   }
> > > -static bool check_divz(CPUMBState *env, uint32_t b, uintptr_t ra)
> > > +static bool check_divz(CPUMBState *env, uint32_t divisor, uintptr_t pc)
> > 
> > The name GETPC notwithstanding, I don't think ra -> pc is a good rename.
> > 
> > PC often gets confused about whether that's a host or guest value.
> > RA (return address) is less so; it gets used often in core tcg.
> > 
> > If you really don't like RA, then perhaps "retaddr" (also with quite a
> > bit of usage) or "unwind_pc" (no existing usage, but very descriptive).
> 
> +1 for 'unwind_pc'.


Sounds good!

Thanks,
Edgar

