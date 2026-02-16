Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463D0E7BDBD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 13:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vryr0-0004BL-VV; Mon, 16 Feb 2026 08:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vryqo-0004Am-7i
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:41:26 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vryql-0002h3-Uj
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:41:21 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-649db2b6cdcso2876484d50.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 05:41:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771249278; cv=none;
 d=google.com; s=arc-20240605;
 b=VOAZkDOHm/baKyMmUi3E09Mv2V2M/hHYuhvPaTIThpiX3n5624QBfegsRlg6KMrI+x
 ABKuFA3giPvlOCcaLhkOVMLQcuAYXFU+lkRihqViWWvuEVGjtnA0+z4qjza4hUf2xS/3
 wEbvqIr0mLIp405Py9l2L7/TmHpw8jzNl/vnUwPOidVZmfnn1P86PXlG7yHSS8e6RPT/
 ShTwGHEflK1oPF+7KtnSwmbodVNaiSBKmnEuPtwjpRY3kGHZAgDLCYZb8rN1HPridmGo
 /OcupFown8TxbeY3iZBSOvsVjG/mhrqZjZ8aiYYnaD3iR8Z4UbDunTfdbOq59YRy3DSY
 rpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TMKyr6NttRPkB25cEVcCNuBuEWgc1BqtKtvpSP2+bN8=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=UHnryQ4aMXQzyG1qMiBzV/j3SF2beEO0/1R0lQw3ApzRT/b2pQU9bCpJiDW02RCiZw
 wLgimZ/cY7H/sut1nLmBuQoqCVxYCSuywmvoh7recTsTHRxLKHxt1pTwPfSDfrcgD7gc
 /RxDQI4iYzuBx3uJUxPiFS86vkknwnFFRSc8FAxrrfOZlrtDxX+dMAVpYGiFcM3A/JJZ
 ZTIeuoepafDRtmn2n+qpxQJQDLmsMRKfUXcvs7y4pRy26/dfSgaHqhXnKCdnB+tbmRDA
 4lcgmDBxC5p6VQyyqeEoEFtQVS2EKbfUFnxJoC8fNlzRSrBTUM+V0cQxsyrd7nPv7fWy
 4XIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771249278; x=1771854078; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TMKyr6NttRPkB25cEVcCNuBuEWgc1BqtKtvpSP2+bN8=;
 b=UpVXvJAvSsuqV7zTZZnsPSG/ejUV13DWKbc7zuDBfvsfk20PMnIpAICy8bXra8HBwT
 cZSkaFSoPm1cr/+Jh3IBCwIL4KxB8Mb817mw3O4XjrCpFR825yBm5WO0w6/CSvqKxk1C
 99b5imICFcCb++DAL2HI9jMTnK/yzHORBj6yG1Ck/RJ7urGRiQw6Sqtw60Nwua1YgCcJ
 UoX0GBZayuHa5Pxq4BDIq4ea0w5QljUO2PdDctfDKvmdl557rQ6P60Zt8vDLTbeGhSRR
 5Bdp0aMReEe/IP9ql/5iml0UNBkqKaIfv+pjSS3eaCuV2v0k+NMRzpNAMNKTFVwEnZz/
 VJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771249278; x=1771854078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMKyr6NttRPkB25cEVcCNuBuEWgc1BqtKtvpSP2+bN8=;
 b=qG2YhljMBus2/aNJzRy2EfQX1Itz1DIcflGn2lfjyVroARII7Ek3TRWlPFOHXQXNMc
 FqIDHz3Y5RQOWAndaoeVp6Z7YDsn1fL5pQn+qgXMSxMiuxf5NPEpVSqOLQGisWLV2nH8
 Tx5Lnrsg+UFzyJs64BMPTNW8CWYLHuOyQyo8o0RyJTClRShdgs854BqhvYay+AkNfIsZ
 9Rq8TeR8pmWwzb/V+mcWXfzQrK2dABdMlZk/mIWSDBEGxdvjPGkzcpc2eJtgkb40i+n7
 6AUX3C3xABiGqUGUooFXxvj9jDKuQFS502FW6ZRA/He9jIx2n7mAG4tnu0J4Ol71bFe6
 UOFw==
X-Gm-Message-State: AOJu0YxIG6SA3Rt8sPeE03ozNNPxSt/GsxwjVnU4kqvTrZ8d3PP91xd+
 sMzC1rXARnNDM6T39KTd4VY69L2B9rqyokWVw960gKQXvQ6Dl06kFsqy2sGnIFnxupst1ucsrb7
 giH1akgq+MfFyC4YSEt5u5zUJPxjj/Ibebt9VK1pxUg==
X-Gm-Gg: AZuq6aKvHZL7+DDJ2b20ROE6C6Jt3JBDb6QZTRUxX4JR180fXB6Qff766OrPIS+LFAA
 jsFZ+6IH990jMfGZxfppVKYkDIlKTugKwC1Y9OV0LOhlXvjFH07Q1FgMCXQNMN/kBsc2gnUjsCk
 DPe+SuDAGXnDxpykb5uymbilxQVGRUIJd1NYkf1NtUO54LHUsWDSXZ/Rq3JebVgGIawI3Re6cjt
 K/TVw/cYAczboUO4hVH9UsWbKMHsdSwVkOt7qTIVj0PYUm2GFzKvKbnS6l7cyymQdxefB2Ycr6d
 DzU/RGdFDfoeSkaozxUofUKyHgLyp84J7+ykSXM/zPZncNkdn8HXOn6bvufjKmhaJC4=
X-Received: by 2002:a53:d009:0:b0:63f:add1:e6da with SMTP id
 956f58d0204a3-64c21b27b99mr5758043d50.57.1771249277666; Mon, 16 Feb 2026
 05:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Feb 2026 13:41:05 +0000
X-Gm-Features: AZwV_QjeMSv6-NugK5-4I_MCoAawXHaboTG7XXCWtEMl5bffqYiFkyWvIMFp-MI
Message-ID: <CAFEAcA9Bf+MGVJTi7_iufyuzXxsrh7RwzcYj1==dxiWhEkjVdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] target/arm: Support SME for KVM
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Mon, 16 Feb 2026 at 03:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> RFC mostly because the kernel support is not yet upsteam.
> This is based on
>
> https://lore.kernel.org/linux-arm-kernel/20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org/
>
> Properly testing this will take more time.  I'm not 100%
> sure how to confirm that the SME registers have the correct
> value across migration.
>
> I'm thinking of a test case in which the ZArray is loaded,
> the test program pauses, migration or vm save/load initiated,
> and the ZArray contents are verified after continuing.
> But anything that takes timing into account like that
> seems way sketchy, so I dunno.

You could avoid the timing dependency by having a test
harness that combined QMP and the gdbstub, so that your
test program does "set up registers; bkpt; ..." and then
you wait for the gdbstub to inform you that the VM has
stopped at the breakpoint, before doing a vmsave over QMP.
Having to manage two communications channels to the QEMU
process might be a bit tedious, though.

(We could avoid the two-channels thing by adding a
gdbstub QEMU-specific maintenance packet for "execute
this monitor command" but unless we think that would be
actively helpful for users it seems a bit hacky.)

-- PMM

