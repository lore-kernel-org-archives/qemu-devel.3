Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC71C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQkM-0003jY-Gd; Tue, 20 May 2025 13:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uHQkF-0003gS-Cu; Tue, 20 May 2025 13:27:16 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uHQkD-000616-9d; Tue, 20 May 2025 13:27:14 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad574992fcaso427493466b.1; 
 Tue, 20 May 2025 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747762030; x=1748366830; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubdpCczsZibNgthTjMiMNGqxMk10dSq5tiwPED9kh+4=;
 b=IRo3c/jmNSkifmQIDvfDw/4Dj2WQjJUbbI5Rr21T/J/PN0n5ymDal8cT7yw90LCzGH
 onVkPvfDQAB/w2r35Lck+W+AAgHWcea19YLj/h+vd7KDO/PoKBMLsS0b65y47nYZTFfO
 0VN1BFnm1ItqrbCxM+vTAUG1dXKDE8YYTynQ595KXBQR8XyptlYrbEvDtJjrKsxsHWD7
 wQ2Fs0qUO0XBzOnH9M+Z8r+31b1xL9igr3qikTjX02pqZ3IiAQjtVJT9a2hd040qCxUp
 9/yFJJlg3x9oOtnTIwejaslr7TlrNW+bDBjqFYRSaf36av1eIs0jcmnJgky66yWqjggd
 kdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747762030; x=1748366830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubdpCczsZibNgthTjMiMNGqxMk10dSq5tiwPED9kh+4=;
 b=WllZmNYmWoUXlWgBhwyr81EjYXLdXzLk6NNVgSOnX5uyzqUFjRcfrlTUy0RzQ1e4am
 m5aLDgNght/oypS5N8olXoCvVSZIi3WX9RGnvDqe1+T9Yf+ZGQRemHvZAQA6LlazJ2qu
 D5bHCoeoujgqXJTPT76BgM62DQCWqDPyfxc5cT2DJJJwTY7NeCF25wIxtxVpaC9xRjWt
 8QLfUZePXelUkfigqAXgI5Sn7S6AtpJXgQPUJx70xvkvWo1D9QdkvW83pTztyUT0icnF
 QJLAl+uRI6oglokp1fBX2Gax2nP7cQG3pWLVKZo1JKEjEuMsFoFwihmU11O0hM0MRqFw
 2sbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR51r46OsNfbRNLgs+tSdBxW7ljoGHtuY2NFzLDAC2YM7OExcfoBLzraxfomfbIOU8uFRrkuPXsfN5XQ==@nongnu.org
X-Gm-Message-State: AOJu0YzpXm0giJmiLU3qpdhdgS9aHuOm2vgNilboLc++WvqKcQEtwRcU
 cqtMmivvs0IZ5bNCUdXQOwuQtYmYB055U564da1lNWvu5npu/KexhrIHnxDYhXZHmI3WLKU+agQ
 HgYTEgyaDB/IQLe367Fyaqly75dAlv7s=
X-Gm-Gg: ASbGncsDdByaMfUm8NLj0L4Jq1w25OdHIPwUbfuyr1KiEOuDFAqKIuqoG3ir8aeWcvq
 vDkdocnEhelcERkxWRoeKe2aDPudU82fWyMvoxj775VmPdFJTFRIyzp6gcXh5h6u26XKb2mwesD
 jt7NWdQeJKHuE7wolixBAMrZq7wAR+WJx3wFcqRWgEh+jD2zakCqOotoAYI4RvmhQADA==
X-Google-Smtp-Source: AGHT+IFcbP4c2BGyQwPh5wTzV/NDB4hPc4321sCiZt+alzZZqhogN30BE8Iw7ZIk30fiOyViXdFo0BvKIP2R3tH6lrc=
X-Received: by 2002:a17:906:9fc6:b0:ac6:ff34:d046 with SMTP id
 a640c23a62f3a-ad52d468b54mr1798804866b.2.1747762030341; Tue, 20 May 2025
 10:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250518152651.334115-1-zzyiwei@gmail.com>
 <328b1fed-f23d-4ec1-ab06-c3096a76da19@collabora.com>
 <CAJ+hS_jVxV78mifbPEqvFM9Yuf3GOS+iP-yFrpLtRksGYpFLxw@mail.gmail.com>
 <f7d09af1-fbd2-45f6-af6b-d6c02d784513@collabora.com>
In-Reply-To: <f7d09af1-fbd2-45f6-af6b-d6c02d784513@collabora.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Tue, 20 May 2025 10:26:58 -0700
X-Gm-Features: AX0GCFspKVbyJ-cW6DpZI-QL7LnmTLP-BSBJKh7Cc2UH7s1U0TvvglVa4oEGQsM
Message-ID: <CAJ+hS_ggx73XDSBvTQDfXnRQNLC5rvWqM0R6CyBe-czzJ+Fjdw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: support context init multiple timeline
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=zzyiwei@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 20, 2025 at 9:31=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 5/20/25 11:26, Yiwei Zhang wrote:
> > On Mon, May 19, 2025 at 7:29=E2=80=AFPM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> On 5/18/25 18:26, Yiwei Zhang wrote:
> >>> +#if VIRGL_VERSION_MAJOR >=3D 1
> >>> +static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
> >>> +                                      uint32_t ring_idx, uint64_t fe=
nce_id) {
> >>> +    VirtIOGPU *g =3D opaque;
> >>> +    struct virtio_gpu_ctrl_command *cmd, *tmp;
> >>> +
> >>> +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> >>> +        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX &&
> >>
> >> What if guest kernel version is very old and doesn't support ring_idx?
> >> Wouldn't this write_context_fence() cb be used by vrend for signalling
> >> fences without ring_idx info?
> >
> > Old kernels without CONTEXT_INIT don't have the uapi to create context
> > fences. So only ctx0 fences can be created, which are retired only
> > with the ctx0 specific write_fence() callback. The newer
> > write_context_fence() callback is dedicated to retire context fences.
>
> All should be good then, thanks.
>
> --
> Best regards,
> Dmitry

Thank you all for the prompt reviews!

Best,
Yiwei

