Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F90CED62B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syS7e-0006t9-Az; Wed, 09 Oct 2024 04:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS7c-0006sp-C9
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS7a-0000aQ-Vc
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728462758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5LEXf1OV+BHeZmadhFnd4+3w/ICXhQoV9vUQr0VSnM=;
 b=RfgOvf/frJHCQPrcaBJABNOJDS7G8UZvCujLJaARPLod0VdtQnkLoMHTJIe92rjP5kW+tQ
 SUsLCLxDTTqt0sN2EnWxZGoSHu5XAN9yYaYnqtM6HYthNuCdV/1DSyE+QCar/rMb3OoJHV
 N0FUwAxifthmnw4BDskZtn+FG4MF2+I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-HK7l_4gVPJmoUL9-Svc-Ng-1; Wed, 09 Oct 2024 04:32:34 -0400
X-MC-Unique: HK7l_4gVPJmoUL9-Svc-Ng-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2e29df9d3abso636224a91.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 01:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728462753; x=1729067553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5LEXf1OV+BHeZmadhFnd4+3w/ICXhQoV9vUQr0VSnM=;
 b=QZSfpo7XilHQKrq7OmsLL+zUa4qCbqtPN4Z2J+0wKd8UdUA8oxGHV0KqOKtU82X3K5
 AxQgxSKp555zZBsnFpIY3o2kGsIOCrjON67HEH+nEuOwI5YbRCOIyJt6gd59XvKcKCWD
 XDARecUYVjrNdf6cmEfAM1jAzOoEMSnRanIyYal3EM5Yr2Z73U/Q57GnOa31kDCfhhRQ
 SCS52z96rESBknKhPIVdtDPopku28gj7aZraFmrmb3skMwJ4oCoR8i7qCb3vZsZ/Iz9E
 6VPkRPctnZTGwHI3BNJfVwa1JvVisxjYE0NCWeJEbbFxsdlrSXYJD87C7UywU/y6mOSL
 pgsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrHp5bprvl1lurLv4yWPu7mTkvHDoO8xWYxLPNag/po3GQzu+2bnjGicrqMDI5EhDMZj0yxDDgzRK8@nongnu.org
X-Gm-Message-State: AOJu0YwlCCz8esrdyVFrle1SuCg5xPkpAVuEO1hMmx3Z97XzIUL1TZl9
 77++e7ZMuFhp/7Up7oeCV9PiGPhmYKNVsKRq4+KFDNMdr6S5QOHDoPpgliJiw4LHGO42R/vig96
 MA8KEBxfU8k+TEJl2rEAWXnzDSLM6UvdFfIa1AoIb0qBTOSPjazofVmopsb+lUCYpHV3ui2cYDO
 sS+AfaLXRM+y3PK7fs5TRhq9T4cRKO1RDbSIzYmg==
X-Received: by 2002:a17:90a:b881:b0:2e1:e19f:609b with SMTP id
 98e67ed59e1d1-2e2a247d1a4mr2105192a91.24.1728462753664; 
 Wed, 09 Oct 2024 01:32:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVpe8fFctyjzWPc2hjHjG2PApoJLrgbbeLmXEjfmtVPxAbFPdRKzMPsKGSgwGhizHswoWM2UsXIsnyTAX/olI=
X-Received: by 2002:a17:90a:b881:b0:2e1:e19f:609b with SMTP id
 98e67ed59e1d1-2e2a247d1a4mr2105169a91.24.1728462753311; Wed, 09 Oct 2024
 01:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240918231447.458796-1-dave@treblig.org>
In-Reply-To: <20240918231447.458796-1-dave@treblig.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 16:32:22 +0800
Message-ID: <CACGkMEs1Mp4_4bb08enwdLh0NbX0HptFSUCQka_exVWra7w-rg@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rocker: Remove unused rocker_fp_ports
To: dave@treblig.org
Cc: jiri@resnulli.us, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 19, 2024 at 7:14=E2=80=AFAM <dave@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> rocker_fp_ports hasn't been used since it was added back in 2015.
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---

Queued.

Thanks


