Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E4510F2847
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69V9-0004q1-UM; Fri, 27 Mar 2026 11:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w69V5-0004pt-Lk
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:53:32 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w69V3-0004Kf-SD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:53:31 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-66abe08cdf5so3661412a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 08:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774626808; cv=none;
 d=google.com; s=arc-20240605;
 b=PvFmpg6rqBE02Ay836mBLYsM3FlDA8YtKtnM2sfA6SSllZzRLvhhE+ON4PVSL4Uf8P
 QlblJCsHdviWuIsyCodAPEH15bT9bMP4iOz9gMfq+JpW2IS8faksrVeqv4gaBlASytY4
 UnULl5jV40Ks2V1A3/dWfs/gwAg/bzorkrGZxmZhxWAVRu/97C/UDDBgrSo7LeDq7aj7
 EtCNsipkbda7Z2oPBu/yTc6vSv0VveKnpcJcVLbVbV1o22K0pDu2KBaZ340/+retvX1Q
 qwA36BzB+jl2Z1tNzpqY+J8hwdy8+Vl2H4M8dc34zu2gXO6c84b4zWVlOy8yfQL2dM3a
 2qqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uKxXzmI6Pip9Jr5AZ1GJWXpGvtGW4EGWEgZvKSIEiAM=;
 fh=Src2sy71esXmwPLI/R7hLn3T5jzgjEe6se5MSKcKL68=;
 b=lZo1In3yva+X1y4nMVvjKANScgF1Kf0s3Q4OZRTnf3MUmODWNGw9DqA+9lvTqXogXZ
 /2s1Mfv+ynEky9rBj1zoYFmJRH8eV2ZesWbTHMIoESLcScqwaNL6w9VsvNK1nkhbTU4R
 640xtqwHqE9KSMgOjMg2TyY4hsdQ+4+OEstZsjVpawwv3dwgoD3VgBsoi4qCxzijCMDW
 81YIkA5P5AEgEgshUXV/LGBfK9QxmAzXWhrj9tycS5iyprS1kumQuBo/pOa9aaEAhmcG
 PB1kcDr+lo9Rua4PTrGEqHWRqaB/7KrSiuFgXjihAUahxT8BPm03Vw3QPRrg1O7hzBg4
 iIxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774626808; x=1775231608; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uKxXzmI6Pip9Jr5AZ1GJWXpGvtGW4EGWEgZvKSIEiAM=;
 b=nf2Fft4S8j2owXf3ZZiqlnVrsnCGgodO1BoQUwmlIfFe/VNE4ECjAXLTz28RFOAv+r
 Vh+RB5d5DckcpucprVCF6bKNl633vicg/bPFSxe7XV1TEeqO0QlP7fbCQrxpVpDnoI51
 C0YoXD/9C2rJSMG1Ih4G+V9R4HzYtNwuISE7Kz8TTqaqoZ5X+1tvlVoxqzd5VA5DtrXG
 BlWlPlU/CC7g9tHAfgunkb1PGk9WiAZCugg1n/kNB39B3hnl3VXRWUlgmEblfVP5jL4G
 fW08UHUSvRgZf0CA1GvaMFM+tiiWCHfsl4vOedVw8GTy/ef1XGrsSFebNC4a88vKJBa5
 OWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774626808; x=1775231608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKxXzmI6Pip9Jr5AZ1GJWXpGvtGW4EGWEgZvKSIEiAM=;
 b=sHPfgb/+Amgb1vpB+EzvuuwYVgVvNr9Cy6eNf2btdL3yT/jkhlgqjYugnekhfecRts
 vdBe52AVt6TjkVxbYgxSKeppR8Mr9IKsMkV2NhqJ5GVrMEo4J4jlL4Tjv7ehFIdaCGS/
 XRHyiRAgKm4PAYW9qC4Bn57aUUGa+RiAIC8x0fDyAS8LH8nVoEzWhMcKkHrBzmxWyvm6
 JiN/UPPfVC9/gN4JTdPjBrVKLW1svTZt+31FtMd00XEYstpjJiAqSI5OfijWFIOO0YXO
 FxKg3eEoag73fQn4hX7ieZvn5qco3Ima4afpxnEyhP+FxP4OK4aOTQpA1B8hzzsragsu
 0fmA==
X-Gm-Message-State: AOJu0YyYggpWhbxJjwPmm/esHozpu9Fj2l+4xKAdRIPrJ8MfYlDjD+47
 qB6c7tjtfd+rJQYt8gWUIA3RQ520PFtsHXHb3X75LZNDRdn/pTXm0/JVbLoWUCT5y1MebAhdufo
 ZbUZN7+lJmeOBpAW8bgWsXcq8S3kR7YQ=
X-Gm-Gg: ATEYQzwrxCcLsZY33CoRqOVqsWVy1HGZ8jwPANeTVdvJVtVaYBP1Gpd6B2AVr8MTp6T
 trt8RzSes0ORAS22u69S+kHfJwviwtRvGxhTxOn4GvWQ+qF05beIrnVTrDohw6WDaSFzIXQLtID
 eHwi9/KjubcgLeeZs1g5DUakGYvazpOn6hbfzwSJl5DpDljJhiQd5L91+ea+G9HFYWc9Z3eOQre
 Xojrw0zycfKyr24HuLPvFLIe/a7h0A9DxT+9FbKK0FcazC7txHWmqi235ij31cvFLzoTYq3O7ZG
 IkJELQn5pXMU+wpEk9uH1PK6t7UNefa27EllLpA=
X-Received: by 2002:a17:907:1c09:b0:b9b:46ec:2f4d with SMTP id
 a640c23a62f3a-b9b50937eb9mr238854266b.41.1774626807692; Fri, 27 Mar 2026
 08:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260327030404.1840571-1-hayatake396@gmail.com>
 <874im1ib6o.fsf@suse.de>
In-Reply-To: <874im1ib6o.fsf@suse.de>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Sat, 28 Mar 2026 00:53:16 +0900
X-Gm-Features: AQROBzDNUEUCrJcnn8GDTCZPRPWTZhVDWZzE3lrkxUrG3ZptyRHDXRiLJ8Ocjyw
Message-ID: <CADFiAc+uCn1diKbpHGJ9yBUJbzaCEwSdmd3mF-42_SeZngqRVQ@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest/migration: Add mapped-ram/postcopy validation
 test
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=hayatake396@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Fabiano-san

Thanks for the review. Here's how I plan to address each point.

> You could choose a shorter name here to make it easier on the eyes when
> calling this multiple times. "do_test" is certainly superfluous.

I'll rename `do_test_validate_capability_pair` to `validate_caps_pair`.

> Could set args->start.only_source here to save a bit of time.

Good point. The capability validation only needs the source side, so
I'll set `args->start.only_source = true` to skip launching the target
VM.


> If you move the start and end into the caller, we could use this
> function to test several pairs of capabilities without having to start a
> new QEMU instance every time.

Understood. I'll make `validate_caps_pair` just take a `QTestState
*from` and let the caller manage the VM lifecycle. To allow testing
multiple pairs on the same VM instance, I'll reset the first
capability back to `false` after each validation.

> I think this would be more useful if it were not restricted to just
> mapped-ram and postcopy. Take a look at migration_test_add_suffix() and
> test_cancel_src_after_status() on how to define a test that can be
> applied to multiple strings. Something roughly like this:
I'll follow the `test_cancel_src_after_status()` pattern -- use
`g_path_get_basename(test_path)` to extract the pair name and branch
accordingly. Registration will use
`migration_test_add_suffix("/migration/validate_caps/",
"mapped_ram_postcopy", ...)`, so adding a new incompatible pair in the
future is just a matter of adding a branch and a registration call.

