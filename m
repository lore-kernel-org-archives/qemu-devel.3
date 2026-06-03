Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A9ACD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUlQr-0005nQ-Cl; Wed, 03 Jun 2026 09:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wUlQq-0005nG-3b
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 09:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wUlQo-0003Zv-8h
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 09:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780492488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMknx8dEM0W7g67LC23CC/whbgefz3p3mFJeXDPxmtA=;
 b=a4+BHRtDkpTRZqK5HFeknJpjTxp09EEdV7Rw0pTugStMfAc693zdC2qIReTZWLT6uKtIvy
 13mUsoec5Ra022DWIOtcjiuhebCCxefCU7tFu+agK0j6VN4HTVjGvOtvRFrHt4QgH5PkoT
 jtyKh2sf3VDojn9XXfqNa4L3UeP+ZlM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Ux9XItRkPxu-os7ZjBrgLA-1; Wed, 03 Jun 2026 09:14:47 -0400
X-MC-Unique: Ux9XItRkPxu-os7ZjBrgLA-1
X-Mimecast-MFC-AGG-ID: Ux9XItRkPxu-os7ZjBrgLA_1780492486
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ef6b407b4so2091113f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780492486; x=1781097286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMknx8dEM0W7g67LC23CC/whbgefz3p3mFJeXDPxmtA=;
 b=cU8I+H/+C6tZEj96VwnfEuj4LXKmaxGtrIx7JmBGA5nZnFSSkFwYRxrlKLI3l1WN4E
 HZNVYUA8vHNBD4fKP93C602pfk7HqCB7HWXmYl/E67nHKZeFseHDAuZoMzFrCqNJDtTo
 1ytFz04u8wJRwh6rFMAzrveATF7DCOmkr1ZR1DGWzK+gcgcyaPNaLFA0Tn4IYDbDcvSC
 tpHxb7N/jAopgaJT6eaJFxav9OP1DbPflrKBbD3lAZbpNQl3UJXHb6SIRqTgRLDxkzip
 CgZD47iJjJYV5GK0NxO8W/4OOVVage0OQM3ugB2G3iNLAkDR6mi1Q8STUw6AqtBjwxq7
 3+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780492486; x=1781097286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sMknx8dEM0W7g67LC23CC/whbgefz3p3mFJeXDPxmtA=;
 b=D9LDy+6sKqkZoU+c6Ztx7S+XFDBJ3phHRPeGZyxpoBunmR1Xj9deRq4vU5YbjF5/+L
 H76hB5Aue7utb0b1OaLqNw9QB4PpLKH46P0slN1bENXC73icqTST7sFLAGukL9W1GO8C
 qRZnZwdTHiyZ/dopjSO8SXw/y2EZbLKCwGFB9ItWeKNUEFnJX7dNwhyihkysgGy9yw7O
 4w91hnJrruq6UfrFxoqVajJr8XnwfJ8vyeXVBI0z5CZWyEvgMoYQ25kG9Q9Ieu6n7mMA
 MVx8GsKPluq5gkG5ol26nWYyjPu6EOVMvZBPh0VBfb7D6JfWs788+UNRFS8zmhPW5tFy
 uH6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+479/ZzCenIlCTnPjn59aHXVj4y503HaGFwLOVdKg9Hp5SA119DHWXIjI5n47WeFbH75gxBfds+waS@nongnu.org
X-Gm-Message-State: AOJu0YwX448K7F93GPGEFplCKTRYd3XUzA5hL+AXNAJuxtfbtFdKhSZf
 x2GJor4xSHOntNYPYilGhQSiK7WFRKkc0rv1P1bJs0h4HqdHYv50NOFx3G2FivZsyLWOtvkSgEk
 5knu83rlfYmns423c5JVg+f6H4LVWaNh1UKMwoJGEMM+1vyxRZfeP3bMR
X-Gm-Gg: Acq92OHvx+xXlHIHRTrH7mPDe544bXE6K913btK+MZ8qV+A5Lkk5KwPrGNsesn1q334
 p+7w1gIDcNouxRjTg34GozxFbPbgZiR/QOYoaqGHr6Uwz14ptMdfF4fIBE7EaDhjRp0Lc779Jga
 uZ5DuSzFR3Y+j+yDsjWb3YNe3Yu+DLmd2EUWKmXjnJTN+pnRONRpvu2UYRRAFlAc2C7SdlvGhAg
 31k4nN2r4vwDcw/CSXh/qXD8oJDU+khHqD7uQgf1TxXWPytrGmkhNymuKfLB3rNyRLjSfufU83O
 0NcTxfzzuCovYyscNSBNJW77Mg+2OzX/3yreOO6Wt1Koo8O2Jbyk6+e/oKLtdG0TKHE+esx8e3p
 80L7dAgr1sBeuLzmU
X-Received: by 2002:a5d:5609:0:b0:45e:ea9b:edf6 with SMTP id
 ffacd0b85a97d-4602188500amr4158944f8f.36.1780492486001; 
 Wed, 03 Jun 2026 06:14:46 -0700 (PDT)
X-Received: by 2002:a5d:5609:0:b0:45e:ea9b:edf6 with SMTP id
 ffacd0b85a97d-4602188500amr4158909f8f.36.1780492485655; 
 Wed, 03 Jun 2026 06:14:45 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcad5sm8005896f8f.5.2026.06.03.06.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 06:14:45 -0700 (PDT)
Date: Wed, 3 Jun 2026 15:14:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, "Huang, FangSheng (Jerry)"
 <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org, gourry@gourry.net,
 Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH v9 0/4] hw/mem: add spm-memory device for Specific
 Purpose Memory
Message-ID: <20260603151443.612d0e61@imammedo>
In-Reply-To: <c9707c49-59ee-458c-8469-12943bab90c2@mailo.com>
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
 <39411489-1473-44ad-ad56-392aa27990ab@kernel.org>
 <5ff45049-d96e-428c-915d-fc14cbcb5e58@amd.com>
 <d4297ad2-4695-4634-a12e-80d65a34e79f@kernel.org>
 <c9707c49-59ee-458c-8469-12943bab90c2@mailo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 3 Jun 2026 09:45:28 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com> wrote:

> On 2/6/26 14:21, David Hildenbrand (Arm) wrote:
> > On 6/2/26 12:02, Huang, FangSheng (Jerry) wrote: =20
> >>
> >>
> >> On 6/2/2026 5:36 PM, David Hildenbrand wrote: =20
> >>> On 6/2/26 10:44, fanhuang wrote: =20
> >>>> This series adds a TYPE_MEMORY_DEVICE subclass `spm-memory` =20
> >>>
> >>> Very nitty: but spm already includes "memory". And I think most thing=
s on the
> >>> cmdline use "mem" as abbreviation.
> >>>
> >>> "sp-mem" ? or simply "spm" ? Thoughts?
> >>> =20
> >> Good point =E2=80=94 the duplication didn't quite register when I name=
d it.
> >> I lean toward simply `spm`: matches the `dimm` / `nvdimm` acronym-only
> >> pattern. =20
> >=20
> > Best to wait for more feedback :) =20
>=20
> +1 for 'spm'

I like spm as well, but it's a very short acronym  and /me/ uselessly
worrying about ambiguity and future name conflicts.

perhaps: sp-mem would be better in that regards.


>=20
>=20
>=20


