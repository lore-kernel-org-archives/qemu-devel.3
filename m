Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C409310854DB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nEv-0006ee-Oe; Wed, 18 Mar 2026 05:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w2nEp-0006df-0t
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w2nEl-00022k-Gc
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773826246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9qGRQWMTn75qUw7IVoZ2yAaT15wnaio8egs6pf0ArEM=;
 b=Tb7v6nF0X/TTKw+iD2qqrwNwk2LZRho5UKtHwzwnLc2OieNCaIimJo0MOxpnCkAxeUtlnt
 V4ItrpZvrBWUWRFfgaOyAJ8oYQ9Q6NPm0kPKAlIOgpY9bWPLzTDb6Qo271h7qbjvYRgaRj
 5SGTq37L4FCXcxIUHLOmT11iXWwNB/U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-LUIpjpnoNbm-_D8dAxfCcw-1; Wed, 18 Mar 2026 05:30:44 -0400
X-MC-Unique: LUIpjpnoNbm-_D8dAxfCcw-1
X-Mimecast-MFC-AGG-ID: LUIpjpnoNbm-_D8dAxfCcw_1773826244
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aec07e8aafso44273625ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773826243; x=1774431043; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qGRQWMTn75qUw7IVoZ2yAaT15wnaio8egs6pf0ArEM=;
 b=sNNrYiB9J1d8LL2oItgAFxkNIG24VAXjZ281hkeIJyK1CyEMW6T4ENL4Q1waRL6KFK
 XxJNp0AelTvi+XAiYcwOi4MYqY/8gUOpHBxqAzTKuMleN/Ry/Ak5agGdTVRe1hcnbprr
 rXfeWo7SaTgJNSbTzPrB+6pxYM1uPmpdPF3JHcrI8LXeroj+lR4XWoswG/nPMizi5kZJ
 cvuvTbtq7QacSAx7DwX67dhSFXzdJ7Rc0ys4opz35Fs05Q3GFXLE2dWz3w4hpiqdktNP
 jFelRmJQFTwb2iAlkkYSzAoCI14YMgJBYcRNkr4CQCy9JWzyCQFmPzFHAg7s9EOnmGsq
 Pkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773826243; x=1774431043;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9qGRQWMTn75qUw7IVoZ2yAaT15wnaio8egs6pf0ArEM=;
 b=DDaCOiwbVuj0fiJb+ZwnyKDOtgxhYuNLFl6KDebYOk3JfDQGaq1xR1BkCwJbw7AbcI
 Y/QFtmWVk+a+qG3gOZ29sU6wVMvqTeo4GP409R9aXCEURygTr2KgGC63Y7OtHlw7x01X
 OOdw3tNJfsa1VfnFcGkDXcPw2LKaNniMCwVCGELptD7UPJ6eM4+8D1xFBxkhZhcP3xUv
 IdhS+W8LhMifGpN8I0OCSJTCvIC/weo2NwQ/GV7wty8XaOguUOJKu66UxptBhP6BGPcE
 g5ZIGKFdzM7sG1vzEzSjTRXfW/E6DEFwvJXqSsKu0QS5nzCKoxC7U5jtJQrygmpKkuC+
 wTog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbwgn0nrzrq/+LITiw4Lb7itEqzuy4ES9QFhdEgplVuuJ5WKB9WTm+Mt2z4482DEEt+qXpXtGxTpQb@nongnu.org
X-Gm-Message-State: AOJu0Yyy8AHU5WlYFcagAWJzboLwoiQBqKdURXqy8c5ApAS95GCYVgkw
 21fGT4gFrtDrA3S0DT6eY3FiuRk260G87mwuWVY/nH79DZyGNsrw1P/YMKppGx7hvJT8gBjhAeU
 FrzhiNayvdK7dVY1o3Z+jIRAL1725CHUpMQWIvvrlMuA2YsfqdVtOALfbfd9NcCHp
X-Gm-Gg: ATEYQzxAoZv3FaQUaKRTwUUr4FI+5eRymSbwc/fxHxKeXz+N0lmtxm/UA8Myp24V70t
 0cqlFjQzEteshKb34T/x4WqhHIUiMo7t7tBX5LnwYUQW70Xrzt3DgxqdlOSGRixq+1cE7vbcOu0
 J1aHX/1ZI70J8FhQOEQTeK0Gy0A487X/QVRWXLxSCATpqezEw8Jwd9juK2Z/xEERhHAkc7mRyVI
 B2KZgd6GhP7H9OatennhO3EQdlx59560CkTyzFKnSZ1mnA35pigOwxwgxNKMAwRm/I/mC6trdwu
 izQXKDLG4u3SW2+YDy52J+JQl/w27/Ydi3BrVYZ7d3c8SezXc6akooJjv7CPylkJNaGB8JV/VKg
 XPppZS8Hj+mHrr0/WMkgV4wUzt7tZ2rwhHFCBTwrzmzwE9byMtVoovyOPPnggqnO4/AJVfg==
X-Received: by 2002:a17:903:1666:b0:2ae:7f9b:3148 with SMTP id
 d9443c01a7336-2b06e33a0demr25800785ad.14.1773826243523; 
 Wed, 18 Mar 2026 02:30:43 -0700 (PDT)
X-Received: by 2002:a17:903:1666:b0:2ae:7f9b:3148 with SMTP id
 d9443c01a7336-2b06e33a0demr25800515ad.14.1773826243012; 
 Wed, 18 Mar 2026 02:30:43 -0700 (PDT)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e629da3sm20527235ad.76.2026.03.18.02.30.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Mar 2026 02:30:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <9794AFF9-DFD9-48D0-B4EA-7745ABDED6F7@redhat.com>
Date: Wed, 18 Mar 2026 15:00:27 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu Ppc <qemu-ppc@nongnu.org>, npiggin@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DCB3A7E9-412C-402D-A4C9-EA558CD1FE29@redhat.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
 <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
 <e966c053-2e69-b185-532e-fcb4173b4daf@redhat.com>
 <b088f554af34cbcc4d88271e227074e1@linux.ibm.com>
 <ED4A083D-2B96-468A-BE77-211E9F3FA88D@redhat.com>
 <7bbeb3cb105934e95bf1a5356cfc4613@linux.ibm.com>
 <7ACBCD63-B759-47FD-824F-0327726E47F6@redhat.com>
 <35f6361f69ef4f09f80bd915f3460a28@linux.ibm.com>
 <B2B682DB-1467-4C42-AF74-346BC61DE31B@redhat.com>
 <526d7172f3933baf913bf4b105a6fa9a@linux.ibm.com>
 <9794AFF9-DFD9-48D0-B4EA-7745ABDED6F7@redhat.com>
To: Misbah Anjum N <misanjum@linux.ibm.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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



> On 18 Mar 2026, at 2:09=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 18 Mar 2026, at 1:49=E2=80=AFPM, Misbah Anjum N =
<misanjum@linux.ibm.com> wrote:
>>=20
>> Hi Ani and Paolo,
>>=20
>> Following up on the KVM guest boot issue due to commit 98884e0c, I =
have conducted additional testing that reveals important new information =
about the nature of this issue.
>>=20
>> The hang is specifically triggered when SMP is configured, that is, =
when -smp parameter is provided in the QEMU command. This is also =
validated via KVM Unit Tests involving SMP which are failing due to the =
same commit.
>=20
> So basically what we know is:
> - Issue seems to show on ppc64.
> - tree with df8df3cb6b at tip does not show issue.
> - tree with next commit 98884e0cc1 at tip shows the issue.
> - kvm_reset_vmfd() introduced by 98884e0cc1 is not called.=20
>=20
> You think any one these commits are the cause of the issue (which I =
personally cannot agree with):
>=20
> 98884e0cc1 accel/kvm: add changes required to support KVM VM file =
descriptor change
> df8df3cb6b system/physmem: add helper to reattach existing memory =
after KVM VM fd change
> 4003e5e65f hw/accel: add a per-accelerator callback to change VM =
accelerator handle
> 2391125f13 accel/kvm: add confidential class member to indicate guest =
rebuild capability
> b3f0a55576 i386/kvm: avoid installing duplicate msr entries in =
msr_handlers
>=20
> None of the above commits does anything SMP related.

One possible thing to try is:

Revert everything in stubs/kvm.c and hence changes in stubs/meson.build, =
include/system/kvm.h and in target/i386/kvm/kvm.c introduced by =
98884e0cc1 .
You will have to comment out calls to kvm_arch_supports_vmfd_change() =
and kvm_arch_on_vmfd_change() in kvm_reset_vmfd(). Since =
kvm_reset_vmfd() is not called anyway, not should make no difference if =
those calls are commented out.

Let me know what you get after doing the above.



