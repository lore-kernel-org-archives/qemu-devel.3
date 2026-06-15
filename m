Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22165CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ7Gv-0004Gu-Um; Mon, 15 Jun 2026 09:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZ7Gm-0004FI-JV
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZ7Gk-0004Ww-Nh
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781529744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xFhKIiX5yvF0sBClo6vGsnDhbuleDc5LvJDqkHMOiY=;
 b=SHV1BzLqQtq69Gr/gF/aroYBTis2rqQ0+LJyi6ez6Akvj3AIxe0m4iUhdsCb6sk9uLQLpp
 f4Tre1SpVeXccbutnKC5RKgt2EmSYBc9RNa2xCWeaHxYy94GFxNHYtyV0/PtCmwYc6AO1R
 zpX+HGigFyuLRGXPOb9/3WSYHHiYDT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-Uq-3yKDJN7qxnvjKut5l7w-1; Mon, 15 Jun 2026 09:22:22 -0400
X-MC-Unique: Uq-3yKDJN7qxnvjKut5l7w-1
X-Mimecast-MFC-AGG-ID: Uq-3yKDJN7qxnvjKut5l7w_1781529741
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b5d2e394so22534845e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 06:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781529741; cv=none;
 d=google.com; s=arc-20240605;
 b=Lg0tIaAC7Jg1OrsyaFSJqm73qXPYroQG0+KjZFpgRL0zonD2g3AUPcwKOFsLM49n6P
 beG+j5QxGW+WGyuiNk8zet6Z9UIhHDYKXEYuimBouQfrgaNJthi/cbcxFWAr7z+Vc6bA
 5+6BC1wGyZwbvFyuI19X/X9E0gYjwvHTdaQ6wW7kUFRYqUtZU3N1biiykxHP0KgiqxKV
 mgg0WAk18bT0rEfI2GtaJ5sO/g2MW/D9pS+tfWtKIPiUw37RarevwCSmjLZ0HEXtBldP
 2O+LhbsAoYkHnG/xkoIrKTyw0Gb9iXU4+dwOZZnNo7GdN4VF/QVKkphQVIHdbvEzCcxL
 qGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9xFhKIiX5yvF0sBClo6vGsnDhbuleDc5LvJDqkHMOiY=;
 fh=8aBEJY+feA7d7ThUvpzyIH9FOGeOtT6IdrliqPJEqPM=;
 b=bUbVejN4nPs88DO0vuG8JpqCiqCzNKs+uw2x2TClWvT/KJVXalHhx1xhZ82ZqZEWgs
 fmYC3Se8+kX4D7iESshde/yTimbNvmsGPoflC+t/HmuoSIYG30Zw72uS21GJn56YqnPM
 ShnufB16wYZLKX+I1NEhxD8DSQADL6kJ7aYowjV6v/eBKrQYw8o2bnQzyIb4pKnvkVA3
 ZI8/2X/U6s1Unb+L4HQRaVJv2NVA467CGga6vagUGCQBZekvVMscho/jcFQtbox1xFf8
 Y6aYIfijRwnwZrIhx2xlUspZ/66YD8mhjRCIRadHXbFZhTGbLfMjV/C0Tk+xayJ+rVrH
 6pQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781529741; x=1782134541; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xFhKIiX5yvF0sBClo6vGsnDhbuleDc5LvJDqkHMOiY=;
 b=qqtAtRaY4oOTKjHc8iNqFcuwMuq7vKav70HAVlIYEUpNRnz0egTwnvYNBmtamZdJm4
 qXDXKTQjn0qhZJ3Fk+CdOBeqqLAfk9UOxtR3p5DNYwJskU49BHB6U6dQkhWgX1FPgpXt
 O+24//FypzLCcQ4N5iLrt8V1BQQUOs/lT14r/IoVv+XnDb5966PZN8bCu79K11hYDx1h
 uqcblP9x4SYE+DTskOQWCANRq4kK4i1tfed+UUWzHJ4Bs4M4Dt8FkhfwEPBEgPiuGQK/
 lT/Qcxzs0PX9hCm/ZT8vI5NFrBtRuILN3yFk98L8vlqMHFJtg5YXZbxV9sAohx83fLR3
 sOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781529741; x=1782134541;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9xFhKIiX5yvF0sBClo6vGsnDhbuleDc5LvJDqkHMOiY=;
 b=YQR40JB2RaNT0fg1MWljzRggM5Z8owV+z39TLfNqKQO5b0QRCZKK42JIFyqMqHlY2i
 4TjuFyy6FJA3TIlEfnCrA0VNzjM5A25cgfRvskNRIP4CTeiIkX2yDPFiO1dNT8nMd9OY
 aymn7Nxn+6MoIK9bicAD7SohWrUqUrUlFu+ZwKc/fhEGTa1jQVhQpraXIlIfWqvhibkW
 JxpiYILS+M9W7LKmD0yvd5/HuBEgZEWfxc75qhXt+JE10als82pES0J+ZRRPoChRPgkq
 LoN6UOCH6FbCKc0R5T3iMapWYC8fDicLp/u6GRzRBv2ahL/Asln9j9dj9MFQTvBYE9iE
 kzuA==
X-Gm-Message-State: AOJu0YwANl3gMsIGKLAmQlCGlJtfgI3qzdjPCKaqhmABhGt82AuBYvyg
 EmJhGUJVgCuqdGyFAHCAc+5SOf+5Ew06RpT9XdOVclirzd0m/zlkkUS930XZRW6gjuVD86SLgH3
 O0nfQSc1pcFcYdkOtxyek27htO89l314vj8vVGTWHoZRdSxz5uvWscHzSKFUwPnF9WZBXIiLi4Q
 xoDJe+17Ibr0pzZLH5fLMp22Id4IPY1gk=
X-Gm-Gg: Acq92OFH7p3BGXn5aL4xOgWfFn+T2k4zrNO9NJ2Vye2iAeWNJ3EhRWrXiZIrhSN4wco
 DdGcWysCdYOjuEz4nfXkZwfKDNYgFOpMSwJAI3FNbTMxvc92PMc7F77uBM7NQqDaqJHv1fsFLD2
 5wpKAuZwNy3m0LV9BDb8PhZ6rIfqHDuJfOllg0MscAFt0Uz/tyUCI3meKmL06SCqcC5Yqffx3U7
 jloq/BYopu+9xbp74j9w0hagBg9eQHP9CNTjCxrve7c/ZJNl3I9OONo9gmybQxYgLMTsn/LyO0m
 D5t9JOw=
X-Received: by 2002:a05:600c:4b89:b0:490:3d62:f5e1 with SMTP id
 5b1f17b1804b1-490ec4fed56mr111581675e9.22.1781529741282; 
 Mon, 15 Jun 2026 06:22:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4b89:b0:490:3d62:f5e1 with SMTP id
 5b1f17b1804b1-490ec4fed56mr111581365e9.22.1781529740893; Mon, 15 Jun 2026
 06:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260525150503.393743-1-pbonzini@redhat.com>
 <20260525150503.393743-8-pbonzini@redhat.com>
 <8733yoqbnb.fsf@pond.sub.org>
In-Reply-To: <8733yoqbnb.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 Jun 2026 15:22:08 +0200
X-Gm-Features: AVVi8CdzFq82xtQzCX9APVT8CB5M_8SqoKD7aOCF-0mLpMN27-d63bt29yl7b10
Message-ID: <CABgObfbA=W0KB_8-3qTA1S3Wf-8K=2yQkb+NVabGdTZvujVN9A@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] json-parser: add location to JSON parsing errors
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 15, 2026 at 1:35=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
> > -    error_setg(&ctxt->err, "JSON parse error, %s", message);
> > +    error_setg(&ctxt->err, "JSON parse error at line %d, column %d, %s=
",
>
> The usual format used by code parsing tools such as compilers is like
>
>    "%d:%d: JSON parse error: %s, token->x, token->y, message
>
> Should we use it?

Sure, why not.

Paolo


