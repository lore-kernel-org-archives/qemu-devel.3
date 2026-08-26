Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6C4C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAkd-0006nD-8T; Wed, 26 Aug 2026 06:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzAkb-0006mJ-OP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzAka-0000ns-3v
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787739654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbIp2dYPlwQrtD+uI7He0XVYEw3siNUFLOX/bQ/nhrg=;
 b=AdRkSFS1nVmwrQRMPMHlPQqjbF/16WZ++kW+XJmRNH9r+QdJ7/DY9lM6nzfHoLm9yMohPC
 HLFYXMma1jBBpMRHGxnHzCk8xqemTd6xdn5YJi72gIItGG9aqLrsO5LffQ51HLGTGODBy4
 KPCZanuliaDk7Duk789tnpOpJsmLmfw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-CTu7BLmxNYGbBh8CfmyK2Q-1; Wed, 26 Aug 2026 06:20:52 -0400
X-MC-Unique: CTu7BLmxNYGbBh8CfmyK2Q-1
X-Mimecast-MFC-AGG-ID: CTu7BLmxNYGbBh8CfmyK2Q_1787739651
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1cade6b71so326722a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 03:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787739651; cv=none;
 d=google.com; s=arc-20260327;
 b=dON4RWMse2nwNtU5ZXD4eSm1D6H5GswlsX/7+9EARZQj/biQ7rA2Q1jqccjKMRQ2im
 g1A0pprqLO3Iz7kDFMCa4WFiipUgepM8GrEjLhCEqHD5WPsTeSF3D2ezwcBp3v8GhEHL
 i9oI7t7rcaQf6JmwNlARYHsTATJFiNtnLHbWz0oZAOJlAyKPOw28hTokaCnh6njYKwTI
 v+JlW8M0xWg1SFt8ejQVLtx0myR7NiSQeUA3ox60AD8hOlm5r7gPCCPuiBIq8VQL3doe
 dXWI4HegBO2l5zheEZgcxal6x3Wo/nDDlMtYQCtVrUtDz7+irxhGbOAL+K63eZgtsvm9
 rCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GbIp2dYPlwQrtD+uI7He0XVYEw3siNUFLOX/bQ/nhrg=;
 fh=My/dhtHlzqpzzqk+O8nz5LmSBGIUu+2zp1fqnReyFzM=;
 b=h2XnrrWi2+YSPMnNB+gRipBMokw0DwpQVPXQGUPzkrEmk2lyrpZMhe0GQFdiAadO5y
 65vEOrDX/zozcnxs4VXG+lyk5hgabf5IM07NhNhv3j+9cekx+Avg0MB/J/Ba8G2EbvFy
 hqVJ1MWCZCINUESjWXvC1tITqicKqOFEbNmZl9bd74hlfZVQo51rrtSDSYwbmfWdOmLL
 /egOlLcLGJFGVQAkBI1LcVJPWHZ7TB1cMVTSIKm5FI3Dnkw1JWkop7ZwTbXkq4+P/BZz
 zNGRKyLaBrM8ii4+9NTsLP12QVrF3uIywW4FeXlodX4FjYJY6KuAHk6jfF/7YdsopCl7
 dFFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787739651; x=1788344451; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GbIp2dYPlwQrtD+uI7He0XVYEw3siNUFLOX/bQ/nhrg=;
 b=fjRYVSB0HCHkrHVXc2WajVI3xna3uD7N45H1sgwKBjdFCIJxSfmVORu+isJIkoOQwu
 iUDghaxzPr6gs0HkpO9v5BUkxJNN/nNDxyCT4gM05/FDlQaX5vfrplDu5K4Tmtp0/bsW
 FF+RFIbepCZexqBnAWyJRZQzCUn9zPDImhRmGLEyA67CHjNRkxi3YLSFuKFpHUZkWpNw
 YwCgB1uo5vdaDD3MUN0HShyPDF1mfxUTuhd0gAluqTv+bhWq81ycL7cEtUaBR6q2LKzb
 ynyn7hYpfnL6yoN9t2258CqvKM1y+vQxBsgNOP5FSSd7jZ6WbrolkrSaMiiEfjH7GVNd
 iPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787739651; x=1788344451;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GbIp2dYPlwQrtD+uI7He0XVYEw3siNUFLOX/bQ/nhrg=;
 b=PyLKVYRTrp8Bx2I+Lvl0KfHGhFpbWDMuHJPS/cnl/loPz0bnhG6GgKgUNMwxc8taBy
 9C8UDPXaQ2oINcbRL1VNM/tHuQ1+BLnmKJZN2FMFdcTrnedbG5yA9FZkAi4aD9lPKX7D
 lDwyhWzgVle/2OqS4T/3jx69ksW/3SBhNn8kCZXZe/ua+hlK10xJUDKT7ZfTgfO2AJ3p
 12fKQo2N9qI9ldD4uz15qpT5Dur3Zb8R89sEkEogdT7y2shLWoyvciL6b3K022yR5eoD
 lKV59B/WAyerToLnIQWWszJfc8abDchZ67RUO4X9YsWot2LGW5CHsEh/zr1s84uAjVjO
 OU5Q==
X-Gm-Message-State: AFuF++nYp1hNdqDqZ3qKVJwgGvqAsMDXNlXWrQwaC7gSs5BzlCfPbcU0
 Dveo1XTDLQy1ty1qHVdQf9MRN47m0Pu5wcEDDtDR32IPNacaCp474LzcAoKWUJb7EG2LyOgMYb9
 u/ulJmSLLiOqZzG8A8FQVbAq6gwCjjow7yPkRcN9Uvu81iHnqZErqak8XWra+2uZzGrQj+aQbGa
 pRIoW5dFbGAwOqijSRZoDkQ+YlUs52DfA=
X-Gm-Gg: AR+sD13DLf/1R8lxkOMLrM2U8lpEWChOGW4vMvKeXTI5lk1Y59FKVGVElaTML2ShtFp
 jno/+8gleweQe+1m4EFmQsC6WiU5DyVSNiaoC+12Uq5qz8e4cP6rFU41WnbfNcK7vouIJ+P/ZOP
 NkwzJHrIKsTWPeatp67AFZTJypBkdeTY7FW9tu0xAYBhMKV3pm+CNovY0Xsws/M677E1xDPyIwY
 tN1QMJS3TqHe0B2BTYifagwhrm3i7CgxOYfaeSPYJposT8NbQWFtuiU6zwlHnFqyrGH2heapwnH
 dw==
X-Received: by 2002:a05:6300:670a:b0:3cc:8716:4702 with SMTP id
 adf61e73a8af0-3ceed63d829mr8077002637.8.1787739651052; 
 Wed, 26 Aug 2026 03:20:51 -0700 (PDT)
X-Received: by 2002:a05:6300:670a:b0:3cc:8716:4702 with SMTP id
 adf61e73a8af0-3ceed63d829mr8076937637.8.1787739650635; Wed, 26 Aug 2026
 03:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-32-24b8bbbe3d86@redhat.com>
 <2a4be3a0-c413-4170-8aca-8d59717fa8f3@nutanix.com>
In-Reply-To: <2a4be3a0-c413-4170-8aca-8d59717fa8f3@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 14:20:39 +0400
X-Gm-Features: AcwNN1U6wrHjTb4OC5UGnNpqNTIHCBJ_TT6IvpyGKRNM77CT4zZxRBqo0uc5JZQ
Message-ID: <CAMxuvayNM9wXkJggCvdzG+zJeaPhoqxkQn_pbe_XgnBx_=k0pQ@mail.gmail.com>
Subject: Re: [PATCH v3 32/74] backends/hostmem-file: fix "align" property
 typename
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi

On Tue, Aug 25, 2026 at 7:07=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 18/08/2026 12:10, Marc-Andr=C3=A9 Lureau wrote:
>
> > The getter and setter use visit_type_size, not visit_type_int.
> >
> > Fixes: 983768431676 ("hostmem-file: add "align" option")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   backends/hostmem-file.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > index 52b62f715334..39a46d353839 100644
> > --- a/backends/hostmem-file.c
> > +++ b/backends/hostmem-file.c
> > @@ -275,7 +275,7 @@ file_backend_class_init(ObjectClass *oc, const void=
 *data)
> >           file_memory_backend_get_discard_data, file_memory_backend_set=
_discard_data);
> >       object_class_property_add_str(oc, "mem-path",
> >           get_mem_path, set_mem_path);
> > -    object_class_property_add(oc, "align", "int",
> > +    object_class_property_add(oc, "align", "size",
> >           file_memory_backend_get_align,
> >           file_memory_backend_set_align,
> >           NULL, NULL);
>
> This looks right, however I also notice that both
> file_memory_backend_get_align() and file_memory_backend_set_align()
> assign the value to uint64_t - is it worth fixing at the same time?
>
> Anyhow:
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Since the underlying type is uint64, let's use that for the visitor as well=
.
thanks

>
>
> ATB,
>
> Mark.
>


