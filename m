Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC03A10ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65LP-0000ZW-NC; Fri, 27 Mar 2026 07:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w65LI-0008JV-6K
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w65LF-0003XU-OH
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774610824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x26TZNRg43BFa3dggwrpI++2QPL80Q+hZB52X2e3BuU=;
 b=DmP8Ns+br02/647yKDZ9/CdadjjtboOYAvfrJtK5G5hhYPmEre6p9A+not9wNHLj4U7CQE
 3bxMxu5f9lx0nqjcEt8JlilGuE9gdKx21fjIykHHgvMcnO+/ofo1dM6hWpDXP5jdJPUiaZ
 N8nYwp/cfnDbdxfunBfUiVikR9W+n3M=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-4OglsDcWPpm3jmwRwWb0hQ-1; Fri, 27 Mar 2026 07:27:03 -0400
X-MC-Unique: 4OglsDcWPpm3jmwRwWb0hQ-1
X-Mimecast-MFC-AGG-ID: 4OglsDcWPpm3jmwRwWb0hQ_1774610822
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-67e1cbc56abso644436eaf.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774610822; cv=none;
 d=google.com; s=arc-20240605;
 b=kmRhQK6I/p9A/88yhmN9FjymNfZ4JAma5EEbJvA9hDhBUfvfCaYeEizPoUsZU77iW1
 xlbBImvWa9Uxw/1yjvmpWJMV2enf4ED9VM+uFpttkY0qfc9fGkFQpZGYs934E4RYmwdD
 zLJNa8Gf2FRrmd3kKW+iWz1c16ngSQZi7PQWf4Zg3rwZ9EhU6iiaMsaPlCv9zvH3znqN
 m6HTZgjAMXk2yKaiLiwKTsw4IVI2DpU0JIYf0WpHD47E2bzfKl9DHypWalUQpGMvEp8q
 fDSqu7OTaWOIRUnPOLTOEviQptsLOhhutIFY9V0gW+EwYDwkxGwwlTdJ6QEM3tiMluVC
 PrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x26TZNRg43BFa3dggwrpI++2QPL80Q+hZB52X2e3BuU=;
 fh=4zrKeeuepEsCoOt2rgoibIVBGwiYslc5fybZAnNN4ZU=;
 b=l3V4AljiNFNlrhIv8F1iijyk0VaQwUjg4FDT+pFZXtSHaF5svOzSRsiQw0XFfanydy
 xt/hvRVV+zKDxYMEg5a5NLz3ogK1MN7fWdQc773GrRno8GgfTX+0DdK8/zAfASOVy2o7
 f4q8QMN41r/AoxxA61K5o9qqjMCCi3Ds4phCjpVa0TaJIRxbUNdgdAuDKFgeuwxiRDPu
 dPoD5jW4PEeEYWUH7vb7sTlbXyAV6D4PSFtTUyzFWuAv4Y3vv+JSTQPBiKHTZZvsfxNb
 2wS0bbYvrEUxRCMAwceRvxFQrhZqyX6Sg48xlPgbZTEq62T/yU+m4KBCwCYNCOMstAEV
 iUbg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774610822; x=1775215622; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x26TZNRg43BFa3dggwrpI++2QPL80Q+hZB52X2e3BuU=;
 b=T9Qenby1rsq4xi1b2NYl0v5Zmyh7j7vvdBpnS2VXK5QLh4PC2MIuIVDAPW+taELzL5
 u6AbY6gKzNw0LOVTzKz0t6c5nYan2ZD9LsIRfsO47gKPS1AL8GOirKe9d0IlBGHsZJ+o
 dE21EymmAFlsXfn3Zom7Wwtz022GZp1lMiKkZGTiunEbxqF213NQCYRN+SFSgUraTE4R
 r057YzUSq5yujRPjIK6o+Q5sNzlEmwInpv/kQCdn+Cn8cSD8vKCpw+8z1e6FyAPewuth
 smAkcNwDhk4O34PkUzEFCIIlCIIYOK7GsL4vmjSufJFg2bWUph94NXsYrm7YeOSwepVs
 ku0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610822; x=1775215622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x26TZNRg43BFa3dggwrpI++2QPL80Q+hZB52X2e3BuU=;
 b=lE453Ses9KBQfK+qfukZr72YXP9B9dRQ2235uKuEOVKoXGyf2+SdgOVOMR2s1gtYGu
 4VbqmfTEGwtWkV0qBvF20+OJzAjnYDnITqmHKi3uf8QK7sF+Kb1eohuUIp3sJ7Qs2aoY
 qSwl06CmN9MA96KyK1tcct37FgWWjgLy8GkT/eqCHLMP9vrTKIAzELUWGFORuTeCsTS7
 BcgMsuIn2jWwB/xtxbAD1feoOmibrFtOb6Bqsp65TwGfZLAIhfk2O5LPF2VdKLAlqzM0
 IfdskhzRM77GltEu4D/DF+IQCQ6oajdsKfeYB9GVebYLg4k9qdX48iSXM7GiPKqZvt0J
 Ow0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtNAMvwAO5o58Pfa3lTKme9SFA8CIZiLzuMYdZ7ClSoNXBQP+bMJp08E6CuIxwF5zFn48x9DVS7Y69@nongnu.org
X-Gm-Message-State: AOJu0YyyVQPeAxiQfA/OQMbdmLqlJHtWebvLc/hVsf0ncBjlciEyfiLQ
 t9M5GtJwAZVukS5e1IYxx17wflrx5gI/ptMTMBmS3Z711Ve/9j945SfPX1HE9+jKn2ryj0/TXBt
 hRF8MsGZNBL2Cq1fYtglsUJ2ymbWvwRIC8YwhpuaTw5X1gw8ae0AtsCHP9+5iagXv8U2Odz5mEk
 J8qdJC8Q+agv6djBzhA3UvkAC5keMINwo=
X-Gm-Gg: ATEYQzxaqP0Bj0fR5RFlz/COUonhr1K6kkKBZCAeXsMQVZB2fWg8MnPMtq779zKXpzb
 6seFmicAVwweADIAfhb9wDnlwEz7gYkXcpkLkaGGp+1yn7DUS3+rnN6zqIeB8u/lScZvS1ev3YN
 p5YKckCrY2rtZvt2vcGuERC2QI+wOt9C/Vc7iM1Sl5qXfDXdJAOv2l8DrYCrYKwPdTzDlAjJmBo
 NdK7/MBiWPqDW/9w4x/CRLzTsXXX1C+d5rnrJc=
X-Received: by 2002:a05:6820:c84:b0:67c:f9c:ad29 with SMTP id
 006d021491bc7-67e18708f87mr964103eaf.43.1774610822500; 
 Fri, 27 Mar 2026 04:27:02 -0700 (PDT)
X-Received: by 2002:a05:6820:c84:b0:67c:f9c:ad29 with SMTP id
 006d021491bc7-67e18708f87mr964086eaf.43.1774610822154; Fri, 27 Mar 2026
 04:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
 <20260324-tpm-tis-sysbus-ppi-v1-1-e59175210954@redhat.com>
 <c6830a19-c275-4a83-bb17-4430680b3d54@linux.ibm.com>
 <A2BD2FA0-6D5F-47DC-BF2B-017ABE5F31AB@unpredictable.fr>
 <07ff064e-bea4-4beb-811a-f5f3485836d6@linux.ibm.com>
 <CAJg9Kky1q=5DFDPkh-i1hyxCKmpuEnR02hrHN-ncewY2VO0LQA@mail.gmail.com>
 <EAD6E043-B77B-478E-91D6-863B0E185CFC@unpredictable.fr>
 <CAJg9KkwznOFSzcme_6A44Er7dd6Ae+szWF+Fwh4dw=Hyv3BWVg@mail.gmail.com>
 <CAFEAcA85B5g0xRExvicBZwW=bADBj+dQFFeA3ihg+=bTYJNZCA@mail.gmail.com>
In-Reply-To: <CAFEAcA85B5g0xRExvicBZwW=bADBj+dQFFeA3ihg+=bTYJNZCA@mail.gmail.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Fri, 27 Mar 2026 16:56:46 +0530
X-Gm-Features: AQROBzAiTh9upMXPgQPDsPlYRixn6GrVkTap4MwT60CKSJpWg8Mmr45JpCEZ7RQ
Message-ID: <CAJg9KkxsqQotGX_0n+ne8LMQB9ckBcuEo56fCapVw2cA60JKGw@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs/specs/tpm: document PPI support on ARM64 virt
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Berger <stefanb@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 27, 2026 at 3:56=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 27 Mar 2026 at 10:08, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
> > For v2, I see a few options for the docs and wanted to get your take:
> >
> > -Add a note in the PPI section mentioning the FEAT_S2FWB requirement
> > for TPM TIS on ARM64
> > -Add it as a separate general "TPM TIS on ARM64" note since the
> > requirement predates PPI and applies to the TIS MMIO region as a whole
> > -Hold off until the ISV=3D0 syndrome support patches land, since they'd
> > remove the FEAT_S2FWB dependency and make any note we add now outdated
>
> We could in theory have QEMU check for whether the host has
> FEAT_S2FWB and actively warn/error about enabling the TPM
> in that setup. But if we're going to land ISV=3D0 emulation soon
> that might not be worth the effort.
>
> -- PMM
>

Thanks, Peter. Agreed
no point adding a runtime check if ISV=3D0 emulation is around the corner.

I went ahead and tested across a few different ARM64 hosts to get a
clearer picture:

*Nvidia Grace (Neoverse V2, Armv9) - Win11 ARM64 installed cleanly, no
Event ID 15. This one has FEAT_S2FWB.
*Ampere Altra Max (Neoverse N1, Armv8.2) - Also works fine. N1 doesn't
advertise FEAT_S2FWB but has equivalent semantics as Mohamed
mentioned.
*Marvell ThunderX2 (CN9980, Armv8.1) - Hangs in TianoCore as soon as
TPM is enabled. Boots fine without TPM. This is Armv8.1 with no
FEAT_S2FWB at all.

So the ThunderX2 result confirms exactly what Mohamed described - TPM
TIS MMIO needs FEAT_S2FWB (or equivalent) on the host. The PPI patches
don't change that requirement.

Will send v2 shortly with the doc hunk move Stefan asked for.

Thanks,
Faiz


