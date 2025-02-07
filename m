Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE09C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgRPO-0004OF-Jy; Fri, 07 Feb 2025 11:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgRPM-0004Nj-5x
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:40:48 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgRPK-0000Je-GS
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:40:47 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e589c258663so2443336276.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 08:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738946444; x=1739551244; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/s1u7j02fdn/PpNH7d1OI9ADeeEfLYIO2WWJTxBpH08=;
 b=NyvKps82EwnwzC6Ra/4/Y46yuEhnYB1WRLTReCNuAjwM+fnfrNffjhOa53FemMTBOS
 o+8zHi/QFDJ5hscKBFtb9QZMrH5YZ08WKAqRYDj0v/rRqzFvjvzbf2+3LF29r2fMdgby
 O29O5Kh7WyQ/iIyOXFlQF6jXWAkkaatnEtRXv/MuPiyejagIwmU9lQwAYTqQ5td8m7n4
 +CNC7erfUEnHDCyMyE1tkEwLPpknsL6QeAJvDXX/G2Ss0lntvmPZ1+zak/NDGHstj6Hr
 4vMITxAT2zQX+JoOMJd5b9bIk3f6kkj7+keKOV/OMQD2A7n2Coao7wTZ+c0JaevznYIw
 LdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738946444; x=1739551244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/s1u7j02fdn/PpNH7d1OI9ADeeEfLYIO2WWJTxBpH08=;
 b=eX8n4skQW27h3vw7/vOc4WVhhMSJPrBc7i8ABDI6OoNvp5KJ1hhGCcWKsi9frB7PED
 N0VwRYpZrzhVu/p7co0iOWnD3UqaTDEeHOoGx1m30oT1dR/QBNwnMfo4n8Hg0xnBlhCB
 NcDUpOnCVk9FChmnz6jbOmFIKic78LPE6cEcXHuYXh+mS67vZBaYYN3KoYxVKb3je6Wf
 Z4rvwHlvDYkC77V+zXgBlkZW2tEwZv0rShUz//XUIiejCvli2cHNXq1P4qQ0Wvwo/0C0
 20ZRdqjyn8eMzcqXa2wknIGqVAK6xSTObz86p2i2R3vXjU6H4tVf7LdAGjhzmeYcWd3F
 O7LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVmv9J5K27Db/16l7t+jp0syiPg6PrUZUZV4Jw9c7hhNeqRwDN86a8eVIw1xtMDcy8oGOHYW1lhQFy@nongnu.org
X-Gm-Message-State: AOJu0YwTt2Tq4Ium5j1U6i1GeFe8NtOW4SBbsIUXTmD1f0Oiy4vrhOUk
 BvTPss8gVjsbqf512qNb/TZEw8EMqQmkciKHiqTMhic1hor1EbfvRXgM/x9JPHSgvXQQt/Pw6x2
 wn9QHTlIU4JYKh48fLYl6Qypk84p2bQX0i8Y94Q==
X-Gm-Gg: ASbGncsL+vrAgxiszNP4M3NyIN/SkMI6sr+of6fvoP8WHtxuoxRPGCQLBveCHQtLrZp
 YPhzME7qgisXpTCAECAegm60+JvdD5bb60BwX3SMr7cD8lqiTHc6Iu51esVZMV5XEVZZz4Ug/lg
 ==
X-Google-Smtp-Source: AGHT+IFJZcnIAKnJXqiJoHJAoFOIo62hcGWutNDOvHpcI0OunGTERzVO+lLPgMpn9JyJ2r4JlFBHsnEl0kAOJ80AXhQ=
X-Received: by 2002:a05:6902:1b12:b0:e58:a2aa:5234 with SMTP id
 3f1490d57ef6-e5b4616ca68mr3144107276.6.1738946444482; Fri, 07 Feb 2025
 08:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250207060822-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250207060822-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2025 16:40:33 +0000
X-Gm-Features: AWEUYZkopjxOM1-HIYOyKs6aoYi5XsykQrgz6-bQbGpuxCYJENFnKmOLqmZ5U6c
Message-ID: <CAFEAcA8j_ra21a2cuJKSxcL81qoT5aUHmb_mOs1J7aVjdR+eXQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix vIOMMU reset order
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, jasowang@redhat.com, imammedo@redhat.com, 
 peterx@redhat.com, alex.williamson@redhat.com, clg@redhat.com, 
 philmd@linaro.org, zhenzhong.duan@intel.com, ddutile@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Fri, 7 Feb 2025 at 11:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Feb 06, 2025 at 03:21:51PM +0100, Eric Auger wrote:
> > This is a follow-up of Peter's attempt to fix the fact that
> > vIOMMUs are likely to be reset before the device they protect:
> >
> > [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
> > https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com/
> >
> > This is especially observed with virtio devices when a qmp system_reset
> > command is sent but also with VFIO devices.
> >
> > This series puts the vIOMMU reset in the 3-phase exit callback.
> >
> > This scheme was tested successful with virtio-devices and some
> > VFIO devices. Nevertheless not all the topologies have been
> > tested yet.
> >
> > Best Regards
> >
> > Eric
>
>
>
> Looks good.
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> How should this be merged?
> I supposed I can merge the 1st three and the other
> two by the respective maintainers?
> I don't think there's a dependency here, right?

If we're happy with the design of the series I think it
would be simpler to take the whole thing through one
tree, rather than split it up. I had a question on the
smmu patch which is mostly about clarifying what the
issue is that we're running into, but in principle
I'm happy for you to take that patch as well.

-- PMM

