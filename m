Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F8DF013FA
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 21:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2FUR-0001i1-MU; Mon, 16 Mar 2026 17:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2FUQ-0001hs-RB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:28:42 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2FUP-0005Ok-B1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:28:42 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso5613802d50.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 14:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773696518; cv=none;
 d=google.com; s=arc-20240605;
 b=Ui9640FN091Q2kaMyIld6GGVr+NIPF3mVG0Jj5VaCSSPmh9xubummQGIHLxIjcHDhX
 Iv50qA+h9Bx/01oHY/oyPclMPoK6je9irRsM0WF9UYF9F6FA9cBdBBe2ltGjMa4yTUFL
 a4BWcytmMX2Awaytv1wm2X9gFcchAQJ2dG35UDR0txqyGFxqHkjxoigOwaAyy6bd++ff
 t3diZRGumD0UzGnyprCdjgaouUNu1ALl4Nv/3A/ZHw5qXyV+nd+smrV5JwFzIWJ6Tu/t
 Ztqc+H+q1auwInWsDPyRdrmNzCJakDovuIpJQ87zeawxP2hwkW/Ipdrv/lc98QajznUQ
 gI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6Sm9LqDp35rGBurR5xaPNf93k67YYzCE/D9w0dDsZ/E=;
 fh=cPQQFOZbGq8SgC48/D36D5YkSg2dsZyJyzZ3lZfFLlQ=;
 b=OWjaXF6dhb1SzAqtri2sA24/tIeqOv7P7CpNuVzQzcb5FMQ+OK91ss6lrJywGNPlOj
 I99yPBGlQS2bu8cQY6vYRCnmJaHMHwUOmTJiFpnHtcyZvbcVpy48fiRvM5smDlzEqbc8
 r4WdpB3Yza3yJCOR8hVlE816I25qF2xchgEJUClTMexhcGT0ToSblJyMtTGAwlKLiyMH
 iu4PyRYUd+pXDf2IOcpxDIVvM1ZaApfhPdLJHkI3XRMMo4seJCGqkZgJ2P/PcA9Lx6x7
 m4vCKinRkNNauE76QRVSxdOG7AUJKYBjbuDrErMCsWy+HHDVBfg4VE2mwHRwWGZGm7BY
 58Qw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773696518; x=1774301318; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Sm9LqDp35rGBurR5xaPNf93k67YYzCE/D9w0dDsZ/E=;
 b=ydvzX6oFf0MzIfpy/ZGefUjLIzeD/cn7k1LUyJYhZllMy9j/uAC3cLKV4Z1xRtLi9+
 19NWLzOkktDl2pRaMJ7x86x6XNvGxjCcmv6X9I9xMPdCtaNjwYisyGJFntCLB540n6gv
 8Xj/qG6D9WycQkr+pyhZYlf7XNXDglPsH2rn7SfhulXgq/PccC+4TYKN5CeV0k7cKfTs
 zzD04NfG8xZHzS2HhkBBYvzwh8pn9wfzsE1RKpAF8tKlYe6xueyxzEGP6u3MEF0EY96S
 VxPcbneidpUFhyx09zT8sXGjYItBiMJLYlMmCkCmP+vIVFbL/Ppzr6tU1JUtO/FtxiE7
 y9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773696518; x=1774301318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Sm9LqDp35rGBurR5xaPNf93k67YYzCE/D9w0dDsZ/E=;
 b=U1iSHmxvr4PJjFQ6YKOFw+7jHAadjHI64tWxKVqgnDCFD5IofPGA10iadT9bP8xmf9
 qOrczRc/z/irjsZ2/9dDlcJ2avI+9Pm0Lx6XOiie/RBTH7nmJJzI7eVAqnfc0YG+L2J7
 Bnej5iquwc4DCCoCCIFQFatvoh/ykNpCGLeCNTexROIpD9OH7h99GuLMizsUeQslW0+q
 cn+Smy6+RiQ953WK0iXJ83+K7mxLnXe4bMCnDF7zMU2pR9CtXgpSRQH1gBqV8HA063f3
 t8R1EInQUVGB1ag41+GHvEOUnCZw2zBKwamBSX1J9stgmvqJa0bzUmVzAsSiEABTuYQJ
 QBhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW68+AQAAiCUfElUHpcRdg91sL1BN23yw8/2pGVvm+ZBf/cEL2DWkMZbRRuBv3eYxDO5g++L0DmmQnM@nongnu.org
X-Gm-Message-State: AOJu0YzW+EYAXffjAw/FcrEk2ZP9rheA21iW+sbMrjeQn8IqUjOqk6RV
 Jia/EnmUSF/BPujmhDPJNbeA89OqtyUGK6eXb8K+jjv4KomskXYnJf4XEy8+IpxnaaNNM8KMHPM
 z4zsqHI6OrTj/1tspGCOJQpEQqCUU7UxAjxvRvuTq8g==
X-Gm-Gg: ATEYQzzP2t55HnwPpJ3wZ6Xpul9yZ3a6md5+/NVa3bUFXm3QLAHm8WjK0QeIb64JClu
 +vNWcAAc28IhL5wrx+g5Uxp8oDDWZFXTGhn1gZj7MDN1B8DbkNs+QBIpC+mkN9Gx3JjUIsowW3u
 gyFmKMh/KhW4M7jA7Z3XuJut+M6EOwk/U8S2s0jOI3ELHGhr4NoxmSXjo+96K+dNqznHjFf90rd
 29NDJGFIOp/86Y12oilsnaqiqC6hrrKg0Euo8s5/qQSrO4wv60qwib/YgHawRPguUt3g9gJVuK2
 iY3BSW31UG0yRLzZhEpXMeFKmJQH69KJMjA3Hs39hqehqPfSNzsyUnD5RjUI1mcqD8s=
X-Received: by 2002:a53:ee5e:0:b0:64c:9a9f:8803 with SMTP id
 956f58d0204a3-64e62f28a79mr10449219d50.14.1773696518527; Mon, 16 Mar 2026
 14:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260316194759.22672-1-farosas@suse.de>
 <abhyg_wRK4_RmqdO@x1.local>
In-Reply-To: <abhyg_wRK4_RmqdO@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 21:28:27 +0000
X-Gm-Features: AaiRm53ClOWYhfJooADSpLMeBSapJqt_0Gc8DdNrjpJjDJv0v5_Om8wqp2tINb8
Message-ID: <CAFEAcA-OJJ7aqbWp04unQ3JG0x017wS4kfN2mxMhCnDpK29gbg@mail.gmail.com>
Subject: Re: [PATCH v1] migration/savevm: Allow stub VMSDs
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Roman Kiryanov <rkir@google.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 16 Mar 2026 at 21:13, Peter Xu <peterx@redhat.com> wrote:
> Is that MIPS board the only one that is broken?

I believe that the MIPS malta and the i440fx PC machines are
the only ones that do "select PIIX" in their Kconfig, so
on the assumption that x86 was tested, the malta is likely
the only problem here.

(For the PC machines, I440FX, which is what does "select PIIX",
also does "select PC_ACPI", which does "select  ACPI_CPU_HOTPLUG".
But MIPS doesn't use ACPI, so no ACPI_CPU_HOTPLUG.)

-- PMM

