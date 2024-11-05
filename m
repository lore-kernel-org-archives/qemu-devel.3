Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B813D12691
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Hyk-0002Xy-N3; Tue, 05 Nov 2024 06:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hyh-0002XX-7M
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:44:07 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hyd-0001EZ-Jo
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:44:06 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so7171758a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730807042; x=1731411842; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=prC59/RjYTQR+Kq4azERnJZuSIqib3TR6CNw4N6mc9Y=;
 b=nylyRQ8BzGJkj1SOBUzGtqaAnqA7NTaSpDVh8whF2UyNIBW39izVYM7jDpB/B8BiOq
 DEGvxLRvMHWZMsoSvSqljqIOpwByXQI0gzHFKeu3NV/DEU+YeG2wiE4gw3isj+rW8/+G
 dm6j4+ywbwW6o71JOKIEIt2AMze7Pcwrtb8UC3nerR65iY8Nen32rDvEEAHhYwAC3CRI
 Y3lL8vGLuYhj8Z6Ey2xUEBhcbGNGrPhEoMS6q6yNQSCZuPiLha0VZtGheYHgJg30z9nL
 pxq0wE1kY7Kjy/PiQFAiHPno454dD8B0eHK4zAqx/Pbe/ML5QWUpW4s72qTXp+n6jxR4
 uthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730807042; x=1731411842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=prC59/RjYTQR+Kq4azERnJZuSIqib3TR6CNw4N6mc9Y=;
 b=GmwQhh1gL3K8+4Y2A/jmC5NbSyxmkzRg2JHEbpQIVkKpWxWccOIR/SSTnf+E8P3ISJ
 gTm692vD0gTnMstiRkGgSEom16UuoMsw5E2EoxWUWsnqg0uAZm6CRLzx1RbOq+Xi09fh
 QUF5Ekxcp7HqKY2NgkI+zMJ2C13LvKSazegdro/FHwU1NuWC9/6zv5P2N6XnEnDwRROD
 L/dm9RihnGgzicWvsr0G6r6XbDQJLjP993JyU8+Y1lh7NZQplVlfGIDF3m5Hj4mQmfZI
 c+fYaIRwpb9Hi+7Zf3DeCpRHiEBVHCjhFrpbtDh21b7RyclZFuOdCX1AFTXlWEPZ8e1u
 XtBA==
X-Gm-Message-State: AOJu0YwLQ4ONuWAxO4BGoF60BbgVNXBHw2Mx/vNNW6uL9L+q7bRly/yk
 sEnktjWJpXZuOUvPydCBDjYSkt7zFD8oA+2YgIvdrqHz0bkSatWeKh9vYiQLWtt+JgFg+LPbxBC
 Pri1tCjDRPuxOSgfd2vlGpnQNxTzW+MRx3+yYOfEyRPPxEHl7
X-Google-Smtp-Source: AGHT+IHFdTNvCp/erv412sj7oUnJRmKMLe1GIme/d+vTRZa53+G2O5+tEJTlzWXdFJOf/mzhCwKljUdBM4EV3rvwCjc=
X-Received: by 2002:a05:6402:35c6:b0:5ce:d2ed:7a45 with SMTP id
 4fb4d7f45d1cf-5ced2ed7b20mr6659389a12.0.1730807041658; Tue, 05 Nov 2024
 03:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20241031175214.214455-1-pbonzini@redhat.com>
 <20241031175214.214455-24-pbonzini@redhat.com>
In-Reply-To: <20241031175214.214455-24-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 11:43:50 +0000
Message-ID: <CAFEAcA_mJtsuqSOnDfBLuX+cTuAmDHksRhGA3jq=5tUS5RKn4A@mail.gmail.com>
Subject: Re: [PULL 23/49] hw/core: Add Enclave Image Format (EIF) related
 helpers
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
 Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 31 Oct 2024 at 17:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
>
> An EIF (Enclave Image Format)[1] file is used to boot an AWS nitro
> enclave[2] virtual machine. The EIF file contains the necessary kernel,
> cmdline, ramdisk(s) sections to boot.
>
> Some helper functions have been introduced for extracting the necessary
> sections from an EIF file and then writing them to temporary files as
> well as computing SHA384 hashes from the section data. These will be
> used in the following commit to add support for nitro-enclave machine
> type in QEMU.
>
> The files added in this commit are not compiled yet but will be added
> to the hw/core/meson.build file in the following commit where
> CONFIG_NITRO_ENCLAVE will be introduced.
>
> [1] https://github.com/aws/aws-nitro-enclaves-image-format
> [2] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
>
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> Reviewed-by: Alexander Graf <graf@amazon.com>
> Link: https://lore.kernel.org/r/20241008211727.49088-4-dorjoychy111@gmail.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi; Coverity raises a couple of potential issues with the
read_eif_file() function in this commit, which are both
"Coverity assumes the file we're reading is untrusted and is
unsure that we're correctly sanitizing data from it before use".
Could somebody who understands the use case here check whether
these need addressing?

CID 1564855 "overflowed integer argument" --
basically eif_header.section_offsets[i] is from the data
file and is a uint64_t, but we pass it to fseek() in
read_eif_file. fseek() takes a signed offset, so if the
section_offset in the file header is very large it will
be unexpectedly treated as a negative number.

CID 1564859 "untrusted value as argument" --
in the "default" case for handling a section type
we call g_malloc() with the uint64_t size from the header.
If the file data is bogus we might try to allocate a
huge amount of memory, which will cause g_malloc() to
kill QEMU.

thanks
-- PMM

