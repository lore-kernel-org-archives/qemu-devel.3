Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FBECCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjbq-0000a6-3e; Mon, 19 Oct 2026 05:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIjbo-0000Z3-6G
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:24:44 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIjbm-0002ol-L2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:24:43 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6798c43a3d6so1175561d50.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 02:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401880; cv=none;
 d=google.com; s=arc-20260327;
 b=ALlroiK+oQmH6FP2sPYExiImhoban4DxsRnnnm0eBIOncUa3pqYyMfwuVIyCE+BtxS
 C9fkqqhAcK2q18L6BPal2otrwYgTVyw4V7TN4j8KGzSkqitXaeKIAp5LnSriuZpxIYyr
 3WuAido6Jh1CbFmIJL71ml+LbTHJyPiT5BdXYaTqzikI+UOJpcvZ+ou5VzNlsSGb/yDL
 0+fcC/V6wkwEs+qLMYQMjYoGW/ywhXuKszAtuLsTUWwE471h6pCF2PKXGxWBVoM5KNOO
 p22r+dxIUlgXpc3itO8np8CXCRjkcQFI9tly8WSSnqA4decqIW7hnqDG+8/+KBgkOl6e
 Rb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MNENA/MC9L+77hx3g/q/IU25eQjNwPssmSWwXIKL5Tc=;
 fh=5Cdf/Z4kSBQryBydwDs/SCIZcuS2qJf1GkOYkDmvwX8=;
 b=owm5xQnHzhq1m77/tQV3QQZ8hlXoWcs+KgdPOTYGm+vUQdq/Evv9yVeC5jX/9iyaKP
 PkLW12ZCJjLlBHVD9lzihDALstTBCFrFen26RFQmTmnhJX0H9eKXA/nvrs5GWFZh7gcS
 5Yer9dPg9KE4anC0vIbtHv5LJNCOJGhrgXN4zpLBbIHykN6rhRWXknZzlUtKiG/LNSGs
 0/cd6QBfd5guG+Wg8I6lzyt6GW2WYWU5EdBQrKxf7AWeaLZzBv28Jvu7eWExtyfoqKy0
 zy7+baLCPFnI+YuvCmGZxoPqedbEqpMeSzLVCrPF5GT8GomxTGOFQX6N0nt6veNOOhjF
 n7MQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792401880; x=1793006680; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MNENA/MC9L+77hx3g/q/IU25eQjNwPssmSWwXIKL5Tc=;
 b=Y7HZ6afo52d6BNX3aU5mbQC3KW2DMdzuc6gehxXTgRIiYaDs6wFoNVdX3e1McBZw63
 eTSYH2W89qx2RXdqbRSNm9xJdIdd/4n5Zumig97lHR7eWyoGBijjbwOxEBMt5JfOwxYi
 DgrMJHCLlY3ZkggeptOyKhZq+Z//9vilqJA54njteAhjTMaoth/tdEKF/YBbVyDwCSZW
 prMCdSujWs/yqXrpPO9QO0F7spBCHnzCqqrUMR/oeQrivnB4+eOdLIB4pCvAMw3kcCPd
 6SzHvKAF776+aPjUzX0LJ3Q3dMO0fbFMgcrYi+mO7ifFNivCjaKGaCJ2hfCzXLmeuAPM
 wH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401880; x=1793006680;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MNENA/MC9L+77hx3g/q/IU25eQjNwPssmSWwXIKL5Tc=;
 b=eSpnQS5ycLfGdXZ5sCZlyK3ojtWbc4BpCcv8f4C2Z3ZhhKa9DHhciqOV0jJN+Bkp0e
 ATvpBC5WFAK24oeToyT4uO4PM8QcjyRRMM24Dr+BiUhUfu8Q5CiNtG6ovTg7jRUY43xV
 ahK0O1VsCyiR05ZD1DfKQJtYdnbbfUpg6GKsq10rbQYy4558UsdKQCM1E94fLX3hwK7b
 nFKNSYMPqCoLWbr+Q4Y4iK9TYaD2DaOk2mrIyD2mqRv+Tc2Q8R/dpMs2uJENjKtFbMXL
 sJOPsR3d7+R3AThvItlGydL6ksdxHaijwAVIQjxhNaiy62vJKOXD1IdtX0mOwqixvfj1
 SAXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy75WjxhuYKuMulpW4S3jDHcevSgbbHewRazwG3HpDKTYtluSlsPlGcJGaxyeJ3faiQpPOehNQA5D/O@nongnu.org
X-Gm-Message-State: AFq9FYJQbsB6lyfUsGlV17tRo53XRXdgJo4G4FYeZOKtId3TQDTMutrE
 EQ8YN6mO70VGH945n3++8PGsW2aOizY1+vzvj8oeOuINP28mLxCZGKIuMmkdJxEoRSyoHgULl6Y
 RXHGBIJdYSXEZ53lfdglu1q9ICMK25Le8dw4MzHjiCg==
X-Gm-Gg: AYBFou3a/rF7V4E5RHlGeT9jvVpmmVyIfyiCm0BxnvUVr2jq5zlBXv3dijCLn72542B
 TyWIstMhJf5nyGa4ldl7iPugSR9BQNnboO+TvEF9vjxMJBtTnBtMvf/D6LboY8j2SXriCntfZ14
 Gg9XGLeQLWqrkkf5XDlyAk8P1kNOggDvyYVoSnORYcx0657UnTGv8WLpqZ2zTiPUzBJTEM0Nrgf
 UD8mVsiy6DQaKAdo2ydIKiRD10XHew8SwVy/veGQDyby1pzA+5LCW2t2yTN6Woq5tLY22Ej891Q
 95zm/bS2ezlSzEI7Osot6rePq8e61d3ez9ucpvmvR9cRCbbPlRkEixx37tOEvThSNqAUNgw91AV
 AegSsAxFB7gQAfz4290a4BOPTPfpQDnFQCiYvTss=
X-Received: by 2002:a05:690e:e89:b0:679:9c43:8599 with SMTP id
 956f58d0204a3-679ca573adfmr1752717d50.8.1792401879841; Mon, 19 Oct 2026
 02:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
 <CAFEAcA8MyrqWC7=A5Bw0G5G-2J64iTLmfY33dNDLm0jvmRb+Eg@mail.gmail.com>
 <27040691-e4b6-44f3-b588-cbbbee13cde2@huawei.com>
In-Reply-To: <27040691-e4b6-44f3-b588-cbbbee13cde2@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 10:24:28 +0100
X-Gm-Features: AclHuK8T7IlPIQFv-s8rGXV6qKTa6j_RBW8npIig5AVCHtrtgTbHRe0lx-FU40k
Message-ID: <CAFEAcA_4xb3CBL9TTAdKMOG_ijWpt9wsveCp0R602VoFaWUH1Q@mail.gmail.com>
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Jinjie Ruan <2118537295@qq.com>, anisinha@redhat.com, armbru@redhat.com, 
 eblake@redhat.com, imammedo@redhat.com, michael.roth@amd.com,
 mst@redhat.com, 
 pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Mon, 19 Oct 2026 at 02:57, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> =E5=9C=A8 2026/10/16 18:20, Peter Maydell =E5=86=99=E9=81=93:
> > I guess my question here is "how much is this actually doing,
> > and how much is it 'we provide enough software-facing interface
> > to keep the guest happy'" ? My (rather shallow) understanding of
> > MPAM is that it's essentially adding tags to memory transactions
> > and then accounting how much bandwidth each tag is using. That
> > seems obviously infeasible for emulation, but on the other hand
>
> Hi Peter,
>
> Yes, I agree with you.
>
> Implementing MPAM bandwidth control and partitioning at the
> performance-effect level in QEMU is neither feasible nor necessary, and
> it is not in line with QEMU=E2=80=99s original purpose as a fast function=
al
> emulator.
>
> We only need to implement the functionality-related parts (i.e., the
> register interfaces and control flow) to ensure that the software stack
> can correctly recognize and configure MPAM, without simulating the real
> performance impact produced by those configurations.
>
> > this looks like it's rather larger than a minimal "we provide
> > the register interface but it does nothing", so what are we doing?
>
> By implementing MPAM-related register interfaces and control flow, as
> well as the MSC hardware topology in QEMU, we can understand the resctrl
> framework and interfaces in Linux, along with the related hardware
> topology discovery process. This facilitates kernel debugging and
> pre-silicon testing, and also allows us to debug and test test cases,
> avoiding the complexity and slowness of testing on FPGA.

Yes, but what is your implementation actually *doing* ? If
software reads some MPAM resource monitor, does it read zeroes,
or something else, or do we implement no monitors at all?
2400 lines is a lot of code for "nothing actually happens".

-- PMM

