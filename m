Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24932C5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUgt-00076j-Qu; Mon, 24 Aug 2026 09:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyUgt-00076a-84
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:26:19 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyUgr-0002Ho-Ke
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:26:19 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so543826066b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787577976; cv=none;
 d=google.com; s=arc-20260327;
 b=IY+CPZ+o33pZvdL1yM4faCYJyjHXNnanfTtbM3Z6eqkAThBaTZ8f1z9d3qN2Gdtsga
 4mCl7RKxs8Fz4Z5woKiK1BQMKG0BLbrUIMjDvXpsAoxR+GkslAnzQc/cVOJDufCMa9J4
 myvBjg6Vw2aqV0wMktZ8MYm/FR8NFjgIDuOw499skf4J6L8gTIkt0Qc+wZR2te52CCF/
 rLO/f1sZPD+PHPIzagpIhRMFzIK+Aro1eJTOyCwHS5VFR17T19TZDAuZgD9Xvf5GyrFO
 q/PzXuO6ZpOmnLqYFT+KajCwFcE4toNJYpRpTjMFNcqT0mnc6z2Lmn/pdLmCUcfyG4G3
 2IMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WJOQloOIABkgH6V3JAdZSvG6I3xZcRSyyak3uFeJFGk=;
 fh=oVB4dXWOC2zGMKj6GsTOfH2DfYaTxhIfJh/He7qPgLk=;
 b=R5kwxD9g8UwUeJb0+uINlMCKfDU98+EKr4/EDehAK3g+1ES4ZPckD0102LObBiRkOd
 QfsFyCtrMrOGSRAEkkoD62V6KfW+JU3DIWGz9oZBdrPSUKybjBuZMrqVX4SOBPQGdGk7
 Ni9XSOGbBhELSpTgjJ28M9WTx/MOKHONas3cdfFOu6ZK4bS5U70UqpyRYRAhlB1sa+Pd
 6Alvwm/X6NdSHrwCHqh9djrx2hGWfbsJFJs+Gi0DMaO4GRPj0A6IV8n+mG3x6C4ZN+m0
 2MaeWIYLy8oRSfRmgQENI7/EVAu7m19gVIrjgpQgvBKKU99Vt75cR3L0qsrbVJzU9SW7
 NRmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787577976; x=1788182776; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WJOQloOIABkgH6V3JAdZSvG6I3xZcRSyyak3uFeJFGk=;
 b=LhEXhjRYVE/EwAZwt/b/stWxXkOuEs2R+blJaqt/JiVQx0vHqUACoKCZXNFBFnfCUM
 ST+1h40rUWlu9vreW2T4e+T687ALsB66nAAy7oiNxq5+RqkXM0kM3j9XkYptwp2E4/Q3
 gQhLSqxz4JQuDxj8ZK3iDhC9d5tgbIRBI8Qe4drGB8LMyGFGvB9ayXGv20BQFr80DFKP
 x3Kw8DgmzId2rOoBaaoQ+StqJMfxh80RY1m0MKQtgxBSfaGsqr1SH9fz5VLCXY5GorW/
 LObdneQDOhiCeN0QVxqgO6aFl+QtGFwhTTHmWDae8C0fPPe7zV68Q+O9kDl8GgPV6GFN
 AjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577976; x=1788182776;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WJOQloOIABkgH6V3JAdZSvG6I3xZcRSyyak3uFeJFGk=;
 b=j/BOtCnL2SeaYASzykViy1ZTgH1l3Wu9quDFEqZ8qDjvVX6vjkSiBbpYo/3+PC0IEn
 3ByztkOoblAUFvsBVKJlQAPNidWDqnEOl5TKPx8EdhiX2clgKKM1qChhhb8HEkkE+KCU
 eEoxACFgPRRKFsboKIa5A8XqRNkmBXsbWv7ge5UqVuAB+wG3yu6NVNpExil23zkFrIfJ
 Q/YhcD+5gV5h1xvK9//SRWuFvR/TOEWleozlSsl50zqkLv6vinFF2axVHUJJCo9fBdiK
 1/e0YWegYspHBFZle9AimmZBm94snxKsLdYLgF0Dvm8W7WSqswcbJYyJJG6NfUvM1lzA
 WNeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmnnRvEBUjeUvMG6u6wMvs4ykY1pAblsv34fDQF/QFI6GCpXfPoxjQst9FE2C+oC6JlRqzS+LERXYE@nongnu.org
X-Gm-Message-State: AFuF++nFGWWUDaL+GVyKGCQT670u+4Fp1KVeXt4YYNRcwbYoBFs+ZIx6
 7xkpDRlXEIehVewM2vo1aS7ijqJns0WQw9zeSVvI0bKUUIkMgHP8n3G7YLo5YmPw5h0IGPVJN1p
 Ca6u7pYcjIqnzp/KRqlL/GdeV7Q8etA9v1olhAHIxJg==
X-Gm-Gg: AR+sD132A99jgJDsQ/EN+KOYAiVEcj2KBsCCaElLUS41znuRHkfZetTRSmMNmdVhkhI
 ycof71RFdFvjF4dq9qppGAFlug9p80R3MBx6PoJb9oaDEB5+3Y9vFPk1A9kPCdzUUNwZnkndfrs
 MhXFnnu/o7N4ZoFJCxbIPjEGxpJmp+wn9pjMsw3DBjroAvokwB2SLKNFVfkXlveu93MwbGRTK8b
 SK1ke318wW0t383+bpm0pkka+E9CFv9yDwbtL2Vd8PYp3SnRQ7JndANe6nTjJtVvZqlXrxkk9Ey
 iayS3ozCSmVurVRswA9uEzqSmDPQAYNOyS23g9rZ85jSfbQwS1cCR7OF/ElJ/EC5af7+btALc9K
 zsvFmucUGnhKRLFVIJ+1RoyC/lOen
X-Received: by 2002:a17:907:7b93:b0:c20:5213:56f1 with SMTP id
 a640c23a62f3a-c246a60348emr2829725766b.13.1787577975945; Mon, 24 Aug 2026
 06:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260805052723.2823538-1-neal.frager@amd.com>
 <2383a98d-d88d-415d-9de1-aa68a5d215fe@amd.com>
 <BL1PR12MB5032F21E0E2A6F17398B6D76F0A02@BL1PR12MB5032.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5032F21E0E2A6F17398B6D76F0A02@BL1PR12MB5032.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2026 14:26:00 +0100
X-Gm-Features: AcwNN1VvxlRRRHvnKb0O7rD1SVWHvRL8XBQeDCQKBO42isGO3VyXT47Xz83_lqU
Message-ID: <CAFEAcA8sWn1vjm+OFYzwA-jko2vYkFcWPwT6g9=0AeO+JQo-JQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] include/hw/xen/xen_native.h: downgrade
 include-order assertion to warning
To: "Frager, Neal" <neal.frager@amd.com>
Cc: "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>, 
 "anthony@xenproject.org" <anthony@xenproject.org>, 
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>, 
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
 "Stabellini, Stefano" <stefano.stabellini@amd.com>, "Saleab,
 Micheal" <Micheal.Saleab@amd.com>, 
 "john.ernberg@actia.se" <john.ernberg@actia.se>, 
 "matthew.l.weber3@boeing.com" <matthew.l.weber3@boeing.com>, 
 "vincent.stehle@arm.com" <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

On Mon, 24 Aug 2026 at 14:14, Frager, Neal <neal.frager@amd.com> wrote:
>
> AMD General
>
> Hi Stewart,
>
> > The -I$(XEN_ROOT)/tools/include added to QEMU's extra-cflags causes
> > __XEN_INTERFACE_VERSION__ to be defined before xen_native.h is included,
> > triggering an include-order assertion. Downgrade to a warning since the
> > version is consistent in cross-compile.
> > Ref: https://github.com/qemu/qemu/commit/e2abfe5ec6

> > This is a buildroot issue, so I don't believe it's necessary to fix from the
> > qemu side.
>
> I am not sure I fully agree here. While this is a buildroot identified issue,
> there could be other use cases for __XEN_INTERFACE_VERSION__ to be defined
> before xen_native.h is included.

But what, though?

> And what we have found is that if
> __XEN_INTERFACE_VERSION__ to be defined before xen_native.h is included, it
> is not a hard error.  For buildroot, the qemu works just fine in spite of
> this.

I think that just means you got lucky. Either there is a hard requirement
for one header to be included before the other (in which case it must
be a #error, and whatever is causing the mis-ordering to happen must be
fixed), or it's fine for the ordering to be either way (in which case it
doesn't even need to be a #warning).

thanks
-- PMM

