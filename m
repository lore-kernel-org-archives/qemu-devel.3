Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B24F3092A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5zK-0003s7-3Q; Thu, 05 Mar 2026 05:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy5z5-0003cz-1t
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:31:18 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy5z0-0002IB-EY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:31:09 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64c9c8f8783so8250123d50.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 02:31:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772706664; cv=none;
 d=google.com; s=arc-20240605;
 b=S3J8UpsXJybdkpCq96AmXgFUDxCJgm56GHoVl0sIAgdTlG8PZhcPVlcpalBG0NE1h/
 qDqdfdUas5S5UgiBjLM8aTpuiGg2FVNFHP07fvQE2OxyNGMKDs82ZrPcAn3zHbuehlyB
 QAUQTMQ0NVnfgdCAHsFeps66d0elOs0I+YPqs8pX22GixuxUWSphd+yHsTooX4LapK56
 Hn8VDee2upDp+zhrBtMO04WRUnu3lOVLZsAaBbriMOD5x4FeS9FOrv9mQFBKC1WwxirS
 ozfXowL7/4a/J0BbMrCz3CJxkQ6e+O/dU8wa5ci47bnzg4E4iqb0A7cn79+pvp3q2uSH
 HoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L/sgNTI14UkJFbod7mAAG/+RB46nPcq7eEnsyv/EAco=;
 fh=Iv2tLzVNkm98GOgCEjbGxmvJTMGDZM8LrU5lvzKRa8M=;
 b=GL4HQKNNOrWdWDfqyc7+TBIvAI90TkN2RibefOb+IgIVaOjQe8IK611KIwgaDBAAt3
 LsrNEsC07Xyzh0Ix95A1xHF6O8dFiPRTlgQCrOelsYU48Pgec/3okku0Xkpg1lt5KCmU
 TNTUZolYgc9gnT4P4qqDNWfWnWMf+pbpXhLU0mLQ7cJswVbB5jHiujF1f/lQdqzpiRLj
 fnjhMmL8jPOVTRAirsOy+bcQgeJWY7fBByfhHXzlET2+0o6mHSEvR4xYRI7AJ8HMv7r8
 ++mMaV2V7YkN009fdhERfCgrQY+AVQ9TTpyGK+gER825h/Ty57hPuxXe2CMR6vEDxwPs
 41hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772706664; x=1773311464; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L/sgNTI14UkJFbod7mAAG/+RB46nPcq7eEnsyv/EAco=;
 b=xYxARWreBXMJRsSFyc5apsEByiwQt5VRgKa/1zGdhs5gHkx9iXKusN4yMig4VAgKJw
 MU2ud2p5Mz40Xx0gV0UvnmAWe1XNCSlWpU5M4Sd8NWUGRC6aEHfZeCTy7GhaJbQAvabc
 ID5w/AxVGF0sHPBsI29CydkY4gbIMbX9fd+AYRpz3kGZFYwnIPAFlEHOwJgbXpNtfybB
 iNUYhlvCT1sU1l7HpzgBSurk0Z6+p0P3PTeLBsnzrNl7oJkwP/su6C1Tux+Sk4AH905Q
 7v7u1D7cJZI+uzd8S4KB16pgKJw9+VTkha7EsJhWKJcsJhIcHnaPWin4iYDaCAkbrsBV
 3DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772706664; x=1773311464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/sgNTI14UkJFbod7mAAG/+RB46nPcq7eEnsyv/EAco=;
 b=IAlkr/hyy+x1eojxkMaGrNiaDh/TDU1LajYZtf/RKuEFoNTmlUSCPjpjMKrjQ9yYkD
 yXmh9+Pn3WAf7UzQ5QrzEzscriY7xzgdimIkiQsWP9v/YtgWyu8/0W2x8l//5+s4/hw4
 A1Kj1h18zvJrFDmzR33y6eXe8pm2taoLkrHqSmt0K/iUoSKy0RAHwr9gRelHvMwmfXVd
 dAi2qSDM2JjyfQgC9a9yQzi7z6fHtpRxJZNNjlp7wd3vVH8qEesqSZPM+cWrjomNSOVf
 GLZ1hwvUcFzBkYdRPcFLkt5bErzO2bF+9WN/iCL6diKF1zi5Ib+/spYTWsrPxDWp3gxY
 5a2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwKIalhr6oDM/uD8T/idTbU4XbRl0a//0eE3+BEom7rLKhlC24kCwKGObGqS3KhEksdYeqj1Usdiuy@nongnu.org
X-Gm-Message-State: AOJu0YySS57Oq78XxdQxigt9xEhcUg3f2ek0Vs/nFxcSKjvCZBTpqDPg
 Nfdl8VJZwDj5wi6GMNYUmoIw5C/3ToEeZGgPtOKiu35RdEwM38mr04xxF59VZ135/woFKTwqGLe
 cAskfemusH7Ld12iMwOOA1ITw1RtkVhXSFJs7vGPBHA==
X-Gm-Gg: ATEYQzx73z5IY1dsf7RoQ4E9HSkmGVUNUgvdjRVN3WmbosLHQW5BdKdpNlH+YwlcHrO
 llQd5AmvVakE9fbHDp7qb9r4gOBLnyrgUG+GGNAHjCtUsYUn0uHAqchoK1sAuB0Br4QHa3Q7Z5o
 rAG8INxor70FbSlLOAvpB02XmgEwzALF3fhwAURWy7iEKY71CLJ1xb2E3hJY4aOVpk670aFCRTD
 jeH6iZIQKaMVOKOvPmSklHyEUpACWRUbTyFD+xvJzHYMtzE9+QoI9JASIi9nOM45e9g07e4nVeU
 JaABIIBKHP+wZVOV5g4fim/DzT6F9WSf61gsRkCyKwETPlu0STuBXz1Y3ro/4j/csOA=
X-Received: by 2002:a05:690e:1a93:b0:64a:d742:6773 with SMTP id
 956f58d0204a3-64d0715016bmr954301d50.43.1772706664231; Thu, 05 Mar 2026
 02:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20260304101625.1962633-1-eric.auger@redhat.com>
In-Reply-To: <20260304101625.1962633-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 10:30:52 +0000
X-Gm-Features: AaiRm50oQDw4faDAAZk82aIjfonUknKw8uyjOLVgt-Ze0i2T0GrLJ9i02aAxafQ
Message-ID: <CAFEAcA_2PDthqLRNgdrJo+qdoWXa0pNgJmB2TAzFr6C0=HXRiw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Improve traces on migration failure due to cpreg
 number mismatch
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Wed, 4 Mar 2026 at 10:16, Eric Auger <eric.auger@redhat.com> wrote:
>
> This series comes as a follow-up of discussions held in
> [PATCH v6 00/11] Mitigation of "failed to load
> cpu:cpreg_vmstate_array_len" migration failures
> (https://lore.kernel.org/all/20260126165445.3033335-1-eric.auger@redhat.com/)
>
> It only covers the improvement of the traces. Actual mitigations
> are handled in a follow-up series:
> Mitigation of "failed to load cpu:cpreg_vmstate_array_len" (v8)
>
> When the number of CPU registers received in an incoming migration
> stream is bigger than the number of CPU registers seen by the
> destination we currently get the following error:
>
> "failed to load cpu:cpreg_vmstate_array_len"
>
> This series removes this cryptic message and explicitly outputs
> which spurious registers cause the failures.
>
> ---



Applied to target-arm.next, thanks.

-- PMM

