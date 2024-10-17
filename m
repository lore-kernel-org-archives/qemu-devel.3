Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0459D2126D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 10:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1NJa-0003lM-6C; Thu, 17 Oct 2024 06:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1NJL-0003fQ-PZ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 06:00:52 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1NJK-0000cb-4b
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 06:00:51 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso1390770a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729159248; x=1729764048; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBDxQIwPfoIXyiBvsN+RgC5HHBxpUxqtcz2/TCFbnDA=;
 b=QTPSp2z9SHF7ECtppECvH2T5ctVGRoD2Q1suVPo4qhH86MJEIknsnzTHu+CRGuZbyb
 yA/uZrjp3hv445Rr/3tJZWTtYINtPXjQXkWkB7YnZfNIdrqGTgd4jfohPYICmc5chKii
 ayt/LH4DJBjYhkc4au37F7nVoYJ4ZsxrSiVMzOgn2Z15mcIoDxwDvjY9h2ESKPnoIkR5
 RVhEOGZsrgjxRiKq6ibxlaaJ19iQf8c99HRGAvRjeJN2A956N6KGEUSPoNB1bix/mAZq
 Jh7PPinQqp3sDLJUupPx3wgGbR5ogcL30bz4q9LPtKXkKt5U5Im/gGr+hC9515HD6jHS
 ePGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729159248; x=1729764048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBDxQIwPfoIXyiBvsN+RgC5HHBxpUxqtcz2/TCFbnDA=;
 b=DXrr2IARZ9AqwyM6cObN4Hg3rS651/fGS+f3uvP+gd9VGB2VpUGQ0zj+F///fxYdf8
 B734pxzi5AgHQqrHy704JWZYFj3ZWxlVCNco78x7Symykm1QiiqJdnX+WbR9p06F7GDf
 N5IuBV8zuiKkgNOY1Rq1YbOd/pWk1KKCKRK//w2Xrsmpo0m3mMR8suxsCtqlsTLcxOKf
 fCg0k/VZFP+TQRXCvwjPsq98s/g7iU8sYw0rrDfgvtoKdkQs8tpM9c/1NqxAtFkRMhu1
 /+yFPuweqK0sd+jkfOp4NwMkH2eyETcvGjSlq30KYFW0O4+hyTR7EsNv7Af5dhn27B/y
 ReXA==
X-Gm-Message-State: AOJu0YyyIfgxsiy6eIr2rVy3+QepszixQIszn9SuaNJKeQuVKjxnm/BZ
 VN6+nQMUOyocJL05cWtfFWyJoA+DNRaEth5GfDA+XJBLUFO8FfTtRofkCel0eROAFmlPEppNLdu
 WdbbUkgN5tFwwh7x7U6QujGEoYTav5L8dVtB6fCxUgFFuGwnI
X-Google-Smtp-Source: AGHT+IECq8jyvJgLWRy7rRo84s2svFf6WlAAVVxzbW1Hz7e7Or9mvbgnVRiX5cjlRCYJtxzQ3XYzTMsQLftRHSkxyt8=
X-Received: by 2002:a05:6402:1e8a:b0:5c8:957a:b1e2 with SMTP id
 4fb4d7f45d1cf-5c948adff84mr14684944a12.0.1729159248076; Thu, 17 Oct 2024
 03:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241017091401.783102-1-pbonzini@redhat.com>
In-Reply-To: <20241017091401.783102-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2024 11:00:36 +0100
Message-ID: <CAFEAcA_1mryG9RyeAqfeRQOvqysO=vV3m=012kLmTsT6p-CdZA@mail.gmail.com>
Subject: Re: [PATCH] tcg/s390x: fix constraint for 32-bit TSTEQ/TSTNE
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 17 Oct 2024 at 10:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> 32-bit TSTEQ and TSTNE is subject to the same constraints as
> for 64-bit, but setcond_i32 and negsetcond_i32 were incorrectly
> using TCG_CT_CONST ("i") instead of TCG_CT_CONST_CMP ("C").
>
> Adjust the constraint and make tcg_target_const_match use the
> same sequence as tgen_cmp2: first check if the constant is a
> valid operand for TSTEQ/TSTNE, then accept everything for 32-bit
> non-test comparisons, finally check if the constant is a valid
> operand for 64-bit non-test comparisons.
>
> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Should this cc stable? Does it cause any current problems?
(AIUI the x86 target changes in your pending pullreq do
trigger this.)

thanks
-- PMM

