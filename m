Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2264FD8FD3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 16:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vve1M-00038p-Mr; Thu, 26 Feb 2026 11:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vve1J-00031R-8u
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:15:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vve1H-0006DK-PN
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772122517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSKQ0n12PECkU++UusRsCy3aOIngD05ybGdgIjZou6Y=;
 b=d5RF/Wi5KscsvlXOZp8/vXXu+i4qT2hZ9HBC8LdmiNO/6j7C9qmG8T2+QC2KF/svGWPy93
 vSTjEs9xyv+aVJ/LVlyDxiYRRfcyzn6tPr0FddNq2zWVhZUASDAqKDfee7LEmscz7pnvlE
 03aj5qXSFXAO+cQOxsvWkhhUHUYlLoQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-u54G7x8ZO8a8EgkRYk7zng-1; Thu, 26 Feb 2026 11:15:16 -0500
X-MC-Unique: u54G7x8ZO8a8EgkRYk7zng-1
X-Mimecast-MFC-AGG-ID: u54G7x8ZO8a8EgkRYk7zng_1772122515
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ad7e454f38so55675085ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 08:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772122515; x=1772727315; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSKQ0n12PECkU++UusRsCy3aOIngD05ybGdgIjZou6Y=;
 b=C46Ga6lxlB6INedHmqqzwl4KhIO6j/fq3Eoa6Xqg7gEtvm7lroEv1vAU64CallcPkW
 s336sbSVyFSsui8RRkXQplwUSPs/AmnH21FT94tDyg14Wn727JLTJTFJXKE+x8w0Tv01
 m/a2FuqnmF75TnzKUtQwpJMi6OrtHyQ8Xn5ILz8hm11/EHPVtNYrvZgbZYfQNtKXN3rs
 r0e7GXtz4dCCsfdfwXZ8mffryqT2SpwYPYetnm3OogIoSiAhZcWrIZi4cX0VoFn1Yy8e
 IHd7QeCQT7LL3B3LWs+kSs+siULnJj9kxFDsSlDecKbrtI9g9gqO/GTK2apTl6urfMT3
 vrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772122515; x=1772727315;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vSKQ0n12PECkU++UusRsCy3aOIngD05ybGdgIjZou6Y=;
 b=LAZYgPf8+Er/O6i1R8tVSarDX11Q/lAv5RL6bN5GniZzDBLSnMG0gLHJzbsY2+R0Is
 wZyUhQIThgjNNFoO6c4Ac5oy5iCxD03/vWv0pClYFSh4ij9SZlj4q/gT03D8Py7a+6Ex
 /gmW57DdiHuYi2XhXC6CE8ThykIUxN+BWE8+B5wTpIOdBKvedStAxnTLcu3NLMSyYzky
 zX72sg+Z4kDna4BAFjBmFS4cQwAhV1mF4VVV1XE4o94pThgvj3E/UG2uEbWTviUU3wFI
 wpESR4vNYc+1w5pcLfgTEwDastAIB9OEB46KFG0JJnw4zkBYx5KjQ6bxfiQiNBvmfYoK
 u21Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdYRpG0UVXbR11S2qYK3OSmO6bP3CtwjEddRqatiwqG1pRhVMQO0LTsOZNMxXB8mY/Dm2Soirj9DZT@nongnu.org
X-Gm-Message-State: AOJu0Yxe+tfWrrlFEl1nFRAYqTfkBsyY/+8lLhyjTNOLtvn9OrHcO4fz
 cicPlK9wb60syLSQ4eKU0gvTJdPaMUBaQF29VVz+Bqe3PelS57aBHd9TxMhd66ulgsPBtst/WeE
 fVyPa26QsKI+O3DTdDukUECEmRoEu3vg4I6phXHd7dtnes6WLK57mydFuuurMWSwP
X-Gm-Gg: ATEYQzxu4eGaRvsOcmpECVUIKnLKE7Ii+aRt8fIf/X86fFMCX8wzSUxqhlgQzx/gxQU
 d5b+I/hDSC4N0TQ3s0vOmPDr0JMcGDTEWExT4U12bS1A9tsOOQxZL6c3mQQDEsS4nuYRI99Rguv
 nrtXqMKaVN7mG0RQH3PqfDQeDAjRmvD18sGeD7FonAuMSPg4tqsFveNpR2++xnDDrUAhJvyvCCS
 KFl0Gcvd4o1O0QNhbMzNX90evlQgf1AWrPnQns+ymLuQ0LX649HScktj+FQKJHkAEzm+3JJnrqQ
 KnMH4OdOR3r7huadRcJf0RvJ01u5Y5Ce0ZPp9FVFaXgZVOZJ8sa+1kFTwPpTShGYh5KypPiBePq
 lsB48392gGZWEeOEsxC0hPubZHCI2Xulj12Z0EblY3PP2t05nZmx7aHDe7OyLAQwY7Fscfg==
X-Received: by 2002:a17:902:e805:b0:2ad:9edf:7fe4 with SMTP id
 d9443c01a7336-2ade9a637f4mr41236835ad.48.1772122514521; 
 Thu, 26 Feb 2026 08:15:14 -0800 (PST)
X-Received: by 2002:a17:902:e805:b0:2ad:9edf:7fe4 with SMTP id
 d9443c01a7336-2ade9a637f4mr41236445ad.48.1772122513802; 
 Thu, 26 Feb 2026 08:15:13 -0800 (PST)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb5c183bsm30620715ad.24.2026.02.26.08.15.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Feb 2026 08:15:13 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <aaBFxY6PUsNrAYft@x1.local>
Date: Thu, 26 Feb 2026 21:44:58 +0530
Cc: Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <83E69A6D-EDC8-4380-8C4E-6F77D1E2F078@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com> <aZ8xlrL2xQtoN9MI@x1.local>
 <C486617D-2B20-4904-A87B-81CC5FA84153@redhat.com> <aaBFxY6PUsNrAYft@x1.local>
To: Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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



> On 26 Feb 2026, at 6:38=E2=80=AFPM, Peter Xu <peterx@redhat.com> =
wrote:
>=20
> On Thu, Feb 26, 2026 at 09:16:43AM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 25 Feb 2026, at 10:59=E2=80=AFPM, Peter Xu <peterx@redhat.com> =
wrote:
>>>=20
>>> Hi, Ani,
>>>=20
>>> On Wed, Feb 25, 2026 at 09:19:40AM +0530, Ani Sinha wrote:
>>>> Currently the code that adds a migration blocker does not check if =
the same
>>>> blocker already exists. Return an EEXIST error code if there is an =
attempt to
>>>> add the same migration blocker again. This way the same migration =
blocker will
>>>> not get added twice.
>>>=20
>>> Could you help explain why it will inject two identical errors in =
the first
>>> place, and why the caller cannot make sure it won't be injected =
twice?
>>=20
>> Likely due to a bug in the code. For example if the init function =
that
>> adds the blocker is called again and the caller does not handle the
>> second init call properly.  This came up as a part of the coco reset =
work
>> where migration blockers are added in init methods. They need not be
>> added again when init methods are again called during the reset
>> process. The caller can handle it of course but adding a check =
further
>> down the call stack makes things more robust.
>=20
> IMHO if we want to make it more robust, we shouldn't return an error
> because the caller may not always check for errors.
>=20
> Would assertion suites more here?  Because migration blockers are not
> something the user can manipulate, so it's a solid bug to fix when
> triggered.

If Prasad agrees, I will send something.

>=20
> Thanks,
>=20
> --=20
> Peter Xu



