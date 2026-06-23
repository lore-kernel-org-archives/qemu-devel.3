Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A603CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwjM-0004jv-Fj; Tue, 23 Jun 2026 04:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbwjK-0004dr-OY
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:43:38 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbwjI-0005YS-TH
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:43:38 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-662ebb1329aso2539035d50.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782204216; cv=none;
 d=google.com; s=arc-20240605;
 b=TfE7iKpSuVvUcqGC8vK03e9SWhyVbdvlAyyONx7Q51YAFrZcHm2a+dhBVS1VXdZvg2
 mETbvoGXi4WDJXf3IW7lgrZTZO8ov7I5Jyhudiz8gEZS98BKkiIQfYf60Abae8PYkbB7
 B9+1MhTtAUJlaZcvjptBg25gtr5BBgtxK6Tpelna1YVmskeJzySZY079Tb+ua1vL+FKw
 t3xxqnhmSoOeFFBPd3Rl5XdcyAJK+dlbd93r+x2cU81gWYDruDgkZYIVTzwCyMIdB3NO
 m/nwj818JvKmQTOLXnlRs+4PyjCs1yVbRR38rFDjh3csQLv7anQOwtsM7Kj9rhu/9INR
 h6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WtkBTr+mNefQ1N1GWcU6OeGgvKb7J5DIyfRVg1KYBC8=;
 fh=nqU2qTrUylmjwSPaum8+DG0h3pDD6hPcgtsDXuA2oBE=;
 b=UiJdGwwugucBx6pMr2Xwj0pWToA5eJikihfdLSdhL3RMqAvR+bTmdxCP5zM2a5RXAi
 0UOX/QbXEpYL0ssKFPMQp85KVAG1HKp6rGdT/4oS9QQI0QOVMG8Pqizh6r1oXos9/jCL
 9vrfuwTI+C7zMaFE0CLEdZLglG75lBworbyIaENFG5UY+b6a2FciCqGueyxQ6kDk/4IC
 LjTgIvQMlLzwRTcI5ygdh4Z0Ctsu91v63DNOd+51Ue9wzjwh9q1Lkt8/SG/WU5PfpW8k
 QnY2foXjFnsk+RWR003FpzbCZXqbiiMWi++ZYv8ml2u8RqZwnUZzSyA2zmv9Ko1JNwhx
 Sf/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782204216; x=1782809016; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WtkBTr+mNefQ1N1GWcU6OeGgvKb7J5DIyfRVg1KYBC8=;
 b=zwUDPPI++H28igy1xrY+kmxWX5CYL/rPcZ1DeJ6T2ju+oQT9z4qcZ+Flmo0Z1UUUHr
 Nc8vaWppNHlGBuERqxV2FntmZ9pn+3XtAmjWOYu/x2gm8C6mFApriBnAYAM9M2LSmTVU
 49Lpmrv+FGXTwm17AYMuZYYkMfeeqdXIInZ3kyQozNylv0ngf6vIKQFA4Np2GzsEW5c0
 Hv0Nl9M1+bBlghWGIWElKk1ReVXR2zdreoQGDrE742Q4blDcPkwAla6bG436ofOrzVsR
 Th/8Ryar+vnmsR61xNCWva3030yFPnmmR1xdQ0WxkXY1xVoBrQSBj/HKDwyFXMXLzvF7
 4NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204216; x=1782809016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtkBTr+mNefQ1N1GWcU6OeGgvKb7J5DIyfRVg1KYBC8=;
 b=rIEavjA9/8mk0bSS+dID+rOWi3NCZIa0bGNtvhPlIDYzjIvJmFpMLekxzoZ+WJopKh
 TeZIwMVeaa33dzxH+FC3Ng+AQsBtf7IdM1KgGZahOqmUZmjTOplDSqJp2wPjRrSi5AP3
 KnR8OEdrMK9W7Od1/fNYd4BWy7MALBzJ8r4A1qi8nw64PUn29Kne14mI6cHHx8rQGSub
 E0bXQEANo3+ch8yOz81YDWBQgxkrV6dLN9RBF2MKipDjR9Yl2711zvFm6qrbabhUdQDd
 TgOdnT0pjn+b3s7Y9ZWkwMo34RZK98kcBm/HJi3sbSh3Ccjj8h7Wz4IC8FaNk/cifEFT
 kGcA==
X-Gm-Message-State: AOJu0YwYEW2qroJ6WCRaqIb6hwb6bWMq3f771D5QnkKnfQS7X7neL1Go
 Y9Z5sPhX9Je4XqojSXbdFcCeovnUGGRj7oKic9EFYwE544F0sqKijRDGZFMH+LRaKCDEeFisYWW
 TpVLOEoiAPVZhHvEOXL2cJP9nOQ5TZzh3FtINn4w3rA==
X-Gm-Gg: AfdE7ck2aSN54IvoOcb20utNlf0obQ/Fn7guUPJQWqCoGB+GJilIIMAmp/57DVkE3pu
 b1wkUBucMDCdf2FjgtbDD06c9LNlclplkj7c8KP0IJtpYnpwMUT48i4zSOAppRmiHmWHG0l+Bkc
 PcZvPdr6cmUVl6+IrW8tMrTOJeGZjWk3YHh3tNhzWc2pmz5b+EaOzNNbbr/cRZ3qJNRhEylq0fN
 gKJhyUzINUyvCLMhb6u3ADqGzCb9Y3WXiwJ7V5QKRRWl4O25mZIrxwZUYfPDCm6ArzRb+3NbgA8
 MxrkdyyrvZkwMJwjn4nWK7EeKMQ5M3kkInu12OS4ts9s9rYzVuXwKnxB
X-Received: by 2002:a05:690e:1286:b0:657:a0f4:ac1d with SMTP id
 956f58d0204a3-662ffc5751bmr15642454d50.12.1782204215693; Tue, 23 Jun 2026
 01:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260623005813.984238-1-alejandro.j.jimenez@oracle.com>
 <20260623005813.984238-2-alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260623005813.984238-2-alejandro.j.jimenez@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2026 09:43:24 +0100
X-Gm-Features: AVVi8CdtOxm6W5cle6lv9kA1iiowK4C8PyvO3LzNmOait_YEYxoYDeAqbiLDPOU
Message-ID: <CAFEAcA8_K2qMU_0L1De2a7YjAnORt3GRuL9=7VqpGNU1ii4QNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] amd_iommu: Return int from page walk status helpers
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sarunkod@amd.com, 
 pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Tue, 23 Jun 2026 at 01:58, Alejandro Jimenez
<alejandro.j.jimenez@oracle.com> wrote:
>
> fetch_pte() returns a status code 0 on success, and (small) negative values
> on failure. The PTE value itself is returned via an output parameter.
> amdvi_get_top_pt_level_and_perms() follows the same return convention.
>
> Both functions currently return uint64_t, which means any negative error
> values are returned as unsigned and then converted back to int by the
> callers. This does not cause any issues in the current implementation, but
> Coverity flags the type mismatch and potential overflow.
>
> Make both helpers return int, so the type matches what the return variable
> is (0 on success, small negative value on failure), and also the type used
> by all callers to store their return values.
>
> No functional changes are intended.
>
> Fixes: a1c97c395729 ("amd_iommu: Sync shadow page tables on page invalidation")
> Fixes: 786550e2d38a ("amd_iommu: Follow root pointer before page walk and use 1-based levels")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

