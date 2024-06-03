Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369FCC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8jH-0000nB-8G; Mon, 03 Jun 2024 10:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE8jF-0000md-7Z
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE8jC-00053E-MU
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717425120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMnGCaUCOJM5udsLF47byKKqJDKb1E5kZ3laZqy4Wr8=;
 b=b35BPGj1ivaM/xtQPuSHTS2vlwcQtP2jRMfHIWN1UJ0+6XJ17spW+wVUvh9Rd5C72ajYmQ
 8HlJVSXkojBwJugNZpplwvcUfFJ7X3FXvelyB7c2omDrhPDk7gU+0Ti5A7VDpvkdOX0zgG
 Nt8D47QUMsLS2nVE8+q52X+P4Jonfuc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-dVS2bzBaOtWZvKggeU6fjg-1; Mon, 03 Jun 2024 10:31:58 -0400
X-MC-Unique: dVS2bzBaOtWZvKggeU6fjg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4212b505781so19592025e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717425117; x=1718029917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMnGCaUCOJM5udsLF47byKKqJDKb1E5kZ3laZqy4Wr8=;
 b=LNR7V09NKWsIbNHsyK94bAxjXwenWBKjq8TW3kthS8zDGvGW0DxhV4mNSkc3dFU2uM
 sNBI3pDdr8qn90t5D/AFhmt2zP3S2GIo61oPTAew8RFv7b8+OtFuT7JxV9B5+xtbkIIK
 WN9ZiM87lV66pb5o/ncHRUCMt4XasdJMoRBSrWiBwNR3HByM00RwbFmBfEJGXkB6vK1U
 U1oMH6xw4pBcsouFfirj+Tqi5VYFqDkoTRLPZlW9gYevuv9AvdDJw/GN0wUL067NXsYO
 kYISSNVgmplgpUDARFSZoi0I1BOvOk5VCY64QziLxM2R4AJDBRsDlg1F0jz6futwtVOC
 1rjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ7Jl10W7lEIHDwn0JZMW8dTHXmZfGQTEvBYw6rETzYUg2NyLDMhe+6zoo1c2CAI3rL11QoYwZjMz8BnhdfcOUStQZzmc=
X-Gm-Message-State: AOJu0YxzPjPSqQe6OE+gTZ0EsjKJBVPXz/gT4E3/izg5Vl8njI+o/ihm
 rheuUqdpiV0MMcR/X9xoT29TzCXSsr7xVEgVHCIgKmZz3bdz9EWyFdJr+ASztSxgjzd1Msc9xKC
 8N2zq/gnQzX5XNuyzcvOy0CtEis+Bu2iguetg+2U/mWfQuojLOvLCTreQSmRd812o6NTafBrO5Z
 Cqg0Cw6cCnJgv+7JrLh3TVtAY832k=
X-Received: by 2002:a05:600c:3b03:b0:421:37fa:e4c8 with SMTP id
 5b1f17b1804b1-42137fae759mr47275455e9.1.1717425117195; 
 Mon, 03 Jun 2024 07:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIqVgMiZETokwx4bnQfwEuYfXGJ9+dX3tDZuMpzrYFYkEGfDNRhvdAm2VeKVBzxGhk2RlybO7OquqkEUsJj0M=
X-Received: by 2002:a05:600c:3b03:b0:421:37fa:e4c8 with SMTP id
 5b1f17b1804b1-42137fae759mr47275195e9.1.1717425116846; Mon, 03 Jun 2024
 07:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-30-pankaj.gupta@amd.com> <Zl2vP9hohrgaPMTs@redhat.com>
 <wfu7az7ofb5lxciw2ewxoyf5xggex5npr7j2qookddfuaioikk@3lf2nzapab5c>
In-Reply-To: <wfu7az7ofb5lxciw2ewxoyf5xggex5npr7j2qookddfuaioikk@3lf2nzapab5c>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Jun 2024 16:31:45 +0200
Message-ID: <CABgObfa1ha1MXYWLRTfBtMCTh0n=wNO=9jbRgbO10ksuzMO9hQ@mail.gmail.com>
Subject: Re: [PATCH v4 29/31] hw/i386/sev: Allow use of pflash in conjunction
 with -bios
To: Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pankaj Gupta <pankaj.gupta@amd.com>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, 
 dovmurik@linux.ibm.com, armbru@redhat.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, kvm@vger.kernel.org, 
 anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 3, 2024 at 4:28=E2=80=AFPM Michael Roth <michael.roth@amd.com> =
wrote:
> So for now maybe we should plan to drop it from qemu-coco-queue and
> focus on the stateless builds for the initial code merge.

Yes, I included it in qemu-coco-queue to ensure that other things
didn't break split firmware (or they were properly identified), but
basically everything else in qemu-coco-queue is ready for merge.

Please double check "i386/sev: Allow measured direct kernel boot on
SNP" as well, as I did some reorganization of the code into a new
class method for sev-guest and sev-snp-guest objects.

Paolo


