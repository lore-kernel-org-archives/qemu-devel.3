Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5062F94CB5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJrb-0008TP-8P; Tue, 21 Apr 2026 18:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFJrZ-0008TF-B3
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFJrX-0004cV-Sz
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776811594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZpuipEpfJtj+DrvERAmgraR+M+WyPbG08RzE3R/W7I=;
 b=CM3RfCb6ywUWqgB7KVex8pDv7Khx+zFfO95zng4Ox47kVq2eBOi0oS3O1Nsw9OTYfQ8WzK
 gJ8lPC6W2ueoNfqYF3NHYHuDFYQ7UcbloMTm9thS1JVz/RgziVzFSh2u35s6dBuIjjgTEx
 Vl1j1C6g4pNoKO7zBralxvhnuZsmCT8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-POxy7BJtPvqNn1lU_JhI1Q-1; Tue, 21 Apr 2026 18:46:33 -0400
X-MC-Unique: POxy7BJtPvqNn1lU_JhI1Q-1
X-Mimecast-MFC-AGG-ID: POxy7BJtPvqNn1lU_JhI1Q_1776811592
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43d03065782so3223114f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 15:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811592; cv=none;
 d=google.com; s=arc-20240605;
 b=QzCGttO3/zrzMhNrFuZuVIdfqfY8zqoT/pw7UrbZPRR930micuqWsgpzplE7qr3JAP
 jp1Iyyur0VwoIP5VXNh31u20EgH3wuMj9o6FgGPllYBgypj5NUXspRbNeW9WzToHl5QY
 ljnd0CdDlE2ESkRZXeHg/OxR4pbfeLx8c9sNO1HLoRCmuw99gnRtJIRybuDL/abYm7ig
 aORI/ir/diZxw81uW2XBV1Hvpyp1/UToa1JTsAHO6S16WF9tXPueiYRzKcUQ05UE9GcG
 8cHKQIBk0D4tfqCapPZP1Vt3fl4O2+BZ6DHh/XcjOMEIm0KZtpkouX3N9bdkFLwIgn7L
 v+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kZpuipEpfJtj+DrvERAmgraR+M+WyPbG08RzE3R/W7I=;
 fh=bfgOPgYf33WKQTbU9LAYkdLBPvdem/dkKQfKUMvia/0=;
 b=VtKeQ9H1NIiJgt6+lyOpQlzLQs9rTkwKQtKd9a7jlszslZdYGXDnlCIGu/FyqjBwLC
 jh9yXe1zKva6bEHGSYJKsrGnOEPIlfD/JB8iOFJx17HZTIpOm8XQS9TlfBY+/xny0qMs
 0U5q7xidUTVGwOWlCuLUm2oZw0t3+IXkVf73etMvTjdnNRQtT0eqO8FvC9vYL6QrTpwt
 lNmIe+ENLrGNe4cHQHkXcBgWojGzUbn8fmwAWx4WzZxHgtMmJj54sqnJp10ObvXIJ2yU
 BpjnpzJJeTt59bnoDDRrL1CrE1Qm/V2nNs31/q12XTpuQHvqH03uR5sxR6oVwx2WqvxH
 9r4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776811592; x=1777416392; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZpuipEpfJtj+DrvERAmgraR+M+WyPbG08RzE3R/W7I=;
 b=mb5A+2Q370P4exFj1Up6ef0AGcn2PF0LI91fDZ0LFZkD0SsQNgD3ktWZthbnviGIOu
 5++hO9PaXKIb3ldSezKgEKhSvy3xe47hjs61MdPoBpAU67edCXhCdtR7nUAGRC1oaLYh
 c4zH/+cE61H3fJtUFIhckRxp3unegoTfP4PplXyTaUKCSWO0C5iwFVsapDCdHQPIDmPR
 peurMBXByz4JRJktCotcLhtKhuBeVspy9kkIXbVdk4DHTzShbYtUYbLZvJoN5T4UoomO
 REG93E1sWmvW9Xt2b86+D8WXAHhnAB0PgXycLV3Y0w1a0R3QUhv58yb0TzPRtSzl7JDz
 3/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811592; x=1777416392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kZpuipEpfJtj+DrvERAmgraR+M+WyPbG08RzE3R/W7I=;
 b=U3wCSrvneGhf5RTSOzQR5oLpvSsC6KdupBpCSOrjaL3NWM4LxdnQx767oWlVUCqJLo
 WFf87/JzpmXZy6Rn3gSZskcHDvSorxamZO8Msfb7xssTucYyy6OFHu1aqbcetBWZyExf
 2Yw37GXiL5F1gGiv3hxE1ckt3qgMY651vEM/3BNTzddBc6qlv2hUFvYnauofWEbaaB2E
 IB3fpAwGTiSLm1PULkbT1swXVHbMWawp7dsmuxHdqSQHSc+w+UslHZekH1UFguz3CUUW
 HGIS+Gx+RbB8pW96EUJSjRu7WH+kDPl3uY894pevijuB/Nlj1EmJN0zhjJxUeVOk4toS
 LeNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GjxeA5momMqxoOyM7Mze9dw+dX37kV1RculrP+c7FcZCOF/gFEHoS4ILPuVTGtTePA4qUGES0G9EP@nongnu.org
X-Gm-Message-State: AOJu0YzP4iRTsNVprDzMwhuRSks6XvL0M2ZicGyvQFIYCilX+B30bbqi
 diI4ihon5eI7YO6TjFEOsT6eKTRuw/3Yjyziq9a8iJpgxnZjyYxKO1yKTxOYZufe3BiiWOo5hKm
 XwEHCGSn3m3hIMtprcer+PozHtTLChcEUjEd5duoQlO4kV6rktK0WSItotPJVrkGVahLveRxOMB
 JGtRuttMKEF80lOiiArmCAQWPtE9D7QPU=
X-Gm-Gg: AeBDieuC5uy1IbOO9RRDJM5UONCn0DWio8XU7PqV5r4ildytD2WP3MU9wX2mdwYTzpl
 jc1WQc6wXVk1sIM9NsJgqn/dJwZGhCsZFlgKfWn7kCMtWoKQjEI1doKlq+GreZAgXJI+eUwrgkk
 lW2cAg2BJbtEMs9A/7k2bwqqPgIGUP6cYimaSfvm+6oSu1OPAf0Oo3g+JnUu/Ze4YGNKJDTKsVE
 rrM6xahL1gI8/Ng4dciOytX2Tq5yfL7HY/afsrtjHN+v11S+NZmn+jYPJmlkcT82gqK8S7t004M
 2+01L8zdJ1bpOQ==
X-Received: by 2002:a05:600d:b:b0:485:2a85:e5ec with SMTP id
 5b1f17b1804b1-488fb73b424mr235784975e9.2.1776811591790; 
 Tue, 21 Apr 2026 15:46:31 -0700 (PDT)
X-Received: by 2002:a05:600d:b:b0:485:2a85:e5ec with SMTP id
 5b1f17b1804b1-488fb73b424mr235784775e9.2.1776811591363; Tue, 21 Apr 2026
 15:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260112113139.3762156-1-flosch@nutanix.com>
 <20260112113139.3762156-3-flosch@nutanix.com>
 <a28bd807-6e98-4393-a354-b7ed1f7a08ae@redhat.com>
 <f878fd12-17bc-4249-beca-cd134bb93d2c@nutanix.com>
 <CABgObfYYt0CuLzj4kdD13J3+bUqAxNpmKTc4g=LtbojvKAatyQ@mail.gmail.com>
 <0ec397c4-5ec9-46c5-a081-a6b380320755@nutanix.com>
In-Reply-To: <0ec397c4-5ec9-46c5-a081-a6b380320755@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Apr 2026 23:46:19 +0100
X-Gm-Features: AQROBzBHpJTUUzKSVvETMjZjM55D2VVXOGxyH0uQ8NsQWRLnEtbdyDKcy1_FR6Q
Message-ID: <CABgObfbwVAgai6cKfxoFFXBfPJcR8riZmWCNi6k+ckzTcjuh_A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Add HvExtCallGetBootZeroedMemory
To: Florian Schmidt <flosch@nutanix.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, Apr 20, 2026 at 11:52=E2=80=AFAM Florian Schmidt <flosch@nutanix.co=
m> wrote:
> Here's another option, though I'm not sure you'll like it: We can get
> the same information from /proc/<pid>/pagemap, right? We just have to
> check whether bits 62 and 63 are both 0 or not for every page.
> It's less efficient, because we have to read 8 bytes per page

It's also completely useless for the very common case of pre-allocated
hugepages. That's the case where you can get the largest benefit,
because when pre-allocating you use threads on the host and do the
zeroing before the VM starts. For non-pre-allocated pages you still
pay the price of double zeroing, but guest and host do it one after
another while the VM is already running.

So I don't think there is any option other than the ioctl. I would
suggest experimenting to understand how Windows uses the hypercall;
and possibly looking at the QEMU write tracking part. The KVM changes
are relatively simple and for quick experimentation you can operate as
if the KVM bitmap is always entirely zero, not unlike this patch.

Paolo


