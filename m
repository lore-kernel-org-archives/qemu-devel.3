Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1DDCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUvw-00005H-Qj; Wed, 07 Oct 2026 12:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xEUvR-0008O9-LS
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xEUvP-00009b-9b
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791392125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VL5W1eRn7bDnhNopgQYpgFIUvfysdptlcOdAW0y5Mic=;
 b=U3S7ET+bhUSZJFlhesVGoo6ThYV6rbZVUTyE2WfsgOA5QxNtT+5PYP1f8HP1d1NoGlqRn+
 ff2CG/ZXEiOGDJMf+TZJpDiCu7WyUO/PJIHR4ygaF8pJjtzhfhyx8U3F1aTskdc2cIyIvN
 S87WVjB9FEZZcjV9i47tCkq7ns5rw4Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-SPf0mUeHMHmJPaCX7cZC4g-1; Wed, 07 Oct 2026 12:55:24 -0400
X-MC-Unique: SPf0mUeHMHmJPaCX7cZC4g-1
X-Mimecast-MFC-AGG-ID: SPf0mUeHMHmJPaCX7cZC4g_1791392123
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a166a9ea21so35369045e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791392123; x=1791996923; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VL5W1eRn7bDnhNopgQYpgFIUvfysdptlcOdAW0y5Mic=;
 b=Hn5lf/Xa92POHrNIHHBTQwFpHfCHi36QfM97eSLhZF4uL+GlBrBg55l1ZTOxMzv6J3
 D6iUYnLqP48kZZfm5AD81BjqOY1eZeQ29eHpGM7YPCPbNASB7qHRM139ZA8EApsbk0PE
 s4qNSvfDxXy3urdrSAcdL2JccbBq4md3BV/minXl1Cj51R1fFZi+F7SRRBceJCj1sTAg
 xYvwNi6jc3yt+k2puOl05MMe+bulBuy/4pAfMwSZwriYRg8iyGYd02+md/vdq/NKSN4W
 vUhFneqHDK9Vd2MEtHoigJeNlRuNQvsqlLUxwLmRZRjmATemUsuoM/ljsraKwMVlElof
 IFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791392123; x=1791996923;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VL5W1eRn7bDnhNopgQYpgFIUvfysdptlcOdAW0y5Mic=;
 b=yl5SJPaVBC2mELI4WyOrjJQidOd996HujmlzhC3Y+CaX7GCw0YOJa308DXtwIvEcko
 JZ9Qp7UTwJ6CC1oOdBIr3fpW0vGGpUQgqeXaKgg5uGAVJDwirDFlu7p/h/szFdd8GPiH
 mqL5Fs6sX3e2mngBidbj7TOZYKrRZX+7OvbuCLrB+Iv2Xwqtcd2UWWi2BiYg3ZKtfXNq
 NFR04QvHTom4mJoODosLIfqjlewkHwcC8ZUU9bHWJ/bgu84rrwTV6QJip0Tb+OuOJIbL
 6eRYyq8bFs/k0QaoQYiAhlE4WsaOF6Bh8CUXWN1hYkWg8gEylwNflyJgI/dbyAF+fOea
 HXpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8hiCit6SkoSd+SzGXNM88JaS+8foFKZJs0Jaru+G60xrQBY27M6fgaYcHviDT2xqhHkszUuhgHUUN@nongnu.org
X-Gm-Message-State: AFuF++nxCLqAzZNgvg6XID4vxqAQelhnooRbbZaToRzaFjbiKyydfA78
 XQt+JkK84kBBNu9FwR2C4L3pVd6QDtC3cB5tAMLzUP5rhDl7HFPs8BSVPwhnCAyU/sKOxwIlcxB
 CXXkhTUdJqfNt4tepYOzZTapnOivmtNAu8TVpJNVJ4GZ4frhyjYJ57z4Q
X-Gm-Gg: AYBFou3LMRbsT1mZTMIDHxdyf1gFgjIaGk4nDsM/KmHzjy+WM/xq5JyhbBkBnJkGlO5
 u75LVaO20n25Ivd/3ESroG1vafMvdvwI6GpTz07nJpuTKtEVhrMUHIKMo9ZmaKe+xRP+fMfGF1l
 I7vgcTQZioX1cUH0wK+Gs2QLYe3l44wa2ajdTu77ja92SZcX4LmdB//OqgLHo1llNW1OcDz3x5/
 1O8FqWSZ9HAaHnouLaWxT3itwX1t9o1ejkuSzhhgqLHi/Bm1Z83v5Z85PX00L6Wfz0LZDp6Of0X
 G/4MUIbCLOuIb8RVaEm4k1IrgEuVFAcN7XdMZZgO5NQvP6frOV/3XJ+glQ==
X-Received: by 2002:a05:600c:64c5:b0:49e:817a:ca7 with SMTP id
 5b1f17b1804b1-4a1802e960amr50642665e9.8.1791392123253; 
 Wed, 07 Oct 2026 09:55:23 -0700 (PDT)
X-Received: by 2002:a05:600c:64c5:b0:49e:817a:ca7 with SMTP id
 5b1f17b1804b1-4a1802e960amr50642425e9.8.1791392122904; 
 Wed, 07 Oct 2026 09:55:22 -0700 (PDT)
Received: from x1 ([151.67.89.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17fc4a588sm64202585e9.1.2026.10.07.09.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 09:55:22 -0700 (PDT)
Date: Wed, 7 Oct 2026 18:55:19 +0200
From: Gustavo Romero <gromero@redhat.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Will Deacon <will@kernel.org>, Itaru Kitayama <itaru.kitayama@linux.dev>, 
 Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v2 1/3] target/arm: Clear TTBR[5:0] from a 52-bit table
 base address
Message-ID: <tebrqylcupcfka4lqbmtfnhabyhcylpvynzqkqzbhab5zh63qg@kinh5l5u2j4o>
References: <20261007080019.350315-1-fuad.tabba@linux.dev>
 <20261007080019.350315-2-fuad.tabba@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007080019.350315-2-fuad.tabba@linux.dev>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Fuad,

Thanks for separating the fixes from the tests.

On Wed, Oct 07, 2026 at 09:00:17AM +0100, Fuad Tabba wrote:
> get_phys_addr_lpae() can read the first descriptor of a walk from the
> wrong address. This happens with a 52-bit OA when the initial lookup
> table has fewer than eight entries and its base address has bit 51 set,
> or bit 50 for a two-entry table. The walk then faults or translates
> through whatever that address holds. VTTBR walks for stage 2 take the
> same path.
> 
> For example, the 16KB granule with a 48-bit VA has a two-entry level 0
> (FEAT_LPA2). The 64KB granule with a 44-bit VA has a four-entry level 1
> (FEAT_LPA). KVM's page_fault_test hangs on this in its 16KB, 52-bit PA
> guest mode under TCG, as reported on kvmarm.
> 
> With a 52-bit OA, TTBR[5:2] hold bits [51:48] of the base address. Such
> a table is 64-byte aligned (R_KBLCR), so bits [5:0] of the base address
> are zero. get_phys_addr_lpae() ORs TTBR[5:2] into bits [51:48], but
> then clears only the bits in indexmask. For these tables indexmask
> covers fewer than six bits, so TTBR[5] stays in the address, and
> TTBR[4] too for a two-entry table.
> 
> Clear TTBR[5:0] when forming a 52-bit table base address.
> 
> Reported-by: Itaru Kitayama <itaru.kitayama@linux.dev>
> Link: https://lore.kernel.org/kvmarm/B4C0AC3E-6A4F-4A7B-B7BC-81207539115E@linux.dev/
> Fixes: 7a928f43d872 ("target/arm: Implement FEAT_LPA")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>  target/arm/ptw.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index de0435a58b..6cff52d592 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -2107,13 +2107,16 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>      descaddr = extract64(ttbr, 0, 48);
>  
>      /*
> -     * For FEAT_LPA and PS=6, bits [51:48] of descaddr are in [5:2] of TTBR.
> +     * With a 52-bit OA (FEAT_LPA or FEAT_LPA2), bits [51:48] of descaddr are
> +     * in [5:2] of TTBR, and bits [5:0] of the base address are zero: a table
> +     * under 64 bytes is still 64-byte aligned (R_KBLCR).
>       *
>       * Otherwise, if the base address is out of range, raise AddressSizeFault.
>       * In the pseudocode, this is !IsZero(baseregister<47:outputsize>),
>       * but we've just cleared the bits above 47, so simplify the test.
>       */
>      if (outputsize > 48) {
> +        descaddr &= ~MAKE_64BIT_MASK(0, 6);
>          descaddr |= extract64(ttbr, 2, 4) << 48;
>      } else if (descaddr >> outputsize) {
>          level = 0;
> -- 
> 2.39.5
> 

Reviewed-by: Gustavo Romero <gromero@redhat.com>


Cheers,
Gustavo


