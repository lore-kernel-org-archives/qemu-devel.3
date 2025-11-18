Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4716CEE339
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 16:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLOTR-0003CZ-Ij; Tue, 18 Nov 2025 11:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLOTP-0003C0-Td
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:22:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLOTH-0006p6-1j
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763482940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9novQhfIyE9CF2gPlHGuZnEW68JqugUFyFcO4vDKfY=;
 b=NW6S+wB7Zw4wdktQJppNK2bEx81jvsoHT6z4v7y1qOwx9qpGvkhZ2ofk38i1tDxkcaEwSm
 lI7WiAQQuWjmk663I+xeVaEM/jxnWfBKys5QOHLlSTW3KNFjxIKXeNcnmCsfqe3eKo/bVj
 nyxUpSc6/nTopn21WEjvorrCBhDOD/I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-5dvqpxOLM_GlJq9Zzd8u9w-1; Tue, 18 Nov 2025 11:22:19 -0500
X-MC-Unique: 5dvqpxOLM_GlJq9Zzd8u9w-1
X-Mimecast-MFC-AGG-ID: 5dvqpxOLM_GlJq9Zzd8u9w_1763482938
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b366a76ffso2858508f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 08:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763482938; x=1764087738; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9novQhfIyE9CF2gPlHGuZnEW68JqugUFyFcO4vDKfY=;
 b=gH8K1gifb4Q5UwWpVt4ZtFfFU/Mij49HsL++CC+b0tDGd+Dy+WAKOv+psJV+AA91rE
 5kODZrnz8gadrmjVET3r0zqL4lfMsXOfc2geMuprSZkdDnvmdbdHm4dzfI/8g+EPNp2B
 J+NvsgXdJanWamo7CRWS2cLsARA4nZWOynj9x2zwGEjeV/bFCmnoEfnm2gcr8+VZZwaz
 t3IXZIHR1P0X+rp+W8IHjxIgMXjgIb4xD73wDeih1PLSsrJab4Aj8Cdm9YyYmVY1uu/6
 aoOKClxWxnC+Wp0n85Jgvrr0pJtLYXtJjn20tkbCOJFPO2udk3DtTcmrANzg5zG+y6xO
 qu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763482938; x=1764087738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/9novQhfIyE9CF2gPlHGuZnEW68JqugUFyFcO4vDKfY=;
 b=OJcMl9z8Zfc+0yr7LSI9FACGwn2njYt3NOQNdJh2QM8ni5NiUysNsCtwtBqED5QXKm
 YTRTUQAtn6qhQo4Dlgr+iREuJldxF3WLJxWNmeSmKAuvpDOQGaLUQSvd+Y2P0763njBN
 H5qIOvZpNmic6pMC8hCp7bV56OzV2b+PCg19u3t8TBf8RBv38+hZg1hJbU8Q6UO46UfJ
 EmMipcSR6E/eYAlaawaKTFYTGaEkuSF3wc2UY5/QPKwu+MX9G9JBSmictdZlDE6LCx6l
 S6VKHZYm8/rvvbMGvUBgRCSzTPltLHdG/wYRgZgnmH8ldj7HAN9sJhFgJvu6RcnwM39q
 0v8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSLnGg7KQ9KDWd2oRkGZYzGsIRfA6HCLuhRrjct8TT3CuoyCNoE1Uabh3sIV/b+Y46rJ1In+WZBWPT@nongnu.org
X-Gm-Message-State: AOJu0YzykEaroNyw/INgB6K2duqYEA1AZXYYUE66Ga4MQ8N7Lkv4UziU
 is9lwZhwznBOw92cjXrJxjKXngI2ZmdOnTFb7tZfXR/ah9p8Jap+j9wR1Z7n7RhNOw+m7Du0cKx
 zIYYtxp60fof4mnTKM4OVHHGoKP59G11R3H/mGYkApDwAGqRtgmhS/KC0nvfADUe4fEkgjFohoT
 o3Qp0Dc9ypa41JncFw9AYLfSATol8KNT8=
X-Gm-Gg: ASbGnctWcBJzNjCOlte6i9QkFiQpO5o0W0uMvU/s/pkiMXRguwEN6IXHlr97DpQGR6D
 AYv9cCLfuLiA5HMguM8r9b0K6u+gWLPicYXIy6+md6ATpmgBrBxvHhL0nVralXrit2Q+1ILNTtk
 eW1QuCCflgF8lIZLgBoUnvSe5tKLhRhU5TkzNl9RsHjDaiNG0C6kgxhb1vYdQP3y3S05FbJt+IW
 J60wUWfCkkB6t7enZj7JTHYWphaMuFmYXXAo4T1pzSMBCp6Su7O+FvuIPA2G9SXkOvPxYY=
X-Received: by 2002:a5d:5d0b:0:b0:401:5ad1:682 with SMTP id
 ffacd0b85a97d-42b5934f412mr14898423f8f.14.1763482937730; 
 Tue, 18 Nov 2025 08:22:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHy75dS1s2Y9K6pKUkbWAcq4UJ6JDhJgx5hElWTHSgGxdrIxFSKxoOJlRk48nMGfiNfTSdlvJX3JGM0G2omLKA=
X-Received: by 2002:a5d:5d0b:0:b0:401:5ad1:682 with SMTP id
 ffacd0b85a97d-42b5934f412mr14898405f8f.14.1763482937342; Tue, 18 Nov 2025
 08:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-4-pbonzini@redhat.com>
 <cb41dc20-5a87-42b6-8819-08f5a1ee4303@redhat.com>
 <ebb0ac51-fbf0-4f93-8a9b-12880d2a0126@rsg.ci.i.u-tokyo.ac.jp>
 <30a9e854-e37b-4494-b372-f76ce6bdce25@redhat.com>
 <d9db8f08-f207-45b4-9637-9f13a04ab606@rsg.ci.i.u-tokyo.ac.jp>
 <81072e45-182f-419a-a44e-fca22ed54167@redhat.com>
 <d4921688-b3b3-45f2-a3c9-dee2977750cd@redhat.com>
 <889e6be6-0cef-4a23-9d57-2e0611f9588a@rsg.ci.i.u-tokyo.ac.jp>
 <185927c2-9386-4935-8bfb-64eeb87f06a7@redhat.com>
 <84bd1674-4a38-4864-9297-fef628b51cb8@redhat.com>
 <ec0110b7-5d63-481a-8d8f-3eefbe366129@redhat.com>
In-Reply-To: <ec0110b7-5d63-481a-8d8f-3eefbe366129@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Nov 2025 17:22:04 +0100
X-Gm-Features: AWmQ_bk-6u3dh64FvO8IawunmZF6BL6quMg1zTdcjtVWGY8x-vExGSxhuz1MBi0
Message-ID: <CABgObfaCXcNn9jvCqW59fu1Nkoe6z_2AoXr5u6ot=90vUosqaA@mail.gmail.com>
Subject: Re: Regression with the "replay" test on target alpha
To: Thomas Huth <thuth@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 14, 2025 at 7:11=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
> > I'll look at it today; if I can't make heads or tails of it we'll rever=
t it,
> > yes.
>
> Sorry if I missed it, but did you find out anything? ... the test is stil=
l
> failing for me, which is somewhat annoying ...

It was failing and when I started debugging it, it fixed itself. :(

I did pin it: 1) to the _recording_ side. That is, the broken
recording cannot be loaded by a good QEMU and a good recording can be
loaded by a broken QEMU; 2) to the write of the WAIT system register,
which is where the CPU goes to sleep and never gets the event to wake
up.

The reproducer is

./qemu-system-alpha -display none -vga none -machine clipper -serial
stdio  -kernel kernel-alpha -append 'printk.time=3D0 console=3DttyS0 -net
none -no-reboot -nodefaults' -icount
shift=3D9,rr=3Dreplay,rrfile=3Dreplay-bad.bin

Also, I wrote a patch to add trace events for instructions written to
the replay stream, which I will send.

Paolo


