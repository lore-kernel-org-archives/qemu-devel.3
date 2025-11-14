Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE4DCE7AA3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 09:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJqUl-0005sO-17; Fri, 14 Nov 2025 04:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vJqUj-0005rd-6R
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:53:29 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vJqUh-0008DP-Cc
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:53:28 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-640e970598cso275509a12.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 01:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1763114004; x=1763718804; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40qHmhfYl4YJ5ykYRtbUnG/SkJMewWh8cH4iztJThUs=;
 b=PoFk7H9Htkrm55OJU6Wooc3MKeLDwOSJrkVKjGHQ6wdEyob8bD0SvWuNkIbR9a02zW
 iTIVHVqaj4FemjQSbWIgcXIjlbkn80lrB9FCyYGZFqRqP37UWjOrzqf/WDCKLMQQAEV4
 lrs0Re+mw7pHuuGkIT7OPoeUyyvVpeYUauFtlD3uYcoj3PUBUGgfcz+DyfNylvZCoY1z
 EDXmCergpqYAsg5iaAIv3xbHpM49t9IQGPwph18mTefItYc/B+h+Ord71FdYSwkiffFW
 7rx4HTfoEbXRnu4eXspj3b1Eh2ry11kOAeADF2dkQH8lTWK2k+sa3V47PyRdluTbroqv
 6fpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763114004; x=1763718804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=40qHmhfYl4YJ5ykYRtbUnG/SkJMewWh8cH4iztJThUs=;
 b=QPWyBG/azPojlbAyiq7OZfq2d/dKxkJATByR5Wsxh4m4gbtCoevv7eSInui7cBlSQt
 hiODChSRCbv9DVPj7y1M7CUZhr4QRufXa/vnSem5JzCx3/4yC77tmh5B0IViqKDC1zEb
 iF2K+EJd3KvqlzU9dbzgQj1McDLELGmOR2xxUt6dLRKXFL1L3yG2oW/MOu4GJxjNGAKz
 ZfaVoEIr70ys1f1dafTBNsAp4DmQo5fMfrv5Js9ONgqqoODRYlZWE6seyUfWtPjiQkgp
 wV4QCbNwWS0Oc2IfV0pAjdt5llE7DoeUSmf9J4+Ksz8r7+bLRbbkgJUIH/HS9wqcC9rT
 ui+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM/on1oP4SH1wX/JwkkPKLaXwLuUneRdig4dIelREfdf0HdBZMDSuVCL0SUBqIUJw+VkRPnBKktshC@nongnu.org
X-Gm-Message-State: AOJu0YziMGooAPBdtEV6ry9X+dn3y7enowBJT0HwoQ44FPLULMhRNkgT
 GAL+kyBUaJRhJonzCbRatcOZLbdJKbJ3K1ISsS/yZMmpBomJu4M0IbdffArjN0JganP1X/zXN+A
 eiZdEJZa0GG8Ftifw3xnnFqhU3+Cyo7l9H5vL6OLbPA==
X-Gm-Gg: ASbGncunp+W3PwxsyNMvLwW48b3Ng8SdZkiUpMCTzhrwIWJgxph29aMGMMCZcwe14JD
 Q+MWDzj9ANfgWYqWPGFjO8ct5wpIt0Y+GnlaezzLWLX46Pa15tGEqqLHEmkUoi6tnYrDn0QSXk9
 dNzzuuvWmdecatZl+NV8HAYUYsC8lz/3falveMxllRPYRtp0a0pxaZaYop+YhVBjFVbTrdWjJCT
 6ShFylSgRdIns/n95h32B4U5kcwdbINI8ApfuhCmQgdxf6HsktbpjxQHONs
X-Google-Smtp-Source: AGHT+IFMsYUibSruaGLTyRmBgAJ1fZJRkPpnNUYcM00Y0LNljJ2CmYjUOduFEO2LZrl0Is6dn9DnF2E8XG9MyMfD9zs=
X-Received: by 2002:a05:6402:3551:b0:640:9b11:5d7d with SMTP id
 4fb4d7f45d1cf-643515a4a91mr1186846a12.7.1763114004511; Fri, 14 Nov 2025
 01:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local> <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local> <20251113124207-mutt-send-email-mst@kernel.org>
 <aRYyTeNNIPW_WIJW@x1.local> <6a83ca08-5484-469a-8020-a1165aed1c73@redhat.com>
In-Reply-To: <6a83ca08-5484-469a-8020-a1165aed1c73@redhat.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 14 Nov 2025 10:53:13 +0100
X-Gm-Features: AWmQ_bkq99dbOE-bwL3uOCmjXfd4lsOkMpptNqMYM2CRK1H_oEqQmIOpS19_jeI
Message-ID: <CAMGffEk_8c4Axe1iuugXa5xV2b1tZhvVUcPL3ZPBXriofG-rOA@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org, 
 farosas@suse.de, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::530;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hello all,

My apologies for the slow reply; I have been heavily involved in other
tasks recently.

I wanted to chime in to confirm that, as a Cloud Service Provider
(CSP), we rely heavily on live migration, particularly during the
rollout of new host operating system versions or for resource
balancing across our infrastructure. Consequently, it is a critical
requirement for us that the live migration process remains robust and
does not experience failures simply because new features are
automatically enabled by default when running on a newer kernel
version.

From the CSP perspective, having a strict feature check that results
in a failure at boot (or feature negotiation) seems significantly
preferable to the previous behavior of silently clearing features and
only failing much later during a migration attempt. A strict check
provides immediate feedback that the requested feature set is
incompatible with the peer/environment, allowing us to address the
configuration issue proactively before the VM is put into production
or before a migration is attempted.

I must admit I don't know the code base well enough to comment on the
technical implementation, but the principle behind the proposed strict
check appears to align well with our operational needs for managing
live migration compatibility and stability.

Thank you very much, Jason, for proposing and working on this solution.

Best regards,
Jinpu

On Fri, Nov 14, 2025 at 6:48=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 13/11/2025 20.32, Peter Xu wrote:
> > On Thu, Nov 13, 2025 at 12:46:55PM -0500, Michael S. Tsirkin wrote:
> >> failing to start a perfectly good qemu which used to work
> >> because you changed kernels is better than failing to migrate how?
> >>
> >
> > I agree this is not pretty.
> >
> > The very original proposal was having extra features to be OFF by defau=
lt,
> > only allow explicit selections to enable them when the mgmt / user is a=
ware
> > of the possible hosts to run on top.
>
> Could it maybe be tied to the "-nodefaults" option of QEMU? If you run QE=
MU
> with "-nodefaults" (which you should do when planning a migration later),
> these extra features that depend on the kernel version stay OFF. If you r=
un
> QEMU without "-nodefaults", QEMU could enable them if supported by the
> kernel. So that would benefit both, the people running QEMU via managemen=
t
> layers (using -nodefaults), and the people who just want to quickly launc=
h
> QEMU on the command line. WDYT?
>
>   Thomas
>

