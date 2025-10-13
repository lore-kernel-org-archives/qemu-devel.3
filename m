Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7720CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 10:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Fwc-0000an-K9; Mon, 13 Oct 2025 06:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8Fwa-0000aD-Mn
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:38:21 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8FwV-0006pd-Bw
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:38:19 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-77636fb28f6so31752847b3.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760351891; x=1760956691; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2tMx1UdZx859djex2Kb3BK0AmsY46PeZcn1y71v+5rs=;
 b=xzhvpkp259BbLRFee9vB5yrSDfpIil1/CzuwewknvFngwRaPORDNsC5ia3TaHPF5Zi
 nAJ8N3d9rkU8NLJYwjZ6fqZEvdn+kKzR5A6FOVGAwx0wFnod5Uyy5EXCpvfdhx4tXzfY
 njRmSUVV9qs6c6feG4YYjuZrUO6Y2dkEHKGJ83HdLo+BC84egk0iK7bfuM59gEoBtNl1
 GOLSMTLMwwDoX3uisTVyIk5PSsxebJZlMOxFY8iADYfjsq0e2tlk7Imxdnpn67YS/4QX
 2kb1T8P4C9FVo7csGa6tdF+8Oc8kmySmbniq4uGDhdScnX2xZtzFUaArLUx2Kkcf2QOz
 tFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760351891; x=1760956691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2tMx1UdZx859djex2Kb3BK0AmsY46PeZcn1y71v+5rs=;
 b=bPtE36DK+3DXZw6AziD0glAVw3WtSFKizTwIwoxIisbN245ixG1aekzvBey16LmoQE
 PpEO2sD5hGgQXBE97Z/nF2FI3BR31rSXL3PbxBbq3uKc7EHPTeEH8ecNtpGtyptKX++d
 a1ltmwxhGVCO570qcyOwSMJRChodDCU+K2ztM8mjb6+dKSYnVr2lbCa35ptmd99GB2ze
 Acdd4RviYnjwVanowICEpJDGWaXxeTJHlDiETFVo9jT6oM7hg7/93SBJI10DkXWAjxKT
 f1PaNmcEzWx3vKvI6nDiwsd7MwWoP/Dcgi2LiV56XBOn6GV/FOAj+347iPdsKS7uO8f3
 XyAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNkqbqHeAmDpJqfax2ldCGnAtd5ZwCUpm5mPal7lbng5KAj7vexim/M6BYYTCbvqgbw9Z1YbqJWKpA@nongnu.org
X-Gm-Message-State: AOJu0YwPt3krUefehaSOkW3Zvdb7STPaNeV0H9TL2OtNhsY+wqh0D966
 8jSH0WAxH9aFT8YJgLyKiEliT/jWgQKLdo3zSzK8iKwYLqmGRilJXRr9AmN36KBf2h6nxS8hepB
 6z5taAEFIfyMhO3oy+Zc6XXW9jvL09XcxF26ULZbJfQ==
X-Gm-Gg: ASbGncv/iwI9N+nUZnsifUyw89IKAA50htAV41GpnOwW13qjXLt58y5PegNdkZGkTWb
 TA9CANfaaCqzk7U8Hm/7qig13S1XA7i4NyRgjVPmyCXBpYJN8tLFFAu2493kGx/u9ClKnS32e6T
 UcvB0tZWi5Kv2eTDQ4E1dAqUkcS5yqWz/H4DYgPlaCpMxd2f114LZpFy8SZfv3sFNSFp3dMXxmV
 Z0cgUDPb3vv0iNtJ+Emd5P4RXPdSZo=
X-Google-Smtp-Source: AGHT+IGdJ9Df+a8ozZzuXbmtKfLBgoLbon46jSTqYLW9G0tKsuEyhtRvWuHQvYBXFhEdAejMk3HiM6gGxq2hTN1C/wI=
X-Received: by 2002:a05:690c:f0e:b0:722:7a7f:537a with SMTP id
 00721157ae682-780e16d4243mr346747547b3.38.1760351891046; Mon, 13 Oct 2025
 03:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251007091214.403430-2-vishalc@linux.ibm.com>
 <CAFEAcA8VWKEy3XVo3b9pTg-jCAD2oA7=dFbOSRL3q+WRUoNBpA@mail.gmail.com>
 <aOyj5p2xzoxCyYZC@linux.ibm.com>
 <CAFEAcA8zGH1sHL45WU=E2p4p0EizuOs3QRaniHW7ES-CQDPajg@mail.gmail.com>
 <5f414f58-f687-46c5-bcaa-32339ea9311e@linux.ibm.com>
In-Reply-To: <5f414f58-f687-46c5-bcaa-32339ea9311e@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Oct 2025 11:37:59 +0100
X-Gm-Features: AS18NWD4XZsvI1gWE2W1OwsLWQ7y-0VAuL1EUHqIfm_B66WwSuxzFjsFKygD6CQ
Message-ID: <CAFEAcA-s2ZUu2JFgyxSeYK8H3Rp7rVR4tCVDnMhdBHYn8E0OBA@mail.gmail.com>
Subject: Re: [PATCH] hw/ppc/pnv: Improve kernel/initrd load failure error
 messages
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>, npiggin@gmail.com,
 milesg@linux.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Mon, 13 Oct 2025 at 11:18, Aditya Gupta <adityag@linux.ibm.com> wrote:
>
> On 13/10/25 14:05, Peter Maydell wrote:
>
> > On Mon, 13 Oct 2025 at 08:02, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> >> On Tue, Oct 07, 2025 at 02:29:52PM +0100, Peter Maydell wrote:
> >>> On Tue, 7 Oct 2025 at 13:59, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> >>> <...snip...>
> >>>
> >>> Rather than printing a list of reasons why the load might
> >>> have failed, I think it would be better if we enhanced
> >>> the error handling in load_image_targphys() and friends
> >>> (i.e. use Error), so that these functions can report back
> >>> to the caller exactly why they failed and then the caller
> >>> can give that error message to the user. That way we can
> >>> improve the error reporting for every board that uses
> >>> these load functions.
> >> Hello Peter,
> >>
> >> Wouldn't it be better to print the error inside the function itself.
> > No, because some users of this family of load functions
> > use a sequence of calls to handle different possible
> > formats. We don't want the function to load file format A
> > to print any errors if we're then going to continue and
> > successfully load the file as format B.
> >
> > More generally, our usual coding practice for functions
> > is that they use Error to tell the caller what went wrong,
> > and it's the caller that then gets to decide whether they
> > want to print an error and exit, tell the monitor about
> > an error, or just continue to try something else instead.
>
> In that case, maybe we can have 'load_image_targphys' take an 'enum
> LoadError*' ? Caller can pass that argument if interesting in handling
> errors.

We have a standard way for functions to report errors with
useful human readable strings attached. That's Error.
We should just use our standard approach if we want to get
better error messages here, rather than inventing an
ad-hoc new thing.

thanks
-- PMM

