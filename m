Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D338C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2QQS-00010d-MO; Fri, 04 Sep 2026 05:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2QQR-00010O-AN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 05:41:35 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2QQP-0005ZO-Mo
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 05:41:35 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-86b03b75fecso13441417b3.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 02:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514892; cv=none;
 d=google.com; s=arc-20260327;
 b=VoDoydSjJtVpcHQUldzQA8H4lzaDifjFvR9aikIxd+LqkD3fRCRSLkUCMlyCq9pZZu
 kLkmGDpRm9LPS48IM3ho+aWMWw3EMCeiMmPs9ZIYaUKUUGMXr0knb2lD4LS4UUJ1kg7U
 fn7Qo05E421/TjTABElqtH8sZFvw4PcGkifqmbA2eKKbG3acIHDbjBRDlIn2Y2NvRYr9
 7n42m1moGtCBydp/QYQZChGX67b3isEQK6cmd3UoCXC09BmmDw5Wgpwjx1c+/lkwPzVE
 7l+VpyDcg6kN1ESwyAx9wnUmYGR2hAjvfy+D202IMeBxm4qUPROU0adCkpivynpodVth
 MN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p0VlP+BzK4Mn/ciijMswVLrKwto6qEsK/U5eLekulww=;
 fh=OgXYGo0wXK9WFWROm5iEemULu6NnfCpnPhT/U/K1jPk=;
 b=mAmRPrCJz+Fs8stz2SRgn+bw8xC96aTEgeIM6+X4d1hVjfJ+FEjz/GcFejBcuMNuYX
 dv6aRkbSrHD5yYKq2j+C1D/yIQo8UlhUyZAEq9zw6Mebz2B1j+aqYw3dylT7ktYVyLYp
 GO3EhPbW2uR49OqZgr334/bKWCMFL//APgr+Bj2GwbYtpBGFM8Ri4Pl3UOnwrpqAnT3A
 qOnm/Jh+sIXYTBQbDd9JPiXBH8nLrPMrkuOWQswYL3FCpNvX6WAm3NNLiTm/B9yAgBCo
 h2ToHEL8Hp7SJdiZjX/RFMpSUldaWY6URRECZ8uKgdt/NoP313W/2ld4zLWQIdK5psRv
 7xWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788514892; x=1789119692; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p0VlP+BzK4Mn/ciijMswVLrKwto6qEsK/U5eLekulww=;
 b=W90GZfYNJx8Z/bAXzjuFZywQRL1oX/e4eImudCDL7QiF4as5CYcqv2o/eg4Rndv9Xi
 RF6g1OB0Iz3JKiDwnzWOcS0diaEGq3oRMJKT7NOYOXOTfggB+sjw0lKysH3r3xI7UWQa
 tNfiZsapSFFROsU8zeM6nXB36CUGUzJC1nYwLGXoEzJ8FKOGhc2atJjRluo17EswYdXy
 JtpuJgCRtpmblJiM9UciJ60Zg3a8Q8OxLq9dw5CVz77IoeE9HREUpk2WkTD5s4atbeVd
 tWOUfHqb1DdLiz0RLz8m1CC4+rSC73KvAe+SW9gaiU+86rOkdvJvqhMsZdUdCd0zrri0
 ItFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788514892; x=1789119692;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p0VlP+BzK4Mn/ciijMswVLrKwto6qEsK/U5eLekulww=;
 b=XvkYpK+bIPv1qOI/3iHcKTnQsuIJM8Dlyo34E2SJ9Ob4UZghIcQyD0wOI/2jnheu+7
 /uLW1xGs4kiCmcQF9qL2PSKSAjjt1148OacYGUie0fhkbCnIyB6+Fb/aMHjuHJ8eDgpD
 p6XJMgKG+apCgoyeFf84COpkXIcSbs8SPY+Rm+fFD/4Dsno4JEhfOPAGwKxaWJ3HmQwi
 AoeoMxYqy5SnhWymz7Ms+h9z7JUBYjeojmkWucJERsblnWqskO0581+P61eUt6TQii4d
 OgIFc1sKAx7v7b3DuX4ZHfmHcau6hnXIqubV3qqJgEw2VVvSNGTs1UbSa2LzM/aUyoRn
 630g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdsjoKTGOv5nnOLSTj64BKPxQsqGD/6DD9HRslXKHwBWsgPJTsTPohfnCoZgh4LaFMyHoCILt3B9Qw@nongnu.org
X-Gm-Message-State: AFuF++m2nkncAZmU34ZdVeNTB9c+LODDr3GjpMONVzs/zExCqoJI1GAo
 yz16aHiTvZwPDUDe79+MYxRnFibYw5RqPDSc7gUy9rqAh8acUYbfY3aIdhs1V73+d16wPnFtPfe
 1Bt5C945FBi9XAhlZjECFne5WTN7o/Axd/z/ghMjSKQ==
X-Gm-Gg: AYBFou2LtsBtvBHeDUUDABmrgz4GCbC+JsNFa/XAh71k3yYnrdTmSvQTsGIfkl/z0l2
 O0SxKj+jZG7YmQr4R0mv1ILJpcOI9vJ0tym1jqVU7xUEE6e50gMDqqLSWnXkmLlbhShuAJ/Hi3U
 xU3WF8U2rj5XF4ru7F51KdZCBN9jyoWIMtqdsRJRnz5WR4KQRIsv3Gc19yrzYzgLDYbomZo+zgn
 UamEMuucaFyrtJu5ubgpBfiPGxc1Vf/7vm+a1hzK5pVJ3aW1DMSOk/nltdBUARrNLtTgllb25sb
 p890RijDrGM/7tSJ05Z+jxs1RE27/NxKBlrzTX9dofInF2AnK7IqvbZUDCrxrBzmeCJC1V+1N2f
 S8b36Q5z8Gj/G9zf+b7Scy6u+cG4/
X-Received: by 2002:a05:690c:571a:b0:81e:9f17:8050 with SMTP id
 00721157ae682-87125ef9985mr22738637b3.21.1788514892146; Fri, 04 Sep 2026
 02:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
 <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
 <CAE2XoE8FTYQMDZFdjf=gayR7H0MJrO=thUcFXddRWBd3_2KQZA@mail.gmail.com>
In-Reply-To: <CAE2XoE8FTYQMDZFdjf=gayR7H0MJrO=thUcFXddRWBd3_2KQZA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2026 10:41:20 +0100
X-Gm-Features: AcwNN1Un6M_dtRvV0aWq0C6RXUHmJ6cbK0UZ0cxtWr8_q229c5VU4C-Z5L3HEgY
Message-ID: <CAFEAcA9eLNLs7ZRaH=PS7tAK49WeJzc0PKfWVG3xKRdc-joU3w@mail.gmail.com>
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
To: luoyonggang@gmail.com
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 4 Sept 2026 at 10:34, Yonggang Luo <luoyonggang@gmail.com> wrote:
>
>
> > I was wondering if maybe one way to approach that is some
> > "disambiguation" syntax on the machine name; so one could write
> > "-machine aarch64:virt" vs "-machine riscv64:virt" (or whatever) to
>
> That's the Proposal B: target only in -M or argv[0] (alternative)
> Do not add -target. The target is always embedded in the machine
> argument, or inferred from argv[0].
>
> - qemu-system-aarch64 -M virt: single-target from argv[0].
> - qemu-system -M arm:virt: single-target from -M.
> - qemu-system -M virt: error (heterogeneous not supported yet).
>
> There is no global option that selects TargetInfo before -M.
> Early option parsing still has to read -M (and argv[0]) before
> machines initialize, the same as proposal A reads -target.
>
>   qemu-system -M help
>   qemu-system -M virt              # error: heterogeneous not supported

This should be an error because it's ambiguous (and ideally
the error could include listing the possible candidates, like
"Did you mean 'riscv64:virt' or 'aarch64:virt' or 'arm:virt' ?"),
not because of anything to do with heterogenous machines. For
instance there's no reason
    qemu-system -M vexpress-a9
couldn't work without a "arm:" disambiguator, as there's only one
"vexpress-a9" machine across all our target archs.

>   qemu-system -M arm:virt ...
>   qemu-system -M aarch64:virt,gic-version=3 ...
>   qemu-system-riscv64 -M virt ...
>
> at:
> https://lore.kernel.org/qemu-devel/CAE2XoE_-ewv3iC_MZ2sM1eKG=CUKM7MZa-ppJV0Vk1rE1h+19w@mail.gmail.com/
>
>
> > disambiguate when just "-machine virt" would be ambiguous; but if
> > there's only one machine of that name then just "-machine foo" would
> > work. That extends nicely to truly heterogeneous machine names:
> > "-machine my-mixed-machine" wouldn't need the user to explicitly
> > give it a -target option or otherwise say that it includes aarch64
>
>
> Seems this direction is fine, May I post experiment patches with this direction?
> The machine-filtering is still needed. and when the target is not specified by machine parameter. The default TargetInfo will be target
> SYS_EMU_TARGET_NONE. And it means emulating heterogeneous machines.

I think we could also let the default (no target specified) work
for non-heterogenous machines, as noted above.

-- PMM

