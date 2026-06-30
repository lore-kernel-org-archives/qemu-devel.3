Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9685BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 16:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weazK-0003I9-T5; Tue, 30 Jun 2026 12:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1weazG-0003HZ-N3
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 12:07:02 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1weazD-0003mp-FN
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 12:07:01 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-698439b6e8aso7048879a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 09:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782835618; cv=none;
 d=google.com; s=arc-20260327;
 b=L8zaljYBvhe5pZZm1WJ1lkwZLvwOPTQZqvgMeAq+P2GxrfiVYMOwUEXCQTCKH+ut9D
 xE9zW4f6bbqsK8loTWUsoCC5epH5LQiIwBU0vOFCp3YDfay78E5CnW3BzK3vCqkUIxFV
 z7dWSuAQWK8uyzIFPkS97UfuLWsmmpm+r1KBtKDFwajvyDatH2cjplK0RwamW2G1WHJz
 fsZ2VDw+PfUZHQTcM4fFvgT/kkpY/jbW/vf7VOv1kaA1E567Y9RJL0wm7TKqNXqyGVFG
 JmGLOpnKZM1e7FPt3hBdu6pffQjepeU2E+IScORRIewYl0/3lVNxqmB12J/c3d8Y8IW0
 8cWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q3J9TtQFCSU1vfSxa4LwwUwmdkEJsTuVieZNgOFQGDQ=;
 fh=V4NTgldfx1wjIJvnPi044x5YSSeGR0uzzQx2Na4nWsA=;
 b=hlJo9IYCuxgrWrSB1Dh2aX8HGXNkJatkg+U2k9BBkGhVuIgFm6MVRdAYe1VudSRIyG
 77X1FxpDm4fcbBtsAjhNB4oRpLo1GSVM+WFRkjhDGf1EgI0OQDom4lREkJp0hPPRce3h
 hhZrMirlo7e+IrgZZP1UgUe0tH6yhCQQVdr5yUo3vrJrd4luO2zW+X93Gxd2qdGt+DrF
 imeKfOgfIgjFUAZtUhQjPd30+bo5HcwB12Yitaitg7RE4A0wZuKTCWpY0FWNoLoEIo4v
 0ge/NSfWJkP0LubK35G27b1NvE5mIrZtpDYrqxphiD3w34SthMhCIyg9+19k77+CwONT
 8TPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782835618; x=1783440418; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3J9TtQFCSU1vfSxa4LwwUwmdkEJsTuVieZNgOFQGDQ=;
 b=nLViWuyxOnwNvtrZJGEf5+y53IebEEz01+HMoETVlzHL8jMn0E2TW0F2uribZ25Hr+
 AQ8aSx4Ckne2UiosPdQt38WYPh33K6Pr+T6+oUTfiYoDkTW3GkFFf0r61S/JeUSaQVKZ
 eDNbbbGGLZDOQpWs7LC9FuXdCdOvu4pap8y7gRfeLCoLfgyauSr1jjOLhRvH9pST4LBU
 ba6NDhEP2kYxZN5EUSg9FmJLoS3OKdfSa+u4WK2Rsfrbi1O1nKq18pvVILz884wF5UUI
 M8f/eRdzKGeymRvAGRGQbL0sFvKpTnrPJDjMuIioR7OdBDiT9f1xscunXgtwgkklH2MG
 +JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782835618; x=1783440418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q3J9TtQFCSU1vfSxa4LwwUwmdkEJsTuVieZNgOFQGDQ=;
 b=UFJPglBqXkJ0JjVVb4pKb4iw6JVKILjp7ehdgj+gqksIuR6ebwVpcFXFiUlaOBmfNR
 8AX7Q55H0z/cPE9Xo+158HqW97e3qJea1/mtKbDr3gqxVefB4jHFTUKfdvldMMF5Kmmd
 r8iK0987VnnRLcDeNlwyRmXB2YdsyCP3o3wcXVjnI/EPsJVTLJTGi+jcYk/ydPTQCe5C
 T6rJRWXftXwuX7O7cs05OTl40TOyM68z7E8lEZJiuj10+muPbVNQQXpAroXId4faLaZt
 NixdHCI/Eei+MC9pBOyRJ/ODLKAPxHCyvR0QZatUz1EvLzqJg1mlyK7B0Rb1bcSyIR/p
 9Ffg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpflVj1cqg/BQw4R9xBOv4NVyQEttl5CoeyDWowwHoQWymaUMXW6naWiI/c6IVXRUEs5kEbXZ5kuasY@nongnu.org
X-Gm-Message-State: AOJu0Yy/oJo/J8x4Z8h7J37bzwbyT2tfaqJMeg7rv55hegmpfxbkQBup
 5Vr6+PhU21poet3iAbOQr7E+6cLwpbh3x6IWnLhfqPy21MSx8x6uUPqTz7vHiVclGDncOmsyM6C
 rVTAvHmJE6P/XeLCRgWbpWj4rG5BSffFh4HKn
X-Gm-Gg: AfdE7cllzVMMtEWgSMS7hOOjRc8stX0RGVWu3aE53dV81+Syi1S4m4D3WFh0xftCTXt
 Lsu0K0CNGNVfcSBAorCf5ONwMCAgfUd/t5hoHxDdrvQc3KSp6pVtvaVBkhzytVB/fzW3Ijyza7J
 DSRzITJvKhhIF8sdIAHWKRBcruUO9BK8JnKp9yhAU1bPOaPLkkAEKvi2//+OGI5q37d1zjIpCCH
 qOPDL3BpniS34X6ddiK4oDWUIrx7fob9Ute0/PnySaC0ZjPzYSIyLta3cbh1OM17sxfXi2KTahD
 9RwZnN8sD7QbXJAQfcoxe3nLW7mVekwJ+l7qexZxTlKrz4lX+7aAVKKbzg==
X-Received: by 2002:a05:6402:5299:b0:698:3469:fa99 with SMTP id
 4fb4d7f45d1cf-69887529d4bmr826500a12.0.1782835617560; Tue, 30 Jun 2026
 09:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260316210600.62415-1-serapheimd@gmail.com>
 <CAJSP0QX3JtwhXDTnEgS-heLYYncjJtttg1KmFqG-+_VUXbH+Ww@mail.gmail.com>
 <20260320172345.4688-1-serapheimd@gmail.com>
 <1747673b.8c8c.19efe3cc66f.Coremail.15927021679@163.com>
In-Reply-To: <1747673b.8c8c.19efe3cc66f.Coremail.15927021679@163.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 30 Jun 2026 18:06:44 +0200
X-Gm-Features: AVVi8CcU2rkjIWvBTGnZeRcwBcQ9AVWx6hqw8VN-xRK2nUTdUg9CpCBuEo5jVmI
Message-ID: <CAJSP0QXG9U7ovrux+JkfBgUsLVK_YBzb7CcLt_YrTw3Nez9=dg@mail.gmail.com>
Subject: Re: Re: [RFC DISCUSSION] virtio-rdma: RDMA device emulation for QEMU
To: Xiong Weimin <15927021679@163.com>
Cc: Serapheim Dimitropoulos <serapheimd@gmail.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org, 
 mst@redhat.com, pbonzini@redhat.com, sgarzarella@redhat.com, 
 Xie <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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

On Thu, Jun 25, 2026 at 12:08=E2=80=AFPM Xiong Weimin <15927021679@163.com>=
 wrote:
> Hi Serapheim, Stefan, and all,

Hi,
I don't have time to participate in this discussion, review code, etc.
Please go ahead without my input and discuss it further with the
VIRTIO community.

Thanks,
Stefan

