Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0F8CD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waE3a-0001CN-PK; Thu, 18 Jun 2026 10:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1waE3Z-0001Bl-67
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1waE3X-0002bL-OB
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781794162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnicVFvfolWU5ASsZe0xlhAi6HzOML3cTzXjnCc3Ovs=;
 b=atDSLlQHLkkpyHvAtQrkxUWV5l2jWzBodACSrFSXd5zNdOC78qF79NJIDmCVOa+ItH2T/s
 NBVID4aLuisNkTFGG3hhyDtZ2afEHOSWLj/BTRwqbiN+TnCsZJ6OcX95qEL28YIvLPRDDG
 bpv00Q5q+O3WtxJkbqsL+5pv1/WDn0A=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-3x74mkd5M7iymRxgCUnR5w-1; Thu, 18 Jun 2026 10:49:20 -0400
X-MC-Unique: 3x74mkd5M7iymRxgCUnR5w-1
X-Mimecast-MFC-AGG-ID: 3x74mkd5M7iymRxgCUnR5w_1781794160
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8924f4d0a4so1368884a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 07:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781794160; cv=none;
 d=google.com; s=arc-20240605;
 b=KtywC29FrcyPwH+sw3cayquXVxn8fRg7ny6PCvbRSmg262a6omrp3ICvcK+fjPgvGY
 7fpchFrDzpkImvD3sxTd0PAHNrLKRi725BYdNbbektj2/OLNwzLD6tH8sODSOxzJrgKv
 I3J2qvYEl7DaNQMpg6GYhEAxL/3dC7s4Bc7PGDpcm89bY9LN1H6SV7Nc82e1MH9AN0N1
 iSnl1RAn2MORJOeYJgAZ8QoVWSSxOpGuWEkXS1e56CjzRjwMOy5WH8ABuWy0mMPOzFOt
 8ai0NTZ+vHqXZjrgxqiQL5x20hZLyWJufaqOdxwq7kBe78Lj6kL/ZSIcN4UxTiZ1m6zE
 fXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CnicVFvfolWU5ASsZe0xlhAi6HzOML3cTzXjnCc3Ovs=;
 fh=z98T1OafDend9cTt+HRd9jcDMICFJhgMbFBEwxbd3bo=;
 b=UdkeVIr5QuOFqqO0YrnOFV7HeN9Kdh3yL6m9PKEKWU1iZemzoa4KpFuyKnB7t5iQeL
 r6WmCtcRZQepVb/a+BpyuXa/xOA1JLqLHC52tAXg9CV3iIMRO1p0UJSNW/mbjR5oHGE7
 q6NLIfVMd6rAyj88e61O9WSctVjNVrSD3mlslNGSi11AWnY0nELuyxeSM70zZhnNxDI+
 26gAuLVTld0t23PJoo26tj4+6Lk8xRoJ5KP1qRpewqPY5JwtEdtWGGox3NiVNxOnmDT4
 8WM68eUYBikFab7D1tcxpftJ7a4UDr+ZrwYsiOTMIftrtUoTMdcghDwO53T6D48F8h7H
 4l8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781794160; x=1782398960; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnicVFvfolWU5ASsZe0xlhAi6HzOML3cTzXjnCc3Ovs=;
 b=FNaf4PcAoGhmsiK2R/5aF09pYg3BXTre0Z6Q+CSyCFweeGZ6ZBJYlf5ae9isdJWn7U
 q4gQbvLtgEWZ+oW1DmsGtx0gsW3lM9+H8ldZP7McuJeINo+xoQ+k3avIrMZG+zJlzoay
 0ZKIjeaA5/Wr+y0aCsE6d7VcNYr8NCAsVql5gm3Xco7LcQChI0Nv+iTDRLRUGtlFrqPv
 F0sEjgMeNamvhJScj+lbx27T6VCzriEM/vLmUrzw3DGIAGhsEeWA1WB/QMEP8g6pLnj5
 iyrrb5/EUr6nMONI3DrQkRnDNm5RQi0hhIJcQBEB7tR/jcVQd0p9fj41qCLfLB5YyRBU
 QNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781794160; x=1782398960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CnicVFvfolWU5ASsZe0xlhAi6HzOML3cTzXjnCc3Ovs=;
 b=GTOVS8asuDp2RL9wHN3Phf0DPZtU0ZzR0Es83+gaeQEkEFTmJSTB2WBwUr2aNGRX/P
 qg2j6uTgWZWncU2ON6mPBPPhmGRdBc7OrPULzfXmbE8Ez7jiIpTxpj8J3mtxobFwb2nj
 LjkLA2QiauydM7KzwOMoA3eCa/8npzFD3ndTMAwKRI9gUygx7xXcfjMpOD7sJdus+vWd
 uhfSYfxDSCDuXj3kXLksaNIySCaUuum4wmXXKy2s4T8Ww/8IMwPBwqMLoudoFwSAMSTZ
 XhzhlxDADMrVkMTHc/sUpoHHvbV4BaPjSVH8YYp9jgNS14YeXH62v+B0ZTpr2zyYIv7w
 477w==
X-Gm-Message-State: AOJu0YyH6qfPScxq3WOeaAAUG6oVZ4ETHyWDgh0yqUfmfl6gsHW/0F6E
 3RINguvkmaQ95P5RbgT6Mhdc34Qp+CqVBYxBOfo49vFKlbgjEc+7VmFP6zZYdKHZtQ7Sw3QqF1v
 2C0pNJghBbPDeKkHcdsqYC1mxBKX4SPxj2rKLyxWaH9p9NRmWQhmTqeiT/fXlmYknQvvqJZRrqs
 iSJZOBYJ7yxzwj0Buooj6PiUw1uMcGD3k=
X-Gm-Gg: AfdE7cl/0GVR4OTGb8rRBaZrN6TC3ivgz8rC28b1QGCzBm23T7ewL/bOnkpK8VcGlYy
 axOMb+gRN4s0MCAugEdha/6prm+H72ll8jBWLxxar4pdziOoDBcfH0yQUT3LCSzqEGiRXAncbkK
 kskM2hxa1xZ1AjnJOUWEpG1WDX1+XcJaHL9jOFEJCaIeyJPUeLwfXDKagISd5TINPw3w==
X-Received: by 2002:a05:6a21:9203:b0:398:7ed3:a001 with SMTP id
 adf61e73a8af0-3b9e5b252b0mr5628507637.2.1781794159785; 
 Thu, 18 Jun 2026 07:49:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:9203:b0:398:7ed3:a001 with SMTP id
 adf61e73a8af0-3b9e5b252b0mr5628471637.2.1781794159293; Thu, 18 Jun 2026
 07:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
In-Reply-To: <20260618132058.1044341-4-berrange@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Thu, 18 Jun 2026 16:49:08 +0200
X-Gm-Features: AVVi8CcNN94ErlcrKxt5Z3tjU29vFgvC0rkmBb3x5q53qtZldVbkhzLmeBY14gc
Message-ID: <CAA8xKjXU1ga6tAQnQK_kLD7jpNOaRcH6Yzg76_t7FOLi0VMOVg@mail.gmail.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 18, 2026 at 3:21=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> It is no longer viable to handle the incredible volumes of
> AI assisted security disclosures via email, nor are extended
> embargos practical or useful.
>
> Remove all information about the current security process and
> instruct reporters to use 'confidential' issues. In contrast
> to the old highly restrictive "need to know" approach, the
> new approach makes all security issues visible to all QEMU
> maintainers immediately.
>
> The focus is on making issues public as soon as possible with
> a viable patch. Co-ordinated disclosure will no longer be
> attempted and nor will requests to embargoes be accepted.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Mauro Matteo Cascella <mcascell@redhat.com>

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


