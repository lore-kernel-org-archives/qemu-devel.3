Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C595E10A88E4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nXU-00015P-4R; Thu, 26 Mar 2026 12:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nXR-00012i-SN
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:26:29 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nXP-0000GA-Ud
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:26:29 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64e8cdafeffso1533159d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542386; cv=none;
 d=google.com; s=arc-20240605;
 b=cxYw/6Y82yUdao4UHGESF7QzUs71GPUtp5wo7HgW2MZnm7zEl4OwvhlO0taaOvpnR+
 0fro0VmATjRcIO+8SCnWLwHdHEQ7HHdJ8tv4EzzRNNp1ynx4RAYP48gM8qB4yNwB3DQD
 sW3RYCCDGE5zzr9+2gdV5B3xQpKS4pnNjkUqrI7l4FgvZbxB5rtESfA6+j1WUzmL6fI3
 hmqB7ViR0dngDFkvjnrBc8fq7q9wpsZ+6LcMIXebEeumRwxI8IrvkZRzr+oKQHdlyOuG
 ajS9eMl8g2LoTGJ9AgAM23Lv6n7+sKhO4fCTpEkyrcuzaOMhL9gHJHwYae6D+pIWKpJm
 ZdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yaffYYovtD79pWvM9SxQeugim+qdZOSUgk9LSwNM3Ag=;
 fh=HTPvbb48pvvew7vhUKgLof3MF4iC/k4XA4OrNYti4Kg=;
 b=bqvacddhh3q/sJGh2H3zHX040tYcuAiCsRMqOu00A1v2pIFk/Qc8qmiBQ+8GHJEMMn
 lKKhWdLJoRDh8YfuWsuvXfuF38QksvkoyCKVvyRTruKHIuLLXHm+YlmtBus66EwUadVo
 EZOFEkZ5Hg2chOywq6St7z9fyuxrqq8FG+JN5U+4wDbsvS89snuNmkPYCFd/cWCivOvI
 NDYfNRh+NF8jYRRIYX8V9bpmQM5LJZtOWmicRq+K/7spF36qe2JxvrJxTlDNdQ4VDVqj
 3Fw1E4d+Y758KNQjr8q6Pll7YqIV2dBmEtO0UbSPj3MqMqZgYgdvUOBhM1GIpQ5O17q3
 v73Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774542386; x=1775147186; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yaffYYovtD79pWvM9SxQeugim+qdZOSUgk9LSwNM3Ag=;
 b=DOzLG2Jlyb1wmQJsmGOP9cuL7C842j6TF6HFyIgm9Ky/tXMkxgJSXWnM/kzp+KuAN7
 M5CwcZfwkYRToBvk8QR/QcNCoYmgJfCTjJjCJppfZE6x0+1OZAoS1kHMWV5CZePJ9REP
 Xohc54L4Fu4YgwCDx+UwMWry4VTtsub87mMHagNfPNE2/DRO3nNWZmYn+Di8VLtHZMBU
 2ypvLtqqlna38tpvtVItqEm7pIHzr4z/+sFkB1ALVDDuO+qFsotL8Pr/N3z4KpquHwSY
 MBwgilQdCQlRHVttAh4oKyomMVrlm8TiO9m+PyNQg3y+JRbFcesJ5bqGOkEr7ERNHCOT
 TpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774542386; x=1775147186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaffYYovtD79pWvM9SxQeugim+qdZOSUgk9LSwNM3Ag=;
 b=oTPZXSS0wjpIITflSN9HdLOMky1PiwzH1Bdhz9pUeRatJV5gSi9+IFryIJkSmz4qVs
 U6kW6J/H4xfQD91dq4Sa6tVcQY9TfAqg2sCfbFL55dAtdaJnHWAdp+DHtDYI2XWQV3K1
 cwtvzP9LxF7OdCZm8dM6XSUEQv0Kpqz1l09+0ugetxx4E1gD8llvHODMXqu7D836CsZd
 cW7WCpxTkGkVlHltH8VBUugPlENYPz+UH36uIlks+3LAb1GEokgVKH+AfidzyjOR72xi
 BVMIF+YdGpZd/DhbKtNZcXG+wBkV2rfku2e1ofPqe1Qr0fbMqVMykmCxGWwPqfxi7P/O
 FRTQ==
X-Gm-Message-State: AOJu0YzCNoQNS2O5f943Ju4F3pzMZvrKYkjgs8m3FV3Jc/bziWT+sfp7
 e8z+/yvNqfnYXs9AWxRVRA3HKJLFsBOZ28Riw7xCL4spgk2csq4ZhuvgBiKTq+ENMGuFD1LwHyP
 j8yPXDo4ByDq9N6znC2bKlL0FPtxM2OIay36b7jxwxGuKw5SfRLBfIOk=
X-Gm-Gg: ATEYQzxKMuP6/xkGT0HTgcqmVvQVf9LE8V92t4nw3QdyCh/TnEqeXJ6h/0FyLF0GfWQ
 gXO9J3XAwSA7oCKDiB5lBpYQBgPPamzVw6l+bb5NUYTcIaudr9oG/28QqR9NLygkaaCS1xyNGMe
 LkYbiRxYa3ork9u8bJOYO61ljtRA5/+Rw2pacx1b3MWtkIjIYFNWfC6uKgFCisYRupEQA0jUzOm
 Z5TVwvbunbjnqEhLKcBe+ibeCg3hAQhl1c367H5U0L5FbXl7Up6l/num4XpIWrJsVlb68b2pfG1
 5GNZXYvu6r4+lesRbeUc4FBgyUW2q4+gcw0t+0fJ4fKRECdryTsdDldcoehAxWqrDbRE1lgCCTp
 /RQ==
X-Received: by 2002:a05:690e:130e:b0:64e:b173:544e with SMTP id
 956f58d0204a3-64fee26aff7mr1882284d50.25.1774542386030; Thu, 26 Mar 2026
 09:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-6-kkostiuk@redhat.com>
 <CAFEAcA8+qpP=TfSY3oa_2jpH2vD+ot7UxSnVWJCqUVshOCZbNA@mail.gmail.com>
 <CAPMcbCp7GTnH=tJtDkJVFb_hfR_p3uaZV-XcwNdWbQqnH6+VSg@mail.gmail.com>
In-Reply-To: <CAPMcbCp7GTnH=tJtDkJVFb_hfR_p3uaZV-XcwNdWbQqnH6+VSg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 16:26:14 +0000
X-Gm-Features: AQROBzDQumgf5F8BDOONnojIYZHfhP834qttPABj3X3V-gnFQhd9FVYmND7b84Y
Message-ID: <CAFEAcA9WAbKWRhXyB0JnMCbq2VY36aU1bJT450UF-KiKcwdf_w@mail.gmail.com>
Subject: Re: [PATCH 5/7] Remove unused sys/param.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 26 Mar 2026 at 16:22, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> Hi Peter,
>
> This is a very old commit. I tested removing sys/param.h based on 512b794b109 (Update version for v11.0.0-rc1 release).
> The full QEMU tree was compiled successfully, so I am not sure why we need it.

Note that "it compiled OK" is not a 100% reliable way to
check for "do we need this include?". For historical and
backwards-compatibility reasons, the glibc headers have
various places where one header might pull in another.
The glibc developers have in the past done cleanup work where
they fix that kind of thing so you only get the function
definition when you include the header that the standards
say you need for that function; it's quite plausible they
might do that again in future. So the best approach is to
check the POSIX spec etc to see which header it says you need
to include, and include that one.

-- PMM

