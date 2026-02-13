Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617DCEDF154
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 11:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqrfC-0004XR-Qp; Fri, 13 Feb 2026 06:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqrfB-0004XI-5A
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 06:48:45 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqrf9-0006c8-Oc
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 06:48:44 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-649df393c04so721479d50.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 03:48:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770983322; cv=none;
 d=google.com; s=arc-20240605;
 b=M3ILQiCO4ZFUW1wWfMKaxkOS5+jeY40KFe9WPbm4CeAaswvpszCveerFgPaLFwile2
 RwkA+uH29VIdgEsD0TgiN7swjBIY/k0hgmZKxuBbGSyyva881ulU9105U0Y1hW6eMBXF
 85ykfRUojWK3VGn8DaL/OjF+qWlFx7VU9Kad4ZfVTDE+mP7X7/HVFzG/P5mtiDjIi9tT
 E+ooCtLl0E9HuWti3fCFgpHq9M1/gS+7/nDqlFimMQEbCJgtwzrF7VAE8Z/Ouwd0sG5s
 KKFMXTUQbldNQPH5b8xMRdazgD5R7O7X+SwYXWgQf36lDk40Aqxx0JKk+Nrv8j8pMtbg
 Iw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vQYVADlqckD4qRUSJhcBbMIqsLHFtKKBwIh0kUEjQRI=;
 fh=Kmddrc17pJFJQKkh+yuJkPEF0blhZPzWvyl9uZUwwfQ=;
 b=FV08AL+5wFq3wFHGxjd0ya9JSPuvYyEkCHeioL2rKlicWcEUpy6X4GVl9oi6YdtM1/
 N2mZAACQEOv0aKdSKJBA//lLbiPBh0mW7CiNIgnRgjxF9I1EPvQEQHBWrikRlWRNbFHK
 2NC/3zXl8GvjL6qundsHIcDRqwYkj688O1hXUKSAj+ZDM2quf6WFwW2jWQdtHQCA1ooi
 vxa+7FCtvDJjU97qD17Ul7P32T4bwakBBQygVlMxagq5ooh/jklt8CdjQdNa6fJkvIOF
 7hTE4LauJOOinlB+oD0xzDDHIHxC47usvTuxljgXvkXlPkLFUy/gsVxebEEBpqrsmOyi
 H+vQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770983322; x=1771588122; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQYVADlqckD4qRUSJhcBbMIqsLHFtKKBwIh0kUEjQRI=;
 b=RDsovvi9cQqDe9aOgpWHAhBZyUqsXyWkShdAssSAo5XDt1GyIRAaZ0qcjUePjITll6
 l39E1EHpWID03+mJyE9N81pBvToxdC1nWXTPDjBz4Z9xPI8hskspw1iWlnOBkCjp+/cn
 H5V8DHSiGQNWmvh2POgv3Rwv41+wsK/LxHfH0gdtKmdpauUfSZZP4h5oNn4QParFPEYA
 ij5/wYU/BuWIfOxvCUTT6J8ekfR3rqpC3BoEGj6gapjFszYiQoZsjj/HGm/yCiwX4zVz
 2ZimtdgFP72TEVPh9gX000oM0Kqa9ZunOTlTSxUsz/JXodzBkJVJWsHDYvbqrVCGtsr9
 7IMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770983322; x=1771588122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vQYVADlqckD4qRUSJhcBbMIqsLHFtKKBwIh0kUEjQRI=;
 b=XY3953QsEjvXsIqOjq5J/tBHVfPd2pjw222GOcDME6ikjhWs0trAxk0X6GosXZF8zc
 kAH7Yh+SCw9Hmt9s4JPZfkik8YSo0FzXE63BL4QkZtLep1j64E7dd+D0pOEYDNV9YRpj
 jxM2yI8NAH3jdBNhM79i5S1Bcu4rvdBtxdVTmCRtiRrBbFt7EdxaubmdRzKecsK8azTn
 luP8S2vTX7l96DURYQJvjRKqW0Y9WjZoTv0X7Q/aUm+zLPIb7NH2r+bHDWYRvyf8wdZa
 xQxnsBqlMVVWdWGn3hV/Xp6vBouwqNQApbZGaxqtjL3ttWTOezyvEqH8W611pbXMfGev
 73cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPP6kevy1WGBagPf0SuKIKP3ZEj1KfTZDu6JkVzOs+Vlh1NTr2Bs+kEDy+n037TwfAeLBiUY+zra8q@nongnu.org
X-Gm-Message-State: AOJu0Yzj2PK9Do2vnwl6JgaMnTmGdTg3PDNLiZfLaYT3aMKmMB/pYfxZ
 8Kd95dbiz/2wJQG8qZ4+YokhZLfu9wdtwIDZ/APinP0/QEc+nIN3SyXlLtXf5D9Vk7GbVmohIAh
 I7VxvWS2hcrmhlqeBh7r7Z6QsLP4ECmGpcCiP4aD5yw==
X-Gm-Gg: AZuq6aLQLTVLykmP/7efHjGzMyJP654RJrHWyU6HbFJ1PpPqt/LBHmXbj1WMwXmGfpj
 mRm7aAhyXNxbGOISx7igkCOfaYTUpViHg97ElxFHIQYHX7mZ5DDac9Y1jz3B+RskuMlvhEfqbzw
 7Ia5NU4xJAQJ482BAhkVDT5VJlC9gSjcjSZawxZbAocZV4cWdWe/NaW+VeMqpHiFyPaBdFSlFIN
 REYWJKCABoaOwiXn3fJ8O/DpfqC+p6uBANdHJfPPQCXicUGjvZwGOlmanB5aEI87fFfVhS7XvGX
 4Mnmg59kRqOqX2c0jZrGYijTV7GHxwmWcYnPdwilP9QzF61tIrr+XkAr5KRpnK00kTo=
X-Received: by 2002:a53:dfcb:0:b0:64a:e799:1d9c with SMTP id
 956f58d0204a3-64c19b2e00cmr795416d50.60.1770983321876; Fri, 13 Feb 2026
 03:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20260213102109.107491-1-pbonzini@redhat.com>
 <20260213102109.107491-2-pbonzini@redhat.com>
 <aY8GLhvyOLZgv7MF@redhat.com>
In-Reply-To: <aY8GLhvyOLZgv7MF@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Feb 2026 11:48:29 +0000
X-Gm-Features: AZwV_QgRqLizImNETd24ATW55moqIgBHW5u9sROPDStheHeW1oo9n6aA51Is7ww
Message-ID: <CAFEAcA_SWSO3cufc3MDv600Qc4nf7pipEhCyt8JLSG2rqQa3fA@mail.gmail.com>
Subject: Re: [PULL v2 29/41] i386/cpu: Fix incorrect initializer in Diamond
 Rapids definition
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Aidan Khoury <aidan@aktech.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Fri, 13 Feb 2026 at 11:09, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Feb 13, 2026 at 11:21:09AM +0100, Paolo Bonzini wrote:
> > From: Aidan Khoury <aidan@aktech.ai>
> >
> > The new Diamond Rapids x86 cpu model definition that was added in 7a6dd=
8bde1
> > has an unexpected comma in the `.features[FEAT_VMX_EXIT_CTLS]` subobjec=
t
> > initializer, causing the prior initialization to be overridden.  For th=
is
> > reason `VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_S=
IZE`
> > is not included.
> >
> > Fix this by replacing the comma with the missing bitwise OR to properly
> > combine all the flags into a single bitmask value.
> >
> > Fixes: 7a6dd8bde159 ("i386/cpu: Add CPU model for Diamond Rapids")
> > Signed-off-by: Aidan Khoury <aidan@aktech.ai>
>
> That's missing your S-o-B


I have this pullreq tested and ready to apply -- do you think this
is important enough to respin?

-- PMM

