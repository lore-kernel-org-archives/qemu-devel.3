Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEA1E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNChV-0007Sk-13; Mon, 16 Dec 2024 10:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNChT-0007SN-BH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:07:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNChQ-00077P-Gc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734361674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPP/G/B52pycc696Wd9izs585ZKMXBRk/dY5TcvCWoc=;
 b=aGEkvjjFIyF/PkWusbLXiOeVnsVmaBzWGbCtCoiSoTTT2XLceyVzKd1izWhYosToUUPj3z
 zlo3SovnTxosS0uAflDSlK5ALTDFBlpnbwVal2rQTfK/CjI/yr/C4Y6T0R7iXadO7WyICd
 cTf/t4Ql9SdrnyL1I5YxJZ7rAVn64tg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-nWtETNAQOm6NoKkrpl-PrA-1; Mon, 16 Dec 2024 10:07:52 -0500
X-MC-Unique: nWtETNAQOm6NoKkrpl-PrA-1
X-Mimecast-MFC-AGG-ID: nWtETNAQOm6NoKkrpl-PrA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361b090d23so6729735e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 07:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734361671; x=1734966471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPP/G/B52pycc696Wd9izs585ZKMXBRk/dY5TcvCWoc=;
 b=hh6z4DAD2BJBns0g893SUexQVXXPR6dtGsaILK/S53mwRD+Rreoi/+HbTt9Z9JEuRW
 XdrWkMzlLmuPJvKVjqYrQvls0kzF0TshMYk6k2ywIV6QWn3K855fxNimReDwhnNc5gal
 b0t+ZoQfiWxL+BvfQAJs4hX2C860w+twXulkrbjpQxnegrA/+ENwPob2BdqZVF3YA5PL
 aF2sAqsyCJfQnJVXZKiinMtiLF0wRABOWhYKOPDywgncb3QU3d3dTviX88f4Nj+CVbdz
 rEggouUuLhoegmB15AzjqJTVSQaAPV/nrZ7E+DvbUSMXsaaRZFaiEmZGDw69Dx/rHv0m
 55kw==
X-Gm-Message-State: AOJu0Yz6EBtPr10jgqBgiacCpk8q8TfClet8NOjeG3zPR3Un67hZquD4
 7scm2Jrmr/RqZY0wK4uBI0M3N+cQSHE3I6ryQ/nyEI9X5Ejwh+BGvL6dU4W8drpBNVKhziMP6fC
 Om2oz5lZIJNPgpSvjVdITtCYXUJxAvjnIIJHEHDUqlNFjSWs/u/4zRD3bj/lYxFe2oJ0yE5d2Lm
 KHhnELptWjQqIA8eYd63VpFnf3B/Y=
X-Gm-Gg: ASbGncs6YT+eKdOzhkkdsb1cUZimtKzhjE4C9phMnjmdMeD1uOXYz0x7oFCZ48J4c62
 q2suJ5pZjeCl383jYgkuiDv63ep3XEbnu2+gZFQ==
X-Received: by 2002:a5d:5988:0:b0:382:450c:2607 with SMTP id
 ffacd0b85a97d-38880abfca5mr8646803f8f.4.1734361671192; 
 Mon, 16 Dec 2024 07:07:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoaKbJWOAzDL1Xz3QbLw/pBkLxCGXIF/BsduZlCPsFFtF0QR/ICF7EITGHwaMpZ3lqgivrVgzQPg2tYepc7R8=
X-Received: by 2002:a5d:5988:0:b0:382:450c:2607 with SMTP id
 ffacd0b85a97d-38880abfca5mr8646772f8f.4.1734361670851; Mon, 16 Dec 2024
 07:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-22-pbonzini@redhat.com>
 <Z1q1KAShyW44BJCg@intel.com>
In-Reply-To: <Z1q1KAShyW44BJCg@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Dec 2024 16:07:38 +0100
Message-ID: <CABgObfa6opCJquJEbyZB6h+Cmk_WcDcJ=w_zvY7D=bwRWV5-uw@mail.gmail.com>
Subject: Re: [PATCH 21/26] rust: tests: allow writing more than one test
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 Junjie Mao <junjie.mao@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

On Thu, Dec 12, 2024 at 10:46=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> > +fn init_qom() {
> > +    static ONCE: Mutex<Cell<bool>> =3D Mutex::new(Cell::new(false));
> > +
> > +    let g =3D ONCE.lock().unwrap();
> > +    if !g.get() {
> > +        unsafe {
> > +            module_call_init(module_init_type::MODULE_INIT_QOM);
> > +        }
> > +        g.set(true);
> > +    }
> > +}
>
> Only one question: what is the purpose of using a Mutex here?

Different #[test] functions can be run in parallel. For now there is
nothing that needs the BQL in the tests, so I used an independent
Mutex (which could become a LazyLock later when the minimum supported
Rust version is bumped).

It could also use unsafe { bql_lock(); } and a BqlCell. I left that
for when there will be a way to lock the BQL from safe Rust code, but
I can also do that now already.

Paolo


