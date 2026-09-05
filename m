Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8032EC624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 12:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2pcI-0001XZ-FM; Sat, 05 Sep 2026 08:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x2pcG-0001Ww-Rk
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 08:35:28 -0400
Received: from mail-qk2-x10.google.com ([2607:f8b0:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x2pcE-0005th-I0
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 08:35:28 -0400
Received: by mail-qk2-x10.google.com with SMTP id
 d75a77b69052e-52fb570631aso1357761cf.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 05:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788611725; cv=none;
 d=google.com; s=arc-20260327;
 b=nfxrvTF9l1P/YBinpnD0wyl/GWyWTBWHHseIQ7FMFXFCSnjP9I33TdYJdIHJCPBKqy
 BJOZtDe6wmF2zm6fIwkY8umcobXPMphtpheCrlODCNziS5ub7JmpeUoIezN3N2st19Kn
 U9hBv8xgrArJrifazx5VDRd3cED9gHOM2syiL+M/d07sF0YvogmrMWC3GqRI83ej/Im1
 GkFQy5jhUQCQhsKNTmZH0z8I8LUmOSq+oK3G/cW7qrjbQviGBNCp9cY5sbYe1iP2rhPm
 sv4KvETQ1Nis3n1t0/jzR9GsUPQ2gBbcwzBpznPzRkPShKJwk3Bh1svWh3vaj/MWe22q
 rWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Yj5TuFDOoSluUNKPvkj7TOC/THmw6MFGsRBW8ytOkrg=;
 fh=AMTzCobT6ZkD2NCmRWtGTUb7TTDU7LlkhhU4as/mdVE=;
 b=JZ8FRppOHaViF3ATSLvspQyaWcuV9sxBI0Dna4SizncPYnyix0IELY2TfDq0xKywm5
 2awjKRv7iY8SPmx/XgGakz6DR9of4i94gPdKR2PXjGgRJj5MNpMwha+HCtGgjWfI12mF
 sYxAeaBALTa9GBZGkk7Owg4BsX5xoudTMIkhf7dmsyMBH9/sDIQLGPV8qXHExB0UgZp8
 CrKQlP8O4yd0CPo8fqkBi1Ce1u25iIF566cpnDN6Q2H/miCqNBMsuUJLJ9PXRL4+SWpC
 kUrmN7PVNvBlp5eNNYVkJCXjOOqkqylYtVIJ+d6zw21vak3lc81hDeTATJ9KciY/IOjG
 0wCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788611725; x=1789216525; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Yj5TuFDOoSluUNKPvkj7TOC/THmw6MFGsRBW8ytOkrg=;
 b=FcIp+ILP/wI4R0S07KsH6sYFk0jg0Mw2/kVkTK9E/xRUCga+Po457Ldin0q+fLkuru
 W2tUo7JxuAUv0FSUXY5UBW8zFJ+yhN4wnuEsnvkFzHzjtUO1Zuuep9rQNbyORiV/SwUW
 KhhEjF6dMrFSTAZa2l6G/whou8u79YIOxtN4H/7ZnIViIltRG+Q3f+1XJ3viM8VLlYgc
 1cBnlqidjf1iiTE/fIfp+HoFR5CY0jCnbohKo6Z+xacOnViPKf9HP7P+Q9R/PBfZPyuh
 Vji6HIuJOX5XNC0UsybiMXWTKT4gYmRtNzJQBRBLSqAAz2YPPCCeqTSbl/zHF6BoiyPd
 5uMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788611725; x=1789216525;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Yj5TuFDOoSluUNKPvkj7TOC/THmw6MFGsRBW8ytOkrg=;
 b=p4ZQWWPfC5Sffd29weunt1RzE9k0IYnhU3Cqp1KXcjaAGsaii5yPcIn4LRozyfugAV
 a5QfzfP2Ni+VPd4t0O3DNk+eLVy0SD/2ioFIdvwnUYmmUA+e5RpKiZVuWHdR5fumURkx
 J+fmwL6+ZIC7lxPXTkPQ6dUZllABtuX74cqw4FVT1jFdQ/wSwbC7obvk5XOzPyjUGNkG
 KS25fftBeE5KRtndRcIw3zTPXN9NsLJE4aFGy/wUGFvjdXldIhzkfk36Cl/I5gtYWU/5
 nFkflQb4gZevxtJxM2ZE7wehKKdIwrTbAXKiAaA/GPgMfGGK4e8fvsiu7mODu6F+VRk5
 INDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5OQ7MJeV3V/+CCFME1J+gS+rfFTVwckIxg8zOYe7BhJgGfeZ3BVW+X8Zd+eIxv5971mLPgB5KzFM3@nongnu.org
X-Gm-Message-State: AFuF++nldeJk2mqyL0UVPekrE47aa+MTCN0AtNtwZjLUPuLaIiTwE/EH
 mLv7+CgQFV6Uo+a3HBiePgcx2HBiIJC4VyJ6my5LZnS1KN0FxIzVJMthYVT4j4VKQTmLF2HFFlg
 U9dQM3LvgpOaX3cilSe+MLqIXFBxbq+A=
X-Gm-Gg: AYBFou2ValoZ3CyksRgrGynxIEYwPbFWgNxS6/ukdiMBbCtMO3oSkVgT2gaa86Iku73
 mbO/0OTW3D6zExeTraHIhYXLLZ+aTo6LY0lv8cAYq2L30VKBm37Jd/gbt171Oj6jVd/0rlqwEXA
 lIshBKo1wP7QYG3oE2+WE5vDfQYplKfpkkOvpgU6sX7llJW85t6hpDv8N9XokjdT0YHVnyFVh04
 pfTPiFaBGYWKBk/Bzlj4kyLMMYkQPYpgD6YCOhvhrUcHCel/ni6he+OzZGf0pfTnOuCOUnjeZQb
 lZHi4RPYy9AkFzTZFtHwrE/V5rXKtfG2G52Z8ip4aXA=
X-Received: by 2002:a05:6214:5c47:b0:90c:df51:1051 with SMTP id
 6a1803df08f44-910476b884cmr37729336d6.1.1788611724937; Sat, 05 Sep 2026
 05:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260805124519.30054-1-danielpaziyski@gmail.com>
In-Reply-To: <20260805124519.30054-1-danielpaziyski@gmail.com>
From: Daniel Paziyski <danielpaziyski@gmail.com>
Date: Sat, 5 Sep 2026 14:35:13 +0200
X-Gm-Features: AcwNN1VxqQOwdTFjTgpeTLamZssgrzOis64-3D99Qi85y-osTrg7TgFO93CgR6k
Message-ID: <CANukVxvWEvcQeaUxwX6K56_2FR53faOCSJWBT9-n6Vv6QyKeug@mail.gmail.com>
Subject: Re: [PATCH 0/3] NVMe hotunplug and PCI SR-IOV fixes
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-stable@nongnu.org, Jesper Devantier <foss@defmacro.it>, 
 "open list:nvme" <qemu-block@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:34::10;
 envelope-from=danielpaziyski@gmail.com; helo=mail-qk2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello! Since of these patches, the nvme ones are unrelated from the pcie one,
I have decided to supersede this series into two separate series:

https://lore.kernel.org/qemu-devel/20260905121812.47816-1-danielpaziyski@gmail.com/T/#t
("[PATCH 0/2] hw/nvme: sr-iov hotunplug fixes (assertion failure, memory leak)")

https://lore.kernel.org/qemu-devel/20260905122924.53813-1-danielpaziyski@gmail.com/T/#u
("[PATCH] pcie_sriov: register user created virtual function before
realizing it")

Please, ignore this series, and apologies for any confusion.

Thanks,
Daniel

