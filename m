Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBD9C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3YG-0005gq-OQ; Mon, 03 Mar 2025 06:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tp3YC-0005bQ-QR
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:01:33 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tp3YA-0003G7-Qb
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:01:32 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-abf57138cfaso320713366b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740999689; x=1741604489; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1DJMsQw9xe1bQU42ybx0La6l3fNEDMG8Y1evDEN0FI=;
 b=aJxARTg/etFFGF6NOysIDPd08x+RheSA+UA58XevSF/1BgafWcW6Q6H7BTsZRAO6ux
 +uc5QqqRAMvo+HDiVU802m7Nev2QRnSDOzB342XEQkvbmuxAmt+GmzRrWsJ72ZB5kl5I
 H/N1pvsFXDkxYrHYgDOtRJaLjXVN8br4HYrpsBnMAezRkhwiVPATgn4/+pPnL0Xnyck5
 1M673STP4B5FdAMeUaMf9dzClPVL05qZ1tdKjFztLVu90FVJqMhFIALaii54zBnapaRE
 oeIQ1CgexX2Y0xDzwxO18RtEyLKSLjZBoS60Zw0qQEq34ju2GhsH5Y3E/lfJN4UvTF1o
 YZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740999689; x=1741604489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1DJMsQw9xe1bQU42ybx0La6l3fNEDMG8Y1evDEN0FI=;
 b=ZgRvk0wgc6IsQvi1mTBObv35CSiey9QieVq0E1SrdyIc42xT9uCWeoAM6azowxlfV0
 lfQfgGiVh4ZGe5xm/p0tiaBEOoTUkN/qufeQW0ExOhFCHX3sqCustdz7v7wPIWS2CKzW
 8HGMlibhayKhxP6RIZQTpUz1jLtGM8yx7J0ludsEqpujT3LYTzqG/RLLFXqS/AjwqKvg
 +IEOg4lIzO2Dtr1YC7VLvPrAjrhyJNjQfC6Ed0XMqsxuPRXUxDm6bIOgY5mn6OniyPOB
 pWuic0lnIKW5ZOCIjR9dAsg7tPpCWKhFtLoPbQxaiapQEQiJMlddBkKHscQYKb7PTaEY
 sCbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxWdkYIemNHNVW34oSJZoeTtZRd4wQKpkWA5GESsU23y1VbyVnHAl6Zk/ZwyAnklp5Ah5pjWg96CWg@nongnu.org
X-Gm-Message-State: AOJu0Yyzh5TnzXg5lKeXL7S2EYPnP5mdsVyizZw4R0/od6n9amC3EydU
 LlF1EBLvUGA5j7sUQZAl4lf7OoW6PUVrwicv756+kfmJAMIAT8X4KHec8Luui1GyHl7YGej5OQb
 zehmkg4SJZgMPsb4lKDnFAXchCgU=
X-Gm-Gg: ASbGncs0AzwdpEMRjEf+Np/y+RwAx5/PlzVQ9YylHew7n/PfAsDzMZoogqtujWVZMCc
 zCCo/0GTn2zcr1sZsIa3KYaQgrZJMuXFn6mCgbf2D0zSceWynVDMU/PcRc3wEGXMisjNkjk7ru9
 QBJeh4ZKOFvjHaR7w9g+UDDB0FQQ==
X-Google-Smtp-Source: AGHT+IHPTKGqmu7rFmonzXxBS7GBp8to3Hz5phrrfSuXduaxJb+xQxL+D6EVlYDl4ghLbkhE2SmqJbUulYlLJ2oeJf0=
X-Received: by 2002:a17:907:7f25:b0:abf:7a26:c47b with SMTP id
 a640c23a62f3a-abf7a26c60bmr272623266b.39.1740999688774; Mon, 03 Mar 2025
 03:01:28 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUk77GViTBgBpfYH-AbAmQ5aUwi0K6UTH9iv=1mVb0Wbw@mail.gmail.com>
 <803732f6-6ab1-4298-a956-660496664f67@redhat.com>
 <CAJSP0QUN_tCSZ=WOk+C9kR3TMqkTaZMNF7qaAsFPiauzN0r_QA@mail.gmail.com>
 <CABgObfYJTPu=sTK5UG2d28tTYrACRaiqU6Wzh_0NhwdnQmg74A@mail.gmail.com>
In-Reply-To: <CABgObfYJTPu=sTK5UG2d28tTYrACRaiqU6Wzh_0NhwdnQmg74A@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 3 Mar 2025 19:01:16 +0800
X-Gm-Features: AQ5f1JqKBrOv2sR49pw6mBfDLONQRdK_vALfTmtidJPegjR7xInNwv-H0QpWqsU
Message-ID: <CAJSP0QUt6YK7PCZ92hmNaVfL+nSSNsQg3KKcpP79SCNJtvfajA@mail.gmail.com>
Subject: Re: Kubernetes gitlab-runner jobs cannot be scheduled
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Camilla Conte <cconte@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Mar 3, 2025 at 5:26=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On Mon, Mar 3, 2025 at 8:35=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
> > GitLab says:
> > "There has been a timeout failure or the job got stuck. Check your
> > timeout limits or try again"
> >
> > Duration: 77 minutes 13 seconds
> > Timeout: 1h (from project)
> >
> > It ran 17 minutes longer than the job timeout.
>
> The job only seems to have run for roughly 15-20 minutes.
>
> I am not sure what's going on, but I have opened a ticket with DO to
> request both larger droplets (16 vCPU / 32 GB) and a higher limit (25
> droplets). This matches roughly what was available on Azure.
>
> Let me know if you prefer to go back to Azure for the time being.

Yes, please. I'm unable to merge pull requests (with a clear
conscience at least) because running CI to completion is taking so
long with many manual retries needed.

Perhaps the timeouts will go away once the droplet size is increased.
It makes sense that running the jobs on different hardware might
require readjusting timeouts.

Thanks,
Stefan

