Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C122B10A62CF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5kvh-0006EA-Sj; Thu, 26 Mar 2026 09:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roberto.foglietta@gmail.com>)
 id 1w5k7t-0000bn-IF
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 08:47:53 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roberto.foglietta@gmail.com>)
 id 1w5k7r-0002uf-Uc
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 08:47:53 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79ab2f6ca48so1376637b3.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 05:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774529269; cv=none;
 d=google.com; s=arc-20240605;
 b=UwfDa4+u+7n1IYaBRtxDKJvA0cNYvKS4R5l7sShhTlal5m/kXuCT6X3fKpgPO5c/Zy
 y8KDaHxTDHZKjezCkLbPKFoEOGhq9VFwshhIpPkzPZm+zC/7NOXWuyUrkmfx4dL54i25
 Srl2XzjNrYp7ujer5O4mZWvc7VvYsfdUS08SINqHDOX1oIP8cq4K9pyP+jOCb2HB8hKC
 bL6zzHqBwYVEslqQmKjWA6HK3P68BacZZ2uSHWS5zzIGBeLO614SnIrir0kJ9XKnq7xD
 PQzzltVDWWydGkFbb5Bl43xNONTbFBgNJP4lMSQKhWmNcR30a9piiYQDHjc8mh6CA6Xf
 Zaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=ED6vLNOaBcgBaZT/fcJy49Wl0w0+Cci154I+lSZLw4U=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=Tltgy8hlxRh6NJrpzDbZuMO1mgFq4TLsUxusqSk7X64epCow6HO4kdIRfbydP8SBbu
 eZaBoQUlWwNpfF3OOz7xAWHBYFEoEJ0lEMs0Mt2tcl8D2qprdigvWZUVwQluTy2Plrj5
 AmMl1CKbd6dX4IoYP48h+EslCMCHzOqXiG4qdTc2jg1pVxbhujIMgntdibCZzSJisxZM
 iuCOfveIRweio+RExFY38i86u6fG7H/cONN7TZZ+O+CjbAtLFzCQCEZu3VLSN1N99rDT
 XU1wkHHqAMXLz3zdhZkMw9OW+GTWOuGG6nIH9y5/9o6hgUXDJJyiIk1eZvIrKyow4mXN
 Irew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774529269; x=1775134069; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ED6vLNOaBcgBaZT/fcJy49Wl0w0+Cci154I+lSZLw4U=;
 b=VZK0OpqqFHYRVfq1hi1OZI7vNZITENrIfsoAPPrXBsERunanxj5RErwQas8Jr1Og1N
 bJEeE2TDx9w3Wj7QMClCLAfZ6ZghUDj7sN71iIQEzcm5HaN0eBN0quFJfCGBudJO014B
 1rn0OWyF5f6ci+fU0tNXXkeZs8Ca0Rm82KtB1YeVmccrlTmsEfMIDv9O61maDHLn6FwQ
 lEeSWc0MkNJvpCU4sCsEK9b7gSR4fDpr8sNfWlROuDb6i7XiabVEXCaid7TSuj8OU6wx
 XKJQkCGI3CElrsmRi8xgBx2/1APaokTKf6esTAzzgFrgEbPOkQjPfma9QvpAqeUpkgKB
 sJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774529269; x=1775134069;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ED6vLNOaBcgBaZT/fcJy49Wl0w0+Cci154I+lSZLw4U=;
 b=HeYqsQ2g1AG4Q40IWtQ1W/iHmOBTPBdkyZAO8Uy2rjlVbONAZiknt/Ri5MH6IuQvtz
 E6jsed92it3og3Ogbv7z5J8MaMEpMWwtW2EKVqOfVh18+Z+fTP5ZsWcbKkm7yZ1S2bZr
 k02VnvBOyoHFAgn/BOuYCqZJOfDx4A28TP1waP62Ss6n+cKjc2bDQyMNIeBU/oBraa3K
 /Chrubw2QS+eT9Ubi4m38j3vCJOdTGzirzeQHyRRV2gy1ytmTkcUz7HyE+RyX7+b91iJ
 Ep64WOfHHCRHk1vLTXayRXT1rg3oprzlastyJyR16u1u61lpS4jztKOcwKHmcjgQU83+
 bK2g==
X-Gm-Message-State: AOJu0YxJrb+xa9whGmW2rAVy6RGdKZ370SjK4tmYH/NOvvG+MCSH8HbI
 DwBmm+Md+5sOhZsdSdcEqcWCawVz4QN7BhsLrnt/Y9QA5iuDcw361IeHJl4RSoydGo6pNvfS4qI
 0W7kkxNyJCvzECkayAk4wZBXBNznwCTu06W2VxIFV
X-Gm-Gg: ATEYQzxYs67dImDRXoZJw5nM1NUK4qTTMx2WmmZcdZs9GozmcHefqVCs/2gyRNNfKP3
 pbKXM79+CxHdBA7DifJAVGYmYesD9Utm+ORhlLRo1dX3Lv4tGDHSA3dFrslHiulMHOxQ3dcGtWd
 OgpiWxDZwdpg7rLLI0Iz45BJJzaf7NZlqJRFpaj66/F+BvwD/Qd3e7lCXXJWPWdeCEJ0ZitzrZt
 ND0T+ON5NqCVDopyQ+JoFSAL4rMx90HctzxY9f/+tLal8Q7jZI83pc8WpCoPnzFG1hJxqdbqPbN
 ZH03XD9awTxaheSFj5skc3VEt6d0ER6oYg==
X-Received: by 2002:a05:690c:c530:b0:79a:b46c:e60a with SMTP id
 00721157ae682-79acf6c80ebmr72236217b3.44.1774529268860; Thu, 26 Mar 2026
 05:47:48 -0700 (PDT)
MIME-Version: 1.0
From: "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Date: Thu, 26 Mar 2026 13:47:12 +0100
X-Gm-Features: AQROBzDLPMNX2lr06bpctG3LdNkLHT2otjwhO_EoO_t5vhdkKSbgFEuGzhHKA84
Message-ID: <CAJGKYO7o9RWK2QAvcUW7Gt_mhiO0MP26XTX7POPubyOyOc8Y2Q@mail.gmail.com>
Subject: uChaoSys v0.6.5: frankenstein glibc-musl static u-qemu boots in 0.06s
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=roberto.foglietta@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Mar 2026 09:39:19 -0400
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

Hi,

uChaoSys v0.6.5: frankenstein glibc-musl static u-qemu boots in 0.06s

It is worth to note that the whole package uChaoSys + u-QEMU +
RNG_test once compressed -- by gzcmd.sh in a self-executable or by
gzip into the initramfs.cpio.gz -- remains under 6 MB (precisely, 5.71
MB).

uChaoSys is bzImage + initrmafs: 1.76Mb while the other two parts:

FILE: 'qemu-system-x86_64.gz.sh', HEAD: 1392 (4),
GZIP: 2715646 (2652 Kb, 35 %), GZSH: v0.1.6

FILE: 'RNG_test.gz.sh', HEAD: 1384 (4),
GZIP: 927519 (906 Kb, 39 %), GZSH: v0.1.6

~> https://github.com/robang74/uchaosys/tree/v065/qemu

It is capable of executing itself `qemu-system-x86_64 -M help` when
included into the initramfs. Instead, the complete self-hosting and
self-emulating isn't yet tested thus granted (also self-emulation
achieved, cfr. comments).

This glibc-musl static qemu is capable of self-hosting and
self-emulation. These aren't strictly necessary features, apart being
the definitive binary healthy check.

uChaoSys initial commit date: Wed Mar 18 23:04:46 2026 +0100

Total working schedule on uChaoSys: 1-man, 7-days.

Best regards,
-- 
Roberto A. Foglietta
+49.176.274.75.661
+39.349.33.30.697

