Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CEBF46444
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w24qJ-0007q0-O8; Mon, 16 Mar 2026 06:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w24pv-0007hL-On
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:06:15 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w24pi-0002Zl-IE
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:06:07 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ca09f2056so3225453d50.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773655556; cv=none;
 d=google.com; s=arc-20240605;
 b=XFJOTDfKy9+ykCmf5x+1b7S8/LwVAZRe+xWg1u25UOH6phpZCFmrDQBjhYN6h8yN6R
 u8O23RqOpNTFbi40AOGzndfBOOH8RPWvfAknYP1YKG/uSnysWG6BiER2AxvfmKKtHm6h
 Qt9h3cnF7fWfJix9X3+B6HrDWgHHpQ/OB8vm/LSu3+V+c+yijyhRz54DfBrAaB136X5v
 6WTW4RtB2h2DYOp10MKLEE/eve2p3PdIUUOGSqnlO4txIOF4hkKqoXNeWRfWWbFIVX3w
 HE7oga8ejiI+NbGn0jrWDOlGdSKLWaCR6wFavnMwd5NRADii5zqg7peBl0GkU6R1j5vB
 HIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=evLupH/yWp2vQEvNZgqDdfr4GAiZrF7fUPDdQWSzT8M=;
 fh=MgsFPLzMik5pzbu6GnQjL4mm15Uw2rRaobbNRPzfUW8=;
 b=dOwoC5RkFaj+ObZ5/WoqqrNVmRY6llorLHv3eXw7z4Gu6iMARoMSv2ePo5Y7NtGw25
 4BzCafD2VjZy/SKsMOCFpSoZgoxTsXw3ocUDJxSbhnmBRTrOljkNE8kWdPhw8APGAJyJ
 f3zRRFJCko6cc/gREqtcZIHDpFi2mNAsUxMSpfo9C4egzX/eZ5/jCFHIIONCWypAN6F5
 HSys+C5syoM+squfELgke2BUqFeVFsyEBePcfvAB6JhFBkSav7B8palTX6stoXMdeQjd
 GssBv6JBV1KdV6IZNA75deSXeKCxfXXAU+ti7CAIFM+NFAqAhvThnndFmO2Xex8QY3cw
 VodA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773655556; x=1774260356; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=evLupH/yWp2vQEvNZgqDdfr4GAiZrF7fUPDdQWSzT8M=;
 b=ERjuZu3Qa7XyilYwKYiUlBJh817M+01YX76FE5voMqLMyLWVHiIh6Fu/6ZRoYaGmHM
 QY9S8hdoTrmw54Nxpv/b1+BBj9IcS1ptYXUYOeqTCvkhjkypaKbI4KDvFKA1q3bCjBaI
 bVj8rJHIW8Gu6NoAqP5F3CWxcchJoMwxa95TIFX7HqXDp9wEfD+/cHSl6dF+KDy/8WUR
 ck8Vu8w/pjXtmNNSl4LDRfq3BTudbuE28rUqFkO7wb5C602UXE9auJ+NqZA6d2WUeKkT
 HvmXEJ9hFz2f4CVGUP8f2c08TNanjB2EQyPmf0o/ueqyScEVPTujE16LwjgSmuD18mjm
 k75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773655556; x=1774260356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evLupH/yWp2vQEvNZgqDdfr4GAiZrF7fUPDdQWSzT8M=;
 b=m/5ql8jFeC5kU6fsbNbPp3chiTpTPLRp72FgqWiQE/ph7EMVtwKARdkAuny6bCoQLz
 WR5JHvOkppothTdybfym9AWWQFpr8YhJc8bXkY/C1wijqWHZzmHtHO0Lw4iG7VC9Wsvp
 /o4v5/0AYQRVsrFchINpWIqp6Lu4ce1kAejpjdAv87SjVwyFzXYZAP/lxohUeKEDGeZS
 nIFFYDjnvtoV6PdJAX1JlJxOjAXJsIwjBg6MM83Gh6Y+QQip2UiOBZuvEb0bJK1aVdAQ
 TZo4dLKhxFQ8U23hloJ1v+RvzEUctltGGiWdAAigH3Wutx1/AaWQW/ZfH+fc31U1mZtR
 K0gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCkCYwiTB+xUzRuncfWGsHgnHGrXv3Ksl7uqPs/gtqN8JEmSVhY+BTx9t0vp9Tuj/XtpL0GX5UD9fL@nongnu.org
X-Gm-Message-State: AOJu0Yw0HMMml17sVQzV3iiBBVc9WMh6ZCaBn15ea4PUZaakS3//lsEy
 oYDaXD4c9DScu9Bcx2R7S6VkpbgPqeIgQ+rWXjv0YQkTsaQLAyzYaj3jDJ1PoV+h5Z7HzfrY+fy
 vAI0g1Svh5WXa0BA3phF/8KbtWtnqeFXj+8kEkwb8mw==
X-Gm-Gg: ATEYQzzf8cXTfICTGdWK5dzU37v/Dw7SCojCCyNDTzzIdma5cDPM0kE87NLjr5c5hdw
 a5Nbz8sY1HT+UjWzXC5+JYZ+9aothLmFhsspww7TPMU1okTruXvToJJrv+WDlUyLMUOsXeEA07D
 a9Ig4Ikt6iLOtu3aMqeCIURCt/RRw0RdvzXZVmezHBpEYEN6AC7o2Q1a7GJR1klNGEy400NmIrB
 M1GfFDdSmC/uuAMpQVDsXlFk76uUBCl6YYDuFs7vScatTKzI3W7fHE9wbcl4sqxxiK3arHUrxn2
 wmgMhzWCwguPdFfw4DpHPxiBV4NFHu9EKiwHCqIdVbi6VDPYtSKW0nAi2OAHWaAgNPE=
X-Received: by 2002:a05:690e:16dc:b0:64c:a41a:3a64 with SMTP id
 956f58d0204a3-64e62f98e92mr8644108d50.34.1773655556106; Mon, 16 Mar 2026
 03:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <a0ca818f-8e05-4756-b6bb-8f986c59cd54@redhat.com>
In-Reply-To: <a0ca818f-8e05-4756-b6bb-8f986c59cd54@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 10:05:44 +0000
X-Gm-Features: AaiRm50Pm_BrjeMMsmtJMn7c8zm8sFv0fzYVJaUiNHtBXur5nKgkk05aDdfCtUo
Message-ID: <CAFEAcA-NjFCaZC-UAykS98J4DAEXyANj2QfAgc3bqT4eQsO=zA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] hw/arm/smmuv3-accel: Support AUTO properties
To: eric.auger@redhat.com
Cc: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 16 Mar 2026 at 08:08, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Nathan,
>
> On 3/12/26 10:03 PM, Nathan Chen wrote:
> > Hi,
>
> If we want this to be taken in qemu 11.0 you need to clearly indicate
> that in the series title:
> using a subject prefix like "PATCH for-11.0"
>
> Then you need to clearly justify what those patches are fixes for stuff
> introduced in qemu 11.0, something like:
>
> In qemu 11 we introduced new options for vSMMU but feedbacks received
> when starting the integration of layered products shows the need for
> auto/host retrieved values. To avoid breaking JSON/QMP compat, we want
> to fix the option types so that they can later support the auto mode. At
> the moment the auto mode is not supported though.

Yes. At the moment this is on my "look at it for 11.1" pile.
If you want it in 11.0 then it must very clearly state the
justfication (i.e. why it is not new feature work) and be
as small as possible to achieve its aim.

-- PMM

