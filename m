Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C379EEA810A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnGn-0008Of-QU; Tue, 10 Feb 2026 07:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpnGl-0008JP-1Y
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 07:55:08 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpnGi-0001vR-1t
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 07:55:05 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7964f1405a0so19901077b3.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 04:55:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770728102; cv=none;
 d=google.com; s=arc-20240605;
 b=al1r1CSq6CBzKn2s7dZmP133s6w2I8skqPM68v5SeSHOPD/8d2VgrQ+t4pI/NcvdgJ
 vmsnYKALg6JQTMyZAqC+jV+OveCK9cMlu53PxR+PQ/aVO/pU6mJH/9oak6OtyCsrL89Z
 sTPggzCOgcXdAjlVxJkET7+1TYJOw63onDYcZvd/Ww7eP0E14tuE1wADHai2gjBF5ecd
 Ls3fknCpQRUA6xZ+fSDw01ZgG66KDybYGPNIaf1cTemQPswzA2vjIDW31ZHGtUbdm2an
 0mwvER29d4Q+VrP9fo/ANKT6Yp/e0takb/nrGoQZQkXUuIlDMVisF1grkXCKHk+0L9xR
 LPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MxDu/SUqdsL8XdauFS4i4DsHwUTDrJAwAgHFeI9/lmE=;
 fh=jaVXKXdPtDZ9Td0ozRtoRANDtI7awvhCgjC7/yxDBPE=;
 b=Sd3gsFxhyl05kDvAsHpjLXRE9X1gNfdgb4GMpNkjfxX7cCaWjeCq3TKDJXODk149A1
 zJukX9lsoISMjapq1DzUkbGeaYkQHJoPQUqsHruGsFeYMMFrS0L0HFk1QgQu3bTWSde+
 dahbmJcp7EgWBOsTQBTBQ2pWKNTx/XYhk3CJS+d/aM9y8pX4cacn6FYCIeUdO1n9tsAb
 Y/uyB1IdrvUMTbXj73ciGNRVddawJkcl1c5VA4epahVEQlzWGFGBcIGIg7PAhRI/Q2EX
 uSR/u4J7tWcKTsO3i8nWtm1rAOEEXRD4GI4CTYR7lF0PiHZD9OFwffaoZ/Z56Eb1AIst
 Mn1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770728102; x=1771332902; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxDu/SUqdsL8XdauFS4i4DsHwUTDrJAwAgHFeI9/lmE=;
 b=bavYFP32LKDzeiVz3wL4N7rL2e0hrWtgmaW/b5kLzfiVAfgNYbabQqePa7SqZwSR6/
 imhg6zH+N3z7cGR7yP30bo992u1SrrAPLepwyzttXZO+Bw2tSYJabyVdiT7Ahz8/fMRf
 x5NaDsWLNgAitp2rpmgJdKZQF0iMFbMAjjaslt3+xcICZkzkOhSa1D23D3stEk3GSNkX
 F45ixMfjdSb+RTR+SDnwveOjEElI/qu9147lYH5VRoTYTFxdLIdKc9Q6UNW5aIlhYm8s
 c9sAhT/bJycSh6+pjzNcxa0kcizJRFEDgTggipp94Slh3L/jqc/J7hrEI8DL1wIbNapr
 qeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770728102; x=1771332902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MxDu/SUqdsL8XdauFS4i4DsHwUTDrJAwAgHFeI9/lmE=;
 b=AWA/Oc9p2RNO/roYWO/QyjBg/SVwbGuRV47shG5XkiJ61uTLMzelt1rKdDw/gleAQS
 j6xXKwb/7S8ZzeXj0H7kei0aLs9tuBUsoxHwCLrsdfGWnk6v6GrLmUCK5rY6IDwQqLM0
 ZVJw/V8GVCNbAtlyWhcM6idzX+TBaKj/fH6WxegcLk1CRVwr7plO2m4m95Qwmf4U1mc8
 G46ZUftfJLQp5solK8pVTmky64FZ8B3/CKg0acYSAKUVQOQ+2w3PZ6bX+xvuwiDdAor1
 rP5JQZVFwie3KbSK0jeV6jnZbqyYApLMsCVl9I1D9S5zjKB9Vo+0Vb8OhBQ7QCn9CkkQ
 ME8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVijGc9ZqwrQkL2ZyWZacifQ1FBYEDU8VVumnJwEBJUaa7zzM9xGN+62ftwJah0g6T7Wko2NvuYPWp3@nongnu.org
X-Gm-Message-State: AOJu0YyNvWaSeq/OOTMJ+ktY21jvWYqWqHCFS9E0WtrfxMUDRk3VNDRb
 mwme1wIqTAm5aS+f9Kf/xW18iTltWu0Lb9hpSdOxEGlWTTd2Ef7RxW/WmwjshLAt3DXAej/Xe/C
 kofgX8knJ9B9+Xh9ZqMBILrK8UBn0giZQgEZ5AMp6DQ==
X-Gm-Gg: AZuq6aKC6/RejNgRLQ+zda7PMVdfpE1sNgL1eo+RolI7GTLDZa+dubFc82EzxGyGXEk
 ghG2apiiFa7yQW6lCieyyiAabnCEFCDXkBetBPpx4Zy/YAVZRenKYi5zvzULsZEqGAvUn+9nhZa
 8RuHCYUbbx6qezXtkBVOolYcwFohDRPvUOk1zHR5uk1ty6RIlwk4cWP0PievoMb662LwK9NpMFm
 +zByUi6ZCYkdgbBZY3jMyR0008ugccbzh1isauLITKH3e//btRpacy0JOrS5VOp97J6DLLjo+RJ
 i2aZWmg3+l08mxyyQmc+R25bgqnkz1ltN6NVlof9/anP18w3iZ0s1RJn22CXUO+1w3ko1SQh0mM
 oDw==
X-Received: by 2002:a05:690c:386:b0:78f:8503:7773 with SMTP id
 00721157ae682-7952aa746b9mr135064697b3.3.1770728102487; Tue, 10 Feb 2026
 04:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20260205210231.888199-1-alex.bennee@linaro.org>
 <6cf4aa8f-5f1b-4145-88d3-da5abfa978ab@linaro.org>
In-Reply-To: <6cf4aa8f-5f1b-4145-88d3-da5abfa978ab@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Feb 2026 12:54:50 +0000
X-Gm-Features: AZwV_QgBciDobILLCboXiZnhQL0VfTJ8-uSNPgQF17sxCyxXtPvDLOxk-vI8Bfw
Message-ID: <CAFEAcA-g+tOP4=NK8hK3vJ-WT4+dYXbiciXBpeq_2Yr6SxfH3A@mail.gmail.com>
Subject: Re: [PATCH v3] target/arm: implement FEAT_E2H0
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 10 Feb 2026 at 12:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/6/26 07:02, Alex Benn=C3=A9e wrote:
> > @@ -3817,10 +3821,15 @@ static void do_hcr_write(CPUARMState *env, uint=
64_t value, uint64_t valid_mask)
> >       /* Clear RES0 bits.  */
> >       value &=3D valid_mask;
> >
> > -    /* RW is RAO/WI if EL1 is AArch64 only */
> > -    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
> > -        !cpu_isar_feature(aa64_aa32_el1, cpu)) {
> > -        value |=3D HCR_RW;
> > +    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
> > +        /* RW is RAO/WI if EL1 is AArch64 only */
> > +        if (!cpu_isar_feature(aa64_aa32_el1, cpu)) {
> > +            value |=3D HCR_RW;
> > +        }
> > +        /* Strictly E2H is RES1 unless FEAT_E2H0 relaxes the requireme=
nt */
> > +        if (!cpu_isar_feature(aa64_e2h0, cpu)) {
> > +            value |=3D HCR_E2H;
> > +        }
> >       }
>
> Reset value of hcr_el2 should have E2H set too.
> I think you want something like cpacr_reset().

I wondered that when reviewing, but we already have an hcr_reset(),
which works by calling hcr_write() to ensure that we set the RES1
bits out of reset, so this new RES1 bit should be automatically
applied too.

-- PMM

