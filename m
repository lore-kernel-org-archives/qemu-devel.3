Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BF9D2CE17
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 10:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTH22-0005wB-Cl; Wed, 10 Dec 2025 05:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTH20-0005vR-GI
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 05:02:48 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTH1y-0007Am-S6
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 05:02:48 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7881b67da53so60475277b3.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 02:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765360965; x=1765965765; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wOtCVjxJBUnbbumcJnmhIiF0s1COVmZGslAgmskVQ9M=;
 b=zuf3UPZAapXfLE8lY0tUf6rwXYw4sSuoPTAA0Q8W6KBg6DSUDF4AFBv4JG2Yy3vls2
 4Avytocdwm5n9GVA3xBPN3idf+w8rGr8d2bBEpDgPx/7o5kS6/7B3fs6UjtF+nhBLtam
 UgK0gOTXWdM8M4rO38jTWK9xpkBbRDsBEpMNNHBUNrab2hN7+7KcA1PeTnCOx3G0ZplF
 m6Z1mVDZQ+fH5AenZkKaXYCF0P2kJgpJnK1+eec60+Vu+7nWtGIUK6efmIxj7Sm6T+Ph
 Drq6RYUpUdOyW+JGmkLOS4YJfICPowYD2lVfh1GDt90ZhuEZjZS+tlyZyheuYbYC7S6M
 YE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765360965; x=1765965765;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wOtCVjxJBUnbbumcJnmhIiF0s1COVmZGslAgmskVQ9M=;
 b=FuuIcKzQc1zyiA7p5wM370a/m9ciFzMio9p8HBI1HPmcMnrlbgWV9Y85dnLBPnY5PU
 uBkJN34PmrvspHIX4RLsahgUbZqV90rwgVxEeIs+WH16Oc8V/nwZzHK17fiLyatOhn0f
 tJ6dhg5h/nFZuMI3pnGlw5UyxhcFvJsNGn8lE//JmF8lal9CDlm3nL9OeKMvcnNzOnic
 FR3uwidVsqqHdNQj2JglgZhDBqpGW6EruWgirpjT124YPMQHCUTnV9rP0MUHIMK1qW36
 ok6M3eLgRMtdLapgkTsHsMW3OxshpNxw9mW7+EccH706RiQm5pJSLwLuWp4QTl6mRq2X
 5nOQ==
X-Gm-Message-State: AOJu0YwqYydFjNTfhYIyE6/Ka2EciIoLXI8KpAmTn8bXqEv+c6Pr22sg
 ZJOilKgmDu/zxf178xMzGJ1jSqm3tpf1cRnwy6ZDd7NxBSAQfYMZ4DmjXKdzzmXmegNctXyqv4H
 33toT2B2xXISX4BxGih31FuwMRzI8O+oGpWoFfNsOiw0D1suCH2qil/A=
X-Gm-Gg: AY/fxX497fXCup+HkKmmGQVxgkb9vEK6qwargwUkXQGws+RixQFgTGVjFRvjGhAbQwe
 uhErdjFj8y37+miyJbr3jut/YcXXO58cBg/uPI/o8M6L7i+KRZZx38ba1QHXV5l0HCeohQoHdX9
 zw+REtoVxlcLf15eJZIam1XP7btpjGrxuadCJpE4VA8i0MNV8zv/ZN8egAUrjRYEEJa8A3ApyM1
 3QLmK07QAb3CyRgHDhxAm0NgdNdtmLZh2TxwGXqdgNs6pP/5dR5P3JRFRtZikgrNpHskVrq
X-Google-Smtp-Source: AGHT+IEGhB1yuKGaJTjQ3rzh+rErlYL83PiJeESB1ofw1P4H2gzfXIFV8pNBM56yDJFzHsJQx52t64qGnNJ0CSzjcxY=
X-Received: by 2002:a05:690c:67c3:b0:788:131:d053 with SMTP id
 00721157ae682-78c9d72d9b6mr16507547b3.43.1765360965455; Wed, 10 Dec 2025
 02:02:45 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Dec 2025 10:02:34 +0000
X-Gm-Features: AQt7F2oXZVQN6wq8A1GmdZ3BZsBVgXft0gWNO3UfeVsAd2cCykNPyp-30aknTag
Message-ID: <CAFEAcA9raNEmY6BP6H79w68G_0SLMw8XLd0RZRu9=jHMA_wxBA@mail.gmail.com>
Subject: -hda fat: vs "Block node is read-only" error
To: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

(Prompted by a user query on IRC.)

In our documentation for "virtual FAT disk images"
https://www.qemu.org/docs/master/system/images.html#virtual-fat-disk-images

we say that you can use a command line like:
 qemu-system-x86_64 linux.img -hdb fat:/my_directory

to get a disk image with (default) read-only access to the host
filesystem. However, if you try this it gives a warning and an error:

$ ./build/x86-tgts/qemu-system-x86_64 -hdb fat:/tmp/zz9
WARNING: Image format was not specified for 'json:{"fat-type": 0,
"dir": "/tmp/zz9", "driver": "vvfat", "floppy": false, "rw": false}'
and probing guessed raw.
         Automatically detecting the format is dangerous for raw
images, write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
qemu-system-x86_64: Block node is read-only


The first of these seems nonsensical -- why is this fake FAT disk
image going through the "auto-detect format" code ? The "image"
the vvfat code presents to the rest of the block system should
always be raw by definition, I would have thought.

The second of them is a fatal error, and means the command line as
we have documented it just doesn't work. Specifying "fat:rw:/dir"
works because then the FAT backend is read-write -- but how should
the user tell QEMU "no, I really do want just read access" here ?

Presumably at some point we added some extra validation on
whether a block backend is read-only, and never updated the
FAT disk image docs accordingly ?

thanks
-- PMM

