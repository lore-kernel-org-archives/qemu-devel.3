Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D5ECA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 05:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuOpV-0001L9-SS; Fri, 05 Sep 2025 01:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uuOpU-0001KH-6F
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 01:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uuOpS-0006mn-IA
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 01:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757049461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q77ng2A0tW7+SeLCv5hnXWTjE45/Zi3Dc25BlIlprQg=;
 b=I9J/QBfvqWRknoIXQTAfvQqDMkpSInx71RoYK+a71350yjv3WFM1dl7+EVgeQeOP43JNVE
 vuoxbUkbRnkHH6kRWOyxbs3Gq/PUccdakJLIoWv3L/4/ryo4VzOBb+yxcNfdgg704tCVs2
 2hU3vMEKq4+M4uv8/agxflHE+31ArL0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-SMhyKEITNImxcE9_qc3RBg-1; Fri, 05 Sep 2025 01:17:39 -0400
X-MC-Unique: SMhyKEITNImxcE9_qc3RBg-1
X-Mimecast-MFC-AGG-ID: SMhyKEITNImxcE9_qc3RBg_1757049459
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ce7f782622so567876f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 22:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757049459; x=1757654259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q77ng2A0tW7+SeLCv5hnXWTjE45/Zi3Dc25BlIlprQg=;
 b=g0GkbRde8WVV8WfkDfMY1IYPKFajmn67QduKNv/C2NBHhjJojAISZoxznvXzK70rTT
 AwLqOIcepHkTeKHZ/9oz1gl9Opk9DKzA1IYJrL9fVznL7CeA/tVH4BVYYz1rOewjf2EZ
 rtSkBmegV8Ti+xiiPzOJ3EZrMrPxZCqiAKhGY+NNZGV5PgxAeBcgPf/zkOewLA6b4UZm
 B+FCm50FmmLu7Y7tpQLwgw94900hqoaFlrRLZSpnuoulnhIqgEjjPiNXAQv2nUf6Yfl5
 9S/0KYGW2PklIIc0uGBZDTopLTWCSI6I9HMZWTvdmc97xrOmRrgmMOZUZfbC7ALFUGy8
 bIzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5L38SCTCpyoV1g4AVujtdyayU9I2uBmX82aQmWTA15dAQgpuaSVfhOHHqRdZWgsNszkT+den5Pi0n@nongnu.org
X-Gm-Message-State: AOJu0YzVmbKMYVxnfjX+ZtWHcSSuToS9+7DkzVzagU0qJ7aDEjZpomMU
 cU0uiJSb1HPHb6UHkPFNj922WYYdsTJzNUdxeTRMhd2hv0xpwI1HQ8hdAtk6bSuSXTSr0z0jan6
 /FAlID1CW0hXBbsAYSqVJWrdaiDlr10Zm4QY81R7p5j4oeSewox0KPGcQCBhXGzioC2WARfonqq
 gC3+gicBwc0fLzLIeFOFhmgqA2XN93tpU=
X-Gm-Gg: ASbGncuiuyCe+doJifwSC1YoigajE/5lAh3z4mB08hu/Em6PSH/Jf+QAmD5xWB9BJlA
 jFjlA/sS/2LRmnWzZto+9hYeoiROChsKT2DnDk/k5SudCAGpn234h/vbrUwNkxPQ67WQ7D0NjZG
 kdsmCBsyKMdJBb37d+wZAUjnm3NJs6tO6sKj0qEnV5H4rIxfjuslqiuoV/M9VYECt0oWjG/Wyvo
 seaGRKFIfhoK5O7D55CbA==
X-Received: by 2002:a5d:64c5:0:b0:3c8:c89d:6b71 with SMTP id
 ffacd0b85a97d-3e30331931emr1563191f8f.22.1757049458775; 
 Thu, 04 Sep 2025 22:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3JIBXRc9dpF4BVdkhjyT9NdjRItm7ynil4dFxFEdqpmsgnWE+m7vBturtUGlxfK1+b/o7jSs/FWtNrXULL8E=
X-Received: by 2002:a5d:64c5:0:b0:3c8:c89d:6b71 with SMTP id
 ffacd0b85a97d-3e30331931emr1563179f8f.22.1757049458423; Thu, 04 Sep 2025
 22:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250506152927.222671-1-pbonzini@redhat.com>
 <20250506152927.222671-2-pbonzini@redhat.com>
 <CAJ+F1CKZr2PZbXvi8OZ9O=QaGv4WUmLPofBzqDv4VAV64y9EnA@mail.gmail.com>
 <1546553e-a21a-4a0a-8bcc-6c4e23ff35e2@redhat.com>
 <CAJ+F1CL+TxyRN0P2njCBRLigKe1tO1CyNOuCP1L5LHwE5FMEsQ@mail.gmail.com>
 <CABgObfY87q19jxOw_tv86dzBkd1AbhjKN6rNqjeh+yFguYizhA@mail.gmail.com>
In-Reply-To: <CABgObfY87q19jxOw_tv86dzBkd1AbhjKN6rNqjeh+yFguYizhA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 5 Sep 2025 07:17:27 +0200
X-Gm-Features: Ac12FXzeQNWW9XG99XLggU0HDYN5kUE03Ymuh-WUiJuZf1qKbGRhC6rty6ZT46I
Message-ID: <CABgObfZAjmCER-LKnsPdYZJjioBYpSoyexoo1fsx01PV-mxLAA@mail.gmail.com>
Subject: Re: [PULL 01/30] lcitool: use newer Rust for Debian and Ubuntu
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 5, 2025 at 7:16=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
> Big-endian MIPS is already deprecated in preparation for Trixie. Until
> it's removed we can keep that target, or all cross-build testing as
> you suggested, on Bookworm.

... and not enable Rust there, of course.

Paolo


