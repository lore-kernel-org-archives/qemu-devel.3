Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41204CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 13:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSEmQ-0001z2-Vd; Wed, 27 May 2026 09:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSEmN-0001x7-In
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:58:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSEmL-00039T-Lw
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:58:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4904fd4f6aeso40588105e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779890315; x=1780495115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESmKA3kOKqumm8rD2uVv3cCuEluI4N3872qHYDYZCnw=;
 b=HIHcfl2Dh5Z+3Wn6CpWgm17Gx+7luykYYcej9sH7yQ9ib0NvyQ9UwzeG+KHsB/ZQD1
 A0kKn03Kl5rdzcc5jTTSuyZhECBoBKy+tfsKrCowJ7IpWrB8p51KJoIaJyq870AF96Yf
 OLSqeI4ozPNiM9ICWLTfgSyUjm/KPP1hRbT8PA+CK38nFxHuqGn+koOHGCtg6sveuiRV
 TtaP+1bP3Rz6hIB8KFZs2wb/xoomkrz1PJod0kN+qDrFuZulZaidaSS5i9oGc2BFAuK+
 UAsKjMAoPTJOiryMhExDvv4qooDTEyRY/lYwkmqBv+JHwCi+7611NMO7OrBcA0i29ArU
 lbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779890315; x=1780495115;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ESmKA3kOKqumm8rD2uVv3cCuEluI4N3872qHYDYZCnw=;
 b=EBcFxx862NmCBDk/fKw69SbpFdfeN9FAzBS4uRpBtyQC98QiL4J0EU+h8S73ByqOuF
 tQ3+m7luFNgKayxZo40H2fb03TjqU70XScmD8De4rBYyq9VOjf8mjg6VQkMEaV1SPL3J
 gVvz8uck1vJpitU19hL51Az0f36uM1Wr5yuWTdQeLkUQ7/dO4wzKnxgdPNbcMGu3SjYV
 vj7EuQBFAOuf45IHNPwtJ/o/TJI1TxU+OC9btsC6+VmbJGt31eEeC0jiU4QPWdFfIgtF
 2JKv2dt8Eq23VDpfpw5t5knAb4tRPDYUuk+DLRXk1es5ybmwYth7mgu0xjJivgywjmJo
 oR4w==
X-Gm-Message-State: AOJu0YzgD/5UzvIu1SWGK2sctUBlWz8yDJajt8tyahp5Zv3c7qvew0ZF
 pWDtwOxHq1+6bRvcSbfFYiziNQ9UzuLkjl2/7s7Vuu1XSpLFswK176Qt1otQwa1Mq2s=
X-Gm-Gg: Acq92OEmGGlFRsc2cucXeB5s3pT05HCjN8p7CNzu7RT8OMiu1kJQutdcgj3zISI/cxb
 d41XPvFUE0se/XZSYdDCyv7j3zpQUumGvyF/G1e0ehDfgMo8GSAp+ukDKXA2SmKSJomUnbTOU4k
 9EUdGBC8X2Cicuwu59DHKPx5G9PnkGsO1qUXJZnOUM3J4DnmSC1GaQokIrqaQm5s/koqJKnbsr5
 Bhk4dDh/tIeBBZbMNz2Oy9kdMASwZTB/dLH8iPbAphypyNQC1UgTUBymJ0djVu5+mVtXZJPCmXM
 PTHJ99oQ7g0SuijeFWmbB96O172A8GYROo+fSjXV9i/UUVoTMCTn5oZxZxo/5KbOYtKRImUMUHo
 /A6xZ/8brIKKQZ7JitiXrR9eMQujd1DJY22QN4h16XKwDKe9g85ErQ/wUQN8k1LMoBFB8hSnVUL
 a7WnEDk2KQ4CJaviHMPcRr7SQ=
X-Received: by 2002:a05:600c:6995:b0:490:482c:4384 with SMTP id
 5b1f17b1804b1-490482c44ddmr385371215e9.24.1779890314771; 
 Wed, 27 May 2026 06:58:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5c27e7sm6262462f8f.35.2026.05.27.06.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 06:58:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 11F1F5F7F0;
 Wed, 27 May 2026 14:58:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org,  rust-vmm@lists.opendev.org,  Stefano
 Garzarella <sgarzare@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Demi Marie Obenour
 <demi@invisiblethingslab.com>,  Alyssa Ross <hi@alyssa.is>,  Albert Esteve
 <aesteve@redhat.com>,  Mark Burton <MBURTON@qti.qualcomm.com>,  Matti
 Moell <matti@qti.qualcomm.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,  Dorinda Bassey
 <dbassey@redhat.com>,  Sergio Lopez <slp@redhat.com>,  Vishwanath
 Seshagiri <vishs@meta.com>,  Rob Bradford <rbradford@meta.com>,  Zhengyu
 Zhao <zhaozhengyu@bytedance.com>,  "Jorge E. Moreira"
 <jemoreira@google.com>
Subject: Re: Where should the vhost-user specification live?
In-Reply-To: <20260527085058-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Wed, 27 May 2026 08:55:14 -0400")
References: <874ijtz038.fsf@draig.linaro.org>
 <20260527085058-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Wed, 27 May 2026 14:58:33 +0100
Message-ID: <87zf1lvtrq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, May 27, 2026 at 10:13:47AM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Hi,
>>=20
>> Apologies for the wide cross-posting but I wanted to find as many
>> interested parties as possible.
>>=20
>> The vhost-user specification currently lives in the main qemu
>> repository (docs/interop/vhost-user.rst) mainly due to historical
>> reasons. QEMU was one of the first VMMs to implement vhost-user and the
>> spec needed to live somewhere.
>>=20
>> However there are now vhost-user implementations for QEMU, rust-vmm,
>> cloud hypervisor and I think CrosVM. We get queries about changing or
>> updating the spec on qemu-devel from time to time and I feel that given
>> it is an interoperability specification we should think about hosting
>> it and its discussions elsewhere.
>>=20
>> I think broadly there are 4 options:
>>=20
>>   *  Move into the OASIS VirtIO group as an appendix/addendum to the main
>>      VirtIO spec.
>>=20
>>      This probably brings the widest visibility to changes to those that
>>      might be affected. However it does come with a certain amount of
>>      bureaucracy with the OASIS process where only members can vote on
>>      changes. While intimately tied to VirtIO it's concerns are more
>>      focused on practical implementation details of the IPC between VMMs
>>      and device backends.
>>=20
>>   * Move to a separate project under the qemu-project space.
>>=20
>>     QEMU hosts a number of sub-projects and mirrors so it would be easy
>>     enough to split the spec into its own repo. Changes to the
>>     specification could then be divorced from QEMU's release cycle and
>>     at the maintainers option issues and merging strategies could be
>>     configured for just the specification.
>>=20
>>   * Create a new project just for vhost-user
>>=20
>>     The interested parties could decide where to host (github, gitlab,
>>     forgejo, whatever..) and decide to move away from mailing lists
>>     altogether or create a mailing list but manage changes via the forge
>>     interface.
>>=20
>>   * Status quo
>>=20
>>     Just keep the spec where it is and muddle through as before. Maybe
>>     we could improve the contribution documentation for how and when
>>     changes are discussed.
>>=20
>> Any thoughts?
>>=20
>> --=20
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>
> I think what is missing here is what are the pros for any of the
> proposed changed?  What are the issues we are trying to solve?
> What 'queries about changing or updating the spec' were problematic?

I was referring to:

  https://lore.kernel.org/qemu-devel/20260522-vhost-user-dev-v1-1-b31646cf1=
9b8@gmail.com

when Demi proposed discussing at the QEMU/KVM community call meeting and
it occurred to me changes to vhost-user affect more than QEMU these days.

>
> Thanks,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

