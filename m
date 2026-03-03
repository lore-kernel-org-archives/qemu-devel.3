Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF157EC1454
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQMc-0002ig-FP; Tue, 03 Mar 2026 09:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vxQMR-0002i5-UB
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:04:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vxQMP-0007Sj-Mm
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772546668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tcu2PNK+Lk0rVjY7kfUG4eDcoEc6YZs0BkB8WpsrkMA=;
 b=AG9fiK/pyTs2JQJ6t7/mojExnnYafuFMEXd5OqP69iiOWSfoPcBNdBy5K4ccwEgDCIisp5
 QlX3lrmUqQ7pOKmpj0xPq6U87uszUI58RCOW7TAVvPIgywF9PwVH+EDvt9CpJAdGwhlxP7
 +I6aP//EFPNjf46gTxTwf2EniR2W32w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-YbCFadEkP32Op8DzvLajGw-1; Tue, 03 Mar 2026 09:04:27 -0500
X-MC-Unique: YbCFadEkP32Op8DzvLajGw-1
X-Mimecast-MFC-AGG-ID: YbCFadEkP32Op8DzvLajGw_1772546666
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so55323835e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 06:04:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772546666; cv=none;
 d=google.com; s=arc-20240605;
 b=aGCqcks0HYQ7EFOqf8nXkkBZuGxlksBViubbckzY02tnPuD+sFfejCnir5gjE5g5nH
 4iTcZbZLsBEZ+K45/kgEQEu7rGHluRmvwE9pRRx1LSWR3PcRWkCULhj7CnRs89oZ6ED0
 3DN4hCJb53iFG0gxMC4rR8rRXdYt+EgnoJR3PRZDHkjHDWphXmY44xxhDi4MkEizGZri
 J7XVmKn0zZYjpWC0Ivyt4wy30dC+Gq/Y29TN55BPYTBjs3dbt6wReHhwxL/nBHz+DiF+
 01cfsAuWBbwlesYRfk7ts/sSMlCdArEK6a7H1h5xLYRw6kY15021MsAi4mIuWG/XDrxB
 Bv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tcu2PNK+Lk0rVjY7kfUG4eDcoEc6YZs0BkB8WpsrkMA=;
 fh=C3e0+sZuoRkzqPJo5N9PiN2hoTQOKo88PWg0Mvv5bT0=;
 b=ZcQYpq9KaTacx3E4ySF//3Aj4i/oNDpiI1VJqexIyjqILj651sqNhBKDZjq3fDRPE9
 FQYBybuDv5QxqrsSfvlS2XZriyBfhRLgeENvB1fZ64DRwBwM9GCJbZN78Z5Bn7+pPm8b
 OUiZ2D+fVNlF9jVtl60gvrr6yhluBSLhSRWXR8XXxYveEGLECbjEP0dyY/x8aCcK1XTn
 12jT0EJBwb5K8ntQ99kcWlL067BbpcK7w0oAqWTwgZ3KUQ+gn/vYHma4UoeCe2fG6bvR
 YfFEX8HTpNqqNbXaNpKuc8kgtgLUtK817QwbTgIP5lhinJHOpS103EW1pjtp6wrCpvwb
 OoAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772546666; x=1773151466; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcu2PNK+Lk0rVjY7kfUG4eDcoEc6YZs0BkB8WpsrkMA=;
 b=NP1qzgIdS3C0defp8GG9f8tyh2zaBdt/bjZ09ot5uNOpURvVvfTF5hgAHv9sIeilnz
 C10laX7v4bu0nAcHGK8LHVR/cb/wSBYaJa2OMnWBoFVfBgsRqaFb+unko5dZZWDjxK23
 bW1a4VwlZN9zSRO4kYmjyMN7hLWryD9zPlSq++2WVixWQxQltjcp7f9QUFnsL4F1oh0G
 B1ulkXakirjsJ6DJ8ZQWbSW3JMihSSdYix/8qfequ//om8wCIH2hjn0aPSuwL9C7zva2
 1ezkaFdN0LLPILtWxpHk3yPdzBP6m1AzGfbJUAasFgMoiB/CQSLGE50AkZQ+Zl+p3doH
 NryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772546666; x=1773151466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tcu2PNK+Lk0rVjY7kfUG4eDcoEc6YZs0BkB8WpsrkMA=;
 b=d0wReRGR3uVwbGSPsQtp98ZO0FGNCMejJ6tsmU1SPLHxpk3X5hLE1K1GUZ3s8Y/lTD
 IR4vMejX9y67AvE6F2v8HsGIzZkKG+tCo3g6DJ5hwPVDlDsmQNN1HrKcipGXHOoieZUm
 klhII6LAh8BkBXGaWytSZwHY3QsezZHcvGaJZEJvOTzKZGJX5hKbdnHj5k0L+KGKrSrT
 8h5Q3c6M/fLmFxWKVrnl4wB7HsEyLL9eaZCuGIdBsKDNOFbUgy6DLYy8cr7AwQEMAwiC
 vOgmUIdww/sQXAWSDwr+fqk9nRBMoGxYO+b0RZDaKvR6wtvhxlwD1X1ops2cxFa/Mmd5
 rXdg==
X-Gm-Message-State: AOJu0YwisTs0LWE2+Alrjf4jqNpdJHOK79S+J+KqlsiUnPmrvny4QHSi
 d3vETzdYupvOqZexKoUv+at1YgK+WdyiXM3oJfazo0RWKYdnwXT2U/UpbhmS1NWqyLQqwN+hUQp
 r8t98QR04yWslrBIPhYNxZjW/QYpv/iQcEswJIWbt3sDQfsCSSpBDiBF/WAOrTbWLxiArau1RzZ
 ovScATHQfwi0zZ5F9Xii7i7AOhw3tPMvo=
X-Gm-Gg: ATEYQzw01kPi5wDAsO6kvjm5sdI6SAmFXmzyz8M+GjKZjBsqV+YN+Je9/aLGGHvkQC9
 lwrqqPsJKTsyWa6ATC0wWOGWBjSP0piFxGUdC5A0IBHUupB7aJtAjrqDwY/iYwLV50uQLVZQv7U
 eQLkz7rr5z2c5v1pKMr3R5Ax8QMeo1inWVPBEDVcwwZPRugJiEvHenlmzucuXSfsMUnTxSDMmZa
 7Ok0uJs8MGClN88LkPEJtfYclYvK7i+h8TwWgrra6IQ80mM9Ocw5smWMHb2kHGHxYIQwOhaZeB8
 O30SZuQ=
X-Received: by 2002:a05:600c:630d:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-483c9bedb42mr233631445e9.20.1772546666035; 
 Tue, 03 Mar 2026 06:04:26 -0800 (PST)
X-Received: by 2002:a05:600c:630d:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-483c9bedb42mr233630775e9.20.1772546665497; Tue, 03 Mar 2026
 06:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <aa442c69-5dd5-4a3a-b42a-299a30aab881@redhat.com>
 <aabik4j+PseewLz3@example.com>
In-Reply-To: <aabik4j+PseewLz3@example.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 3 Mar 2026 15:04:14 +0100
X-Gm-Features: AaiRm50WUnULfFG3zK45xW8mCYHgFTB48IrWas4wE58Migc6h24XI2Cr55nsnpc
Message-ID: <CABgObfbvpcAL9a6c1vKtGRdSyjqXOV13M6zyoH=--fbAA1nLAA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Support QEMU cpu models in MSHV accelerator
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>, 
 Magnus Kulke <magnuskulke@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 3, 2026 at 2:31=E2=80=AFPM Magnus Kulke
<magnuskulke@linux.microsoft.com> wrote:
>
> On Mon, Mar 02, 2026 at 07:34:21PM +0100, Paolo Bonzini wrote:
> > Hi Magnus,
> >
> > I went back to reviewing this series.
> >
> > More or less, using "-cpu host" should work because MSHV already runs i=
n a
> > partition.  Therefore, it should be safe to assume that whatever bits w=
ere
> > allowed in the current partition's CPUID will also be allowed in the ne=
sted
> > guest.
> >
> > However, you still need to mask the features corresponding to MSRs that=
 you
> > do not save/restore; this includes for example TSC deadline timer, AMX
> > (XFD), FRED, PMU, UMWAIT are the first few that came to mind.  Or
> > alternatively, just add them to get/put_msrs.
> >
>
> Hey Paolo,
>
> thanks for taking a look at this. I am currently staging follow up
> patch-sets in which the MSR handling is reworked as part of the live
> migration support.

Ok, let's start from there so that we don't have to think about
filtering out features because they're not migrated.

Thanks for the extra information, I'll study the rust-vmm docs.

> in the future I think we want to have a MSHV_GET_SUPPORTED_MSRS ioctl
> that we can query, similar to what's available for KVM.

That may not be needed if we can rely on the parent partition's CPUID
(I changed my mind and I think we can, because QEMU already filters
out CPUID features it doesn't know about).

We may want to share the knowledge of MSRs between KVM and MSHV, but
that's a different story.

Paolo

> There are "hv_partition_processor_features" that we query from the
> hypervisor to filter out MSRs that are not available for a given
> partition, e.g.
>
>                 uint64_t tsc_adjust_support:1;
>
> > Later on, we probably want to share some of the code to handle MSRs bet=
ween
> > Hyper-V and KVM.  Please add some comments about the hypercalls, since =
they
> > are poorly documented, explaining how to find out which MSRs are suppor=
ted
> > by the hypervisor.
> >
>
> If the hypercalls are not documented, we probably want to fix it either
> in the rust-vmm/mshv create (which at the moment provides authorative
> headers (until we have moved everything to the mshv uapi headers), but
> i'll double check.
>
> > With respect to live migration, here are a few bits of states that shou=
ld be
> > migrated:
> >
> > - the FPU registers (MshvFPU is dead code and can be removed; I missed =
it
> > during my initial review).
>
> yup, the FPU registers handling has also been reworked a bit to
> accomodate XSAVE migration.
>
> >
> > - the PDPTRs.  That is probably okay (because you never set nor read
> > env->pdptrs_valid) but please check if Hyper-V supports reading them.
> >
>
> I'll try to find that out. Haven't stumbled over this so far, but I
> understand it's relevant for 32bit PAE guest, which we probably haven't
> tested thoroughly yet.
>
> > - KVM also has support for migrating in the middle of an exception bein=
g
> > delivered (for example if an EPT violation happens due to a write to th=
e
> > stack); this is handled with fields such as these:
> >
> >         VMSTATE_UINT8(env.exception_pending, X86CPU),
> >         VMSTATE_UINT8(env.exception_injected, X86CPU),
> >         VMSTATE_UINT8(env.exception_has_payload, X86CPU),
> >         VMSTATE_UINT64(env.exception_payload, X86CPU),
> >         VMSTATE_INT32(env.exception_nr, X86CPU),
> >         VMSTATE_INT32(env.interrupt_injected, X86CPU),
> >         VMSTATE_UINT8(env.soft_interrupt, X86CPU),
> >         VMSTATE_UINT8(env.nmi_injected, X86CPU),
> >         VMSTATE_UINT8(env.nmi_pending, X86CPU),
> >
> > please check how Hyper-V handles this situation so that it can be
> > implemented in QEMU as well.
> >
>
> Those are covered in MSHV's "vCPU Events", I think they map quite
> cleanly to the QEMU representation:
>
> https://docs.rs/mshv-bindings/0.6.7/src/mshv_bindings/x86_64/regs.rs.html=
#404
>
> thanks,
>
> magnus
>


