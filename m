Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90523C55172
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 12:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wq8Qe-0001z9-Cr; Sat, 01 Aug 2026 08:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wq8Qc-0001ye-EL
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 08:02:58 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wq8Qa-00053O-QW
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 08:02:58 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6689f36ae56so2825165d50.3
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2026 05:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785585775; cv=none;
 d=google.com; s=arc-20260327;
 b=LW+K2L/XLIMhLq/xh09JRmhxKDj01vPNsUVj7GIkxHHf+EzWFpIZkhDB5t0vewpjh7
 BtiyS/qhNa24Z2EqJEWfGJfshbBd9Q98m2YGrb2sNVGQnqlCcbtG/Lc1vgZh7nKzZV0e
 A9U7EXCJixpzvwKMhFSY7Vwi0uy5sIXVWTI5bSVftHCX40kVGGMXIwsDsXQzFH9YM6Ft
 Bsxs9ZN2YTiL9EzVk52c+2DJYi9SYsIMKqbCV1Sb9YFi5KS3pbvM1wiR3VK82qq7MJ3b
 XRponAaiIn0W0o55gj44AD1BoHosqHeezvl9yyPfeKtkZpV1db9Re4G/mV7ErGOSbdsN
 NeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Cy9zAdN3Y3pgbgW57Qg3suhyIf4Ln6sO/8ETzrpdyTE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=PRCsE1cjYmYRY6QPSzhX4aLQUB6Fz76ZGSAMaRIPFQsgEt6Y1Q1Joz18g40c6AlLOx
 Q/qsSSyDu830HFxSSM4+KBQ7eTLq6j4PyyCryzf68Lp1jLll+7jWkHTAZyF9cji0VpeJ
 u4SUJvGSGEui3DeX7Jx9rg9pwJQFuWoDAuiwu4+vqRvy5vf4NKE5LXb0n89LHwUTKJS6
 LZv3EmzHzjCPurfqXW5DVAic/Aoh01qe8g8EeGWGnoxszTKDJTGG4DDp26vXPloGI63F
 9AggfkpRTpPDWDHdw3sIBpPqHenBTU16r+CwxN+Kot3TuDtFNika3CIiE/J3tvkF5GPa
 ATjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785585775; x=1786190575; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cy9zAdN3Y3pgbgW57Qg3suhyIf4Ln6sO/8ETzrpdyTE=;
 b=Dz1avYhL7I8pV7js//Xfxhe+65fHubopy69Bjv0ZTVTp6kY8ObsLpDOmGkj2sNy3KY
 uELPwodeG2k5VUXf+F1OOaTXL70oJIyMovn3k5tDRM1VL3mYnnDPYvHIqDcO2nwY0QGN
 /lMaehb9vf8MFpPlB43Ah4q14xCwdDdJwA5NCZYyBNaaMMLHeul+MX+98m5gi2bK0q6w
 xPdEl551IaL0wzVGsxwilRHYaW4h5xHtqAGHNqOFTPRPj4rz7BVxAg5CGxE4PYeJeE/L
 l++5wx2PUU6RNJawRzFQrtjSX3Rw9hNTsJDFfpSUzZjh9DXMwuJwglPkQdJNEi+nsALW
 E3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785585775; x=1786190575;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Cy9zAdN3Y3pgbgW57Qg3suhyIf4Ln6sO/8ETzrpdyTE=;
 b=WDnBkQ3NqMqYFn7RFk+VcShaHbLvLjPuecepQMRuiS057336Lm/VArkfuSFRGV8Y5P
 S8T9NhHkeaTzm3DsuD65NPyHmIS9XKGdemcVW+Z3XhKsXLxXcQgtsqzHyvE9bXsyQ/y3
 Da34EEso1G9Vk+Y522vVKJB/ub/J7WwNA6EejGtAwcsN/Bn8abIEaza9Kw47gNePk8R6
 GbYrdA7U44X0iRxU2AGXyCZ4LkVnqLC5KpjeZ8+ImjeaJIU4XFQys4l1eSOVNDgUrIt3
 Dc+zlMEXcytFy4VboCIFHhXJVbIosVaD9lfNtLsFUVA9uQhvuL430fqvDs5Ru5bYeenT
 McMA==
X-Gm-Message-State: AOJu0YxG7HGHCfO9h28UhkA7Qtg43g7wIh5a92/KKbp4d9J3FFNi11p7
 N8ggvX86RDIPLsDUA29BKQ5eMY16S/4Omflh9j6eetVGouhYygqqi6G71Tw90IWsyhUdQrHuzXm
 jZtzFsxUGpwthUMTADCw7eEBe7Kb/MvqhsclKfzyUpPP8YcsWaqYn
X-Gm-Gg: AR+sD10RlrXStKbdvCKeqVKZclIZqXIVF+HYDOfGtT0Q1pbC4q7dBxwXwiEFD7iw/G5
 ZQsNgOWpET4chpBSbEhYgdBgPlU/Xgb/FQ6ZqRhiOEl3nLYDePoznLqnMdv5hTD9G3rdeHz6vs9
 h/m7zIf9oQdCVar1UpH/AZIk0lf8vo8mdQR1J/PFIhoihesjY8D7XArEcj5j2oWPFNUpkU9vYSZ
 U7M/YXleRkMopV8AYFLKg27jQvJI2+GP3kYMpagitcT4wcjOLprw/WMpter/4FZi12EoSXrPAqZ
 PHY9qZNbvXFKHGIUxYbBBaaXpIgZAibnF33iOwQYyaWfZe7E/QDCi6HVIcu37iLONhirB/vM24d
 OdDC+EGIjftIR1PkBXD4sVi7Nol9E
X-Received: by 2002:a05:690e:155b:10b0:667:e04a:8a3f with SMTP id
 956f58d0204a3-6694efcc215mr3765403d50.5.1785585775108; Sat, 01 Aug 2026
 05:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260724030616.76180-1-richard.henderson@linaro.org>
 <20260724030616.76180-2-richard.henderson@linaro.org>
 <CAFEAcA-BkEG59qM8sRtEtD-Y0-LC5sWfuWhMFTLnEcGDcvvDmQ@mail.gmail.com>
 <2efdfc06-b522-40f9-9aca-88d1a258ea14@linaro.org>
In-Reply-To: <2efdfc06-b522-40f9-9aca-88d1a258ea14@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Aug 2026 13:02:43 +0100
X-Gm-Features: AUfX_myZWXT3hjyw_gscfcrMhqzVB-Re83sU3tjqw1lh98aGsoSasQ1GMzqdn20
Message-ID: <CAFEAcA_LP-QMw=E4yb+tnY-Q-hOzD0TAUL6Ay2Z0oys9CdWTig@mail.gmail.com>
Subject: Re: [PATCH 1/6] target/arm: Add FGWTE3_EL3
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 31 Jul 2026 at 20:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/31/26 09:30, Peter Maydell wrote:
> >> @@ -553,7 +553,7 @@ typedef struct CPUArchState {
> >>            * FEAT_FGT2 will add more elements to these arrays.
> >>            */
> >>           uint64_t fgt_read[2]; /* HFGRTR, HDFGRTR */
> >> -        uint64_t fgt_write[2]; /* HFGWTR, HDFGWTR */
> >> +        uint64_t fgt_write[3]; /* HFGWTR, HDFGWTR, FGWTE3 */
> >>           uint64_t fgt_exec[1]; /* HFGITR */
> >
> > GICv5 also has some new fgt registers, incidentally; implementation
> > of them in my w-i-p gicv5 branch:
> > https://gitlab.com/pm215/qemu/-/commit/31900667e440a136c60b984c9e7c9e9a95d708df
> >
> > I don't think there's any particular clash here, though. The
> > one thing I do wonder about is that FGWTE3 has only a
> > write trap version, whereas the gicv5 regs have both read
> > and write trap versions. We rely on being able to use the same
> > index for fgt_read[] and fgt_write[].
>
> We do?  Where?
>
> E.g. HFGRTR and HFGWTR have separate names, and could therefore can have separate indexes
> in cpregs.h.

For registers that can be FGT-trapped independently for both read and
write, we put only a single index and bitpos into ri->fgt, and then
access_check_cp_reg will look the index up in either fgt_read[] or
fgt_write[] depending on whether the access is a read or not.
Essentially we rely on the read-trap config registers and the
write-trap config registers being in pairs with identical layout
so we don't have to separately store an (index,bitpos) for R and W.

(fgt_exec[] has an independent order because "this is a sysreg
we check for an exec-trap" overrides looking at whether it's
a read or a write.)

thanks
-- PMM

