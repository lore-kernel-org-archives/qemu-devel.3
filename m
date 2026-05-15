Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A27CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 07:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnIj-0002Zd-5j; Fri, 15 May 2026 03:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnIh-0002ZV-IY
 for qemu-devel@nongnu.org; Fri, 15 May 2026 03:49:39 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnIg-0004fQ-3u
 for qemu-devel@nongnu.org; Fri, 15 May 2026 03:49:39 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65c7a459105so1501491d50.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 00:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778831376; cv=none;
 d=google.com; s=arc-20240605;
 b=GOAoWrJouoU6QD5sj2s/02FgnJLpY6fLNbBLvAbJ+bH+ptBNz0nelDbWq3bWyPl6mt
 /ZlThdz6vPPEjSpsiL8tWNeMIR3M788xsxgHEWobQA2znkI62SQ+NHfbVFJxnVtjHI6w
 5UegTlbYUpuvVwlSeZq/XY7oHnE86+Wnm0Z7obn5yeFEhPRcYpTU7fC4ZtF3j00iKTxi
 /8Zf9X5EmKcmH2Ta1WflIToQagxVDCoyYCYU+uANyfmNwlNfT0B8ROW9WAlV3LqfHg/X
 cdmCwcq27UNcAjo/Z+MA9eDvfqEjxOLOeUAFAAMc9wUAttKQlKtyUxEiKxmPQg8AA4/L
 j7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Kl7r+CxFQIu/AdB82SR5m36jXeSWsX3wG0LWBa4lbz8=;
 fh=e8nu1IjsldMjLOhkwTyl+Pk0dizS3lE7fiZnEkdMfPA=;
 b=LNC7OtEZ3sR5ByugZHalRh7mkmIl2z/mxE5aHvHDtZpfNJXDSdOT+ps6vA1QoweANU
 BMABkJbRd5ONrZexgoimSb1Fqsm83vLR245+AMQn/V3CB+6rjU3H69LwNyxHZgfsM/AL
 3aeIk2usXlaEHGSXRElDc4pMvDQUqKMn5nu3G1zjk6R+uvdkoASoBb+VkZe/FoVql4DC
 julpXBmQDfqO32D2eU8pfnRx/aZDgklvJTi1xGD3aZ1SkDx15JgC4FMAjExGy6Qn8Q9g
 Xq93+Ov/aBR+dgd4gIuy4U5Av+cOKGDfX8XxZb99Y8+a7YNMu5+yZ7H9ql3NIvlVABJP
 ST0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778831376; x=1779436176; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kl7r+CxFQIu/AdB82SR5m36jXeSWsX3wG0LWBa4lbz8=;
 b=m+2LTdyTHoQL9Y6SGPu3x7+HIaLA4PBfyL/8OBThhw/GStu0YxsjlBl9pCU8eOtlE8
 CRyvY50TC6kXRCMIsSQeQyoUuQSh8MyUx8JXNHqlOMq6MVPlv+2gn5QJ8qBgSruSwvOF
 5y8rwbEm+avRKBuYk7D3I1ZFb28Idaett49ULOa/Khh/ZnumHvNLjVSogRs3BCkPJ08Q
 9lkJizFAEy3qyKFXY9X8MupriQpbvSQuLC4+UTVzdTPO5eob7csSbDW4zbtkOf+7J8xx
 KGkmcORoED7rF/N8JCPuNXacFOqz1dxLGiggUdfxFKFIlTFU7XnPhIkhfP14eOoV8xTu
 ad6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778831376; x=1779436176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kl7r+CxFQIu/AdB82SR5m36jXeSWsX3wG0LWBa4lbz8=;
 b=N6HjGHxj2jO/0imShZPQ/41ErEv+FV/ZJG1GGFR4SLPgqW7eaQtpIfmZWxikguHdjy
 uWTa9nA/1G9U3L+GTIilXyxwy9P62YSnA3LkChW2UOUxcrQwr8iU3qItxAnmhyzzc+EH
 rsaRgBY3YzzvqPi/3PCY9qD/m0f8jiplCOlZOY+a1jRLzybgS/wdCKVojget7+xMMdvG
 uOb1JEbGAHvw9SSmJuCqa8XodDvRSIcPxplqb3xm8SK3Hj3AQXbGOJG3ndyBjBkqI0SG
 mpiVFoLUMW/zFR7n/HFXu40PnzYfCXThbS/XXZdUUPpXbR60pfRDFvclWih27K11xOLr
 7gug==
X-Gm-Message-State: AOJu0YxBCELE+O+WQP1FjUc3Z6BHvYbQh9pieyTiAzVCZFOu25l/489D
 PUEwcE72jv9CTCiK8ShUgCp4DL7b2t9NUkf9W9/QHvluRW0iAp+PTU1gd9ctjwsDkXrnJfTUEx9
 dZarzvF9W0jrNKlk6ZXXcdkPXnaFQNs/3zxojR/Qtaw==
X-Gm-Gg: Acq92OG44dkU2VES0VRs+gJINXecgqURwIquyg5YpdN2KNh5GaPwuPTaOldluwgJT31
 mTbLcntg8snb1QcpcfTKK2OEbLT0oaZDvp1IkrC/PflgIGR0c3VGWZjE1LB4fWq7Hi3M5eo1jVY
 J8GBdUUG5f7UojQ5qUzn5qAEH0kO65QGeInf0B8wo4JXjYXqcH6wx4D7bPIgX2umCtfE7heQbaB
 9s6RZthaadTfSV73PU0uuSOtKKGIJKFVMYRaeB7d8aIKTNlFOixYRbZhMZhF/4oxWWCRw/O6JJW
 UKYxX0lmiYxYf9tHCYZ8AaFgGrToDUViuNgPetFVUvsB4OomfxCS5upAx0cIX8/BNSk=
X-Received: by 2002:a53:c05b:0:10b0:652:e1f6:2437 with SMTP id
 956f58d0204a3-65e2148b752mr2045398d50.1.1778831376542; Fri, 15 May 2026
 00:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <agRC56rkfb4z6zSO@redhat.com>
In-Reply-To: <agRC56rkfb4z6zSO@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 08:49:24 +0100
X-Gm-Features: AVHnY4J61MQ27C0TVF1bkLLe1FkWtoTaf6fJmQFbfqWUZECjHxL85E97MH-3tGs
Message-ID: <CAFEAcA9_Xmy8FukkMDGVzU8LvE9giSp9zgrpiGvbxn=wNjJp-g@mail.gmail.com>
Subject: Re: Limit USB 1.0 (UHCI/OCHI) and 2.0 (EHCI) to non-virt use cases
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 13 May 2026 at 10:23, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> QEMU has implemented four generic USB controllers
>
>  * UHCI - USB 1.0 only
>  * OHCI - USB 1.0 only
>  * EHCI - USB 2.0 only (must have UHCI companions for 1.0 compat)
>  * XHCI - All of USB 3.0, 2.0, 1.0 in one controller

> Thus to reduce our maint burden around security bug handling, it is
> proposed henceforth to classify UHCI, OHCI and EHCI under the non-
> virtualization use case and thus be excluded from security bug triage
> processes. No CVEs would be assigned, bugs would be reported publically
> in gitlab:

> The XHCI controller (specifically the hcd-xhci.c variant) would remain
> as our only option for the virtualization use case, with security process
> applied to bugs & eligible for CVE assignment:

I support this; I don't think there's any reason to use anything
except XHCI in a modern VM, and the others are useful now
largely in the emulation and retrocomputing areas.

I guess my question is how we communicate this to users, and
whether there's some sort of timescale or if it's just
"effective immediately". If we're fairly confident nobody's
really using the old controllers in production then I guess
we can just commit the policy update to security.rst and
that then appears on the website ?

-- PMM

