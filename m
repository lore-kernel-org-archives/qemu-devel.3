Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3D0C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 14:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFaNz-0003li-0t; Fri, 07 Jun 2024 10:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFaNh-0003g6-0F
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:15:50 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFaNe-0006xT-5W
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:15:48 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eab0bc74cdso22813931fa.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717769742; x=1718374542; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m1g31EP1QemxA2CTPd0NgNSVIzuF7p1smSJyn7t+l0Y=;
 b=l8W9K5Xe7H9NTbch3svnKGdnTnNNVG6Q+K1uBlLv3y+kuXTuCbIdFOejZJdbgLscGD
 hnvWIF/jJP2aFFaGeTYLj8id17HnBsAPxc0BDctBHag8Yag2Uw+kGa88bEt56dzjq5OP
 noGvcky2nx2FsRnBbQr0osVvSzKyA/DnStoQkExSss8Q8seZUGkaqH2LyOu8P4SS6Nf/
 Sn3cmOO78tldB+FOlh8SOLHoK0DqogmkGRdjGgtJ8ojcvj42LifMD63vTiLJrT5eUzNJ
 LSdPA9pXxHa6eeq8XMZUD9TQoxz9WVXkjCcjj4ghC403yPKcgnVA+miqEJX+O4gitQGU
 TXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717769742; x=1718374542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m1g31EP1QemxA2CTPd0NgNSVIzuF7p1smSJyn7t+l0Y=;
 b=nwGCkiElKbsTnIELyJGmmOmj7dT7vKDZ9XGgYOKnEkVT2+9uULpFvVQipzUYWy8e/w
 KoASzJxpRqTFVWq5R3iS8mO+D6bRZfwcyMopMrHZl3KC85YihpDqyAE8btc96QCSRD5R
 iBgoFw4qAUIw32QOFbkIsw50Zd1AUuhmOFNASw4C+nw+rtz4+U1uq1EeEg0JPem+zwru
 T1cAtH5KmLieOw6KZEZOs5VqUqiDSmRRY6t3xO6gbOeZj1B2xzmqi9z6fVbhhIHFoF+X
 SvoKev7M+0fTFf1HPqCHVicb5fc1v3Xs1qdCNnixtKpYyTByCtDeNzAKsaQ/hDzwNKkn
 SPsQ==
X-Gm-Message-State: AOJu0Yx0IwfMp1HZnRsh7VS3RxASzJDNycCBFQ3C9Cd0wqcSIYKl7etv
 T8zd1aNbqwE09AQwsac35fqfEvbY6kti+PMYgrrHl2Zgc0QPc0GfqWQ5eQ9KBsyP2Res0N0SiPP
 ybIfUqxTlILGjUULb1nX1LVs/fEBtVw4KXklHHQ==
X-Google-Smtp-Source: AGHT+IEpK8+cgKx0YQhHkoTVSsCND18CwFIbQzTgMizc3gercQohyTF9XgODZDaWb5msSE0zmorUN2zMIkGc5aB/vnI=
X-Received: by 2002:a2e:b177:0:b0:2e5:2c7e:257 with SMTP id
 38308e7fff4ca-2eadce380damr17803421fa.30.1717769742149; Fri, 07 Jun 2024
 07:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240604064409.957105-1-pbonzini@redhat.com>
 <20240604064409.957105-22-pbonzini@redhat.com>
In-Reply-To: <20240604064409.957105-22-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2024 15:15:30 +0100
Message-ID: <CAFEAcA9k4YSALNG+mJP7Disox7xm-giAknFzfZ2MxGDkPpsTLw@mail.gmail.com>
Subject: Re: [PULL 21/45] i386/sev: Introduce 'sev-snp-guest' object
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Brijesh Singh <brijesh.singh@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 Pankaj Gupta <pankaj.gupta@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 4 Jun 2024 at 07:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Brijesh Singh <brijesh.singh@amd.com>
>
> SEV-SNP support relies on a different set of properties/state than the
> existing 'sev-guest' object. This patch introduces the 'sev-snp-guest'
> object, which can be used to configure an SEV-SNP guest. For example,
> a default-configured SEV-SNP guest with no additional information
> passed in for use with attestation:
>
>   -object sev-snp-guest,id=sev0
>
> or a fully-specified SEV-SNP guest where all spec-defined binary
> blobs are passed in as base64-encoded strings:
>
>   -object sev-snp-guest,id=sev0, \
>     policy=0x30000, \
>     init-flags=0, \
>     id-block=YWFhYWFhYWFhYWFhYWFhCg==, \
>     id-auth=CxHK/OKLkXGn/KpAC7Wl1FSiisWDbGTEKz..., \
>     author-key-enabled=on, \
>     host-data=LNkCWBRC5CcdGXirbNUV1OrsR28s..., \
>     guest-visible-workarounds=AA==, \
>
> See the QAPI schema updates included in this patch for more usage
> details.
>
> In some cases these blobs may be up to 4096 characters, but this is
> generally well below the default limit for linux hosts where
> command-line sizes are defined by the sysconf-configurable ARG_MAX
> value, which defaults to 2097152 characters for Ubuntu hosts, for
> example.

Hi; Coverity reports (CID 1546887) an issue in this code:

> +static void
> +sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
> +{
> +    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
> +    struct kvm_sev_snp_launch_finish *finish = &sev_snp_guest->kvm_finish_conf;
> +    gsize len;
> +
> +    g_free(sev_snp_guest->id_block);
> +    g_free((guchar *)finish->id_block_uaddr);
> +
> +    /* store the base64 str so we don't need to re-encode in getter */
> +    sev_snp_guest->id_block = g_strdup(value);
> +
> +    finish->id_block_uaddr =
> +        (uint64_t)qbase64_decode(sev_snp_guest->id_block, -1, &len, errp);
> +
> +    if (!finish->id_block_uaddr) {
> +        return;
> +    }
> +
> +    if (len != KVM_SEV_SNP_ID_BLOCK_SIZE) {
> +        error_setg(errp, "parameter length of %lu not equal to %u",
> +                   len, KVM_SEV_SNP_ID_BLOCK_SIZE);
> +        return;

Here if len is not 96 then we return early...

> +    }
> +
> +    finish->id_block_en = (len) ? 1 : 0;

...but here we check whether len is 0, which it can never be.

What was the intention here?

Side notes: you don't need to cast the argument to g_free(); and
you don't need to put brackets around a single argument like "len".

thanks
-- PMM

