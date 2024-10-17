Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A143D21262
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 09:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Mau-0006M6-Lv; Thu, 17 Oct 2024 05:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1Mat-0006Lf-0Y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1Mar-0002hb-Jt
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729156492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0gpUptpWKApUHwiJ6LoyEnuhzJeGxkEeZTr3Sc3qSk=;
 b=NNYAmwexdR33tXwNxCHie4ULaNn7VHc+SVqpYVSymPWEo8hQgswdCfxNhrilyQZ+Ae0LxU
 NLhVXFfakofgawE2t7QRXhoywoiRW8h8Dg6qMvfL+NsdkOj+vGc9Ui1Fzu2MXS333LcZiT
 ihnBdoosyqjje2+wfNCgUU/bc47VXE8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-USHUzyZCPhGqZ-s85bdKPA-1; Thu, 17 Oct 2024 05:14:51 -0400
X-MC-Unique: USHUzyZCPhGqZ-s85bdKPA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d5ca192b8so346897f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 02:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729156489; x=1729761289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x0gpUptpWKApUHwiJ6LoyEnuhzJeGxkEeZTr3Sc3qSk=;
 b=iJ2Nkfw4wVPIGLI+gRm9X1+kGtkMfwn2+lzipXOxjzkRh4aA2MXxAXtbhGUSLFOYpu
 ZZDigGcgGAm/LQFCu9fWYJoklrrVrOrYUnUY/ektJRYtyUi3L1+X/yPoj6Hpl7BvGnGX
 KW82pwhoWH/JKJpAwhPUYq6fLdy5osYSTpSCI2fbVeRDE2RXiKYZB8/lv73MWwhlEFoB
 RFQPeLPDc4igxZ9v63ixNaBC9CnmGTw2N/7SPXiE1Ol6Yq/EK60qfzBKUQVLRr34keq+
 XgrGKU5HTjbuGD1exlbHmHom2nvRaMSypvjTkcTLplxm8EecvZSSi48nicA3FXgw2POP
 0kBw==
X-Gm-Message-State: AOJu0Yw80Ivx1pF48xW8J41JzKZQHob4zoEFB1cm/bHKKSaQRI9/2vCM
 DGIjZ/lpBat7CFQhrcjzDl3McVCbG4I/YnAt2aaQ0eaLBjWJgzZLVwgYsfU7PeGTH71MCFIK3Jt
 DxSkuL7Rjd7MzYMrQDyFeD3lphGesvJhsPHjXzDZaQug2Z8uD1EUz/9pVyYhARdH6QC++NCqRTR
 7ESCrO/xJQ8/XT24v6zsKgSsZX7WtRbKWgUYBmgSsI
X-Received: by 2002:a5d:6b91:0:b0:37d:3baa:9f34 with SMTP id
 ffacd0b85a97d-37d93dca7acmr1546720f8f.1.1729156489022; 
 Thu, 17 Oct 2024 02:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUD2gWc9o/yxgGJ9qGrskbcsyuaBWAD5Fr6jJMnHfwnZum/OZh9G2qMNSyaV4JToBrLDgGQTAk7rVZ7F5r07s=
X-Received: by 2002:a5d:6b91:0:b0:37d:3baa:9f34 with SMTP id
 ffacd0b85a97d-37d93dca7acmr1546705f8f.1.1729156488670; Thu, 17 Oct 2024
 02:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241015141711.528342-1-pbonzini@redhat.com>
 <20241015141711.528342-14-pbonzini@redhat.com>
 <b48f19ae-0e73-48d1-a29e-0dd0e4570a39@linaro.org>
In-Reply-To: <b48f19ae-0e73-48d1-a29e-0dd0e4570a39@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 17 Oct 2024 11:14:35 +0200
Message-ID: <CABgObfb_Hgdx=naeyOBQeyzcj43db3pSu-JbsfLNmdW-c4k1WA@mail.gmail.com>
Subject: Re: [PULL 13/25] target/i386: convert CMPXCHG8B/CMPXCHG16B to new
 decoder
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
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

On Wed, Oct 16, 2024 at 6:37=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> On s390x the cdrom-test generates:
>
> tcg/s390x/tcg-target.c.inc:1284:tgen_cmp2: code should not be reached

Backend bug, sent "[PATCH] tcg/s390x: fix constraint for 32-bit
TSTEQ/TSTNE" to fix it.

Paolo


