Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF22AEDEC1D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxgLf-0001Gt-4e; Wed, 04 Mar 2026 02:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxgLd-0001Ge-4O
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxgLb-0000pG-LW
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772608122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aYWZxDP4xmrA9S+jh1JAnFPqC0MQR1e+xzAiH8ejzr8=;
 b=X+yUX4IGAoDfxG1C9f5pa+6mkpg/RuZKEgWY9vBoPN0e0mPg9ofZ9NtoDtcGvOQj9j24JX
 Ny9O5oVx6A5NqlYVHtZg5UXU+nNgmUTxcIftkJv6hVFFF4NKepZ0rGZEmO4GyQsVRiW2st
 q4XbjIf4q2HPmBrra2QRt1XxqqobZ5E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-M03zmcQ9PcCUA3YYyb48ew-1; Wed, 04 Mar 2026 02:08:41 -0500
X-MC-Unique: M03zmcQ9PcCUA3YYyb48ew-1
X-Mimecast-MFC-AGG-ID: M03zmcQ9PcCUA3YYyb48ew_1772608120
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ae4a6bb316so34394185ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 23:08:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772608120; cv=none;
 d=google.com; s=arc-20240605;
 b=hC6QpvqDlpXtLiDXzj3f69X2+NWR/r/vR5XBhnVyYzP34sw/SwRWAV+4J+58GriJ2C
 l758zZRnsbRxI4bd5zpFDDWv+HdlYZU9ZF/7DRL4IzMA9pMj6ztoz9eIJeBdqQiarNyk
 EoIx0pjHkP4AkIialPZbU8KggruYfaKPxgFLJVk01i+fXpCTtXNO/M52mwkgU5u3rU9H
 Lzjnh8NflQCef3a+GQCegZZJR4L0GpgpSMsM/E1icJ6XSyC3Wt3raplWCky4qlHGVQQH
 7lhislGuamv6zC/2eVpghLiAGA2VsONwqtaPRUZEJLPmm2irprtwBZ6v3fNuw0fV5Gv7
 2C4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aYWZxDP4xmrA9S+jh1JAnFPqC0MQR1e+xzAiH8ejzr8=;
 fh=x+wZ1Jwvq/irxESHq9MukUL2OgNfBYUuohgfpS6g4V8=;
 b=HFjCs7mpWAJyTNracRC5ye2cLroDi7I6a5bR0Ij4Nv0r3/CaxAvjNxkErMNlhSSOyf
 5i3637oyZVbxCBV0a/wN88m4IGa+bFW/VlgowtolWCQN+oPeIbOefr4DOfFHxn2mhhyo
 9M5OyQDYOPbyQT91/9Bp729HGW5psJs1Jvgwbq788coNo/RI4Ym5gn8vBJU4oozaCBxi
 jIrmwWU0xRvM/UKU4Rz6rohzDjELcEvnQU8KVDeU0ayCm3sVK+YrSaF2orfa8OVBJ0xy
 T3mV7IXXE0ZR2/9zMcUAKO7ea/XxeRdos7RSCfTavwZLRMbcGzOP8A2q4I/5WFNnYbTV
 AGag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772608120; x=1773212920; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYWZxDP4xmrA9S+jh1JAnFPqC0MQR1e+xzAiH8ejzr8=;
 b=dT6ZWrJNcMxW0oJ8L3Sj9XyAAf8J9WKaCI/FeDwVicV4ic+irQFTK4jF2yoNAvTCHG
 Vz6Cfg3vmo+mb/KkV+qREaU3jippNbeWpXsEPkCLxce8wBorDasy6T+ZEX0CtqowRRGG
 y7oBJIc/Mavw0ODBUjP0xi9k8dsVHvZ1yTfngaSfUQxKmb/HZ2yIVyP9EjNzApvmW7TG
 RCl+UZ/5EKvc7oBX0RYwreNPhqvS8R2rYyHhwijA+Ws31VopaTF2MRwOJYSiY9J15zqP
 33krEpn757AvzA2po6+blBlJ0LlJqTj07T5SCLB7dn1gRKtHqhl59LPMjps27I01Y3Cs
 /9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772608120; x=1773212920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aYWZxDP4xmrA9S+jh1JAnFPqC0MQR1e+xzAiH8ejzr8=;
 b=AyxC0kSPUR7D6f0/+Npnm3PEi/E8R8DgXDGJ++CC5fxB/Gp4NZSDG1q5amO83L6Hjr
 W8C6q5yzVh2AVFIjaDQosDzlRivzrMnAo+JjtaJ4Jl6TXv1G/9zxWKaueqTPbXf5A2Oj
 cqoO/lJFHXWeQiLbB/PlBkYuASCfIcw2kYNI6J3PV0udrjkltVCobdwN/OJ7iaGq0LYF
 ra+3altPQXXljmT8sJDdrdcX7Zsn8rwIYGnA1bePz3DZ2HyRO0FMiGh3zeoc+TyAcmDD
 xtdvpI5q1TVixoZSlgA3n5Cy7hbwWTZJM7E2T2h1rhiVvrQksyKvN52kEmvR0tuYBoBG
 DhSQ==
X-Gm-Message-State: AOJu0Yyg0AQQpZUB7pPYCOvPn/K1HIXIl2Qgk0XIzrm36X/e3z3jjQzS
 42gZSvj/50fHEJdMghohwDm8UeHVi7NXrtJ4l2WKSJrCjUva08EVsxwNuq8hxYsGn7b5KdC0dWD
 q75sF4iQfjnOZ8P+pPuIN8s57R1GwcIs9YF42gKPaDbG4D8/82g4s6nNLnta4PYKQErGDQTZtkr
 CAR3ZEzWx/qPNCLshrOzdrN2GElbL0noPe0iCaDRGXLg==
X-Gm-Gg: ATEYQzw3CL1hF7Su5cFTs1fjsTr2yCG7dKGLsXiwsNuybmXBTcBEaEGG/wjeGifXIbs
 b2UkOvtWolWzs2jQSg+Dqgj03Iyvb6wPjO9glWb+3wQ5/YH2mhmoJ2QpeZewCVfTBml6Nb0mzbm
 JTk/VgxTYzYByEFvPRFPuFsHoRe+AHhm+DIsrOnkv9StSbOVZNMfUaxdLQsJoCQa1wx2MRJvJWN
 06lDnk=
X-Received: by 2002:a17:902:d503:b0:2aa:d5ea:4cfb with SMTP id
 d9443c01a7336-2ae6aa04db7mr13110635ad.9.1772608119916; 
 Tue, 03 Mar 2026 23:08:39 -0800 (PST)
X-Received: by 2002:a17:902:d503:b0:2aa:d5ea:4cfb with SMTP id
 d9443c01a7336-2ae6aa04db7mr13110345ad.9.1772608119488; Tue, 03 Mar 2026
 23:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20260223-passt-v1-0-101c6ba1c88a@google.com>
In-Reply-To: <20260223-passt-v1-0-101c6ba1c88a@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Mar 2026 15:08:28 +0800
X-Gm-Features: AaiRm52V5p9yUr0X2wDHthODGQnnd2ViKVNngX5E3ySOWtjH8cHj1BHpGKgV_rc
Message-ID: <CACGkMEvF_j1s_bvpnwwGEQHfEftSNoj5QEFa9sAGd3fg54E9iQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Error-handling fixes for passt
To: Peter Foley <pefoley@google.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Adding Laurent.

On Tue, Feb 24, 2026 at 5:52=E2=80=AFAM Peter Foley <pefoley@google.com> wr=
ote:
>
> Some fixes for passt error handling that showed up when
> trying to enable support with an internal Google framework.
>
> Signed-off-by: Peter Foley <pefoley@google.com>
> ---
> Peter Foley (2):
>       Only kill passt if it wrote a pidfile
>       Don't try to read the pidfile if passt got a signal
>
>  net/passt.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> ---
> base-commit: afe653676dc6dfd49f0390239ff90b2f0052c2b8
> change-id: 20260223-passt-0708603dc495
>
> Best regards,
> --
> Peter Foley <pefoley@google.com>
>


