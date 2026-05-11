Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13F5CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRr2-0003vm-DP; Mon, 11 May 2026 10:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRqp-0003q1-Rl
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:43:22 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRqj-0000gO-PY
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:43:15 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-678a16429c6so6739032a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510592; cv=none;
 d=google.com; s=arc-20240605;
 b=Ka3J3XGsll1JV57tf2vs+WNIbkgZtgES9WlvFJS4jVNQDhhJr1R1W8Ndf150B446u6
 4Ji2MngA/B3+hyykYOk0GoRXbPEaceEFo2b053o1qY50j17tsJVam7RreziKfoVf5wgC
 O2GJKp1UkFRXIW3mmOvAlkcGuFwaymzlhmN1q7afSFBH5LppekX9xcsHUiZfvnsxMc6m
 LdAJaDnb2FHt9Vmj4TpST2SYw66CaRkgYEjeomh804cV3h7oyDSN37urXRzqKmO5pYIS
 0tEz47+YicRNNTbbN1sRW11TPdOgOYfFcImDIRtzo2dpVPm50q+JnWLBr/VfuGaIpZMg
 I7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rqM36hR71hOw8dYmxmsLRIDvVQPPwrb6TbDLEqYOxIU=;
 fh=GzxBTHQloWqJfnrmUBXdrSWlBYRF+fQvhYVjQyZiL/w=;
 b=crfM/klZW2+ihm24Cdic/zv9Yhh5EKOz2q8mD5lqy0DAhDwKXNq6zcUYebUMy3Ps3y
 KRUVUfd0kdz5A3NXMtyVDj2Bq/IJOE9f6+tbtRhVuEfCpWyxJ8633GWxUQXj9JN6S4Zw
 VShETyEdv+4+kS4HzQ1kYQHShaFix5SuFApH3Xs+nMqbRdD8mPax8dF01ZT1PP6JMbOZ
 SBEFQn6qwICJOdG9oLlxqtBeRhF6b1F25GoIfyKzejDgNHgA27EPQX6EkGOEodbzWhCc
 sgZXUzKSA2pIBCza8xaLooDpPx9E94KmMgZw1L0UPxrO3L+Abvmp3EWlMrhfe9/7S2Fm
 i40w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778510592; x=1779115392; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rqM36hR71hOw8dYmxmsLRIDvVQPPwrb6TbDLEqYOxIU=;
 b=yvmLb7xR1myCMVHsGiXIa0X89TuF4KVHwZZKbevMDntUQfCKHvcGanI0gbBjqrzvMR
 NCsWqPQxp9484NclIJI2fLtCkNFgPbXzPb3QeQNzr3M9GkkvZxrnxezcIrFxSAXFvxqX
 ErOW/r5BvaDxnTayzw5kUVzdehP+Bi8j0CJpx7GxTW3MGbJ54wTH2FWFXBIx8lbPES1P
 Cjn91SunVdH4t79Lv9LKVnFocpR1LSPAaAdb1fVKPopVwof5pF3g4hEIFrovosPJa8FB
 aQ1xzxYTbt0mT1V+3K1+b5QVruAe+OBuCKY1lP6WO7vLOeCeOZO2PQM9A2cn7x77I9YD
 eyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778510592; x=1779115392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqM36hR71hOw8dYmxmsLRIDvVQPPwrb6TbDLEqYOxIU=;
 b=CUuz9MBgD/9oYnAnbbo0VLsxGlRCImYHilhczvE1F5eMN31EOuYA68IgI3ls7g3y82
 4vhfrjQf5l57XG7rVE+3QgK7UlxF1u01F6M1MNJnaBtlJi7kE1mg6GsRWCtRNqzIYOqI
 3IAk8QT8CtYC424CFllxSNYneMSbKG1GrUQZaAvMZOjL1GpSHNvP5Y9G8nrItzkLonHX
 /Crj8meWRYl5fbenflE9j1l4JAyoU6vIzM/7dv69JknyQlIWmx6f6B6JS1hWJPR7i596
 4RCBO69L7ryQjp12CuqEZN/f6Wignmq2j6nufN8TedXILeNz46vhhSMRkvtr3B0EE/aT
 9hPg==
X-Gm-Message-State: AOJu0YwlVMT67w9lDWiRawwCFjM/bQQgiuCeJ3l3L8yry5CtvH7WbWHz
 f2epbWCRmwKn453nAwP1I8EGpCJEDOUiC7Hp1VtlJfAhaCT0kLWKBr/dnfZJm3jSIieMrTPrkWU
 CkHwdtpu+jLeL6Uzm/qNI6vrOKnIowMBZUPd0RyoC/A==
X-Gm-Gg: Acq92OFWS3R8Cj7hJ9lk8ZMyoENK9vLDR6d5zSav8/WdEaASBVFYgTDmZSTB2DmruLU
 uwuBCC9facM6qU+ZZMAYFjfrmlKvo41FqGdujSiuWU/PR5C4DleKTnokMGusn/X5lJ6FUpE2wDU
 TrzFSHvaQtq8HZHG0pZ4O1EF8KzgjDbib9YhZuY9t9JyPUEPVXB5T1JG2+u6jVyFG35hhl0KEbh
 UomcRXla8GbNLC6Ze4+WCUwwwCNCtabWu4Z5WQGc0+uJ46NW8zRYzRhq8f/MeESj/QrSDRn+uZt
 oh3YTMq7xkk1Xc5XAAMRFEl86urYgRj3SWx1MXb9XPRUvcgBS1C55Mc0MdYXFoIp4RCfJf7tQ6Q
 07Q==
X-Received: by 2002:a05:6402:b8a:b0:671:9dec:ba3 with SMTP id
 4fb4d7f45d1cf-67e0ee9abb2mr5662552a12.13.1778510592099; Mon, 11 May 2026
 07:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260427161132.1463385-1-peter.maydell@linaro.org>
 <6f68014b-e3b5-41e7-9474-b2964661d19e@oss.qualcomm.com>
In-Reply-To: <6f68014b-e3b5-41e7-9474-b2964661d19e@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 15:42:59 +0100
X-Gm-Features: AVHnY4IgjVQiJvgFxqfEXGGCp5LRdPQBZRkc7A4Cb7rHVszvBgZJvlBTLGTtxe4
Message-ID: <CAFEAcA-2dOmcryxWVh-uRJ77DNy-vCZaHvFm+KACPCXbuY1ruA@mail.gmail.com>
Subject: Re: [PATCH] docs: Document TIMEOUT_MULTIPLIER for raising test
 timeouts
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 27 Apr 2026 at 17:17, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 4/27/2026 9:11 AM, Peter Maydell wrote:
> > Our test infrastructure allows you to set the TIMEOUT_MULTIPLIER
> > environment variable to raise the test timeouts if you're building
> > for a slow environment.  (scripts/mtest2make.py reads it and sets the
> > meson test -t argument accordingly.)
> >
> > Document this so it's not a secret feature only known to a select
> > few.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  docs/devel/testing/main.rst | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Thanks; since this is a fairly minor docs update I'll throw
it into target-arm.next unless anybody would prefer to take
it via a different route.

-- PMM

