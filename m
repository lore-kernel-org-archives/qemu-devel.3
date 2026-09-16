Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A72C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nh6-0004rL-03; Wed, 16 Sep 2026 07:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6nh2-0004qk-Px
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:20:48 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6nh1-0008Uw-2Q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:20:48 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d43db0c1cso7137207b3.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 04:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789557646; cv=none;
 d=google.com; s=arc-20260327;
 b=KZtPEgj3rrFoR5DjapCtr1vAmeCWhNv2hCZ8E+6ef8TcFOzTC+EPWGH5UY2SFgjfGC
 BFVAEakssEkvnyywmQLT7vS+GwJKzLxcDnM4T9DjUIYVqZdP8afiQXki2LPXmR0pMV7D
 inFUD0TSF8/ZjfJ7Jko7KygvtMDaTVIP1aytbcQitw9Vbc6N0YD+ev8qs1vkxUR8dCAa
 qGwtO8iJ7b6KvHKYL7Hc3YiKrDSqR/Dy+BxLx0CRfTGUTDIKQfGNa0MfUpeWmagLb9+o
 HoGewO1D5IH+oBPjkmReIG0TXqGzU/wJgsSDH3x7w/QWB0flxlo8Uk06AdBOn6VecD65
 4cMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aRgVgjOFsh5/uu7F/9NUKjsFy7qIQcVbVGDCxF6g9zM=;
 fh=EQRlMMMaBW8zxI2rwUI6QZvbR3nqOcEaFehDENRIQPg=;
 b=CIL/vgFnOkWLFGZikJEXI/q0LBx2p/uDYRLsEZvXAonxQ9NbveTcsRSCK2ko43Vfrr
 S03fnmfqkOdUC3F+N/RZesDwRWU3YQ+ILsuttWMhAF48w4PmRhBF6xtmRgguAkVbtKeI
 9QVXQ3zQAKOInEatoT6fu/Itkw9C249Pmamzb5qzWMuxxwUhl/1WfxYEAZVw906oTClx
 BLBXMCHtUsKnZ0BTIzVALWIXN7nhlSGhHzdbSj27HErAz9WIZ0bujIKrqXCEAlinPdcb
 1zswE5oltmHV9EqQrr7j4U9WcDWC6rDbfIxFtQ1y2FPM4J52m+0Gi0Ecxg3JPyqBng+k
 nNEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789557645; x=1790162445; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aRgVgjOFsh5/uu7F/9NUKjsFy7qIQcVbVGDCxF6g9zM=;
 b=rIMVrHqE17sr6jiSMT//bFsi0FVGFPppOS9nOjpgVO6d8i51MlPZ0tFaNG1mxn5zA/
 hYXigox24i/iyMqnCmC+K1eGanI8q8+FBIgWFyRfPWFt0cHrJKePGeWzRbOWAR+uPuoW
 vAqLAi024I8oRXHdcBQ6q3xmVLTZQ4A5yxbRdpS2sLrEQ8xQNNLwTNM3Fki0yJMnOWZK
 VGGKZZzwBAOM2BpcA+pUmcbJUfYc4svs6unbfCt083F5ISg9cUveVXfgD0su3CW8VphP
 aKms1KPND5+2EneRDiBJcDwvN2/rFjEWj+O6td04szhvPHjq7MSiKkrmRvJUmHktD16x
 HIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789557646; x=1790162446;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aRgVgjOFsh5/uu7F/9NUKjsFy7qIQcVbVGDCxF6g9zM=;
 b=FBKlPRvIQxjMDXZC0BSBwgzl1I6A/ru1lwyJpe4S4381TbXdZes/OxZwbseXJLagQ6
 ERvhfpwOhUrQnrTOf8j28WRQEL8Hd698LNW8rJJXCkc1DHbOKA8oht/PXDcjc6W/lP64
 xuILoamJRpgRytD1PSJEjLhjj7gcaUUlXnhO6i7YWMtEFXU4bgIEKY1c2Tp6dgXp9mJg
 eWweNxST0Jig0t3VaNsQFYKxKR2YxCxYHYDLBGnOtaJHsIwDbMS0sh37HJLAy1TYhlet
 /F8OHdZNJzAwbNsIFZLbMXSjTsFcVi+tuutgT29hK00iwfZSE96WUXqWZQvsx2Cr0xc9
 bxmw==
X-Gm-Message-State: AFuF++kDGW5KWnLuKUukMsflskuwZ8E1v3VHw10iSZte2MYb5Nb7Hd6F
 utcc7v7r2+2zZJNMb3jZmntqcs/y6cgmu0rq78OtFOsqCZ4MYpnz8XHOfa44xg8v7JLjsJwr08z
 c7tvHCmAnJ2+rNTZrNAIlBmdNXx1eHYZj0DULSlD80A==
X-Gm-Gg: AYBFou2UV3FCwcCbtWCroPB3A7gYPDaBae1F0rD6R8ylRs/o1hraRtkiwIi74Oiz77W
 BRRknZFM1lKt2k4J8FeDt7T9Zzgh+K1hTOuDaXQBbn/9a16SV7saznPSj3B+lL53JCblI2jb94I
 XV9UGhlcPVeWCdA+XXEbYpykW9L0m3l5r6VsesBNS9aGjj6UugsQnSK0leJo754n35gUiNKFWci
 yU0BBxDMJNutFLXgMcQtl4wI5owOCPLo2aXxmyCNDv0I74Aiu6VXnhHZxgIyv1R2HJuq+z+H7L5
 vMwdUSnOaU2Ye8ko8b2vcA/znBBQkxIVs5B5DYV2W5M1Lpj/+2HQ4OXt7ngC0dEVkGDL4RXYahS
 zl83Nx1KjplPn7EJ6mnCvZZEDboVeoS+wS7kxGIxFG3JeCYlENQ==
X-Received: by 2002:a05:690e:806:20b0:66f:c1bc:4091 with SMTP id
 956f58d0204a3-671632efa5dmr421632d50.84.1789557645604; Wed, 16 Sep 2026
 04:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
 <20260916100021.73825-7-mohamed@unpredictable.fr>
In-Reply-To: <20260916100021.73825-7-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 16 Sep 2026 12:20:33 +0100
X-Gm-Features: AcwNN1WbDPC4zWhoTX8SZTF9QBFaMBagXwI6VYb1ZyKkLYdHhm8DkSczai9lXUQ
Message-ID: <CAFEAcA_T1Ka5M=40LYKXD1nwnEefYbjx5mG=OfWuDqwFkMcdYA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 06/10] hw/vmapple: aes: convert MAX_LEN to a #define
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Wed, 16 Sept 2026 at 11:00, Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
>
> Working around this compiler warning:
>
> ../hw/vmapple/aes.c:257:14: warning: variable length array folded to constant array as an extension [-Wgnu-folding-constant]
>   257 |     char hex[MAX_LEN * 2 + 1] = "";
>       |              ^~~~~~~~~~~~~~~
> 1 warning generated.

I'm surprised this wasn't already caught by our '-Wvla' setting:
we don't want to have variable length arrays at all.

> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  hw/vmapple/aes.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vmapple/aes.c b/hw/vmapple/aes.c
> index 553e688adb..9d062d5a7f 100644
> --- a/hw/vmapple/aes.c
> +++ b/hw/vmapple/aes.c
> @@ -253,7 +253,7 @@ static bool cmd_iv(AESState *s)
>
>  static void dump_data(const char *desc, const void *p, size_t len)
>  {
> -    static const size_t MAX_LEN = 0x1000;
> +#define MAX_LEN  0x1000
>      char hex[MAX_LEN * 2 + 1] = "";
>
>      if (len > MAX_LEN) {
> @@ -262,6 +262,7 @@ static void dump_data(const char *desc, const void *p, size_t len)
>
>      qemu_hexdump_to_buffer(hex, sizeof(hex), p, len);
>      trace_aes_dump_data(desc, hex);
> +#undef MAX_LEN
>  }

MAX_LEN is an awkwardly generic name. I would define it outside
the function, something like

/* Maximum amount of AES data to dump in trace events */
#define MAX_AES_DUMP_DATA_LEN 0x1000

Then you don't need to #undef it as there's no risk of a clash.

(Really this function ought not to do the binary-to-hex
conversion of all the data unless the trace event is actually
enabled, which docs/devel/tracing.rst says you can do, and
it would maybe be nice to emit at least some truncated data
in the "more than 1K of data" case, but let's stick to fixing
the compile issues for the moment.)

thanks
-- PMM

