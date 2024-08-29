Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367BCC83F16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 16:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjhmp-0002QQ-Tn; Thu, 29 Aug 2024 12:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sjhmn-0002Hc-D8
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 12:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sjhml-00052g-GD
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 12:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724948049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6npwhu39G30tGrB2/fpfVMwAsgHQeo2hNQ2jcyFeobk=;
 b=fr9++SL+3CyBc82hR5dQNtdUXfPgaCIJBoPUflEXURoyMXi92swRNnHkVgqluliQNvNVaD
 SaalUN7k2ala1Cc2ewdrSEaOY+zrA5wo5U+joKCoJRLGRxHZs6Y+4nwmT6dPqIBRlOEOje
 DuHnDE5x3i1D9K7cSBoixxJilM6Q3ic=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-S5LWQUwnMZewAX-2BDusbA-1; Thu, 29 Aug 2024 12:14:08 -0400
X-MC-Unique: S5LWQUwnMZewAX-2BDusbA-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-82a1ccc67c0so3946639f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 09:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724948047; x=1725552847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6npwhu39G30tGrB2/fpfVMwAsgHQeo2hNQ2jcyFeobk=;
 b=p9Fvc9ELDHeDDuQ/yDXDa/AqB297kDKtIMfJ/nAqIRa9bFgrbMapz0l1St/+suT1hY
 HxGoSEoy0nKME9a2uN8W1TQmvR+J/1JCyHhVIDehEdpEQ3gHNXCzh1CJA9LkuSUFVnFp
 wF1K4E1FMYKCKlRipz7zAIc0LtL59DsllGHhSh5vXRExufo+Ow6YAmyV/zEE9tm1Yrz9
 NbtEcjOtSRBjOFfmOEUieZ3svc7IvvAVLdJyQQRduPEol3ambiE2KHcURPGJC1Ykn4hH
 sxugiThzQA9j18Q6/caELJbMZ+GCOtH40LErTsDKVPcncqePNqffJ2Lc4l8zEF1jR8en
 er5A==
X-Gm-Message-State: AOJu0YyJCIaK1Q6dqcHBqIs8PCN7Z8vpTcYvLd3UPhYc6JDbIexXoL4O
 sZsT0HBVeqlu/WFBFQ1uMtdqKkXB+jy8Uv2tcSwbO3QtkQTl+BpU3ND+AgXNIh59e8Eqo1SCjh1
 ZCrgy6w7fbCYJWVVGN603AriELee/LHI9A1CaS8zcuS4QBdbt8ef8
X-Received: by 2002:a6b:f702:0:b0:7f6:85d1:f81a with SMTP id
 ca18e2360f4ac-82a11076864mr209364039f.2.1724948047486; 
 Thu, 29 Aug 2024 09:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8d8YAS2vnGk8Zijn0DcKHu1902QbbB+pvEZPDHT3B5c7+yWuqKmEC1TyVb88rl+3SYyyKlw==
X-Received: by 2002:a6b:f702:0:b0:7f6:85d1:f81a with SMTP id
 ca18e2360f4ac-82a11076864mr209362639f.2.1724948047125; 
 Thu, 29 Aug 2024 09:14:07 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2e93713sm308232173.88.2024.08.29.09.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 09:14:06 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:14:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Corvin =?UTF-8?B?S8O2aG5l?=" <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, c.koehne@beckhoff.com, =?UTF-8?B?Q8OpZHJpYw==?=
 Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 0/7] vfio/igd: add passthrough support for IGDs of
 gen 11 and later
Message-ID: <20240829101405.59e034fa.alex.williamson@redhat.com>
In-Reply-To: <20240828134328.94528-1-c.koehne@beckhoff.com>
References: <20240828134328.94528-1-c.koehne@beckhoff.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 28 Aug 2024 15:43:21 +0200
"Corvin K=C3=B6hne" <corvin.koehne@gmail.com> wrote:

> Hi,
>=20
> Qemu has experimental support for GPU passthrough of Intels integrated gr=
aphic
> devices. Unfortunately, Intel has changed some bits for their gen 11 devi=
ces
> and later. To support these devices, we have to account for those changes=
. This
> patch series adds the missing bits on the Qemu side.
>=20
> I've tested the patch series on an ElkhartLake and TigerLake device. On t=
he
> guest side, I've tested an EFI environment (GOP driver), a Linux guest an=
d a
> Windows VM. The driver of all guests are able to use the GPU and produce =
an
> output on the connected display.
>=20
> Corvin K=C3=B6hne (7):
>   vfio/igd: return an invalid generation for unknown devices
>   vfio/igd: support legacy mode for all known generations
>   vfio/igd: use new BDSM register location and size for gen 11 and later
>   vfio/igd: add new bar0 quirk to emulate BDSM mirror
>   vfio/igd: add ID's for ElkhartLake and TigerLake
>   vfio/igd: don't set stolen memory size to zero
>   vfio/igd: correctly calculate stolen memory size for gen 9 and later
>=20
>  hw/vfio/igd.c        | 185 +++++++++++++++++++++++++++++++++++++------
>  hw/vfio/pci-quirks.c |   1 +
>  hw/vfio/pci.h        |   1 +
>  3 files changed, 161 insertions(+), 26 deletions(-)
>=20

LGTM, for series

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


